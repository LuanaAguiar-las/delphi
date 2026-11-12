unit FrmOrcamento;

interface

uses
  CategoriaService, CategoriaModel,
  FormaPagamentoService, FormaPagamentoModel,
  OrcamentoService, OrcamentoModel, OrcamentoDespesaModel,
  CotacaoService,
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  System.Generics.Collections, System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Grids, Vcl.Mask;

type
  TfrmCadOrcamento = class(TForm)
    pnlOrcamento: TPanel;
    lblMesAno: TLabel;
    edtMesAno: TEdit;
    lblSalario: TLabel;
    edtSalario: TEdit;
    lblRendaExtra: TLabel;
    edtRendaExtra: TEdit;
    lblMeta: TLabel;
    edtMeta: TEdit;
    lblObservacao: TLabel;
    edtObservacao: TEdit;
    btnSalvar: TButton;
    btnCarregarOrcamento: TButton;
    btnNovoOrcamento: TButton;
    pnlTotais: TPanel;
    pnlCardRenda: TPanel;
    lblRendaTotalTit: TLabel;
    lblRendaTotalVal: TLabel;
    pnlCardDespesas: TPanel;
    lblTotalDespesasTit: TLabel;
    lblTotalDespesasVal: TLabel;
    pnlCardSaldo: TPanel;
    lblSaldoLivreTit: TLabel;
    lblSaldoLivreVal: TLabel;
    pnlDespesa: TPanel;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    lblValor: TLabel;
    edtValor: TEdit;
    lblCategoria: TLabel;
    cmbCategoria: TComboBox;
    lblFormaPagamento: TLabel;
    cmbFormaPagamento: TComboBox;
    chkPago: TCheckBox;
    btnAdicionarDespesa: TButton;
    btnRemoverDespesa: TButton;
    gridDespesas: TStringGrid;
    pnlCotacao: TPanel;
    btnCotacao: TButton;
    lblCotacao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtSalarioChange(Sender: TObject);
    procedure edtRendaExtraChange(Sender: TObject);
    procedure edtMetaChange(Sender: TObject);
    procedure edtSalarioExit(Sender: TObject);
    procedure edtRendaExtraExit(Sender: TObject);
    procedure edtMetaExit(Sender: TObject);
    procedure btnAdicionarDespesaClick(Sender: TObject);
    procedure btnRemoverDespesaClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnCarregarOrcamentoClick(Sender: TObject);
    procedure btnNovoOrcamentoClick(Sender: TObject);
    procedure btnCotacaoClick(Sender: TObject);
    procedure gridDespesasMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    FOrcamentoAtual: TOrcamento;
    FOrcamentoService: TOrcamentoService;
    FCategoriaService: TCategoriaService;
    FFormaPagamentoService: TFormaPagamentoService;
    FCotacaoService: TCotacaoService;
    procedure CarregarComboCategorias;
    procedure CarregarComboFormasPagamento;
    procedure AtualizarGridDespesas;
    procedure AtualizarTotais;
    procedure SincronizarMasterComTela;
    procedure FormatarCampoMoeda(Edit: TEdit);
    procedure LimparCamposDespesa;
    procedure PreencherTelaPorOrcamento(const AOrcamento: TOrcamento);
    function ObterIdCombo(Combo: TComboBox): Integer;
    procedure SelecionarItemComboPorId(Combo: TComboBox; IdDesejado: Integer);
    function ParsiarMoeda(const ATexto: string): Currency;
  public
  end;

var
  frmCadOrcamento: TfrmCadOrcamento;

implementation

{$R *.dfm}


function TfrmCadOrcamento.ParsiarMoeda(const ATexto: string): Currency;
var
  Texto: string;
  TemVirgula, TemPonto: Boolean;
begin
  Result := 0;

  Texto := Trim(ATexto);
  if Texto = '' then Exit;

  Texto := StringReplace(Texto, 'R$', '', [rfReplaceAll]);
  Texto := StringReplace(Texto, ' ',  '', [rfReplaceAll]);
  Texto := Trim(Texto);

  if Texto = '' then Exit;

  TemVirgula := Pos(',', Texto) > 0;
  TemPonto   := Pos('.', Texto) > 0;

  if TemVirgula and TemPonto then
  begin
    Texto := StringReplace(Texto, '.', '', [rfReplaceAll]);
    Texto := StringReplace(Texto, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);
  end
  else
  begin
    Texto := StringReplace(Texto, '.', FormatSettings.DecimalSeparator, [rfReplaceAll]);
    Texto := StringReplace(Texto, ',', FormatSettings.DecimalSeparator, [rfReplaceAll]);
  end;

  Result := StrToCurrDef(Texto, 0);
