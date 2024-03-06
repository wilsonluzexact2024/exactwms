unit MService.PerfilDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.Stan.Option, PerfilClass, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type

  TPerfilDao = class(TBasicDao)
  private

    FPerfil: TPerfil;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
  public

    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar(pJsonObject: TJsonObject): Boolean;
    function GetId(pPerfil: String): TjSonArray;
    Function GetPerfil4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Function ControleAcessoFuncionalidades(pPerfilId: Integer;
      pListaTopicos: String): TJsonObject;
    Function ControleAcessoTopicos(pPerfilId: Integer): TJsonObject;
    Function SalvarAcesso(pPerfilId: Integer; pJsonObject: TJsonObject)
      : TjSonArray;
    Property ObjPerfil: TPerfil Read FPerfil Write FPerfil;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

function TPerfilDao.ControleAcessoFuncionalidades(pPerfilId: Integer;
  pListaTopicos: String): TJsonObject;
var
  JsonArrayFuncionalidades: TjSonArray;
Begin
  Result := TJsonObject.Create;
  try
    JsonArrayFuncionalidades := TjSonArray.Create;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('select Tf.TopicoId, F.Funcionalidadeid, F.Descricao, F.Status, (Case When PF.FuncionalidadeId Is Not Null Then 1 Else 0 End) as Acesso');
    FConexao.Query.SQL.Add('from Funcionalidades F');
    FConexao.Query.SQL.Add
      ('INNER Join TopicoFuncionalidades TF On TF.FuncionalidadeId = F.FuncionalidadeId --and TF.TopicoId In ('
      + pListaTopicos + ')');
    FConexao.Query.SQL.Add
      ('Left Join PerfilFuncionalidades PF ON PF.FuncionalidadeId = TF.Funcionalidadeid and PF.PerfilId = '
      + pPerfilId.ToString());
    If pListaTopicos <> '' then
      FConexao.Query.SQL.Add('Where TF.TopicoId In (' + pListaTopicos + ')');
    FConexao.Query.SQL.Add('Order by Tf.TopicoId, F.Descricao');
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ControleAcessoFuncionalidades.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result.AddPair('Erro', tuEvolutConst.QrySemDados);
    End
    Else
    Begin
      Result.AddPair('funcionalidades', FConexao.Query.toJsonArray);
    End;
    JsonArrayFuncionalidades.Free;
  Except
    on E: Exception do
    Begin
      JsonArrayFuncionalidades.AddElement(TJsonObject.Create.AddPair('Erro',
        E.Message));
      Result.AddPair('Erro', E.Message);
      JsonArrayFuncionalidades.Free;
    End;
  end;
end;

function TPerfilDao.ControleAcessoTopicos(pPerfilId: Integer): TJsonObject;
var
  JsonArrayTopicos: TjSonArray;
Begin
  Result := TJsonObject.Create;
  try
    JsonArrayTopicos := TjSonArray.Create;
    FConexao.Query.SQL.Add(tuEvolutConst.SqlGetPerfilControleAcessoTopico);
    FConexao.Query.ParamByName('pPerfilId').Value := pPerfilId;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      JsonArrayTopicos.AddElement(TJsonObject.Create.AddPair('Erro',
        'N�o h� T�picos cadastrado no sistema!'));
      Result.AddPair('Erro', tuEvolutConst.QrySemDados);
    End
    Else
    Begin
      Result.AddPair('topicos', FConexao.Query.toJsonArray);
    End;
    JsonArrayTopicos.Free;
  Except
    on E: Exception do
    Begin
      JsonArrayTopicos.AddElement(TJsonObject.Create.AddPair('Erro',
        E.Message));
      Result.AddPair('Erro', E.Message);
      JsonArrayTopicos.Free;
    End;
  end;
end;

constructor TPerfilDao.Create;
begin
  ObjPerfil := TPerfil.Create;
  inherited;
end;

function TPerfilDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Perfil where PerfilId = ' +
      Self.ObjPerfil.PerfilId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TPerfilDao.Destroy;
begin
  ObjPerfil.Free;
  
  inherited;
end;

function TPerfilDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  FConexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Perfil') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
  Begin
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'));
  End
  Else
  Begin
    Result := FConexao.Query.toJsonArray();
  End;
end;

