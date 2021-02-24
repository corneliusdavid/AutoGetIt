object frmAutoGetItMain: TfrmAutoGetItMain
  Left = 0
  Top = 0
  Caption = 'Auto GetIt!'
  ClientHeight = 569
  ClientWidth = 852
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 868
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
    Width = 852
    Height = 89
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 848
    DesignSize = (
      852
      89)
    object Label1: TLabel
      Left = 532
      Top = 22
      Width = 116
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'RAD Studio Version:'
      ExplicitLeft = 550
    end
    object btnRefresh: TBitBtn
      Left = 8
      Top = 17
      Width = 169
      Height = 56
      Action = actRefresh
      Caption = '&Refresh Package List'
      TabOrder = 0
    end
    object cmbRADVersions: TComboBox
      Left = 654
      Top = 19
      Width = 186
      Height = 24
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 1
      ExplicitLeft = 704
    end
    object rgrpSortBy: TRadioGroup
      Left = 183
      Top = 10
      Width = 210
      Height = 46
      Caption = 'Sort By'
      Columns = 3
      ItemIndex = 0
      Items.Strings = (
        'Name'
        'Vendor'
        'Date')
      TabOrder = 2
    end
    object chkInstalledOnly: TCheckBox
      Left = 416
      Top = 28
      Width = 97
      Height = 17
      Caption = 'Installed Only'
      TabOrder = 3
    end
    object edtNameFilter: TLabeledEdit
      Left = 272
      Top = 62
      Width = 265
      Height = 24
      EditLabel.Width = 89
      EditLabel.Height = 16
      EditLabel.Caption = 'Name contains:'
      LabelPosition = lpLeft
      TabOrder = 4
      TextHint = 'leave blank to include all packages'
    end
  end
  object lbPackages: TCheckListBox
    Left = 0
    Top = 89
    Width = 852
    Height = 461
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
    ExplicitTop = 81
    ExplicitWidth = 848
    ExplicitHeight = 488
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 550
    Width = 852
    Height = 19
    Panels = <
      item
        Width = 100
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
    ExplicitLeft = 432
    ExplicitTop = 296
    ExplicitWidth = 0
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
