unit MService.PedidoSaidaDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Math, FireDAC.Stan.Intf,
  FireDAC.Phys.Intf,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.Stan.Option, Web.HTTPApp, LotesClass, MService.ProdutoDAO,
  PedidoSaidaClass, PedidoProdutoClass, MService.PedidoProdutoDAO,
  exactwmsservice.lib.connection, exactwmsservice.lib.utils,
  exactwmsservice.dao.base;

type

  TPedidoSaidaDao = class(TBasicDao)
  private
    //

    FPedidoSaida: TPedidoSaida;
    function IfThen(AValue: Boolean; const ATrue: String;
      const AFalse: String = ''): String; overload; inline;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pPedidoId, pOperacaoTipoId, pPessoaId: Integer;
      pDocumentoNr: String; pDocumentoData: TDate; pArmazemId: Integer)
      : TjSonArray;
    Function Salvar: Boolean;
    function GetId(pPedidoId: Integer): TjSonArray;
    function GetPedidoAll(pPedidoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer;
      pRazao, pDocumentoNr, pRegistroERP: String;
      pRotaId, pProcessoId, pMontarCarga: Integer; pCodProduto: Int64;
      pPedidoPendente: Integer): TjSonArray;
    Function GetPedidoResumoAtendimento(pPedidoId: Integer;
      pDivergencia: Integer; pDataInicial, pDataFinal: TDate): TjSonArray;
    Function GetClientesRotaCarga(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetPendente: TjSonArray;
    function GetDocumento(pDocumento: String; pPessoaId: Integer): TjSonArray;
    Function Cancelar(pJsonPedidoCancelar: TJsonObject): Boolean;
    Function Delete: Boolean;
    Function Estrutura: TjSonArray;
    Function PedidoProcessar(pPedidoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer;
      pDocumentoNr, pRazao, pRegistroERP: String; pRotaId: Integer;
      pRotaIdFinal: Integer; pZonaId: Integer; pProcessoId: Integer;
      pRecebido, pCubagem, pEtiqueta, pPrintTag, pEmbalagem: Integer)
      : TjSonArray;
    Function PedidoPrintTag(pPedidoId: Integer; pPedidoVolumeId: Integer;
      pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer; pRazao: String;
      pRotaId: Integer; pRotaIdFinal: Integer; pZonaId: Integer;
      pProcessoId: Integer; pRecebido, pCubagem, pEtiqueta, pPrintTag,
      pEmbalagem: Integer): TjSonArray;
    Function ProdutoSemPicking(pPedidoId: Integer; pDataIni, pDataFin: TDate;
      pCodigoERP, pPessoaId: Integer; pDocumentoNr, pRazao, pRegistroERP: String; pRotaId: Integer;
      pRecebido, pCubagem, pEtiqueta, pverificarEstoque: Integer): TjSonArray;
    Function GetEstoqueCaixaFechada(pPedidoId: Integer): TjSonArray;
    Function CreateVolumeCaixaFechada(pJsonArray: TjSonArray): TjSonArray;
    Function GetLoteParaVolumeFracionado(pPedidoId: Integer): TjSonArray;
    Function GetEstoqueCaixaFracionada(pPedidoId: Integer): TjSonArray;
    Function CreateVolumeCaixaFracionada(pJsonArray: TjSonArray): TjSonArray;
    Function CancelarCubagem(pPedidoId: Integer): TjSonArray;
    Function GetProdutoReposicao(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetCortes(Const AParams: TDictionary<string, string>): TjSonArray;
    Function GetRelRupturaAbastecimento(pDataIni, pDataFin: TDateTime)
      : TjSonArray;
    Function GetRelColetaPulmao(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetRelApanhePicking(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetRelAnaliseRessuprimento(Const AParams
      : TDictionary<string, string>; pVolume: Boolean): TjSonArray;
    Function GetDashBoard0102(Const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function GetProducaoPendente: TjSonArray;
    Function GetDashBoard030405(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetDashBoard06(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetReposicaoGerar(pData: TDate; pZonaId: Integer;
      pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
    Function GetReposicaoEnderecoColeta(pData: TDate; pZonaId: Integer;
      pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
    Function ReposicaoSalvar(pJsonReposicao: TJsonObject): TjSonArray;
    Function PostReposicaoModelo(pJsonReposicao: TJsonObject): TjSonArray;
    Function GetReposicaoModelo(pModeloId: Integer): TjSonArray;
    Function DeleteReposicaoModelo(pModeloId: Integer): TjSonArray;
    Function ReposicaoSalvarItemColetado(pJsonReposicao: TjSonArray)
      : TjSonArray;
    Function ReposicaoFinalizar(pJsonReposicao: TjSonArray): TjSonArray;
    Function GetResumoProducao(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetAuditoriaSaidaPorProduto(Const AParams
      : TDictionary<string, string>): TjSonArray;
    Function GetMovimentacao(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetEvolucaoAtendimentoPed(Const pDataInicio,
      pDataTermino: TDateTime; pRotaId: Integer): TjSonArray;
    Function GetEvolucaoAtendimentoVol(Const pDataInicio,
      pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer): TjSonArray;
    Function GetEvolucaoAtendimentoUnid(Const pDataInicio,
      pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer): TjSonArray;
    Function GetEvolucaoAtendimentoUnidEmbalagem(Const pDataInicio,
      pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer;
      pTipo: String): TjSonArray;
    Function DeleteReservaCorrecao: TjSonArray;
    Function GetPedidoProcesso(pPedidoId: Integer): TjSonArray;
    Property PedidoSaida: TPedidoSaida Read FPedidoSaida Write FPedidoSaida;
    Function GetReposicaoAutomatica(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetReposicaoAutomaticaColeta(Const AParams
      : TDictionary<string, string>): TjSonArray;
    Function GetConsultaReposicao(Const AParams: TDictionary<string, string>)
      : TjSonArray;
    Function GetConsultaReposicaoProduto(pReposicaoId: Integer): TjSonArray;
    Function PutRegistrarProcesso(pJsonObject: TJsonObject): TjSonArray;

  end;

implementation

uses uSistemaControl, Constants,
  MService.PedidoVolumeDAO;

{ TClienteDao }

function TPedidoSaidaDao.Cancelar(pJsonPedidoCancelar: TJsonObject): Boolean;
var
  // vQryPedido, vQryVolumes2: TFDQuery;
  vSql: String;
  ObjPedidoVolumeDAO: TPedidoVolumeDAO;
  JsonVolumeCancelar: TJsonObject;
begin
  Result := False;
  try
    // Chamar Rotina de Cancelamento de Cubagem
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
    FConexao.Query.Close;
    FConexao.Query.SQL.Add
      ('Select PedidoVolumeId From PedidoVolumes Where PedidoId = ' +
      pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString);
    FConexao.Query.Open();
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    while Not FConexao.Query.Eof do
    Begin
      JsonVolumeCancelar := TJsonObject.Create;
      JsonVolumeCancelar.AddPair('pedidoVolumeId',
        TJsonNumber.Create(FConexao.Query.FieldByName('PedidoVolumeId')
        .Asinteger));
      JsonVolumeCancelar.AddPair('usuarioid',
        TJsonNumber.Create(pJsonPedidoCancelar.GetValue<String>('usuarioid')));
      JsonVolumeCancelar.AddPair('terminal',
        pJsonPedidoCancelar.GetValue<String>('terminal'));
      Try
        ObjPedidoVolumeDAO.Cancelar(FConexao.DB, JsonVolumeCancelar);
      Except
        On E: Exception do
          raise Exception.Create('Processo: CancelarVolumes - ' +
            StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
            '', [rfReplaceAll]));
      End;
      FConexao.Query.Next;
      JsonVolumeCancelar.Free;
    End;
    ObjPedidoVolumeDAO.Free;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    vSql := 'Update Pedido Set Status = 3 ' + #13 + #10 + 'where PedidoId = ' +
      pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString +
      ' and OperacaoTipoId = 2' + sLineBreak +
      'Insert Into DocumentoEtapas Values ' + sLineBreak +
      ' ( Cast((Select Uuid from Pedido Where Pedidoid = ' +
      pJsonPedidoCancelar.GetValue<Integer>('pedidoid').ToString() +
      ') as UNIQUEIDENTIFIER), ' + sLineBreak + '15, ' +
      pJsonPedidoCancelar.GetValue<Integer>('usuarioid').ToString() + ', ' +
      SqlDataAtual + ', ' + SqlHoraAtual + ', GetDate(), ' +
      QuotedStr(pJsonPedidoCancelar.GetValue<String>('terminal')) + ', 1)';
    FConexao.Query.ExecSQL(vSql);
    Result := True;
    FConexao.Query.connection.Commit;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Processo: CancelarPedido - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.CancelarCubagem(pPedidoId: Integer): TjSonArray;
Var
  vTransaction: Boolean;
begin
  FConexao.Query.connection.StartTransaction;
  Result := TjSonArray.Create;
  try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlCancelarCubagemPedido);
    FConexao.Query.ParamByName('pPedido').Value := pPedidoId;
    FConexao.Query.ExecSQL;
    FConexao.Query.connection.Commit;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Resultado',
      'Cancelamento de Cubagem realizado com sucess!')));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('N�o foi poss�vel cancelar a cubagem do pedido.' +
        sLineBreak + E.Message);
    End;
  end;
end;

constructor TPedidoSaidaDao.Create;
begin
  PedidoSaida := TPedidoSaida.Create;
  PedidoSaida.ListProduto := TObjectList<TPedidoProduto>.Create();
  inherited;;
end;

function TPedidoSaidaDao.Delete: Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Pedido where PedidoId = ' +
      Self.PedidoSaida.PedidoId.ToString + ' and OperacaoTipoId = 2';
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception Do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.DeleteReposicaoModelo(pModeloId: Integer): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add('Delete ReposicaoModelo');
    FConexao.Query.SQL.Add('Where ReposicaoModeloId = :pModeloId');
    FConexao.Query.ParamByName('pModeloId').Value := pModeloId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('DelteReposicaoModelo.Sql');
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Ok',
      'Registro exclu�do com sucesso!')));
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.DeleteReservaCorrecao: TjSonArray;
begin
  Try
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', 'Fun��o n�o usada...'));
  Except
    On E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TPedidoSaidaDao.Destroy;
begin
  PedidoSaida.ListProduto.Free;
  PedidoSaida.Free;
  inherited;
end;

function TPedidoSaidaDao.Estrutura: TjSonArray;
Var
  vRegEstrutura: TJsonObject;
begin
  Result := TjSonArray.Create;
  FConexao.Query.Open
    ('SELECT COLUMN_NAME As Nome, DATA_TYPE As Tipo, Coalesce(CHARACTER_MAXIMUM_LENGTH, 0) as Tamanho'
    + sLineBreak + 'FROM INFORMATION_SCHEMA.COLUMNS' + sLineBreak +
    'Where TABLE_NAME = ' + QuotedStr('Pedido') +
    ' and CHARACTER_MAXIMUM_LENGTH Is Not Null');
  if FConexao.Query.IsEmpty Then
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Sem Dados da Estrutura da Tabela.'))
  Else
  Begin
    Result := FConexao.Query.ToJSONArray();
  End;
end;

// revisar Try Except
Function TPedidoSaidaDao.CreateVolumeCaixaFechada(pJsonArray: TjSonArray)
  : TjSonArray;
Var
  xArray: Integer;
  xQtdVolume: Integer;
  xVolume: Integer;
  jsonVolume: TJsonObject;
  vSql: String;
  vGuuid: string;
  StartProc: Boolean;
Begin
  FConexao.Query.connection.StartTransaction;
  Result := TjSonArray.Create;
  StartProc := True;
  Try
    For xArray := 0 to Pred(pJsonArray.Count) do
    Begin
      jsonVolume := pJsonArray.Items[xArray] as TJsonObject;
      For xVolume := 1 to jsonVolume.GetValue<Integer>('qtvolume') do
      Begin // Criando o Volume
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add(TuEvolutConst.SqlCreateVolume);
        FConexao.Query.ParamByName('pPedidoId').Value :=
          jsonVolume.GetValue<Integer>('pedidoid');
        FConexao.Query.ParamByName('pEmbalagemId').Value := 0;
        FConexao.Query.ParamByName('pTerminal').Value :=
          jsonVolume.GetValue<String>('terminal');
        FConexao.Query.ParamByName('pUsuarioId').Value :=
          jsonVolume.GetValue<String>('usuarioid');
        vGuuid := TGUID.NewGuid.ToString();
        FConexao.Query.ParamByName('pNewId').Value := vGuuid;
        if DebugHook <> 0 then
          FConexao.Query.SQL.SaveToFile('CreateVolume.Sql');
        Try
          FConexao.Query.ExecSQL; // Definindo os Lotes do Volume
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add(TuEvolutConst.SqlGerarVolumeLoteCaixaFechada);
          FConexao.Query.ParamByName('pNewId').Value := vGuuid;
          FConexao.Query.ParamByName('pLoteId').Value :=
            jsonVolume.GetValue<Integer>('loteid');
          FConexao.Query.ParamByName('pEnderecoId').Value :=
            jsonVolume.GetValue<Integer>('enderecoid');
          FConexao.Query.ParamByName('pEstoqueTipoId').Value :=
            jsonVolume.GetValue<Integer>('estoquetipoid');
          FConexao.Query.ParamByName('pQuantidade').Value :=
            jsonVolume.GetValue<Integer>('quantidade');
          FConexao.Query.ParamByName('pEmbalagemPadrao').Value :=
            jsonVolume.GetValue<Integer>('embalagempadrao');
          FConexao.Query.ParamByName('pTerminal').Value :=
            jsonVolume.GetValue<String>('terminal');
          FConexao.Query.ParamByName('pUsuarioId').Value :=
            jsonVolume.GetValue<String>('usuarioid');
          FConexao.Query.ExecSQL;
        Except
          ON E: Exception do
          Begin
            raise Exception.Create('PedidoId = ' + jsonVolume.GetValue<Integer>
              ('pedidoid').ToString + ' ' + E.Message);
          End;
        End;
      End;
      // Reserva de Estoque
      Try
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add
          ('--PedidoSaidaDao.CreateVolumeCaixaFechada - Reserva de Estoque');
        FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
        FConexao.Query.ParamByName('pLoteId').Value :=
          jsonVolume.GetValue<Integer>('loteid');
        FConexao.Query.ParamByName('pEnderecoId').Value :=
          jsonVolume.GetValue<Integer>('enderecoid');
        FConexao.Query.ParamByName('pEstoqueTipoId').Value := 6;
        FConexao.Query.ParamByName('pQuantidade').Value :=
          jsonVolume.GetValue<Integer>('quantidade') *
          jsonVolume.GetValue<Integer>('qtvolume');
        FConexao.Query.ParamByName('pUsuarioId').Value :=
          jsonVolume.GetValue<String>('usuarioid');
        FConexao.Query.ExecSQL;
      Except
        ON E: Exception do
        Begin
          raise Exception.Create(E.Message);
        End;
      end;
    End;
    // retirar processo de Registro de Processo daqui e realizar no Front ap�s Calcular Fracionados
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '
      + jsonVolume.GetValue<Integer>('pedidoid').ToString + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    if jsonVolume.GetValue<Integer>('reprocessado') = 0 then
      FConexao.Query.ParamByName('pProcessoId').Value := 2
      // 2	Cubagem Realizada
    else
      FConexao.Query.ParamByName('pProcessoId').Value := 21;
    // 21	Re-Processado
    FConexao.Query.ParamByName('pTerminal').Value :=
      jsonVolume.GetValue<String>('terminal');
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      jsonVolume.GetValue<String>('usuarioid');
    // ClipBoard.AsText := FConexao.Query.Sql.Text;
    // FConexao.Query.ExecSql;
    FConexao.Query.connection.Commit;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Resultado',
      'Volume(s) criado com sucesso!')));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  End;
end;

// Revisar Try Except
function TPedidoSaidaDao.CreateVolumeCaixaFracionada(pJsonArray: TjSonArray)
  : TjSonArray;
Var
  xArray: Integer;
  xQtdVolume: Integer;
  xVolume, xLotes: Integer;
  jsonVolume, jsonVolumeLotes: TJsonObject;
  ArrayJsonVolumeLotes: TjSonArray;
  vSql: String;
  vGuuid: string;
  StartProc: Boolean;
  pTerminal: string;
  pUsuarioId: Integer;
  pPedidoId: Integer;
begin
  FConexao.Query.connection.StartTransaction;
  Result := TjSonArray.Create;
  StartProc := True;
  Try
    For xArray := 0 to Pred(pJsonArray.Count) do
    Begin // Quantidade Volumes Gerados na Cubagem do Produto
      jsonVolume := pJsonArray.Items[xArray] as TJsonObject;
      // for xVolume := 1 to jsonVolume.GetValue<Integer>('qtvolume') do Begin
      // Criando o Volume
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add(TuEvolutConst.SqlCreateVolume);
      FConexao.Query.ParamByName('pPedidoId').Value :=
        jsonVolume.GetValue<Integer>('pedidoid');
      pPedidoId := jsonVolume.GetValue<Integer>('pedidoid');
      // FConexao.Query.ParamByName('pNumVolume').Value   := jsonVolume.GetValue<Integer>('numvolume');
      FConexao.Query.ParamByName('pEmbalagemId').Value :=
        jsonVolume.GetValue<Integer>('embalagemid');
      pTerminal := jsonVolume.GetValue<String>('terminal');
      pUsuarioId := jsonVolume.GetValue<Integer>('usuarioid');
      FConexao.Query.ParamByName('pTerminal').Value := pTerminal;
      FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
      ArrayJsonVolumeLotes := jsonVolume.Get('lotes').JsonValue as TjSonArray;
      vGuuid := TGUID.NewGuid.ToString();
      FConexao.Query.ParamByName('pNewId').Value := vGuuid;
      // ClipBoard.AsText := vGuuid;
      FConexao.Query.ExecSQL;
      try
        // Definindo os Lotes do Volume
        for xLotes := 0 to Pred(ArrayJsonVolumeLotes.Count) do
        Begin
          jsonVolumeLotes := ArrayJsonVolumeLotes.Items[xLotes] as TJsonObject;
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add(TuEvolutConst.SqlGerarVolumeLoteCaixaFechada);
          FConexao.Query.ParamByName('pNewId').Value := vGuuid;
          FConexao.Query.ParamByName('pLoteId').Value :=
            jsonVolumeLotes.GetValue<Integer>('loteid');
          FConexao.Query.ParamByName('pEnderecoId').Value :=
            jsonVolumeLotes.GetValue<Integer>('enderecoid');
          FConexao.Query.ParamByName('pEstoqueTipoId').Value :=
            jsonVolumeLotes.GetValue<Integer>('estoquetipoid'); // 4;
          FConexao.Query.ParamByName('pQuantidade').Value :=
            jsonVolumeLotes.GetValue<Integer>('quantidade');
          FConexao.Query.ParamByName('pEmbalagemPadrao').Value :=
            jsonVolumeLotes.GetValue<Integer>('embalagempadrao');
          FConexao.Query.ParamByName('pTerminal').Value := pTerminal;
          FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
          FConexao.Query.ExecSQL;

          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add
            ('--PedidoSaidaDao.CreateVolumeCaixaFracionada');
          FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
          FConexao.Query.SQL.Add('-- EnderecoId = ' +
            jsonVolumeLotes.GetValue<Integer>('enderecoid').ToString());
          FConexao.Query.ParamByName('pLoteId').Value :=
            jsonVolumeLotes.GetValue<Integer>('loteid');
          FConexao.Query.ParamByName('pEnderecoId').Value :=
            jsonVolumeLotes.GetValue<Integer>('enderecoid');
          FConexao.Query.ParamByName('pEstoqueTipoId').Value := 6;
          FConexao.Query.ParamByName('pQuantidade').Value :=
            jsonVolumeLotes.GetValue<Integer>('quantidade');
          // *jsonVolumeLotes.GetValue<Integer>('embalagempadrao');
          FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
          FConexao.Query.ExecSQL;
        End;
      Except
        ON E: Exception do
        Begin
          raise Exception.Create(E.Message);
        End;
      end;
      // End;
    End;
    // ProdutoId	EmbPrim	EmbSec	MesSaidaMinima	LoteId	Vencimento	EnderecoId	Endereco	Estrutura	Qtde	DtEntrada	HrEntrada	EstoqueTipoId	TipoEstoque	Producao	Distribuicao	CxaFechada
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '
      + jsonVolume.GetValue<Integer>('pedidoid').ToString + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    if jsonVolume.GetValue<Integer>('reprocessado') = 0 then
      FConexao.Query.ParamByName('pProcessoId').Value := 2
      // 2	Cubagem Realizada
    else
      FConexao.Query.ParamByName('pProcessoId').Value := 21;
    // 21	Re-Processado

    FConexao.Query.ParamByName('pTerminal').Value := pTerminal;
    FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    // ClipBoard.AsText := FConexao.Query.Sql.Text;
    // FConexao.Query.ExecSql;
    FConexao.Query.connection.Commit;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Resultado',
      'Volume(s) criado com sucesso!')));
    FConexao.Query.Close;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  End;
