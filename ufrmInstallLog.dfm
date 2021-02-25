object frmInstallLog: TfrmInstallLog
  Left = 0
  Top = 0
  Caption = 'Install Log'
  ClientHeight = 555
  ClientWidth = 808
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbInstallLog: TListBox
    Left = 0
    Top = 0
    Width = 808
    Height = 555
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 176
    ExplicitWidth = 121
    ExplicitHeight = 97
  end
  object DosCmdGetItInstall: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewLine = DosCmdGetItInstallNewLine
    OnTerminated = DosCmdGetItInstallTerminated
    Left = 232
    Top = 216
  end
end