function TPerfilDao.GetId(pPerfil: String): TjSonArray;
var
  ObjJson: TJsonObject;
  PerfilItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  Try
    FConexao.Query.SQL.Add(tuEvolutConst.SqlPerfil);
    if (pPerfil = '0') or (StrToInt64Def(pPerfil, 0) > 0) then
      FConexao.Query.ParamByName('pPerfilId').Value := pPerfil
    Else
      FConexao.Query.ParamByName('pPerfilId').Value := 0;
    if (StrToInt64Def(pPerfil, 0) > 0) or (pPerfil = '0') then
      FConexao.Query.ParamByName('pDescricao').Value := ''
    Else
      FConexao.Query.ParamByName('pDescricao').Value := '%' + pPerfil + '%';
    FConexao.Query.Open;
    while Not FConexao.Query.Eof do
      With ObjPerfil do
      Begin
        ObjJson := TJsonObject.Create;
        With ObjJson do
        Begin
          AddPair('perfilid',
            TJsonNumber.Create(FConexao.Query.FieldByName('PerfilId')
            .AsInteger));
          AddPair('descricao', FConexao.Query.FieldByName('Descricao')
            .AsString);
          AddPair('status',
            TJsonNumber.Create(FConexao.Query.FieldByName('Status').AsInteger));
          AddPair('data', DateToStr(FConexao.Query.FieldByName('Data')
            .AsDateTime));
          AddPair('hora',
            TimeToStr(StrToTime(Copy(FConexao.Query.FieldByName('Hora')
            .AsString, 1, 8))));
          Result.AddElement(ObjJson);
          // tJson.ObjectToJsonObject(ObjFuncionalidade, [joDateFormatISO8601]));
        End;
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPerfilDao.GetPerfil4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
  vSql: String;
begin
  vSql := 'select P.PerfilId, P.Descricao, P.Status, Rd.Data, Rh.Hora' +
    sLineBreak + 'from Perfil P' + sLineBreak +
    'Inner Join Rhema_Data RD On Rd.IdData = P.Data' + sLineBreak +
    'Inner join Rhema_Hora RH ON RH.IdHora = P.Hora' + sLineBreak +
    'Where 1 = 1';
  Result := TJsonObject.Create();
  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.SQL.Add(vSql);
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.SQL.Add('Select Count(PerfilId) cReg From Perfil Where 1 =1');
  if AParams.ContainsKey('perfilid') then
  begin
    QryPesquisa.SQL.Add('and PerfilId = :PerfilId');
    QryPesquisa.ParamByName('PerfilId').AsLargeInt :=
      AParams.Items['perfilid'].ToInt64;
    QryRecordCount.SQL.Add('and PerfilId = :PerfilId');
    QryRecordCount.ParamByName('PerfilId').AsLargeInt :=
      AParams.Items['perfilid'].ToInt64;
  end;
  if AParams.ContainsKey('descricao') then
  begin
    QryPesquisa.SQL.Add('and (descricao like :descricao))');
    QryPesquisa.ParamByName('descricao').AsString := '%' + AParams.Items
      ['descricao'].ToLower + '%';
    QryRecordCount.SQL.Add('and (Descricao like :Descricao))');
    QryRecordCount.ParamByName('Descricao').AsString := '%' + AParams.Items
      ['descricao'].ToLower + '%';
  end;
  if AParams.ContainsKey('limit') then
  begin
    QryPesquisa.FetchOptions.RecsMax := StrToIntDef(AParams.Items['limit'], 50);
    QryPesquisa.FetchOptions.RowsetSize :=
      StrToIntDef(AParams.Items['limit'], 50);
  end;
  if AParams.ContainsKey('offset') then
    QryPesquisa.FetchOptions.RecsSkip :=
      StrToIntDef(AParams.Items['offset'], 0);
  QryPesquisa.SQL.Add('order by perfilid');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.toJsonArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  
  
end;

function TPerfilDao.Salvar(pJsonObject: TJsonObject): Boolean;
var
  vSql: String;
begin
  try
    if pJsonObject.GetValue<Integer>('perfilId') = 0 then
      vSql := 'Insert Into Perfil (Descricao, Status, Data, Hora) Values (' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) + ', ' +
        pJsonObject.GetValue<String>('status') + ', ' +
        tuEvolutConst.SqlDataAtual + ', ' + tuEvolutConst.SqlHoraAtual + ')'
    Else
      vSql := ' Update Perfil ' + '   Set Descricao = ' +
        QuotedStr(pJsonObject.GetValue<String>('descricao')) +
        '      , Status   = ' + pJsonObject.GetValue<String>('status') +
        ' where PerfilId = ' + pJsonObject.GetValue<String>('perfilId');
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPerfilDao.SalvarAcesso(pPerfilId: Integer; pJsonObject: TJsonObject)
  : TjSonArray;
