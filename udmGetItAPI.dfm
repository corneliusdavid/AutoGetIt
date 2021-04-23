object dmGetItAPI: TdmGetItAPI
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 405
  Width = 384
  object RESTClientGetIt: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'https://getit-104.embarcadero.com:443'
    ContentType = 'application/x-www-form-urlencoded'
    Params = <>
    UserAgent = 'AutoGetIt RESTClient/1.0'
    Left = 56
    Top = 40
  end
  object RESTReqCatalogInfo: TRESTRequest
    Client = RESTClientGetIt
    Method = rmPOST
    Params = <>
    Resource = 'catalog'
    ResourceSuffix = 'info'
    Response = RESTRespCatalogInfo
    Left = 120
    Top = 64
  end
  object RESTRespCatalogInfo: TRESTResponse
    ContentType = 'text/html'
    Left = 120
    Top = 112
  end
  object RESTRespDSAdapterCatInfo: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblCatalogInfo
    FieldDefs = <>
    Response = RESTRespCatalogInfo
    Left = 64
    Top = 168
  end
  object tblCatalogInfo: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Version'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Description'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Vendor'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'VendorUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Image'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Icon'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'TypeId'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'TypeDescription'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Tags'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibLicense'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibUrlProvider'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibCloudfrontUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibAkamaiUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibSignCloudfrontUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibSignAkamaiUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibProjectUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Modified'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibLicenseName'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'State'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'PurchaseUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'TargetPath'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'RequireElevation'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'AllUsers'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibSize'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibGenerateTmpUrl'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibCode'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibCodeName'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Categories'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibPlatforms'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LibOSes'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'ProductVersions'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Actions'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Compatibility'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'LicenseState'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 64
    Top = 216
    object tblCatalogInfoId: TWideStringField
      FieldName = 'Id'
      Size = 255
    end
    object tblCatalogInfoName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object tblCatalogInfoVersion: TWideStringField
      FieldName = 'Version'
      Size = 255
    end
    object tblCatalogInfoDescription: TWideStringField
      FieldName = 'Description'
      Size = 255
    end
    object tblCatalogInfoVendor: TWideStringField
      FieldName = 'Vendor'
      Size = 255
    end
    object tblCatalogInfoVendorUrl: TWideStringField
      FieldName = 'VendorUrl'
      Size = 255
    end
    object tblCatalogInfoImage: TWideStringField
      FieldName = 'Image'
      Size = 255
    end
    object tblCatalogInfoIcon: TWideStringField
      FieldName = 'Icon'
      Size = 255
    end
    object tblCatalogInfoTypeId: TWideStringField
      FieldName = 'TypeId'
      Size = 255
    end
    object tblCatalogInfoTypeDescription: TWideStringField
      FieldName = 'TypeDescription'
      Size = 255
    end
    object tblCatalogInfoTags: TWideStringField
      FieldName = 'Tags'
      Size = 255
    end
    object tblCatalogInfoLibLicense: TWideStringField
      FieldName = 'LibLicense'
      Size = 255
    end
    object tblCatalogInfoLibUrlProvider: TWideStringField
      FieldName = 'LibUrlProvider'
      Size = 255
    end
    object tblCatalogInfoLibCloudfrontUrl: TWideStringField
      FieldName = 'LibCloudfrontUrl'
      Size = 255
    end
    object tblCatalogInfoLibAkamaiUrl: TWideStringField
      FieldName = 'LibAkamaiUrl'
      Size = 255
    end
    object tblCatalogInfoLibSignCloudfrontUrl: TWideStringField
      FieldName = 'LibSignCloudfrontUrl'
      Size = 255
    end
    object tblCatalogInfoLibSignAkamaiUrl: TWideStringField
      FieldName = 'LibSignAkamaiUrl'
      Size = 255
    end
    object tblCatalogInfoLibProjectUrl: TWideStringField
      FieldName = 'LibProjectUrl'
      Size = 255
    end
    object tblCatalogInfoModified: TWideStringField
      FieldName = 'Modified'
      Size = 255
    end
    object tblCatalogInfoLibLicenseName: TWideStringField
      FieldName = 'LibLicenseName'
      Size = 255
    end
    object tblCatalogInfoState: TWideStringField
      FieldName = 'State'
      Size = 255
    end
    object tblCatalogInfoPurchaseUrl: TWideStringField
      FieldName = 'PurchaseUrl'
      Size = 255
    end
    object tblCatalogInfoTargetPath: TWideStringField
      FieldName = 'TargetPath'
      Size = 255
    end
    object tblCatalogInfoRequireElevation: TWideStringField
      FieldName = 'RequireElevation'
      Size = 255
    end
    object tblCatalogInfoAllUsers: TWideStringField
      FieldName = 'AllUsers'
      Size = 255
    end
    object tblCatalogInfoLibSize: TWideStringField
      FieldName = 'LibSize'
      Size = 255
    end
    object tblCatalogInfoLibUrl: TWideStringField
      FieldName = 'LibUrl'
      Size = 255
    end
    object tblCatalogInfoLibGenerateTmpUrl: TWideStringField
      FieldName = 'LibGenerateTmpUrl'
      Size = 255
    end
    object tblCatalogInfoLibCode: TWideStringField
      FieldName = 'LibCode'
      Size = 255
    end
    object tblCatalogInfoLibCodeName: TWideStringField
      FieldName = 'LibCodeName'
      Size = 255
    end
    object tblCatalogInfoCategories: TWideStringField
      FieldName = 'Categories'
      Size = 255
    end
    object tblCatalogInfoLibPlatforms: TWideStringField
      FieldName = 'LibPlatforms'
      Size = 255
    end
    object tblCatalogInfoLibOSes: TWideStringField
      FieldName = 'LibOSes'
      Size = 255
    end
    object tblCatalogInfoProductVersions: TWideStringField
      FieldName = 'ProductVersions'
      Size = 255
    end
    object tblCatalogInfoActions: TWideStringField
      FieldName = 'Actions'
      Size = 255
    end
    object tblCatalogInfoCompatibility: TWideStringField
      FieldName = 'Compatibility'
      Size = 255
    end
    object tblCatalogInfoLicenseState: TWideStringField
      FieldName = 'LicenseState'
      Size = 255
    end
  end
  object RESTReqCategories: TRESTRequest
    Client = RESTClientGetIt
    Method = rmPOST
    Params = <>
    Resource = 'categories'
    ResourceSuffix = 'info'
    Response = RESTRespCategories
    Left = 288
    Top = 32
  end
  object RESTRespCategories: TRESTResponse
    ContentType = 'text/html'
    Left = 288
    Top = 80
  end
  object RESTRespDSAdapterCategories: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblCategories
    FieldDefs = <>
    Response = RESTRespCategories
    Left = 288
    Top = 128
  end
  object tblCategories: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'NumElements'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 288
    Top = 176
    Content = {
      414442530F000000D2040000FF00010001FF02FF0304001A000000740062006C
      00430061007400650067006F00720069006500730005000A0000005400610062
      006C006500060000000000070000080032000000090000FF0AFF0B0400040000
      0049006400050004000000490064000C00010000000E000D000F00FF00000010
      0001110001120001130001140001150001160004000000490064001700FF0000
      00FEFF0B0400080000004E0061006D0065000500080000004E0061006D006500
      0C00020000000E000D000F00FF00000010000111000112000113000114000115
      00011600080000004E0061006D0065001700FF000000FEFF0B0400160000004E
      0075006D0045006C0065006D0065006E00740073000500160000004E0075006D
      0045006C0065006D0065006E00740073000C00030000000E000D000F00FF0000
      001000011100011200011300011400011500011600160000004E0075006D0045
      006C0065006D0065006E00740073001700FF000000FEFEFF18FEFF19FEFF1AFF
      1B1C0000000000FF1D0000040000002D00310001000600000041006C006C0002
      00080000003300380030003700FEFEFF1B1C0001000000FF1D00000200000031
      000100120000004C006900620072006100720069006500730002000400000037
      003200FEFEFF1B1C0002000000FF1D000002000000320001001400000043006F
      006D0070006F006E0065006E0074007300020006000000310036003400FEFEFF
      1B1C0003000000FF1D000002000000340001002400000049006E007400650072
      006E006500740020004F00660020005400680069006E00670073000200040000
      0037003200FEFEFF1B1C0004000000FF1D000004000000310035000100120000
      0050006C006100740066006F0072006D00730002000800000033003300380031
      00FEFEFF1B1C0005000000FF1D0000040000003300330001000A000000540072
      00690061006C0002000400000038003800FEFEFF1B1C0006000000FF1D000004
      0000003300360001002400000049006E00640075007300740072007900200054
      0065006D0070006C0061007400650073000200020000003400FEFEFF1B1C0007
      000000FF1D00000400000033003700010016000000490044004500200050006C
      007500670069006E0073000200020000003900FEFEFF1B1C0008000000FF1D00
      00040000003300380001000C0000005300740079006C00650073000200040000
      0034003000FEFEFF1B1C0009000000FF1D0000040000003400330001001A0000
      0043002B002B0020004C00690062007200610072006900650073000200040000
      0032003100FEFEFF1B1C000A000000FF1D0000040000003400360001000A0000
      0054006F006F006C0073000200020000003800FEFEFF1B1C000B000000FF1D00
      00040000003900390001001E000000530061006D0070006C0065002000500072
      006F006A00650063007400730002000400000033003700FEFEFF1B1C000C0000
      00FF1D000006000000390039003800010010000000500072006F006D006F0074
      00650064000200020000003200FEFEFF1B1C000D000000FF1D00000600000039
      00390039000100280000005000610074006300680065007300200061006E0064
      00200048006F0074006600690078006500730002000400000031003000FEFEFE
      FEFEFF1EFEFF1F20007F000000FF21FEFEFE0E004D0061006E00610067006500
      72001E0055007000640061007400650073005200650067006900730074007200
      790012005400610062006C0065004C006900730074000A005400610062006C00
      650008004E0061006D006500140053006F0075007200630065004E0061006D00
      65000A0054006100620049004400240045006E0066006F007200630065004300
      6F006E00730074007200610069006E00740073001E004D0069006E0069006D00
      75006D0043006100700061006300690074007900180043006800650063006B00
      4E006F0074004E0075006C006C00140043006F006C0075006D006E004C006900
      730074000C0043006F006C0075006D006E00100053006F007500720063006500
      49004400180064007400570069006400650053007400720069006E0067001000
      440061007400610054007900700065000800530069007A006500140053006500
      6100720063006800610062006C006500120041006C006C006F0077004E007500
      6C006C000800420061007300650014004F0041006C006C006F0077004E007500
      6C006C0012004F0049006E0055007000640061007400650010004F0049006E00
      570068006500720065001A004F0072006900670069006E0043006F006C004E00
      61006D006500140053006F007500720063006500530069007A0065001C004300
      6F006E00730074007200610069006E0074004C00690073007400100056006900
      650077004C006900730074000E0052006F0077004C0069007300740006005200
      6F0077000A0052006F0077004900440010004F0072006900670069006E006100
      6C001800520065006C006100740069006F006E004C006900730074001C005500
      7000640061007400650073004A006F00750072006E0061006C00120053006100
      7600650050006F0069006E0074000E004300680061006E00670065007300}
    object tblCategoriesId: TWideStringField
      FieldName = 'Id'
      Size = 255
    end
    object tblCategoriesName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
    object tblCategoriesNumElements: TWideStringField
      FieldName = 'NumElements'
      Size = 255
    end
  end
  object RESTRespDSAdapterCatPlatforms: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblCatalogPlatforms
    FieldDefs = <>
    Response = RESTRespCatalogInfo
    RootElement = '[0].LibPlatforms'
    NestedElements = True
    Left = 168
    Top = 184
  end
  object tblCatalogPlatforms: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 168
    Top = 232
    object tblCatalogPlatformsId: TWideStringField
      FieldName = 'Id'
      Size = 255
    end
    object tblCatalogPlatformsName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
  end
  object RESTRespDSAdapterCatOSes: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblCatalogOSes
    FieldDefs = <>
    Response = RESTRespCatalogInfo
    RootElement = '[0].LibOSes'
    NestedElements = True
    Left = 144
    Top = 288
  end
  object tblCatalogOSes: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftWideString
        Size = 255
      end
      item
        Name = 'Name'
        DataType = ftWideString
        Size = 255
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 144
    Top = 336
    object tblCatalogOSesId: TWideStringField
      FieldName = 'Id'
      Size = 255
    end
    object tblCatalogOSesName: TWideStringField
      FieldName = 'Name'
      Size = 255
    end
  end
end