end;


procedure TfrmCadOrcamento.FormatarCampoMoeda(Edit: TEdit);
var
  Valor: Currency;
begin
  Valor := ParsiarMoeda(Edit.Text);
  if Valor > 0 then
    Edit.Text := FormatFloat('#,##0.00', Valor)
  else if Trim(Edit.Text) <> '' then
    Edit.Text := ''
end;


function TfrmCadOrcamento.ObterIdCombo(Combo: TComboBox): Integer;
begin
  Result := 0;
  if Combo.ItemIndex <> -1 then
    Result := Integer(NativeInt(Combo.Items.Objects[Combo.ItemIndex]));
end;

procedure TfrmCadOrcamento.SelecionarItemComboPorId(Combo: TComboBox; IdDesejado: Integer);
var
  I: Integer;
begin
  Combo.ItemIndex := -1;
  for I := 0 to Combo.Items.Count - 1 do
    if Integer(NativeInt(Combo.Items.Objects[I])) = IdDesejado then
    begin
      Combo.ItemIndex := I;
      Break;
    end;
end;


procedure TfrmCadOrcamento.FormCreate(Sender: TObject);
begin
  FOrcamentoService      := TOrcamentoService.Create;
  FCategoriaService      := TCategoriaService.Create;
  FFormaPagamentoService := TFormaPagamentoService.Create;
  FCotacaoService        := TCotacaoService.Create;
  FOrcamentoAtual        := TOrcamento.Create;


  gridDespesas.ColCount     := 6;
  gridDespesas.ColWidths[0] := 36;
  gridDespesas.ColWidths[1] := 210;
  gridDespesas.ColWidths[2] := 110;
  gridDespesas.ColWidths[3] := 175;
  gridDespesas.ColWidths[4] := 230;
  gridDespesas.ColWidths[5] := 60;

  CarregarComboCategorias;
  CarregarComboFormasPagamento;
  AtualizarGridDespesas;
  AtualizarTotais;
end;

procedure TfrmCadOrcamento.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FOrcamentoAtual);
  FreeAndNil(FOrcamentoService);
  FreeAndNil(FCategoriaService);
  FreeAndNil(FFormaPagamentoService);
  FreeAndNil(FCotacaoService);
end;

procedure TfrmCadOrcamento.FormShow(Sender: TObject);
begin
  edtMesAno.SetFocus;
end;


procedure TfrmCadOrcamento.gridDespesasMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Col, Row: Integer;
  Despesa: TOrcamentoDespesa;
begin
  if Button <> mbLeft then Exit;

  gridDespesas.MouseToCell(X, Y, Col, Row);

  if (Col = 5) and (Row >= 1) and (Row <= FOrcamentoAtual.Despesas.Count) then
  begin
    Despesa := FOrcamentoAtual.Despesas[Row - 1];
    Despesa.Pago := not Despesa.Pago;

    if Despesa.Pago then
      gridDespesas.Cells[5, Row] := '☑ Sim'
    else
      gridDespesas.Cells[5, Row] := '☐ Não';
  end;
end;

procedure TfrmCadOrcamento.SincronizarMasterComTela;
begin
  FOrcamentoAtual.SalarioLiquido   := ParsiarMoeda(edtSalario.Text);
  FOrcamentoAtual.RendaExtra       := ParsiarMoeda(edtRendaExtra.Text);
  FOrcamentoAtual.MetaInvestimento := ParsiarMoeda(edtMeta.Text);
  AtualizarTotais;
end;

procedure TfrmCadOrcamento.edtSalarioChange(Sender: TObject);
begin
  SincronizarMasterComTela;
end;

procedure TfrmCadOrcamento.edtRendaExtraChange(Sender: TObject);
begin
  SincronizarMasterComTela;
end;

procedure TfrmCadOrcamento.edtMetaChange(Sender: TObject);
begin
  SincronizarMasterComTela;
