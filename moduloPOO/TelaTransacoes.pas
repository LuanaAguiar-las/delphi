unit TelaTransacoes;

interface

uses
  Modelo.Conta,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmTransacoes = class(TForm)
    grpCadastroConta: TGroupBox;
    edtClienteCadastrado: TEdit;
    edtNumeroContaCadastrada: TEdit;
    grpTransacoes: TGroupBox;
    memoInfoConta: TMemo;
    btnSaldo: TButton;
    btnDepositar: TButton;
    btnSacar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnSaldoClick(Sender: TObject);
    procedure btnDepositarClick(Sender: TObject);
    procedure btnSacarClick(Sender: TObject);
  private
    { Private declarations }
    FContaLogada: TConta;
    procedure AtualizarDadosCadastraisConta;
    procedure RegistraExtrato(const ATexto: string);
  public
    { Public declarations }
    class procedure ExibirTela(pOwner: TComponent; pConta: TConta);
  end;

var
  frmTransacoes: TfrmTransacoes;

implementation

{$R *.dfm}

{ TfrmTransacoes }

procedure TfrmTransacoes.AtualizarDadosCadastraisConta;
begin
  if FContaLogada <> nil then
  begin
    edtClienteCadastrado.Text := FContaLogada.Nome;
    edtNumeroContaCadastrada.Text := FContaLogada.NumeroConta;
  end;
end;

procedure TfrmTransacoes.btnDepositarClick(Sender: TObject);
var
  lEntradaTexto: string;
  lValorDeposito: Currency;
begin
  if FContaLogada = nil then
  Exit;

  if InputQuery('Depósito','Informe o valor do depósito: ', lEntradaTexto) then
  begin
    lValorDeposito := StrToCurrDef(Trim(lEntradaTexto), 0);

    try
      FContaLogada.Depositar(lValorDeposito);

      ShowMessage(Format('Depósito de %s realizado com sucesso! ', [FormatCurr('R$ #,##0.00', lValorDeposito)]));

      RegistraExtrato('Depósito realizado!!!');
      RegistraExtrato(Format('Valor depositado: %s', [FormatCurr('R$ #,##0.00', lValorDeposito)]));
      RegistraExtrato(Format('O saldo atualizado é: %s', [FormatCurr('R$ #,##0.00', FContaLogada.Saldo)]));
      RegistraExtrato('*******************************************');

    Except
      on E: Exception do
      begin
        ShowMessage('Atenção!: '+ E.Message);
      end;

    end;
  end;

end;

procedure TfrmTransacoes.btnSacarClick(Sender: TObject);
var
  lEntradaTexto: string;
  lValorSaque: Currency;
  lMensagemErro: string;

begin
  if FcontaLogada = nil then
  Exit;

  if InputQuery('Saque', 'Informe o valor do saque', lEntradaTexto) then
  begin
    lValorSaque := StrToCurrDef(Trim(lEntradaTexto), 0);

    if FContaLogada.Sacar(lValorSaque, lMensagemErro) then
    begin
      ShowMessage(Format('O saque foi de %s ', [FormatCurr('R$ #,##0.00', lValorSaque)]));

      RegistraExtrato('Saque realizado!!!');
      RegistraExtrato(Format('O saldo atualizado é: %s', [FormatCurr('R$ #,##0.00', FContaLogada.Saldo)]));
      RegistraExtrato('*******************************************');
    end
    else
    begin
      ShowMessage('Operação não permitida: ' + lMensagemErro);
    end;

  end;

end;

procedure TfrmTransacoes.btnSaldoClick(Sender: TObject);
var lTextoSaldo: string;
begin
  if FContaLogada =  nil then
  Exit;

  lTextoSaldo := Formatcurr('R$ #,##0.00', FContaLogada.Saldo);

  RegistraExtrato('Consulta de saldo: ');
  RegistraExtrato(Format('O saldo atual é: %s', [lTextoSaldo]));
  RegistraExtrato('*******************************************');
end;

class procedure TfrmTransacoes.ExibirTela(pOwner: TComponent; pConta: TConta);
var Form: TfrmTransacoes;
begin
   if pConta = nil then
   begin
     ShowMessage('Nenhuma conta selecionada');
     Exit;
   end;

   Form := TfrmTransacoes.Create(pOwner);
   try
     Form.FContaLogada := pConta;
     form.ShowModal;
   finally
    Form.Free;
   end;
end;

procedure TfrmTransacoes.FormShow(Sender: TObject);
begin
  AtualizarDadosCadastraisConta;

  memoInfoConta.Clear;
  RegistraExtrato('*** Extrato bancário ***');
  RegistraExtrato('');
end;

procedure TfrmTransacoes.RegistraExtrato(const ATexto: string);
begin
  memoInfoConta.Lines.Add(ATexto);
end;

end.
