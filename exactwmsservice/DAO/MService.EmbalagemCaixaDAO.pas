unit MService.EmbalagemCaixaDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, FireDAC.Stan.Error,
   DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  EmbalagemCaixaClass, exactwmsservice.lib.connection,exactwmsservice.dao.base;

type

  TCaixaEmbalagemDao =class(TBasicDao)
  private
    

    FCaixaEmbalagem: TCaixaEmbalagem;
    Function TrataErroFireDac(pErro: EFDDBEngineException): String;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    Function Salvar: Boolean;
    function GetId(pCaixaEmbalagemId: Integer): TjSonArray;
    Function GetLista(pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin,
      pVolumeEmbalagemId: Integer; pSituacao: String; pStatus: Integer)
      : TjSonArray;
    Function Estrutura: TjSonArray;
    Function Delete: Boolean;
    Property ObjCaixaEmbalagem: TCaixaEmbalagem Read FCaixaEmbalagem
      Write FCaixaEmbalagem;
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

constructor TCaixaEmbalagemDao.Create;
begin
  ObjCaixaEmbalagem := TCaixaEmbalagem.Create;
  inherited;
end;

function TCaixaEmbalagemDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from CaixaEmbalagem where CaixaEmbalagemId= ' +
      Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TCaixaEmbalagemDao.Destroy;
begin
  
  ObjCaixaEmbalagem.Free;
  inherited;
end;

function TCaixaEmbalagemDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open(
    'SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('CaixaEmbalagem') +
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

function TCaixaEmbalagemDao.GetLista(pCaixaEmbalagemId, pSequenciaIni,
  pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus: Integer): TjSonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagemLista);
    FConexao.Query.ParamByName('pCaixaEmbalagemId').Value := pCaixaEmbalagemId;
    FConexao.Query.ParamByName('pSequenciaIni').Value := pSequenciaIni;
    FConexao.Query.ParamByName('pSequenciaFin').Value := pSequenciaFin;
    FConexao.Query.ParamByName('pVolumeEmbalagemId').Value := pVolumeEmbalagemId;
    FConexao.Query.ParamByName('pSituacao').Value := pSituacao;
    FConexao.Query.ParamByName('pStatus').Value := pStatus;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('CaixaEmbalagemLista.Sql');
    FConexao.Query.Open;
    if (FConexao.Query.IsEmpty) or (FConexao.Query.FieldByName('JsonRetorno').AsString = '') then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := TJsonObject.ParseJSONValue
        (TEncoding.UTF8.GetBytes(FConexao.Query.FieldByName('jsonRetorno').AsString), 0)
        as TjSonArray;
    // Result := vQry.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(Caixas Lista) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCaixaEmbalagemDao.GetId(pCaixaEmbalagemId: Integer): TjSonArray;
