unit ufrmAutoGetItMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  DosCommand, Vcl.CheckLst, Vcl.ComCtrls, Vcl.Menus, Vcl.Mask, Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components,
  Vcl.Imaging.pngimage, Vcl.BaseImageCollection, Vcl.ImageCollection;

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
    mnuCheckListPopup: TPopupMenu;
    actSaveCheckedList: TAction;
    actCheckAll: TAction;
    CheckAll1: TMenuItem;
    Savedcheckeditems1: TMenuItem;
    actUncheckAll: TAction;
    UncheckAll1: TMenuItem;
    N1: TMenuItem;
    InstallChecked1: TMenuItem;
    N2: TMenuItem;
    chkAcceptEULAs: TCheckBox;
    btnInstallSelected: TBitBtn;
    actUninstallChecked: TAction;
    UninstallChecked1: TMenuItem;
    FileOpenDialogSavedChecks: TFileOpenDialog;
    FileSaveDialogSavedChecks: TFileSaveDialog;
    actLoadCheckedList: TAction;
    dlgClearChecksFirst: TTaskDialog;
    actLoadCheckedList1: TMenuItem;
    actInstallOne: TAction;
    Installhighlightedpackage1: TMenuItem;
    actUninstallOne: TAction;
    Uninstallhighlightedpackage1: TMenuItem;
    Label2: TLabel;
    mmoDescription: TMemo;
    BindingsList1: TBindingsList;
    Splitter1: TSplitter;
    pnlListOpts: TPanel;
    pnlInstall: TPanel;
    imlAG: TImageCollection;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
    procedure DosCommandTerminated(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actInstallCheckedExecute(Sender: TObject);
    procedure actCheckAllExecute(Sender: TObject);
    procedure actUncheckAllExecute(Sender: TObject);
    procedure actUninstallCheckedExecute(Sender: TObject);
    procedure actSaveCheckedListExecute(Sender: TObject);
    procedure actLoadCheckedListExecute(Sender: TObject);
    procedure actInstallOneExecute(Sender: TObject);
    procedure actUninstallOneExecute(Sender: TObject);
    procedure lbPackagesClick(Sender: TObject);
    procedure rgrpSortByClick(Sender: TObject);
  private
    const
      BDS_USER_ROOT = '\Software\Embarcadero\BDS\';
    type
      TGetItArgsFunction = reference to function (const GetItName: string): string;
    var
      FPastFirstItem: Boolean;
      FFinished: Boolean;
      FPackageNewLine: string;
      FInstallAborted: Boolean;
    procedure SetExecLine(const Value: string);
    procedure SetDownloadTime(const Value: Integer);
    procedure SetPackageCount(const Value: Integer);
    procedure LoadRADVersionsCombo;
    procedure CleanPackageList;
    procedure ProcessCheckedPackages(GetItArgsFunc: TGetItArgsFunction);
    function BDSRootPath(const BDSVersion: string): string;
    function BDSBinDir: string;
    function SwitchFlavor(const DelphiVersionStr: string): Integer;
    function GetItInstallCmd(const GetItPackageName: string): string;
    function GetItUninstallCmd(const GetItPackageName: string): string;
    function ParseGetItName(const GetItLine: string): string;
    function CountChecked: Integer;
    function SelectedBDSVersion: string;
    function IsPackageIndexValid: Boolean;
    property PackageCount: Integer write SetPackageCount;
    property DownloadTime: Integer write SetDownloadTime;
    property ExecLine: string write SetExecLine;
  end;

var
  frmAutoGetItMain: TfrmAutoGetItMain;


implementation

{$R *.dfm}

uses
  System.Diagnostics, System.Win.Registry, System.StrUtils, System.IOUtils,
  ufrmInstallLog;

const
  GETIT_VR_NOT_SUPPORTED_MSG = 'GetItCmd not supported for this version of Delphi';

procedure TfrmAutoGetItMain.FormCreate(Sender: TObject);
begin
  LoadRADVersionsCombo;
  lbPackages.Items.Clear;
end;

function TfrmAutoGetItMain.SwitchFlavor(const DelphiVersionStr: string): Integer;
{ inspired by GitHub user toxinon12345 }
var
  DVer: string;
begin
  DVer := LeftStr(DelphiVersionStr, 4);
  if DVer = '19.0' then
    Result := 1   // BDS 19 | Delphi 10.2 Tokyo
  else if DVer = '20.0' then
    Result := 1   // BDS 20 | Delphi 10.3 Rio
  else if DVer = '21.0' then
    Result := 2   // BDS 21 | Delphi 10.4 Sydney
  else if DVer = '22.0' then
    Result := 2   // BDS 22 | Delphi 11.0 Alexandria
  else if DVer = '23.0' then
    Result := 2   // BDS 23 | Delphi 12.0 Athens
  else
    Result := -1; // unsupported Delphi version
end;

function TfrmAutoGetItMain.GetItInstallCmd(const GetItPackageName: string): string;
begin
  case SwitchFlavor(cmbRADVersions.Text) of
    1: Result := Format('-accept_eulas -i"%s"', [GetItPackageName]);
    2: Result := Format('-ae -i="%s"', [GetItPackageName]);
  else
    raise ENotImplemented.Create(GETIT_VR_NOT_SUPPORTED_MSG);
  end;
end;

function TfrmAutoGetItMain.GetItUninstallCmd(const GetItPackageName: string): string;
begin
  case SwitchFlavor(cmbRADVersions.Text) of
    1: Result := Format('-u"%s"', [GetItPackageName]);
    2: Result := Format('-u="%s"', [GetItPackageName]);
  else
    raise ENotImplemented.Create(GETIT_VR_NOT_SUPPORTED_MSG);
  end
end;

function TfrmAutoGetItMain.IsPackageIndexValid: Boolean;
begin
  Result := (lbPackages.ItemIndex > -1) and (lbPackages.ItemIndex < lbPackages.Items.Count);
end;

procedure TfrmAutoGetItMain.lbPackagesClick(Sender: TObject);
begin
  if IsPackageIndexValid then begin
    actInstallOne.Enabled := True;
    actUninstallOne.Enabled := True;

    mmoDescription.Text := lbPackages.Items[lbPackages.ItemIndex];

    if actInstallOne.Enabled then begin
      actInstallOne.Caption := 'Install ' + ParseGetItName(lbPackages.Items[lbPackages.ItemIndex]);
      actUninstallOne.Caption := 'Uninstall ' + ParseGetItName(lbPackages.Items[lbPackages.ItemIndex]);
    end else begin
      actInstallOne.Caption := 'Install ...';
      actUninstallOne.Caption := 'Uninstall ...';
    end;
  end else begin
    actInstallOne.Enabled := False;
    actUninstallOne.Enabled := False;
  end;
end;

procedure TfrmAutoGetItMain.actInstallCheckedExecute(Sender: TObject);
begin
  actInstallChecked.Enabled := False;
  actRefresh.Enabled := False;
  try
    ProcessCheckedPackages(function (const GetItName: string): string
        begin
          Result := GetItInstallCmd(GetItName);
        end);
  finally
    actInstallChecked.Enabled := True;
    actRefresh.Enabled := True;
  end;
end;

procedure TfrmAutoGetItMain.actUninstallCheckedExecute(Sender: TObject);
begin
  actUninstallChecked.Enabled := False;
  actRefresh.Enabled := False;
  try
    ProcessCheckedPackages(function (const GetItName: string): string
        begin
          Result := GetItUninstallCmd(GetItName);
        end);
  finally
    actUninstallChecked.Enabled := True;
    actRefresh.Enabled := True;
  end;
end;

procedure TfrmAutoGetItMain.actInstallOneExecute(Sender: TObject);
begin
  if IsPackageIndexValid then begin
    actInstallOne.Enabled := False;
    actRefresh.Enabled := False;
    try
      frmInstallLog.Initialize;
      frmInstallLog.ProcessGetItPackage(BDSBinDir,
                 GetItInstallCmd(ParseGetItName(lbPackages.Items[lbPackages.ItemIndex])),
                 1, 1, FInstallAborted);

      frmInstallLog.NotifyFinished;
    finally
      actInstallOne.Enabled := True;
      actRefresh.Enabled := True;
    end;
  end;
end;

procedure TfrmAutoGetItMain.actUninstallOneExecute(Sender: TObject);
begin
  if IsPackageIndexValid then begin
    actUninstallOne.Enabled := False;
    actRefresh.Enabled := False;
    try
      frmInstallLog.Initialize;
      frmInstallLog.ProcessGetItPackage(BDSBinDir,
                         GetItUninstallCmd(ParseGetItName(lbPackages.Items[lbPackages.ItemIndex])),
                         1, 1, FInstallAborted);
      frmInstallLog.NotifyFinished;
    finally
      actUninstallOne.Enabled := True;
      actRefresh.Enabled := True;
    end;
  end;
end;

procedure TfrmAutoGetItMain.actRefreshExecute(Sender: TObject);
var
  SortField: string;
  CmdLineArgs: string;
begin
  actRefresh.Enabled := False;
  try
    lbPackages.Items.Clear;
    FPastFirstItem := False;
    FFinished := False;

    case rgrpSortBy.ItemIndex of
      0: SortField := 'name';
      1: SortField := 'vendor';
      2: SortField := 'date';
    end;

    DosCommand.CurrentDir := BDSBinDir;

    case SwitchFlavor(cmbRADVersions.Text) of
      1: CmdLineArgs := Format('-listavailable:%s -sort:%s -filter:%s ', [edtNameFilter.Text, SortField,
                          IfThen(chkInstalledOnly.Checked, 'Installed', 'All')]);
      2: CmdLineArgs := Format('--list=%s --sort=%s --filter=%s', [
                          edtNameFilter.Text, SortField,
                          IfThen(chkInstalledOnly.Checked, 'installed', 'all')]);
    else
      raise ENotImplemented.Create(GETIT_VR_NOT_SUPPORTED_MSG);
    end;

    DosCommand.CommandLine := 'GetItCmd.exe ' + CmdLineArgs;
    ExecLine := TPath.Combine(DosCommand.CurrentDir, DosCommand.CommandLine);

    Screen.Cursor := crHourGlass;
    try
      var CmdTime := TStopWatch.Create;
      CmdTime.Start;

      DosCommand.Execute;
      repeat
        Application.ProcessMessages;
      until FFinished;
      CleanPackageList;

      CmdTime.Stop;
      DownloadTime := cmdTime.Elapsed.Seconds;
      PackageCount := lbPackages.Items.Count;
    finally
      Screen.Cursor := crDefault;
    end;

    actInstallChecked.Enabled := lbPackages.Items.Count > 0;
    actUninstallChecked.Enabled := lbPackages.Items.Count > 0;
  finally
    actRefresh.Enabled := True;
  end;
end;

procedure TfrmAutoGetItMain.actSaveCheckedListExecute(Sender: TObject);
var
  GetItName: string;
  CheckedList: TStringList;
begin
  CheckedList := TStringList.Create;
  try
    for var i := 0 to lbPackages.Count - 1 do
      if lbPackages.Checked[i] then begin
        GetItName := ParseGetItName(lbPackages.Items[i]);
        CheckedList.Add(GetItName);
      end;

    FileSaveDialogSavedChecks.FileName := 'AutoGetIt for RAD Studio ' + cmbRADVersions.Text;
    if FileSaveDialogSavedChecks.Execute then
      CheckedList.SaveToFile(FileSaveDialogSavedChecks.FileName);
  finally
    CheckedList.Free;
  end;
end;

procedure TfrmAutoGetItMain.actLoadCheckedListExecute(Sender: TObject);
var
  GetItPos: Integer;
  CheckedList: TStringList;
begin
  CheckedList := TStringList.Create;
  try
    FileOpenDialogSavedChecks.FileName := 'AutoGetIt for RAD Studio ' + cmbRADVersions.Text;
    if FileOpenDialogSavedChecks.Execute then begin
      CheckedList.LoadFromFile(FileOpenDialogSavedChecks.FileName);

      if CountChecked > 0 then begin
        if dlgClearChecksFirst.Execute then
          case dlgClearChecksFirst.ModalResult of
            mrCancel:
              Exit;
            mrYes:
              actUncheckAll.Execute;
          end;
      end;

      for var i := 0 to CheckedList.Count - 1 do begin
        for GetItPos := 0 to lbPackages.Items.Count - 1 do
          if StartsText(CheckedList[i], lbPackages.Items[GetItPos]) then
            lbPackages.Checked[GetItPos] := True;
      end;
    end;
  finally
    CheckedList.Free;
  end;
end;

procedure TfrmAutoGetItMain.actCheckAllExecute(Sender: TObject);
begin
  lbPackages.CheckAll(TCheckBoxState.cbChecked);
end;

procedure TfrmAutoGetItMain.actUncheckAllExecute(Sender: TObject);
begin
  lbPackages.CheckAll(TCheckBoxState.cbUnchecked);
end;

function TfrmAutoGetItMain.BDSBinDir: string;
begin
  Result := TPath.Combine(BDSRootPath(SelectedBDSVersion), 'bin');
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
{ Not sure if there's a bug in DosCommand or what but the list of packages
  often contains cut-off entries that are then completed on the next line,
  like it misinterpreted a line break, so this routine goes through and
  deletes those partial entries by checking to see if the previous line
  is the start of the current line.
}
var
  LastPackage: string;
begin
  LastPackage := EmptyStr;
  for var i := lbPackages.Count - 1 downto 1 do begin
    LastPackage := lbPackages.Items[i-1];

    if (LastPackage.Length > 0) and StartsText(LastPackage, lbPackages.Items[i]) then
      lbPackages.Items.Delete(i - 1)
    else
  end;
end;

function TfrmAutoGetItMain.CountChecked: Integer;
begin
  Result := 0;
  for var i := 0 to lbPackages.Count - 1 do
    if lbPackages.Checked[i] then
      Result := Result + 1;
end;

procedure TfrmAutoGetItMain.DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
begin
  if not FPastFirstItem then begin
    if StartsText('--', ANewLine) then
      FPastFirstItem := True;
  end else if ContainsText(ANewLine, 'command finished') then begin
    FFinished := True;
    // write out the last package
    if lbPackages.Items.IndexOf(FPackageNewLine) = -1 then
      lbPackages.Items.Add(FPackageNewLine);
  end else if not FFinished and (Trim(ANewLine).Length > 0) then begin
    if ANewLine.Contains('  ') then begin
      // if this is a new line, write out whatever was in the buffer for the previous package
      if (not FPackageNewLine.IsEmpty) and (lbPackages.Items.IndexOf(FPackageNewLine) = -1) then
        lbPackages.Items.Add(FPackageNewLine);

      // start a new package line
      FPackageNewLine := ANewLine;
    end else
      // add to the previous package line
      FPackageNewLine := FPackageNewLine + ANewLine
  end;
end;

procedure TfrmAutoGetItMain.DosCommandTerminated(Sender: TObject);
begin
  FFinished := True;
end;

procedure TfrmAutoGetItMain.LoadRADVersionsCombo;
const
  MAX_VERSIONS = 5;
  BDS_VERSIONS: array[1..MAX_VERSIONS] of string = ('19.0', '20.0', '21.0', '22.0', '23.0');
  DELPHI_NAMES: array[1..MAX_VERSIONS] of string = ('10.2 Tokyo', '10.3 Rio', '10.4 Sydney', '11 Alexandria', '12 Athens');
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
          cmbRADVersions.Items.Insert(0, BDS_VERSIONS[i] + ' - Delphi ' + DELPHI_NAMES[i]);
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

function TfrmAutoGetItMain.ParseGetItName(const GetItLine: string): string;
begin
  var space := Pos(' ', GetItLine);
  Result := LeftStr(GetItLine, space - 1);
end;

procedure TfrmAutoGetItMain.ProcessCheckedPackages(GetItArgsFunc: TGetItArgsFunction);
var
  GetItLine: string;
  GetItName: string;
  count, total: Integer;
begin
  FInstallAborted := False;
  total := CountChecked;
  if total = 0 then
    ShowMessage('There are no packages selected.')
  else begin
    count := 0;
    frmInstallLog.Initialize;
    for var i := 0 to lbPackages.Count - 1 do begin
      if lbPackages.Checked[i] then begin
        GetItLine := lbPackages.Items[i];
        GetItName := ParseGetItName(GetItLine);

        Inc(count);
        frmInstallLog.ProcessGetItPackage(BDSBinDir, GetItArgsFunc(GetItName),
                                          Count, Total, FInstallAborted)
      end;

      if FInstallAborted then
        Break;
    end;
    frmInstallLog.NotifyFinished;
  end;
end;

procedure TfrmAutoGetItMain.rgrpSortByClick(Sender: TObject);
begin
  if (StartsText('19', cmbRADVersions.Text) or StartsText('20', cmbRADVersions.Text)) and
     (rgrpSortBy.ItemIndex = 2) then
  begin
    rgrpSortBy.ItemIndex := 0;
    ShowMessage('Sorting by Date not available with GetItCmd for RAD Studio 19 or 20');
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

procedure TfrmAutoGetItMain.SetExecLine(const Value: string);
begin
  StatusBar.Panels[2].Text := Value;
  StatusBar.Update;
end;

procedure TfrmAutoGetItMain.SetPackageCount(const Value: Integer);
begin
  StatusBar.Panels[0].Text := Format('%d packages', [Value]);
  StatusBar.Update;
end;

end.
