program AutoGetItVCL;

uses
  Vcl.Forms,
  ufrmAutoGetItMain in 'ufrmAutoGetItMain.pas' {frmAutoGetItMain},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Metropolis UI Green');
  Application.CreateForm(TfrmAutoGetItMain, frmAutoGetItMain);
  Application.Run;
end.
