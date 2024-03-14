unit Server.Connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  Server.Constants,
  FireDAC.Comp.UI,
  FireDAC.Stan.Option,
  FireDAC.Stan.Pool,
  FireDAC.Phys.MSSQL {$IFDEF WINDOWS},

  Winapi.Messages,
  Vcl.Forms
{$ENDIF};

type
  TConnection = class
  private
    FQuery: TFDQuery;
    FDB: TFDConnection;
    Fdriver: TFDPhysMSSQLDriverLink;
  public
    property DB: TFDConnection read FDB write FDB;
    property Query: TFDQuery read FQuery write FQuery;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

uses
  Server.Config;

{ TConnection }

constructor TConnection.Create;
var

  LStrTemp: string;
begin
  try
    Fdriver := TFDPhysMSSQLDriverLink.Create(Nil);
    DB := TFDConnection.Create(nil);
    DB.ConnectionDefName := cConnectionDefName;
    DB.Connected := True;
    Query := TFDQuery.Create(nil);
    Query.Connection := DB;
  except
    on e: exception do
{$IFDEF LINUX}
      Writeln(' Excesscao ocorrida ao conectar banco de dados at ' + e.Message);
{$ENDIF}
  end;
end;

destructor TConnection.Destroy;
begin
  if assigned(Query) then
  begin
    Query.Close;
    Query.Free;
  end;
  if assigned(DB) then
  begin
    DB.Connected := False;
    DB.Free;
  end;
  if assigned(Fdriver) then
  begin
    FreeAndNil(Fdriver);
  end;
  inherited;
end;

end.
