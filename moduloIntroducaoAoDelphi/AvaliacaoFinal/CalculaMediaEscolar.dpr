program CalculaMediaEscolar;

uses
  Vcl.Forms,
  TelaPrincipal in 'TelaPrincipal.pas' {frmTelaPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTelaPrincipal, frmTelaPrincipal);
  Application.Run;
end.
