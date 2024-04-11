{
  VolumeEmbalagemCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.CargasDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.Types, System.JSON, REST.JSON, System.JSON.Types, FireDAC.Stan.Option,
  System.Generics.Collections, CargasClass, Web.HTTPApp,
  exactwmsservice.lib.utils, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TCargasDAO = class(TBasicDao)
  private
    FCargaDAO: TCargas;
    Function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  Public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(Const pCargaId: Integer; pJsonObject: TJsonObject)
      : TJSonArray;
    // (pVolumeEmbalagemId : Integer; pDescricao : String; pStatus : Integer ) : TjSonArray;
    function Get(Const AParams: TDictionary<string, string>): TJSonArray;
    Function Get4D(const AParams: TDictionary<string, string>): TJsonObject;
    Function GetCargaCarregarClientes(Const pCarga: Integer): TJSonArray;
    Function GetCargaCarregarPedidos(Const pCarga: Integer): TJSonArray;
    Function GetCargaCarregarVolumes(Const pCarga, pPessoaId: Integer;
      pProcesso: String): TJSonArray;
    Function Delete(pCargaId: Integer; pJsonObject: TJsonObject): Boolean;
    Function CargaCarregamento(pJsonObject: TJsonObject): TJsonObject;
    Function CargaCarregamentoFinalizar(pJsonObject: TJsonObject): TJsonObject;
    Function CancelarCarregamento(Const pCargaId: Integer): TJsonObject;
    Function CancelarConferencia(Const pCargaId: Integer): TJsonObject;
    Function CancelarCarga(pJsonObject: TJsonObject): TJsonObject;
    Property ObjCarga: TCargas Read FCargaDAO Write FCargaDAO;
    Function GetCargaHearder(pCargaId: Integer): TJSonArray;
    Function GetCargaPessoas(pCargaId: Integer): TJSonArray;
    Function GetCargaPedidos(pCargaId, pPessoaId: Integer; pProcesso: String)
      : TJSonArray;
    Function GetCargaPedidosRomaneio(pCargaId, pPessoaId: Integer;
      pProcesso: String): TJSonArray;
    Function GetCargaNotaFiscal(pCargaId: Integer): TJSonArray;
    Function GetCargaPedidoVolumes(pCargaId: Integer; pProcesso: String)
      : TJSonArray;
    Function CargaLista(pCargaId, pRotaId, pProcessoId, pPendente: Integer)
      : TJSonArray;
    Function GetResumoCarga(const AParams: TDictionary<string, string>)
      : TJSonArray;
    function GetMapaCarga(pCargaId: Integer): TJSonArray;
    Function PedidosParaCargas(Const AParams: TDictionary<string, string>)
      : TJSonArray;
    Function PedidosParaCargasNFs(Const AParams: TDictionary<string, string>)
      : TJSonArray;
    Function GetRelAnaliseConsolidada(Const AParams
      : TDictionary<string, string>): TJSonArray;
    Function PutAtualizarStatus(Const pJsonObjectCargas: TJsonObject)
      : TJSonArray;

  end;

implementation

uses uSistemaControl, Constants, System.Math;

{ TClienteDao }

function TCargasDAO.CancelarCarga(pJsonObject: TJsonObject): TJsonObject;
var
  vSql: String;
Begin
  try
    FConexao.Query.SQL.Add
      ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Cargas where CargaId = :pCargaId)');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    // FConexao.Query.Sql.Add('Update Pedido set CargaId = Null where CargaId = '+pJsonObject.GetValue<Integer>('cargaid').ToString());
    // FConexao.Query.Sql.Add('Update CargaPedidos Set Conferido = 0 Where CargaId = '+pCargaId.ToString);
    FConexao.Query.ParamByName('pCargaId').Value :=
      pJsonObject.GetValue<Integer>('cargaid');
    FConexao.Query.ParamByName('pProcessoId').Value := 21;
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      pJsonObject.GetValue<Integer>('usuarioid');
    FConexao.Query.ParamByName('pTerminal').Value :=
      pJsonObject.GetValue<String>('terminal', '');
    FConexao.Query.ExecSQL(vSql);
    Result := TJsonObject.Create.AddPair('Ok', '200');
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CancelarCarregamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCargasDAO.CancelarCarregamento(const pCargaId: Integer): TJsonObject;
var
  vSql: String;
Begin
  try
    FConexao.Query.SQL.Add('Delete from CargaCarregamento where CargaId = ' +
      pCargaId.ToString + ' and Processo = ' + QuotedStr('CA'));
    FConexao.Query.SQL.Add
      ('Update CargaPedidos Set Conferido = 0 Where CargaId = ' +
      pCargaId.ToString);
    FConexao.Query.ExecSQL(vSql);
    Result := TJsonObject.Create.AddPair('Ok', '200');
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CancelarCarregamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCargasDAO.CancelarConferencia(const pCargaId: Integer): TJsonObject;
var
  vSql: String;
Begin
  try
    FConexao.Query.SQL.Add('Delete from CargaCarregamento where CargaId = ' +
      pCargaId.ToString + ' and Processo = ' + QuotedStr('CO'));
    FConexao.Query.SQL.Add
      ('Update CargaPedidos Set Conferido = 0 Where CargaId = ' +
      pCargaId.ToString);
    FConexao.Query.ExecSQL(vSql);
    Result := TJsonObject.Create.AddPair('Ok', '200');
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CancelarConferência - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCargasDAO.CargaCarregamento(pJsonObject: TJsonObject): TJsonObject;
var
  vSql: String;