end;

function TPedidoSaidaDao.GetEstoqueCaixaFechada(pPedidoId: Integer): TjSonArray;
var
  vSql: String;
  jsonEstoqueDisponivel: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoqueCubagemCxaFechada);
    // Pegar Estoque para Processar Caixa Fechada
    FConexao.Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('EstoqueCaixaFechada.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'N�o h� c�lculo para caixa fechada!')));
      Exit;
    End;
    With FConexao.Query do
      While Not FConexao.Query.Eof do
      Begin
        jsonEstoqueDisponivel := TJsonObject.Create();
        jsonEstoqueDisponivel.AddPair('produtoid', TJsonNumber.Create(FieldByName('produtoid').Asinteger));
        jsonEstoqueDisponivel.AddPair('embprim', TJsonNumber.Create(FieldByName('embprim').Asinteger));
        jsonEstoqueDisponivel.AddPair('embsec', TJsonNumber.Create(FieldByName('embsec').Asinteger));
        jsonEstoqueDisponivel.AddPair('messaidaminima', TJsonNumber.Create(FieldByName('messaidaminima').Asinteger));
        jsonEstoqueDisponivel.AddPair('loteid', TJsonNumber.Create(FieldByName('loteid').Asinteger));
        jsonEstoqueDisponivel.AddPair('vencimento', FieldByName('Vencimento').AsString);
        jsonEstoqueDisponivel.AddPair('enderecoid', TJsonNumber.Create(FieldByName('enderecoid').Asinteger));
        jsonEstoqueDisponivel.AddPair('qtdpedido', TJsonNumber.Create(FieldByName('qtdpedido').Asinteger));
        jsonEstoqueDisponivel.AddPair('embalagempadrao', TJsonNumber.Create(FieldByName('EmbalagemPadrao').Asinteger));
        jsonEstoqueDisponivel.AddPair('qtde', TJsonNumber.Create(FieldByName('qtde').Asinteger));
        jsonEstoqueDisponivel.AddPair('bloqueado', TJsonNumber.Create(0));
        jsonEstoqueDisponivel.AddPair('dtentrada', FieldByName('dtentrada').AsString);
        jsonEstoqueDisponivel.AddPair('hrentrada', FieldByName('hrentrada').AsString);
        jsonEstoqueDisponivel.AddPair('estoquetipoid', TJsonNumber.Create(FieldByName('EstoqueTipoId').Asinteger));
        Result.AddElement(jsonEstoqueDisponivel);
        Next;
      End;
    // ProdutoId	EmbPrim	EmbSec	MesSaidaMinima	LoteId	Vencimento	EnderecoId	Endereco	Estrutura	Qtde	DtEntrada	HrEntrada	EstoqueTipoId	TipoEstoque	Producao	Distribuicao	CxaFechada
  Except ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.GetEstoqueCaixaFracionada(pPedidoId: Integer)
  : TjSonArray;
var
  vSql: String;
  jsonEstoqueDisponivel: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoqueVolumeCaixaFracionada);
    FConexao.Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('EstoqueFracionado.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('MSG',
        'Pedido(' + pPedidoId.ToString() +
        '). Sem c�lculo para Fracionado!!')));
      Exit;
    End
    Else
      Result := FConexao.Query.ToJSONArray(); // Alterado em 26/07/23
    // ProdutoId	EmbPrim	EmbSec	MesSaidaMinima	LoteId	Vencimento	EnderecoId	Endereco	Estrutura	Qtde	DtEntrada	HrEntrada	EstoqueTipoId	TipoEstoque	Producao	Distribuicao	CxaFechada
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoPed(const pDataInicio,
  pDataTermino: TDateTime; pRotaId: Integer): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetEvolucaoAtendimentoPed);
    if pDataInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDataInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.SQL.Add('--DtInicio = ' + FormatDateTime('YYYY-MM-DD',
      pDataInicio));
    FConexao.Query.SQL.Add('--DtTermino = ' + FormatDateTime('YYYY-MM-DD',
      pDataTermino));
    FConexao.Query.SQL.Add('--RotaId = ' + pRotaId.ToString);
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoPed.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Dados n�o encontrados para a pesquisa.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnid(const pDataInicio,
  pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetEvolucaoAtendimentoUnid);
    if pDataInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := 0
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoUnid.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados da Estrutura da Tabela.'))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoUnidEmbalagem(const pDataInicio,
  pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer; pTipo: String)
  : TjSonArray;
begin
  Try
    if pTipo = 'Unid' then
      FConexao.Query.SQL.Add
        (TuEvolutConst.SqlGetEvolucaoAtendimentoUnidEmbalagem)
    Else
      FConexao.Query.SQL.Add
        (TuEvolutConst.SqlGetEvolucaoAtendimentoVolEmbalagem);
    if pDataInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := 0
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoUnidEmbalagem.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Evolu��o do Ressuprimento(Detalhes).'))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Tabela: Perfil - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetEvolucaoAtendimentoVol(const pDataInicio,
  pDataTermino: TDateTime; pZonaId: Integer; pRotaId: Integer): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetEvolucaoAtendimentoVol);
    if pDataInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDataInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicio);
    if pDataTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := 0
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDataTermino);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('EvolucaoAtendimentoVol.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty Then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Dados n�o encontrados para a pesquisa.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDashBoard0102(Const AParams
  : TDictionary<string, string>): TJsonObject;
Var
  pDtInicio, pDtTermino: TDate;
begin
  Try
    Result := TJsonObject.Create;
    pDtInicio := 0;
    pDtTermino := 0;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashboad0102);
    if AParams.ContainsKey('dtinicio') then
      pDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      pDtTermino := StrToDate(AParams.Items['dttermino']);
    if pDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDtInicio);
    if pDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := pDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDtTermino);
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('DashBoard0102.Sql');
    FConexao.Query.Open;
    Result.AddPair('diario', FConexao.Query.ToJSONArray);
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashboad0102);
    FConexao.Query.ParamByName('pDtInicio').Value := (pDtInicio - 31);
    FConexao.Query.ParamByName('pDtTermino').Value := (pDtInicio - 1);
    FConexao.Query.Open;
    Result.AddPair('mensal', FConexao.Query.ToJSONArray);
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDashBoard030405(Const AParams
  : TDictionary<string, string>): TjSonArray;
Var
  pDtInicio, pDtTermino: TDate;
