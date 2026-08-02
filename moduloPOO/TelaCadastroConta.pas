unit TelaCadastroConta;

interface

uses
  Modelo.conta,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Datasnap.DBClient;

type
  TfrmCadastroEdicaoConta = class(TForm)
    lblNome: TLabel;
    lblNumero: TLabel;
    lblSenha: TLabel;
    edtNome: TEdit;
    edtNumeroConta: TEdit;
    edtSenha: TEdit;
    bntGravar: TButton;
    btnFechar: TButton;
    procedure bntGravarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Novo(pOwner: TComponent; out AConta: TConta): Boolean;
    class function Editar(pOwner: TComponent; const AContaExistente: TConta): Boolean;
  end;

var
  frmCadastroEdicaoConta: TfrmCadastroEdicaoConta;

implementation

{$R *.dfm}

class function TfrmCadastroEdicaoConta.Novo(pOwner: TComponent; out AConta: TConta): Boolean;
var
  Form: TfrmCadastroEdicaoConta;
  lMensagemErro: string;

begin
  Result := False;
  AConta := nil;

  Form := TfrmCadastroEdicaoConta.Create(pOwner);
  try
    if Form.ShowModal = mrOk then
    begin
    AConta := TConta.Create(Form.edtNome.Text, Form.edtNumeroConta.Text, Form.edtSenha.Text);

    if not AConta.ValidaVazio(lMensagemErro) then
    begin
      ShowMessage(lMensagemErro);
      AConta.Free;
      AConta := nil;
      Exit;
    end;
    Result := True;
    end;
    finally
    Form.Free;
  end;

end;

procedure TfrmCadastroEdicaoConta.bntGravarClick(Sender: TObject);
var
  lContaTemp: TConta;
  lMensagemErro: string;
begin
  lContaTemp := TConta.Create(edtNome.Text, edtNumeroConta.Text, edtSenha.Text);

  try
    if not lContaTemp.ValidaVazio(lMensagemErro) then
    begin
      ShowMessage(lMensagemErro);
      Exit;
    end;
  finally
    lContaTemp.Free;
  end;
  Self.ModalResult := mrOk;
end;

procedure TfrmCadastroEdicaoConta.btnFecharClick(Sender: TObject);
begin
  Self.ModalResult := mrCancel;
end;


class function TfrmCadastroEdicaoConta.Editar(pOwner: TComponent; const AContaExistente: TConta): Boolean;
var
  Form: TfrmCadastroEdicaoConta;
  lMensagemErro: string;

begin
  Result := False;
  if AContaExistente = nil then
    Exit;

  Form := TfrmCadastroEdicaoConta.Create(pOwner);
  try
    Form.edtNome.Text := AContaExistente.Nome;
    Form.edtNumeroConta.Text := AContaExistente.NumeroConta;
    Form.edtSenha.Text := AContaExistente.Senha;

    if Form.ShowModal = mrOk then
    begin
      AContaExistente.Nome := Form.edtNome.Text;
      AContaExistente.NumeroConta := Form.edtNumeroConta.Text;
      AContaExistente.Senha := Form.edtSenha.Text;

      if not AcontaExistente.ValidaVazio(lMensagemErro) then
      begin
        ShowMessage(lMensagemErro);
        exit;
      end;
      Result := True;
    end;
  finally
    Form.Free;

  end;

end;


end.
