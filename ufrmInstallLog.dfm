object frmInstallLog: TfrmInstallLog
  Left = 0
  Top = 0
  Caption = 'Install Log'
  ClientHeight = 555
  ClientWidth = 803
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
    Width = 803
    Height = 517
    Align = alClient
    ItemHeight = 13
    TabOrder = 0
    ExplicitWidth = 808
    ExplicitHeight = 385
  end
  object pnlLogBottom: TPanel
    Left = 0
    Top = 517
    Width = 803
    Height = 38
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 523
    DesignSize = (
      803
      38)
    object lblCount: TLabel
      Left = 105
      Top = 12
      Width = 76
      Height = 13
      Caption = '0 of 2 packages'
    end
    object btnCancel: TBitBtn
      Left = 8
      Top = 4
      Width = 89
      Height = 28
      Anchors = [akLeft, akTop, akBottom]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnCancelClick
      ExplicitHeight = 35
    end
    object pbInstalls: TProgressBar
      Left = 208
      Top = 6
      Width = 569
      Height = 27
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
    end
  end
  object DosCmdGetItInstall: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewLine = DosCmdGetItInstallNewLine
    OnTerminated = DosCmdGetItInstallTerminated
    Left = 240
    Top = 216
  end
end
