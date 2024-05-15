unit MService.EnderecoDAO;

interface

uses
  FireDAC.Comp.Client, EnderecoClass, System.SysUtils,
  DataSet.Serialize,
  System.JSON, REST.JSON, System.Generics.Collections, Constants,
  FireDAC.Stan.Option, exactwmsservice.lib.connection,exactwmsservice.dao.base;

Const
  SqlEndereco = 'Select * From vEnderecamentos';

type
  TEnderecoDao = class(TBasicDao)
  private
    
    ObjEnderecoDAO: TEndereco;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pJsonEndereco: TJsonObject): TjSonArray;
    function GetId(pEnderecoId: String): TjSonArray;
    function GetEndereco4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function GetLista(pEnderecoId: Integer; pEstruturaId: Integer;
      pZonaId: Integer; pRuaId: Integer; pEnderecoIni: String;
      pEnderecoFin, pOcupacaoEndereco: String; pStatus: Integer;
      pListaZona: String; pCurva: String): TjSonArray;
    Function GetEnderecoToReposicao(pZonaId: Integer;
      pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal: String;
      pRuaParImpar: Integer; pPredioInicial, pPredioFinal: String;
      pPredioParImpar: Integer; pNivelInicial, pNivelFinal: String;
      pNivelParImpar: Integer; pAptoInicial, pAptoFinal: String;
      pAptoParImpar: Integer): TjSonArray;
    function GetEstrutura(pEstruturaId: Integer): TjSonArray;
    Function GetPickingMask: TjSonArray;
    Function GetReUsoPicking(pZonaId, pDias: Integer): TjSonArray;
    function GetZona(pEstruturaId: Integer): TjSonArray;
    Function Delete(pEnderecoId: Integer): Boolean;
    Function EnderecoBloquear(ArrayEndereco: TjSonArray): TjSonArray;
    Function MontarPaginacao: TJsonObject;
    Function PutDesvincularPicking(pJsonArray: TjSonArray): TjSonArray;
    Function Estrutura: TjSonArray;
    Function ExportFile(const AParams: TDictionary<string, string>): TjSonArray;
    Function Manutencao(pJsonManutencao: TJsonObject): TJsonObject;
    Function GetMotivoMovimentacaoSegregado: TjSonArray;
  end;

implementation

uses uSistemaControl;

{ TClienteDao }

constructor TEnderecoDao.Create;
begin
  inherited;
  ObjEnderecoDAO := TEndereco.Create;
end;

destructor TEnderecoDao.Destroy;
begin
  
  ObjEnderecoDAO.Free;
  inherited;
end;

function TEnderecoDao.Delete(pEnderecoId: Integer): Boolean;
var vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Enderecamentos where EnderecoId = ' +
      pEnderecoId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.EnderecoBloquear(ArrayEndereco: TjSonArray): TjSonArray;
Var
  xEndereco: Integer;
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add
      ('Update Enderecamentos Set Status = 0 Where EnderecoId = :EnderecoId');
    FConexao.Query.connection.StartTransaction;
    for xEndereco := 0 to ArrayEndereco.Count - 1 do
    Begin
      FConexao.Query.ParamByName('EnderecoId').Value := ArrayEndereco.Get(xEndereco)
        .GetValue<Integer>('enderecoid', 0);
      FConexao.Query.ExecSQL;
    End;
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
  Except
    ON E: Exception do
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: Enderecamentos - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('vEnderecamentos') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'))
  Else
  Begin
    While Not FConexao.Query.Eof do
    Begin
      vRegEstrutura := TJsonObject.Create;
      vRegEstrutura.AddPair('coluna',
        LowerCase(FConexao.Query.FieldByName('Nome').AsString));
      vRegEstrutura.AddPair('tipo',
        LowerCase(FConexao.Query.FieldByName('Tipo').AsString));
      vRegEstrutura.AddPair('tamanho',
        TJsonNumber.Create(FConexao.Query.FieldByName('Tamanho').AsInteger));
      Result.AddElement(vRegEstrutura);
      FConexao.Query.Next;
    End;
  End;
end;

function TEnderecoDao.ExportFile(const AParams: TDictionary<string, string>)
  : TjSonArray;
var
  vSql, pCampos: String;
begin
  try
    if AParams.ContainsKey('campos') then
      pCampos := AParams.Items['campos']
    else
      pCampos := 'Descricao, PickingFixo';
    vSql := 'Select ' + pCampos + ' ' + sLineBreak + 'From vEnderecamentos';
    FConexao.Query.Open(vSql);
    if FConexao.Query.IsEmpty then Begin
       Result := TJsonArray.Create;
       Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Não foram encontrados dados da pesquisa.')));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;

end;