Var
  pJsonArrayTopicos, pJsonArrayFuncionalidades: TjSonArray;
  vQryTopico, vQryFuncionalidade: TFDQuery;
  xTopico, xFuncionalidade: Integer;
begin
  Try
    pJsonArrayTopicos := TjSonArray.Create;
    pJsonArrayFuncionalidades := TjSonArray.Create;
    pJsonArrayTopicos := pJsonObject.GetValue<TjSonArray>('topicos');
    pJsonArrayFuncionalidades := pJsonObject.GetValue<TjSonArray>
      ('funcionalidades');
    vQryTopico := FConexao.GetQuery;
    vQryTopico.connection.StartTransaction;
    vQryTopico.connection.TxOptions.Isolation := xiReadCommitted;
    vQryTopico.SQL.Add(tuEvolutConst.SqlSalvarPerfilAcessoTopico);
    for xTopico := 0 to Pred(pJsonArrayTopicos.Count) do
    Begin
      vQryTopico.Close;
      vQryTopico.ParamByName('pPerfilId').Value := pPerfilId;
      vQryTopico.ParamByName('pTopicoId').Value := pJsonArrayTopicos.Items
        [xTopico].GetValue<Integer>('topicoid');
      vQryTopico.ParamByName('pAcesso').Value := pJsonArrayTopicos.Items
        [xTopico].GetValue<Integer>('acesso');
      vQryTopico.ExecSQL;
    End;

    vQryFuncionalidade := FConexao.GetQuery;
    vQryFuncionalidade.SQL.Add
      (tuEvolutConst.SqlSalvarPerfilAcessoFuncionalidade);
    for xFuncionalidade := 0 to Pred(pJsonArrayFuncionalidades.Count) do
    Begin
      vQryFuncionalidade.Close;
      vQryFuncionalidade.ParamByName('pPerfilId').Value := pPerfilId;
      vQryFuncionalidade.ParamByName('pFuncionalidadeId').Value :=
        pJsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>
        ('funcionalidadeid');
      vQryFuncionalidade.ParamByName('pAcesso').Value :=
        pJsonArrayFuncionalidades.Items[xFuncionalidade].GetValue<Integer>
        ('acesso');
      vQryFuncionalidade.ExecSQL;
    End;
    Result := vQryFuncionalidade.toJsonArray;
    vQryTopico.connection.Commit;
  Except
    ON E: Exception do
    Begin
      vQryTopico.connection.Rollback;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

Function TPerfilDao.TrataErroFireDac(pErro: EFDDBEngineException): String;
begin
  case pErro.Kind of
    ekOther:
      Result := pErro.Message; // 'Opera��o com o Banco de Dados';
    ekNoDataFound:
      Result := 'Erro! Dados n�o encontrados';
    ekTooManyRows:
      Result := 'Excesso de Linhas';
    ekRecordLocked:
      Result := 'Registro com acesso bloqueado. Pode est� sendo usado por outro processo.';
    ekUKViolated:
      Result := 'Tentativa de incluir registro j� existente.';
    ekFKViolated:
      Result := 'Cadastro prim�rio necess�rio inexistente.';
    ekObjNotExists:
      Result := 'Objeto n�o encontrado';
    ekUserPwdInvalid:
      Result := 'Usu�rio e/ou Senha inv�lido.';
    ekUserPwdExpired:
      Result := 'Usu�rio e/ou Senha expirou!';
    ekUserPwdWillExpire:
      Result := 'Usu�rio e/ou Senha prestes a expirar';
    ekCmdAborted:
      Result := 'Opera��o cancelada.';
    ekServerGone:
      Result := 'Servidor de Banco de Dados inexistente.';
    ekServerOutput:
      Result := 'Servidor de Banco de Dados parece est� fora do ar.';
    ekArrExecMalfunc:
      Result := 'Opera��o mal sucedida.';
    ekInvalidParams:
      Result := 'Par�metros inv�lidos para esta opera��o.';
  end;
  Result := 'Tabela: EnderecamentoRuas - ' + StringReplace(Result,
    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
    '', [rfReplaceAll]);
end;

end.
