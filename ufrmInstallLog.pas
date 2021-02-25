unit ufrmInstallLog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, DosCommand,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmInstallLog = class(TForm)
    lbInstallLog: TListBox;
    DosCmdGetItInstall: TDosCommand;
    pnlLogBottom: TPanel;
    btnCancel: TBitBtn;
    lblCount: TLabel;
    pbInstalls: TProgressBar;
    procedure DosCmdGetItInstallNewLine(ASender: TObject;
      const ANewLine: string; AOutputType: TOutputType);
    procedure DosCmdGetItInstallTerminated(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FAbort: Boolean;
    FFinished: Boolean;
  public
    procedure ClearLog;
    procedure InstallGetItPackage(const StartDir, GetItCmdArgs: string;
                                  const Count, Total: Integer;
                                  var Aborted: Boolean);
  end;

var
  frmInstallLog: TfrmInstallLog;

implementation

{$R *.dfm}

uses
  System.IOUtils, System.Diagnostics;

{ TfrmInstallLog }

procedure TfrmInstallLog.btnCancelClick(Sender: TObject);
begin
  FAbort := True;
  DosCmdGetItInstall.Stop;
end;

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

procedure TfrmInstallLog.InstallGetItPackage(const StartDir, GetItCmdArgs: string;
                                             const Count, Total: Integer;
                                             var Aborted: Boolean);
begin
  if not Visible then begin
    ClearLog;
    Show;
  end;

  lblCount.Caption := Format('%d of %d packages', [Count, Total]);
  lblCount.Update;

  pbInstalls.Max := Total;
  pbInstalls.Position := Count;
  pbInstalls.Update;

  DosCmdGetItInstall.CurrentDir := StartDir;
  DosCmdGetItInstall.CommandLine := TPath.Combine(StartDir, 'GetItCmd.exe ') + GetItCmdArgs;

  lbInstallLog.Items.Add(DosCmdGetItInstall.CommandLine);

  FAbort := False;
  FFinished := False;
  btnCancel.Enabled := True;
  Screen.Cursor := crHourGlass;
  try
    DosCmdGetItInstall.Execute;
    repeat
      Application.ProcessMessages;
    until FFinished or FAbort;

    lbInstallLog.Items.Add('========================');
    lbInstallLog.ItemIndex := lbInstallLog.Items.Count - 1;
    lbInstallLog.Update;
  finally
    Screen.Cursor := crDefault;
  end;

  Aborted := FAbort;
  if FAbort then
    lbInstallLog.Items.Add('Aborted!');
end;

end.
