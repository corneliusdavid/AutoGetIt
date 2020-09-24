unit ufrmAutoGetItMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  DosCommand, Vcl.CheckLst;

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
    procedure actRefreshExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
    procedure DosCommandTerminated(Sender: TObject);
    procedure actInstallCheckedExecute(Sender: TObject);
  private
    const
      BDS_USER_ROOT = '\Software\Embarcadero\BDS\';
    var
      PastFirstItem: Boolean;
      Finished: Boolean;
    procedure LoadRADVersionsCombo;
    function BDSRootPath(const BDSVersion: string): string;
    function SelectedBDSVersion: string;
  end;

var
  frmAutoGetItMain: TfrmAutoGetItMain;


implementation

{$R *.dfm}

uses
  System.Win.Registry, System.StrUtils;

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
begin
  lbPackages.Items.Clear;
  PastFirstItem := False;
  Finished := False;

  DosCommand.CurrentDir := BDSRootPath(SelectedBDSVersion);
  DosCommand.CommandLine := 'GetItCmd.exe -l= -s=name -f=all';

  Screen.Cursor := crHourGlass;
  try
    DosCommand.Execute;

    repeat
      Application.ProcessMessages;
    until Finished;
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

procedure TfrmAutoGetItMain.DosCommandNewLine(ASender: TObject; const ANewLine: string; AOutputType: TOutputType);
begin
  if not PastFirstItem then begin
    if StartsText('--', ANewLine) then
      PastFirstItem := True;
  end else if Length(Trim(ANewLine)) = 0 then
    Finished := True
  else if not Finished then
    if lbPackages.Items.IndexOf(ANewLine) = -1 then
      lbPackages.Items.Add(ANewLine);
end;

procedure TfrmAutoGetItMain.DosCommandTerminated(Sender: TObject);
begin
  Finished := True;
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

procedure TfrmAutoGetItMain.FormCreate(Sender: TObject);
begin
  LoadRADVersionsCombo;
end;

end.
