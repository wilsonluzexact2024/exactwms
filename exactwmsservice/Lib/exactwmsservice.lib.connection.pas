unit exactwmsservice.lib.connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Comp.Client,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  // Posix.Base,
  // Posix.Fcntl;
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Stan.Async,
  FireDAC.UI.Intf,
  Data.DB,
  FireDAC.Comp.UI,
  FireDAC.Stan.Option,
  FireDAC.Comp.DataSet,
  FireDAC.Stan.Pool,
  exactwmsservice.lib.utils,
  FireDAC.Phys.MSSQL, Generics.Collections;

type
  TConnection = class
  private
    FQuery: TFDQuery;
    FSender: TObject;
    FDB: TFDConnection;
    Fdriver: TFDPhysMSSQLDriverLink;
    FtimeExecute: TTime;
    FtimeOpen: TTime;
    FtimeConnect: TTime;
    FListQuerys: TObjectList<TFDQuery>;
    procedure SetupQuery(Obj: TFDQuery);
    Function GetSender: String;

  public
    property DB: TFDConnection read FDB write FDB;
    property Sender: TObject read FSender write FSender;
    property Query: TFDQuery read FQuery write FQuery;
    constructor Create(TypeConnecion: Integer = 0);
    destructor Destroy; override;
    procedure FDQueryBeforeExecute(DataSet: TFDDataSet);
    procedure FDQueryAfterExecute(DataSet: TFDDataSet);
    procedure FDQueryBeforeOpen(DataSet: TDataSet);
    procedure FDQueryAfterOpen(DataSet: TDataSet);
    procedure ConnectionError(ASender, AInitiator: TObject;
      var AException: Exception);
    function GetQuery: TFDQuery;

    procedure DConnectionBeforeConnect(Sender: TObject);
    procedure OnLogin(AConnection: TFDCustomConnection;
      AParams: TFDConnectionDefParams);
    procedure DAfterforeConnect(Sender: TObject);

    procedure QueryError(ASender, AInitiator: TObject;
      var AException: Exception);
  end;

const
  _MaxTimeOut = 60000;

implementation

{ TConnection }
{ ------------------------------------------------------------------------------- }
procedure TConnection.ConnectionError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  Tutil.Gravalog(GetSender + ' Erro na conexao ' + AException.Message);
end;

constructor TConnection.Create(TypeConnecion: Integer = 0);
begin

  FListQuerys := TObjectList<TFDQuery>.Create();
  DB := TFDConnection.Create(nil);
  DB.FetchOptions.Unidirectional := true;
  DB.ResourceOptions.KeepConnection := true;
  DB.OnLogin := OnLogin;
  DB.OnError := ConnectionError;
  DB.ResourceOptions.SilentMode := true;
  DB.ResourceOptions.AutoReconnect := False;
  DB.BeforeConnect := DConnectionBeforeConnect;
  DB.AfterConnect := DAfterforeConnect;
  // criando sem pool - n�o funcina no modelo atual
  // Tutil.SetConection(DB, TypeConnecion);
  if TypeConnecion = 1 then
    DB.ConnectionDefName := _CTCONEXAOLOG
  else
    DB.ConnectionDefName := _CTCONEXAO;

  Query := TFDQuery.Create(nil);
  Query.connection := DB;
  SetupQuery(Query);
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.DAfterforeConnect(Sender: TObject);
begin
  // Tutil.Gravalog('  ' + GetSender + '  Conectado ao banco delay conexao: ' +
  // FormatDateTime('HH:mm:ss:zzz', Time - FtimeConnect));

end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.DConnectionBeforeConnect(Sender: TObject);
begin
  FtimeConnect := Time;

end;

{ ------------------------------------------------------------------------------- }
destructor TConnection.Destroy;
var
  I: Integer;
begin;

  // 'sysctl -w vm.drop_caches=3'

  DB.Connected := False;
  for I := 0 to pred(FListQuerys.Count) do
  begin
    try
      FListQuerys[I].close;
      FListQuerys[I].Free;
    except
      on e: Exception do
        Tutil.Gravalog('  ' + GetSender + ' Querry foi previamente liberada !');
    end;
  end;
  try
    if assigned(Query) then
    begin
      Query.close;
      Query.Free;
    end;
  except
  end;
  try
    if assigned(DB) then
    begin
      Db.Close ;
      DB.Connected := False;
      FreeAndNil(DB);
    end;
  except
  end;

  inherited;
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryAfterExecute(DataSet: TFDDataSet);
begin
  Tutil.Gravalog('  ' + GetSender + ' Comando executado ' +
    FormatDateTime('HH:mm:ss:zzz', Time - FtimeExecute));
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryAfterOpen(DataSet: TDataSet);
begin
  Tutil.Gravalog('   ' + GetSender + ' - Consulta executada: ' +
    FormatDateTime('HH:mm:ss:zzz', Time - FtimeOpen) + ' Registros: ' +
    inttostr(DataSet.RecordCount));
  DataSet.First;
end;
{ ------------------------------------------------------------------------------- }

procedure TConnection.FDQueryBeforeExecute(DataSet: TFDDataSet);
begin
  if (DataSet is TFDQuery) then
    Tutil.Gravalog('  ' + GetSender + ' Executando comando ' +
      copy(TFDQuery(DataSet).SQL.Text, 0, 100));
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryBeforeOpen(DataSet: TDataSet);
begin
  FtimeOpen := Time;
  // Tutil.Gravalog('Executando consulta ');
  Tutil.Gravalog('  ' + GetSender + ' Executando consulta ' +
    copy(TFDQuery(DataSet).SQL.Text, 0, 100));
end;

function TConnection.GetQuery: TFDQuery;
begin
  result := TFDQuery.Create(Nil);
  SetupQuery(result);
  FListQuerys.Add(result);
end;

function TConnection.GetSender: String;
begin
  result := '[SQLConexao]';
  if assigned(FSender) then
    result := '[SQLConexao]Sender-> ' + (FSender).ClassName;
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.OnLogin(AConnection: TFDCustomConnection;
  AParams: TFDConnectionDefParams);
begin

end;

procedure TConnection.QueryError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  Tutil.Gravalog('  ' + GetSender + ' Erro na execucao da query ->  ' +
    AException.Message);
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.SetupQuery(Obj: TFDQuery);
begin
  // {$DEFINE TESTEDEBUG}
  Obj.BeforeOpen := FDQueryBeforeOpen;
  Obj.BeforeExecute := FDQueryBeforeExecute;
  Obj.AfterOpen := FDQueryAfterOpen;
  Obj.AfterExecute := FDQueryBeforeExecute;
  Obj.connection := DB;
  Obj.ResourceOptions.SilentMode := true;
  Obj.connection.TxOptions.Isolation := xiReadCommitted;
  Obj.FetchOptions.Unidirectional := true;
  Obj.FetchOptions.Mode := fmAll;

  Obj.OnError := QueryError;
{$IFDEF TESTEDEUBG}
  Obj.FetchOptions.AutoFetchAll := afDisable;
  Obj.FetchOptions.RecsMax := 2 Obj.FetchOptions.RowsetSize := 20;;
{$ENDIF}
end;

{ ------------------------------------------------------------------------------- }
end.