begin
  Try
    pDtInicio := 0;
    pDtTermino := 0;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashboard030405);
    if AParams.ContainsKey('dtinicio') then
      pDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      pDtTermino := StrToDate(AParams.Items['dttermino']);
    if pDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDtInicio);
    if pDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := pDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDtTermino);
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDashBoard06(Const AParams
  : TDictionary<string, string>): TjSonArray;
Var
  pDtInicio, pDtTermino: TDate;
Begin
  Try
    pDtInicio := 0;
    pDtTermino := 0;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlDashBoard06);
    if AParams.ContainsKey('dtinicio') then
      pDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      pDtTermino := StrToDate(AParams.Items['dttermino']);
    if pDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := pDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDtInicio);
    if pDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := pDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDtTermino);
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Proc: GetEvolucaoAtendimentoVol - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetDocumento(pDocumento: String; pPessoaId: Integer)
  : TjSonArray;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedido);
    FConexao.Query.ParamByName('pPedidoId').Value := 0;
    FConexao.Query.ParamByName('pDataIni').Value := 0;
    FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumento;
    FConexao.Query.ParamByName('pRazao').Value := '';
    FConexao.Query.ParamByName('pRegistroERP').Value := '';
    FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := 0;
    FConexao.Query.ParamByName('pOPeracaoTipoId').Value := 2;
    FConexao.Query.ParamByName('pZonaId').Value := 0;
    FConexao.Query.ParamByName('pProcessoId').Value := 0;
    FConexao.Query.ParamByName('pMontarCarga').Value := 2;
    FConexao.Query.ParamByName('pCodProduto').Value := 0;
    FConexao.Query.ParamByName('pPedidoPendente').Value := 0;
    FConexao.Query.ParamByName('pCargaId').Value := 0;
    FConexao.Query.ParamByName('pNotaFiscalERP').Value := '';
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoDocumento.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetId(pPedidoId: Integer): TjSonArray;
var
  ObjPedidoProduto: TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  ArrayPedidoProdutoDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedido);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pDataIni').Value := 0;
    FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := 0;

    FConexao.Query.ParamByName('pPessoaId').Value := 0;
    FConexao.Query.ParamByName('pDocumentoNr').Value := '';
    FConexao.Query.ParamByName('pRazao').Value := '';
    FConexao.Query.ParamByName('pRegistroERP').Value := '';
    FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := 0;
    FConexao.Query.ParamByName('pZonaId').Value := 0;
    FConexao.Query.ParamByName('pOperacaoTipoId').Value := 2;
    FConexao.Query.ParamByName('pProcessoId').Value := 0;
    FConexao.Query.ParamByName('pMontarCarga').Value := 2;
    FConexao.Query.ParamByName('pCodProduto').Value := 0;
    FConexao.Query.ParamByName('pPedidoPendente').Value := 0;
    FConexao.Query.ParamByName('pCargaId').Value := 0;
    FConexao.Query.ParamByName('pNotaFiscalERP').Value := '';

    if pPedidoId = 0 then
      FConexao.Query.ParamByName('pPedidoPendente').Value := 1;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      while Not FConexao.Query.Eof do
      Begin
        PedidoSaida.PedidoId := FConexao.Query.FieldByName('PedidoId')
          .Asinteger;
        PedidoSaida.OperacaoTipo.OperacaoTipoId :=
          FConexao.Query.FieldByName('OperacaoTipoId').Asinteger;
        PedidoSaida.OperacaoTipo.Descricao := FConexao.Query.FieldByName
          ('OperacaoTipo').AsString;
        PedidoSaida.Pessoa.PessoaId := FConexao.Query.FieldByName('PessoaId')
          .Asinteger;
        PedidoSaida.Pessoa.Razao := FConexao.Query.FieldByName('Razao')
          .AsString;
        PedidoSaida.DocumentoNr := FConexao.Query.FieldByName
          ('DocumentoNr').AsString;
        PedidoSaida.DocumentoData := FConexao.Query.FieldByName('DocumentoData')
          .AsDateTime;
        PedidoSaida.DtInclusao := FConexao.Query.FieldByName('DtInclusao')
          .AsDateTime;
        PedidoSaida.HrInclusao := FConexao.Query.FieldByName('HrInclusao')
          .AsDateTime;
        PedidoSaida.ArmazemId := FConexao.Query.FieldByName('ArmazemId')
          .Asinteger;
        PedidoSaida.Status := FConexao.Query.FieldByName('Status').Asinteger;
        PedidoSaida.uuid := FConexao.Query.FieldByName('uuid').AsString;
        // vQryProduto.Open('Declare @Pedido Integer = '+FConexao.Query.FieldByName('PedidoId').AsString+#13+#10+SqlPedidoProdutos);
        ObjPedidoSaidaItensDAO := TPedidoProdutoDAO.Create;
        ArrayPedidoProdutoDAO := ObjPedidoSaidaItensDAO.GetId(pPedidoId);
        // vQryProduto.FieldByName('PedidoId').AsInteger);
        for vItens := 0 to ArrayPedidoProdutoDAO.Count - 1 do
        Begin
          ObjPedidoProduto := ObjPedidoProduto.JsonToClass
            (ArrayPedidoProdutoDAO.Items[vItens].ToString());
          PedidoSaida.ListProduto.Add(ObjPedidoProduto);
        End;
        Result.AddElement(tJson.ObjectToJsonObject(PedidoSaida,
          [joDateFormatISO8601]));
        ObjPedidoSaidaItensDAO.Free;
        FConexao.Query.Next;
      End;
    ObjPedidoProduto := Nil;
    ArrayPedidoProdutoDAO := nil;
  Except
    ON E: Exception do
    Begin
      ObjPedidoProduto := Nil;
      ArrayPedidoProdutoDAO := nil;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetLoteParaVolumeFracionado(pPedidoId: Integer)
  : TjSonArray;
var
  vSql: String;
  jsonEstoqueDisponivel: TJsonObject;
begin
  try
    // FConexao.Query.SQL.Add(TuEvolutConst.SqlGetLoteParaVolumeFracionado);
    // clipboard.AsText := FConexao.Query.SQL.Text;
    FConexao.Query.ParamByName('pPedidoid').Value := pPedidoId.ToString();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('LoteParaVolumeFracionado.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Pedido(' + pPedidoId.ToString() + ') indispon�vel para Cubagem!')));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  end;
end;

function TPedidoSaidaDao.GetMovimentacao(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetMovimentacaoRessuprimento);
    if AParams.ContainsKey('pedidoid') then
      FConexao.Query.ParamByName('pPedidoId').Value := AParams.Items['pedidoid']
        .ToInteger()
    Else
      FConexao.Query.ParamByName('pPedidoId').Value := 0;
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('produtoid') then
      FConexao.Query.ParamByName('pProdutoid').Value :=
        AParams.Items['produtoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pProdutoId').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('MovimentacaoRessuprimento.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para gerar o Resumo da Produ��o.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        E.Message)));
    End;
  End;
end;

function TPedidoSaidaDao.GetPedidoAll(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pRazao, pDocumentoNr, pRegistroERP: String;
  pRotaId, pProcessoId, pMontarCarga: Integer; pCodProduto: Int64;
  pPedidoPendente: Integer): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  Result := TjSonArray.Create;
  try
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedido);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni = 0 then
       FConexao.Query.ParamByName('pDataIni').Value := pDataIni
    Else
       FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
       FConexao.Query.ParamByName('pDataFin').Value := pDataFin
    Else
       FConexao.Query.ParamByName('pDataFin').Value  := FormatDateTime('YYYY-MM-DD', pDataFin);
    FConexao.Query.ParamByName('pCodigoERP').Value   := pCodigoERP;
    FConexao.Query.ParamByName('pPessoaId').Value    := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value       := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value      := pRotaId;
    FConexao.Query.ParamByName('pProcessoId').Value  := pProcessoId;
    FConexao.Query.ParamByName('pMontarCarga').Value := pMontarCarga;
    FConexao.Query.ParamByName('pCodProduto').Value  := pCodProduto;
    FConexao.Query.ParamByName('pPedidoPendente').Value := pPedidoPendente;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoAll.Sql');
    FConexao.Query.ParamByName('pOperacaoTipoId').Value := 2;
    // FConexao.Query.ResourceOptions.CmdExecMode := amAsync;
    FConexao.Query.Open;
    // while FConexao.Query.Command.State = csExecuting do begin
    // do something while query is executing
    // end;
    // FConexao.Query.ResourceOptions.CmdExecMode := amBlocking;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      while Not FConexao.Query.Eof do
      Begin
        JsonRetorno := TJsonObject.Create();
        JsonRetorno.AddPair('pedidoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('PedidoId').Asinteger));
        JsonRetorno.AddPair('operacaotipoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('OperacaoTipoId')
          .Asinteger));
        JsonRetorno.AddPair('operacao',
          FConexao.Query.FieldByName('OperacaoTipo').AsString);
        JsonRetorno.AddPair('pessoaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('PessoaId').Asinteger));
        JsonRetorno.AddPair('codpessoaerp',
          TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaErp')
          .Asinteger));
        JsonRetorno.AddPair('razao', FConexao.Query.FieldByName('Razao')
          .AsString);
        JsonRetorno.AddPair('documentooriginal',
          FConexao.Query.FieldByName('DocumentoOriginal').AsString);
        JsonRetorno.AddPair('documentonr',
          FConexao.Query.FieldByName('DocumentoNr').AsString);
        JsonRetorno.AddPair('documentodata',
          DateToStr(FConexao.Query.FieldByName('DocumentoData').AsDateTime));
        JsonRetorno.AddPair('dtinclusao',
          DateToStr(FConexao.Query.FieldByName('DtInclusao').AsDateTime));
        JsonRetorno.AddPair('hrinclusao',
          TimeToStr(StrToTime(Copy(FConexao.Query.FieldByName('HrInclusao')
          .AsString, 1, 8))));
        JsonRetorno.AddPair('armazemid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ArmazemId')
          .Asinteger));
        JsonRetorno.AddPair('status',
          TJsonNumber.Create(FConexao.Query.FieldByName('Status').Asinteger));
        JsonRetorno.AddPair('rotaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
        JsonRetorno.AddPair('rota', FConexao.Query.FieldByName('Rota')
          .AsString);
        JsonRetorno.AddPair('processoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('ProcessoId')
          .Asinteger));
        JsonRetorno.AddPair('dtprocesso',
          FConexao.Query.FieldByName('DtProcesso').AsString);
        JsonRetorno.AddPair('etapa', FConexao.Query.FieldByName('Etapa')
          .AsString);
        JsonRetorno.AddPair('cargaid',
          TJsonNumber.Create(FConexao.Query.FieldByName('CargaId').Asinteger));
        JsonRetorno.AddPair('processoidcarga',
          TJsonNumber.Create(FConexao.Query.FieldByName('ProcessoIdCarga')
          .Asinteger));
        JsonRetorno.AddPair('processocarga',
          FConexao.Query.FieldByName('ProcessoCarga').AsString);
        JsonRetorno.AddPair('carregamentoid',
          TJsonNumber.Create(FConexao.Query.FieldByName('CarregamentoId')
          .Asinteger));
        JsonRetorno.AddPair('picking',
          TJsonNumber.Create(FConexao.Query.FieldByName('Picking').Asinteger));
        JsonRetorno.AddPair('itens',
          TJsonNumber.Create(FConexao.Query.FieldByName('Itens').Asinteger));
        JsonRetorno.AddPair('demanda',
          TJsonNumber.Create(FConexao.Query.FieldByName('Demanda').Asinteger));
        JsonRetorno.AddPair('qtdsuprida',
          TJsonNumber.Create(FConexao.Query.FieldByName('QtdSuprida')
          .Asinteger));
        JsonRetorno.AddPair('registroerp',
          FConexao.Query.FieldByName('RegistroERP').AsString);
        JsonRetorno.AddPair('uuid', FConexao.Query.FieldByName('uuid')
          .AsString);
        JsonRetorno.AddPair('tvolumes',
          TJsonNumber.Create(FConexao.Query.FieldByName('TVolCxaFechada')
          .Asinteger + FConexao.Query.FieldByName('TVOlFracionado').Asinteger +
          FConexao.Query.FieldByName('Cancelado').Asinteger));
        JsonRetorno.AddPair('tvolCxaFechada',
          TJsonNumber.Create(FConexao.Query.FieldByName('TVolCxaFechada')
          .Asinteger));
        JsonRetorno.AddPair('tvolFracionado',
          TJsonNumber.Create(FConexao.Query.FieldByName('TVOlFracionado')
          .Asinteger));
        JsonRetorno.AddPair('cancelado',
          TJsonNumber.Create(FConexao.Query.FieldByName('Cancelado')
          .Asinteger));
        JsonRetorno.AddPair('peso',
          TJsonNumber.Create(FConexao.Query.FieldByName('Peso').AsFloat));
        JsonRetorno.AddPair('volcm3',
          TJsonNumber.Create(FConexao.Query.FieldByName('VolCm3').AsFloat));
        JsonRetorno.AddPair('volm3',
          TJsonNumber.Create(FConexao.Query.FieldByName('Volm3').AsFloat));
        JsonRetorno.AddPair('processado',
          TJsonNumber.Create(FConexao.Query.FieldByName('Processado')
          .Asinteger));
        JsonRetorno.AddPair('concluido',
          TJsonNumber.Create(FConexao.Query.FieldByName('Concluido')
          .Asinteger));
        Result.AddElement(JsonRetorno);
        // tJson.ObjectToJsonObject(PedidoSaida, [joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
  finally
    FConexao.Query.Close
  end;
end;

