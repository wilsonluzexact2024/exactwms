unit exactwmsservice.lib.utils;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  System.Threading,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.ConsoleUI.Wait,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  System.JSON,
  IniFiles,
  FireDAC.Phys.MSSQLDef,
  FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSSQL,
  Web.HTTPApp,
  FireDAC.Comp.UI;

type
  Tutil = class
    class procedure SetConectionsDef;
    class function ServerBd: String;
    class procedure SalvarLog(pMethod: TMethodType; pUsuarioId: Integer;
      pTerminal, pIpClient: String; pPort: Integer;
      pUrl, pParams, pBody, pResponseStr: String; pResponseJson: AnsiString;
      pRespStatus: Integer; pTimeExecution: Double; pAppName: String);
    class procedure Gravalog(mensagem: string);
    class procedure SetConection(Conection: TFDConnection;
      TypeConnection: Integer = 0);
    class function EncerarConexoesInativas: string;

  end;

const
  _CTCONEXAO = 'EVOLUTIONSERVICE';

const
  _CTCONEXAOLOG = 'EXACTWMSDBLOG';

  _SQLKILL = 'DECLARE @query VARCHAR(MAX) = ''''' + #13#10 + 'SELECT' + #13#10 +
    '   @query = COALESCE(@query, '','') + ''KILL '' + CONVERT(VARCHAR, spid) + ''; '''
    + #13#10 + 'FROM' + #13#10 + '    master..sysprocesses                    '
    + #13#10 + 'WHERE                                       ' + #13#10 +
    '   dbid = DB_ID(''%s'')      ' + #13#10 +
    '    AND dbid > 4                            ' + #13#10 +
    '    AND spid <> @@SPID                      ' + #13#10 +
    '	   AND program_name = ''%s''' + #13#10 +
    '  	 AND status   =''sleeping''              ' + #13#10 +

    'IF (LEN(@query) > 0)                        ' + #13#10 +
    '    EXEC(@query) ';

implementation

uses
  exactwmsservice.lib.connection;

{ Tutil }

class procedure Tutil.SetConection(Conection: TFDConnection;
  TypeConnection: Integer = 0);
var
  ArqIni: TIniFile;
  OParams: Tstrings;
