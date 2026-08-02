unit Servico.Autenticacao;

interface

uses
  Modelo.Conta, System.SysUtils;

type
  TAutenticaConta = class

  public
    class function ValidaSenha(const AConta: TConta; const ASenhaInformada: string; out AMensagemErro: string): Boolean;
  end;

implementation



{ TAutenticaConta }

class function TAutenticaConta.ValidaSenha(const AConta: TConta; const ASenhaInformada: string; out AMensagemErro: string): Boolean;
begin
  Result := False;
  AMensagemErro := '';

  if AConta = nil then
  begin
    AMensagemErro := 'Conta inválida ou não encontrada.';
    Exit;
  end;

  if Trim(ASenhaInformada) = '' then
  begin
    AMensagemErro := 'Prencha a senha.';
    Exit;
  end;

  if AConta.Senha <> ASenhaInformada then
  begin
    AMensagemErro := 'Senha incorreta';
    Exit;
  end;
  Result := True;

end;

end.
