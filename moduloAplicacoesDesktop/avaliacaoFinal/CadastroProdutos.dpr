program CadastroProdutos;

uses
  Vcl.Forms,
  Telaprincipal in 'Telaprincipal.pas' {frmTelaPrincipal},
  TelaCadastro in 'TelaCadastro.pas' {frmTelaCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTelaPrincipal, frmTelaPrincipal);
  Application.CreateForm(TfrmTelaCadastro, frmTelaCadastro);
  Application.Run;
end.
