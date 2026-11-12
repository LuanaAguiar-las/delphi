unit FrmPrincipal;

interface

uses
  FrmCategoria, FrmFormaPagamento, FrmOrcamento,
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  System.UITypes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmTelaPrincipal = class(TForm)
    // ---- Header ----
    pnlHeader: TPanel;
    lblTitulo: TLabel;
    lblSubtitulo: TLabel;

    // ---- Menu central ----
    pnlMenu: TPanel;
    btnCategorias: TButton;
    btnFormasPagamento: TButton;
    btnOrcamento: TButton;

    // ---- Rodap'#233 ----
    pnlFooter: TPanel;
    lblVersao: TLabel;

    procedure btnCategoriasClick(Sender: TObject);
    procedure btnFormasPagamentoClick(Sender: TObject);
    procedure btnOrcamentoClick(Sender: TObject);
  private
  public
  end;

var
  frmTelaPrincipal: TfrmTelaPrincipal;

implementation

{$R *.dfm}

procedure TfrmTelaPrincipal.btnCategoriasClick(Sender: TObject);
var
  Frm: TfrmCadCategoria;
begin
  Frm := TfrmCadCategoria.Create(Self);
  try
    Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

procedure TfrmTelaPrincipal.btnFormasPagamentoClick(Sender: TObject);
var
  Frm: TfrmCadFormaPagamento;
begin
  Frm := TfrmCadFormaPagamento.Create(Self);
  try
    Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

procedure TfrmTelaPrincipal.btnOrcamentoClick(Sender: TObject);
var
  Frm: TfrmCadOrcamento;
begin
  Frm := TfrmCadOrcamento.Create(Self);
  try
    Frm.ShowModal;
  finally
    Frm.Free;
  end;
end;

end.