begin
  try
    vSql := 'Declare @CargaId Integer = ' + pJsonObject.GetValue<Integer>
      ('cargaid').ToString() + sLineBreak + 'Declare @PedidoVolumeId Integer = '
      + pJsonObject.GetValue<Integer>('pedidovolumeid').ToString() + sLineBreak
      + 'Declare @PedidoId Integer = (Select PedidoId From PedidoVolumes' +
      sLineBreak +
      '                             Where PedidoVolumeId = @PedidoVolumeId)' +
      sLineBreak +
      'Insert Into CargaCarregamento (Cargaid, PedidoVolumeId, UsuarioId, Data, Hora, Terminal, Processo) Values ('
      + sLineBreak + pJsonObject.GetValue<Integer>('cargaid').ToString() + ', '
      + pJsonObject.GetValue<Integer>('pedidovolumeid').ToString() + ', ' +
      pJsonObject.GetValue<Integer>('usuarioid').ToString() + ', ' +
      ' GetDate(), GetDate(), ' +
      QuotedStr(pJsonObject.GetValue<String>('terminal')) + ', ' +
      QuotedStr(pJsonObject.GetValue<String>('processo')) + ')';
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.SQL.Add('Update Cp Set Conferido = 1');
    FConexao.Query.SQL.Add('From CargaPedidos Cp');
    FConexao.Query.SQL.Add
      ('Left Join (select Pv.PedidoId, Pv.PedidoVolumeId, CC.PedidoVolumeId VlmConferido');
    FConexao.Query.SQL.Add('			        From PedidoVolumes Pv');
    FConexao.Query.SQL.Add
      ('			        inner Join vDocumentoEtapas De ON De.Documento = Pv.Uuid');
    FConexao.Query.SQL.Add
      ('			        Left Join CargaCarregamento CC On Cc.PedidoVolumeId = Pv.PedidoVolumeId');
    FConexao.Query.SQL.Add
      ('			        where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)');
    FConexao.Query.SQL.Add
      ('			        And De.ProcessoId <> 15) CC On Cc.PedidoId = Cp.PedidoId and CC.PedidoVOlumeId is Null');
    FConexao.Query.SQL.Add
      ('where Cp.CargaId = @CargaId and Cp.PedidoId = @PedidoId');
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('CargaCarregamento.Sql');
    FConexao.Query.ExecSQL;
    Result := TJsonObject.Create.AddPair('Ok', '200');
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: CargaCarregamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCargasDAO.CargaCarregamentoFinalizar(pJsonObject: TJsonObject)
  : TJsonObject;
var
  vSql: String;
  vProcessoId: Integer;
begin
  try
    if pJsonObject.GetValue<String>('operacao') = 'CO' then
    Begin
      vProcessoId := 18;
      FConexao.Query.SQL.Add
        ('Update CargaPedidos Set Conferido = 0 Where CargaId = ' +
        pJsonObject.GetValue<Integer>('cargaid').ToString());
    End
    Else
    Begin
      vProcessoId := 17;
      FConexao.Query.SQL.Add
        ('Insert Into DocumentoEtapas (Documento, ProcessoId, UsuarioId, DataId, HoraId, DataHora, Terminal, Status)'
        + '             Select (Select uuid From Pedido where PedidoId = CP.PedidoId), 17, '
        + pJsonObject.GetValue<Integer>('usuarioid').ToString() +
        ' , (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '
        + ' (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'
        + ', GETDATE(), ' + QuotedStr(pJsonObject.GetValue<String>('terminal'))
        + ', 1 from cargaPedidos CP Where CP.cargaid = ' +
        pJsonObject.GetValue<Integer>('cargaid').ToString());
    End;
    FConexao.Query.SQL.Add
      ('Insert Into DocumentoEtapas (Documento, ProcessoId, UsuarioId, DataId, HoraId, DataHora, Terminal, Status)'
      + sLineBreak +
      '            Values ((Select uuid From Cargas where CargaId = ' +
      pJsonObject.GetValue<Integer>('cargaid').ToString() + '), ' +
      vProcessoId.ToString() + ', ' + sLineBreak + pJsonObject.GetValue<Integer>
      ('usuarioid').ToString() +
      ' , (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '
      + ' (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'
      + ', GETDATE(), ' + sLineBreak +
      QuotedStr(pJsonObject.GetValue<String>('terminal')) + ', 1)');

    // '--Delete From CargaCarregamento Where CargaId = '+pJsonObject.GetValue<Integer>('cargaid').ToString();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('CargaCarregamentoFinalizar.Sql');
    FConexao.Query.ExecSQL;
    Result := TJsonObject.Create.AddPair('Ok', '200');
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: CargaCarregamentoFinalizar - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;
constructor TCargasDAO.Create;
begin
  ObjCarga := TCargas.Create;
  inherited;
