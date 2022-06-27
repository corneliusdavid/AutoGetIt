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
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TfrmAutoGetItMain, frmAutoGetItMain);
  Application.CreateForm(TfrmInstallLog, frmInstallLog);
  Application.Run;
end.