end;

procedure TfrmCadOrcamento.edtSalarioExit(Sender: TObject);
begin
  FormatarCampoMoeda(edtSalario);
end;

procedure TfrmCadOrcamento.edtRendaExtraExit(Sender: TObject);
begin
  FormatarCampoMoeda(edtRendaExtra);
end;

procedure TfrmCadOrcamento.edtMetaExit(Sender: TObject);
begin
  FormatarCampoMoeda(edtMeta);
end;

procedure TfrmCadOrcamento.CarregarComboCategorias;
var
  Lista: TObjectList<TCategoria>;
  Cat: TCategoria;
begin
  cmbCategoria.Items.Clear;
  Lista := FCategoriaService.ListarTodas;
  try
    for Cat in Lista do
      cmbCategoria.Items.AddObject(Cat.Nome, TObject(NativeInt(Cat.Id)));
  finally
    Lista.Free;
  end;
end;

procedure TfrmCadOrcamento.CarregarComboFormasPagamento;
var
  Lista: TObjectList<TFormaPagamento>;
  FP: TFormaPagamento;
begin
  cmbFormaPagamento.Items.Clear;
  Lista := FFormaPagamentoService.ListarTodas;
  try
    for FP in Lista do
      cmbFormaPagamento.Items.AddObject(FP.Nome, TObject(NativeInt(FP.Id)));
  finally
    Lista.Free;
  end;
end;


procedure TfrmCadOrcamento.AtualizarGridDespesas;
var
  D: TOrcamentoDespesa;
  Linha: Integer;
begin
  gridDespesas.ColCount := 6;
  gridDespesas.Cells[0, 0] := '#';
  gridDespesas.Cells[1, 0] := 'Descrição';
  gridDespesas.Cells[2, 0] := 'Valor';
  gridDespesas.Cells[3, 0] := 'Categoria';
  gridDespesas.Cells[4, 0] := 'Forma Pagto';
  gridDespesas.Cells[5, 0] := 'Pago';

  if FOrcamentoAtual.Despesas.Count = 0 then
  begin
    gridDespesas.RowCount := 2;
    gridDespesas.Cells[0, 1] := '';
    gridDespesas.Cells[1, 1] := 'Nenhuma despesa adicionada';
    gridDespesas.Cells[2, 1] := '';
    gridDespesas.Cells[3, 1] := '';
    gridDespesas.Cells[4, 1] := '';
    gridDespesas.Cells[5, 1] := '';
    Exit;
  end;

  gridDespesas.RowCount := FOrcamentoAtual.Despesas.Count + 1;
  Linha := 1;
  for D in FOrcamentoAtual.Despesas do
  begin
    gridDespesas.Cells[0, Linha] := IntToStr(Linha);
    gridDespesas.Cells[1, Linha] := D.Descricao;
    gridDespesas.Cells[2, Linha] := FormatFloat('R$ ###,##0.00', D.Valor);
    gridDespesas.Cells[3, Linha] := D.CategoriaNome;
    gridDespesas.Cells[4, Linha] := D.FormaPagamentoNome;
    if D.Pago then
      gridDespesas.Cells[5, Linha] := '☑ Sim'
    else
      gridDespesas.Cells[5, Linha] := '☐ Não';
    Inc(Linha);
  end;
end;


procedure TfrmCadOrcamento.AtualizarTotais;
begin
  lblRendaTotalVal.Caption    := FormatFloat('R$ ###,##0.00', FOrcamentoAtual.RendaTotal);
  lblTotalDespesasVal.Caption := FormatFloat('R$ ###,##0.00', FOrcamentoAtual.TotalDespesas);

  if FOrcamentoAtual.SaldoLivre >= 0 then
    lblSaldoLivreVal.Font.Color := clGreen
  else
    lblSaldoLivreVal.Font.Color := clRed;

  lblSaldoLivreVal.Caption := FormatFloat('R$ ###,##0.00', FOrcamentoAtual.SaldoLivre);
end;


procedure TfrmCadOrcamento.LimparCamposDespesa;
begin
  edtDescricao.Clear;
  edtValor.Clear;
  cmbCategoria.ItemIndex      := -1;
  cmbFormaPagamento.ItemIndex := -1;
  chkPago.Checked := False;
  edtDescricao.SetFocus;