function TPedidoSaidaDao.GetPedidoProcesso(pPedidoId: Integer): TjSonArray;
Var
  JsonVolumeHistorico: TJsonObject;
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedidoProcesso);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoProcesso.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: PedidoProcesso - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetPedidoResumoAtendimento(pPedidoId: Integer;
  pDivergencia: Integer; pDataInicial, pDataFinal: TDate): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetPedidoResumoAtendimento);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pDivergencia').Value := pDivergencia;
    FConexao.Query.ParamByName('pDataInicial').Value := 0;
    FConexao.Query.ParamByName('pDataFinal').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoResumoAtendimento.Sql');

    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
  end;
end;

function TPedidoSaidaDao.GetAuditoriaSaidaPorProduto(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetAuditoriaSaidaPorProduto);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('pedidoid') then
      FConexao.Query.ParamByName('pPedidoid').Value := AParams.Items['pedidoid']
        .ToInteger()
    Else
      FConexao.Query.ParamByName('pPedidoId').Value := 0;
    if AParams.ContainsKey('codproduto') then
      FConexao.Query.ParamByName('pCodProduto').Value :=
        AParams.Items['codproduto'].ToInteger()
    Else
      FConexao.Query.ParamByName('pusuarioid').Value := 0;
    if AParams.ContainsKey('descrlote') then
      FConexao.Query.ParamByName('pDescrLote').Value :=
        AParams.Items['descrlote']
    Else
      FConexao.Query.ParamByName('pDescrLote').Value := '';
    if AParams.ContainsKey('ressuprimento') then
      FConexao.Query.ParamByName('pRessuprimento').Value :=
        AParams.Items['ressuprimento']
    Else
      FConexao.Query.ParamByName('pRessuprimento').Value := '';
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('SaidaPorProduto.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
  end;
end;

function TPedidoSaidaDao.GetClientesRotaCarga(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedidoCarga);
    If AParams.ContainsKey('pedidoid') then
       FConexao.Query.ParamByName('pPedidoId').AsLargeInt := AParams.Items['pedidoid'].ToInt64
    Else
      FConexao.Query.ParamByName('pPedidoId').Value := 0;
    Try
      if AParams.ContainsKey('dataini') then
        FConexao.Query.ParamByName('pDataIni').Value := StrToDate(AParams.Items['dataini'])
      Else
        FConexao.Query.ParamByName('pDataIni').Value := 0;
    Except
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Inicial dos Pedidos � inv�lida!')));
      Exit;
    End;
    Try
      if AParams.ContainsKey('datafin') then
        FConexao.Query.ParamByName('pDataFin').Value := StrToDate(AParams.Items['datafin'])
      Else
        FConexao.Query.ParamByName('pDataFin').Value := 0;
    Except
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'Data Final dos Pedidos � inv�lida!')));
      Exit;
    End;
    If AParams.ContainsKey('pessoaid') then
       FConexao.Query.ParamByName('pPessoaId').AsLargeInt := AParams.Items['pessoaid'].ToInt64
    Else
       FConexao.Query.ParamByName('pPessoaId').Value := 0;
    If AParams.ContainsKey('razao') then
       FConexao.Query.ParamByName('pRazao').AsString := AParams.Items['razao']
    Else
       FConexao.Query.ParamByName('pRazao').AsString := '';
    If AParams.ContainsKey('rotaid') then
       FConexao.Query.ParamByName('pRotaId').AsLargeInt := AParams.Items['rotaid'].ToInteger()
    Else
       FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pOperacaoTipoId').Asinteger := 2;
    If DebugHook <> 0 then
       FConexao.Query.SQL.SaveToFile('PedidoCarga.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', 'N�o h� dados para gerar o relat�rio')));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do Begin
    raise Exception.Create(StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetConsultaReposicao(Const AParams : TDictionary<string, string>): TjSonArray;
var vQryBasico, vQry: TFDQuery;
    vErroBody : TJsonArray;
begin
  Try
    vQryBasico := FConexao.GetQuery;
    vQry := FConexao.GetQuery;
    vQryBasico.SQL.Add(TuEvolutConst.SqlGetConsultaReposicaoBasico);
    vQry.SQL.Add(TuEvolutConst.SqlGetConsultaReposicao);
    if AParams.ContainsKey('datainicial') then Begin
       vQryBasico.ParamByName('pdatainicial').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
       vQry.ParamByName('pdatainicial').Value       := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']));
    End
    Else Begin
       vQryBasico.ParamByName('pdatainicial').Value := 0;
       vQry.ParamByName('pdatainicial').Value       := 0;
    End;
    if AParams.ContainsKey('datafinal') then Begin
       vQryBasico.ParamByName('pdatafinal').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
       vQry.ParamByName('pdatafinal').Value       := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']));
    End
    Else Begin
       vQryBasico.ParamByName('pdatafinal').Value := 0;
       vQry.ParamByName('pdatafinal').Value       := 0;
    End;
    if AParams.ContainsKey('reposicaoid') then Begin
       vQryBasico.ParamByName('pReposicaoId').Value := AParams.Items['reposicaoid'].ToInteger();
       vQry.ParamByName('pReposicaoId').Value       := AParams.Items['reposicaoid'].ToInteger();
    End
    Else Begin
       vQryBasico.ParamByName('pReposicaoId').Value := 0;
       vQry.ParamByName('pReposicaoId').Value       := 0;
    End;
    if AParams.ContainsKey('processoid') then Begin
       vQryBasico.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
       vQry.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
    End
    Else Begin
       vQryBasico.ParamByName('pProcessoId').Value := 0;
       vQry.ParamByName('pProcessoId').Value       := 0;
    End;
    if AParams.ContainsKey('pendente') then Begin
       vQryBasico.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger();
       vQry.ParamByName('pPendente').Value := AParams.Items['pendente'].ToInteger();
    End
    Else Begin
       vQryBasico.ParamByName('pPendente').Value := 99;
       vQry.ParamByName('pPendente').Value       := 99;
    End;
    if DebugHook <> 0 then
       vQryBasico.SQL.SaveToFile('ReposicaoConsultaBasico.Sql');
    vQryBasico.Open();
    if vQryBasico.IsEmpty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'));
    End
    Else Begin
       if DebugHook <> 0 then
          vQry.SQL.SaveToFile('ReposicaoConsulta.Sql');
       vQry.Open();
       if vQry.IsEmpty then Begin
          Result := TjSonArray.Create;
          vErroBody := TJsonArray.Create;
          vErroBody.AddElement(TJsonObject.Create.AddPair('Erro', 'Reposi��o sem itens para coleta.'));
          Result.AddElement(TJsonObject.Create.AddPair('header', vQryBasico.ToJSONArray())
                                              .AddPair('body', vErroBody ));
      End
      Else Begin
         Result := TjSonArray.Create;
         Result.AddElement(TJsonObject.Create.AddPair('header', vQryBasico.ToJSONArray()).AddPair('body', vQry.ToJSONArray()));
      End;
    End;
    vQryBasico.Close;
    vQry.Close;
  Except On E: Exception do
    Begin
      vQryBasico.Close;
      vQry.Close;
      Result := Nil;
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro', StringReplace(E.Message,
                        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetConsultaReposicaoProduto(pReposicaoId: Integer)
  : TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetConsultaReposicaoProduto);
    FConexao.Query.ParamByName('pReposicaoId').Value := pReposicaoId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoConsultaProduto.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para a consulta.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetCortes(const AParams: TDictionary<string, string>) : TjSonArray;
var JsonProduto: TJsonObject;
    pPedidoId, pCodProduto: Integer;
begin
  Try
    if AParams.ContainsKey('sintetico') then
       FConexao.Query.SQL.Add(TuEvolutConst.SqlGetPedidoCortesSintetico)
    Else
      FConexao.Query.SQL.Add(TuEvolutConst.SqlGetPedidoCortes);
    if AParams.ContainsKey('dataini') then
       FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
    Else
       FConexao.Query.ParamByName('pDataIni').Value := 0;
    if AParams.ContainsKey('datafin') then
       FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
    Else
       FConexao.Query.ParamByName('pDataFin').Value := 0;
    pPedidoId   := 0;
    pCodProduto := 0;
    if AParams.ContainsKey('pedidoid') then
       pPedidoId := AParams.Items['pedidoid'].ToInteger;
    if AParams.ContainsKey('codproduto') then
       pCodProduto := AParams.Items['codproduto'].ToInteger;
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid'].ToInteger
    Else
       FConexao.Query.ParamByName('pZonaId').Value := 0;
    if DebugHook <> 0 then
       if AParams.ContainsKey('sintetico') then
          FConexao.Query.SQL.SaveToFile('CortesSintetico.Sql')
       Else
          FConexao.Query.SQL.SaveToFile('CortesAnalitico.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados para a consulta.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
            '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  End;
end;

function TPedidoSaidaDao.GetPendente: TjSonArray;
var
  vSql: String;
  ObjPedidoProduto: TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  ArrayPedidoProdutoDAO: TjSonArray;
begin
  Result := TjSonArray.Create;
  try
    vSql := TuEvolutConst.SqlPedidoProcessar;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := 0;
    FConexao.Query.ParamByName('pDataIni').Value := 0;
    FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := 0;
    FConexao.Query.ParamByName('pDocumentoNr').Value := '';
    FConexao.Query.ParamByName('pRazao').Value := '';
    FConexao.Query.ParamByName('pRegistroERP').Value := '';
    FConexao.Query.ParamByName('pRotaId').Value := 0;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := 0;
    FConexao.Query.ParamByName('pZonaId').Value := 0;
    FConexao.Query.ParamByName('pProcessoId').Value := 1;
    FConexao.Query.ParamByName('pRecebido').Value := 1;
    FConexao.Query.ParamByName('pCubagem').Value := 0;
    FConexao.Query.ParamByName('pEtiqueta').Value := 0;
    FConexao.Query.ParamByName('pPrintTag').Value := 2;
    FConexao.Query.ParamByName('pEmbalagem').Value := 2;
    // Todos os pedidos dispon�veis para processamento
    // vSql := vSql + ' Where PedidoId = '+pPedidoId.ToString+' and Ped.OperacaoTipoId = 2';
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      While Not FConexao.Query.Eof do
      Begin
        PedidoSaida.PedidoId := FConexao.Query.FieldByName('PedidoId')
          .Asinteger;
        PedidoSaida.OperacaoTipo.OperacaoTipoId :=
          FConexao.Query.FieldByName('OperacaoTipoId').Asinteger;
        PedidoSaida.OperacaoTipo.Descricao := FConexao.Query.FieldByName
          ('OperacaoTipo').AsString;
        PedidoSaida.Pessoa.PessoaId := FConexao.Query.FieldByName('PessoaId')
          .Asinteger;
        PedidoSaida.Pessoa.Razao := FConexao.Query.FieldByName('Razao')
          .AsString;
        PedidoSaida.DocumentoNr := FConexao.Query.FieldByName
          ('DocumentoNr').AsString;
        PedidoSaida.DocumentoData := FConexao.Query.FieldByName('DocumentoData')
          .AsDateTime;
        PedidoSaida.DtInclusao := FConexao.Query.FieldByName('DtInclusao')
          .AsDateTime;
        PedidoSaida.HrInclusao := FConexao.Query.FieldByName('HrInclusao')
          .AsDateTime;
        PedidoSaida.ArmazemId := FConexao.Query.FieldByName('ArmazemId')
          .Asinteger;
        PedidoSaida.Status := FConexao.Query.FieldByName('Status').Asinteger;
        PedidoSaida.uuid := FConexao.Query.FieldByName('uuid').AsString;
        // vQryProduto.Open('Declare @Pedido Integer = '+FConexao.Query.FieldByName('PedidoId').AsString+#13+#10+SqlPedidoProdutos);
        ObjPedidoSaidaItensDAO := TPedidoProdutoDAO.Create;
        ArrayPedidoProdutoDAO := ObjPedidoSaidaItensDAO.GetId(0);
        // vQryProduto.FieldByName('PedidoId').AsInteger);
        for vItens := 0 to ArrayPedidoProdutoDAO.Count - 1 do
        Begin
          ObjPedidoProduto := ObjPedidoProduto.JsonToClass
            (ArrayPedidoProdutoDAO.Items[vItens].ToString());
          PedidoSaida.ListProduto.Add(ObjPedidoProduto);
        End;
        Result.AddElement(tJson.ObjectToJsonObject(PedidoSaida,
          [joDateFormatISO8601]));
        FConexao.Query.Next;
      End;
    ObjPedidoProduto := Nil;
    ArrayPedidoProdutoDAO := nil;
  Except
    ON E: Exception do
    Begin
      ObjPedidoProduto := Nil;
      ArrayPedidoProdutoDAO := nil;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetProducaoPendente: TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetProducaoPendente);
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetProdutoReposicao(const AParams : TDictionary<string, string>): TjSonArray;
var JsonProduto: TJsonObject;
begin
  Try
    FConexao.Query.SQL.Add('Select ProdutoId, CodProduto, Descricao, EnderecoId, Endereco, FatorConversao, EmbalagemPadrao, ');
    FConexao.Query.SQL.Add('       Quantidade, Fracionado, EstPicking, (Fracionado-EstPicking) QtdReposicao');
    FConexao.Query.SQL.Add('From');
    FConexao.Query.SQL.Add('   (Select PP.ProdutoId, Prd.CodProduto, Prd.Descricao, TEnd.EnderecoId, TEnd.Descricao Endereco, Prd.FatorConversao, PP.EmbalagemPadrao,');
    FConexao.Query.SQL.Add('           Sum(PP.Quantidade) Quantidade,');
    FConexao.Query.SQL.Add('           Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade /  Prd.FatorConversao) Else 0 End)) CaixaFechada ,');
    FConexao.Query.SQL.Add('		         Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End)) Fracionado');
    FConexao.Query.SQL.Add('           , Est.Estoque EstPicking--, ((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End) - Est.Estoque) As QtdReposicao');
    FConexao.Query.SQL.Add('   From Pedido Ped');
    FConexao.Query.SQL.Add('   Inner Join PedidoProdutos PP ON PP.PedidoId = Ped.PedidoId');
    FConexao.Query.SQL.Add('			Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId');
    FConexao.Query.SQL.Add('			Left Join Enderecamentos TEnd On TEnd.EnderecoId = Prd.EnderecoId');
    FConexao.Query.SQL.Add('   Inner join Rhema_Data DP On Dp.IdData = Ped.DocumentoData');