end;
function TCargasDAO.Delete(pCargaId: Integer; pJsonObject: TJsonObject)
  : Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    FConexao.Query.SQL.Add('Declare @CargaId Integer = ' + pCargaId.ToString);
    FConexao.Query.SQL.Add
      ('select CC.IdMin, De.Processoid, De.Descricao Processo, C.*');
    FConexao.Query.SQL.Add('From Cargas C');
    FConexao.Query.SQL.Add
      ('Left Join vDocumentoEtapas DE On De.Documento = C.uuid');
    FConexao.Query.SQL.Add
      ('Left Join (Select CargaId, Min(CarregamentoId) IdMin');
    FConexao.Query.SQL.Add('           From CargaCarregamento');
    FConexao.Query.SQL.Add
      ('           Group by CargaId) Cc ON Cc.CargaId = C.CargaId');
    FConexao.Query.SQL.Add
      ('Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = C.uuid and Status = 1)');
    FConexao.Query.SQL.Add('      And C.CargaId = @CargaId');
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('CargasDelete.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.FieldByName('ProcessoId').AsInteger > 16) then
    Begin
      Result := False;
      raise Exception.Create('Não é possível Cancelar a Carga. Processo Atual: '
        + FConexao.Query.FieldByName('Processo').AsString);
    End
    Else if (Not FConexao.Query.IsEmpty) and
      (FConexao.Query.FieldByName('IdMin').AsInteger > 0) then
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add
        ('Insert Into DocumentoEtapas (Documento, ProcessoId, UsuarioId, DataId, HoraId, DataHora, Terminal, Status)'
        + '             Select (Select uuid From Pedido where PedidoId = CP.PedidoId), 17, '
        + pJsonObject.GetValue<Integer>('usuarioid').ToString() +
        ' , (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '
        + ' (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))'
        + ', GETDATE(), ' + QuotedStr(pJsonObject.GetValue<String>('terminal'))
        + ', 1 from cargaPedidos CP Where CP.cargaid = ' + pCargaId.ToString);
      Result := True;
    End
    Else if (Not FConexao.Query.IsEmpty) and
      (FConexao.Query.FieldByName('IdMin').AsInteger = 0) then
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Delete Cargas where CargaId = ' +
        pCargaId.ToString);
      FConexao.Query.ExecSQL;
      Result := True;
    End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: DeleteCargas - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TCargasDAO.Destroy;
begin
  ObjCarga.Free;
  inherited;
end;

function TCargasDAO.Get(const AParams: TDictionary<string, string>): TJSonArray;
var
  vQuery, vQryPed: TFDQuery;
  JsonCargas: TJsonObject;
