unit udmGetItCtrl;

interface

uses
  System.SysUtils, System.Classes, DosCommand;

type
  TdmGetitCtrl = class(TDataModule)
    DosCommand: TDosCommand;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmGetitCtrl: TdmGetitCtrl;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