begin
  OParams := TStringList.Create;
  try
    if GetEnvironmentVariable('RHEMA_DB_HOST') <> '' then
    begin
      if TypeConnection = 0 then
      begin
        OParams.Clear;
        OParams.add('DriverID=MSSQL');
        OParams.add('Server=' + GetEnvironmentVariable('RHEMA_DB_HOST'));
        OParams.add('ApplicationName=EVOLUTIONSERVICE_API');
        OParams.add('Database=' + GetEnvironmentVariable('RHEMA_DB_DATABASE'));
        OParams.add('User_Name=' + GetEnvironmentVariable('RHEMA_DB_USER'));
        OParams.add('POOL_MaximumItems=200');
        OParams.add('Password=' + GetEnvironmentVariable('RHEMA_DB_PASSWORD'));
        OParams.add('POOL_ExpireTimeout=1000');
        OParams.add('POOL_CleanupTimeout=3000');
        // OParams.add('Pooled=True');
        Conection.Params.Text := OParams.Text;
        Conection.Params.DriverID := 'MSSQL';
        OParams.Clear;
      end
      else
      begin
        OParams.add('DriverID=MSSQL');
        OParams.add('Server=' + GetEnvironmentVariable('RHEMA_DB_LOG_HOST'));
        OParams.add('ApplicationName=EVOLUTIONSERVICE_API');
        OParams.add('Database=' + GetEnvironmentVariable
          ('RHEMA_DB_LOG_DATABASE'));
        OParams.add('User_Name=' + GetEnvironmentVariable('RHEMA_DB_LOG_USER'));
        OParams.add('POOL_MaximumItems=200');
        OParams.add('POOL_ExpireTimeout=5000');
        OParams.add('Password=' + GetEnvironmentVariable
          ('RHEMA_DB_LOG_PASSWORD'));
        // OParams.add('Pooled=True');
        Conection.Params.Text := OParams.Text;
        Conection.Params.DriverID := 'MSSQL';
      end;
    end
    else
    begin
      if not fileexists(ExtractFilePath(GetModuleName(HInstance)) +
        'eXactWMS.ini') then
      Begin
        Writeln('[Provider.Connection]Erro : [não encotrado arquivo de configuracao] '
          + ExtractFilePath(GetModuleName(HInstance)));
        exit;
      end;
      ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) +
        'eXactWMS.ini');
      if TypeConnection = 0 then
      begin
        OParams.Clear;
        OParams.add('DriverID=' + ArqIni.ReadString('BD', 'Driver', 'MSSQL'));
        OParams.add('Server=' + ArqIni.ReadString('BD', 'Server', 'locahost'));
        OParams.add('ApplicationName=EVOLUTIONSERVIC_LOG');
        OParams.add('Database=' + ArqIni.ReadString('BD', 'DataBase',
          'eXactWMS'));
        OParams.add('User_Name=' + ArqIni.ReadString('BD', 'user', 'sa'));
        OParams.add('Password=' + ArqIni.ReadString('BD', 'pwd', 'Ctpd$#*%0'));
        Conection.Params.Text := OParams.Text;
        Conection.Params.Database := ArqIni.ReadString('BD', 'DataBase',
          'eXactWMS');
        Conection.Params.UserName := ArqIni.ReadString('BD', 'user', 'sa');
        Conection.Params.DriverID := 'MSSQL';
      end
      else
      begin
        OParams.Clear;
        OParams.add('DriverID=' + ArqIni.ReadString('BDLOG', 'Driver',
          'MSSQL'));
        OParams.add('Server=' + ArqIni.ReadString('BDLOG', 'Server',
          'locahost'));
        OParams.add('ApplicationName=EVOLUTIONSERVICE_LOG');
        OParams.add('Database=' + ArqIni.ReadString('BDLOG', 'DataBase',
          'eXactWMS'));
        OParams.add('User_Name=' + ArqIni.ReadString('BDLOG', 'user', 'sa'));
        OParams.add('Password=' + ArqIni.ReadString('BDLOG', 'pwd',
          'Ctpd$#*%0'));
        Conection.Params.Text := OParams.Text;
        Conection.Params.Database := ArqIni.ReadString('BDLOG', 'DataBase',
          'eXactWMS');
        Conection.Params.UserName := ArqIni.ReadString('BDLOG', 'user', 'sa');
        Conection.Params.DriverID := 'MSSQL';
      end;
    end;
  finally
    if assigned(ArqIni) then
      FreeAndNil(ArqIni);
    if assigned(OParams) then
      FreeAndNil(OParams)
  end;
end;

{ ----------------------------------------------------------------------------- }
class procedure Tutil.SetConectionsDef;
var
  ArqIni: TIniFile;
  OParams: Tstrings;