begin
  vQuery := FConexao.GetQuery;
  vQryPed := FConexao.GetQuery;
  Result := TJSonArray.Create();
  vQuery.SQL.Add(TuEvolutConst.SqlGetCargas);
  if AParams.ContainsKey('id') then
  begin
    vQuery.SQL.Add('and (@CargaId = 0 or C.cargaid = @CargaId)');
    vQuery.ParamByName('pCargaid').AsLargeInt := AParams.Items['id'].ToInt64;
  end;
  if AParams.ContainsKey('datainicial') then
  begin
    vQuery.SQL.Add('and C.DtInclusao >= :datainicial');
    vQuery.ParamByName('datainicial').Value := FormatDateTime('YYYY-MM-DD',
      StrtoDate(AParams.Items['datainicial']));
  end;
  if AParams.ContainsKey('datafinal') then
  begin
    vQuery.SQL.Add('and C.DtInclusao <= :datafinal');
    vQuery.ParamByName('datafinal').Value := FormatDateTime('YYYY-MM-DD',
      StrtoDate(AParams.Items['datafinal']));
  end;
  if AParams.ContainsKey('rotaid') then
  begin
    vQuery.SQL.Add('and C.Rotaid = :rotaid');
    vQuery.ParamByName('rotaid').AsInteger := AParams.Items['rotaid'].Tointeger;
  end;
  if AParams.ContainsKey('rota') then
  begin
    vQuery.SQL.Add('and R.Descricao like :rota');
    vQuery.ParamByName('rota').AsString := '%' + AParams.Items['rota'] + '%';
  end;
  if AParams.ContainsKey('transportadoraid') then
  begin
    vQuery.SQL.Add('and C.transportadoraid = :tranportadoraid');
    vQuery.ParamByName('transportadoraid').AsInteger :=
      AParams.Items['transportadoraid'].Tointeger;
  end;
  if AParams.ContainsKey('transportadora') then
  begin
    vQuery.SQL.Add('and T.Razao Like :transportadora');
    vQuery.ParamByName('Transportadora').AsString := '%' + AParams.Items
      ['transportadora'] + '%';
  end;
  if AParams.ContainsKey('veiculoid') then
  begin
    vQuery.SQL.Add('and C.veiculoid = :veiculoid');
    vQuery.ParamByName('veiculoid').AsInteger := AParams.Items['veiculoid']
      .Tointeger;
  end;
  if AParams.ContainsKey('placa') then
  begin
    vQuery.SQL.Add('and V.Placa = :placa');
    vQuery.ParamByName('placa').AsString := AParams.Items['placa'];
  end;
  if AParams.ContainsKey('motoristaid') then
  begin
    vQuery.SQL.Add('and C.motoristaid = :motoristaid');
    vQuery.ParamByName('motoristaid').AsInteger := AParams.Items['motoristaid']
      .Tointeger;
  end;
  if AParams.ContainsKey('motorista') then
  begin
    vQuery.SQL.Add('and M.Razao like :motorista');
    vQuery.ParamByName('motorista').AsString := '%' + AParams.Items
      ['motorista'] + '%';
  end;
  if AParams.ContainsKey('status') then
  begin
    vQuery.SQL.Add('and C.Status = :Status');
    vQuery.ParamByName('status').AsInteger := AParams.Items['status'].Tointeger;
  end;
  if AParams.ContainsKey('processoid') then
  begin
    vQuery.SQL.Add('and De.Processoid = :processoid');
    vQuery.ParamByName('processoid').AsInteger :=
      StrToIntDef(AParams.Items['processoid'], 0);
  end;
  if AParams.ContainsKey('processo') then
  begin
    vQuery.SQL.Add('and De.Processo = :processo');
    vQuery.ParamByName('processo').AsString := AParams.Items['processo'];
  end;
  if AParams.ContainsKey('limit') then
  begin
    vQuery.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    vQuery.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    vQuery.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
  vQuery.SQL.Add('order by CargaId');
  if AParams.ContainsKey('processoid') then
    vQuery.ParamByName('pProcessoId').AsLargeInt :=
      AParams.Items['processoid'].ToInt64
  Else
    vQuery.ParamByName('pProcessoId').AsLargeInt := 0;
  if DebugHook <> 0 then
    vQuery.SQL.SaveToFile('Cargas.Sql');
  vQuery.Open();
  if vQuery.IsEmpty then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados))
  Else
  begin
    vQryPed.SQL.Add
      ('Select C.CargaPedidoId, C.CargaId, C.PedidoId, P.PessoaId, P.DocumentoNr, Rd.Data as Data');
    vQryPed.SQL.Add('From CargaPedidos C');
    vQryPed.SQL.Add('Inner Join Pedido P On P.PedidoId = C.PedidoId');
    vQryPed.SQL.Add('Inner join Rhema_Data RD ON Rd.IdData = P.DocumentoData');
    vQryPed.SQL.Add('Where C.CargaId = :pCargaId');
    // +FConexao.Query.FieldByName('CargaId').AsString);
    while Not vQuery.Eof do
    Begin
      JsonCargas := TJsonObject.Create();
      JsonCargas.AddPair('cargaid',
        TJsonNumber.Create(vQuery.FieldByName('cargaid').AsInteger));
      // JsonCargas.AddPair('data', FConexao.Query.FieldByName('data').AsString);
      JsonCargas.AddPair('rotaid',
        TJsonNumber.Create(vQuery.FieldByName('rotaid').AsInteger));
      JsonCargas.AddPair('rota', vQuery.FieldByName('rota').AsString);
      JsonCargas.AddPair('transportadoraid',
        TJsonNumber.Create(vQuery.FieldByName('transportadoraid').AsInteger));
      JsonCargas.AddPair('transportadora', vQuery.FieldByName('Transportadora')
        .AsString);
      JsonCargas.AddPair('veiculoid',
        TJsonNumber.Create(vQuery.FieldByName('veiculoid').AsInteger));
      JsonCargas.AddPair('placa', vQuery.FieldByName('placa').AsString);
      JsonCargas.AddPair('modelo', vQuery.FieldByName('modelo').AsString);
      JsonCargas.AddPair('marca', vQuery.FieldByName('marca').AsString);
      JsonCargas.AddPair('cor', vQuery.FieldByName('cor').AsString);
      JsonCargas.AddPair('motoristaid',
        TJsonNumber.Create(vQuery.FieldByName('motoristaid').AsInteger));
      JsonCargas.AddPair('motorista', vQuery.FieldByName('Motorista').AsString);
      JsonCargas.AddPair('usuarioid',
        TJsonNumber.Create(vQuery.FieldByName('usuarioid').AsInteger));
      JsonCargas.AddPair('usuario', vQuery.FieldByName('usuario').AsString);
      JsonCargas.AddPair('dtinclusao', vQuery.FieldByName('dtinclusao')
        .AsString);
      JsonCargas.AddPair('hrinclusao', vQuery.FieldByName('hrinclusao')
        .AsString);
      JsonCargas.AddPair('status',
        TJsonNumber.Create(vQuery.FieldByName('status').AsInteger));
      JsonCargas.AddPair('uuid', vQuery.FieldByName('uuid').AsString);
      JsonCargas.AddPair('processoid',
        TJsonNumber.Create(vQuery.FieldByName('ProcessoId').AsInteger));
      JsonCargas.AddPair('processo', vQuery.FieldByName('processo').AsString);
      JsonCargas.AddPair('emconferencia', vQuery.FieldByName('EmConferencia')
        .AsString);
      JsonCargas.AddPair('carregando', vQuery.FieldByName('carregando')
        .AsString);
      JsonCargas.AddPair('statusoper',
        TJsonNumber.Create(vQuery.FieldByName('StatusOper').AsInteger));
      JsonCargas.AddPair('tpedido',
        TJsonNumber.Create(vQuery.FieldByName('TPedido').AsInteger));
      JsonCargas.AddPair('tvolume',
        TJsonNumber.Create(vQuery.FieldByName('TVolume').AsInteger));
      JsonCargas.AddPair('tunidade',
        TJsonNumber.Create(vQuery.FieldByName('TUnidade').AsInteger));
      vQryPed.Close;
      vQryPed.ParamByName('pCargaId').Value := vQuery.FieldByName('cargaid')
        .AsInteger;
      vQryPed.Open;
      JsonCargas.AddPair('pedidos', vQryPed.ToJSONArray());
      Result.AddElement(JsonCargas);
      vQuery.Next;
      JsonCargas := Nil;
    End;
  End;

end;

