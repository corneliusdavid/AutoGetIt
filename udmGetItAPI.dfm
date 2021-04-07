object dmGetItAPI: TdmGetItAPI
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 332
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
    Left = 120
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
    Left = 120
    Top = 224
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
    Left = 232
    Top = 88
  end
  object RESTRespCategories: TRESTResponse
    ContentType = 'text/html'
    Left = 232
    Top = 136
  end
  object RESTRespDSAdapterCategories: TRESTResponseDataSetAdapter
    Active = True
    Dataset = tblCategories
    FieldDefs = <>
    Response = RESTRespCategories
    Left = 232
    Top = 184
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
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable, uvAutoCommitUpdates]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 232
    Top = 232
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
end
