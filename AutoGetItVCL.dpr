program AutoGetItVCL;

uses
  Vcl.Forms,
  ufrmAutoGetItMain in 'ufrmAutoGetItMain.pas' {frmAutoGetItMain},
  Vcl.Themes,
  Vcl.Styles,
  ufrmInstallLog in 'ufrmInstallLog.pas' {frmInstallLog};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Metropolis UI Green');
  Application.CreateForm(TfrmAutoGetItMain, frmAutoGetItMain);
  Application.CreateForm(TfrmInstallLog, frmInstallLog);
  Application.Run;
end.
