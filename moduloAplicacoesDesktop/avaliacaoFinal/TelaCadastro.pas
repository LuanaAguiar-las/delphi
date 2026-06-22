unit TelaCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Datasnap.DBClient;

type
  TfrmTelaCadastro = class(TForm)
    pnlProduto: TPanel;
    pnlBotoes: TPanel;
    lblNome: TLabel;
    lblQuantidade: TLabel;
    lblPreco: TLabel;
    edtNome: TEdit;
    edtQuantidade: TEdit;
    edtPreco: TEdit;
    btnSalvar: TButton;
    btnCancelar: TButton;
    procedure edtNomeExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtPrecoExit(Sender: TObject);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);

  private
    { Private declarations }
    function ValidaCampoVazio(pEdit: TEdit; const pMensagem: string): Boolean;
    function ValidaMaiorQueZero(pEdit: Tedit; const pMensagem: string): Boolean;

  public
    { Public declarations }
    class procedure Adicionar(pDataSet: TClientDataSet; pOwner: TComponent);
    class procedure Editar(pDataSet: TClientDataSet; pOwner: TComponent);
  end;

var
  frmTelaCadastro: TfrmTelaCadastro;

implementation

{$R *.dfm}

function TfrmTelaCadastro.ValidaCampoVazio(pEdit: TEdit; const pMensagem: string): Boolean;
begin
  if Screen.ActiveControl = btnCancelar then
  begin
    Result := True;
    Exit;
  end;

  if Trim(pEdit.Text) = '' then
  begin
    ShowMessage(pMensagem);
    Result := False;
  end
  else
  begin
    Result := True;
  end;
end;

function TfrmTelaCadastro.ValidaMaiorQueZero(pEdit: TEdit; const pMensagem: string): Boolean;
var vTexto: string;

begin
  Result := True;

  if Screen.ActiveControl = btnCancelar then
    Exit;

    vTexto := StringReplace(pEdit.Text, '.','', [rfReplaceAll]);

    if StrToFloat(vTexto) <=0 then
    begin
      ShowMessage(pMensagem);
      Result := False;
    end;

end;

class procedure TfrmTelaCadastro.Adicionar(pDataSet: TClientDataSet; pOwner: TComponent);
begin
  var lfrmTelaCadastro := TfrmTelaCadastro.Create(pOwner);

  try
    if lfrmTelaCadastro.ShowModal = mrOk then
    begin
      pDataSet.Append;
      pDataSet.FieldByName('Nome').AsString := lfrmTelaCadastro.edtNome.Text;
      pDataSet.FieldByName('Quantidade').AsInteger := StrToInt(lfrmTelaCadastro.edtQuantidade.Text);
      pDataSet.FieldByName('Preço').AsFloat := StrToFloat(lfrmTelaCadastro.edtPreco.Text);
      pDataSet.Post;
    end;
  finally
    lfrmTelaCadastro.Free;
  end;
end;

class procedure TfrmTelaCadastro.Editar(pDataSet: TClientDataSet; pOwner: TComponent);
begin
  var lfrmTelaCadastro := TfrmTelaCadastro.Create(pOwner);

  try
    lfrmTelaCadastro.edtNome.Text := pDataSet.FieldByName('Nome').AsString;
    lfrmTelaCadastro.edtQuantidade.Text := IntToStr(pDataSet.FieldByName('Quantidade').AsInteger);
    lfrmTelaCadastro.edtPreco.Text := FloatToStr(pDataSet.FieldByName('Preço').AsFloat);

    if lfrmTelaCadastro.ShowModal = mrOk then
    begin
      pDataSet.Edit;
      pDataSet.FieldByName('Nome').AsString := lfrmTelaCadastro.edtNome.Text;
      pDataSet.FieldByName('Quantidade').AsInteger := StrToInt(lfrmTelaCadastro.edtQuantidade.Text);
      pDataSet.FieldByName('Preço').AsFloat := StrToFloat(lfrmTelaCadastro.edtPreco.Text);
      pDataSet.Post;
    end;

  finally
    lfrmTelaCadastro.Free;
  end;
end;

procedure TfrmTelaCadastro.edtNomeExit(Sender: TObject);
  begin
    ValidaCampoVazio(edtNome, 'Preencha o nome do produto.');
  end;  

procedure TfrmTelaCadastro.edtPrecoExit(Sender: TObject);
var
  vValorFormatado: Double;
  vTexto: string;


begin
  if not ValidaCampoVazio(edtPreco, 'Preencha o nome do preço.') then
    Exit;

  if not ValidaMaiorQueZero(edtPreco, 'Informe um preço maior que zero') then
    Exit;

   try
     vValorFormatado := StrToFloat(edtPreco.Text);
     edtPreco.Text := FormatFloat('0.00', vValorFormatado);
   except
    on E: Exception do
    begin
      ShowMessage('Valor inválido');
    end;

   end;
end;

procedure TfrmTelaCadastro.edtPrecoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #8) or (Key = ',') then
  Exit;

  if not CharInSet(Key, ['0'..'9']) then
  Key := #0;
end;

procedure TfrmTelaCadastro.edtQuantidadeExit(Sender: TObject);
begin
  if ValidaCampoVazio(edtQuantidade, 'Preencha a quantidade.') then
    ValidaMaiorQueZero(edtQuantidade, 'Informe uma quantidade acima de zero');
end;

procedure TfrmTelaCadastro.edtQuantidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #8 then
  Exit;

  if not charInSet(Key, ['0'..'9']) then
  Key := #0;
end;

procedure TfrmTelaCadastro.btnSalvarClick(Sender: TObject);
begin
   if ValidaCampoVazio(edtNome, 'Preencha o nome do produto.') and
      ValidaCampoVazio(edtQuantidade, 'Preencha a quantidade.') and
      ValidaMaiorQueZero(edtQuantidade, 'Informe uma quantidade acima de zero') and
      ValidaCampoVazio(edtPreco, 'Preencha o preço.') and
      ValidaMaiorQueZero(edtPreco, 'Informe um preço maior que zero') then
   begin
     modalResult := mrOk;
   end;
end;

end.
