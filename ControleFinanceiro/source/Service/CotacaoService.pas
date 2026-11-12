unit CotacaoService;

interface

uses
  System.SysUtils, System.Net.HttpClient, System.JSON;

type
  TCotacao = record
    Codigo: string;
    Nome: string;
    Bid: Currency;
    Ask: Currency;
    PctChange: string;
    VarBid: string;
    DateTime: string;
  end;

  TCotacaoService = class
  private
    FHttpClient: THTTPClient;
    function ExtrairCampoStr(const AObj: TJSONObject; const ACampo: string): string;
    function ExtrairCampoCurrency(const AObj: TJSONObject; const ACampo: string): Currency;
  public
    constructor Create;
    destructor Destroy; override;

    function ObterCotacao(const APar: string): TCotacao;
  end;

implementation

{ TCotacaoService }

constructor TCotacaoService.Create;
begin
  inherited Create;
  FHttpClient := THTTPClient.Create;
  FHttpClient.ResponseTimeout := 10000;
  FHttpClient.ConnectionTimeout := 10000;
end;

destructor TCotacaoService.Destroy;
begin
  FHttpClient.Free;
  inherited Destroy;
end;

function TCotacaoService.ExtrairCampoStr(const AObj: TJSONObject; const ACampo: string): string;
var
  Val: TJSONValue;
begin
  Result := '';
  Val := AObj.GetValue(ACampo);
  if Assigned(Val) then
    Result := Val.Value;
end;

function TCotacaoService.ExtrairCampoCurrency(const AObj: TJSONObject; const ACampo: string): Currency;
var
  Str: string;
begin
  Result := 0;
  Str := ExtrairCampoStr(AObj, ACampo);
  if Str <> '' then
    Result := StrToCurrDef(StringReplace(Str, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]), 0);
end;

function TCotacaoService.ObterCotacao(const APar: string): TCotacao;
const
  BASE_URL = 'https://economia.awesomeapi.com.br/last/%s';
var
  URL: string;
  Response: IHTTPResponse;
  Root: TJSONObject;
  ChaveRaiz: string;
  DadosPar: TJSONObject;
begin
  Result := Default(TCotacao);

  URL := Format(BASE_URL, [APar]);

  Response := FHttpClient.Get(URL);

  if Response.StatusCode <> 200 then
    raise Exception.CreateFmt(
      'Falha ao consultar cotação. HTTP %d: %s',
      [Response.StatusCode, Response.StatusText]
    );

  Root := TJSONObject.ParseJSONValue(Response.ContentAsString(TEncoding.UTF8)) as TJSONObject;
  if not Assigned(Root) then
    raise Exception.Create('Resposta inválida da API de cotação.');

  try

    ChaveRaiz := StringReplace(APar, '-', '', [rfReplaceAll]);
    DadosPar := Root.GetValue(ChaveRaiz) as TJSONObject;

    if not Assigned(DadosPar) then
      raise Exception.CreateFmt(
        'Par "%s" não encontrado na resposta da API.',
        [APar]
      );

    Result.Codigo    := ExtrairCampoStr(DadosPar, 'code');
    Result.Nome      := ExtrairCampoStr(DadosPar, 'name');
    Result.Bid       := ExtrairCampoCurrency(DadosPar, 'bid');
    Result.Ask       := ExtrairCampoCurrency(DadosPar, 'ask');
    Result.PctChange := ExtrairCampoStr(DadosPar, 'pctChange');
    Result.VarBid    := ExtrairCampoStr(DadosPar, 'varBid');
    Result.DateTime  := ExtrairCampoStr(DadosPar, 'create_date');
  finally
    Root.Free;
  end;
end;

end.