begin
  if GetEnvironmentVariable('RHEMA_DB_HOST') <> '' then
  begin
    Writeln('Geting enviroment variables...');
    OParams := TStringList.Create;
    try
      OParams.Clear;
      OParams.add('DriverID=MSSQL');
      OParams.add('Server=' + GetEnvironmentVariable('RHEMA_DB_HOST'));
      OParams.add('ApplicationName=EVOLUTIONSERVICE');
      OParams.add('Database=' + GetEnvironmentVariable('RHEMA_DB_DATABASE'));
      OParams.add('User_Name=' + GetEnvironmentVariable('RHEMA_DB_USER'));
      OParams.add('POOL_MaximumItems=200');
      OParams.add('Password=' + GetEnvironmentVariable('RHEMA_DB_PASSWORD'));
      OParams.add('POOL_ExpireTimeout=1000');
      OParams.add('POOL_CleanupTimeout=3000');
      OParams.add('Pooled=True');
      Writeln('Servidor DB Host: ' + GetEnvironmentVariable('RHEMA_DB_HOST'));
      Writeln('Servidor DB Database: ' + GetEnvironmentVariable
        ('RHEMA_DB_DATABASE'));
      Writeln('Servidor User: ' + GetEnvironmentVariable('RHEMA_DB_USER'));
      try
        if not assigned(FDManager.ConnectionDefs.FindConnectionDef(_CTCONEXAO))
        then
          FDManager.AddConnectionDef(_CTCONEXAO, 'MSSQL', OParams);

      except
      end;
      OParams.Clear;

      OParams.add('DriverID=MSSQL');
      OParams.add('Server=' + GetEnvironmentVariable('RHEMA_DB_LOG_HOST'));
      OParams.add('ApplicationName=EVOLUTIONSERVICE');
      OParams.add('Database=' + GetEnvironmentVariable
        ('RHEMA_DB_LOG_DATABASE'));
      OParams.add('User_Name=' + GetEnvironmentVariable('RHEMA_DB_LOG_USER'));
      OParams.add('POOL_MaximumItems=200');
      OParams.add('POOL_ExpireTimeout=5000');
      OParams.add('Password=' + GetEnvironmentVariable
        ('RHEMA_DB_LOG_PASSWORD'));
      OParams.add('Pooled=True');
      try
        if not assigned(FDManager.ConnectionDefs.FindConnectionDef
          (_CTCONEXAOLOG)) then
          FDManager.AddConnectionDef(_CTCONEXAOLOG, 'MSSQL', OParams);
      except
      end;
    finally
      FreeAndNil(OParams);
    end;
    exit;
  end;
  if not fileexists(ExtractFilePath(GetModuleName(HInstance)) + 'eXactWMS.ini')
  then
  Begin
    Writeln('[Provider.Connection]Erro : [não encotrado arquivo de configuracao] '
      + ExtractFilePath(GetModuleName(HInstance)));
    exit;
  end;
  Try
    ArqIni := TIniFile.Create(ExtractFilePath(GetModuleName(HInstance)) +
      'eXactWMS.ini');
    OParams := TStringList.Create;
    try
      OParams.Clear;
      OParams.add('DriverID=' + ArqIni.ReadString('BD', 'Driver', 'MSSQL'));
      OParams.add('Server=' + ArqIni.ReadString('BD', 'Server', 'locahost'));
      OParams.add('ApplicationName=EVOLUTIONSERVICE');
      OParams.add('Database=' + ArqIni.ReadString('BD', 'DataBase',
        'eXactWMS'));
      OParams.add('User_Name=' + ArqIni.ReadString('BD', 'user', 'sa'));
      OParams.add('POOL_MaximumItems=200');
      OParams.add('Password=' + ArqIni.ReadString('BD', 'pwd', 'Ctpd$#*%0'));
      OParams.add('Pooled=True');
      OParams.add('POOL_ExpireTimeout=100');
      OParams.add('POOL_CleanupTimeout=300');
      Writeln('Servidor DB: ' + ArqIni.ReadString('BD', 'Server', 'locahost'));
      try
        if not assigned(FDManager.ConnectionDefs.FindConnectionDef(_CTCONEXAO))
        then
          FDManager.AddConnectionDef(_CTCONEXAO, 'MSSQL', OParams);
      except
      end;
      OParams.Clear;
      OParams.add('DriverID=' + ArqIni.ReadString('BDLOG', 'Driver', 'MSSQL'));
      OParams.add('Server=' + ArqIni.ReadString('BDLOG', 'Server', 'locahost'));
      OParams.add('ApplicationName=EVOLUTIONSERVICE');
      OParams.add('Database=' + ArqIni.ReadString('BDLOG', 'DataBase',
        'eXactWMS'));
      OParams.add('User_Name=' + ArqIni.ReadString('BDLOG', 'user', 'sa'));
      OParams.add('POOL_MaximumItems=200');
      OParams.add('POOL_ExpireTimeout=1000');
      OParams.add('POOL_CleanupTimeout=3000');
      OParams.add('Password=' + ArqIni.ReadString('BDLOG', 'pwd', 'Ctpd$#*%0'));
      OParams.add('Pooled=True');
      try
        if not assigned(FDManager.ConnectionDefs.FindConnectionDef
          (_CTCONEXAOLOG)) then
          FDManager.AddConnectionDef(_CTCONEXAOLOG, 'MSSQL', OParams);
      except
      end;
    finally
      FreeAndNil(OParams);
    end;
  Finally
    FreeAndNil(ArqIni);
  End;
