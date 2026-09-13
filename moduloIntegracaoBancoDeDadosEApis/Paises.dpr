program Paises;

uses
  Vcl.Forms,
  TelaPrincipal in 'view\TelaPrincipal.pas' {frmTelaPrincipal},
  Service.Api.Paises in 'service\Service.Api.Paises.pas',
  Model.Paises in 'model\Model.Paises.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTelaPrincipal, frmTelaPrincipal);
  Application.Run;
end.
