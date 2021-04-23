unit udmGetItAPI;

interface

uses
  System.SysUtils, System.Classes, REST.Types, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, FireDAC.Stan.StorageBin;

type
  TdmGetItAPI = class(TDataModule)
    RESTClientGetIt: TRESTClient;
    RESTReqCatalogInfo: TRESTRequest;
    RESTRespCatalogInfo: TRESTResponse;
    RESTRespDSAdapterCatInfo: TRESTResponseDataSetAdapter;
    tblCatalogInfo: TFDMemTable;
    tblCatalogInfoId: TWideStringField;
    tblCatalogInfoName: TWideStringField;
    tblCatalogInfoVersion: TWideStringField;
    tblCatalogInfoDescription: TWideStringField;
    tblCatalogInfoVendor: TWideStringField;
    tblCatalogInfoVendorUrl: TWideStringField;
    tblCatalogInfoImage: TWideStringField;
    tblCatalogInfoIcon: TWideStringField;
    tblCatalogInfoTypeId: TWideStringField;
    tblCatalogInfoTypeDescription: TWideStringField;
    tblCatalogInfoTags: TWideStringField;
    tblCatalogInfoLibLicense: TWideStringField;
    tblCatalogInfoLibUrlProvider: TWideStringField;
    tblCatalogInfoLibCloudfrontUrl: TWideStringField;
    tblCatalogInfoLibAkamaiUrl: TWideStringField;
    tblCatalogInfoLibSignCloudfrontUrl: TWideStringField;
    tblCatalogInfoLibSignAkamaiUrl: TWideStringField;
    tblCatalogInfoLibProjectUrl: TWideStringField;
    tblCatalogInfoModified: TWideStringField;
    tblCatalogInfoLibLicenseName: TWideStringField;
    tblCatalogInfoState: TWideStringField;
    tblCatalogInfoPurchaseUrl: TWideStringField;
    tblCatalogInfoTargetPath: TWideStringField;
    tblCatalogInfoRequireElevation: TWideStringField;
    tblCatalogInfoAllUsers: TWideStringField;
    tblCatalogInfoLibSize: TWideStringField;
    tblCatalogInfoLibUrl: TWideStringField;
    tblCatalogInfoLibGenerateTmpUrl: TWideStringField;
    tblCatalogInfoLibCode: TWideStringField;
    tblCatalogInfoLibCodeName: TWideStringField;
    tblCatalogInfoCategories: TWideStringField;
    tblCatalogInfoLibPlatforms: TWideStringField;
    tblCatalogInfoLibOSes: TWideStringField;
    tblCatalogInfoProductVersions: TWideStringField;
    tblCatalogInfoActions: TWideStringField;
    tblCatalogInfoCompatibility: TWideStringField;
    tblCatalogInfoLicenseState: TWideStringField;
    RESTReqCategories: TRESTRequest;
    RESTRespCategories: TRESTResponse;
    RESTRespDSAdapterCategories: TRESTResponseDataSetAdapter;
    tblCategories: TFDMemTable;
    tblCategoriesId: TWideStringField;
    tblCategoriesName: TWideStringField;
    tblCategoriesNumElements: TWideStringField;
    RESTRespDSAdapterCatPlatforms: TRESTResponseDataSetAdapter;
    tblCatalogPlatforms: TFDMemTable;
    tblCatalogPlatformsId: TWideStringField;
    tblCatalogPlatformsName: TWideStringField;
    RESTRespDSAdapterCatOSes: TRESTResponseDataSetAdapter;
    tblCatalogOSes: TFDMemTable;
    tblCatalogOSesId: TWideStringField;
    tblCatalogOSesName: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    const
      DEFAULT_BASE_URL = 'https://getit-104.embarcadero.com:443';
      DEFAULT_CONNECT_TIMEOUT = 30000;
      DEFAULT_READ_TIMEOUT = 30000;
    procedure SetConnectTimeout(const Value: Integer);
    var
      FBaseURL: string;
      FConnectTimeout: Integer;
      FReadTimeout: Integer;
    procedure SetBaseURL(const Value: string);
    procedure SetReadTimeout(const Value: Integer);
  public
    procedure GetCatalogInfo(const SearchText: string; const CategoryIDs: string);
    function PkgPlatformsCSV: string;
    function PkgOpSystemsCSV: string;
    property BaseURL: string read FBaseURL write SetBaseURL;
    property ConnectTimeout: Integer read FConnectTimeout write SetConnectTimeout;
    property ReadTimeout: Integer read FReadTimeout write SetReadTimeout;
  end;

var
  dmGetItAPI: TdmGetItAPI;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmGetItAPI.DataModuleCreate(Sender: TObject);
begin
  BaseURL     := DEFAULT_BASE_URL;
  ReadTimeout := DEFAULT_READ_TIMEOUT;
end;

procedure TdmGetItAPI.GetCatalogInfo(const SearchText, CategoryIDs: string);
begin
  RESTReqCategories.Params.Clear;

  if SearchText.Length > 0 then
    RESTReqCatalogInfo.Params.AddItem('Search', SearchText);

  if CategoryIDs.Length > 0 then
    RESTReqCatalogInfo.Params.AddItem('Categories', CategoryIDs);

  RESTReqCatalogInfo.Execute;
end;

function TdmGetItAPI.PkgOpSystemsCSV: string;
begin
  Result := EmptyStr;
  if tblCatalogOSes.Active then begin
    tblCatalogOSes.First;
    while not tblCatalogOSes.Eof do begin
      if Result.Length > 0 then
        Result := Result + ', ';
      Result := Result + tblCatalogOSesName.AsString;
      tblCatalogOSes.Next;
    end;
  end;
end;

function TdmGetItAPI.PkgPlatformsCSV: string;
begin
  Result := EmptyStr;
  if tblCatalogPlatforms.Active then begin
    tblCatalogPlatforms.First;
    while not tblCatalogPlatforms.Eof do begin
      if Result.Length > 0 then
        Result := Result + ', ';
      Result := Result + tblCatalogPlatformsName.AsString;
      tblCatalogPlatforms.Next;
    end;
  end;
end;

procedure TdmGetItAPI.SetBaseURL(const Value: string);
begin
  FBaseURL := Value;
  RESTClientGetIt.BaseURL := FBaseURL;
end;

procedure TdmGetItAPI.SetConnectTimeout(const Value: Integer);
begin
  FConnectTimeout := Value;
  RESTClientGetIt.ConnectTimeout := FConnectTimeout;
  RESTReqCatalogInfo.ConnectTimeout := FConnectTimeout;
  RESTReqCategories.ConnectTimeout  := FConnectTimeout;
end;

procedure TdmGetItAPI.SetReadTimeout(const Value: Integer);
begin
  FReadTimeout := Value;
  RESTClientGetIt.ReadTimeout := FReadTimeout;
  RESTReqCatalogInfo.ReadTimeout := FReadTimeout;
end;

end.
