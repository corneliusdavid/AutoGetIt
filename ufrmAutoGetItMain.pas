unit ufrmAutoGetItMain;

interface  USES
  RegexProxy, Winapi.CommCtrl,
  RegularExpressions, RegularExpressionsCore, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  DosCommand, Vcl.CheckLst, Vcl.ComCtrls, Vcl.Menus, Vcl.Mask;

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
    procedure StatusBarDblClick(Sender: TObject);
    function GetPanelIndex( Point: TPoint ): Integer;
  private
    const
      BDS_USER_ROOT = '\Software\Embarcadero\BDS\';
    type
      TGetItArgsFunction = reference to function (const GetItName: string): string;
    var
      FPastFirstItem: Boolean;
      FFinished: Boolean;
      FInstallAborted: Boolean;
    procedure SetExecLine(const Value: string);
    procedure SetDownloadTime(const Value: Integer);
    procedure SetPackageCount(const Value: Integer);
    procedure LoadRADVersionsCombo;
    procedure CleanPackageList;
    procedure ProcessCheckedPackages(GetItArgsFunc: TGetItArgsFunction);
    function BDSRootPath(const BDSVersion: string): string;
    function BDSBinDir: string;
    function GetItInstallCmd(const GetItPackageName: string): string;
    function GetItUninstallCmd(const GetItPackageName: string): string;
    function ParseGetItName(const GetItLine: string): string;
    function CountChecked: Integer;
    function SelectedBDSVersion: string;
    property PackageCount: Integer write SetPackageCount;
    property DownloadTime: Integer write SetDownloadTime;
    property ExecLine: string write SetExecLine;
  end;

var
  frmAutoGetItMain: TfrmAutoGetItMain;
  MyReProxy1: TMyRegexProxy;
  MyReProxy2: TMyRegexProxy;
  myRePattern: string = 'BDS ([^\x20]+) \x7C Delphi ([^\x20]+) (\w+)';
  myRePattern2: string = '@SET ([^\x20]+)=(.*)';
  getItUrl : string = 'https://getit-104.embarcadero.com';


implementation USES
  UEnvVars,
  System.Diagnostics, System.Win.Registry, System.StrUtils, System.IOUtils,
  ufrmInstallLog;

{$R *.dfm}

CONST
  GETIT_VR_NOT_SUPPORTED_MSG = 'This version of Delphi''s GetItCmd.exe is not supported.';

procedure TfrmAutoGetItMain.FormCreate(Sender: TObject);
begin
  LoadRADVersionsCombo;
  lbPackages.Items.Clear;

  var AutoGetItDir := GetCurrentDir();
  if FileExists( 'rsvars.bat' ) then begin
    var myRsVars : TextFile;   var myRsLine: string;  AssignFile( myRsVars, 'rsvars.bat' );   Reset( myRsVars );
      MyReProxy2.Open( myRePattern2, [roIgnoreCase] );

     While not Eof(myRsVars) do begin
       ReadLn(myRsVars, myRsLine);
       MyReProxy2.ResolveForEach_old_safe( myRsLine );
       //   MyReProxy2.GroupItem.Value
       DebugPrint( '>>> %s = %s',  [MyReProxy2.GroupCol.Item[1].Value, MyReProxy2.GroupCol.Item[2].Value ] );
       SetEnvVarValue( MyReProxy2.GroupCol.Item[1].Value, ExpandEnvVars(MyReProxy2.GroupCol.Item[2].Value) );
     End;
    CloseFile( myRsVars );
  end;




   var reg := TRegistry.Create;
    try
      reg.RootKey := HKEY_CURRENT_USER;
      var SubKey := BDS_USER_ROOT + SelectedBDSVersion() + '\CatalogRepository';
      var KeyExists := reg.OpenKey( SubKey, False);
      var serviceKind := reg.ReadString('ServiceKind');
      if KeyExists and (serviceKind = 'Online') then begin
        StatusBar.Panels[3].Text := reg.ReadString('ServiceUrl');
      end
      else if KeyExists and (serviceKind = 'Offline') then begin
        StatusBar.Panels[3].Text :=  reg.ReadString('ServicePath');
      end;
    finally
      reg.Free;
    end;



end;

