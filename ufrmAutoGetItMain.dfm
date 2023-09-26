object frmAutoGetItMain: TfrmAutoGetItMain
  Left = 0
  Top = 0
  Margins.Left = 2
  Margins.Top = 2
  Margins.Right = 2
  Margins.Bottom = 2
  Caption = 'Auto GetIt!'
  ClientHeight = 569
  ClientWidth = 921
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 925
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 16
  object Splitter1: TSplitter
    Left = 0
    Top = 500
    Width = 921
    Height = 4
    Cursor = crVSplit
    Align = alBottom
    MinSize = 15
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 921
    Height = 89
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 919
    object pnlListOpts: TPanel
      Left = 1
      Top = 1
      Width = 504
      Height = 87
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object btnRefresh: TBitBtn
        Left = 16
        Top = 17
        Width = 161
        Height = 39
        Action = actRefresh
        Caption = '&Refresh Package List'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF91DA8F5C
          D65958E25630D92F3AD2387EC97BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF84CE806ACB6678C074FF00FF67B36231C62E41CA3F7CC0
          78FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF66B7604BA946FF00FFFF
          00FFFF00FFFF00FF67B36261DA5E91DE8F61A95AFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF67B36299EA
          974FA448FF00FFFF00FFFF00FFFF00FFFF00FF84BE80FF00FFFF00FFFF00FFFF
          00FFFF00FF67B36267B36267B3628DEA8CAFE7AD68B4629BC797FF00FFFF00FF
          32D12F79CA7532D12FFF00FFFF00FFFF00FFFF00FFFF00FF4FD14B7AE8798DEA
          8C99DE97449D3CFF00FFFF00FF8FDF8D26D42546D14572B76DFF00FFFF00FFFF
          00FFFF00FFFF00FF6AD1668CEC8B9FEF9E6AB7647BB575FF00FF84BE8032D431
          28D1262CCB2A71D46F84BE80FF00FFFF00FFFF00FFFF00FFFF00FF61DA5E9FE0
          9C449D3CFF00FFFF00FF67B36267B36227D2266BD56967B36267B362FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF6DC569FF00FFFF00FFFF00FFFF00FF54BE4F
          27D2266ED56C53A24BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF3ADC388BE68867B362FF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          5AD85785E783A1E89F67B362FF00FFFF00FFFF00FF83CB7F3EA638FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7EDD7B92EC9188EA8767B3627A
          D67773D26F3EB239FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF9ACE9790D38D84CA8154B54F6FBE6AFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
      end
      object chkInstalledOnly: TCheckBox
        Left = 399
        Top = 30
        Width = 103
        Height = 17
        Caption = 'Installed Only'
        TabOrder = 1
      end
      object edtNameFilter: TLabeledEdit
        Left = 183
        Top = 62
        Width = 314
        Height = 24
        EditLabel.Width = 160
        EditLabel.Height = 24
        EditLabel.Margins.Left = 12
        EditLabel.Margins.Top = 12
        EditLabel.Margins.Right = 12
        EditLabel.Margins.Bottom = 12
        EditLabel.Caption = 'Name/description contains: '
        LabelPosition = lpLeft
        TabOrder = 2
        Text = ''
        TextHint = 'leave blank to include all packages'
      end
      object rgrpSortBy: TRadioGroup
        Left = 183
        Top = 10
        Width = 210
        Height = 46
        Hint = 
          'This parameter is passed to the command line but does not seem t' +
          'o have any effect.'
        Caption = 'Sort By'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Name'
          'Vendor'
          'Date')
        TabOrder = 3
        OnClick = rgrpSortByClick
      end
    end
    object pnlInstall: TPanel
      Left = 505
      Top = 1
      Width = 409
      Height = 87
      Align = alLeft
      BevelEdges = []
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 93
        Top = 14
        Width = 116
        Height = 16
        Alignment = taRightJustify
        Caption = 'RAD Studio Version:'
      end
      object Label2: TLabel
        Left = 5
        Top = 61
        Width = 204
        Height = 14
        Alignment = taRightJustify
        Caption = 'All EULAs are automatically accepted.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGrayText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object btnInstallSelected: TBitBtn
        Left = 215
        Top = 39
        Width = 186
        Height = 34
        Action = actInstallChecked
        Caption = 'Install checked'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000130B0000130B00000000000000000000FFFFFFFFFFFF
          FEFEFED5D4D4D5D5D5D5D6D6D3D4D4D2D2D2D3D0CFD9C7C3E2D6D3FDFDFDFBFA
          FAF9F8F8FBFBFBFDFDFDFFFFFFFFFFFF4949496262626A6A6A6A6A6A6A6A6A6C
          6C6C393D3DF6EAE7915B51814032B49187FFFFFFF9F8F8FCFCFCFFFFFF747474
          858787FFFFFFF5F5F5F5F5F5F5F5F5FFFFFF333535E5D1CC6E2313905448B38C
          87A7796FFDFDFDFBFAFAFFFFFF696969CACDCDFFFFFFFDFFFFFDFFFFFDFFFFFF
          FFFF313133FFFFFFC9ABA9884A3ED2B3B5B07E79FFFFFFFBFAFAFFFFFF6B6F71
          996448B88F7EB68F7AB68F7AB68F7ABE9580402C21FCF7F7B48C888C4E40D5B8
          BADBC0C0FFFFFFFDFDFDFFFFFF75655DE0B692FFBE59FFBE5DFFBE5DFFBE5DFF
          C25DA27D4BE8DBDD874C4371301F6F2D1D712E1D7A3726E7DBD8FFFFFF6C6F75
          FFAC4E8D3000913200913200913200933200663713FFFFFFD5BABCD2B9BBCFB3
          B3CFB1B38E5247DFCFCADDDDDD45454540444ABBC1C5E2E8ECE0E6EAE0E6EAE6
          EEF22F3335FDFAFCE5D7DBE3D5D7DDCBCBD1B2B48E5246E1D2CE3131317B7B7B
          B2B2B23131313333333333333535356161617272729D9994FFD8ABF9D3A8ECE8
          EAD5BABA8D5345E1D2CED5D5D5404040CACACAFFFFFFFFFFFFFFFFFFD7D7D73D
          3D3D5A5A5C8F8578FFD79FFCBB6DEFEBEFDBC0C08E5446E1D2CEFFFFFF2F2F2F
          353535333333333333313333333537565450595654FFE8C9FFE5C4FCC88BF0EB
          EFE0C8CA8F5448E2D3D0FFFFFFFFFFFFFFFFFFF6EFECF5E6E4FFFAFBF2E3DAFF
          EBC5FFF0D0FFE3C1FFC277FDD6A8F2EDEFE5D0D090564AE2D3D0FFFFFFFFFFFF
          FFFFFFC5A69FBD9990DACACDB18967FFAA31FFBE66FFC87CFFD18FFFE4C1F5EE
          F2E9D6D891584CE2D3D0FFFFFFFFFFFFFFFFFFB79188B1867ED4C0C080675D80
          696780676380676380655F8B736ED6C6C4ECDADC92594DE2D3D0FFFFFFFFFFFF
          FFFFFFBB9991B38A82F2E2E2F2E0E2F2E0E2F2E0E2F2E0E2F2E0E2F0E0E0ECDC
          DCF2E2E2955B4FE2D3D0FFFFFFFFFFFFFFFFFFBA968D874A3A935B4F93594D93
          594D93594D93594D93594D93594D93594D955B4F813F30E0D0CD}
        ParentFont = False
        TabOrder = 0
      end
      object chkAcceptEULAs: TCheckBox
        Left = 104
        Top = 40
        Width = 105
        Height = 17
        Alignment = taLeftJustify
        Caption = 'Accept EULAs'
        Checked = True
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 1
      end
      object cmbRADVersions: TComboBox
        Left = 215
        Top = 12
        Width = 186
        Height = 24
        Style = csDropDownList
        TabOrder = 2
      end
    end
  end
  object lbPackages: TCheckListBox
    Left = 0
    Top = 89
    Width = 921
    Height = 411
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
    PopupMenu = mnuCheckListPopup
    TabOrder = 1
    OnClick = lbPackagesClick
    ExplicitWidth = 919
    ExplicitHeight = 407
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 550
    Width = 921
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
    ExplicitTop = 546
    ExplicitWidth = 919
  end
  object mmoDescription: TMemo
    Left = 0
    Top = 504
    Width = 921
    Height = 46
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 3
    ExplicitTop = 500
    ExplicitWidth = 919
  end
  object aclAutoGetit: TActionList
    Left = 216
    Top = 184
    object actRefresh: TAction
      Caption = '&Refresh Package List'
      OnExecute = actRefreshExecute
    end
    object actInstallChecked: TAction
      Category = 'install'
      Caption = 'Install checked'
      Enabled = False
      OnExecute = actInstallCheckedExecute
    end
    object actSaveCheckedList: TAction
      Category = 'load and save'
      Caption = 'Saved checked items'
      ShortCut = 16467
      OnExecute = actSaveCheckedListExecute
    end
    object actCheckAll: TAction
      Category = 'check all'
      Caption = 'Check All'
      ShortCut = 16449
      OnExecute = actCheckAllExecute
    end
    object actUncheckAll: TAction
      Category = 'check all'
      Caption = 'Uncheck All'
      OnExecute = actUncheckAllExecute
    end
    object actUninstallChecked: TAction
      Category = 'install'
      Caption = 'Uninstall checked'
      Enabled = False
      OnExecute = actUninstallCheckedExecute
    end
    object actLoadCheckedList: TAction
      Category = 'load and save'
      Caption = 'Load checked items'
      OnExecute = actLoadCheckedListExecute
    end
    object actInstallOne: TAction
      Category = 'install'
      Caption = 'Install highlighted'
      Enabled = False
      OnExecute = actInstallOneExecute
    end
    object actUninstallOne: TAction
      Category = 'install'
      Caption = 'Uninstall highlighted'
      Enabled = False
      OnExecute = actUninstallOneExecute
    end
  end
  object DosCommand: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 60
    MaxTimeAfterLastOutput = 30
    OnNewLine = DosCommandNewLine
    OnTerminated = DosCommandTerminated
    Left = 209
    Top = 329
  end
  object mnuCheckListPopup: TPopupMenu
    Left = 176
    Top = 488
    object CheckAll1: TMenuItem
      Action = actCheckAll
    end
    object UncheckAll1: TMenuItem
      Action = actUncheckAll
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object InstallChecked1: TMenuItem
      Action = actInstallChecked
    end
    object UninstallChecked1: TMenuItem
      Action = actUninstallChecked
    end
    object Installhighlightedpackage1: TMenuItem
      Action = actInstallOne
    end
    object Uninstallhighlightedpackage1: TMenuItem
      Action = actUninstallOne
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Savedcheckeditems1: TMenuItem
      Action = actSaveCheckedList
    end
    object actLoadCheckedList1: TMenuItem
      Action = actLoadCheckedList
    end
  end
  object FileOpenDialogSavedChecks: TFileOpenDialog
    DefaultExtension = '*.txt'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Text files'
        FileMask = '*.txt'
      end
      item
        DisplayName = 'Any file'
        FileMask = '*.*'
      end>
    Options = [fdoPathMustExist, fdoFileMustExist]
    Title = 'Open a saved set of GetIt checked names'
    Left = 556
    Top = 384
  end
  object FileSaveDialogSavedChecks: TFileSaveDialog
    DefaultExtension = '*.txt'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Text files'
        FileMask = '*.txt'
      end
      item
        DisplayName = 'Any file'
        FileMask = '*.*'
      end>
    Options = [fdoOverWritePrompt, fdoCreatePrompt]
    Title = 'Save a set of GetIt checked names'
    Left = 488
    Top = 528
  end
  object dlgClearChecksFirst: TTaskDialog
    Buttons = <>
    Caption = 'AutoGetIt'
    CommonButtons = [tcbYes, tcbNo, tcbCancel]
    DefaultButton = tcbCancel
    RadioButtons = <>
    Text = 
      'Should all currently checked packages be unchcecked before loadi' +
      'ng the saved list of checked packages?'
    Title = 'Clear checked first?'
    Left = 592
    Top = 256
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 788
    Top = 581
  end
end
