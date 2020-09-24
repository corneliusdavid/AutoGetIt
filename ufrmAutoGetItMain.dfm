object frmAutoGetItMain: TfrmAutoGetItMain
  Left = 0
  Top = 0
  Caption = 'Auto GetIt!'
  ClientHeight = 569
  ClientWidth = 848
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 480
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 848
    Height = 81
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 549
    DesignSize = (
      848
      81)
    object Label1: TLabel
      Left = 529
      Top = 22
      Width = 116
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'RAD Studio Version:'
      ExplicitLeft = 280
    end
    object btnRefresh: TBitBtn
      Left = 8
      Top = 17
      Width = 169
      Height = 39
      Action = actRefresh
      Caption = '&Refresh Package List'
      TabOrder = 0
    end
    object cmbRADVersions: TComboBox
      Left = 651
      Top = 19
      Width = 185
      Height = 24
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 1
      ExplicitLeft = 402
    end
  end
  object lbPackages: TCheckListBox
    Left = 0
    Top = 81
    Width = 848
    Height = 488
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    ItemHeight = 15
    Items.Strings = (
      'one'
      'two'
      'three')
    ParentFont = False
    TabOrder = 1
    ExplicitWidth = 281
  end
  object aclAutoGetit: TActionList
    Left = 216
    Top = 184
    object actRefresh: TAction
      Caption = '&Refresh Package List'
      OnExecute = actRefreshExecute
    end
    object actInstallChecked: TAction
      Caption = 'Install Checked'
      OnExecute = actInstallCheckedExecute
    end
  end
  object DosCommand: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 60
    MaxTimeAfterLastOutput = 30
    OnNewLine = DosCommandNewLine
    OnTerminated = DosCommandTerminated
    Left = 225
    Top = 265
  end
end