function TfrmAutoGetItMain.GetItInstallCmd(const GetItPackageName: string): string;
begin


    var switch_dispatch : Integer;
    MyReProxy1.Open( myRePattern, [roIgnoreCase] );
    MyReProxy1.ResolveForEach_old_safe( cmbRADVersions.Text );

    if MyReProxy1.GroupCol.Item[1].Value = '19.0' then switch_dispatch := 1;   // BDS 19 | Delphi 10.2 Tokyo
    if MyReProxy1.GroupCol.Item[1].Value = '20.0' then switch_dispatch := 1;   // BDS 20 | Delphi 10.3 Rio
    if MyReProxy1.GroupCol.Item[1].Value = '21.0' then switch_dispatch := 2;   // BDS 21 | Delphi 10.4 Sydney
    if MyReProxy1.GroupCol.Item[1].Value = '22.0' then switch_dispatch := 3;   // BDS 22 | Delphi 11.0 Alexandria


  if switch_dispatch = 1 then
    Result := Format('-accept_eulas -i"%s"', [GetItPackageName])
  else if switch_dispatch = 2 then                                begin
    Result := Format('-ae -i="%s"', [GetItPackageName]);          end
  else if switch_dispatch = 3 then                                begin
    Result := Format('-ae -i="%s"', [GetItPackageName]);          end
  else                                                            begin
    raise ENotImplemented.Create(GETIT_VR_NOT_SUPPORTED_MSG);     end;
end;

function TfrmAutoGetItMain.GetItUninstallCmd(const GetItPackageName: string): string;
var  switch_dispatch : Integer;
begin
    MyReProxy1.Open( myRePattern, [roIgnoreCase] );
    MyReProxy1.ResolveForEach_old_safe( cmbRADVersions.Text );

    if MyReProxy1.GroupCol.Item[1].Value = '19.0' then switch_dispatch := 1;   // BDS 19 | Delphi 10.2 Tokyo
    if MyReProxy1.GroupCol.Item[1].Value = '20.0' then switch_dispatch := 1;   // BDS 20 | Delphi 10.3 Rio
    if MyReProxy1.GroupCol.Item[1].Value = '21.0' then switch_dispatch := 2;   // BDS 21 | Delphi 10.4 Sydney
    if MyReProxy1.GroupCol.Item[1].Value = '22.0' then switch_dispatch := 3;   // BDS 22 | Delphi 11.0 Alexandria


  if switch_dispatch = 1 then
    Result := Format('-u"%s"', [GetItPackageName])
  else if switch_dispatch = 2 then                                begin
    Result := Format('-u="%s"', [GetItPackageName]);              end
  else if switch_dispatch = 3  then                               begin
    Result := Format('-u="%s"', [GetItPackageName]);              end
  else                                                            begin
    raise ENotImplemented.Create(GETIT_VR_NOT_SUPPORTED_MSG);     end;
end;

procedure TfrmAutoGetItMain.lbPackagesClick(Sender: TObject);
begin
  actInstallOne.Enabled := (lbPackages.ItemIndex > -1) and (lbPackages.ItemIndex < lbPackages.Items.Count);
  actUninstallOne.Enabled := (lbPackages.ItemIndex > -1) and (lbPackages.ItemIndex < lbPackages.Items.Count);

  if actInstallOne.Enabled then begin
    actInstallOne.Caption := 'Install ' + ParseGetItName(lbPackages.Items[lbPackages.ItemIndex]);
    actUninstallOne.Caption := 'Uninstall ' + ParseGetItName(lbPackages.Items[lbPackages.ItemIndex]);
  end else begin
    actInstallOne.Caption := 'Install ...';
    actUninstallOne.Caption := 'Uninstall ...';
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

procedure TfrmAutoGetItMain.actUninstallOneExecute(Sender: TObject);
begin
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

procedure TfrmAutoGetItMain.actRefreshExecute(Sender: TObject);
var
  SortField: string;
  CmdLineArgs: string;
  switch_dispatch : Integer;
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

    DosCommand.CurrentDir := BDSBinDir();

//    var parseCombo: String :=
    MyReProxy1.Open( myRePattern, [roIgnoreCase] );
    MyReProxy1.ResolveForEach_old_safe( cmbRADVersions.Text );

    if MyReProxy1.GroupCol.Item[1].Value = '19.0' then switch_dispatch := 1;   // BDS 19 | Delphi 10.2 Tokyo
    if MyReProxy1.GroupCol.Item[1].Value = '20.0' then switch_dispatch := 1;   // BDS 20 | Delphi 10.3 Rio
    if MyReProxy1.GroupCol.Item[1].Value = '21.0' then switch_dispatch := 2;   // BDS 21 | Delphi 10.4 Sydney
    if MyReProxy1.GroupCol.Item[1].Value = '22.0' then switch_dispatch := 3;   // BDS 22 | Delphi 11.0 Alexandria

    if switch_dispatch = 1 then
      CmdLineArgs := Format('-listavailable:%s -sort:%s -filter:%s ', [edtNameFilter.Text, SortField,
                          IfThen(chkInstalledOnly.Checked, 'Installed', 'All')])
    else if switch_dispatch = 2 then                                                  begin
      CmdLineArgs := Format('--list=%s --sort=%s --filter=%s', [
                          edtNameFilter.Text, SortField,
                          IfThen(chkInstalledOnly.Checked, 'installed', 'all')]);     end
    else if switch_dispatch = 3 then                                                  begin
      CmdLineArgs := Format('--list=%s --sort=%s --filter=%s', [
                          edtNameFilter.Text, SortField,
                          IfThen(chkInstalledOnly.Checked, 'installed', 'all')]);     end
    else                                                                              begin
      raise ENotImplemented.Create(GETIT_VR_NOT_SUPPORTED_MSG);                       end;


    DosCommand.CommandLine := 'GetItCmd.exe ' + CmdLineArgs;