function TCargasDAO.Get4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
Var
  QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TJsonObject.Create();
  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.connection := FConexao.DB;
  QryPesquisa.SQL.Add(TuEvolutConst.SqlGetCargas);
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.connection := FConexao.DB;
  QryRecordCount.SQL.Add('Declare @ProcessoId Integer = :pProcessoId');
  QryRecordCount.SQL.Add('Select Count(C.CargaId) cReg');
  QryRecordCount.SQL.Add('from Cargas C');
  QryRecordCount.SQL.Add
    ('Left Join vDocumentoEtapas DE On De.Documento = C.Uuid');
  QryRecordCount.SQL.Add('Inner join Rotas R On R.RotaId = C.RotaId');
  QryRecordCount.SQL.Add
    ('Left Join Pessoa T ON T.PessoaId = C.transportadoraid');
  QryRecordCount.SQL.Add('Inner Join Pessoa M On M.Pessoaid = C.motoristaid');
  QryRecordCount.SQL.Add('Inner Join Veiculos V ON V.VeiculoId = C.veiculoid');
  QryRecordCount.SQL.Add('Inner Join usuarios U On U.UsuarioId = C.Usuarioid');
  QryRecordCount.SQL.Add
    ('Where (@ProcessoId = 0 or @ProcessoId = DE.ProcessoId)');
  if AParams.ContainsKey('cargaid') then
  begin
    // qryPesquisa.SQL.Add('and C.CargaId = :Cargaid');
    QryPesquisa.ParamByName('pCargaId').AsLargeInt :=
      AParams.Items['cargaid'].ToInt64;
    QryRecordCount.SQL.Add('and C.CargaId = :Cargaid');
    QryRecordCount.ParamByName('CargaId').AsLargeInt :=
      AParams.Items['cargaid'].ToInt64;
  end
  Else
  Begin
    QryPesquisa.ParamByName('pCargaId').AsLargeInt := 0;
  End;
  if AParams.ContainsKey('status') then
  begin
    QryPesquisa.SQL.Add('and Status = :Status');
    QryPesquisa.ParamByName('status').AsInteger := AParams.Items['status']
      .Tointeger;
    QryRecordCount.SQL.Add('and Status = :Status');
    QryRecordCount.ParamByName('Status').AsInteger := AParams.Items['status']
      .Tointeger;
  end;
  if AParams.ContainsKey('processoid') then
  begin
    QryPesquisa.ParamByName('pProcessoId').AsInteger :=
      AParams.Items['processoid'].Tointeger;
    QryRecordCount.ParamByName('pProcessoId').AsInteger :=
      AParams.Items['processoid'].Tointeger;
  end
  Else
  Begin
    QryPesquisa.ParamByName('pProcessoId').AsInteger := 0;
    QryRecordCount.ParamByName('pProcessoId').AsInteger := 0;
  End;
  if AParams.ContainsKey('limit') then
  begin
    QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    QryPesquisa.FetchOptions.RowsetSize :=
      StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    QryPesquisa.FetchOptions.RecsSkip :=
      StrToIntDef(AParams.Items['offset'], 0);
  QryPesquisa.SQL.Add('order by CargaId Desc');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.ToJSONArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));

end;

function TCargasDAO.GetCargaCarregarClientes(const pCarga: Integer): TJSonArray;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlCargaCarregarCliente);
  FConexao.Query.ParamByName('CargaId').Value := pCarga;
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.GetCargaCarregarPedidos(const pCarga: Integer): TJSonArray;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlCargaCarregarPedido);
  FConexao.Query.ParamByName('CargaId').Value := pCarga;
  FConexao.Query.SQL.SaveToFile('CargaCarregarPedidos.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.GetCargaCarregarVolumes(const pCarga, pPessoaId: Integer;
  pProcesso: String): TJSonArray;
