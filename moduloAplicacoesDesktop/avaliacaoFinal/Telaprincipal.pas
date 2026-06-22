unit Telaprincipal;

interface

uses
  TelaCadastro,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmTelaPrincipal = class(TForm)
    pnlMenu: TPanel;
    pnlProdutos: TPanel;
    btnNovo: TButton;
    btnEditar: TButton;
    btnRemover: TButton;
    cdsProdutos: TClientDataSet;
    dtsProdutos: TDataSource;
    grdProdutos: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure dtsProdutosDataChange(Sender: TObject; Field: TField);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmTelaPrincipal: TfrmTelaPrincipal;

implementation

{$R *.dfm}

procedure TfrmTelaPrincipal.btnEditarClick(Sender: TObject);
begin
  TfrmTelaCadastro.Editar(cdsProdutos, Self);
end;

procedure TfrmTelaPrincipal.btnNovoClick(Sender: TObject);
begin
  TfrmTelaCadastro.Adicionar(cdsProdutos, Self);
end;

procedure TfrmTelaPrincipal.btnRemoverClick(Sender: TObject);
begin
  if not cdsProdutos.IsEmpty then
  cdsProdutos.Delete;
end;

procedure TfrmTelaPrincipal.FormCreate(Sender: TObject);
begin
  cdsProdutos.FieldDefs.Add('Nome', ftString, 60);
  cdsProdutos.FieldDefs.Add('Quantidade', ftInteger, 0);
  cdsProdutos.FieldDefs.Add('Preço', ftFloat, 0);
  cdsProdutos.CreateDataSet;
end;

procedure TfrmTelaPrincipal.dtsProdutosDataChange(Sender: TObject; Field: TField);
begin
  btnEditar.Enabled := not cdsProdutos.IsEmpty;
  btnRemover.Enabled := not cdsProdutos.IsEmpty;
end;

end.