//    FConexao.Query.Sql.Add('Inner join (Select Documento, Max(DataHora) horario From DocumentoEtapas Where Status = 1 Group by Documento) DeM On DeM.Documento = Pv.Uuid');
    FConexao.Query.Sql.Add('Inner Join vDocumentoEtapas De on De.Documento = Pv.uuid and --De.Horario = DeM.horario and');
    FConexao.Query.Sql.Add('                                  De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento) --and Horario = De.Horario) ');
    //    FConexao.Query.SQL.Add('   Left  Join vDocumentoEtapas De On De.Documento = Ped.uuid');
    FConexao.Query.SQL.Add('			Left Join (Select ProdutoId, SUM(Qtde) Estoque ');
    FConexao.Query.SQL.Add('              From vEstoqueProducao ');
    FConexao.Query.SQL.Add('              where PickingFixo = 1');
    FConexao.Query.SQL.Add('              Group by ProdutoId) Est ON Est.ProdutoId = PP.ProdutoId');
    FConexao.Query.SQL.Add('			Where De.ProcessoId <> 15');
    FConexao.Query.SQL.Add('		   and Ped.OperacaoTipoId = 2');
    if AParams.ContainsKey('datapedido') then begin
       FConexao.Query.SQL.Add(' 		      and Dp.Data = :DataPedido ');
       FConexao.Query.ParamByName('datapedido').Value := AParams.Items['datapedido'];
    end;
    FConexao.Query.SQL.Add('			Group by PP.ProdutoId, Prd.CodProduto, Prd.Descricao, TEnd.EnderecoId, ');
    FConexao.Query.SQL.Add('            TEnd.Descricao, Prd.FatorConversao, PP.EmbalagemPadrao, Est.Estoque');
    FConexao.Query.SQL.Add(') as ProdReposicao');
    // FConexao.Query.SQL.Add('where (Fracionado-EstPicking) > 0');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then Begin
       Result := TjSonArray.Create;
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Sem Dados da Estrutura da Tabela.'));
    End
    Else
       Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

Function TPedidoSaidaDao.GetRelAnaliseRessuprimento(const AParams : TDictionary<string, string>; pVolume: Boolean): TjSonArray;
var vDtInicio, vDtTermino: TDate;
    vRotaId: Integer;
    vPessoaId: Integer;
begin
  vDtInicio := 0;
  vDtTermino := 0;
  vRotaId := 0;
  vPessoaId := 0;
  Try
    if pVolume then
      FConexao.Query.SQL.Add(TuEvolutConst.SqlRelAnaliseRessuprimentoVolume)
    Else
      FConexao.Query.SQL.Add(TuEvolutConst.SqlRelAnaliseRessuprimento);
    if AParams.ContainsKey('dtinicio') then
      vDtInicio := StrToDate(AParams.Items['dtinicio']);
    if AParams.ContainsKey('dttermino') then
      vDtTermino := StrToDate(AParams.Items['dttermino']);
    if vDtInicio = 0 then
      FConexao.Query.ParamByName('pDtInicio').Value := vDtInicio
    Else
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', vDtInicio);
    if vDtTermino = 0 then
      FConexao.Query.ParamByName('pDtTermino').Value := vDtTermino
    Else
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', vDtTermino);
    if AParams.ContainsKey('rotaid') then
      vRotaId := StrToIntDef(AParams.Items['rotaid'], 0);
    FConexao.Query.ParamByName('pRotaId').Value := vRotaId;
    if AParams.ContainsKey('codpessoaerp') then
      vPessoaId := StrToIntDef(AParams.Items['codpessoaerp'], 0);
    if (pVolume) then
    Begin
      If (AParams.ContainsKey('zonaid')) then
        FConexao.Query.ParamByName('pZonaId').Value :=
          StrToIntDef(AParams.Items['zonaid'], 0)
      Else
        FConexao.Query.ParamByName('pZonaId').Value := 0;
    End;
    FConexao.Query.ParamByName('pCodPessoaERP').Value := vPessoaId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('AnaliseRessuprimentos.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetRelApanhePicking(Const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelApahaPicking);
    if AParams.ContainsKey('dataini') then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if AParams.ContainsKey('datafin') then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    if AParams.ContainsKey('codpessoaerp') then
      FConexao.Query.ParamByName('pCodPessoaERP').Value :=
        StrToIntDef(AParams.Items['codpessoaerp'], 0)
    Else
      FConexao.Query.ParamByName('pCodPessoaERP').Value := 0;
    if AParams.ContainsKey('rotaid') then
      FConexao.Query.ParamByName('pRotaId').Value :=
        StrToIntDef(AParams.Items['rotaid'], 0)
    Else
      FConexao.Query.ParamByName('pRotaId').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ApanhePicking.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetRelColetaPulmao(Const AParams : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelColetaPulmao);
    if AParams.ContainsKey('dataini') then
       FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dataini']))
    Else
       FConexao.Query.ParamByName('pDataIni').Value := 0;
    if AParams.ContainsKey('datafin') then
       FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafin']))
    Else
       FConexao.Query.ParamByName('pDataFin').Value := 0;
    if AParams.ContainsKey('codpessoaerp') then
       FConexao.Query.ParamByName('pCodPessoaERP').Value := StrToIntDef(AParams.Items['codpessoaerp'], 0)
    Else
       FConexao.Query.ParamByName('pCodPessoaERP').Value := 0;
    if AParams.ContainsKey('rotaid') then
       FConexao.Query.ParamByName('pRotaId').Value := StrToIntDef(AParams.Items['rotaid'], 0)
    Else
       FConexao.Query.ParamByName('pRotaId').Value := 0;
    if AParams.ContainsKey('zonaid') then
       FConexao.Query.ParamByName('pzonaid').Value := StrToIntDef(AParams.Items['zonaid'], 0)
    Else
      FConexao.Query.ParamByName('pzonaid').Value := 0;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ColetaPulmao.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except ON E: Exception do Begin
    raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetRelRupturaAbastecimento(pDataIni,
  pDataFin: TDateTime): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRelRupturaAbastecimento);
    if pDataIni = 0 then
      FConexao.Query.ParamByName('pDataIni').Value := 0
    Else
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
      FConexao.Query.ParamByName('pDataFin').Value := 0
    Else
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin);
    FConexao.Query.Open();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('RupturaAbastecimento.Sql');
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados da Estrutura da Tabela.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoAutomatica(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetReposicaoAutomatica);
    Try
      If AParams.ContainsKey('data') then
        if StrToDate(AParams.Items['data']) = 0 then
          FConexao.Query.ParamByName('pDataReposicao').Value := 0
        Else
          FConexao.Query.ParamByName('pDataReposicao').Value :=
            FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['data']))
      Else
        FConexao.Query.ParamByName('pDataReposicao').Value := 0;
    Except
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data de Reposi��o inv�lida!')));
        Exit;
      End;
    End;
    If AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    If AParams.ContainsKey('enderecoinicial') then
      FConexao.Query.ParamByName('penderecoinicial').Value :=
        AParams.Items['enderecoinicial']
    Else
      FConexao.Query.ParamByName('penderecoinicial').Value := '';
    If AParams.ContainsKey('enderecofinal') then
      FConexao.Query.ParamByName('penderecofinal').Value :=
        AParams.Items['enderecofinal']
    Else
      FConexao.Query.ParamByName('penderecofinal').Value := '';
    FConexao.Query.ParamByName('pStatus').Value := 0;
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoAutomatica.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'N�o h� dados para gerar Coleta da Reposi��o')));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoAutomaticaColeta(const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetReposicaoAutomaticaColeta);
    Try
      If AParams.ContainsKey('data') then
        if StrToDate(AParams.Items['data']) = 0 then
          FConexao.Query.ParamByName('pDataReposicao').Value := 0
        Else
          FConexao.Query.ParamByName('pDataReposicao').Value :=
            FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['data']))
      Else
        FConexao.Query.ParamByName('pDataReposicao').Value := 0;
    Except
      Begin
        Result := TjSonArray.Create;
        Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
          'Data de Reposi��o inv�lida!')));
        Exit;
      End;
    End;
    If AParams.ContainsKey('zonaid') then
      FConexao.Query.ParamByName('pZonaId').Value := AParams.Items['zonaid']
        .ToInteger
    Else
      FConexao.Query.ParamByName('pZonaId').Value := 0;
    If AParams.ContainsKey('enderecoinicial') then
      FConexao.Query.ParamByName('penderecoinicial').Value :=
        AParams.Items['enderecoinicial']
    Else
      FConexao.Query.ParamByName('penderecoinicial').Value := '';
    If AParams.ContainsKey('enderecofinal') then
      FConexao.Query.ParamByName('penderecofinal').Value :=
        AParams.Items['enderecofinal']
    Else
      FConexao.Query.ParamByName('penderecofinal').Value := '';
    FConexao.Query.ParamByName('pStatus').Value := 0;
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoAutomaticaColeta.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'N�o h� dados para gerar Coleta da Reposi��o')));
      Exit;
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoEnderecoColeta(pData: TDate;
  pZonaId: Integer; pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.GetReposicaoEnderecoColeta);
    FConexao.Query.ParamByName('pDataPedido').Value :=
      FormatDateTime('YYYY-MM-DD', pData);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pEnderecoInicial').Value := pEnderecoInicial;
    FConexao.Query.ParamByName('pEnderecoFinal').Value := pEnderecoFinal;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoColetaEndereco.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoGerar(pData: TDate; pZonaId: Integer;
  pEnderecoInicial, pEnderecoFinal: String): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetGerarReposicao);
    // FConexao.Query.Sql.Add('Order by Prd.ZonaDescricao, Prd.Descricao');
    FConexao.Query.ParamByName('pDataPedido').Value :=
      FormatDateTime('YYYY-MM-DD', pData);
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pEnderecoIni').Value := pEnderecoInicial;
    FConexao.Query.ParamByName('pEnderecoFin').Value := pEnderecoFinal;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoGerar.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))));
    End;
  end;
end;

function TPedidoSaidaDao.GetReposicaoModelo(pModeloId: Integer): TjSonArray;
var
  JsonRetorno: TJsonObject;
begin
  try
    FConexao.Query.SQL.Add('Declare @ModeloId Integer = :pModeloId');
    FConexao.Query.SQL.Add('Select * from vReposicaoModelo');
    FConexao.Query.SQL.Add
      ('Where (@ModeloId = 0 or ReposicaoModeloId = @ModeloId)');
    FConexao.Query.ParamByName('pModeloId').Value := pModeloId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoModelo.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.GetResumoProducao(Const AParams
  : TDictionary<string, string>): TjSonArray;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetResumoOperacao);
    if AParams.ContainsKey('datainicial') then
      FConexao.Query.ParamByName('pdatainicial').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datainicial']))
    Else
      FConexao.Query.ParamByName('pdatainicial').Value := 0;
    if AParams.ContainsKey('datafinal') then
      FConexao.Query.ParamByName('pdatafinal').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['datafinal']))
    Else
      FConexao.Query.ParamByName('pdatafinal').Value := 0;
    if AParams.ContainsKey('processoid') then
      FConexao.Query.ParamByName('pprocessoid').Value :=
        AParams.Items['processoid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pprocessoid').Value := 0;
    if AParams.ContainsKey('usuarioid') then
      FConexao.Query.ParamByName('pusuarioid').Value :=
        AParams.Items['usuarioid'].ToInteger()
    Else
      FConexao.Query.ParamByName('pusuarioid').Value := 0;
    if AParams.ContainsKey('dtpedidoini') then
      FConexao.Query.ParamByName('pDtPedidoIni').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidoini']))
    Else
      FConexao.Query.ParamByName('pDtPedidoIni').Value := 0;
    if AParams.ContainsKey('dtpedidofin') then
      FConexao.Query.ParamByName('pdtpedidofin').Value :=
        FormatDateTime('YYYY-MM-DD', StrToDate(AParams.Items['dtpedidofin']))
    Else
      FConexao.Query.ParamByName('pdtpedidofin').Value := 0;
    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('ResumoProducao.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para gerar o Resumo da Produ��o.'));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TPedidoSaidaDao.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TPedidoSaidaDao.InsertUpdate(pPedidoId, pOperacaoTipoId,
  pPessoaId: Integer; pDocumentoNr: String; pDocumentoData: TDate;
  pArmazemId: Integer): TjSonArray;
var
  vSql: String;
begin
  try
    if pPedidoId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, DtInclusao, HrInclusao, ArmazemId) Values ('
        + pOperacaoTipoId.ToString() + ', ' + pPessoaId.ToString() + ', ' +
        QuotedStr(pDocumentoNr) + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + '), ' +
        SqlDataAtual + ', ' + SqlHoraAtual + ', ' + pArmazemId.ToString()
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        pOperacaoTipoId.ToString() + '   , PessoaId      = ' +
        pPessoaId.ToString() + '   , DocumentoNr   = ' + QuotedStr(pDocumentoNr)
        + '   , DocumentoData = ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', pDocumentoData) + #39 + ')' +
      // '   , DtInclusao    = '+SqlDataAtual+
      // '   , HrInclusao    = '+SqlHoraAtual+
        '   , ArmazemId     = ' + IfThen(pArmazemId = 0, 'Null',
        pArmazemId.ToString()) + ' where PedidoId = ' + pPedidoId.ToString +
        ' and OperacaoTipoId = 2';
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Function TPedidoSaidaDao.PedidoProcessar(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pDocumentoNr, pRazao, pRegistroERP: String; pRotaId: Integer;
  pRotaIdFinal: Integer; pZonaId: Integer; pProcessoId: Integer;
  pRecebido, pCubagem, pEtiqueta, pPrintTag, pEmbalagem: Integer): TjSonArray;