end;

{ ----------------------------------------------------------------------------- }
class procedure Tutil.SalvarLog(pMethod: TMethodType; pUsuarioId: Integer;
  pTerminal, pIpClient: String; pPort: Integer;
  pUrl, pParams, pBody, pResponseStr: String; pResponseJson: AnsiString;
  pRespStatus: Integer; pTimeExecution: Double; pAppName: String);

begin
  TTask.Create(
    procedure()
    Var
      vMethod: String;
      Lconnection: Tconnection;
      LjsonValue: TJSONValue;
    begin
      Lconnection := Tconnection.Create(1);
      Try
        try
          If length(pParams) > 1000 then
            pParams := Copy(pParams, 1, 1000);
          If length(pBody) > 4000 then
            pBody := Copy(pBody, 1, 4000);
          If length(pResponseStr) > 1000 then
            pResponseStr := Copy(pResponseStr, 1, 1000);
          If length(pResponseJson) > 8000 then
            pResponseJson := Copy(pResponseJson, 1, 8000);
          pResponseJson := StringReplace(pResponseJson, #39, #34,
            [rfReplaceAll]);

          case pMethod of
            mtAny:
              vMethod := 'Any';
            mtGet:
              vMethod := 'Get';
            mtPut:
              vMethod := 'Put';
            mtPost:
              vMethod := 'Post';
            mtHead:
              vMethod := 'Head';
            mtDelete:
              vMethod := 'Delete';
            mtPatch:
              vMethod := 'Patch';
          end;
          LjsonValue := TJSONObject.ParseJSONValue(pBody);
          if pBody = '' then
            pBody := '[]'
          Else
          begin
            if (LjsonValue Is TJSONObject) or (LjsonValue Is TJsonArray) then
            Else
            Begin
              // pParams := Copy(pBody, 1, 1000);
              pBody := '[]';
            End;
          end;
          If pResponseJson = '' then
            pResponseJson := 'Null'
          Else
          Begin
            if (LjsonValue Is TJsonArray) then
            Begin
              if (LjsonValue as TJsonArray).Count > 1 then
              Begin
                pResponseStr := 'Retorno: ' +
                  (TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes
                  (pResponseJson), 0) as TJsonArray).Count.ToString +
                  ' Registros.';
                pResponseJson := '[]';
              End;
            End
            Else if (LjsonValue Is TJSONObject) then
            Begin
              if (LjsonValue as TJSONObject).Count > 1 then
              Begin
                pResponseStr := 'Retorno: ' + (LjsonValue as TJSONObject)
                  .Count.ToString + ' Registros.';
                pResponseJson := '[]';
              End;
            End
            Else
            Begin
              pResponseStr := pResponseJson;
              pResponseJson := '[]'
            End;
          End;
          Lconnection.Query.SQL.add
            ('Insert into RequestResponse (data,	hora,	usuarioid,	terminal,	verbo	,'
            + sLineBreak +
            '            ipclient,	Port,	url,	params, body,	responsestr,	responsejson, '
            + sLineBreak +
            '           	respstatus,	timeexecution) Values (GetDate(), GetDate(), '
            + '      ' + pUsuarioId.ToString() + ', ' + #39 + pTerminal + #39 +
            ', ' + #39 + vMethod + #39 + ', ' + '      ' + #39 + pIpClient + #39
            + ', ' + pPort.ToString() + ', ' + #39 + pUrl + #39 + ', ' +
            '      :pParams, :pBody, ' + #39 + Copy(pResponseStr, 1, 3000) + #39
            + ', ' + '      :pResponseJson, ' +

            pRespStatus.ToString() + ', ' +
            StringReplace(pTimeExecution.ToString(), ',', '.', [rfReplaceAll]) +

            ')');

          Lconnection.Query.ParamByName('pParams').Value := pParams;
          Lconnection.Query.ParamByName('pBody').Value := pBody;
          Lconnection.Query.ParamByName('pResponseJson').AsAnsiString :=
            pResponseJson;

          Lconnection.Query.ExecSQL;
        Except
          on e: exception do
            Tutil.Gravalog('ERRO AO GRAVAR LOG DB ' + e.Message);

        End;
      Finally
        try
          vMethod := '';
          pUrl := '';
          pParams := '';
          pBody := '';
          pResponseStr := '';
          pResponseJson := '';
          Lconnection.Query.Close;
        except
        end;
        try
          if assigned(LjsonValue) then
            LjsonValue.Free;
        except
        end;
        try
          Lconnection.DB.Close;
        except
        end;
        FreeAndNil(Lconnection);
      End;
    end).Start;