end;

procedure TfrmCadOrcamento.PreencherTelaPorOrcamento(const AOrcamento: TOrcamento);
begin
  // Desativa OnChange para evitar disparos de SincronizarMasterComTela durante o preenchimento
  edtSalario.OnChange    := nil;
  edtRendaExtra.OnChange := nil;
  edtMeta.OnChange       := nil;
  try
    edtMesAno.Text     := AOrcamento.MesAno;
    edtSalario.Text    := FormatFloat('###,##0.00', AOrcamento.SalarioLiquido);
    edtRendaExtra.Text := FormatFloat('###,##0.00', AOrcamento.RendaExtra);
    edtMeta.Text       := FormatFloat('###,##0.00', AOrcamento.MetaInvestimento);
    edtObservacao.Text := AOrcamento.Observacao;
  finally
    edtSalario.OnChange    := edtSalarioChange;
    edtRendaExtra.OnChange := edtRendaExtraChange;
    edtMeta.OnChange       := edtMetaChange;
  end;
end;


procedure TfrmCadOrcamento.btnAdicionarDespesaClick(Sender: TObject);
var
  Despesa: TOrcamentoDespesa;
  IdCat, IdFP: Integer;
begin
  if Trim(edtDescricao.Text) = '' then
  begin
    ShowMessage('Informe a descrição da despesa.');
    edtDescricao.SetFocus;
    Exit;
  end;

  if ParsiarMoeda(edtValor.Text) <= 0 then
  begin
    ShowMessage('Informe um valor maior que zero.');
    edtValor.SetFocus;
    Exit;
  end;

  IdCat := ObterIdCombo(cmbCategoria);
  if IdCat = 0 then
  begin
    ShowMessage('Selecione uma categoria.');
    cmbCategoria.SetFocus;
    Exit;
  end;

  IdFP := ObterIdCombo(cmbFormaPagamento);
  if IdFP = 0 then
  begin
    ShowMessage('Selecione uma forma de pagamento.');
    cmbFormaPagamento.SetFocus;
    Exit;
  end;

  Despesa := TOrcamentoDespesa.Create;
  try
    Despesa.Descricao          := Trim(edtDescricao.Text);
    Despesa.Valor              := ParsiarMoeda(edtValor.Text);
    Despesa.IdCategoria        := IdCat;
    Despesa.CategoriaNome      := cmbCategoria.Text;
    Despesa.IdFormaPagamento   := IdFP;
    Despesa.FormaPagamentoNome := cmbFormaPagamento.Text;
    Despesa.Pago               := chkPago.Checked;
    FOrcamentoAtual.Despesas.Add(Despesa);
  except
    Despesa.Free;
    raise;
  end;

  LimparCamposDespesa;
  AtualizarGridDespesas;
  AtualizarTotais;
end;

procedure TfrmCadOrcamento.btnRemoverDespesaClick(Sender: TObject);
var
  Linha: Integer;