begin
  FConexao.Query.Close;
  FConexao.Query.SQL.Clear;
  FConexao.Query.SQL.Add(TuEvolutConst.SqlCargaCarregarVolumes);
  FConexao.Query.ParamByName('pCargaId').Value := pCarga;
  FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
  FConexao.Query.ParamByName('pProcesso').Value := pProcesso;
  FConexao.Query.Open();
  if DebugHook <> 0 then
    FConexao.Query.SQL.SaveToFile('CargaVolumes.Sql');
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create();
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados))
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.GetCargaHearder(pCargaId: Integer): TJSonArray;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlGetCargaHeader);
  FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
  if DebugHook <> 0 then
    FConexao.Query.SQL.SaveToFile('CargaHearder.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.GetCargaNotaFiscal(pCargaId: Integer): TJSonArray;
begin
  Try
    FConexao.Query.SQL.Add('Declare @CargaId Integer = :pCargaId');
    FConexao.Query.SQL.Add('Select Cp.CargaId, PNF.*');
    FConexao.Query.SQL.Add('From CargaPedidos Cp');
    FConexao.Query.SQL.Add
      ('Inner join PedidoNotaFiscal PNF On PNF.PedidoId = Cp.PedidoId');
    FConexao.Query.SQL.Add('where Cp.CargaId = @CargaId');
    FConexao.Query.SQL.Add('Order by PedidoId, NotaFiscal');
    FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('CargaNotaFiscal.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('MSG',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TCargasDAO.GetCargaPedidos(pCargaId, pPessoaId: Integer;
  pProcesso: String): TJSonArray;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlGetCargaPedidos);
  FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
  FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
  FConexao.Query.ParamByName('pProcesso').Value := pProcesso;
  if DebugHook <> 0 then
    FConexao.Query.SQL.SaveToFile('CargaPedidos.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

// Function semelhante a anterior(GetCargaPedidos). porém trabalhando com multiplas NF
function TCargasDAO.GetCargaPedidosRomaneio(pCargaId, pPessoaId: Integer;
  pProcesso: String): TJSonArray;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlGetCargaPedidos);
  FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
  FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
  FConexao.Query.ParamByName('pProcesso').Value := pProcesso;
  if DebugHook <> 0 then
    FConexao.Query.SQL.SaveToFile('CargaPedidos.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados))
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.GetCargaPedidoVolumes(pCargaId: Integer; pProcesso: String)
  : TJSonArray;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlGetCargaPedidoVolumes);
  FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
  FConexao.Query.ParamByName('pProcesso').Value := pProcesso;
  if DebugHook <> 0 then
    FConexao.Query.SQL.SaveToFile('CargaPedidoVolumes.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.GetMapaCarga(pCargaId: Integer): TJSonArray;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlGetMapaCarga);
  FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
  if DebugHook <> 0 then
    FConexao.Query.SQL.SaveToFile('MapaCarga.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      TuEvolutConst.QrySemDados));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.GetRelAnaliseConsolidada(const AParams
  : TDictionary<string, string>): TJSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelCargaAnaliseConsolidada);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('rotainicialid') then
      FConexao.Query.ParamByName('pRotaInicial').AsInteger := AParams.Items['rotainicialid'].Tointeger
    Else
      FConexao.Query.ParamByName('pRotaInicial').AsInteger := 0;
    if AParams.ContainsKey('rotafinalid') then
      FConexao.Query.ParamByName('pRotaFinal').AsInteger := AParams.Items['rotafinalid'].Tointeger
    Else
      FConexao.Query.ParamByName('pRotaFinal').AsInteger := 0;
    if AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').AsInteger := AParams.Items['zonaid'].Tointeger
    Else
      FConexao.Query.ParamByName('pZonaId').AsInteger := 0;
    if AParams.ContainsKey('codpessoa') then
      FConexao.Query.ParamByName('pCodPessoa').AsInteger := AParams.Items['codpessoa'].Tointeger
    Else
      FConexao.Query.ParamByName('pCodPessoa').AsInteger := 0;
    if AParams.ContainsKey('somenteexpedido') then
      FConexao.Query.ParamByName('pSomenteExpedido').Value := AParams.Items['somenteexpedido'].Tointeger()
    Else
      FConexao.Query.ParamByName('pSomenteExpedido').Value := 0;
    if AParams.ContainsKey('ordem') then
      FConexao.Query.ParamByName('pOrdem').Value := AParams.Items['ordem'].Tointeger()
    Else
      FConexao.Query.ParamByName('pOrdem').Value := 0;
    // if AParams.ContainsKey('limit') then begin
    // FConexao.Query.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    // FConexao.Query.FetchOptions.RowsetSize := StrToIntDef(AParams.Items['limit'], 50);
    // end;
    // if AParams.ContainsKey('offset') then
    // FConexao.Query.FetchOptions.RecsSkip := StrToIntDef(AParams.Items['offset'], 0);
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('CargaAnaliseConsolidada.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    end;
  End;
end;

function TCargasDAO.GetResumoCarga(const AParams: TDictionary<string, string>)
  : TJSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelCargaResumo);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('rotainicial') then
      FConexao.Query.ParamByName('pRotaIdInicial').AsInteger :=
        AParams.Items['rotainicial'].Tointeger
    Else
      FConexao.Query.ParamByName('pRotaIdInicial').AsInteger := 0;
    if AParams.ContainsKey('rotafinal') then
      FConexao.Query.ParamByName('pRotaIdFinal').AsInteger :=
        AParams.Items['rotafinal'].Tointeger
    Else
      FConexao.Query.ParamByName('pRotaIdFinal').AsInteger := 0;
    if AParams.ContainsKey('processoid') then
      FConexao.Query.ParamByName('pProcessoId').AsInteger :=
        AParams.Items['processoid'].Tointeger
    Else
      FConexao.Query.ParamByName('pProcessoId').AsInteger := 0;
    if (AParams.ContainsKey('pendente')) and
      (AParams.Items['pendente'].Tointeger = 1) then
      FConexao.Query.ParamByName('pPendente').AsInteger :=
        AParams.Items['pendente'].Tointeger
    Else
      FConexao.Query.ParamByName('pPendente').AsInteger := 0;
    FConexao.Query.Open();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ResumoCarga.Sql');
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    end;
  End;
end;

function TCargasDAO.GetCargaPessoas(pCargaId: Integer): TJSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetCargaPessoas);
    FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
    FConexao.Query.Open();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('CargaPessoas.Sql');
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    end;
  End;
end;

Function TCargasDAO.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

Function TCargasDAO.InsertUpdate(Const pCargaId: Integer;
  pJsonObject: TJsonObject): TJSonArray;
// (pVolumeEmbalagemId : Integer; pDescricao : String; PStatus : Integer): TjSonArray;
var
  vSql: String;
  vCargaId, xPed: Integer;
  vGuuid: string;
  vCompl, vListaPedidos: String;
  Function MontaValor2(pValor: Single): String;
  Begin
    Result := FloatToStr(RoundTo(pValor, -2));
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  End;