end;

{ ----------------------------------------------------------------------------- }
class function Tutil.EncerarConexoesInativas: string;
var
  LmessageErro: String;
  procedure Exececute(Value: Integer);
  var
    ConexaoP: TFDConnection;
    Lsql: string;
  begin
    { ConexaoP := TFDConnection.Create(Nil);
      try
      try
      Tutil.SetConection(ConexaoP, Value);
      Lsql := Format(_SQLKILL, [ConexaoP.Params.Database,
      ConexaoP.Params.Values['ApplicationName']]);
      ConexaoP.Params.Values['ApplicationName'] := 'EXMANUT1';
      ConexaoP.ExecSQL(Lsql);
      except
      on e: exception do
      LmessageErro := LmessageErro + '  ' + e.Message;
      end;
      finally
      FreeAndNil(ConexaoP);
      end;
      end; }
  end;

begin
  {
    LmessageErro := '';
    Exececute(0);
    Exececute(1);
    if LmessageErro = '' then
    Result := 'Comando executado '
    else
    Result := 'Houve erros na execução ' + LmessageErro
    ?
  }
end;

class procedure Tutil.Gravalog(mensagem: string);
begin
  Try
    TTask.Create(
      procedure()
      var
        p: string;
        F: TextFile;
        LSaida: string;
      begin
        LSaida := FormatDateTime('hh:nn:ss.zzz', now) + ' - ' + mensagem;
        Writeln(LSaida);
        try
          try
            p := ExtractFilePath(ParamStr(0)) + 'log' + PathDelim;
            ForceDirectories(p);
            p := p + FormatDateTime('yyyymmdd', now) + '_' +
              ChangeFileExt(ExtractFileName(ParamStr(0)), '') + '.log';
            AssignFile(F, p);
            if not fileexists(p) then
              Rewrite(F)
            else
              Append(F);
            Writeln(F, LSaida);
          except
          end;
        finally
          Closefile(F);
        end;
        LSaida := '';

      End).Start;

  except
  end;
end;

{ ----------------------------------------------------------------------------- }
class function Tutil.ServerBd: String;
Var
  ArqIni: TIniFile;
  LserverHost: string;
  Ldatabase: string;
begin
  if GetEnvironmentVariable('RHEMA_DB_HOST') <> '' then
  begin
    LserverHost := GetEnvironmentVariable('RHEMA_DB_HOST');
    Ldatabase := GetEnvironmentVariable('RHEMA_DB_DATABASE');
  end
  else
  begin
    ArqIni := TIniFile.Create((ExtractFilePath(GetModuleName(HInstance)) +
      'eXactWMS.ini'));
    LserverHost := ArqIni.ReadString('BD', 'Server', 'locahost');
    Ldatabase := ArqIni.ReadString('BD', 'DataBase', 'eXactWMS_NotDefined');
    FreeAndNil(ArqIni)
  End;
  Result := 'Servidor: ' + LserverHost;
  Result := Result + '  Bd: ' + Ldatabase;
end;

end.
