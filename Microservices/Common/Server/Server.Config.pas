unit Server.Config;

interface

uses
  System.IniFiles,
  Server.Constants,
  System.SysUtils,
  FireDAC.Comp.Client,
  System.Types,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Phys,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Comp.UI,
  Data.DB,
  FireDAC.Comp.DataSet,
  System.Classes,
  System.IOUtils,
  Server.Connection,
  Server.Utils.Criptografia;

type
  TServerConfig = class
  private
    FDManager: TFDManager;
    procedure ConfigDB;
    class var FInstance: TServerConfig;
  public
    class function GetInstance: TServerConfig;
  end;

implementation

{ TServer }

class function TServerConfig.GetInstance: TServerConfig;
begin
  if FInstance = nil then
  begin
    FInstance := TServerConfig.Create;
    FInstance.ConfigDB;
  end;
  Result := FInstance;
end;

procedure TServerConfig.ConfigDB;
var
  IniFile: TIniFile;
  Database: string;
  Server: string;
  UserName: string;
  Password: string;
  Params: TStrings;
  Driver: string;
  Spath: string;
  Port: integer;

begin
  Spath := ExtractFilePath(GetModuleName(HInstance)) + cConfigFileName;
  Params := TStringList.Create;
  if GetEnvironmentVariable('RHEMA_DB_HOST') <> '' then
  begin
    Params.Clear;
    Params.add('DriverID=MSSQL');
    Params.add('Server=' + GetEnvironmentVariable('RHEMA_DB_HOST'));
    Params.add('Database=' + GetEnvironmentVariable('RHEMA_DB_DATABASE'));
    Params.add('User_Name=' + GetEnvironmentVariable('RHEMA_DB_USER'));
    Params.add('POOL_MaximumItems=200');
    Params.add('Password=' + GetEnvironmentVariable('RHEMA_DB_PASSWORD'));
    Params.add('POOL_ExpireTimeout=1000');
    Params.add('POOL_CleanupTimeout=3000');
    Params.add('Pooled=True');
  end
  else
  begin
    if not FileExists(Spath) then
      Writeln('<<FATAL ERRO>> Arquivo de configuracao ou variaveis de ambiente não definidos '
        + Spath)
    else
      Writeln('Lendo config :' + Spath);
    IniFile := TIniFile.Create(Spath);
    try
      Server := IniFile.ReadString('BD', 'Server', '');
      Driver := IniFile.ReadString('BD', 'driver', ' MsSql');
      Database := IniFile.ReadString('BD', 'Database', '');
      UserName := IniFile.ReadString('BD', 'user', '');
      Password := IniFile.ReadString('BD', 'pwd', '');

      Params.AddPair('Server', Server);
      Params.AddPair('Database', Database);
      Params.AddPair('User_Name', UserName);
      Params.AddPair('Password', Password);
      Params.AddPair('Port', Port.ToString);
      Params.AddPair('Pooled', 'True');
      Params.AddPair('DriverID', 'MsSql');
    finally
      IniFile.Free;
    end;
  end;
  FInstance.FDManager := TFDManager.Create(nil);
  FInstance.FDManager.SilentMode := True;
  FInstance.FDManager.AddConnectionDef(cConnectionDefName, 'MsSql', Params);
  Writeln('Configuracao Server:' + Server + ' Db ' + Database + ' User ' +
    UserName);
end;

end.