begin
  FConexao.Query.connection.StartTransaction;
  try
    ObjCarga.CargaId := pJsonObject.GetValue<Integer>('cargaid');
    ObjCarga.Rotaid := pJsonObject.GetValue<Integer>('rotaid');
    ObjCarga.Transportadora.PessoaId := pJsonObject.GetValue<Integer>
      ('transportadoraid');
    ObjCarga.Veiculo.VeiculoId := pJsonObject.GetValue<Integer>('veiculoid');
    ObjCarga.Motorista.PessoaId := pJsonObject.GetValue<Integer>('motoristaid');
    ObjCarga.Usuarioid := pJsonObject.GetValue<Integer>('usuarioid');
    ObjCarga.Status := pJsonObject.GetValue<Integer>('status');
    // ObjCargaDAO := tJson.JsonToObject<tCargas>(pJsonObject.ToString(), [joDateIsUTC, joDateFormatISO8601]);
    if pCargaId = 0 then
    Begin
      vGuuid := TGUID.NewGuid.ToString() + sLineBreak;
      vSql :=
        'Insert Into Cargas (rotaid, transportadoraid,	veiculoid,	motoristaid, dtinclusao,	hrinclusao,	usuarioid,	status, uuid) Values ('
        + ObjCarga.Rotaid.ToString() + ', ' +
        IfThen(ObjCarga.Transportadora.PessoaId = 0, 'Null',
        ObjCarga.Transportadora.PessoaId.ToString) + ', ' +
        ObjCarga.Veiculo.VeiculoId.ToString + ', ' +
        ObjCarga.Motorista.PessoaId.ToString() + ', ' + 'GetDate(), GetDate(), '
        + ObjCarga.Usuarioid.ToString() + ', 1, Cast(' + QuotedStr(vGuuid) +
        ' AS UNIQUEIDENTIFIER))';
      vSql := vSql + 'Select CargaId From Cargas where Uuid = Cast(' +
        QuotedStr(vGuuid) + ' AS UNIQUEIDENTIFIER)';
      FConexao.Query.SQL.Add(vSql);
      FConexao.Query.Open;
      vCargaId := FConexao.Query.FieldByName('CargaId').AsInteger;
      // Registrar o Pedido em Montagem de Carga
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add
        ('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Cargas where CargaId = '
        + vCargaId.ToString() + ')');
      FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      FConexao.Query.ParamByName('pProcessoId').Value := 16;
      // 2	Cubagem Realizada
      FConexao.Query.ParamByName('pTerminal').Value :=
        pJsonObject.GetValue<String>('terminal');
      FConexao.Query.ParamByName('pUsuarioId').Value := ObjCarga.Usuarioid;
      // ClipBoard.AsText := FConexao.Query.Sql.Text;
      FConexao.Query.ExecSQL;
    End
    Else
    Begin
      vSql := 'Update Cargas ' + '    Set RotaId           = ' +
        ObjCarga.Rotaid.ToString() + #13 + #10 + '      , TransportadoraId = ' +
        IfThen(ObjCarga.Transportadora.PessoaId = 0, 'Null',
        ObjCarga.Transportadora.PessoaId.ToString) + #13 + #10 +
        '      , Veiculoid        = ' + ObjCarga.Veiculo.VeiculoId.ToString +
        #13 + #10 + '      , MotoristaId      = ' +
        ObjCarga.Motorista.PessoaId.ToString() + #13 + #10 +
        '      , UsuarioId        = ' + ObjCarga.Usuarioid.ToString + #13 + #10
        + '        ,Status          = ' + ObjCarga.Status.ToString() + #13 + #10
        + 'where CargaId = ' + pCargaId.ToString;
      vCargaId := pCargaId;
      FConexao.Query.ExecSQL(vSql);
    End;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    // FConexao.Query.SQL.Add('Delete From CargaPedidos Where CargaId = '+vCargaId.ToString);
    vCompl := '';
    vListaPedidos := '';
    For xPed := 0 To Pred(pJsonObject.GetValue<TJSonArray>('pedidos').Count) do
    Begin
      vListaPedidos := vListaPedidos + vCompl + pJsonObject.GetValue<TJSonArray>
        ('pedidos').Items[xPed].GetValue<Integer>('pedidoid').ToString();
      vCompl := ', ';
    End;
    FConexao.Query.SQL.Add('Delete Cc');
    FConexao.Query.SQL.Add('from CargaCarregamento cc');
    FConexao.Query.SQL.Add
      ('Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = cc.PedidoVolumeId');
    FConexao.Query.SQL.Add('where Cc.Cargaid = ' + vCargaId.ToString +
      ' and (Pv.PedidoId Not in (' + vListaPedidos + '))');
    FConexao.Query.SQL.Add('Delete Cp');
    FConexao.Query.SQL.Add('from CargaPedidos Cp');
    FConexao.Query.SQL.Add('where Cp.Cargaid = ' + vCargaId.ToString +
      ' and (Cp.PedidoId Not in (' + vListaPedidos + '))');
    FConexao.Query.SQL.Add('');
    FConexao.Query.ExecSQL;
    // Result := FConexao.Query.toJsonArray;
    For xPed := 0 To Pred(pJsonObject.GetValue<TJSonArray>('pedidos').Count) do
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add
        ('If Not Exists (Select PedidoId From CargaPedidos Where PedidoId = ' +
        pJsonObject.GetValue<TJSonArray>('pedidos').Items[xPed]
        .GetValue<Integer>('pedidoid').ToString() + ' and CargaId  = ' +
        vCargaId.ToString + ')');
      FConexao.Query.SQL.Add('   Insert Into CargaPedidos Values (' +
        pJsonObject.GetValue<TJSonArray>('pedidos').Items[xPed]
        .GetValue<Integer>('pedidoid').ToString() + ', ' + vCargaId.ToString() +
        ', GetDate(), GetDate(), ' + ObjCarga.Usuarioid.ToString + ', 1, 0)');
      FConexao.Query.ExecSQL;
      { //Registrar o Pedido em Montagem de Carga
        FConexao.Query.Close;
        FConexao.Query.Sql.Clear;
        FConexao.Query.Sql.Add('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '+pJsonObject.GetValue<TJsonArray>('pedidos').Items[xPed].GetValue<Integer>('pedidoid').ToString+')');
        FConexao.Query.SQL.Add( TuEvolutConst.SqlRegistrarDocumentoEtapa );
        FConexao.Query.ParamByName('pProcessoId').Value  := 16; //2	Cubagem Realizada
        FConexao.Query.ParamByName('pTerminal').Value    := pJsonObject.GetValue<String>('terminal');
        FConexao.Query.ParamByName('pUsuarioId').Value   := ObjCarga.UsuarioId;
        //ClipBoard.AsText := FConexao.Query.Sql.Text;
        FConexao.Query.ExecSql;
      } End;
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('cargaid',
      TJsonNumber.Create(vCargaId)));
    FConexao.Query.connection.Commit;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Tabela: CargasInsertUpdate - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCargasDAO.PedidosParaCargas(const AParams : TDictionary<string, string>): TJSonArray;
var
  JsonCargas: TJsonObject;