begin
  Linha := gridDespesas.Row;

  if (Linha < 1) or (Linha > FOrcamentoAtual.Despesas.Count) then
  begin
    ShowMessage('Selecione uma despesa na lista para remover.');
    Exit;
  end;

  if Application.MessageBox('Remover a despesa selecionada da lista?',
    'Confirmação', MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;

  FOrcamentoAtual.Despesas.Delete(Linha - 1);
  AtualizarGridDespesas;
  AtualizarTotais;
end;


procedure TfrmCadOrcamento.btnSalvarClick(Sender: TObject);
begin
  try
    FOrcamentoAtual.MesAno           := Trim(edtMesAno.Text);
    FOrcamentoAtual.SalarioLiquido   := ParsiarMoeda(edtSalario.Text);
    FOrcamentoAtual.RendaExtra       := ParsiarMoeda(edtRendaExtra.Text);
    FOrcamentoAtual.MetaInvestimento := ParsiarMoeda(edtMeta.Text);
    FOrcamentoAtual.Observacao       := Trim(edtObservacao.Text);

    if Trim(FOrcamentoAtual.MesAno) = '' then
    begin
      ShowMessage('Informe o mês/ano de referência (ex: 11/2026).');
      edtMesAno.SetFocus;
      Exit;
    end;

    if FOrcamentoAtual.SalarioLiquido <= 0 then
    begin
      ShowMessage('Informe o salário líquido.');
      edtSalario.SetFocus;
      Exit;
    end;

    if FOrcamentoService.Salvar(FOrcamentoAtual) then
    begin
      ShowMessage('Orçamento salvo com sucesso!');
      AtualizarTotais;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar: ' + E.Message);
  end;
end;

procedure TfrmCadOrcamento.btnCarregarOrcamentoClick(Sender: TObject);
var
  MesAno: string;
  Lista: TObjectList<TOrcamento>;
  Orc: TOrcamento;
  Encontrado: TOrcamento;
begin
  MesAno := Trim(edtMesAno.Text);
  if MesAno = '' then
  begin
    ShowMessage('Informe o mês/ano para carregar (ex: 11/2026).');
    edtMesAno.SetFocus;
    Exit;
  end;

  Encontrado := nil;
  Lista := FOrcamentoService.ListarTodos;
  try
    for Orc in Lista do
      if Trim(Orc.MesAno) = Trim(MesAno) then
      begin
        Encontrado := Orc;
        Break;
      end;

    if not Assigned(Encontrado) then
    begin
      ShowMessage('Nenhum orçamento encontrado para "' + MesAno + '".');
      Exit;
    end;

    Lista.Extract(Encontrado);
    FreeAndNil(FOrcamentoAtual);
    FOrcamentoAtual := Encontrado;
  finally
    Lista.Free;
  end;

  PreencherTelaPorOrcamento(FOrcamentoAtual);
  AtualizarGridDespesas;
  AtualizarTotais;
end;

procedure TfrmCadOrcamento.btnNovoOrcamentoClick(Sender: TObject);
begin
  if Application.MessageBox(
    'Deseja iniciar um novo orçamento? As alterações não salvas serão perdidas.',
    'Confirmação', MB_YESNO + MB_ICONQUESTION) <> IDYES then Exit;

  FreeAndNil(FOrcamentoAtual);
  FOrcamentoAtual := TOrcamento.Create;
  // Garante que Id=0 (novo) e lista de despesas limpa (já garantido pelo Create)

  // Desativa OnChange para não disparar SincronizarMasterComTela com campos vazios
  edtSalario.OnChange    := nil;
  edtRendaExtra.OnChange := nil;
  edtMeta.OnChange       := nil;
  try
    edtMesAno.Clear;
    edtSalario.Clear;
    edtRendaExtra.Clear;
    edtMeta.Clear;
    edtObservacao.Clear;
  finally
    edtSalario.OnChange    := edtSalarioChange;
    edtRendaExtra.OnChange := edtRendaExtraChange;
    edtMeta.OnChange       := edtMetaChange;
  end;

  // Zera labels de totais
  lblRendaTotalVal.Caption    := FormatFloat('R$ ###,##0.00', 0);
  lblTotalDespesasVal.Caption := FormatFloat('R$ ###,##0.00', 0);
  lblSaldoLivreVal.Caption    := FormatFloat('R$ ###,##0.00', 0);
  lblSaldoLivreVal.Font.Color := clGreen;

  LimparCamposDespesa;
  AtualizarGridDespesas;
  AtualizarTotais;
  edtMesAno.SetFocus;
end;


procedure TfrmCadOrcamento.btnCotacaoClick(Sender: TObject);
var
  CotUSD, CotEUR: TCotacao;
begin
  lblCotacao.Caption := 'Consultando...';
  Application.ProcessMessages;
  try
    CotUSD := FCotacaoService.ObterCotacao('USD-BRL');
    CotEUR := FCotacaoService.ObterCotacao('EUR-BRL');

    lblCotacao.Caption :=
      'Dólar (USD): R$ ' + FormatFloat('###,##0.0000', CotUSD.Bid) +
      '  (' + CotUSD.PctChange + '%)    ' +
      'Euro  (EUR): R$ ' + FormatFloat('###,##0.0000', CotEUR.Bid) +
      '  (' + CotEUR.PctChange + '%)';
  except
    on E: Exception do
    begin
      lblCotacao.Caption := 'Erro ao consultar cotação.';
      ShowMessage('Não foi possível obter a cotação:' + sLineBreak + E.Message);
    end;
  end;
end;

end.
