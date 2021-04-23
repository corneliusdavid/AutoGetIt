object frmAutoGetItMain: TfrmAutoGetItMain
  Left = 0
  Top = 0
  Caption = 'Auto GetIt!'
  ClientHeight = 586
  ClientWidth = 914
  Color = clBtnFace
  Constraints.MinHeight = 300
  Constraints.MinWidth = 868
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 914
    Height = 89
    Align = alTop
    TabOrder = 0
    DesignSize = (
      914
      89)
    object Label1: TLabel
      Left = 594
      Top = 22
      Width = 116
      Height = 16
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'RAD Studio Version:'
      ExplicitLeft = 550
    end
    object Label2: TLabel
      Left = 495
      Top = 69
      Width = 214
      Height = 16
      Alignment = taRightJustify
      Caption = 'All EULAs are automatically accepted.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
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
    object cmbRADVersions: TComboBox
      Left = 716
      Top = 19
      Width = 186
      Height = 24
      Style = csDropDownList
      Anchors = [akTop, akRight]
      TabOrder = 1
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
      TabOrder = 2
      OnClick = rgrpSortByClick
    end
    object chkInstalledOnly: TCheckBox
      Left = 399
      Top = 30
      Width = 103
      Height = 17
      Caption = 'Installed Only'
      TabOrder = 3
    end
    object edtNameFilter: TLabeledEdit
      Left = 183
      Top = 62
      Width = 265
      Height = 24
      EditLabel.Width = 160
      EditLabel.Height = 16
      EditLabel.Caption = 'Name/description contains: '
      LabelPosition = lpLeft
      TabOrder = 4
      TextHint = 'leave blank to include all packages'
    end
    object chkAcceptEULAs: TCheckBox
      Left = 605
      Top = 50
      Width = 105
      Height = 17
      Alignment = taLeftJustify
      Anchors = [akTop, akRight]
      Caption = 'Accept EULAs'
      Checked = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object btnInstallSelected: TBitBtn
      Left = 716
      Top = 49
      Width = 186
      Height = 34
      Action = actInstallChecked
      Anchors = [akTop, akRight]
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
      TabOrder = 6
    end
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 567
    Width = 914
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
  end
  object pnlPackage: TPanel
    Left = 185
    Top = 89
    Width = 729
    Height = 478
    Align = alClient
    TabOrder = 2
    object lbPackages: TCheckListBox
      Left = 1
      Top = 1
      Width = 727
      Height = 80
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Consolas'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      PopupMenu = mnuCheckListPopup
      TabOrder = 0
      OnClick = lbPackagesClick
    end
    object lstPackages: TControlList
      Left = 1
      Top = 81
      Width = 727
      Height = 396
      Align = alClient
      ItemCount = 10
      ItemHeight = 110
      ItemIndex = 0
      ItemMargins.Left = 0
      ItemMargins.Top = 0
      ItemMargins.Right = 0
      ItemMargins.Bottom = 0
      ParentColor = False
      TabOrder = 1
      ExplicitLeft = 4
      ExplicitTop = 76
      object lblPkgName: TLabel
        Left = 3
        Top = 4
        Width = 502
        Height = 19
        AutoSize = False
        Caption = '1.8-JDK8'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 2
        Top = 29
        Width = 706
        Height = 55
        AutoSize = False
        Caption = 'Java SE Development Kit 8'
        WordWrap = True
      end
      object lblPkgPlatforms: TLabel
        Left = 338
        Top = 90
        Width = 83
        Height = 16
        Caption = 'Platforms: x86'
      end
      object lblPkgOSes: TLabel
        Left = 3
        Top = 90
        Width = 169
        Height = 16
        Caption = 'Operating Systems: Windows'
      end
    end
  end
  object pnlCategoriesPkgs: TPanel
    Left = 0
    Top = 89
    Width = 185
    Height = 478
    Align = alLeft
    TabOrder = 3
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 183
      Height = 16
      Align = alTop
      Caption = 'Categories'
      ExplicitWidth = 61
    end
    object lblNumElements: TLabel
      Left = 1
      Top = 279
      Width = 183
      Height = 16
      Align = alTop
      Caption = 'Total Packages: 3807'
      ExplicitLeft = -3
      ExplicitTop = 274
    end
    object lbCategories: TListBox
      Left = 1
      Top = 17
      Width = 183
      Height = 262
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 18
      Items.Strings = (
        'All'
        'Libraries'
        'Components'
        'Internet Of Things'
        'Platforms'
        'Trial'
        'Industry Templates'
        'IDE Plugins'
        'Styles'
        'C++ Libraries'
        'Tools'
        'Sample Projects'
        'Promoted'
        'Patches and Hotfixes')
      ParentFont = False
      TabOrder = 0
      ExplicitTop = 11
    end
    object pnlPkgInfo: TPanel
      Left = 1
      Top = 295
      Width = 183
      Height = 182
      Margins.Top = 5
      Align = alClient
      BevelEdges = [beTop, beBottom]
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitLeft = -3
      ExplicitTop = 290
      object Label4: TLabel
        Left = 1
        Top = 1
        Width = 181
        Height = 16
        Align = alTop
        Alignment = taCenter
        Caption = 'Package Information'
        Color = clWindowText
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBtnFace
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = False
        ExplicitWidth = 117
      end
      object lblVendor: TRzURLLabel
        Left = 1
        Top = 33
        Width = 181
        Height = 13
        Align = alTop
        Caption = 'Embarcadero Technologies'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        URL = 'http://www.embarcadero.com'
        ExplicitTop = 17
        ExplicitWidth = 128
      end
      object lblPkgSize: TLabel
        Left = 1
        Top = 46
        Width = 181
        Height = 16
        Align = alTop
        Caption = 'Size: 367.599'
        ExplicitTop = 30
        ExplicitWidth = 79
      end
      object lblPkgType: TLabel
        Left = 1
        Top = 62
        Width = 181
        Height = 16
        Align = alTop
        Caption = 'Type: Library'
        ExplicitTop = 46
        ExplicitWidth = 76
      end
      object lblPkgTags: TLabel
        Left = 1
        Top = 165
        Width = 181
        Height = 16
        Align = alBottom
        Caption = 'Tags: '
        WordWrap = True
        ExplicitWidth = 37
      end
      object lblLicense: TRzURLLabel
        Left = 1
        Top = 78
        Width = 181
        Height = 13
        Align = alTop
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsUnderline]
        ParentFont = False
        URL = 
          'http://altd.embarcadero.com/getit/public/licenses/jdk8-license.t' +
          'xt'
        ExplicitLeft = -2
        ExplicitTop = 84
      end
      object lblModified: TLabel
        Left = 1
        Top = 91
        Width = 181
        Height = 16
        Align = alTop
        ExplicitWidth = 4
      end
      object lblVersion: TLabel
        Left = 1
        Top = 17
        Width = 181
        Height = 16
        Align = alTop
        Caption = 'Version: 18.0.25048.9432'
        ExplicitLeft = 2
        ExplicitTop = 8
      end
    end
  end
  object aclAutoGetit: TActionList
    Left = 128
    Top = 304
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
    Left = 329
    Top = 265
  end
  object mnuCheckListPopup: TPopupMenu
    Left = 336
    Top = 120
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
    Left = 404
    Top = 392
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
    Left = 416
    Top = 440
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
    Left = 560
    Top = 456
  end
  object BindSourceDBCategories: TBindSourceDB
    DataSet = dmGetItAPI.tblCategories
    ScopeMappings = <>
    Left = 56
    Top = 168
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 340
    Top = 501
    object LinkListControlToField1: TLinkListControlToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCategories
      FieldName = 'Name'
      Control = lbCategories
      FillExpressions = <>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
    object LinkPropertyToFieldNumElements: TLinkPropertyToField
      DataSource = BindSourceDBCategories
      FieldName = 'NumElements'
      Component = lblNumElements
      CustomFormat = #39'Total Packages: '#39' + %s'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldName: TLinkPropertyToField
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'Name'
      Component = lblPkgName
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldDescription: TLinkPropertyToField
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'Description'
      Component = Label5
      ComponentProperty = 'Caption'
    end
    object LinkGridToDataSourceBindSourceDBCatalogInfo: TLinkGridToDataSource
      DataSource = BindSourceDBCatalogInfo
      GridControl = lstPackages
      Columns = <>
    end
    object LinkPropertyToFieldVendor: TLinkPropertyToField
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'Vendor'
      Component = lblVendor
      CustomFormat = '%s'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldURL: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'VendorUrl'
      Component = lblVendor
      ComponentProperty = 'URL'
    end
    object LinkPropertyToFieldCaption: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'LibSize'
      Component = lblPkgSize
      CustomFormat = #39'Size: '#39' + %s'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption2: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'TypeDescription'
      Component = lblPkgType
      CustomFormat = #39'Type: '#39' + %s'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption3: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'Tags'
      Component = lblPkgTags
      CustomFormat = #39'Tags: '#39' + %s'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption4: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'LibLicenseName'
      Component = lblLicense
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldURL2: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'LibLicense'
      Component = lblLicense
      ComponentProperty = 'URL'
    end
    object LinkPropertyToFieldCaption5: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'Modified'
      Component = lblModified
      CustomFormat = #39'Last Modified: '#39' + FormatDateTime('#39'yyyy-mm-dd'#39', %s)'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption6: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'LibPlatforms'
      Component = lblPkgPlatforms
      CustomFormat = #39'Platforms: '#39' + JsonArrayToCSV(%s, '#39'Name'#39')'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption7: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'LibOSes'
      Component = lblPkgOSes
      CustomFormat = #39'Operating Systems: '#39' + JsonArrayToCSV(%s, '#39'Name'#39')'
      ComponentProperty = 'Caption'
    end
    object LinkPropertyToFieldCaption8: TLinkPropertyToField
      Category = 'Quick Bindings'
      DataSource = BindSourceDBCatalogInfo
      FieldName = 'Version'
      Component = lblVersion
      CustomFormat = #39'Version: '#39' + %s'
      ComponentProperty = 'Caption'
    end
  end
  object BindSourceDBCatalogInfo: TBindSourceDB
    DataSet = dmGetItAPI.tblCatalogInfo
    ScopeMappings = <>
    Left = 616
    Top = 392
  end
end