begin
  FConexao.Query.SQL.Add(TuEvolutConst.SqlRelPedidosParaCargas);
  if AParams.ContainsKey('datainicial') then
    FConexao.Query.ParamByName('pdatainicial').Value :=
      FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
  Else
    FConexao.Query.ParamByName('pdatainicial').Value := 0;
  if AParams.ContainsKey('datafinal') then
    FConexao.Query.ParamByName('pdatafinal').Value :=
      FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
  Else
    FConexao.Query.ParamByName('pdatafinal').Value := 0;
  if AParams.ContainsKey('codpessoaerp') then
    FConexao.Query.ParamByName('pCodPessoaERP').AsInteger :=
      AParams.Items['codpessoaerp'].Tointeger
  Else
    FConexao.Query.ParamByName('pCodPessoaERP').AsInteger := 0;
  if AParams.ContainsKey('rotaid') then
    FConexao.Query.ParamByName('protaid').AsInteger := AParams.Items['rotaid']
      .Tointeger
  Else
    FConexao.Query.ParamByName('protaid').AsInteger := 0;
  if AParams.ContainsKey('zonaid') then
    FConexao.Query.ParamByName('pzonaid').AsInteger := AParams.Items['zonaid']
      .Tointeger
  Else
    FConexao.Query.ParamByName('pzonaid').AsInteger := 0;
  if AParams.ContainsKey('processoid') then
    FConexao.Query.ParamByName('pprocessoid').Value :=
      AParams.Items['processoid'].Tointeger()
  Else
    FConexao.Query.ParamByName('pprocessoid').Value := 0;
  if DebugHook <> 0 then
     FConexao.Query.SQL.SaveToFile('PedidoParaCargas.Sql');
  FConexao.Query.Open();
  if FConexao.Query.IsEmpty then
  Begin
    Result := TJSonArray.Create();
    Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
  End
  Else
    Result := FConexao.Query.ToJSONArray();
end;

function TCargasDAO.PedidosParaCargasNFs(const AParams
  : TDictionary<string, string>): TJSonArray;
var
  JsonCargas: TJsonObject;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelPedidosParaCargasNFs);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrtoDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('codpessoaerp') then
      FConexao.Query.ParamByName('pCodPessoaERP').AsInteger :=
        AParams.Items['codpessoaerp'].Tointeger
    Else
      FConexao.Query.ParamByName('pCodPessoaERP').AsInteger := 0;
    if AParams.ContainsKey('rotaid') then
      FConexao.Query.ParamByName('protaid').AsInteger :=
        AParams.Items['rotaid'].Tointeger
    Else
      FConexao.Query.ParamByName('protaid').AsInteger := 0;
    if AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pzonaid').AsInteger :=
        AParams.Items['zonaid'].Tointeger
    Else
      FConexao.Query.ParamByName('pzonaid').AsInteger := 0;
    if AParams.ContainsKey('processoid') then
      FConexao.Query.ParamByName('pprocessoid').Value :=
        AParams.Items['processoid'].Tointeger()
    Else
      FConexao.Query.ParamByName('pprocessoid').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoParaCargasNFs.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('MSG',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CancelarCarregamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCargasDAO.PutAtualizarStatus(const pJsonObjectCargas: TJsonObject)
  : TJSonArray;
var
  xCargas: Integer;
  vListaCarga: String;
  vListaCargaOff: String;
  vCompl: String;
  vComplOff: String;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlCargaAtualizarStatus);
    vListaCarga := '';
    vListaCargaOff := '';
    vCompl := '';
    vComplOff := '';
    for xCargas := 0 to Pred(pJsonObjectCargas.GetValue<TJSonArray>
      ('cargas').Count) do
    Begin
      if pJsonObjectCargas.GetValue<TJSonArray>('cargas').Items[xCargas]
        .GetValue<Integer>('status') = 1 then
      Begin
        vListaCarga := vListaCarga + vCompl +
          pJsonObjectCargas.GetValue<TJSonArray>('cargas').Items[xCargas]
          .GetValue<String>('cargaid');
        vCompl := ', ';
      End
      Else
      Begin
        vListaCargaOff := vListaCargaOff + vComplOff +
          pJsonObjectCargas.GetValue<TJSonArray>('cargas').Items[xCargas]
          .GetValue<String>('cargaid');
        vComplOff := ', ';
      End;
    End;
    FConexao.Query.SQL.Add('  and C.CargaId in (' + vListaCarga + ')');
    FConexao.Query.ParamByName('pProcessoId').Value :=
      pJsonObjectCargas.GetValue<Integer>('processoid');
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      pJsonObjectCargas.GetValue<Integer>('usuarioid');
    FConexao.Query.ParamByName('pTerminal').Value :=
      pJsonObjectCargas.GetValue<String>('terminal');
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('CargasAtualizarStatus.Sql');
    if vListaCarga <> '' then
      FConexao.Query.ExecSQL;
    if vListaCargaOff <> '' then
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update De Set Status = 0');
      FConexao.Query.SQL.Add('From DocumentoEtapas De');
      FConexao.Query.SQL.Add('Inner Join Cargas C On C.Uuid = De.Documento');
      FConexao.Query.SQL.Add('Where C.CargaId In (' + vListaCargaOff +
        ') and De.ProcessoId = ' + pJsonObjectCargas.GetValue<String>
        ('processoid'));
      FConexao.Query.ExecSQL;
    End;
    Result := TJSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok',
      'Atualizado com sucesso!'));
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PutAtualizarStatus - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCargasDAO.CargaLista(pCargaId, pRotaId, pProcessoId,
  pPendente: Integer): TJSonArray;
Begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlCargaLista);
    FConexao.Query.ParamByName('pCargaId').Value := pCargaId;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pPendente').Value := pPendente;
    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('CargaLista.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJSonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: CargaLista - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

end.
