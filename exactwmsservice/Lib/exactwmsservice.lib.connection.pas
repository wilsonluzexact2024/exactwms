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
  TConnection = class(TComponent)
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
    function FormatQuery(value: string): string;
  end;

const
  _MaxTimeOut = 60000;

implementation

{ TConnection }
{ ------------------------------------------------------------------------------- }
procedure TConnection.ConnectionError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  try
    var
    Lmessage := AException.Message;
    var
    Lsender := GetSender;
    Tutil.Gravalog('               ->' + Lsender + ' Erro na conexao ' +
      Lmessage);
  except
  end;
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
  Tutil.SetConection(DB, TypeConnecion);
  {
    if TypeConnecion = 1 then
    DB.ConnectionDefName := _CTCONEXAOLOG
    else
    DB.ConnectionDefName := _CTCONEXAO;
  }
  Query := TFDQuery.Create(nil);
  Query.connection := DB;
  SetupQuery(Query);
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.DAfterforeConnect(Sender: TObject);
begin

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
  for I := 0 to pred(FListQuerys.Count) do
  begin
    try
      FListQuerys[I].close;
      FreeAndNil(FListQuerys[I]);
    except
      on e: Exception do
      begin
        var
        Lsender := GetSender;
        Tutil.Gravalog('          ->' + Lsender +
          ' Querry foi previamente liberada !');
      end;
    end;
  end;
  try
    FListQuerys.Destroy;
  except

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
      DB.close;
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

end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryAfterOpen(DataSet: TDataSet);

begin
  var
  Lsender := GetSender;
  try

    // var Ltext := TFDQuery(DataSet).sql.text;
    var
    Lrecords := DataSet.RecordCount;
    Tutil.Gravalog('          -> ' + Lsender + ' - Consulta executada: ' +
      FormatDateTime('HH:mm:ss:zzz', Time - FtimeOpen) + ' Registros: ' +
      inttostr(Lrecords));

    if DataSet.RecordCount > 500 then
      Tutil.Gravalog('          ->' + Lsender +
        '< Warning > Limit Records  ! ');

    DataSet.First;
  except
  end;
end;
{ ------------------------------------------------------------------------------- }

procedure TConnection.FDQueryBeforeExecute(DataSet: TFDDataSet);
begin
  try
    var
    Lsender := GetSender;
    var
    Ltext := TFDQuery(DataSet).sql.text;
    if (DataSet is TFDQuery) then
      Tutil.Gravalog('          ' + Lsender + ' Executando comando ' + #13#10 +
        FormatQuery(Ltext));
  except
  end;
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.FDQueryBeforeOpen(DataSet: TDataSet);
begin
  FtimeOpen := Time;
  try
    var
    Lsender := GetSender;
    var
    Ltext := TFDQuery(DataSet).sql.text;
    Tutil.Gravalog('          ->' + Lsender + ' Executando consulta ' + #13#10 +
      FormatQuery(trim(Ltext)));
  Except
  end;
end;

function TConnection.FormatQuery(value: string): string;
var
  I: Integer;
begin
  var
  Lts := TStringList.Create;
  try
    Lts.text := value;
    for I := 0 to pred(Lts.Count) do
    begin
      Lts[I] := '     ' + LowerCase(Lts[I]);
    end;
    Result := Lts.text;
  finally
    FreeAndNil(Lts);
  end;
end;

function TConnection.GetQuery: TFDQuery;
begin
  Result := TFDQuery.Create(Self);
  SetupQuery(Result);
  FListQuerys.Add(Result);
end;

function TConnection.GetSender: String;
begin
  Result := '[SQLConexao]';
  Try
    if assigned(FSender) then
      Result := '[SQLConexao]Sender-> ' + (FSender).ClassName;
  except
  End;
end;

{ ------------------------------------------------------------------------------- }
procedure TConnection.OnLogin(AConnection: TFDCustomConnection;
  AParams: TFDConnectionDefParams);
begin

end;

procedure TConnection.QueryError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  var
  Lsender := GetSender;
  var
  Lmessage := AException.Message;
  try
    Tutil.Gravalog('          ->' + Lsender + ' Erro na execucao da query ->  '
      + Lmessage);
  except

  end;
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
