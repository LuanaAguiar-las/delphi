unit OrcamentoDespesaModel;

interface

uses
System.SysUtils;

type
  TOrcamentoDespesa = class
    private
      FId: integer;
      FIdOrcamento: integer;
      FIdCategoria: integer;
      FIdFormaPagamento: integer;
      FCategoriaNome: string;
      FFormaPagamentoNome: string;
      FDescricao: string;
      FValor: Currency;
      FData: TDateTime;
      FPago: boolean;
      procedure SetDescricao(const Value: string);
      procedure SetValor(const Value: Currency);
    public
      constructor Create;
      property Id: integer read FId write FId;
      property IdOrcamento: integer read FIdOrcamento write FIdOrcamento;
      property IdCategoria: integer read FIdCategoria write FIdCategoria;
      property IdFormaPagamento: integer read FIdFormaPagamento write FIdFormaPagamento;
      property CategoriaNome: string read FCategoriaNome write FCategoriaNome;
      property FormaPagamentoNome: string read FFormaPagamentoNome write FFormaPagamentoNome;
      property Descricao: string read FDescricao write SetDescricao;
      property Valor: Currency read FValor write SetValor;
      property Data: TDateTime read FData write FData;
      property Pago: boolean read FPago write FPago;
  end;

implementation

{ TOrcamentoDespesa }

constructor TOrcamentoDespesa.Create;
begin
  inherited Create;
  FId := 0;
  FIdOrcamento := 0;
  FIdCategoria := 0;
  FIdFormaPagamento := 0;
  FValor := 0;
  FData := Date;
  FPago := False;
end;

procedure TOrcamentoDespesa.SetDescricao(const Value: string);
begin
  if Trim(Value) = '' then
    raise Exception.Create('Infome a descrição.');

  FDescricao := Trim(Value);
end;

procedure TOrcamentoDespesa.SetValor(const Value: Currency);
begin
  if Value <= 0 then
    raise Exception.Create('Informe um valor maior que zero.');

  FValor := Value;
end;

end.
