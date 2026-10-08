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
    procedure DosCmdGetItInstallTerminateProcess(ASender: TObject; var ACanTerminate: Boolean);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    FAbort: Boolean;
    FFinished: Boolean;
    FSucceeded: Integer;
    FFailures: TStringList;
    FPartialShown: Boolean;
    FPromptAnswered: Boolean;
    procedure AddLog(const LogMsg: string);
    procedure ShowPartialLine(const Partial: string);
    procedure AnswerYesNoPrompt(const Prompt: string);
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
  Winapi.Windows, Winapi.TlHelp32, System.SysUtils, System.StrUtils, System.UITypes, System.IOUtils,
  System.Diagnostics, System.Generics.Collections, Vcl.Dialogs;

const
  // not declared in Winapi.Windows in every Delphi version; unlike PROCESS_QUERY_INFORMATION it is
  // granted for an elevated process to an unelevated caller
  PROCESS_QUERY_LIMITED_INFORMATION = $1000;

  END_STATUS_TEXT: array[TEndStatus] of string = (
    'stopped', 'finished', 'still running', 'not started', 'failed to run', 'timed out');

function ProcessCreationTime(const ProcessId: DWORD): UInt64;
var
  Creation, ExitTime, Kernel, User: TFileTime;
begin
  Result := 0;
  var Handle := OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, False, ProcessId);
  if Handle <> 0 then
    try
      if GetProcessTimes(Handle, Creation, ExitTime, Kernel, User) then
        Result := UInt64(Creation.dwHighDateTime) shl 32 or Creation.dwLowDateTime;
    finally
      CloseHandle(Handle);
    end;
end;

procedure TerminateProcessDescendants(const ProcessId: DWORD);
{ Terminates every process started by ProcessId (children, grandchildren, ...), deepest first, but
  not ProcessId itself, which TDosCommand.Stop terminates. GetItCmd can start other processes
  (installers, MSBuild) that would otherwise keep running after Cancel. A process counts as a child
  only if it was created after its claimed parent, because Windows reuses process ids. }
var
  Entry: TProcessEntry32;
begin
  var Parents := TDictionary<DWORD, DWORD>.Create;  // process id -> parent id
  var Ordered := TList<DWORD>.Create;
  var Queue := TQueue<DWORD>.Create;
  try
    var Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if Snapshot = INVALID_HANDLE_VALUE then
      Exit;
    try
      Entry.dwSize := SizeOf(Entry);
      if Process32First(Snapshot, Entry) then
        repeat
          Parents.AddOrSetValue(Entry.th32ProcessID, Entry.th32ParentProcessID);
        until not Process32Next(Snapshot, Entry);
    finally
      CloseHandle(Snapshot);
    end;

    // breadth-first from the root, so Ordered lists parents before their children
    Queue.Enqueue(ProcessId);
    while Queue.Count > 0 do begin
      var Parent := Queue.Dequeue;
      var ParentCreated := ProcessCreationTime(Parent);
      for var Pair in Parents do
        if (Pair.Value = Parent) and (Pair.Key <> Parent) and (Pair.Key <> ProcessId) and
           not Ordered.Contains(Pair.Key) and (ProcessCreationTime(Pair.Key) >= ParentCreated) then begin
          Ordered.Add(Pair.Key);
          Queue.Enqueue(Pair.Key);
        end;
    end;

    // deepest first, so no parent can start a replacement for a child just terminated
    for var i := Ordered.Count - 1 downto 0 do begin
      var Handle := OpenProcess(PROCESS_TERMINATE, False, Ordered[i]);
      if Handle <> 0 then
        try
          TerminateProcess(Handle, 1);
        finally
          CloseHandle(Handle);
        end;
    end;
  finally
    Queue.Free;
    Ordered.Free;
    Parents.Free;
  end;
end;

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

procedure TfrmInstallLog.ShowPartialLine(const Partial: string);
begin
  // TDosCommand reports the unfinished line so far (cumulatively) after each pipe read; showing it
  // makes a question that GetItCmd asks without a line break visible at all
  if FPartialShown then
    lbInstallLog.Items[lbInstallLog.Items.Count - 1] := Partial
  else begin
    AddLog(Partial);
    FPartialShown := True;
  end;
end;

procedure TfrmInstallLog.AnswerYesNoPrompt(const Prompt: string);
begin
  FPromptAnswered := True;
  var Answer := MessageDlg('GetItCmd is asking:' + sLineBreak + sLineBreak + Trim(Prompt) + sLineBreak + sLineBreak +
                           'Answer Yes?', mtConfirmation, [mbYes, mbNo], 0);
  DosCmdGetItInstall.SendLine(IfThen(Answer = mrYes, 'Y', 'N'), True);
end;

procedure TfrmInstallLog.btnCancelClick(Sender: TObject);
begin
  FAbort := True;
  // Stop raises OnTerminateProcess, which ends GetItCmd's own child processes first
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
  if AOutputType = otEntireLine then begin
    // the finished line replaces the partial one shown for it
    if FPartialShown then begin
      lbInstallLog.Items[lbInstallLog.Items.Count - 1] := ANewLine;
      FPartialShown := False;
    end else
      AddLog(ANewLine);
  end else begin
    ShowPartialLine(ANewLine);
    // GetItCmd 7.0 writes "Do you accept" with no line break and waits for an answer on standard
    // input; the " (Y/N) ? " part only appears after it has read one
    var Line := TrimRight(ANewLine);
    if (not FPromptAnswered) and (EndsText('(Y/N) ?', Line) or EndsText('Do you accept', Line)) then
      AnswerYesNoPrompt(ANewLine);
  end;
end;

procedure TfrmInstallLog.DosCmdGetItInstallTerminated(Sender: TObject);
begin
  FFinished := True;
end;

procedure TfrmInstallLog.DosCmdGetItInstallTerminateProcess(ASender: TObject; var ACanTerminate: Boolean);
begin
  // raised on Cancel and on the silence timeout, just before TDosCommand terminates GetItCmd.exe
  TerminateProcessDescendants(DosCmdGetItInstall.ProcessInformation.dwProcessId);
  ACanTerminate := True;
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
  FPartialShown := False;
  FPromptAnswered := False;
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
