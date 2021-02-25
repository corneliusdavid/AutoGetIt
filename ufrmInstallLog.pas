unit ufrmInstallLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, DosCommand;

type
  TfrmInstallLog = class(TForm)
    lbInstallLog: TListBox;
    DosCmdGetItInstall: TDosCommand;
    procedure DosCmdGetItInstallNewLine(ASender: TObject;
      const ANewLine: string; AOutputType: TOutputType);
    procedure DosCmdGetItInstallTerminated(Sender: TObject);
  private
    FFinished: Boolean;
  public
    procedure ClearLog;
    procedure InstallGetItPackage(const StartDir, GetItCmdArgs: string);
  end;

var
  frmInstallLog: TfrmInstallLog;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.Diagnostics;

{ TfrmInstallLog }

procedure TfrmInstallLog.ClearLog;
begin
  lbInstallLog.Items.Clear;
end;

procedure TfrmInstallLog.DosCmdGetItInstallNewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  lbInstallLog.Items.Add(ANewLine);
end;

procedure TfrmInstallLog.DosCmdGetItInstallTerminated(Sender: TObject);
begin
  FFinished := True;
end;

procedure TfrmInstallLog.InstallGetItPackage(const StartDir, GetItCmdArgs: string);
begin
  if not Visible then begin
    ClearLog;
    Show;
  end;

  DosCmdGetItInstall.CurrentDir := StartDir;
  DosCmdGetItInstall.CommandLine := TPath.Combine(StartDir, 'GetItCmd.exe ') + GetItCmdArgs;

  lbInstallLog.Items.Add(DosCmdGetItInstall.CommandLine);

  FFinished := False;
  Screen.Cursor := crHourGlass;
  try
    DosCmdGetItInstall.Execute;
    repeat
      Application.ProcessMessages;
    until FFinished;

    lbInstallLog.Items.Add('========================');
    lbInstallLog.ItemIndex := lbInstallLog.Items.Count - 1;
    lbInstallLog.Update;
  finally
    Screen.Cursor := crDefault;
  end;
end;

end.
