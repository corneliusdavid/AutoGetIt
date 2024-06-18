unit ufrmInstallLog;

interface

uses
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.ComCtrls, Vcl.StdCtrls, DosCommand,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmInstallLog = class(TForm)
    lbInstallLog: TListBox;
    DosCmdGetItInstall: TDosCommand;
    pnlLogBottom: TPanel;
    btnCancel: TBitBtn;
    lblCount: TLabel;
    pbInstalls: TProgressBar;
    btnClose: TBitBtn;
    procedure DosCmdGetItInstallNewLine(ASender: TObject;
      const ANewLine: string; AOutputType: TOutputType);
    procedure DosCmdGetItInstallTerminated(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FAbort: Boolean;
    FFinished: Boolean;
    procedure AddLog(const LogMsg: string);
  public
    procedure Initialize;
    procedure NotifyFinished;
    procedure ProcessGetItPackage(const StartDir, GetItCmdArgs: string;
                                  const Count, Total: Integer;
                                  var Aborted: Boolean);
  end;

var
  frmInstallLog: TfrmInstallLog;

implementation

{$R *.dfm}

uses
  System.SysUtils, System.IOUtils, System.Diagnostics;

{ TfrmInstallLog }

procedure TfrmInstallLog.AddLog(const LogMsg: string);
begin
  lbInstallLog.Items.Add(LogMsg);
  lbInstallLog.ItemIndex := lbInstallLog.Items.Count - 1;
  lbInstallLog.Update;
end;

procedure TfrmInstallLog.btnCancelClick(Sender: TObject);
begin
  FAbort := True;
  DosCmdGetItInstall.Stop;
end;

procedure TfrmInstallLog.btnCloseClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrmInstallLog.Initialize;
begin
  lbInstallLog.Items.Clear;
  btnCancel.BringToFront;
  Show;
end;

procedure TfrmInstallLog.DosCmdGetItInstallNewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  AddLog(ANewLine);
end;

procedure TfrmInstallLog.DosCmdGetItInstallTerminated(Sender: TObject);
begin
  FFinished := True;
end;

procedure TfrmInstallLog.ProcessGetItPackage(const StartDir, GetItCmdArgs: string;
                                             const Count, Total: Integer;
                                             var Aborted: Boolean);
begin
  lblCount.Caption := Format('%d of %d packages', [Count, Total]);
  lblCount.Update;

  pbInstalls.Max := Total;
  pbInstalls.Position := Count;
  pbInstalls.Update;

  DosCmdGetItInstall.CurrentDir := StartDir;

  // set up selected Delphi's environment paths--thanks GitHub user toxinon12345!
  DosCmdGetItInstall.CommandLine := 'rsvars.bat && GetItCmd.exe ' + GetItCmdArgs;

  AddLog('Command Line: ' + DosCmdGetItInstall.CommandLine);

  FAbort := False;
  FFinished := False;
  btnCancel.Enabled := True;
  Screen.Cursor := crHourGlass;
  try
    DosCmdGetItInstall.Execute;
    repeat
      Application.ProcessMessages;
    until FFinished or FAbort;

    AddLog('========================');
  finally
    Screen.Cursor := crDefault;
  end;

  Aborted := FAbort;
  if FAbort then
    AddLog('Aborted!');
end;

procedure TfrmInstallLog.NotifyFinished;
begin
  AddLog('Finished');
  btnClose.BringToFront;
end;

end.