//    DosCommand.CommandLine := 'winver';

    ExecLine := DosCommand.CommandLine;


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
  Result := TPath.Combine( BDSRootPath( SelectedBDSVersion() ), 'bin');
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
  MAX_VERSIONS = 4;
  BDS_VERSIONS: array[1..MAX_VERSIONS] of string = ('19.0', '20.0', '21.0', '22.0');
  DELPHI_NAMES: array[1..MAX_VERSIONS] of string = ('10.2 Tokyo', '10.3 Rio', '10.4 Sydney', '11 Alexandria');
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
          cmbRADVersions.Items.Insert(0, 'BDS ' + BDS_VERSIONS[i] + ' | Delphi ' + DELPHI_NAMES[i]);
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

procedure TfrmAutoGetItMain.rgrpSortByClick(Sender: TObject);
var switch_dispatch : Integer;
begin
    MyReProxy1.Open( myRePattern, [roIgnoreCase] );
    MyReProxy1.ResolveForEach_old_safe( cmbRADVersions.Text );

    if MyReProxy1.GroupCol.Item[1].Value = '19.0' then switch_dispatch := 1;   // BDS 19 | Delphi 10.2 Tokyo
    if MyReProxy1.GroupCol.Item[1].Value = '20.0' then switch_dispatch := 1;   // BDS 20 | Delphi 10.3 Rio


  if (switch_dispatch = 1) and
     (rgrpSortBy.ItemIndex = 2) then
  begin
    rgrpSortBy.ItemIndex := 0;
    ShowMessage('Sorting by Date not available with GetItCmd for RAD Studio 19 or 20');
  end;
end;

function TfrmAutoGetItMain.SelectedBDSVersion: string;
begin
  MyReProxy1.Open( myRePattern, [roIgnorecase]);
  MyReProxy1.ResolveForEach_old_safe( cmbRADVersions.Text );

DebugPrint( '%s',  [ MyReProxy1.GroupCol.Item[1].Value ] );

  Result := MyReProxy1.GroupCol.Item[1].Value;

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




procedure TfrmAutoGetItMain.StatusBarDblClick(Sender: TObject);
var
  LClickPos: TPoint;    LIndex: Integer;
begin
  LClickPos := SmallPointToPoint(TSmallPoint(GetMessagePos()));
  LClickPos := StatusBar.ScreenToClient(LClickPos);
  LIndex := GetPanelIndex(LClickPos);

  var Comspec : string := ExpandEnvVars( '%windir%\system32\cmd.exe' );  var ErrorCode: Integer;
  if 2 = LIndex then ExecuteProcess( Comspec , '/K title RADStudio', '', false, false, false, ErrorCode);
  if 3 = LIndex then begin
       var reg := TRegistry.Create;
        try
          reg.RootKey := HKEY_CURRENT_USER;
          var SubKey := BDS_USER_ROOT + SelectedBDSVersion() + '\CatalogRepository';
          var KeyExists := reg.OpenKey( SubKey, False);
          var serviceKind := reg.ReadString('ServiceKind');
          if KeyExists and (serviceKind = 'Online') then begin
            StatusBar.Panels[3].Text := reg.ReadString('ServicePath');
            DosCommand.CommandLine := 'GetItCmd.exe --config=useoffline';
          end else if KeyExists and (serviceKind = 'Offline') then begin
            StatusBar.Panels[3].Text :=  reg.ReadString('ServiceUrl');
            DosCommand.CommandLine := 'GetItCmd.exe --config=useonline';
          end;
          DosCommand.Execute();
          ExecLine := DosCommand.CommandLine;
        finally
          reg.Free;
        end;
  end;
end;

//=========================================================================================================================

function  TfrmAutoGetItMain.GetPanelIndex( Point: TPoint ): Integer;
var
  I: Integer;    LRect: TRect;
begin
  For I := 0 to StatusBar.Panels.Count - 1 do    begin
    if SendMessage(StatusBar.Handle, SB_GETRECT, I, LPARAM(@LRect)) <> 0 then begin
      if PtInRect(LRect, Point) then
        Exit(I);
    end;
  End;

  Result := -1;
end;


END.
