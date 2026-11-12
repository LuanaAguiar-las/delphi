program ControleFinanceiro;

uses
  Vcl.Forms,
  FrmPrincipal in 'source\view\FrmPrincipal.pas' {frmTelaPrincipal},
  uDataModule in 'source\DataModule\uDataModule.pas' {dtmDataBase: TDataModule},
  CategoriaModel in 'source\Model\CategoriaModel.pas',
  FormaPagamentoModel in 'source\Model\FormaPagamentoModel.pas',
  OrcamentoDespesaModel in 'source\Model\OrcamentoDespesaModel.pas',
  OrcamentoModel in 'source\Model\OrcamentoModel.pas',
  CategoriaService in 'source\Service\CategoriaService.pas',
  FormaPagamentoService in 'source\Service\FormaPagamentoService.pas',
  OrcamentoService in 'source\Service\OrcamentoService.pas',
  CotacaoService in 'source\Service\CotacaoService.pas',
  FrmCategoria in 'source\view\FrmCategoria.pas' {frmCadCategoria},
  FrmFormaPagamento in 'source\view\FrmFormaPagamento.pas' {frmCadFormaPagamento},
  FrmOrcamento in 'source\view\FrmOrcamento.pas' {frmCadOrcamento};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTelaPrincipal, frmTelaPrincipal);
  Application.CreateForm(TdtmDataBase, dtmDataBase);
  Application.Run;
end.
