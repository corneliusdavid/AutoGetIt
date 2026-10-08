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
    FSucceeded: Integer;
    FFailures: TStringList;
    procedure AddLog(const LogMsg: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Initialize;
    procedure NotifyFinished(const Total: Integer);
    function ProcessGetItPackage(const GetItCmdExe, GetItCmdArgs, PackageName: string;
                                 const Count, Total: Integer;
                                 var Aborted: Boolean): Boolean;
  end;

var
  frmInstallLog: TfrmInstallLog;

implementation

{$R *.dfm}

uses
  System.SysUtils, System.IOUtils, System.Diagnostics;

const
  END_STATUS_TEXT: array[TEndStatus] of string = (
    'stopped', 'finished', 'still running', 'not started', 'failed to run', 'timed out');

{ TfrmInstallLog }

constructor TfrmInstallLog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFailures := TStringList.Create;
end;

destructor TfrmInstallLog.Destroy;
begin
  FFailures.Free;
  inherited Destroy;
end;

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
  FFailures.Clear;
  FSucceeded := 0;
  btnCancel.BringToFront;
  Show;
end;

procedure TfrmInstallLog.DosCmdGetItInstallNewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  if AOutputType = otEntireLine then
    AddLog(ANewLine);
end;

procedure TfrmInstallLog.DosCmdGetItInstallTerminated(Sender: TObject);
begin
  FFinished := True;
end;

function TfrmInstallLog.ProcessGetItPackage(const GetItCmdExe, GetItCmdArgs, PackageName: string;
                                            const Count, Total: Integer;
                                            var Aborted: Boolean): Boolean;
begin
  lblCount.Caption := Format('%d of %d packages', [Count, Total]);
  lblCount.Update;

  pbInstalls.Max := Total;
  pbInstalls.Position := Count;
  pbInstalls.Update;

  DosCmdGetItInstall.CurrentDir := ExtractFileDir(GetItCmdExe);

  // GetItCmd.exe by its full path, with no cmd.exe in between; the selected Delphi's environment
  // paths (rsvars.bat--thanks GitHub user toxinon12345!) are already set on this process
  DosCmdGetItInstall.CommandLine := '"' + GetItCmdExe + '" ' + GetItCmdArgs;

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

    // Cancel gets here before OnTerminated; wait for it so ExitCode and EndStatus are final
    while not FFinished and DosCmdGetItInstall.IsRunning do
      Application.ProcessMessages;
  finally
    Screen.Cursor := crDefault;
  end;

  // GetItCmd returns a non-zero exit code when it fails
  var Status := DosCmdGetItInstall.EndStatus;
  var Code := DosCmdGetItInstall.ExitCode;
  Result := (Status = esProcess) and (Code = 0);

  AddLog(Format('Result: %s, exit code %d', [END_STATUS_TEXT[Status], Code]));
  AddLog('========================');

  if Result then
    Inc(FSucceeded)
  else
    FFailures.Add(Format('%s: %s, exit code %d', [PackageName, END_STATUS_TEXT[Status], Code]));

  Aborted := FAbort;
  if FAbort then
    AddLog('Aborted!');
end;

procedure TfrmInstallLog.NotifyFinished(const Total: Integer);
begin
  AddLog(Format('Finished: %d of %d packages succeeded.', [FSucceeded, Total]));
  if FFailures.Count > 0 then begin
    AddLog('Did not succeed:');
    for var Failure in FFailures do
      AddLog('  ' + Failure);
  end;
  btnClose.BringToFront;
end;

end.