function TEnderecoDao.GetEstrutura(pEstruturaId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEndereco;
    vSql := vSql + #13 + #10 + ' where EstruturaId = ' +
      pEstruturaId.ToString();
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      With ObjEnderecoDAO do
      Begin
        EnderecoId := FConexao.Query.FieldByName('EnderecoId').AsInteger;
        EnderecoEstrutura.EstruturaId := FConexao.Query.FieldByName('EstruturaId')
          .AsInteger;
        EnderecoEstrutura.Descricao := FConexao.Query.FieldByName('Estrutura').AsString;
        EnderecamentoZona.ZonaId := FConexao.Query.FieldByName('ZonaId').AsInteger;
        EnderecamentoZona.Descricao := FConexao.Query.FieldByName('Zona').AsString;
        Descricao := FConexao.Query.FieldByName('Endereco').AsString;
        DesenhoArmazem.Id := FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        Altura := FConexao.Query.FieldByName('Altura').AsFloat;
        largura := FConexao.Query.FieldByName('Largura').AsFloat;
        Comprimento := FConexao.Query.FieldByName('Comprimento').AsFloat;
        Volume := FConexao.Query.FieldByName('Volume').AsFloat;
        Capacidade := FConexao.Query.FieldByName('Capacidade').AsFloat;
        Curva := FConexao.Query.FieldByName('Curva').AsString;
        Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
        FConexao.Query.Next;
      End;
    end;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: Enderecamentos - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.GetId(pEnderecoId: String): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEndereco;
    if pEnderecoId <> '0' then
      vSql := vSql + #13 + #10 + 'Where (Cast(EnderecoId as varchar(20)) = ' +
        QuotedStr(pEnderecoId) + ') or (Endereco = ' +
        QuotedStr(pEnderecoId) + ')';
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      With ObjEnderecoDAO do
      Begin
        EnderecoId := FConexao.Query.FieldByName('EnderecoId').AsInteger;
        EnderecoRua.RuaId := FConexao.Query.FieldByName('ruaid').AsInteger;
        EnderecoRua.Descricao := FConexao.Query.FieldByName('Rua').AsString;
        EnderecoRua.Lado := FConexao.Query.FieldByName('Lado').AsString;
        EnderecoRua.Ordem := FConexao.Query.FieldByName('Ordem').AsInteger;
        EnderecoEstrutura.EstruturaId := FConexao.Query.FieldByName('EstruturaId')
          .AsInteger;
        EnderecoEstrutura.Descricao := FConexao.Query.FieldByName('Estrutura').AsString;
        EnderecoEstrutura.PickingFixo := FConexao.Query.FieldByName('PickingFixo')
          .AsInteger;
        EnderecoEstrutura.Mascara := FConexao.Query.FieldByName('Mascara').AsString;
        EnderecamentoZona.ZonaId := FConexao.Query.FieldByName('ZonaId').AsInteger;
        EnderecamentoZona.Descricao := FConexao.Query.FieldByName('Zona').AsString;
        Descricao := FConexao.Query.FieldByName('Endereco').AsString;
        DesenhoArmazem.Id := FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        Altura := FConexao.Query.FieldByName('Altura').AsFloat;
        largura := FConexao.Query.FieldByName('Largura').AsFloat;
        Comprimento := FConexao.Query.FieldByName('Comprimento').AsFloat;
        Volume := FConexao.Query.FieldByName('Volume').AsFloat;
        Capacidade := FConexao.Query.FieldByName('Capacidade').AsFloat;
        Curva := FConexao.Query.FieldByName('Curva').AsString;
        Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
        FConexao.Query.Next;
      End;
    end;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: Enderecamentos - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.GetEndereco4D(const AParams: TDictionary<string, string>)
  : TJsonObject;
var
  QryPesquisa, QryRecordCount: TFDQuery;
begin
  Result := TJsonObject.Create();
  QryPesquisa := FConexao.GetQuery;
  QryPesquisa.Sql.Add
    ('select EnderecoId, Endereco, Estrutura, Rua, Lado, Zona, Status, Curva From vEnderecamentos where 1 = 1');
  QryRecordCount := FConexao.GetQuery;
  QryRecordCount.Sql.Add
    ('Select Count(EnderecoId) cReg From vEnderecamentos where 1=1');
  if AParams.ContainsKey('endereco') then
  begin
    QryPesquisa.Sql.Add('and Endereco = :Endereco');
    QryPesquisa.ParamByName('Endereco').AsString := AParams.Items['endereco'];
    QryRecordCount.Sql.Add('and Endereco = :Endereco');
    QryRecordCount.ParamByName('Endereco').AsString :=
      AParams.Items['endereco'];
  end;
  if AParams.ContainsKey('zona') then
  begin
    QryPesquisa.Sql.Add('and zona Like :zona');
    QryPesquisa.ParamByName('zona').AsString := '%' + AParams.Items['descricao']
      .ToUpper + '%';
    QryRecordCount.Sql.Add('and zona like :zona');
    QryRecordCount.ParamByName('zona').AsString := '%' + AParams.Items
      ['descricao'].ToUpper + '%';
  end;
  if AParams.ContainsKey('curva') then
  begin
    QryPesquisa.Sql.Add('and curva = :curva');
    QryPesquisa.ParamByName('curva').AsString := AParams.Items['curva'].ToUpper;
    QryRecordCount.Sql.Add('and curva = :curva');
    QryRecordCount.ParamByName('curva').AsString :=
      AParams.Items['curva'].ToUpper;
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
  QryPesquisa.Sql.Add('order by Endereco');
  QryPesquisa.Open();
  Result.AddPair('data', QryPesquisa.ToJSONArray());
  QryRecordCount.Open();
  Result.AddPair('records',
    TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  QryPesquisa.Close;
  
  QryRecordCount.Close;
  
end;

function TEnderecoDao.GetEnderecoToReposicao(pZonaId: Integer;
  pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal: String;
  pRuaParImpar: Integer; pPredioInicial, pPredioFinal: String;
  pPredioParImpar: Integer; pNivelInicial, pNivelFinal: String;
  pNivelParImpar: Integer; pAptoInicial, pAptoFinal: String;
  pAptoParImpar: Integer): TjSonArray;
begin
  try
    FConexao.Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
    FConexao.Query.Sql.Add('Declare @EnderecoIni VarChar(40)  = ' + #39 +
      pEnderecoIni + #39);
    FConexao.Query.Sql.Add('Declare @EnderecoFin VarChar(40)  = ' + #39 +
      pEnderecoFin + #39);
    FConexao.Query.Sql.Add('Declare @RuaInicial VarChar(2)    = ' + #39 +
      pRuaInicial + #39);
    FConexao.Query.Sql.Add('Declare @RuaFinal  VarChar(2)     = ' + #39 +
      pRuaFinal + #39);
    FConexao.Query.Sql.Add('Declare @RuaParImpar Integer      = ' +
      pRuaParImpar.ToString());
    FConexao.Query.Sql.Add('Declare @PredioInicial VarChar(2) = ' + #39 +
      pPredioInicial + #39);
    FConexao.Query.Sql.Add('Declare @PredioFinal   VarChar(2) = ' + #39 +
      pPredioFinal + #39);
    FConexao.Query.Sql.Add('Declare @PredioParImpar Integer   = ' +
      pPredioParImpar.ToString());
    FConexao.Query.Sql.Add('Declare @NivelInicial VarChar(2)  = ' + #39 +
      pNivelInicial + #39);
    FConexao.Query.Sql.Add('Declare @NivelFinal   VarChar(2)  = ' + #39 +
      pNivelFinal + #39);
    FConexao.Query.Sql.Add('Declare @NivelParImpar Integer    = ' +
      pNivelParImpar.ToString());
    FConexao.Query.Sql.Add('Declare @AptoInicial VarChar(2)   = ' + #39 +
      pAptoInicial + #39);
    FConexao.Query.Sql.Add('Declare @AptoFinal   VarChar(2)   = ' + #39 +
      pAptoFinal + #39);
    FConexao.Query.Sql.Add('Declare @AptoParImpar Integer     = ' +
      pAptoParImpar.ToString());

    FConexao.Query.Sql.Add
      ('Select (select vEnd.enderecoid, vEnd.Endereco, vEnd.Mascara, vEnd.Descricao Produto,');
    FConexao.Query.Sql.Add('        Cast(vEnd.altura as Decimal(15,3)) altura,');
    FConexao.Query.Sql.Add('        Cast(vEnd.largura as Decimal(15,3)) largua,');
    FConexao.Query.Sql.Add
      ('        Cast(vEnd.comprimento as Decimal(15,3)) comprimento,');
    FConexao.Query.Sql.Add('        Cast(vEnd.volume as Decimal(15,6)) volume,');
    FConexao.Query.Sql.Add('        Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
    FConexao.Query.Sql.Add('        vEnd.Zona, Coalesce(Est.Qtde, 0) as ' + #39 + 'qtde' +
      #39 + ', Coalesce(EstPulmao.Qtde, 0) as ' + #39 + 'qtdepulmao' + #39);
    FConexao.Query.Sql.Add('From vEnderecamentos vEnd');
    // FConexao.Query.Sql.Add('Left Join (Select Produtoid, Coalesce(Sum(Qtde), 0) Qtde From vEstoque Group By ProdutoId) Est ON Est.Produtoid = vEnd.ProdutoId');
    FConexao.Query.Sql.Add
      ('Left Join (Select EnderecoId, Coalesce(Sum(Qtde), 0) Qtde From vEstoque Group By EnderecoId) Est ON Est.Enderecoid = vEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join (Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde' +
      sLineBreak + 'From vEstoque Where EstruturaId <> 2' + sLineBreak +
      'Group By CodigoERP) EstPulmao ON EstPulmao.CodigoERP = vEnd.CodProduto');
    FConexao.Query.Sql.Add('Where (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
    FConexao.Query.Sql.Add('      (@EnderecoIni = ' + #39 + #39 +
      ' or Substring(vEnd.Endereco, 1, LEN( @EnderecoIni)) >= @EnderecoIni) and ');
    FConexao.Query.Sql.Add('      (@EnderecoFin = ' + #39 + #39 +
      ' or Substring(vEnd.Endereco, 1, LEN( @EnderecoFin)) <= @EnderecoFin) and ');
    FConexao.Query.Sql.Add('      (@RuaInicial  = ' + #39 + #39 +
      ' or SubString(vEnd.Endereco,1,2) >= @RuaInicial) and');
    FConexao.Query.Sql.Add('      (@RuaFinal    = ' + #39 + #39 +
      ' or SubString(vEnd.Endereco,1,2) <= @RuaFinal) and');
    FConexao.Query.Sql.Add
      ('      (@RuaParImpar = 2 or (@RuaParImpar=0 and SubString(vEnd.Endereco,1,2) % 2 = 0) or ');
    FConexao.Query.Sql.Add
      ('                           (@RuaParImpar=1 and SubString(vEnd.Endereco,1,2) % 2 = 1) ) and');
    FConexao.Query.Sql.Add('      (vEnd.EstruturaId=2 and vEnd.Status = 1)');
    FConexao.Query.Sql.Add('Order by vEnd.Endereco'); // by RuaId, Lado, Endereco');
    FConexao.Query.Sql.Add('For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno');
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelEnderecoToReposicao.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('ConsultaRetorno')
      .AsString = '') Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Endereço não encontrado.'));
    End
    Else
      Result := TJsonObject.ParseJSONValue
        (TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('ConsultaRetorno').AsString),
        0) as TjSonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.GetLista(pEnderecoId, pEstruturaId, pZonaId: Integer;
  pRuaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
  pStatus: Integer; pListaZona: String; pCurva: String): TjSonArray;
begin
  try
    FConexao.Query.Sql.Add('SET NOCOUNT ON');
    FConexao.Query.Sql.Add('SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED');
    FConexao.Query.Sql.Add('Declare @EnderecoId Integer = ' + pEnderecoId.ToString());
    FConexao.Query.Sql.Add('Declare @EstruturaId Integer = ' + pEstruturaId.ToString());
    FConexao.Query.Sql.Add('Declare @ZonaId Integer = ' + pZonaId.ToString());
    FConexao.Query.Sql.Add('Declare @Ruaid Integer  = ' + pRuaId.ToString());
    FConexao.Query.Sql.Add('Declare @EnderecoIni VarChar(40) = ' + #39 +
      pEnderecoIni + #39);
    FConexao.Query.Sql.Add('Declare @EnderecoFin VarChar(40) = ' + #39 +
      pEnderecoFin + #39);
    FConexao.Query.Sql.Add('Declare @OcupacaoEndereco Varchar(1) = ' + #39 +
      pOcupacaoEndereco + #39);
    FConexao.Query.Sql.Add('Declare @Curva Varchar(30)           = ' + #39 +
      pCurva + #39);
    FConexao.Query.Sql.Add('Declare @Status Integer = ' + pStatus.ToString());
    // vqry.SQL.Add('select vEnd.*, Est.Qtde ');
    FConexao.Query.Sql.Add('Select (select vEnd.enderecoid,');
    FConexao.Query.Sql.Add('   vEnd.Endereco descricao,');
    FConexao.Query.Sql.Add('   Cast(vEnd.altura as Decimal(15,3)) altura,');
    FConexao.Query.Sql.Add('   Cast(vEnd.largura as Decimal(15,3)) largura,');
    FConexao.Query.Sql.Add('   Cast(vEnd.comprimento as Decimal(15,3)) comprimento, ');
    FConexao.Query.Sql.Add('   Cast(vEnd.volume as Decimal(15,6)) volume,');
    FConexao.Query.Sql.Add('   Cast(vEnd.capacidade as Decimal(15,3)) capacidade,');
    FConexao.Query.Sql.Add('   vEnd.status,');
    FConexao.Query.Sql.Add('   vEnd.EstruturaId as '#39 + 'enderecoestrutura.estruturaid'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.estrutura as '#39 + 'enderecoestrutura.descricao'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.PickingFixo as '#39 + 'enderecoestrutura.pickingfixo'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.Mascara as '#39 + 'enderecoestrutura.mascara'#39 + ',');

    FConexao.Query.Sql.Add('   vEnd.Ruaid as '#39 + 'enderecorua.ruaid'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.Rua as '#39 + 'enderecorua.descricao'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.Lado as '#39 + 'enderecorua.lado'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.Ordem as '#39 + 'enderecorua.ordem'#39 + ', ');

    FConexao.Query.Sql.Add('   vEnd.ZonaId as '#39 + 'enderecamentozona.zonaid'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.Zona as '#39 + 'enderecamentozona.descricao'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.EstoqueTipoId as '#39 + 'enderecamentozona.estoquetipoid'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.ZonaStatus as '#39 + 'enderecamentozona.status'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.produtosngpc as '#39 + 'enderecamentozona.produtosngpc'#39 + ',');

    FConexao.Query.Sql.Add('   vEnd.DesenhoArmazemId AS '#39 + 'desenhoarmazem.Id'#39 + ',');
    FConexao.Query.Sql.Add('   vEnd.DesenhoArmazemDescricao AS '#39 + 'desenhoarmazem.descricao'#39 + ',');

    FConexao.Query.Sql.Add('   Coalesce(vEnd.produtoid, 0) as '#39 + 'produto.produtoid'#39 + ',');
    FConexao.Query.Sql.Add('   Coalesce(vEnd.codproduto, 0) as '#39 + 'produto.codproduto'#39 + ',');
    FConexao.Query.Sql.Add('   Coalesce(vEnd.descricao, ' + #39 + #39 + ') as '#39 + 'produto.descricao'#39 + ',');

    FConexao.Query.Sql.Add('   Coalesce(Est.Qtde, 0) as ' + #39 + 'produto.qtde' + #39 + ', ');
    FConexao.Query.Sql.Add('   Coalesce(EstPulmao.Qtde, 0) as ' + #39 + 'produto.qtdepulmao' + #39 + ', ');
    FConexao.Query.Sql.Add('   Coalesce(EstPicking.Qtde, 0) as ' + #39 + 'produto.qtdepicking' + #39 + ', ');
    FConexao.Query.Sql.Add('   Coalesce(EstReserva.Qtde, 0) as ' + #39 + 'produto.qtdereserva' + #39 + ', ');
    FConexao.Query.Sql.Add('   Coalesce(EstRepo.Qtde, 0) as ' + #39 + 'produto.qtdetransferencia' + #39);
    FConexao.Query.Sql.Add('  , 0 as Ocupacao --, (Case When Coalesce(EstProd.Ocupacao, 0) > 0 then EstProd.Ocupacao Else 0 End) Ocupacao');
    FConexao.Query.Sql.Add('   , (Case When vEnd.Curva is Null then ' + #39 + #39 + ' Else vEnd.Curva End) Curva');
    FConexao.Query.Sql.Add('From vEnderecamentos vEnd');
    // vQry.Sql.Add('Left Join (Select Produtoid, Coalesce(Sum(Qtde), 0) Qtde From vEstoque Group By ProdutoId) Est ON Est.Produtoid = vEnd.ProdutoId');
    FConexao.Query.Sql.Add('Left Join (Select EnderecoId, Coalesce(Sum(Qtde), 0) Qtde From vEstoque Group By EnderecoId) Est ON Est.Enderecoid = vEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join (Select CodigoERP, Coalesce(Sum(Qtde), 0) Qtde');
    FConexao.Query.Sql.Add('           From vEstoque Where EstruturaId <> 2');
    FConexao.Query.Sql.Add('           Group By CodigoERP) EstPulmao ON EstPulmao.CodigoERP = vEnd.CodProduto');
    FConexao.Query.Sql.Add('Left Join (Select EnderecoId, Coalesce(Sum(QtdeProducao), 0) Qtde ' );
    FConexao.Query.Sql.Add('           From vEstoque Where EstruturaId = 2 ');
    FConexao.Query.Sql.Add('           Group By EnderecoId) EstPicking ON EstPicking.EnderecoId = vEnd.EnderecoId');
    FConexao.Query.Sql.Add('Left Join (Select EnderecoId, Coalesce(Sum(QtdeReserva), 0) Qtde ');
    FConexao.Query.Sql.Add('           From vEstoque Group By EnderecoId) EstReserva ON EstReserva.EnderecoId = vEnd.EnderecoId');

    FConexao.Query.Sql.Add('Left Join (Select EnderecoId, Coalesce(Sum(Qtde), 0) Qtde ');
    FConexao.Query.Sql.Add('           From ReposicaoEstoqueTransferencia');
    FConexao.Query.Sql.Add('           Where Qtde > 0');
    FConexao.Query.Sql.Add('           Group By EnderecoId) EstRepo ON EstRepo.EnderecoId = vEnd.EnderecoId');

    FConexao.Query.Sql.Add('Left Join (Select vEst.EnderecoId,');
    FConexao.Query.Sql.Add('                  Cast(Sum(Prd.Volume*vEst.Qtde) As decimal(15,2)) Ocupacao2,');
    FConexao.Query.Sql.Add('                  Cast(Sum(Cast( Prd.Volume*vEst.Qtde As decimal(15,2))');
    FConexao.Query.Sql.Add('                           / Cast( (Case When TEnd.Volume <=0 then 1 else TEnd.Volume End) as Decimal(15,2)))');
    FConexao.Query.Sql.Add('						                     * 100 as decimal(15,2)) Ocupacao');
    FConexao.Query.Sql.Add('           From vEstoque vEst');
    FConexao.Query.Sql.Add('		         Inner join Enderecamentos TEnd On Tend.EnderecoId = vEst.EnderecoId');
    FConexao.Query.Sql.Add('		         Inner join vProduto Prd on Prd.CodProduto = vEst.CodigoERP');
    FConexao.Query.Sql.Add('		         Where vEst.Producao = 1 and vEst.Qtde > 0');
    FConexao.Query.Sql.Add('		         Group By vEst.EnderecoId) EstProd ON EstProd.Enderecoid = vEnd.EnderecoId');
    FConexao.Query.Sql.Add('Where (@EnderecoId = 0 or vEnd.EnderecoId = @EnderecoId) and ');
    FConexao.Query.Sql.Add('      (@EstruturaId = 0 or vEnd.EstruturaId = @EstruturaId) and');
    FConexao.Query.Sql.Add('      (@ZonaId = 0 or vEnd.ZonaId = @ZonaId) and');
    FConexao.Query.Sql.Add('      (@RuaId  = 0 or vEnd.RuaId  = @RuaId) and');
    FConexao.Query.Sql.Add('      (@EnderecoIni = ' + #39 + #39 + ' or vEnd.Endereco >= @EnderecoIni) and ');
    FConexao.Query.Sql.Add('      (@EnderecoFin = ' + #39 + #39 + ' or vEnd.Endereco <= @EnderecoFin) and ');
    FConexao.Query.Sql.Add('      ((@OcupacaoEndereco = ' + #39 + 'T' + #39 +') or (@OcupacaoEndereco=' + #39 + 'L' + #39 + ' and vEnd.ProdutoId Is Null) or ');
    FConexao.Query.Sql.Add('      (@OcupacaoEndereco=' + #39 + 'O' + #39 + ' and vEnd.ProdutoId is Not Null)) And ');
    FConexao.Query.Sql.Add('      (@Curva = ' + #39 + #39 + ' or vEnd.Curva = @Curva) and');
    FConexao.Query.Sql.Add('      (@Status Not In (0,1) or (@Status = Status))');
    if pListaZona <> '' then
      FConexao.Query.Sql.Add('      and (ZonaId in (' + pListaZona + '))');
    FConexao.Query.Sql.Add('Order by vEnd.Endereco'); // by RuaId, Lado, Endereco');
    FConexao.Query.Sql.Add('For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno');
    FConexao.Query.Sql.Add('SET NOCOUNT OFF');
    FConexao.Query.Sql.Add('SET TRANSACTION ISOLATION LEVEL READ COMMITTED');
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelEnderecoLista.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('ConsultaRetorno')
      .AsString = '') Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Endereço não encontrado.'));
    End
    Else
      Result := TJsonObject.ParseJSONValue
        (TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('ConsultaRetorno').AsString),
        0) as TjSonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamentos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.GetMotivoMovimentacaoSegregado: TjSonArray;
begin
  try
    FConexao.Query.Sql.Add
      ('Select EnderecoId, Endereco, Mascara, ZonaId From vEnderecamentos');
    FConexao.Query.Sql.Add('Where ZonaId in (1, 3) And Status = 1');
    FConexao.Query.Sql.Add('Order By ZonaId, Endereco');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há dados para gerar o relatório'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Erro: GetMotivoMovimentacaoSegregado - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.GetPickingMask: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.Open('Select Mascara From EnderecamentoEstruturas where Descricao = ' +
      QuotedStr('Picking'));
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('mascara',
      FConexao.Query.FieldByName('Mascara').AsString)));
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: Enderecamento - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.GetReUsoPicking(pZonaId, pDias: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlReUsoPicking);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pDias').Value := pDias;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelReUsoPicking.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Não há picking disponível para ReUso.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.GetZona(pEstruturaId: Integer): TjSonArray;
var
  vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := SqlEndereco;
    vSql := vSql + #13 + #10 + ' where ZonaId = ' + pEstruturaId.ToString();
    FConexao.Query.Open(vSql);
    while Not FConexao.Query.Eof do
    Begin
      With ObjEnderecoDAO do
      Begin
        EnderecoId := FConexao.Query.FieldByName('EnderecoId').AsInteger;
        EnderecoEstrutura.EstruturaId := FConexao.Query.FieldByName('EstruturaId')
          .AsInteger;
        EnderecoEstrutura.Descricao := FConexao.Query.FieldByName('Estrutura').AsString;
        EnderecamentoZona.ZonaId := FConexao.Query.FieldByName('ZonaId').AsInteger;
        EnderecamentoZona.Descricao := FConexao.Query.FieldByName('Zona').AsString;
        Descricao := FConexao.Query.FieldByName('Endereco').AsString;
        DesenhoArmazem.Id := FConexao.Query.FieldByName('DesenhoArmazemId').AsInteger;
        Altura := FConexao.Query.FieldByName('Altura').AsFloat;
        largura := FConexao.Query.FieldByName('Largura').AsFloat;
        Comprimento := FConexao.Query.FieldByName('Comprimento').AsFloat;
        Volume := FConexao.Query.FieldByName('Volume').AsFloat;
        Capacidade := FConexao.Query.FieldByName('Capacidade').AsFloat;
        Curva := FConexao.Query.FieldByName('Curva').AsString;
        Status := FConexao.Query.FieldByName('Status').AsInteger;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEnderecoDAO));
        FConexao.Query.Next;
      End;
    end;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: Enderecamento - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  end;
end;

function TEnderecoDao.InsertUpdate(pJsonEndereco: TJsonObject): TjSonArray;
var
  vSql: String;
begin
  try
    if pJsonEndereco.GetValue<Integer>('enderecoId') = 0 then
      vSql := 'Insert Into Enderecamentos (RuaId, EstruturaId, ZonaId, Descricao, DesenhoArmazemID, Altura, Largura, Comprimento, Volume, Capacidade, Curva, Status) Values ('
        + pJsonEndereco.GetValue<TJsonObject>('enderecoRua')
        .GetValue<Integer>('ruaId').ToString() + ', ' +
        pJsonEndereco.GetValue<TJsonObject>('enderecoEstrutura')
        .GetValue<Integer>('estruturaId').ToString() + ', ' +
        pJsonEndereco.GetValue<TJsonObject>('enderecamentoZona')
        .GetValue<Integer>('zonaId').ToString() + ', ' +
        QuotedStr(pJsonEndereco.GetValue<String>('descricao')) + ', ' +
        pJsonEndereco.GetValue<TJsonObject>('desenhoArmazem')
        .GetValue<Integer>('id').ToString() + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('altura').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('largura').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('comprimento').ToString(),
        ',', '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('volume').ToString(), ',',
        '.', [rfReplaceAll]) + ', ' +
        StringReplace(pJsonEndereco.GetValue<double>('capacidade').ToString(),
        ',', '.', [rfReplaceAll]) + ', ' +
        QuotedStr(pJsonEndereco.GetValue<String>('curva')) + ', 1)'
    Else
      vSql := 'Update Enderecamentos Set ' + sLineBreak +
        '     RuaId            = ' + pJsonEndereco.GetValue<TJsonObject>
        ('enderecoRua').GetValue<Integer>('ruaId').ToString() + sLineBreak +
        '   , EstruturaId      = ' + pJsonEndereco.GetValue<TJsonObject>
        ('enderecoEstrutura').GetValue<Integer>('estruturaId').ToString() +
        sLineBreak + '   , ZonaId           = ' +
        pJsonEndereco.GetValue<TJsonObject>('enderecamentoZona')
        .GetValue<Integer>('zonaId').ToString() + sLineBreak +
        '   , Descricao        = ' +
        QuotedStr(pJsonEndereco.GetValue<String>('descricao')) + sLineBreak +
        '   , DesenhoArmazemId = ' + pJsonEndereco.GetValue<TJsonObject>
        ('desenhoArmazem').GetValue<Integer>('id').ToString() + sLineBreak +
        '   , Altura           = ' +
        StringReplace(pJsonEndereco.GetValue<double>('altura').ToString(), ',',
        '.', [rfReplaceAll]) + sLineBreak + '   , Largura          = ' +
        StringReplace(pJsonEndereco.GetValue<double>('largura').ToString(), ',',
        '.', [rfReplaceAll]) + sLineBreak + '   , Comprimento      = ' +
        StringReplace(pJsonEndereco.GetValue<double>('comprimento').ToString(),
        ',', '.', [rfReplaceAll]) + sLineBreak + '   , Volume           = ' +
        StringReplace(pJsonEndereco.GetValue<double>('volume').ToString(), ',',
        '.', [rfReplaceAll]) + sLineBreak + '   , Capacidade       = ' +
        StringReplace(pJsonEndereco.GetValue<double>('capacidade').ToString(),
        ',', '.', [rfReplaceAll]) + sLineBreak + '   , Curva            = ' +
        QuotedStr(pJsonEndereco.GetValue<String>('curva')) + sLineBreak +
        '   , Status           = ' + pJsonEndereco.GetValue<Integer>('status')
        .ToString() + sLineBreak + 'where EnderecoId = ' +
        pJsonEndereco.GetValue<Integer>('enderecoId').ToString();
    FConexao.Query.Sql.Add(vSql);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EnderecoInsert.Sql');
    FConexao.Query.ExecSQL;
    Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Enderecamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.Manutencao(pJsonManutencao: TJsonObject): TJsonObject;
var
  vSql: String;
  
  xManutencao: Integer;
  vOperacao: String;
  vAcao: String;
  vZonaId: Integer;
  vPicking, vPickingNovo: String;
  vAltura, vLargura, vComprimento, vPeso: double;
  vEndereco: String;
  
begin
  try
    Fconexao.Query.Connection.StartTransaction;
    vOperacao := pJsonManutencao.GetValue<String>('operacao');
    if vOperacao = 'AtivaDesativa' then
      vAcao := pJsonManutencao.GetValue<String>('acao')
    Else if vOperacao = 'MudarZona' then
    Begin
      vZonaId := pJsonManutencao.GetValue<Integer>('zonaid');
    End
    Else if vOperacao = 'Cubagem' then
    Begin
      vAltura := pJsonManutencao.GetValue<double>('altura');
      vLargura := pJsonManutencao.GetValue<double>('largura');
      vComprimento := pJsonManutencao.GetValue<double>('comprimento');
      vPeso := pJsonManutencao.GetValue<double>('peso');
    End;
    if vOperacao <> 'Transferencia' then
    Begin
      For xManutencao :=
        0 to Pred(pJsonManutencao.GetValue<TjSonArray>('lista').Count) do
      Begin
        vEndereco := pJsonManutencao.GetValue<TjSonArray>('lista')
          .Items[xManutencao].GetValue<String>('endereco');
        if vOperacao = 'AtivaDesativa' then
        Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('Update Enderecamentos');
          if vAcao = 'Ativar' then
             FConexao.Query.Sql.Add('  Set Status = 1')
          Else
             FConexao.Query.Sql.Add('  Set Status = 0');
          FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'MudarZona' then
        Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('Update Enderecamentos');
          FConexao.Query.Sql.Add('  Set ZonaId = ' + vZonaId.ToString());
          FConexao.Query.Sql.Add
            ('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '
            + QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'Cubagem' then
        Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('Update Enderecamentos');
          FConexao.Query.Sql.Add('  Set Altura      = ' +
            StringReplace(vAltura.ToString(), ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add('    , Largura     = ' +
            StringReplace(vLargura.ToString(), ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add('    , Comprimento = ' +
            StringReplace(vComprimento.ToString(), ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add('    , Capacidade  = ' + StringReplace(vPeso.ToString(),
            ',', '.', [rfReplaceAll]));
          FConexao.Query.Sql.Add
            ('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '
            + QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'Excluir' then
        Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('Delete Enderecamentos');
          FConexao.Query.Sql.Add
            ('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '
            + QuotedStr(vEndereco) + ')');
        End
        Else if vOperacao = 'RemoverVinculo' then
        Begin
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add('update Produto');
          FConexao.Query.Sql.Add('  Set EnderecoId = Null');
          FConexao.Query.Sql.Add
            ('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = '
            + QuotedStr(vEndereco) + ')');
        End;
        if DebugHook <> 0 then
          FConexao.Query.Sql.SaveToFile('EnderecoManutencao.Sql');
        FConexao.Query.ExecSQL;
      End;
    End
    Else
    Begin
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('update Produto');
      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');
      FConexao.Query.Sql.Add('update Estoque');
      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');
      //Volumes Pendentes
//      FConexao.Query.Sql.Add('update Estoque');
//      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
//      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');

      FConexao.Query.Sql.Add('update ReposicaoEstoqueTransferencia');
      FConexao.Query.Sql.Add('  Set EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('pickingnovo')) + ')');
      FConexao.Query.Sql.Add('Where EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = ' + QuotedStr(pJsonManutencao.GetValue<String>('picking')) + ')');

      if DebugHook <> 0 then
         FConexao.Query.Sql.SaveToFile('EnderecoManutencao_TransfPicking.Sql');
      FConexao.Query.ExecSQL;
    End;
    Result := TJsonObject.Create.AddPair('Ok', 'Manutenção realizado com sucesso!');
    Fconexao.Query.Connection.Commit;
  Except ON E: Exception do
    Begin
      Fconexao.Query.Connection.Rollback;
      Result := TJsonObject.Create.AddPair('Erro', 'Tabela: Enderecamento - '+StringReplace(E.Message,
                '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TEnderecoDao.MontarPaginacao: TJsonObject;
var
  vSql: String;
begin
  Result := TJsonObject.Create;
  try
    FConexao.Query.Open('Select Count(*) Paginacao From Enderecamento');
    Result.AddPair('paginacao', TJsonNumber.Create(FConexao.Query.FieldByName('Paginacao')
      .AsInteger));
  Except
    On E: Exception do
    Begin
      Result.AddPair('Erro', E.Message);
    End;
  end;
end;

function TEnderecoDao.PutDesvincularPicking(pJsonArray: TjSonArray): TjSonArray;
var
  vSql: String;
  xEndereco: Integer;
  vParamSize: Integer;
begin
  FConexao.Query.connection.StartTransaction;
  try
    FConexao.Query.Close;
    FConexao.Query.Sql.Add
      ('Update Produto Set EnderecoId = Null Where EnderecoId = :pEnderecoId');
    FConexao.Query.Params.ArraySize := pJsonArray.Count;
    for xEndereco := 0 to Pred(pJsonArray.Count) do
    Begin
      FConexao.Query.Params[0].Values[xEndereco] := pJsonArray.Items[xEndereco]
        .GetValue<Integer>('enderecoid');
    End;
    FConexao.Query.Execute(FConexao.Query.Params.ArraySize, 0);
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Picking`s Liberados'));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create(E.Message);
    End;
  end;
end;

end.
