unit Modelo.Conta;

interface

uses
  SysUtils;

type
  TConta = class

  private
    FNome: string;
    FNumeroConta: string;
    FSenha: string;
    FSaldo: currency;
  public
    property Nome: string read FNome write FNome;
    property NumeroConta: string read FNumeroConta write FNumeroConta;
    property Senha: string read FSenha write FSenha;
    property Saldo: currency read FSaldo;

    constructor Create; overload;
    constructor Create(const ANome, ANumeroConta: string); overload;
    constructor Create(const ANome, ANumeroConta, ASenha: string); overload;

    function ValidaVazio(out AMensagemErro: string): Boolean;
    function Sacar(const AValor: currency; out AMensagemErro: string): Boolean;
    procedure Depositar(const AValor: currency);

  end;

implementation

function TConta.ValidaVazio(out AMensagemErro: string): Boolean;
begin
  Result := false;

  if Trim(FNome) = '' then
  begin
    AMensagemErro := 'Informe o nome.';
    Exit;
  end;

  if Trim(FNumeroConta) = '' then
  begin
    AMensagemErro := 'Informe o número da conta';
    Exit;
  end;

  if Trim(FSenha) = '' then
  begin
    AMensagemErro := 'Informe a senha.';
    Exit;
  end;
  Result := true;

end;

constructor TConta.Create;
begin
  inherited Create;
  FNome := '';
  FNumeroConta := '';
  FSenha := '';
  FSaldo := 0;
end;

constructor TConta.Create(const ANome, ANumeroConta: string);
begin
  Create;
  FNome := ANome;
  FNumeroConta := ANumeroConta;
end;

constructor TConta.Create(const ANome, ANumeroConta, ASenha: string);
begin
  Create(ANome, ANumeroConta);
  FSenha := ASenha;
end;

procedure TConta.Depositar(const AValor: Currency);
begin
  if AValor <= 0 then
    raise Exception.Create('O valor do depósito deve ser maior que zero');
  FSaldo := FSaldo + AValor;
end;

function TConta.Sacar(const AValor: currency; out AMensagemErro: string): Boolean;
begin
  Result := False;

  if AValor <= 0 then
  begin
    AMensagemErro := 'O valor do saque deve ser maior que zero';
    Exit;
  end;

  if AValor > FSaldo then
  begin
    AMensagemErro := Format('Saldo insuficiente! O Saldo atual é %s', [FormatCurr('R$ #,##0.00', FSaldo)]);
    Exit;
  end;
  FSaldo := FSaldo - AValor;
  Result := True;

end;

end.
