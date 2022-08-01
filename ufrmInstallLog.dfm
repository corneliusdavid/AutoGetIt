object frmInstallLog: TfrmInstallLog
  Left = 0
  Top = 0
  Caption = 'Install/Uninstall Log'
  ClientHeight = 1110
  ClientWidth = 1606
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -22
  Font.Name = 'Tahoma'
  Font.Style = []
  PixelsPerInch = 192
  TextHeight = 27
  object lbInstallLog: TListBox
    Left = 0
    Top = 0
    Width = 1606
    Height = 1034
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    ItemHeight = 27
    TabOrder = 0
  end
  object pnlLogBottom: TPanel
    Left = 0
    Top = 1034
    Width = 1606
    Height = 76
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      1606
      76)
    object lblCount: TLabel
      Left = 210
      Top = 24
      Width = 155
      Height = 27
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Caption = '0 of 2 packages'
    end
    object btnCancel: TBitBtn
      Left = 20
      Top = 12
      Width = 178
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = [akLeft, akTop, akBottom]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object pbInstalls: TProgressBar
      Left = 416
      Top = 12
      Width = 1138
      Height = 54
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
    end
    object btnClose: TBitBtn
      Left = 20
      Top = 12
      Width = 178
      Height = 56
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Anchors = [akLeft, akTop, akBottom]
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnCloseClick
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