var
  vSql: String;
  // ObjPedidoProduto       : TPedidoProduto;
  ObjPedidoSaidaItensDAO: TPedidoProdutoDAO;
  vItens: Integer;
  // ArrayPedidoProdutoDAO  : TJsonArray;
  JsonArrayPedidos, jsonArrayRotas, JsonArrayPessoas: TjSonArray;
  JsonRetorno, jsonPedido, jsonOperacao, jsonNatureza, jsonRota,
    jsonPessoa: TJsonObject;
begin
  try
    vSql := TuEvolutConst.SqlPedidoProcessar;
    // ClipBoard.Astext := vSql;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pProcessoid').Value := pProcessoId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    FConexao.Query.ParamByName('pPrintTag').Value := pPrintTag;
    FConexao.Query.ParamByName('pEmbalagem').Value := pEmbalagem;
    // Clipboard.AsText := FConexao.Query.Text;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoProcessar.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'N�o h� dados para gerar o relat�rio')));
      Exit;
    End;
    JsonArrayPedidos := TjSonArray.Create;
    while Not FConexao.Query.Eof do
    Begin
      jsonPedido := TJsonObject.Create;
      jsonOperacao := TJsonObject.Create;
      jsonNatureza := TJsonObject.Create;
      jsonPessoa := TJsonObject.Create;
      jsonPedido.AddPair('pedidoid',
        TJsonNumber.Create(FConexao.Query.FieldByName('PedidoId').Asinteger));
      jsonPedido.AddPair('processoid',
        TJsonNumber.Create(FConexao.Query.FieldByName('ProcessoId').Asinteger));
      jsonPedido.AddPair('processoetapa',
        FConexao.Query.FieldByName('ProcessoEtapa').AsString);
      jsonPedido.AddPair('statusmin',
        TJsonNumber.Create(FConexao.Query.FieldByName('StatusMin').Asinteger));
      jsonPedido.AddPair('statusmax',
        TJsonNumber.Create(FConexao.Query.FieldByName('StatusMax').Asinteger));
      jsonOperacao.AddPair('operacaotipoid',
        TJsonNumber.Create(FConexao.Query.FieldByName('OperacaoTipoId')
        .Asinteger));
      jsonOperacao.AddPair('descricao',
        FConexao.Query.FieldByName('OperacaoTipo').AsString);
      jsonPedido.AddPair('operacaotipo', jsonOperacao);
      jsonPessoa.AddPair('pessoaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('PessoaId').Asinteger));
      jsonPessoa.AddPair('codpessoaerp',
        TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaERP')
        .Asinteger));
      jsonPessoa.AddPair('razao', FConexao.Query.FieldByName('Razao').AsString);
      jsonPessoa.AddPair('fantasia', FConexao.Query.FieldByName('Fantasia')
        .AsString);
      jsonPessoa.AddPair('rotaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
      jsonPessoa.AddPair('rota', FConexao.Query.FieldByName('Rota').AsString);
      jsonPedido.AddPair('pessoa', jsonPessoa);
      jsonPedido.AddPair('documentonr',
        FConexao.Query.FieldByName('DocumentoNr').AsString);
      jsonPedido.AddPair('documentodatar',
        DateToStr(FConexao.Query.FieldByName('DocumentoData').AsDateTime));
      // FormatDateTime('YYYY-MM-DD', FConexao.Query.FieldByName('DocumentoData').AsDateTime));
      jsonPedido.AddPair('dtinclusao', FormatDateTime('YYYY-MM-DD',
        FConexao.Query.FieldByName('DtInclusao').AsDateTime));
      jsonPedido.AddPair('hrinclusao', FConexao.Query.FieldByName('HrInclusao')
        .AsString);
      // FormatDateTime('hh:mm', FConexao.Query.FieldByName('HrInclusao').AsDateTime));
      jsonPedido.AddPair('armazemid',
        TJsonNumber.Create(FConexao.Query.FieldByName('ArmazemId').Asinteger));
      jsonPedido.AddPair('status',
        TJsonNumber.Create(FConexao.Query.FieldByName('Status').Asinteger));
      jsonPedido.AddPair('qtdproduto',
        TJsonNumber.Create(FConexao.Query.FieldByName('QtdProdutos')
        .Asinteger));
      jsonPedido.AddPair('peso',
        TJsonNumber.Create(FConexao.Query.FieldByName('peso').Asinteger));
      jsonPedido.AddPair('volume',
        TJsonNumber.Create(FConexao.Query.FieldByName('volume').AsFloat));
      jsonPedido.AddPair('registroerp',
        FConexao.Query.FieldByName('RegistroERP').AsString);
      jsonPedido.AddPair('picking', FConexao.Query.FieldByName('Picking')
        .AsString);
      jsonPedido.AddPair('uuid', FConexao.Query.FieldByName('uuid').AsString);
      JsonArrayPedidos.AddElement(jsonPedido);
      FConexao.Query.Next;
    End;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    // Buscar As Rotas
    vSql := TuEvolutConst.SqlPedidoRotas;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := pRazao;
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoRotas.Sql');
    FConexao.Query.Open();
    jsonArrayRotas := TjSonArray.Create;
    while Not FConexao.Query.Eof do
    Begin
      jsonRota := TJsonObject.Create();
      jsonRota.AddPair('rotaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
      jsonRota.AddPair('descricao', FConexao.Query.FieldByName('Descricao')
        .AsString);
      jsonArrayRotas.AddElement(jsonRota);
      FConexao.Query.Next;
    End;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    // Buscar As Pessoas/Destinat�rio
    vSql := TuEvolutConst.SqlPedidoPessoa;
    FConexao.Query.SQL.Add(vSql);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := pRazao;
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    FConexao.Query.Open();
    JsonArrayPessoas := TjSonArray.Create;
    while Not FConexao.Query.Eof do
    Begin
      jsonPessoa := TJsonObject.Create();
      jsonPessoa.AddPair('pessoaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('PessoaId').Asinteger));
      jsonPessoa.AddPair('codpessoaerp',
        TJsonNumber.Create(FConexao.Query.FieldByName('CodPessoaERP')
        .Asinteger));
      jsonPessoa.AddPair('razao', FConexao.Query.FieldByName('Razao').AsString);
      jsonPessoa.AddPair('rotaid',
        TJsonNumber.Create(FConexao.Query.FieldByName('RotaId').Asinteger));
      JsonArrayPessoas.AddElement(jsonPessoa);
      FConexao.Query.Next;
    End;
    FConexao.Query.Close;
    JsonRetorno := TJsonObject.Create;
    JsonRetorno.AddPair('pedido', JsonArrayPedidos);
    JsonRetorno.AddPair('rota', jsonArrayRotas);
    JsonRetorno.AddPair('pessoa', JsonArrayPessoas);
    Result.AddElement(JsonRetorno);
    // ClipBoard.AsText := JsonRetorno.ToString();
  Except
    on E: Exception do
    Begin
      raise Exception.Create('Erro na cubagem: ' + E.Message);
    End;
  end;
end;

Function TPedidoSaidaDao.PedidoPrintTag(pPedidoId: Integer;
  pPedidoVolumeId: Integer; pDataIni, pDataFin: TDate;
  pCodigoERP, pPessoaId: Integer; pRazao: String; pRotaId: Integer;
  pRotaIdFinal: Integer; pZonaId: Integer; pProcessoId: Integer;
  pRecebido, pCubagem, pEtiqueta, pPrintTag, pEmbalagem: Integer): TjSonArray;
begin
  try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlPedidoPrintTag);
    if (pRotaId > 0) or (pRotaIdFinal > 0) then
      FConexao.Query.SQL.Add('Order by RotaId, PedidoId')
    Else
      FConexao.Query.SQL.Add('Order by PedidoId');
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    if pDataIni = 0 then
      FConexao.Query.ParamByName('pDataIni').Value := pDataIni
    Else
      FConexao.Query.ParamByName('pDataIni').Value := FormatDateTime('YYYY-MM-DD', pDataIni);
    if pDataFin = 0 then
      FConexao.Query.ParamByName('pDataFin').Value := pDataFin
    Else
      FConexao.Query.ParamByName('pDataFin').Value := FormatDateTime('YYYY-MM-DD', pDataFin);
    //FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    //FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pRotaIdFinal').Value := pRotaIdFinal;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pPrintTag').Value := pPrintTag;
    FConexao.Query.ParamByName('pEmbalagem').Value := pEmbalagem;
    // Clipboard.AsText := FConexao.Query.Text;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('PedidoPrintTag.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create;
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'N�o h� dados para gerar o relat�rio')));
      Exit;
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    on E: Exception do
    Begin
      raise Exception.Create('Erro na cubagem: ' + E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.PostReposicaoModelo(pJsonReposicao: TJsonObject)
  : TjSonArray;
Var
  vZonaId, vPickingInicial, vPickingFinal: String;
  vRuaInicial, vRuaFinal: String;
  vRuaPar, vRuaImpar: Integer;
  vPredioInicial, vPredioFinal: String;
  vPredioPar, vPredioImpar: Integer;
  vNivelInicial, vNivelFinal: String;
  vNivelPar, vNivelImpar: Integer;
  vAptoInicial, vAptoFinal: String;
  vAptoPar, vAptoImpar: Integer;
begin
  Try
    if pJsonReposicao.GetValue<String>('pickinginicial') = '' then
      vPickingInicial := 'Null'
    Else
      vPickingInicial := #39 + pJsonReposicao.GetValue<String>
        ('pickinginicial') + #39;
    if pJsonReposicao.GetValue<String>('pickingfinal') = '' then
      vPickingFinal := 'Null'
    Else
      vPickingFinal := #39 + pJsonReposicao.GetValue<String>
        ('pickingfinal') + #39;
    if pJsonReposicao.GetValue<String>('zonaid') = '0' then
      vZonaId := 'Null'
    Else
      vZonaId := pJsonReposicao.GetValue<String>('zonaid');
    if pJsonReposicao.GetValue<String>('ruainicial') = '' then
      vRuaInicial := 'Null'
    Else
      vRuaInicial := #39 + pJsonReposicao.GetValue<String>('ruainicial') + #39;
    if pJsonReposicao.GetValue<String>('ruafinal') = '' then
      vRuaFinal := 'Null'
    Else
      vRuaFinal := #39 + pJsonReposicao.GetValue<String>('ruafinal') + #39;
    vRuaImpar := pJsonReposicao.GetValue<Integer>('ruaimpar');
    vRuaPar := pJsonReposicao.GetValue<Integer>('ruapar');
    if pJsonReposicao.GetValue<String>('predioinicial') = '' then
      vPredioInicial := 'Null'
    Else
      vPredioInicial := #39 + pJsonReposicao.GetValue<String>
        ('predioinicial') + #39;
    if pJsonReposicao.GetValue<String>('prediofinal') = '' then
      vPredioFinal := 'Null'
    Else
      vPredioFinal := #39 + pJsonReposicao.GetValue<String>
        ('prediofinal') + #39;
    vPredioImpar := pJsonReposicao.GetValue<Integer>('predioimpar');
    vPredioPar := pJsonReposicao.GetValue<Integer>('prediopar');
    if pJsonReposicao.GetValue<String>('nivelinicial') = '' then
      vNivelInicial := 'Null'
    Else
      vNivelInicial := #39 + pJsonReposicao.GetValue<String>
        ('nivelinicial') + #39;
    if pJsonReposicao.GetValue<String>('nivelfinal') = '' then
      vNivelFinal := 'Null'
    Else
      vNivelFinal := #39 + pJsonReposicao.GetValue<String>('nivelfinal') + #39;
    vNivelImpar := pJsonReposicao.GetValue<Integer>('nivelimpar');
    vNivelPar := pJsonReposicao.GetValue<Integer>('nivelpar');
    if pJsonReposicao.GetValue<String>('aptoinicial') = '' then
      vAptoInicial := 'Null'
    Else
      vAptoInicial := #39 + pJsonReposicao.GetValue<String>
        ('aptoinicial') + #39;
    if pJsonReposicao.GetValue<String>('aptofinal') = '' then
      vAptoFinal := 'Null'
    Else
      vAptoFinal := #39 + pJsonReposicao.GetValue<String>('aptofinal') + #39;
    vAptoImpar := pJsonReposicao.GetValue<Integer>('aptoimpar');
    vAptoPar := pJsonReposicao.GetValue<Integer>('aptopar');
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    if pJsonReposicao.GetValue<Integer>('modeloid') = 0 then
    Begin
      FConexao.Query.SQL.Add('Declare @ModeloId Integer = 0');
      FConexao.Query.SQL.Add('Insert Into ReposicaoModelo Values (');
      FConexao.Query.SQL.Add('GetDate(), GetDate(), 1, ' + vZonaId + ', ' +
        vPickingInicial + ', ' + vPickingFinal + ', ' + vRuaInicial + ', ' +
        vRuaFinal + ', ' + vRuaImpar.ToString() + ', ' + vRuaPar.ToString() +
        ', ' + vPredioInicial + ', ' + vPredioFinal + ', ' +
        vPredioImpar.ToString() + ', ' + vPredioPar.ToString() + ', ' +
        vNivelInicial + ', ' + vNivelFinal + ', ' + vNivelImpar.ToString() +
        ', ' + vNivelPar.ToString() + ', ' + vAptoInicial + ', ' + vAptoFinal +
        ', ' + vAptoImpar.ToString() + ', ' + vAptoPar.ToString() + ', ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', ' + #39 +
        pJsonReposicao.GetValue<String>('terminal') + #39 + ')');
      FConexao.Query.SQL.Add('Set @ModeloId = SCOPE_IDENTITY()');
      FConexao.Query.SQL.Add('Select @ModeloId as ModeloId');
    End
    Else
    begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update ReposicaoModelo Set ');
      FConexao.Query.SQL.Add('   Data = GetDate()');
      FConexao.Query.SQL.Add('   , hora = GetDate()');
      FConexao.Query.SQL.Add('   , ZonaId        = ' + vZonaId);
      FConexao.Query.SQL.Add('   , PickingInicial = ' + vPickingInicial);
      FConexao.Query.SQL.Add('   , PickingFinal   = ' + vPickingFinal);
      FConexao.Query.SQL.Add('   , RuaInicial   = ' + vRuaInicial);
      FConexao.Query.SQL.Add('   , RuaFinal     = ' + vRuaFinal);
      FConexao.Query.SQL.Add('   , RuaImpar     = ' + vRuaImpar.ToString());
      FConexao.Query.SQL.Add('   , Ruapar       = ' + vRuaPar.ToString());
      FConexao.Query.SQL.Add('   , PredioInicial = ' + vPredioInicial);
      FConexao.Query.SQL.Add('   , PredioFinal   = ' + vPredioFinal);
      FConexao.Query.SQL.Add('   , PredioImpar   = ' + vPredioImpar.ToString());
      FConexao.Query.SQL.Add('   , Prediopar     = ' + vPredioPar.ToString());
      FConexao.Query.SQL.Add('   , NivelInicial  = ' + vNivelInicial);
      FConexao.Query.SQL.Add('   , NivelFinal    = ' + vNivelFinal);
      FConexao.Query.SQL.Add('   , NivelImpar    = ' + vNivelImpar.ToString());
      FConexao.Query.SQL.Add('   , Nivelpar      = ' + vNivelPar.ToString());
      FConexao.Query.SQL.Add('   , AptoInicial   = ' + vAptoInicial);
      FConexao.Query.SQL.Add('   , AptoFinal     = ' + vAptoFinal);
      FConexao.Query.SQL.Add('   , AptoImpar     = ' + vAptoImpar.ToString());
      FConexao.Query.SQL.Add('   , Aptopar       = ' + vAptoPar.ToString());
      FConexao.Query.SQL.Add('   , UsuarioId     = ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString());
      FConexao.Query.SQL.Add('   , Terminal      = ' + #39 +
        pJsonReposicao.GetValue<String>('terminal') + #39);
      FConexao.Query.SQL.Add('Where ReposicaoModeloId = ' +
        pJsonReposicao.GetValue<Integer>('modeloid').ToString());
      FConexao.Query.SQL.Add
        ('Select * From ReposicaoModelo where ReposicaoModeloId = ' +
        pJsonReposicao.GetValue<Integer>('modeloid').ToString());
    end;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposicaoModeloSalvar.Sql');
    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.ProdutoSemPicking(pPedidoId: Integer;
  pDataIni, pDataFin: TDate; pCodigoERP, pPessoaId: Integer;
  pDocumentoNr, pRazao, pRegistroERP: String; pRotaId, pRecebido, pCubagem,
  pEtiqueta, pverificarEstoque: Integer): TjSonArray;
begin
  try
    // ClipBoard.Astext := vSql;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetProdutoSemPicking);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if pDataIni <> 0 then
      FConexao.Query.ParamByName('pDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataIni)
      // FormatDateTime('YYYY-MM-DD', pDataIni)
    Else
      FConexao.Query.ParamByName('pDataIni').Value := 0;
    if pDataFin <> 0 then
      FConexao.Query.ParamByName('pDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFin)
      // FormatDateTime('YYYY-MM-DD', pDataFin)
    Else
      FConexao.Query.ParamByName('pDataFin').Value := 0;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    FConexao.Query.ParamByName('pPessoaId').Value := pPessoaId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRazao').Value := '%' + pRazao + '%';
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pRecebido').Value := pRecebido;
    FConexao.Query.ParamByName('pCubagem').Value := 0; // pCubagem;
    FConexao.Query.ParamByName('pEtiqueta').Value := pEtiqueta;
    FConexao.Query.ParamByName('pVerificarEstoque').Value := pverificarEstoque;
    // Clipboard.AsText := FConexao.Query.Text;
    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('ProdutoSemPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TjSonArray.Create();
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.PutRegistrarProcesso(pJsonObject: TJsonObject)
  : TjSonArray;
Begin
  Try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '
      + pJsonObject.GetValue<Integer>('pedidoid').ToString + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    FConexao.Query.ParamByName('pProcessoId').Value :=
      pJsonObject.GetValue<Integer>('processoid');
    FConexao.Query.ParamByName('pTerminal').Value :=
      pJsonObject.GetValue<String>('terminal');
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      pJsonObject.GetValue<String>('usuarioid');
    FConexao.Query.ExecSQL;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok',
      'Registro realizado com sucesso!'));
  Except
    On E: Exception do
    Begin
      raise Exception.Create('N�o foi poss�vel Finalizar o registro da coleta.'
        + sLineBreak + E.Message);
    End;
  End;
end;

function TPedidoSaidaDao.ReposicaoFinalizar(pJsonReposicao: TjSonArray)
  : TjSonArray;
Var
  vTransaction: Boolean;
  xColeta: Integer;
  vReposicaoId: Integer;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    xColeta := 0;
    vReposicaoId := pJsonReposicao.Get(xColeta)
      .GetValue<Integer>('reposicaoid');
    // SOMENTE PARA REPOSI��O AUTOM�TICA SEM COLETA (Brasil)
    { for xColeta := 0 to Pred(pJsonReposicao.Count) do Begin
      //Baixar Estoque
      if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') > 0) and
      (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid')<>'') and
      (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid')<>'0') then Begin
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(TuEvolutConst.SqlEstoque);
      vQry.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
      vQry.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
      vQry.ParamByName('pEstoqueTipoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
      vQry.ParamByName('pQuantidade').Value    := (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo')*-1);
      vQry.ParamByName('pUsuarioId').Value     := (pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid'));
      vQry.ExecSQL;
      //Baixar Reserva
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(TuEvolutConst.SqlEstoque);
      vQry.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
      vQry.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
      vQry.ParamByName('pEstoqueTipoId').Value := 6;
      vQry.ParamByName('pQuantidade').Value    := (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde')*-1);
      vQry.ParamByName('pUsuarioId').Value     := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
      vQry.ExecSQL;
      //Transferir para o Picking
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(TuEvolutConst.SqlEstoque);
      vQry.ParamByName('pLoteId').Value        := pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
      vQry.ParamByName('pEnderecoId').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
      vQry.ParamByName('pEstoqueTipoId').Value := pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
      vQry.ParamByName('pQuantidade').Value    := pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
      vQry.ParamByName('pUsuarioId').Value     := pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
      vQry.ExecSQL;
      End;
      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add('Update ReposicaoEnderecoColeta');
      vQry.SQL.Add('  Set QtdRepo = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo').ToString());
      vQry.SQL.Add('    , UsuarioId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid').ToString());
      vQry.SQL.Add('    , Terminal  = '+QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('terminal')));
      vQry.SQL.Add('    , DtEntrada = '+QuotedStr(FormatDateTime('YYYY-MM-DD', StrToDate(pJsonReposicao.Get(xColeta).GetValue<String>('dtentrada')))));
      vQry.SQL.Add('    , HrEntrada = '+QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('hrentrada')));

      vQry.SQL.Add('Where ReposicaoId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid').ToString);
      vQry.SQL.Add('  And ProdutoId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('produtoid').ToString);
      vQry.Sql.Add('  And Loteid = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid').ToString());
      vQry.SQL.Add('  And EnderecoId = '+pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid').ToString());
      if DebugHook <> 0 then
      vQry.Sql.SaveToFile('SqlUpdateReposicaoColeta.Sql');

      vQry.ExecSQL;
      vReposicaoId := pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid');
      //Registrar no Kardex

      End;
    }
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Update Reposicao Set ProcessoId = (Select ProcessoId From ProcessoEtapas where Descricao = '
      + #39 + 'Reposi��o - Finalizada' + #39 + ') Where ReposicaoId = ' +
      vReposicaoId.ToString());
    FConexao.Query.ExecSQL;
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', '201'));
  Except
    On E: Exception do
    Begin
      if vTransaction then
        FConexao.Query.connection.Rollback;
      raise Exception.Create('N�o foi poss�vel Finalizar o registro da coleta.'
        + sLineBreak + E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.ReposicaoSalvar(pJsonReposicao: TJsonObject)
  : TjSonArray;
Var
  JsonArrayItens, JsonArrayEndereco: TjSonArray;
  vGuuid: string;
  xItens, xEndereco, vReposicaoId: Integer;
  vTransaction: Boolean;

  vDataReposicao, vZonaId, vEnderecoInicial, vEnderecoFinal: String;
  vReposicaoModeloId: String;
  vProdutoId: Integer;
begin
  Try
    vGuuid := TGUID.NewGuid.ToString();
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
    if pJsonReposicao.GetValue<String>('zonaid') = '0' then
      vZonaId := 'Null'
    Else
      vZonaId := pJsonReposicao.GetValue<String>('zonaid');
    if pJsonReposicao.GetValue<String>('enderecoinicial') = '' then
      vEnderecoInicial := 'Null'
    Else
      vEnderecoInicial := pJsonReposicao.GetValue<String>('enderecoinicial');
    if pJsonReposicao.GetValue<String>('enderecofinal') = '' then
      vEnderecoFinal := 'Null'
    Else
      vEnderecoFinal := pJsonReposicao.GetValue<String>('enderecofinal');
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    if Not pJsonReposicao.tryGetValue('reposicaomodeloid', vReposicaoModeloId)
    then
      vReposicaoModeloId := 'Null'
    Else
      vReposicaoModeloId := pJsonReposicao.GetValue<String>
        ('reposicaomodeloid');
    if pJsonReposicao.GetValue<Integer>('reposicaoid') = 0 then
    Begin
      if (pJsonReposicao.GetValue<String>('dtressuprimento') = '') or
        (pJsonReposicao.GetValue<String>('dtressuprimento') = '  /  /    ') then
        vDataReposicao := 'Null'
      Else
        vDataReposicao := #39 + FormatDateTime('YYYY-MM-DD',
          StrToDate(pJsonReposicao.GetValue<String>('dtressuprimento'))) + #39;
      FConexao.Query.SQL.Add('Declare @NewId Varchar(38) = ' +
        QuotedStr(vGuuid));
      FConexao.Query.SQL.Add('Declare @ProcessoId Integer = ' +
        pJsonReposicao.GetValue<Integer>('processoid').ToString());
      FConexao.Query.SQL.Add
        ('Set @ProcessoId = (select ProcessoId From PRocessoEtapas ');
      FConexao.Query.SQL.Add
        ('where descricao = (Case when @ProcessoId = 1 then ' + #39 +
        'Reposi��o - Criada' + #39);
      FConexao.Query.SQL.Add
        ('                        when @ProcessoId = 2 then ' + #39 +
        'Reposi��o - Em Coleta' + #39);
      FConexao.Query.SQL.Add('						when @ProcessoId = 3 then ' + #39 +
        'Reposi��o - Finalizada' + #39);
      FConexao.Query.SQL.Add('                        Else ' + #39 +
        'Reposi��o - Cancelada' + #39 + ' End))');
      FConexao.Query.SQL.Add('Insert Into Reposicao Values (');
      FConexao.Query.SQL.Add(vDataReposicao + ', ' +
        pJsonReposicao.GetValue<Integer>('reposicaotipo').ToString() + ', ' +
        '@ProcessoId, ' +
        // pJsonReposicao.GetValue<Integer>('processoid').ToString()+', '+
        vZonaId + ', ' + vEnderecoInicial + ', ' + vEnderecoFinal + ', ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString() + ', ' + #39 +
        pJsonReposicao.GetValue<String>('terminal') + #39 + ', ' +
        'GetDate(), (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()), 12, 12)), '
        + vReposicaoModeloId + ', ' + 'Null, Null, ' +
        // UsuarioIdInUse e TerminalInUse
        'Cast(@NewId AS UNIQUEIDENTIFIER)');
      FConexao.Query.SQL.Add(')');
      FConexao.Query.SQL.Add('Select * From Reposicao where Uuid = @NewId');
    End
    Else
    begin
      vReposicaoId := pJsonReposicao.GetValue<Integer>('reposicaoid');
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update Reposicao Set ');
      FConexao.Query.SQL.Add('   DtRessuprimento = ' + #39 +
        FormatDateTime('YYYY-MM-DD',
        StrToDate(pJsonReposicao.GetValue<String>('dtressuprimento'))) + #39);
      FConexao.Query.SQL.Add('   , ReposicaoTipo = ' +
        pJsonReposicao.GetValue<Integer>('reposicaotipo').ToString());
      FConexao.Query.SQL.Add('   , ZonaId        = ' + vZonaId);
      FConexao.Query.SQL.Add('   , EnderecoInicial = ' + vEnderecoInicial);
      FConexao.Query.SQL.Add('   , EnderecoFinal   = ' + vEnderecoFinal);
      FConexao.Query.SQL.Add('   , ReposicaoModeloId = ' + vReposicaoModeloId);
      // FConexao.Query.SQL.Add('   , ProcessoId    = '+pJsonReposicao.GetValue<Integer>('processoid').ToString());
      FConexao.Query.SQL.Add('   , UsuarioId     = ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString());
      FConexao.Query.SQL.Add('Where ReposicaoId = ' +
        pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
      FConexao.Query.SQL.Add('Select * From Reposicao where ReposicaoId = ' +
        pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
    end;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ReposiocaoSalvar.Sql');

    FConexao.Query.Open;
    Result := FConexao.Query.ToJSONArray();
    // Salvar os Endere�os da Coleta
    JsonArrayEndereco := pJsonReposicao.GetValue<TjSonArray>('coleta');
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Delete From ReposicaoEnderecoColeta Where ReposicaoId = ' +
      pJsonReposicao.GetValue<Integer>('reposicaoid').ToString());
    FConexao.Query.ExecSQL;
    For xEndereco := 0 to Pred(JsonArrayEndereco.Count) do
    Begin
      If JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('produtoid') = 11954
      then
        vProdutoId := JsonArrayEndereco.Items[xEndereco].GetValue<Integer>
          ('demanda');

      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add
        ('Insert Into ReposicaoEnderecoColeta (reposicaoid, produtoid, loteid, enderecoid, EstoqueTipoId, EstoqueDisponivel, Qtde) Values (');
      FConexao.Query.SQL.Add(Result.Items[0].GetValue<Integer>('reposicaoid')
        .ToString() + ', ' + JsonArrayEndereco.Items[xEndereco]
        .GetValue<Integer>('produtoid').ToString() + ', ' +
        JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('loteid')
        .ToString() + ', ' + JsonArrayEndereco.Items[xEndereco]
        .GetValue<Integer>('enderecoid').ToString() + ', ' +
        JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('estoquetipoid')
        .ToString() + ', ' + JsonArrayEndereco.Items[xEndereco]
        .GetValue<Integer>('disponivel').ToString() + ', ' +
        JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('demanda')
        .ToString());
      FConexao.Query.SQL.Add(')');
      FConexao.Query.SQL.Add('Update PedidoReposicao ' + '    Set Status = 1 ' +
        'Where LoteId = ' + JsonArrayEndereco.Items[xEndereco].GetValue<Integer>
        ('loteid').ToString() + '  And Enderecoid = ' + JsonArrayEndereco.Items
        [xEndereco].GetValue<Integer>('enderecoid').ToString());
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('SalvarReposicaoEndereco.Sql');
      // if JsonArrayEndereco.Items[xEndereco].GetValue<Integer>('qtdrepo') > 0 then
      FConexao.Query.ExecSQL;
    End;
    // Incluir na Reserva quando tipo for por Demanda
    if pJsonReposicao.GetValue<Integer>('reposicaotipo') = 1 then
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update Est');
      FConexao.Query.SQL.Add('   Set Qtde = Est.Qtde + RC.Qtde');
      FConexao.Query.SQL.Add('from ReposicaoEnderecoColeta RC');
      FConexao.Query.SQL.Add
        ('Inner Join Estoque Est On Est.LoteId = RC.LoteId and Est.EnderecoId = RC.EnderecoId and Est.EstoqueTipoId = 6');
      FConexao.Query.SQL.Add('where reposicaoid = ' + Result.Items[0]
        .GetValue<Integer>('reposicaoid').ToString());

      FConexao.Query.SQL.Add('Insert Into Estoque');
      FConexao.Query.SQL.Add('select RC.LoteId, RC.EnderecoId, 6, RC.Qtde, ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual + ', ' +
        pJsonReposicao.GetValue<Integer>('usuarioid').ToString() +
        ', Null, Null, Null');
      FConexao.Query.SQL.Add('from ReposicaoEnderecoColeta RC');
      FConexao.Query.SQL.Add
        ('Left Join Estoque Est On Est.LoteId = RC.LoteId and Est.EnderecoId = RC.EnderecoId and Est.EstoqueTipoId = 6');
      FConexao.Query.SQL.Add('where reposicaoid = ' + Result.Items[0]
        .GetValue<Integer>('reposicaoid').ToString() +
        ' and Est.LoteId Is Null');
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('ReposicaoDemandaReserva.Sql');
      FConexao.Query.ExecSQL;
    End;
    FConexao.Query.connection.Commit;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('N�o foi poss�vel Gerar a reposi��o.' + sLineBreak
        + E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.ReposicaoSalvarItemColetado(pJsonReposicao: TjSonArray)
  : TjSonArray;
Var
  vTransaction: Boolean;
  xColeta: Integer;
  vReposicaoId: Integer;
  vEstoqueTipoId: Integer;
  vQtdeReserva: Integer;
begin
  Try
    // vGuuid := TGUID.NewGuid.ToString();
    FConexao.Query.connection.StartTransaction;
    xColeta := 0;
    for xColeta := 0 to Pred(pJsonReposicao.Count) do
    Begin
      // Baixar Estoque
      if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') > 0) and
        (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid') <> '') and
        (pJsonReposicao.Get(xColeta).GetValue<String>('pickingid') <> '0') then
      Begin
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add('-- PedidoSaidaDao.ReposicaoSalvarItemColetado');
        FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
        FConexao.Query.ParamByName('pLoteId').Value :=
          pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
        FConexao.Query.ParamByName('pEnderecoId').Value :=
          pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
        FConexao.Query.ParamByName('pEstoqueTipoId').Value :=
          pJsonReposicao.Get(xColeta).GetValue<Integer>('estoquetipoid');
        FConexao.Query.ParamByName('pQuantidade').Value :=
          (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') * -1);
        FConexao.Query.ParamByName('pUsuarioId').Value :=
          (pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid'));
        if DebugHook <> 0 then
          FConexao.Query.SQL.SaveToFile('SqlReposicaoBaixarEstoque.Sql');
        if (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') > 0) then
          FConexao.Query.ExecSQL;
        // Baixar Reserva
        FConexao.Query.Close;
        FConexao.Query.SQL.Clear;
        FConexao.Query.SQL.Add('Select Coalesce(Qtde, 0) Qtde From Estoque');
        FConexao.Query.SQL.Add('Where LoteId = ' + pJsonReposicao.Get(xColeta)
          .GetValue<String>('loteid'));
        FConexao.Query.SQL.Add('  And EnderecoId = ' +
          pJsonReposicao.Get(xColeta).GetValue<String>('enderecoid'));
        FConexao.Query.SQL.Add('  And EstoqueTipoId = 6');
        FConexao.Query.Open;
        vQtdeReserva := FConexao.Query.FieldByName('Qtde').Asinteger;
        if FConexao.Query.FieldByName('Qtde').Asinteger > 0 then
        Begin
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add
            ('-- PedidoSaidaDao.ReposicaoSalvarItemColetado');
          FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
          FConexao.Query.ParamByName('pLoteId').Value :=
            pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
          FConexao.Query.ParamByName('pEnderecoId').Value :=
            pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
          FConexao.Query.ParamByName('pEstoqueTipoId').Value := 6;
          if vQtdeReserva >= (pJsonReposicao.Get(xColeta)
            .GetValue<Integer>('qtde')) then
            FConexao.Query.ParamByName('pQuantidade').Value :=
              (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') * -1)
          Else
            FConexao.Query.ParamByName('pQuantidade').Value :=
              (vQtdeReserva * -1);
          FConexao.Query.ParamByName('pUsuarioId').Value :=
            pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
          if DebugHook <> 0 then
          Begin
            FConexao.Query.SQL.Add('-- pLoteId = ' + pJsonReposicao.Get(xColeta)
              .GetValue<Integer>('loteid').ToString());
            FConexao.Query.SQL.Add('-- pEnderecoId = ' +
              pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid')
              .ToString());
            FConexao.Query.SQL.Add('-- pQuantidadeId = ' +
              (pJsonReposicao.Get(xColeta).GetValue<Integer>('qtde') * -1)
              .ToString());
            FConexao.Query.SQL.SaveToFile('SqlReposicaoBaixarReserva.Sql');
          End;
          FConexao.Query.ExecSQL;
        End;
        // Transferir para o Picking
        if pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo') > 0 then
        Begin
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          FConexao.Query.SQL.Add
            ('Select Coalesce(ReposicaoColetaParaPicking, 0) ReposicaoColetaParaPicking From Configuracao');
          FConexao.Query.Open;
          If FConexao.Query.FieldByName('ReposicaoColetaParaPicking')
            .Asinteger = 0 then
            vEstoqueTipoId := 7
          Else
            vEstoqueTipoId := pJsonReposicao.Get(xColeta)
              .GetValue<Integer>('estoquetipoid');
          FConexao.Query.Close;
          FConexao.Query.SQL.Clear;
          if vEstoqueTipoId = 7 then
          Begin
            FConexao.Query.SQL.Add
              (TuEvolutConst.SqlReposicaoSalvarItemColetado);
            // SqlReposicaoEstoqueTransferencia);
            FConexao.Query.ParamByName('pLoteId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
            FConexao.Query.ParamByName('pEnderecoId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
            FConexao.Query.ParamByName('pReposicaoId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid');
            FConexao.Query.ParamByName('pEnderecoOrigemId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('enderecoid');
            FConexao.Query.ParamByName('pEstoqueTipoId').Value :=
              vEstoqueTipoId;
            FConexao.Query.ParamByName('pQuantidade').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
            FConexao.Query.ParamByName('pUsuarioId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
            FConexao.Query.ParamByName('pTerminal').Value :=
              pJsonReposicao.Get(xColeta).GetValue<String>('terminal');
          End
          Else
          Begin
            FConexao.Query.SQL.Add
              ('-- PedidoSaidaDao.ReposicaoSalvarItemColetado  EstoqueTipoId <> 7');
            FConexao.Query.SQL.Add(TuEvolutConst.SqlEstoque);
            FConexao.Query.ParamByName('pLoteId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('loteid');
            FConexao.Query.ParamByName('pEnderecoId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('pickingid');
            FConexao.Query.ParamByName('pEstoqueTipoId').Value :=
              vEstoqueTipoId;
            FConexao.Query.ParamByName('pQuantidade').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('qtdrepo');
            FConexao.Query.ParamByName('pUsuarioId').Value :=
              pJsonReposicao.Get(xColeta).GetValue<Integer>('usuarioid');
          End;
          if DebugHook <> 0 then
            FConexao.Query.SQL.SaveToFile('SqlReposicaoTransfPicking.Sql');
          FConexao.Query.ExecSQL;
        End;
      End;
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('Update ReposicaoEnderecoColeta');
      FConexao.Query.SQL.Add('  Set QtdRepo = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('qtdrepo').ToString());
      FConexao.Query.SQL.Add('    , UsuarioId = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('usuarioid').ToString());
      FConexao.Query.SQL.Add('    , Terminal  = ' +
        QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('terminal')));
      FConexao.Query.SQL.Add('    , DtEntrada = ' +
        QuotedStr(FormatDateTime('YYYY-MM-DD',
        StrToDate(pJsonReposicao.Get(xColeta).GetValue<String>('dtentrada')))));
      FConexao.Query.SQL.Add('    , HrEntrada = ' +
        QuotedStr(pJsonReposicao.Get(xColeta).GetValue<String>('hrentrada')));
      FConexao.Query.SQL.Add('Where ReposicaoId = ' +
        pJsonReposicao.Get(xColeta).GetValue<Integer>('reposicaoid').ToString);
      FConexao.Query.SQL.Add('  And ProdutoId = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('produtoid').ToString);
      FConexao.Query.SQL.Add('  And Loteid = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('loteid').ToString());
      FConexao.Query.SQL.Add('  And EnderecoId = ' + pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('enderecoid').ToString());
      if DebugHook <> 0 then
        FConexao.Query.SQL.SaveToFile('SqlReposicaoEnderecoColeta.Sql');

      FConexao.Query.ExecSQL;
      vReposicaoId := pJsonReposicao.Get(xColeta)
        .GetValue<Integer>('reposicaoid');
      // Registrar no Kardex

    End;
    FConexao.Query.connection.Commit;
    Result := TjSonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok', '201'));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create(E.Message);
    End;
  end;
end;

function TPedidoSaidaDao.Salvar: Boolean;
var
  vSql: String;
begin
  try
    if Self.PedidoSaida.PedidoId = 0 then
      vSql := 'Insert Into Pedido (OperacaoTipoId, PessoaId, DocumentoNr, DocumentoData, RegistroERP, DtInclusao, HrInclusao, ArmazemId) Values ('
        + Self.PedidoSaida.OperacaoTipo.OperacaoTipoId.ToString() + ', ' +
        Self.PedidoSaida.Pessoa.PessoaId.ToString() + ', ' +
        QuotedStr(Self.PedidoSaida.DocumentoNr) + ', ' +
        '(select IdData From Rhema_Data where Data = ' + #39 +
        FormatDateTime('YYYY-MM-DD', Self.PedidoSaida.DocumentoData) + #39 +
        '), ' + #39 + Self.PedidoSaida.RegistroERP + #39 + ', ' + SqlDataAtual +
        ', ' + SqlHoraAtual + ', ' +
      // Self.PedidoSaida.ArmazemId.ToString() //
        IfThen(Self.PedidoSaida.ArmazemId = 0, 'Null',
        Self.PedidoSaida.ToString()) + ')'
    Else
      vSql := ' Update Pedido ' + '     Set OperacaoTipoId = ' +
        Self.PedidoSaida.OperacaoTipo.OperacaoTipoId.ToString() +
        '   , PessoaId      = ' + Self.PedidoSaida.Pessoa.PessoaId.ToString() +
        '   , DocumentoNr   = ' + QuotedStr(Self.PedidoSaida.DocumentoNr) +
        '   , DocumentoData = ' + '(select IdData From Rhema_Data where Data = '
        + #39 + FormatDateTime('YYYY-MM-DD', Self.PedidoSaida.DocumentoData) +
        #39 + ')' + '   , RegistroERP   = ' +
        QuotedStr(Self.PedidoSaida.RegistroERP) + '   , ArmazemId     = ' +
        Self.PedidoSaida.ArmazemId.ToString() + ' where PedidoId = ' +
        Self.PedidoSaida.PedidoId.ToString + ' and OperacaoTipoId = 2';
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;

end;

end.
