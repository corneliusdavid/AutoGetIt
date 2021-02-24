unit ufrmAutoGetItMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  DosCommand, Vcl.CheckLst, Vcl.ComCtrls;

type
  TfrmAutoGetItMain = class(TForm)
    pnlTop: TPanel;
    btnRefresh: TBitBtn;
    aclAutoGetit: TActionList;
    actRefresh: TAction;
    cmbRADVersions: TComboBox;
    Label1: TLabel;
    DosCommand: TDosCommand;
    lbPackages: TCheckListBox;
    actInstallChecked: TAction;
    rgrpSortBy: TRadioGroup;
    chkInstalledOnly: TCheckBox;
    edtNameFilter: TLabeledEdit;
    StatusBar: TStatusBar;
    procedure actRefreshExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
    procedure DosCommandTerminated(Sender: TObject);
    procedure actInstallCheckedExecute(Sender: TObject);
  private
    const
      BDS_USER_ROOT = '\Software\Embarcadero\BDS\';
    var
      FPastFirstItem: Boolean;
      FFinished: Boolean;
    procedure SetDownloadTime(const Value: Integer);
    procedure SetPackageCount(const Value: Integer);
    procedure LoadRADVersionsCombo;
    procedure CleanPackageList;
    function BDSRootPath(const BDSVersion: string): string;
    function SelectedBDSVersion: string;
    property PackageCount: Integer write SetPackageCount;
    property DownloadTime: Integer write SetDownloadTime;
  end;

var
  frmAutoGetItMain: TfrmAutoGetItMain;


implementation

{$R *.dfm}

uses
  System.Diagnostics, System.Win.Registry, System.StrUtils;

procedure TfrmAutoGetItMain.FormCreate(Sender: TObject);
begin
  LoadRADVersionsCombo;
  lbPackages.Items.Clear;
end;

procedure TfrmAutoGetItMain.actInstallCheckedExecute(Sender: TObject);
begin
{
var
  space: Integer;
  name, vr, desc: string;
begin
  space := Pos(' ', GetItLine);
  name := LeftStr(GetItLine, space - 1);

  vr := Trim(MidStr(GetItLine, space, Length(GetItLine)));
  space := Pos(' ', vr);
  desc := Trim(MidStr(vr, space + 1, Length(vr)));
  vr := Trim(LeftStr(vr, space));
}
end;

procedure TfrmAutoGetItMain.actRefreshExecute(Sender: TObject);
var
  SortField: string;
begin
  lbPackages.Items.Clear;
  FPastFirstItem := False;
  FFinished := False;

  case rgrpSortBy.ItemIndex of
    0: SortField := 'name';
    1: SortField := 'vendor';
    2: SortField := 'date';
  end;

  DosCommand.CurrentDir := 'C:\Program Files (x86)\Embarcadero\Studio\21.0\bin'; // BDSRootPath(SelectedBDSVersion);
  DosCommand.CommandLine := Format('GetItCmd.exe -l=%s --sort=% --filter=%s',
                    [edtNameFilter.Text, SortField, IfThen(chkInstalledOnly.Checked, 'installed', 'all')]);

  Screen.Cursor := crHourGlass;
  try
    var CmdTime: TStopWatch;
    CmdTime.Start;

    DosCommand.Execute;
    repeat
      Application.ProcessMessages;
    until FFinished;
    CleanPackageList;

    cmdTime.Stop;
    DownloadTime := cmdTime.Elapsed.Seconds;
    PackageCount := lbPackages.Items.Count;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TfrmAutoGetItMain.BDSRootPath(const BDSVersion: string): string;
begin
  var reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;

    if reg.OpenKey(BDS_USER_ROOT + BDSVersion, False) then
      Result := reg.ReadString('RootDir');
  finally
    reg.Free;
  end;
end;

procedure TfrmAutoGetItMain.CleanPackageList;
{ not sure if there's a bug in DosCommand or what but the list of packages
  often contains cut-off entries that are then completed on the next line,
  so this routine goes through and deletes those partial entries }
var
  LastPackage: string;
begin
  LastPackage := EmptyStr;
  for var i := lbPackages.Count - 1 downto 1 do begin
    LastPackage := lbPackages.Items[i-1];

    if (LastPackage.Length > 0) and StartsText(LastPackage, lbPackages.Items[i]) then
      lbPackages.Items.Delete(i - 1);
  end;
end;

procedure TfrmAutoGetItMain.DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
begin
  if not FPastFirstItem then begin
    if StartsText('--', ANewLine) then
      FPastFirstItem := True;
  end else if ContainsText(ANewLine, 'command finished') then
    FFinished := True
  else if not FFinished and (Trim(ANewLine).Length > 0) then
    if lbPackages.Items.IndexOf(ANewLine) = -1 then
      lbPackages.Items.Add(ANewLine);
end;

procedure TfrmAutoGetItMain.DosCommandTerminated(Sender: TObject);
begin
  FFinished := True;
end;

procedure TfrmAutoGetItMain.LoadRADVersionsCombo;
const
  MAX_VERSIONS = 6;
  BDS_VERSIONS: array[1..MAX_VERSIONS] of string = ('16.0', '17.0', '18.0', '19.0', '20.0', '21.0');
  DELPHI_NAMES: array[1..MAX_VERSIONS] of string = ('XE8', '10 Seattle', '10.1 Berlin', '10.2 Tokyo', '10.3 Rio', '10.4 Sydney');
begin
  cmbRADVersions.Items.Clear;

  var reg := TRegistry.Create;
  try
    reg.RootKey := HKEY_CURRENT_USER;

    // find and list all versions of RAD studio installed
    for var i := 1 to MAX_VERSIONS do
      if reg.OpenKey(BDS_USER_ROOT + BDS_VERSIONS[i], False) then begin
        // make sure a root path is listed before adding this version
        if Length(BDSRootPath(BDS_VERSIONS[i])) > 0 then
          cmbRADVersions.Items.Add(BDS_VERSIONS[i] + ' - Delphi ' + DELPHI_NAMES[i]);
      end;

    if cmbRADVersions.Items.Count > 0 then
      cmbRADVersions.ItemIndex := 0
    else begin
      cmbRADVersions.Style := TComboBoxStyle.csSimple;
      cmbRADVersions.Text := '<None Found>';
      cmbRADVersions.Enabled := False;
    end;
  finally
    reg.Free;
  end;
end;

function TfrmAutoGetItMain.SelectedBDSVersion: string;
begin
  Result := Trim(Copy(cmbRADVersions.Text, 1, Pos(' ', cmbRADVersions.Text) - 1));
end;

procedure TfrmAutoGetItMain.SetDownloadTime(const Value: Integer);
begin
  StatusBar.Panels[1].Text := Format('%d seconds', [Value]);
  StatusBar.Update;
end;

procedure TfrmAutoGetItMain.SetPackageCount(const Value: Integer);
begin
  StatusBar.Panels[0].Text := Format('%d packages', [Value]);
  StatusBar.Update;
end;

end.
