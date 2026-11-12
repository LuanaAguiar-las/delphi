unit FormaPagamentoModel;

interface

uses
System.SysUtils;

type
  TFormaPagamento = class
    private
      FId: integer;
      FNome: string;
      procedure SetNome(const Value: string);

    public
      constructor Create;
      property Id: integer read FId write FId;
      property Nome: string read FNome write SetNome;
  end;

implementation

{ TFormaPagamento }

constructor TFormaPagamento.Create;
begin
  inherited Create;
  FId := 0;
  FNome := string.Empty;
end;

procedure TFormaPagamento.SetNome(const Value: string);
begin
  if Trim(Value) = '' then
    raise Exception.Create('Infome o nome da forma de pagamento.');

  FNome := Trim(Value);
end;

end.
