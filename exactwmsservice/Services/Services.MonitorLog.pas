unit Services.MonitorLog;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection;

type
  TServiceMonitorLog = class
  private
    { Private declarations }
    FConexao: TConnection;
  public
    { Public declarations }
    Function GetListaLog(pIdReq, pUsuarioId: Integer;
      pDataInicial, pDataFinal: TDateTime; pTerminal, pIpClient, pPorta: String;
      pStatusCode: Integer; pUrl: String): TjSonArray;
    Function DeleteLog(pIdReq: Integer): TjSonArray;
    constructor Create;
    destructor Destroy; override;
  end;

var
  ServiceMonitorLog: TServiceMonitorLog;

implementation

uses Constants, IniFiles;

constructor TServiceMonitorLog.Create;
begin
  FConexao := TConnection.Create(1);
end;

function TServiceMonitorLog.DeleteLog(pIdReq: Integer): TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.Sql.Add('Delete RequestResponse where IdReq = ' +
      pIdReq.ToString());
    FConexao.Query.ExecSql;
    Result.AddElement(TJsonObject.Create.AddPair('Ok',
      'Registro(' + pIdReq.ToString() + ') exclu�do com sucesso!'));
    FConexao.DB.Connected := False;
  Except
    ON E: Exception do
    Begin
      FConexao.DB.Connected := False;
      Raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TServiceMonitorLog.Destroy;
begin

  FConexao.Free;
  inherited;
end;

function TServiceMonitorLog.GetListaLog(pIdReq, pUsuarioId: Integer;
  pDataInicial, pDataFinal: TDateTime; pTerminal, pIpClient, pPorta: String;
  pStatusCode: Integer; pUrl: String): TjSonArray;
var
  JsonRetorno: TJsonObject;
  FIndexConnExact: Integer;

  ArqIni: TIniFile;
  BdeXactWMS: String;
begin
  Result := TjSonArray.Create;
  try
    if fileexists(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.Ini')
    then
    Begin
      ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) +
        'eXactWMS.Ini');
      BdeXactWMS := ArqIni.ReadString('BD', 'DataBase', 'eXactWMSBad');
      ArqIni.Free;
    End
    Else
      raise Exception.Create
        ('Arquivo de configura��o do banco de dados inexistente!');
    FConexao.Query.Sql.Add('select RR.*, U.Nome, RR.RespStatus As statuscode');
    FConexao.Query.Sql.Add('From RequestResponse RR');
    FConexao.Query.Sql.Add('Left Join ' + BdeXactWMS +
      '.Dbo.Usuarios U On U.UsuarioId = RR.UsuarioId');
    FConexao.Query.Sql.Add('Where 1=1');
    If pIdReq <> 0 then
    Begin
      FConexao.Query.Sql.Add(' And RR.IdReq = :pIdReq');
      FConexao.Query.ParamByName('pIdReq').Value := pIdReq;
    End;
    If pUsuarioId <> 0 then
    Begin
      FConexao.Query.Sql.Add(' And RR.UsuarioId = :pUsuarioId');
      FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    End;
    If pDataInicial <> 0 Then
    Begin
      FConexao.Query.Sql.Add(' And RR.Data >= :pDataInicial');
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicial);
    End;
    If pDataFinal <> 0 Then
    Begin
      FConexao.Query.Sql.Add(' And RR.Data <= :pDataFinal');
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFinal);
    End;
    If pTerminal <> '' Then
    Begin
      FConexao.Query.Sql.Add(' And RR.Terminal like :pTerminal');
      FConexao.Query.ParamByName('pTerminal').Value := '%' + pTerminal + '%';
      FConexao.Query.Sql.Add('--pTerminal = ' + '%' + pTerminal + '%');
    End;
    If pPorta <> '' Then
    Begin
      FConexao.Query.Sql.Add(' And RR.Port = :pPort');
      FConexao.Query.ParamByName('pPort').Value := pPorta;
    End;
    If pStatusCode <> 0 Then
    Begin
      FConexao.Query.Sql.Add(' And RR.Status = :pStatus');
      FConexao.Query.ParamByName('pStatus').Value := pStatusCode;
    End;
    If pUrl <> '' Then
    Begin
      FConexao.Query.Sql.Add(' And RR.Url like :pUrl');
      FConexao.Query.ParamByName('pUrl').Value := '%' + pUrl + '%';
      FConexao.Query.Sql.Add('--pUrl = ' + '%' + pUrl + '%');
    End;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('MonitorLog.Sql');
    FConexao.Query.Open;
    if FConexao.Query.Isempty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        tuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
      FConexao.DB.Connected := False;
    End;
  end;
end;

end.