var
  ObjJson: TJsonObject;
  CaixaEmbalagemItensDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlCaixaEmbalagem);
    FConexao.Query.ParamByName('pCaixaEmbalagemId').Value := pCaixaEmbalagemId;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    begin
      if pCaixaEmbalagemId = 0 then
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          TuEvolutConst.QrySemDados))
      Else
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          'Caixa não encontrada!'))
    End
    Else
      while Not FConexao.Query.Eof do
        With ObjCaixaEmbalagem do
        Begin
          CaixaEmbalagemId := FConexao.Query.FieldByName('CaixaEmbalagemId').AsInteger;
          VolumeEmbalagem.EmbalagemId := FConexao.Query.FieldByName('EmbalagemId')
            .AsInteger;
          VolumeEmbalagem.Descricao := FConexao.Query.FieldByName('Descricao').AsString;
          VolumeEmbalagem.Tipo := FConexao.Query.FieldByName('Tipo').AsString;
          VolumeEmbalagem.TipoDescricao :=
            FConexao.Query.FieldByName('TipoDescricao').AsString;
          VolumeEmbalagem.Altura := FConexao.Query.FieldByName('Altura').AsFloat;
          VolumeEmbalagem.Largura := FConexao.Query.FieldByName('Largura').AsFloat;
          VolumeEmbalagem.Comprimento :=
            FConexao.Query.FieldByName('Comprimento').AsFloat;
          VolumeEmbalagem.Volume := FConexao.Query.FieldByName('Volume').AsFloat;
          VolumeEmbalagem.Aproveitamento := FConexao.Query.FieldByName('Aproveitamento')
            .AsInteger;
          VolumeEmbalagem.Tara := FConexao.Query.FieldByName('Tara').AsFloat;
          VolumeEmbalagem.Capacidade := FConexao.Query.FieldByName('Capacidade').AsFloat;
          VolumeEmbalagem.QtdLacres := FConexao.Query.FieldByName('QtdLacres').AsInteger;
          VolumeEmbalagem.CodBarras := FConexao.Query.FieldByName('CodBarras').AsInteger;
          VolumeEmbalagem.Disponivel := FConexao.Query.FieldByName('Disponivel')
            .AsInteger;
          VolumeEmbalagem.PrecoCusto := FConexao.Query.FieldByName('PrecoCusto').AsFloat;
          // VolumeEmbalagem.DtInclusao     := FConexao.Query.FieldByName('DtInclusao').AsDateTime;
          // VolumeEmbalagem.HrInclusao     := FConexao.Query.FieldByName('HrInclusao').AsDateTime;
          VolumeEmbalagem.Status := FConexao.Query.FieldByName('Status').AsInteger;
          NumSequencia := FConexao.Query.FieldByName('NumSequencia').AsInteger;
          Observacao := FConexao.Query.FieldByName('Observacao').AsString;
          Disponivel := FConexao.Query.FieldByName('Disponivel').AsInteger;
          Status := FConexao.Query.FieldByName('Status').AsInteger;
          Result.AddElement(tJson.ObjectToJsonObject(ObjCaixaEmbalagem,
            [joDateFormatISO8601]));
          FConexao.Query.Next;
        End;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: CaixaEmbalagem(Caixas) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TCaixaEmbalagemDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.ObjCaixaEmbalagem.CaixaEmbalagemId = 0 then
      vSql := 'Insert Into CaixaEmbalagem (EmbalagemId, NumSequencia, Observacao, Disponivel, Status) Values ('
        + Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString() + ', ' +
        Self.ObjCaixaEmbalagem.NumSequencia.ToString() + ', ' +
        QuotedStr(Self.ObjCaixaEmbalagem.Observacao) + ', ' +
        Self.ObjCaixaEmbalagem.Disponivel.ToString() + ', ' +
        Self.ObjCaixaEmbalagem.Status.ToString() + ')'
    Else
      vSql := ' Update CaixaEmbalagem ' +
      // '     Set NumSequencia = '+QuotedStr(Self.ObjCaixaEmbalagem.Descricao)+
        '   Set Observacao       = ' +
        QuotedStr(Self.ObjCaixaEmbalagem.Observacao) +
        '      ,Disponivel       = ' + Self.ObjCaixaEmbalagem.Disponivel.
        ToString() + '      , Status          = ' +
        Self.ObjCaixaEmbalagem.Status.ToString() + ' where CaixaEmbalagemId = '
        + Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;

  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

Function TCaixaEmbalagemDao.TrataErroFireDac
  (pErro: EFDDBEngineException): String;
begin
  case pErro.Kind of
    ekOther:
      Result := pErro.Message; // 'Operação com o Banco de Dados';
    ekNoDataFound:
      Result := 'Erro! Dados não encontrados';
    ekTooManyRows:
      Result := 'Excesso de Linhas';
    ekRecordLocked:
      Result := 'Registro com acesso bloqueado. Pode está sendo usado por outro processo.';
    ekUKViolated:
      Result := 'Tentativa de incluir registro já existente.';
    ekFKViolated:
      Result := 'Cadastro primário necessário inexistente.';
    ekObjNotExists:
      Result := 'Objeto não encontrado';
    ekUserPwdInvalid:
      Result := 'Usuário e/ou Senha inválido.';
    ekUserPwdExpired:
      Result := 'Usuário e/ou Senha expirou!';
    ekUserPwdWillExpire:
      Result := 'Usuário e/ou Senha prestes a expirar';
    ekCmdAborted:
      Result := 'Operação cancelada.';
    ekServerGone:
      Result := 'Servidor de Banco de Dados inexistente.';
    ekServerOutput:
      Result := 'Servidor de Banco de Dados parece está fora do ar.';
    ekArrExecMalfunc:
      Result := 'Operação mal sucedida.';
    ekInvalidParams:
      Result := 'Parâmetros inválidos para esta operação.';
  end;
  Result := 'Tabela: EnderecamentoRuas - ' + StringReplace(Result,
    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
    '', [rfReplaceAll]);
end;

end.
