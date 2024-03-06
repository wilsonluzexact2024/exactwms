unit Services.Recebimento;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  Services.Produto, FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI,
  exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

Const
  SqlEntrada = 'Declare @PedidoId Integer        = :pPedidoId' + sLineBreak +
    'Declare @CodPessoaERP Integer    = :pCodPessoaERP' + sLineBreak +
    'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
    'Declare @Razao VarChar(100)      = :pRazao' + sLineBreak +
    'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
    'Declare @Pendente Integer        = :pPendente' + sLineBreak +
    'Declare @AgrupamentoId Integer   = :pAgrupamentoId' + sLineBreak +
    'Declare @DtNotaFiscal DateTime   = :pDtNotaFiscal' + sLineBreak +
    'select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid,'
    + sLineBreak +
    '       P.CodPessoaERP, P.Razao, Ped.DocumentoNr, FORMAT(Rd.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') ' + sLineBreak +
    '       as DocumentoData, Ped.RegistroERP, FORMAT(RE.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') as DtInclusao, ' + sLineBreak +
    '       CONVERT(VARCHAR, RH.hora ,8) as HrInclusao, ArmazemId, Ped.Status, De.ProcessoId, De.Descricao as Processo,'
    + sLineBreak + '       Coalesce(Pa.AgrupamentoId, 0) AgrupamentoId' +
    sLineBreak + 'From pedido Ped ' + sLineBreak +
    'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId ' +
    sLineBreak + 'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId ' +
    sLineBreak + 'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData ' +
    sLineBreak + 'Inner Join Rhema_Data RE On Re.IdData = Ped.DtInclusao ' +
    sLineBreak + 'Inner Join Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao ' +
    sLineBreak + 'Left join vDocumentoEtapas DE On De.Documento = Ped.Uuid' +
    sLineBreak +
    'Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = Ped.PedidoId' +
    sLineBreak +
    'Where (@PedidoId = 0 or Ped.PedidoId = @PedidoId) and Ped.OperacaoTipoId = 3 and '
    + sLineBreak +
    '      (@CodPessoaERP = 0 or P.CodPessoaERP = @CodPessoaERP) and ' +
    sLineBreak + '      (@DocumentoNr = ' + #39 + #39 +
    ' or Ped.DocumentoNr = @DocumentoNr) and ' + sLineBreak + '      (@Razao = '
    + #39 + #39 + ' or P.Razao Like @Razao) and ' + sLineBreak +
    '      (@RegistroERP = ' + #39 + #39 + ' or Ped.RegistroERP = @RegistroERP)'
    + sLineBreak +
    '      And De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
    + sLineBreak + '      And (@DtNotaFiscal = 0 or Rd.Data = @DtNotaFiscal)' +
    sLineBreak + '      And (@Pendente = 0 or (De.ProcessoId in (1,4)))' +
    sLineBreak +
    '      And (@AgrupamentoId = 0 or Pa.AgrupamentoId = @AgrupamentoId or (@AgrupamentoId=-1 and PA.agrupamentoid Is Null))'
    + sLineBreak + '      And De.ProcessoId <> 31' + sLineBreak +
    'Order by Ped.PedidoId';
  // Retiraro o 5, ver se n�o gera impacto no retorno da integra��o

Const
  SqlEntradaItens =
    'select PIt.PedidoId, PIt.PedidoItemId, Pl.LoteId, Pl.ProdutoId, Prd.CodProduto CodigoERP, Pl.DescrLote'
    + #13 + #10 + ', FORMAT(DF.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as Fabricacao' + #13 + #10 + ', FORMAT(DV.Data, ' + #39 + 'dd/MM/yyyy' +
    #39 + ') as Vencimento  ' + #13 + #10 + ', FORMAT(RD.Data, ' + #39 +
    'dd/MM/yyyy' + #39 + ') as DtEntrada  ' + #13 + #10 +
    ', Rh.Hora HrEntrada, ' + #13 + #10 +
    'PIt.QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida, PIt.QtdSegregada, ' + #13 +
    #10 + 'Prd.Descricao DescrProduto, PIt.PrintEtqControlado' + #13 + #10 +
    'From PedidoItens PIt' + #13 + #10 +
    'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + #13 + #10 +
    'Left Join Rhema_Data DF On DF.IdData = Pl.Fabricacao ' + #13 + #10 +
    'Left Join Rhema_Data DV On DV.IdData = Pl.Vencimento ' + #13 + #10 +
    'Inner join Rhema_Data RD on Rd.IdData = Pl.DtEntrada' + #13 + #10 +
    'Left Join Rhema_Hora RH on Rh.IdHora = Pl.HrEntrada' + #13 + #10 +
    'Inner join Produto Prd On Prd.IdProduto = Pl.ProdutoId' + #13 + #10 +
    'Where PedidoId = @pPedido';

type
  TServiceRecebimento = class(TBasicDao)
  private
    { Private declarations }
    function AtualizarKardex(pQryKardex: TFdQuery;
      pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId,
      pEstoqueTipoIdDestino, pQuantidade, pEnderecoIdDestino,
      pUsuarioId: Integer; pObservacaoOrigem, pObservacaoDestino,
      pNomeEstacao: String): Boolean;
  public
    { Public declarations }
    function Pesquisar(pPedidoId, pCodPessoaERP: Integer;
      pDocumento, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
      pPendente: Integer; pAgrupamentoId: Integer; pBasico: Boolean;
      pShowErro: Integer = 1): tJsonArray;
    Function GetEtiquetaArmazenagem(pPedidoId: Integer = 0;
      pDocumentoNr: String = ''; pZonaId: Integer = 0; pCodProduto: Integer = 0;
      pSintetico: Integer = 0; pDtInicio: TDateTime = 0;
      pDtTermino: TDateTime = 0): tJsonArray;
    Function DshRecebimentos(pDataInicial, pDataFinal: TDateTime): tJsonArray;
    Function ExcluirPreEntrada(pJsonArray: tJsonArray): tJsonArray;
    Function CancelarNFeERP(pJsonArray: tJsonArray): tJsonArray;
    Function FinalizarCheckIn(pjsonEntrada: TJsonObject): Boolean;
    Function GetEntradaProduto(pPedidoId, pAgrupamentoId: Integer): tJsonArray;
    Function GetEntradaLotes(pPedidoId, pAgrupamentoId, pCodProduto,
      pLoteId: Integer): tJsonArray;
    Function GetEntradaItens(pPedidoId, pAgrupamentoId: Integer): tJsonArray;
    function GetEntradaProdutoSemPicking(pDataInicial, pDataFinal: TDateTime;
      pPedidoId: Integer; pCodPessoaERP: Integer; pDocumentoNr: String)
      : tJsonArray;
    Function SalvarCheckInItem(pjsonEntrada: TJsonObject): TJsonObject;
    Function ValidarQtdCheckIn(pPedidoId, pCodProduto: Int64): tJsonArray;
    Function SalvarAgrupamento(pNotaAgrupamentoJsonArray: tJsonArray)
      : tJsonArray;
    Function GetAgrupamentoLista(pAgrupamentoId, pCodPessoaERP: Integer)
      : tJsonArray;
    Function GetAgrupamentoPedido(pAgrupamentoId, pPedidoId: Integer)
      : tJsonArray;
    Function SalvarCheckInItemAgrupamento(pJsonItemCheckIn: TJsonObject)
      : TJsonObject;
    Function GetAgrupamentoFatorarLoteXML(pAgrupamentoId: Integer): tJsonArray;
    Function GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId: Integer)
      : tJsonArray;
    Function CancelarCheckInProduto(pAgrupamentoId, pPedidoId,
      pCodProduto: Integer): tJsonArray;
    Function DeleteAgrupamento(pAgrupamentoId, pPedidoId: Integer): tJsonArray;
    Function GetProdutoTagByProduto(aQuery: TDictionary<String, String>)
      : tJsonArray;
    Function RegPrintEtqProduto(pPedidoId, pLoteId: Integer): tJsonArray;
    Function GetResumoCheckIn(pEntradaId: Integer): tJsonArray;
    Function Header(pEntradaId, pAgrupamentoId: Integer): tJsonArray;
    Function GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId,
      pCodProduto: Integer): tJsonArray;
    Function GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId,
      pCodProduto: Integer): tJsonArray;
    Function GetOcorrencias(pPedidoId: Integer;
      pDocumentoNr, pRegistroERP: String; pCodProduto: Integer;
      pDataInicial, pDataFinal, pDataCheckInInicial, pDataCheckInFinal
      : TDateTime): tJsonArray;
    Function GetAcompanhamentoCheckIn(pPedidoId, pCodPessoaERP: Integer;
      pDataInicial, pDataFinal: TDateTime): tJsonArray;

    constructor Create;  overload;
    destructor Destroy; override;
  end;

var
  ServiceRecebimento: TServiceRecebimento;

implementation

uses Constants, EntradaItensClass, EntradaClass, ProdutoClass;

{ TProvidersBase1 }

function TServiceRecebimento.DeleteAgrupamento(pAgrupamentoId,
  pPedidoId: Integer): tJsonArray;
Var
  JsonArrayErro: tJsonArray;
begin
  Try
    Result := tJsonArray.Create;
    FConexao.Query.Close;
    FConexao.Query.Sql.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
    FConexao.Query.Sql.Add('Declare @PedidoId      Integer = :pPedidoid');
    FConexao.Query.Sql.Add
      ('Delete PedidoAgrupamento where (AgrupamentoId=@AgrupamentoId and @PedidoId=0)');
    FConexao.Query.Sql.Add
      ('Delete PedidoAgrupamentoNotas Where (@AgrupamentoId=0 or @AgrupamentoId = AgrupamentoId) And PedidoId = @PedidoId ');
    FConexao.Query.Sql.Add('Delete Pa');
    FConexao.Query.Sql.Add('From PedidoAgrupamento Pa');
    FConexao.Query.Sql.Add
      ('Left Join PedidoAgrupamentoNotas PN ON PN.agrupamentoid = Pa.agrupamentoid');
    FConexao.Query.Sql.Add
      ('where Pa.agrupamentoid = @AgrupamentoId and Pn.AgrupamentoId Is Null');
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ExecSql;
    Result.AddElement(TJsonObject.Create.AddPair('Status',
      TJsonNumber.Create(200)));
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: DeleteAgrupamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

destructor TServiceRecebimento.Destroy;
begin

  inherited;

end;

function TServiceRecebimento.DshRecebimentos(pDataInicial,
  pDataFinal: TDateTime): tJsonArray;
var
  vSql: String;
  JsonArrayResumo: tJsonArray;
begin
  Try
    Result := tJsonArray.Create;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlDshRecebimentos);
    FConexao.Query.ParamByName('pDataInicial').Value := pDataInicial;
    FConexao.Query.ParamByName('pDataFinal').Value := pDataFinal;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('RelDshRecebimento.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.AtualizarKardex(pQryKardex: TFdQuery;
  pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId, pEstoqueTipoIdDestino,
  pQuantidade, pEnderecoIdDestino, pUsuarioId: Integer;
  pObservacaoOrigem, pObservacaoDestino, pNomeEstacao: String): Boolean;
begin

end;

function TServiceRecebimento.CancelarCheckInProduto(pAgrupamentoId, pPedidoId,
  pCodProduto: Integer): tJsonArray;
Var
  JsonArrayErro: tJsonArray;
begin
  Try
    Result := tJsonArray.Create;
    FConexao.Query.Close;
    FConexao.Query.Sql.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
    FConexao.Query.Sql.Add('Declare @PedidoId      Integer = :pPedidoId');
    FConexao.Query.Sql.Add
      ('Declare @ProdutoId     Integer = Coalesce((Select IdProduto From Produto where CodProduto = :pCodProduto), 0)');
    FConexao.Query.Sql.Add('Delete Pc');
    FConexao.Query.Sql.Add('from PedidoItensCheckIn Pc');
    FConexao.Query.Sql.Add
      ('Inner Join ProdutoLotes Pl on Pl.LoteId = Pc.LoteId');
    FConexao.Query.Sql.Add
      ('Left Join PedidoAgrupamentoNotas Pn on Pn.pedidoid = Pc.PedidoId');
    FConexao.Query.Sql.Add
      ('where (@AgrupamentoId=0 or Pn.agrupamentoid=@AgrupamentoId) and');
    FConexao.Query.Sql.Add
      ('      (@PedidoId=0 or Pc.PedidoId = @PedidoId) and');
    FConexao.Query.Sql.Add
      ('	     (@ProdutoId = 0 or Pl.ProdutoId = @ProdutoId)');
    FConexao.Query.Sql.Add('');
    FConexao.Query.Sql.Add('Delete Pi');
    FConexao.Query.Sql.Add('from PedidoItens Pi');
    FConexao.Query.Sql.Add
      ('Inner Join ProdutoLotes Pl on Pl.LoteId = Pi.LoteId');
    FConexao.Query.Sql.Add
      ('Left Join PedidoAgrupamentoNotas Pn on Pn.pedidoid = Pi.PedidoId');
    FConexao.Query.Sql.Add
      ('where (@AgrupamentoId=0 or Pn.agrupamentoid=@AgrupamentoId) and');
    FConexao.Query.Sql.Add
      ('      (@PedidoId=0 or Pi.PedidoId = @PedidoId) and');
    FConexao.Query.Sql.Add
      ('	     (@ProdutoId = 0 or Pl.ProdutoId = @ProdutoId) and QtdXml = 0');

    FConexao.Query.Sql.Add('Update Pi');
    FConexao.Query.Sql.Add
      ('   set QtdCheckIn = 0, QtdDevolvida = 0, QtdSegregada = 0');
    FConexao.Query.Sql.Add('from PedidoItens Pi');
    FConexao.Query.Sql.Add
      ('Inner Join ProdutoLotes Pl on Pl.LoteId = Pi.LoteId');
    FConexao.Query.Sql.Add
      ('Left Join PedidoAgrupamentoNotas Pn on Pn.pedidoid = Pi.PedidoId');
    FConexao.Query.Sql.Add
      ('where (@AgrupamentoId=0 or Pn.agrupamentoid=@AgrupamentoId) and');
    FConexao.Query.Sql.Add
      ('      (@PedidoId=0 or Pi.PedidoId = @PedidoId) And');
    FConexao.Query.Sql.Add
      ('	     (@ProdutoId = 0 or Pl.ProdutoId = @ProdutoId)');

    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    FConexao.Query.ExecSql;
    Result.AddElement(TJsonObject.Create.AddPair('Status',
      TJsonNumber.Create(200)));
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: CancelarCheckInProduto - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.CancelarNFeERP(pJsonArray: tJsonArray): tJsonArray;
Var
  vQryDelete: TFdQuery;
  vQryValida: TFdQuery;
  xPedido: Integer;
  JsonArrayErro: tJsonArray;
begin
  Try
    Result := tJsonArray.Create;
    vQryDelete := FConexao.GetQuery;
    vQryValida := FConexao.GetQuery;
    vQryDelete.connection.StartTransaction;
    vQryDelete.Close;
    vQryDelete.Sql.Add('Declare @PedidoId VarChar(50) = :pPedidoId');
    vQryDelete.Sql.Add('Declare @UsuarioId Integer = Null'); // :pUsuarioId');
    vQryDelete.Sql.Add('Declare @Terminal Varchar(50) = :pTerminal');
    vQryDelete.Sql.Add('Update Pedido Set Status = 3 ');
    vQryDelete.Sql.Add('where ((Cast(PedidoId as VarChar(36)) = @PedidoId)');
    vQryDelete.Sql.Add
      ('   or  (Cast(RegistroERP as VarChar(36)) = @PedidoId))');
    vQryDelete.Sql.Add('      and OperacaoTipoId = 2');
    vQryDelete.Sql.Add('Insert Into DocumentoEtapas Values (');
    vQryDelete.Sql.Add
      ('       Cast((Select Uuid from Pedido Where ((Cast(PedidoId as VarChar(36)) = @PedidoId) or (RegistroERP = @PedidoId))) as UNIQUEIDENTIFIER), ');
    vQryDelete.Sql.Add
      ('       (Select ProcessoId From ProcessoEtapas Where Descricao = ' + #39
      + 'Documento Excluido' + #39 + '), ');
    vQryDelete.Sql.Add('@UsuarioId, ' + TuEvolutConst.SqlDataAtual + ', ' +
      TuEvolutConst.SqlHoraAtual + ', GetDate(), @Terminal, 1)');
    for xPedido := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        vQryValida.Close;
        vQryValida.Sql.Clear;
        vQryValida.Sql.Add('Declare @RegistroERP VarChar(36) = :pRegistroERP');
        vQryValida.Sql.Add('Declare @PedidoId VarChar(36)    = :pPedidoId');
        vQryValida.Sql.Add
          ('select Ped.DocumentoNr, Ped.RegistroERP, De.ProcessoId, De.Descricao Processo, De.Horario, Ped.Status');
        vQryValida.Sql.Add('From pedido Ped');
        vQryValida.Sql.Add
          ('Left join vDocumentoEtapas De On De.Documento = Ped.uuid');
        vQryValida.Sql.Add
          ('where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and');
        vQryValida.Sql.Add('      Ped.OperacaoTipoId = 3 And');
        vQryValida.Sql.Add
          ('      ((Cast(Ped.RegistroERP as VarChar(36)) = @RegistroERP) ');
        vQryValida.Sql.Add
          ('       Or (Cast(PedidoId as VarChar(36))        = @PedidoId))');
        vQryValida.ParamByName('pRegistroERP').Value :=
          pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
        vQryValida.ParamByName('pPedidoId').Value := pJsonArray.Items[xPedido]
          .GetValue<String>('pedidoid');
        If DebugHook <> 0 Then
          vQryValida.Sql.SaveToFile('ValidaEntrada.Sql');
        vQryValida.Open;
        if (vQryValida.IsEmpty) then
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('status', '500')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', 'Documento n�o localizacado.'));
        End
        Else If ((vQryValida.FieldByName('ProcessoId').AsInteger > 4) or
          (vQryValida.FieldByName('Status').AsInteger = 2)) then
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('status', '500')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', 'Entrada n�o pode ser exclu�da. Processo: ' +
            vQryValida.FieldByName('Processo').AsString));
        End
        Else
        begin
          vQryDelete.Close;
          vQryDelete.ParamByName('pPedidoId').Value := pJsonArray.Items[xPedido]
            .GetValue<String>('pedidoid');
          // vQryDelete.ParamByName('pUsuarioId').Value := 0;  //pJsonArray.Items[xPedido].GetValue<Integer>('usuarioid');
          vQryDelete.ParamByName('pTerminal').Value := 'IntegracaoERP';
          // pJsonArray.Items[xPedido].GetValue<String>('terminal');
          If DebugHook <> 0 Then
            vQryDelete.Sql.SaveToFile('PedidoExcluir.Sql');
          vQryDelete.ExecSql;
          Result.AddElement(TJsonObject.Create.AddPair('status', '200')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', 'Entrada exclu�da com sucesso'));

          // 'pedidoid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid')+' - Ok! Excluido.'))
        end;
      Except
        On E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('status', '500')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', E.Message));
          // raise Exception.Create('N�o foi poss�vel excluir o Pedido: '+pJsonArray.Items[xPedido].GetValue<String>('pedidoid'));
        End;
      End;
    End;
    vQryDelete.connection.Commit;

  Except
    On E: Exception do
    Begin
      vQryDelete.connection.Rollback;

      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('entradaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
        .AddPair('mensagem', E.Message));
      // raise Exception.Create('Processo: DeletePedido - '+StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  End;
End;

constructor TServiceRecebimento.Create;
begin
  inherited;
end;

function TServiceRecebimento.ExcluirPreEntrada(pJsonArray: tJsonArray)
  : tJsonArray;
Var
  vQryDelete: TFdQuery;
  vQryValida: TFdQuery;
  xPedido: Integer;
  JsonArrayErro: tJsonArray;
begin
  Try
    Result := tJsonArray.Create;
    vQryDelete := FConexao.GetQuery;
    vQryValida := FConexao.GetQuery;
    vQryDelete.connection.StartTransaction;
    vQryDelete.Close;
    vQryDelete.Sql.Add('Declare @PedidoId VarChar(50) = :pPedidoId');
    vQryDelete.Sql.Add('Declare @UsuarioId Integer = Null'); // :pUsuarioId');
    vQryDelete.Sql.Add('Declare @Terminal Varchar(50) = :pTerminal');
    vQryDelete.Sql.Add('Update Pedido Set Status = 3 ');
    vQryDelete.Sql.Add('where ((Cast(PedidoId as VarChar(36)) = @PedidoId)');
    vQryDelete.Sql.Add
      ('   or  (Cast(RegistroERP as VarChar(36)) = @PedidoId))');
    vQryDelete.Sql.Add('      and OperacaoTipoId = 2');
    vQryDelete.Sql.Add('Insert Into DocumentoEtapas Values (');
    vQryDelete.Sql.Add
      ('       Cast((Select Uuid from Pedido Where ((Cast(PedidoId as VarChar(36)) = @PedidoId) or (RegistroERP = @PedidoId))) as UNIQUEIDENTIFIER), ');
    vQryDelete.Sql.Add
      ('       (Select ProcessoId From ProcessoEtapas Where Descricao = ' + #39
      + 'Documento Excluido' + #39 + '), ');
    vQryDelete.Sql.Add('@UsuarioId, ' + TuEvolutConst.SqlDataAtual + ', ' +
      TuEvolutConst.SqlHoraAtual + ', GetDate(), @Terminal, 1)');
    for xPedido := 0 to Pred(pJsonArray.Count) do
    Begin
      Try
        vQryValida.Close;
        vQryValida.Sql.Clear;
        vQryValida.Sql.Add('Declare @RegistroERP VarChar(36) = :pRegistroERP');
        vQryValida.Sql.Add('Declare @PedidoId VarChar(36)    = :pPedidoId');
        vQryValida.Sql.Add
          ('select Ped.DocumentoNr, Ped.RegistroERP, De.ProcessoId, De.Descricao Processo, De.Horario, Ped.Status');
        vQryValida.Sql.Add('From pedido Ped');
        vQryValida.Sql.Add
          ('Left join vDocumentoEtapas De On De.Documento = Ped.uuid');
        vQryValida.Sql.Add
          ('where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and');
        vQryValida.Sql.Add('      Ped.OperacaoTipoId = 3 And');
        vQryValida.Sql.Add
          ('      ((Cast(Ped.RegistroERP as VarChar(36)) = @RegistroERP) ');
        vQryValida.Sql.Add
          ('       Or (Cast(PedidoId as VarChar(36))        = @PedidoId))');
        vQryValida.ParamByName('pRegistroERP').Value :=
          pJsonArray.Items[xPedido].GetValue<String>('pedidoid');
        vQryValida.ParamByName('pPedidoId').Value := pJsonArray.Items[xPedido]
          .GetValue<String>('pedidoid');
        If DebugHook <> 0 Then
          vQryValida.Sql.SaveToFile('ValidaEntrada.Sql');
        vQryValida.Open;
        if (vQryValida.IsEmpty) then
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('status', '500')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', 'Documento n�o localizacado.'));
        End
        Else If ((vQryValida.FieldByName('ProcessoId').AsInteger > 4) or
          (vQryValida.FieldByName('Status').AsInteger = 2)) then
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('status', '500')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', 'Entrada n�o pode ser exclu�da. Processo: ' +
            vQryValida.FieldByName('Processo').AsString));
        End
        Else
        begin
          vQryDelete.Close;
          vQryDelete.ParamByName('pPedidoId').Value := pJsonArray.Items[xPedido]
            .GetValue<String>('pedidoid');
          // vQryDelete.ParamByName('pUsuarioId').Value := 0;  //pJsonArray.Items[xPedido].GetValue<Integer>('usuarioid');
          vQryDelete.ParamByName('pTerminal').Value := 'IntegracaoERP';
          // pJsonArray.Items[xPedido].GetValue<String>('terminal');
          If DebugHook <> 0 Then
            vQryDelete.Sql.SaveToFile('PedidoExcluir.Sql');
          vQryDelete.ExecSql;
          Result.AddElement(TJsonObject.Create.AddPair('status', '200')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', 'Entrada exclu�da com sucesso'));

          // 'pedidoid', pJsonArray.Items[xPedido].GetValue<String>('pedidoid')+' - Ok! Excluido.'))
        end;
      Except
        On E: Exception do
        Begin
          Result.AddElement(TJsonObject.Create.AddPair('status', '500')
            .AddPair('entradaid', pJsonArray.Items[xPedido].GetValue<String>
            ('pedidoid')).AddPair('documentoerp',
            pJsonArray.Items[xPedido].GetValue<String>('pedidoid'))
            .AddPair('mensagem', E.Message));
          // raise Exception.Create('N�o foi poss�vel excluir o Pedido: '+pJsonArray.Items[xPedido].GetValue<String>('pedidoid'));
        End;
      End;
    End;
    vQryDelete.connection.Commit;
    vQryDelete.Close;
  Except
    On E: Exception do
    Begin
      vQryDelete.connection.Rollback;
      vQryDelete.Close;
      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('entradaid', TJsonNumber.Create(0)).AddPair('documentoerp', '')
        .AddPair('mensagem', E.Message));
    End;
  End;
end;

function TServiceRecebimento.FinalizarCheckIn(pjsonEntrada
  : TJsonObject): Boolean;
Var
  vQryFinalizar, vQryItens, vQryKardex: TFdQuery;
  EntradaId, vEnderecoIdStage: Integer;
  vSql: String;
  vRecno: Integer;
  vEstoqueInicial: Integer;
begin
  Result := False; // TJsonArray.Create;
  vQryFinalizar := FConexao.GetQuery;
  vQryFinalizar.connection.StartTransaction;
  vQryKardex := FConexao.GetQuery;
  vQryItens := FConexao.GetQuery;
  Try
    EntradaId := pjsonEntrada.GetValue<Integer>('pedido');
    vQryItens.connection := vQryFinalizar.connection;
    vQryItens.Close;
    vQryItens.Sql.Clear;
    vQryItens.Sql.Add('Select De.ProcessoId, Ped.Status ');
    vQryItens.Sql.Add('From vDocumentoEtapas De');
    vQryItens.Sql.Add('Inner join Pedido Ped On Ped.Uuid = De.Documento');
    vQryItens.Sql.Add('Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.PedidoId = '+EntradaId.ToString());
    vQryItens.Open;
    if (vQryItens.FieldByName('ProcessoId').AsInteger = 5) or (vQryItens.FieldByName('Status').AsInteger = 2) then
    Begin
      vQryItens.Close;
      raise Exception.Create('Entrada j� finalizada!!!');
    End;
    vQryItens.Close;
    vQryItens.Sql.Clear;
    vQryItens.Sql.Add('select PI.*, Rd.Data, Rh.hora ');
    vQryItens.Sql.Add('From PedidoItensCheckIn PI');
    vQryItens.Sql.Add('Inner Join Rhema_Data Rd On Rd.IdData = PI.CheckInDtInicio');
    vQryItens.Sql.Add('Inner join Rhema_Hora Rh ON Rh.IdHora = Pi.CheckInHrInicio');
    vQryItens.Sql.Add('where PedidoId = ' + EntradaId.ToString());// + ' and Pi.QtdCheckIn > 0');
    vQryItens.Open;
    vRecno := vQryItens.RecordCount;
    vQryItens.First;
    while Not vQryItens.Eof do
    Begin
      // LoteId        := vQryItens.FieldByName('LoteId').AsInteger;
      vQryFinalizar.Close;
      vQryFinalizar.Sql.Clear;
      vQryFinalizar.Sql.Add('select LoteId, ');
      vQryFinalizar.Sql.Add('       (Case When SNGPC = 1 or ZonaSNGPC = 1 then (Select EnderecoIdStageSNGPC From Configuracao)');
      vQryFinalizar.Sql.Add('	            Else (Select EnderecoIdStage From Configuracao) End) EnderecoIdStage');
      vQryFinalizar.Sql.Add('from vProdutoLotes');
      vQryFinalizar.Sql.Add('where LoteId = :pLoteId');
      vQryFinalizar.ParamByName('pLoteId').Value := vQryItens.FieldByName('LoteId').AsInteger;
      vQryFinalizar.Open();
      vEnderecoIdStage := vQryFinalizar.FieldByName('EnderecoIdStage').AsInteger;
      // Pegar Saldo inicial do Lote
      vQryFinalizar.Close;
      vQryFinalizar.Sql.Clear;
      vQryFinalizar.Sql.Add('select Qtde From Estoque');
      vQryFinalizar.Sql.Add('Where LoteId = ' + vQryItens.FieldByName('LoteId').AsString);
      vQryFinalizar.Sql.Add('  And EnderecoId = ' + vEnderecoIdStage.ToString());
      vQryFinalizar.Sql.Add('  And EstoqueTipoId = 1');
      vQryFinalizar.Open;
      vEstoqueInicial := vQryFinalizar.FieldByName('Qtde').AsInteger;
      vQryFinalizar.Close;
      vQryFinalizar.Sql.Clear;
      vSql := 'Declare @EntradaId Integer = ' + EntradaId.ToString() + sLineBreak +
              'Declare @LoteId Integer = ' + vQryItens.FieldByName('LoteId').AsString + sLineBreak +
              'Declare @QtdXml     Integer = ' + vQryItens.FieldByName('QtdXml').AsString + sLineBreak +
              'Declare @QtdCheckIn Integer = ' + vQryItens.FieldByName('QtdCheckIn').AsString + sLineBreak +
              'Declare @QtdDevolvida Integer = ' + vQryItens.FieldByName('QtdDevolvida').AsString + sLineBreak +
              'Declare @QtdSegregada Integer = ' + vQryItens.FieldByName('QtdSegregada').AsString + sLineBreak +
              'Declare @EnderecoIdStage Integer = ' + vEnderecoIdStage.ToString();
      vSql := vSql +
              'If @QtdCheckIn > 0 Begin' + sLineBreak +
              '   If Exists (Select LoteId From Estoque Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage) Begin'+sLineBreak +
              '      Update Estoque Set Qtde = Qtde + @QtdCheckIn Where EstoqueTipoId = 1 and LoteId = @LoteId and EnderecoId = @EnderecoIdStage'+sLineBreak +
              '      End' + sLineBreak + 'Else Begin' + sLineBreak +
              '      Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao ) '+sLineBreak +
              '           Values (@LoteId, @EnderecoIdStage, 1, @QtdCheckIn, ' +sLineBreak +
              '                  (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '+ sLineBreak +
              '                  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) )'+sLineBreak +
              '   End;'+sLineBreak+
              'End;'+sLineBreak;
      vSql := vSql + 'If @QtdSegregada > 0 Begin' + sLineBreak +
              '   If Exists (Select LoteId From Estoque Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)) Begin'+ sLineBreak +
              '      Update Estoque Set Qtde = Qtde + @QtdSegregada Where EstoqueTipoId = 3 and LoteId = @LoteId and EnderecoId = (Select EnderecoSegregadoId From Configuracao)'+sLineBreak +
              '   End' + sLineBreak +
              '	  Else Begin' + sLineBreak +
              '	   Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao ) Values (@LoteId, (Select EnderecoSegregadoId From Configuracao), 3, @QtdSegregada,'+sLineBreak +
              '							(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'+sLineBreak +
              '							(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))) )'+sLineBreak +
              '   End;' + sLineBreak +
              'End;';
      // try Clipboard.AsText := vSql; Except End;
      vQryFinalizar.Sql.Add(vSql);
      if DebugHook <> 0 then
        vQryFinalizar.Sql.SaveToFile('FinalizarCheckIn_AtEstoque' +
          vQryItens.FieldByName('LoteId').AsString + '.Sql');
      vQryFinalizar.ExecSql;
      // AtualizarKardex(vQryKardex, 3, vQryItens.FieldByName('LoteId').AsInteger, vEnderecoIdStage, 1, 1,
      // vQryItens.FieldByName('QtdCheckIn').AsInteger, 1, vQryItens.FieldByName('UsuarioId').AsInteger,
      // 'Recebimento Pedido: '+EntradaId.ToString(), 'Stage - �rea de Armazenagem(Espera)',
      // vQryItens.FieldByName('Terminal').AsString );

      vQryKardex.Close;
      vQryKardex.Sql.Clear;
      vQryKardex.Sql.Add(TuEvolutConst.SqlKardexInsUpd);
      vQryKardex.ParamByName('pOperacaoTipoId').Value := 3;
      vQryKardex.ParamByName('pLoteId').Value := vQryItens.FieldByName('LoteId')
        .AsInteger;
      vQryKardex.ParamByName('pEnderecoId').Value := vEnderecoIdStage;
      vQryKardex.ParamByName('pEstoqueTipoId').Value := 1;
      vQryKardex.ParamByName('pEstoqueTipoIdDestino').Value := 1;
      vQryKardex.ParamByName('pQuantidade').Value :=
        vQryItens.FieldByName('QtdCheckIn').AsInteger;
      vQryKardex.ParamByName('pObservacaoOrigem').Value :=
        'Recebimento Pedido: ' + EntradaId.ToString();
      vQryKardex.ParamByName('pEnderecoIdDestino').Value := 1;
      vQryKardex.ParamByName('pObservacaoDestino').Value :=
        'Stage - �rea de Armazenagem(Espera)';
      vQryKardex.ParamByName('pUsuarioId').Value :=
        vQryItens.FieldByName('UsuarioId').AsInteger;
      vQryKardex.ParamByName('pNomeEstacao').Value :=
        vQryItens.FieldByName('Terminal').AsString;
      vQryKardex.ParamByName('pEstoqueInicial').Value := vEstoqueInicial;
      If DebugHook <> 0 then
        vQryKardex.Sql.SaveToFile('AtKardex.Sql');
      vQryKardex.ExecSql;

      vQryItens.Next;
    End;
    // RegistrarDocumentoEtapa
    vQryFinalizar.Close;
    vQryFinalizar.Sql.Clear;
    vQryFinalizar.Sql.Add
      ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Pedido where PedidoId = '
      + EntradaId.ToString() + ')');
    vQryFinalizar.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    vQryFinalizar.ParamByName('pProcessoId').Value := 5;
    vQryFinalizar.ParamByName('pUsuarioId').Value :=
      pjsonEntrada.GetValue<Integer>('usuarioid');
    vQryFinalizar.ParamByName('pTerminal').Value :=
      pjsonEntrada.GetValue<String>('terminal', '');
    vQryFinalizar.Sql.Add('');
    vQryFinalizar.Sql.Add('Update Pedido Set Status = 2 where pedidoid = ' +
      EntradaId.ToString());
    vQryFinalizar.ExecSql;
    vQryFinalizar.connection.Commit;
    Result := True;
    vQryFinalizar.Close;
    vQryItens.Close;
    vQryKardex.Close;
  Except
    On E: Exception do
    Begin
      vQryItens.Close;
      vQryFinalizar.connection.Rollback;
      vQryFinalizar.Close;
      vQryKardex.Close;
      raise Exception.Create('Processo: FinalizarCheckInService - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetAcompanhamentoCheckIn(pPedidoId,
  pCodPessoaERP: Integer; pDataInicial, pDataFinal: TDateTime): tJsonArray;
begin
  Try

    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetAcompanhamentoCheckIn);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    if pDataInicial = 0 then
      FConexao.Query.ParamByName('pDataInicial').Value := 0
    Else
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicial);
    if pDataFinal = 0 then
      FConexao.Query.ParamByName('pDataFinal').Value := 0
    Else
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFinal);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaAcompanhamentoCheckIn.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.GetAgrupamentoFatorarLoteXML(pAgrupamentoId
  : Integer): tJsonArray;
Var
  JsonObjectFatorarLoteXML: TJsonObject;
begin
  Result := tJsonArray.Create;
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetAgrupamentoFatorarLoteXML);
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('AgrupamentoFatorarLoteXML.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: AgrupamentoPedidos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetAgrupamentoFatorarPedidoLotes
  (pAgrupamentoId: Integer): tJsonArray;
Var
  JsonObjectFatorarLoteXML: TJsonObject;
begin
  Result := tJsonArray.Create;
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.GetAgrupamentoFatorarPedidoLotes);
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('AgrupamentoFatorarPedidoLotes.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: AgrupamentoPedidos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetAgrupamentoLista(pAgrupamentoId,
  pCodPessoaERP: Integer): tJsonArray;
Var
  vQryAgrupamentoLista: TFdQuery;
  vQryAgrupamentoPedido: TFdQuery;
  JsonObjectAgrupamento: TJsonObject;
begin
  Result := tJsonArray.Create;
  Try
    vQryAgrupamentoLista := FConexao.GetQuery;
    vQryAgrupamentoPedido := FConexao.GetQuery;
    vQryAgrupamentoPedido.connection := vQryAgrupamentoLista.connection;
    vQryAgrupamentoLista.Sql.Add(TuEvolutConst.SqlGetAgrupamentoLista);
    vQryAgrupamentoLista.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    vQryAgrupamentoLista.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    if DebugHook <> 0 then
      vQryAgrupamentoLista.Sql.SaveToFile('AgrupamentoLista.Sql');
    vQryAgrupamentoLista.Open;
    if vQryAgrupamentoLista.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      while Not vQryAgrupamentoLista.Eof do
      Begin
        JsonObjectAgrupamento := TJsonObject.Create;
        JsonObjectAgrupamento.AddPair('agrupamentoid',
          TJsonNumber.Create(vQryAgrupamentoLista.FieldByName('Agrupamentoid')
          .AsInteger)).AddPair('codpessoaerp',
          TJsonNumber.Create(vQryAgrupamentoLista.FieldByName('CodPessoaErp')
          .AsInteger)).AddPair('fantasia',
          vQryAgrupamentoLista.FieldByName('fantasia').AsString)
          .AddPair('usuario', vQryAgrupamentoLista.FieldByName('usuario')
          .AsString).AddPair('data', vQryAgrupamentoLista.FieldByName('data')
          .AsString).AddPair('hora', vQryAgrupamentoLista.FieldByName('hora')
          .AsString).AddPair('terminal',
          vQryAgrupamentoLista.FieldByName('terminal').AsString);
        // Pegar o detalhe(Pedidos)
        vQryAgrupamentoPedido.Close;
        vQryAgrupamentoPedido.Sql.Clear;
        vQryAgrupamentoPedido.Sql.Add(TuEvolutConst.SqlGetAgrupamentoPedidos);
        vQryAgrupamentoPedido.ParamByName('pAgrupamentoId').Value :=
          vQryAgrupamentoLista.FieldByName('AgrupamentoId').AsInteger;
        vQryAgrupamentoPedido.ParamByName('pCodPessoaERP').Value := 0;
        if DebugHook <> 0 then
          vQryAgrupamentoPedido.Sql.SaveToFile('AgrupamentoPedidos.Sql');
        vQryAgrupamentoPedido.Open;
        if Not vQryAgrupamentoPedido.IsEmpty then
          JsonObjectAgrupamento.AddPair('pedidos',
            vQryAgrupamentoPedido.ToJSONArray)
        else
          JsonObjectAgrupamento.AddPair('pedidos', tJsonArray.Create);
        Result.AddElement(JsonObjectAgrupamento);
        vQryAgrupamentoLista.Next;
      End;
    //vQryAgrupamentoLista.Close;
    //vQryAgrupamentoLista.Free;
  Except
    On E: Exception do
    Begin
      vQryAgrupamentoLista.Close;
      raise Exception.Create('Processo: AgrupamentoPedidos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetAgrupamentoPedido(pAgrupamentoId,
  pPedidoId: Integer): tJsonArray;
Var
  JsonObjectAgrupamento: TJsonObject;
begin
  Result := tJsonArray.Create;
  Try

    FConexao.Query.Sql.Add('Declare @PedidoId      Integer = :pPedidoId');
    FConexao.Query.Sql.Add('Declare @AgrupamentoId Integer = :pAgrupamentoId');
    FConexao.Query.Sql.Add('Select * from PedidoAgrupamentoNotas');
    FConexao.Query.Sql.Add('Where (@PedidoId = 0 or pedidoid = @PedidoId) And');
    FConexao.Query.Sql.Add
      ('      (@AgrupamentoId = 0 or agrupamentoid = @AgrupamentoId)');
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('AgrupamentoPedido.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    Else
      Result := FConexao.Query.ToJSONArray();
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: AgrupamentoPedidos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetEntradaItens(pPedidoId, pAgrupamentoId: Integer)
  : tJsonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetPedidoItens);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaItens.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: GetEntradaItens - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId,
  pCodProduto: Integer): tJsonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaLoteCheckIn);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaLoteCheckIn.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      FConexao.DB.Connected := False;
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId,
  pCodProduto: Integer): tJsonArray;
begin
  Try

    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaLoteDevolucao);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaLoteDevolucao.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.GetEntradaLotes(pPedidoId, pAgrupamentoId,
  pCodProduto, pLoteId: Integer): tJsonArray;
begin
  Try
    if pAgrupamentoId = 0 then
      FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaLotes)
    else
      FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaLotesAgrupamento);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    FConexao.Query.ParamByName('pLoteId').Value := pLoteId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaLotes.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: GetEntradaLote - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetEntradaProdutoSemPicking(pDataInicial,
  pDataFinal: TDateTime; pPedidoId: Integer; pCodPessoaERP: Integer;
  pDocumentoNr: String): tJsonArray;
begin
  Try
    FConexao.Query.connection := FConexao.DB;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaProdutoSemPicking);
    if pDataInicial = 0 then
      FConexao.Query.ParamByName('pDataInicial').Value := 0
    Else
      FConexao.Query.ParamByName('pDataInicial').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicial);
    if pDataFinal = 0 then
      FConexao.Query.ParamByName('pDataFinal').Value := 0
    Else
      FConexao.Query.ParamByName('pDataFinal').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFinal);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('GetEntradaProdutoSemPicking.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados));
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: GetEntradaProdutoSemPicking - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetEntradaProduto(pPedidoId, pAgrupamentoId
  : Integer): tJsonArray;
begin
  Try
    if pAgrupamentoId > 0 then
      FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaProdutoAgrupamento)
      // SqlGetPedidoItensByProd );
    Else
      FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaProduto);
    // SqlGetPedidoItensByProd );
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaProdutos.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: GetEntradaProdutos - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.GetEtiquetaArmazenagem(pPedidoId: Integer;
  pDocumentoNr: String; pZonaId, pCodProduto, pSintetico: Integer;
  pDtInicio, pDtTermino: TDateTime): tJsonArray;
begin // Processo lento
  Try
    Result := tJsonArray.Create;

    if pSintetico = 0 then
      FConexao.Query.Sql.Add(TuEvolutConst.SqlRelEtiquetaArmazenagem)
    Else
      FConexao.Query.Sql.Add(TuEvolutConst.SqlRelEtqArmazenagemResumo);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if pDtInicio <> 0 then
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDateTime('YYYY-MM-DD', pDtInicio)
    Else
      FConexao.Query.ParamByName('pDtInicio').Value := 0;
    if pDtTermino <> 0 then
      FConexao.Query.ParamByName('pDtTermino').Value :=
        FormatDateTime('YYYY-MM-DD', pDtTermino)
    Else
      FConexao.Query.ParamByName('pDtTermino').Value := 0;
    FConexao.Query.Open();
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EtqArmazenagem.Sql');
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
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

function TServiceRecebimento.GetOcorrencias(pPedidoId: Integer;
  pDocumentoNr, pRegistroERP: String; pCodProduto: Integer;
  pDataInicial, pDataFinal, pDataCheckInInicial, pDataCheckInFinal: TDateTime)
  : tJsonArray;
begin
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetEntradaOcorrencia);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if pDataInicial = 0 then
      FConexao.Query.ParamByName('pDoctoDataIni').Value := 0
    Else
      FConexao.Query.ParamByName('pDoctoDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataInicial);
    if pDataFinal = 0 then
      FConexao.Query.ParamByName('pDoctoDataFin').Value := 0
    Else
      FConexao.Query.ParamByName('pDoctoDataFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataFinal);
    if pDataCheckInInicial = 0 then
      FConexao.Query.ParamByName('pCheckInDtIni').Value := 0
    Else
      FConexao.Query.ParamByName('pDoctoDataIni').Value :=
        FormatDateTime('YYYY-MM-DD', pDataCheckInInicial);
    if pDataCheckInFinal = 0 then
      FConexao.Query.ParamByName('pCheckInDtFin').Value := 0
    Else
      FConexao.Query.ParamByName('pCheckInDtFin').Value :=
        FormatDateTime('YYYY-MM-DD', pDataCheckInFinal);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaOcorrencias.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.GetProdutoTagByProduto
  (aQuery: TDictionary<String, String>): tJsonArray;
var
  vParamsOk, pPedidoId, pCodigoERP: Integer;
  pDocumentoNr, pRegistroERP: String;
  pDtDocumentoData, pDtCheckInFinalizacao: TDateTime;
begin
  pPedidoId := 0;
  pCodigoERP := 0;
  pDocumentoNr := '';
  pRegistroERP := '';
  pDtDocumentoData := 0;
  pDtCheckInFinalizacao := 0;
  vParamsOk := 0;
  if aQuery.ContainsKey('pedidoid') then
  Begin
    pPedidoId := StrToIntDef(aQuery.Items['pedidoid'], 0);
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('codigoerp') then
  Begin
    pCodigoERP := StrToIntDef(aQuery.Items['codigoerp'], 0);
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('documentonr') then
  Begin
    pDocumentoNr := aQuery.Items['documentonr'];
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('registroerp') then
  Begin
    pRegistroERP := aQuery.Items['registroerp'];
    vParamsOk := vParamsOk + 1;
  End;
  if aQuery.ContainsKey('documentodata') then
  Begin
    Try
      pDtDocumentoData := StrToDate(aQuery.Items['documentodata']);
      vParamsOk := vParamsOk + 1;
    Except
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Data dos Pedidos � inv�lida!')));
      Exit;
    End;
  End;
  if aQuery.ContainsKey('dtcheckinfinalizacao') then
  Begin
    Try
      pDtCheckInFinalizacao := StrToDate(aQuery.Items['dtcheckinfinalizacao']);
      vParamsOk := vParamsOk + 1;
    Except
      Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
        'Data de finaliza��o do CheckIn � inv�lida!')));
      Exit;
    End;
  End;
  if vParamsOk <> aQuery.Count then
  Begin
    Result := tJsonArray.Create;
    Result.AddElement(TJsonObject.Create(TJSONPair.Create('Erro',
      'Par�metros da consulta definidos incorretamente!')));
    Exit;
  End;
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetProdutoTagByProduto);
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodigoERP').Value := pCodigoERP;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    FConexao.Query.ParamByName('pRegistroERP').Value := pRegistroERP;
    if pDtDocumentoData = 0 then
      FConexao.Query.ParamByName('pDtDocumentoData').Value := 0
      // pDtDocumentoData
    Else
      FConexao.Query.ParamByName('pDtDocumentoData').Value :=
        FormatDateTime('YYYY-MM-DD', pDtDocumentoData);
    if pDtCheckInFinalizacao = 0 then
      FConexao.Query.ParamByName('pDtCheckInFinalizacao').Value := 0
      // pDtCheckInFinalizacao
    Else
      FConexao.Query.ParamByName('pDtCheckInFinalizacao').Value :=
        FormatDateTime('YYYY-MM-DD', pDtCheckInFinalizacao);
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ProdutoTagByProduto');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.GetResumoCheckIn(pEntradaId: Integer): tJsonArray;
begin
  if pEntradaId <= 0 then
  Begin
    Result.AddElement(TJsonObject.Create.AddPair('Erro',
      'Informe o Id da Entrada.'));
    Exit;
  End;
  Try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetResumoCheckIn);
    FConexao.Query.ParamByName('pPedidoid').Value := pEntradaId;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('ResumoCheckIn.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
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

function TServiceRecebimento.Header(pEntradaId, pAgrupamentoId: Integer)
  : tJsonArray;
begin
  Try

    FConexao.Query.Sql.Add(TuEvolutConst.SqlEntradaHeader);
    FConexao.Query.ParamByName('pPedidoId').Value := pEntradaId;
    FConexao.Query.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('EntradaHeader.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.Pesquisar(pPedidoId, pCodPessoaERP: Integer;
  pDocumento, pRazao, pRegistroERP: String; pDtNotaFiscal: TDateTime;
  pPendente: Integer; pAgrupamentoId: Integer; pBasico: Boolean;
  pShowErro: Integer): tJsonArray;
var // VQry,
  vQryRecebimentos: TFdQuery;
  vQryItens: TFdQuery;
  vSql, vSqlItens: String;
  ObjJson: TJsonObject;
  vItens, vProdutoId: Integer;

  JsonRecebimento: TJsonObject;
  ObjEntrada: TEntrada;
  ObjEntradaItens: TEntradaItens;
  JsonArrayitens: tJsonArray;
  JsonArrayProduto: tJsonArray;
  LServiceProduto: TServiceProduto;
  aQueryParamProduto: TDictionary<String, String>;
begin // Processo lento
  Try
    vQryRecebimentos := FConexao.GetQuery;
    vQryItens := FConexao.GetQuery;
    vQryRecebimentos.Sql.Add(SqlEntrada);
    vQryRecebimentos.ParamByName('pPedidoId').Value := pPedidoId;
    vQryRecebimentos.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    vQryRecebimentos.ParamByName('pDocumentoNr').Value := pDocumento;
    vQryRecebimentos.ParamByName('pRazao').Value := '%' + pRazao + '%';
    vQryRecebimentos.ParamByName('pRegistroERP').Value := pRegistroERP;
    vQryRecebimentos.ParamByName('pPendente').Value := pPendente;
    vQryRecebimentos.ParamByName('pAgrupamentoId').Value := pAgrupamentoId;
    vQryRecebimentos.Sql.Add('--pAgrupamentoId = ' + pAgrupamentoId.ToString());
    if pDtNotaFiscal = 0 then
      vQryRecebimentos.ParamByName('pDtNotaFiscal').Value := 0
    Else
      vQryRecebimentos.ParamByName('pDtNotaFiscal').Value :=
        FormatDateTime('YYYY-MM-DD', pDtNotaFiscal);
    if DebugHook <> 0 then
      vQryRecebimentos.Sql.SaveToFile('EntradaPesquisar.Sql');
    vQryRecebimentos.Open;
    if vQryRecebimentos.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else if pBasico then
      Result := vQryRecebimentos.ToJSONArray
    Else
    Begin
      Result := tJsonArray.Create;
      while Not vQryRecebimentos.Eof do
      Begin
        ObjEntrada := TEntrada.Create;
        ObjEntrada.EntradaId := vQryRecebimentos.FieldByName('PedidoId')
          .AsInteger;
        ObjEntrada.OperacaoTipo.OperacaoTipoId :=
          vQryRecebimentos.FieldByName('OperacaoTipoId').AsInteger;
        ObjEntrada.OperacaoTipo.Descricao := vQryRecebimentos.FieldByName
          ('OperacaoTipo').AsString;
        ObjEntrada.Pessoa.PessoaId := vQryRecebimentos.FieldByName('PessoaId')
          .AsInteger;
        ObjEntrada.Pessoa.CodPessoa := vQryRecebimentos.FieldByName
          ('CodPessoaERP').AsInteger;
        ObjEntrada.Pessoa.Razao := vQryRecebimentos.FieldByName
          ('Razao').AsString;
        ObjEntrada.DocumentoNr := vQryRecebimentos.FieldByName
          ('DocumentoNr').AsString;
        ObjEntrada.DocumentoData := vQryRecebimentos.FieldByName
          ('DocumentoData').AsDateTime;
        ObjEntrada.RegistroERP := vQryRecebimentos.FieldByName
          ('RegistroERP').AsString;
        ObjEntrada.DtInclusao := vQryRecebimentos.FieldByName('DtInclusao')
          .AsDateTime;
        ObjEntrada.HrInclusao :=
          StrToTime(Copy(vQryRecebimentos.FieldByName('HrInclusao')
          .AsString, 1, 8));
        ObjEntrada.ArmazemId := vQryRecebimentos.FieldByName('ArmazemId')
          .AsInteger;
        ObjEntrada.Status := vQryRecebimentos.FieldByName('Status').AsInteger;
        ObjEntrada.ProcessoId := vQryRecebimentos.FieldByName('ProcessoId')
          .AsInteger;
        ObjEntrada.Processo := vQryRecebimentos.FieldByName('Processo')
          .AsString;
        vQryItens.Close;
        vQryItens.Sql.Clear;
        vQryItens.Sql.Add('Declare @pPedido  Integer = ' +
          ObjEntrada.EntradaId.ToString());
        vQryItens.Sql.Add('Declare @ProdutoId Integer = 0');
        vQryItens.Sql.Add('Declare @LoteId Integer    = 0');
        vQryItens.Sql.Add(SqlEntradaItens);
        vQryItens.Sql.Add
          ('   and (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId)');
        vQryItens.Sql.Add
          ('   and (@LoteId    = 0 or Pl.LoteId     = @LoteId) ');
        vQryItens.Sql.Add('Order by PIt.PedidoId, PIt.PedidoItemId');
        if DebugHook <> 0 then
          vQryItens.Sql.SaveToFile('PedidoItens.Sql');
        vQryItens.Open;
        vQryItens.First;
        vProdutoId := 0;
        if Not vQryItens.IsEmpty then
          While Not vQryItens.Eof do
          Begin
            ObjEntradaItens := TEntradaItens.Create;
            ObjEntradaItens.EntradaId := vQryItens.FieldByName('PedidoId')
              .AsInteger;
            ObjEntradaItens.EntradaItemId :=
              vQryItens.FieldByName('PedidoItemId').AsInteger;
            // ObjEntradaItens := TEntradaItens.Create;
            // if vProdutoId <> vQryItens.FieldByName('ProdutoId').AsInteger then Begin
            // ObjEntradaItens.ProdutoLotes.Produto.IdProduto := vQryItens.FieldByName('ProdutoId').AsInteger;
            // vProdutoId := vQryItens.FieldByName('ProdutoId').AsInteger;
            // End;
            LServiceProduto := TServiceProduto.Create;
            aQueryParamProduto := TDictionary<String, String>.Create;
            aQueryParamProduto.Add('codigoerp',
              vQryItens.FieldByName('CodigoERP').AsString);
            JsonArrayProduto := LServiceProduto.GetProduto(aQueryParamProduto);
            ObjEntradaItens := TEntradaItens.Create;
            ObjEntradaItens.EntradaId := vQryItens.FieldByName('PedidoId')
              .AsInteger;
            ObjEntradaItens.EntradaItemId :=
              vQryItens.FieldByName('PedidoItemId').AsInteger;
            ObjEntradaItens.ProdutoLotes.Produto :=
              tJson.JsonToObject<TProduto>
              (JsonArrayProduto.Items[0] as TJsonObject);
            ObjEntradaItens.ProdutoLotes.Lotes.LoteId :=
              vQryItens.FieldByName('LoteId').AsInteger;
            ObjEntradaItens.ProdutoLotes.Lotes.ProdutoId :=
              vQryItens.FieldByName('ProdutoId').AsInteger;
            ObjEntradaItens.ProdutoLotes.Lotes.CodigoERP :=
              vQryItens.FieldByName('CodigoERP').AsInteger;
            ObjEntradaItens.ProdutoLotes.Lotes.DescrLote :=
              vQryItens.FieldByName('descrLote').AsString;
            ObjEntradaItens.ProdutoLotes.Lotes.Fabricacao :=
              vQryItens.FieldByName('Fabricacao').AsDateTime;
            ObjEntradaItens.ProdutoLotes.Lotes.Vencimento :=
              vQryItens.FieldByName('Vencimento').AsDateTime;
            ObjEntradaItens.ProdutoLotes.Lotes.DtEntrada :=
              vQryItens.FieldByName('DtEntrada').AsDateTime;
            ObjEntradaItens.ProdutoLotes.Lotes.HrEntrada :=
              StrToTime(Copy(vQryItens.FieldByName('HrEntrada')
              .AsString, 1, 8));
            ObjEntradaItens.ProdutoLotes.Lotes.QtdeDisponivel := 0;
            // vQry.FieldByName('QtdeDisponivel').AsInteger;
            ObjEntradaItens.QtdXml := vQryItens.FieldByName('QtdXml').AsInteger;
            ObjEntradaItens.QtdCheckIn := vQryItens.FieldByName('QtdCheckIn')
              .AsInteger;
            ObjEntradaItens.QtdDevolvida :=
              vQryItens.FieldByName('QtdDevolvida').AsInteger;
            ObjEntradaItens.QtdSegregada :=
              vQryItens.FieldByName('QtdSegregada').AsInteger;
            ObjEntradaItens.PrintEtqControlado :=
              vQryItens.FieldByName('PrintEtqControlado').AsInteger;
            ObjEntrada.Itens.Add(ObjEntradaItens);
            vQryItens.Next;
          End;
        Result.AddElement(tJson.ObjectToJsonObject(ObjEntrada,
          [joDateFormatISO8601]));
        vQryRecebimentos.Next;
      End;
    End;
    vQryRecebimentos.Close;
    vQryItens.Close;

  Except
    On E: Exception do
    Begin
      vQryRecebimentos.Close;

      raise Exception.Create(E.Message);
    End;
  End;
end;

function TServiceRecebimento.RegPrintEtqProduto(pPedidoId, pLoteId: Integer)
  : tJsonArray;
begin
  Try
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Update PedidoItens');
    FConexao.Query.Sql.Add('  Set PrintEtqControlado = 1');
    FConexao.Query.Sql.Add('Where PedidoId = ' + pPedidoId.ToString() +
      ' and LoteId = ' + pLoteId.ToString());
    FConexao.Query.ExecSql;
    Result := tJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create
        ('Processo: Registrar impress�o Etiquetas Controlado - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.SalvarAgrupamento(pNotaAgrupamentoJsonArray
  : tJsonArray): tJsonArray;
Var
  xNotas: Integer;
  vAgrupamentoId: Integer;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add('Declare @AgrupamentoId Integer = 0');
    FConexao.Query.Sql.Add('Insert into PedidoAgrupamento Values (');
    FConexao.Query.Sql.Add(pNotaAgrupamentoJsonArray.Items[xNotas]
      .GetValue<Integer>('usuarioid').ToString() + ', ' + #39 +
      pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<String>('terminal') + #39
      + ', ' + #39 + FormatDateTime('YYYY-MM-DD',
      StrToDate(pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<String>('data')
      )) + #39 + ', ' + #39 + FormatDateTime('hh:mm:ss',
      StrToTime(pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<String>('hora')
      )) + #39 + ', 1 ');
    FConexao.Query.Sql.Add(')');
    FConexao.Query.Sql.Add('Set @AgrupamentoId = SCOPE_IDENTITY()');
    FConexao.Query.Sql.Add('Select @AgrupamentoId As ItemId');
    FConexao.Query.Open;
    vAgrupamentoId := FConexao.Query.FieldByName('ItemId').AsInteger;
    for xNotas := 0 to Pred(pNotaAgrupamentoJsonArray.Count) do
    Begin
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add('Insert into PedidoAgrupamentoNotas Values (');
      FConexao.Query.Sql.Add(vAgrupamentoId.ToString + ',' +
        pNotaAgrupamentoJsonArray.Items[xNotas].GetValue<Integer>('pedidoid')
        .ToString());
      FConexao.Query.Sql.Add(')');
      FConexao.Query.ExecSql;
    End;
    Result := tJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('status', '200'));
    FConexao.Query.connection.Commit;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Processo: Salvar Agrupamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.SalvarCheckInItem(pjsonEntrada: TJsonObject)
  : TJsonObject;
Var
  jsonEntradaItem: TJsonObject;
  JsonArrayitens: tJsonArray;
  xItens: Integer;
  vSql: String;
  EntradaId, EntradaItemId, ProdutoId, LoteId: Integer;
  DescrLote, Fabricacao, Vencimento, DtEntrada, HrEntrada: String;
  QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada, CausaId, UsuarioId,
    RespAltLoteId: Integer;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    EntradaId := pjsonEntrada.GetValue<Integer>('pedido');
    // jsonArrayItens := tjsonArray.Create;
    JsonArrayitens := pjsonEntrada.Get('itens').JsonValue as tJsonArray;
    For xItens := 0 to JsonArrayitens.Count - 1 do
    Begin
      jsonEntradaItem := JsonArrayitens.Items[xItens] as TJsonObject;
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      FConexao.Query.Sql.Add
        ('Select Pl.ProdutoId, Sum(QtdXML) QtdXML, Sum(PI.qtdcheckin+PI.qtddevolvida+PI.qtdsegregada) TotalCheckIn');
      FConexao.Query.Sql.Add('From PedidoItens PI');
      FConexao.Query.Sql.Add
        ('Inner Join ProdutoLotes PL ON Pl.LoteId = Pi.LoteId');
      FConexao.Query.Sql.Add('Where Pi.pedidoid = ' + EntradaId.ToString() +
        ' and Pl.ProdutoId = ' + jsonEntradaItem.GetValue<String>('produtoid'));
      FConexao.Query.Sql.Add('Group By Pl.ProdutoId');
      If DebugHook <> 0 then
        FConexao.Query.Sql.SaveToFile('ValidarCheckIn.Sql');
      FConexao.Query.Open();
      if FConexao.Query.FieldByName('QtdXml').AsInteger <
        (FConexao.Query.FieldByName('TotalCheckIn').AsInteger +
        jsonEntradaItem.GetValue<Integer>('qtdcheckin') +
        jsonEntradaItem.GetValue<Integer>('qtddevolvida') +
        jsonEntradaItem.GetValue<Integer>('qtdsegregada')) then
        raise Exception.Create('Quantidade CheckIn(' +
          FConexao.Query.FieldByName('TotalCheckIn').AsString +
          ') maior que no XML!');
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      EntradaItemId := 0; // jsonEntradaItem.GetValue<integer>('entradaitemid');
      ProdutoId := jsonEntradaItem.GetValue<Integer>('produtoid');
      LoteId := 0; // jsonEntradaItem.GetValue<Integer>('loteid');
      DescrLote := jsonEntradaItem.GetValue<String>('descrlote');
      Fabricacao := jsonEntradaItem.GetValue<string>('fabricacao');
      Vencimento := jsonEntradaItem.GetValue<string>('vencimento');
      DtEntrada := jsonEntradaItem.GetValue<string>('dtentrada');
      HrEntrada := jsonEntradaItem.GetValue<string>('hrentrada');
      QtdXml := jsonEntradaItem.GetValue<Integer>('qtdxml');
      QtdCheckIn := jsonEntradaItem.GetValue<Integer>('qtdcheckin');
      QtdDevolvida := jsonEntradaItem.GetValue<Integer>('qtddevolvida');
      CausaId := jsonEntradaItem.GetValue<Integer>('causaid');
      QtdSegregada := jsonEntradaItem.GetValue<Integer>('qtdsegregada');
      UsuarioId := jsonEntradaItem.GetValue<Integer>('usuarioid');
      RespAltLoteId := jsonEntradaItem.GetValue<Integer>('respaltloteid');
      // Salvar no banco
      vSql := 'Declare @EntradaId Integer     = ' + EntradaId.ToString() +
        sLineBreak + 'Declare @EntradaItemId Integer = ' +
        EntradaItemId.ToString() + sLineBreak +
        'Declare @ProdutoId Integer     = ' + ProdutoId.ToString() + sLineBreak
        + 'Declare @LoteId Integer        = ' + LoteId.ToString + sLineBreak +
        'Declare @DescrLote VarChar(30) = ' + #39 + DescrLote + #39 + sLineBreak
        + 'Declare @Fabricacao Date = ' + #39 + FormatDateTime('YYYY-MM-DD',
        StrToDate(Fabricacao)) + #39 + sLineBreak +
        'Declare @Vencimento Date = ' + #39 + FormatDateTime('YYYY-MM-DD',
        StrToDate(Vencimento)) + #39 + sLineBreak +
        'Declare @DtEntrada  Date = ' + #39 + FormatDateTime('YYYY-MM-DD',
        StrToDate(DtEntrada)) + #39 + sLineBreak + 'Declare @HrEntrada  Time = '
        + #39 + HrEntrada + #39 + sLineBreak + 'Declare @QtdXml     Integer = '
        + QtdXml.ToString() + sLineBreak + 'Declare @QtdCheckIn Integer = ' +
        QtdCheckIn.ToString() + sLineBreak + 'Declare @QtdDevolvida Integer = '
        + QtdDevolvida.ToString() + sLineBreak +
        'Declare @QtdSegregada Integer = ' + QtdSegregada.ToString() +
        sLineBreak + 'Declare @CausaId Integer = ' + CausaId.ToString() +
        sLineBreak + 'Declare @Usuarioid Integer    = ' + UsuarioId.ToString() +
        sLineBreak + 'Declare @RespAltLoteId Integer = ' +
        RespAltLoteId.ToString() + sLineBreak +
        'Declare @Terminal Varchar(50) = ' + #39 +
        jsonEntradaItem.GetValue<String>('terminal') + #39 + sLineBreak;
      // Cadastrar Lote Novo
      vSql := vSql + 'If @LoteId = 0' + sLineBreak +
        '   Set @LoteId = Coalesce((Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote), 0)'
        + #13 + #10;
      vSql := vSql + 'If @LoteId = 0 Begin' + sLineBreak +
        '   Insert Into ProdutoLotes Values (@ProdutoId, @DescrLote, ' +
        '      (Select IdData From Rhema_Data Where Data = @Fabricacao), ' +
        '      (Select IdData From Rhema_Data Where Data = @Vencimento), ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual +
        ', NewId())' + sLineBreak +
        '   Set @LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)'
        + sLineBreak + 'End' + #13 + #10;
      vSql := vSql + 'Else Begin' + sLineBreak + '   Update ProdutoLotes Set' +
        sLineBreak +
        '      Fabricacao = (Select IdData from Rhema_data Where Data = @Fabricacao), '
        + sLineBreak +
        '      Vencimento = (Select IdData from Rhema_data Where Data = @Vencimento)  '
        + sLineBreak + '   Where LoteId = @LoteId' + sLineBreak + 'End;';
      // Novo Lote n�o pertencente ao XML origiginal
      vSql := vSql +
        'Set @EntradaItemId = Coalesce((Select Pi.PedidoItemId From PedidoItens Pi'
        + sLineBreak +
        '                               Inner join ProdutoLotes Pl On Pl.LoteId = Pi.LoteId'
        + sLineBreak +
        '                               Where PedidoId = @EntradaId and Pl.ProdutoId = @ProdutoId and Pl.DescrLote = @DescrLote), 0)'
        + sLineBreak;
      vSql := vSql + 'If @EntradaItemId = 0 Begin' + sLineBreak +
        '   Insert Into PedidoItens Values (@EntradaId, @LoteId, 0, @QtdCheckIn, @QtdDevolvida, @QtdSegregada, 0, newid())'
        + sLineBreak + '   Set @QtdXML = 0' + sLineBreak + 'End' + sLineBreak +
        'Else Begin' + sLineBreak +
        '   Update PedidoItens Set QtdCheckIn = QtdCheckIn+@QtdCheckIn, ' +
        sLineBreak +
        '                          QtdDevolvida = QtdDevolvida+@QtdDevolvida, '
        + sLineBreak +
        '                          QtdSegregada = QtdSegregada+@QtdSegregada ' +
        sLineBreak + '   Where PedidoItemId = @EntradaItemId' + sLineBreak +
        'End;' + sLineBreak + sLineBreak;
      vSql := vSql +
        'Insert Into PedidoItensCheckIn Values (@EntradaId, @LoteId, @UsuarioId, 0, @QtdCheckIn, '
        + sLineBreak +
        '   @QtdDevolvida, @QtdSegregada, @Causaid, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'
        + sLineBreak +
        '   (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), '
        + sLineBreak +
        '   (Case When @RespAltLoteId = 0 then Null Else @RespAltLoteId End), NewId(), @Terminal)'
        + sLineBreak;
      vSql := vSql +
        'If Not Exists (select DocumentoEtapaId From DocumentoEtapas where Documento = '
        + sLineBreak +
        '   (Select UUid From Pedido Where PedidoId = @EntradaId) and ProcessoId = 4 and Status = 1) Begin'
        + sLineBreak;
      vSql := vSql + '   Insert Into DocumentoEtapas Values (' + sLineBreak +
        '          Cast((Select Uuid from Pedido Where ((Cast(PedidoId as VarChar(36)) = @EntradaId))) as UNIQUEIDENTIFIER), '
        + sLineBreak + '          4, @UsuarioId, ' + TuEvolutConst.SqlDataAtual
        + ', ' + TuEvolutConst.SqlHoraAtual + ', GetDate(), @Terminal, 1)' +
        sLineBreak;
      vSql := vSql + 'End;';
      // Clipboard.Clear;
      // try Clipboard.AsText := vSql; Except End;
      FConexao.Query.Sql.Add(vSql);
      if DebugHook <> 0 then
        FConexao.Query.Sql.SaveToFile('SalvarCheckin.Sql');
      FConexao.Query.ExecSql;
    End;
    FConexao.Query.connection.Commit;

    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add
      ('Select PI.Pedidoitemid, PI.loteid, PI.qtdcheckin, PI.qtddevolvida, PI.qtdsegregada ');
    FConexao.Query.Sql.Add('From PedidoItens PI');
    FConexao.Query.Sql.Add
      ('Inner Join ProdutoLotes PL ON Pl.LoteId = Pi.LoteId and Pl.ProdutoId = '
      + ProdutoId.ToString() + ' and Pl.DescrLote = ' + QuotedStr(DescrLote));
    FConexao.Query.Sql.Add('Where Pi.pedidoid = ' + EntradaId.ToString());
    FConexao.Query.Open();
    Result := TJsonObject.Create;
    With Result do
    Begin
      AddPair('pedidoitemid', TJsonNumber.Create(FConexao.Query.FieldByName('PedidoItemId').AsInteger));
      AddPair('loteid', TJsonNumber.Create(FConexao.Query.FieldByName('LoteId').AsInteger));
      AddPair('qtdcheckin', TJsonNumber.Create(FConexao.Query.FieldByName('QtdCheckIn').AsInteger));
      AddPair('qtddevolvida', TJsonNumber.Create(FConexao.Query.FieldByName('QtdDevolvida').AsInteger));
      AddPair('qtdsegregada', TJsonNumber.Create(FConexao.Query.FieldByName('QtdSegregada').AsInteger));
    End;
    // jsonEntradaItem.Free;
    // jsonArrayItens.Free;
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Processo: SalvarCheckInItem - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.SalvarCheckInItemAgrupamento(pJsonItemCheckIn
  : TJsonObject): TJsonObject;
Var
  vSql: String;
  vAgrupamentoId: Integer;
  xItens: Integer;
  JsonArrayitens: tJsonArray;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    vAgrupamentoId := pJsonItemCheckIn.GetValue<Integer>('agrupamentoid');
    JsonArrayitens := pJsonItemCheckIn.GetValue<tJsonArray>('itens');
    for xItens := 0 to Pred(JsonArrayitens.Count) do
    Begin
      FConexao.Query.Close;
      FConexao.Query.Sql.Clear;
      // Salvar no banco
      vSql := 'Declare @AgrupamentoId Integer = ' + vAgrupamentoId.ToString() +
        sLineBreak + 'Declare @ProdutoId Integer     = ' + JsonArrayitens.Items
        [xItens].GetValue<string>('produtoid') + sLineBreak +
        'Declare @LoteId Integer = ' + JsonArrayitens.Items[xItens]
        .GetValue<string>('loteid') + sLineBreak +
        'Declare @DescrLote VarChar(30) = ' + #39 + JsonArrayitens.Items[xItens]
        .GetValue<string>('descrlote') + #39 + sLineBreak +
        'Declare @Fabricacao Date = ' + #39 + FormatDateTime('YYYY-MM-DD',
        StrToDate(JsonArrayitens.Items[xItens].GetValue<string>('fabricacao')))
        + #39 + sLineBreak + 'Declare @Vencimento Date = ' + #39 +
        FormatDateTime('YYYY-MM-DD',
        StrToDate(JsonArrayitens.Items[xItens].GetValue<string>('vencimento')))
        + #39 + sLineBreak + 'Declare @QtdCheckIn Integer = ' +
        JsonArrayitens.Items[xItens].GetValue<Integer>('qtdcheckin').ToString()
        + sLineBreak + 'Declare @QtdDevolvida Integer = ' + JsonArrayitens.Items
        [xItens].GetValue<Integer>('qtddevolvida').ToString() + sLineBreak +
        'Declare @QtdSegregada Integer = ' + JsonArrayitens.Items[xItens]
        .GetValue<Integer>('qtdsegregada').ToString() + sLineBreak +
        'Declare @CausaId      Integer = ' + JsonArrayitens.Items[xItens]
        .GetValue<Integer>('causaid').ToString() + sLineBreak +
        'Declare @Usuarioid Integer    = ' + JsonArrayitens.Items[xItens]
        .GetValue<Integer>('usuarioid').ToString() + sLineBreak +
        'Declare @RespAltLoteId Integer = ' + JsonArrayitens.Items[xItens]
        .GetValue<Integer>('respaltloteid').ToString() + sLineBreak +
        'Declare @Terminal Varchar(50) = ' +
        QuotedStr(JsonArrayitens.Items[xItens].GetValue<string>('terminal')) +
        #13 + #10;
      // Cadastrar Lote Novo
      vSql := vSql + 'If @LoteId = 0' + sLineBreak +
        '   Set @LoteId = Coalesce((Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote), 0)'
        + #13 + #10;
      vSql := vSql + 'If @LoteId = 0 Begin' + sLineBreak +
        '   Insert Into ProdutoLotes Values (@ProdutoId, @DescrLote, ' +
        '(Select IdData From Rhema_Data Where Data = @Fabricacao), ' +
        '(Select IdData From Rhema_Data Where Data = @Vencimento), ' +
        TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual +
        ', NewId())' + sLineBreak +
        '  Set @LoteId = (Select LoteId From ProdutoLotes Where ProdutoId = @ProdutoId and DescrLote = @DescrLote)'
        + sLineBreak + 'End;' + #13 + #10;
      // Novo Lote n�o pertencente ao XML origiginal

      // vSql := vSql + 'If @EntradaItemId = 0 Begin'+sLineBreak+
      // '   Insert Into PedidoItens Values (@EntradaId, @LoteId, @QtdXml, @QtdCheckIn, @QtdDevolvida, @QtdSegregada, 0 newid())'+sLineBreak+
      // 'End'+sLineBreak+
      // 'Else Begin'+sLineBreak+
      // '   Update PedidoItens Set QtdCheckIn = QtdCheckIn+@QtdCheckIn, QtdDevolvida = QtdDevolvida+@QtdDevolvida, QtdSegregada = QtdSegregada+@QtdSegregada Where PedidoItemId = @EntradaItemId'+sLineBreak+
      // 'End;'+sLineBreak+sLineBreak;
      vSql := vSql +
        'Insert Into PedidoItensCheckInAgrupamento Values (@AgrupamentoId, @LoteId, @UsuarioId, @QtdCheckIn, '
        + sLineBreak + '   @QtdDevolvida, @QtdSegregada, @CausaId, ' +
        TuEvolutConst.SqlDataAtual + ',' + sLineBreak + '   ' +
        TuEvolutConst.SqlHoraAtual +
        ', (Case When @RespAltLoteId = 0 then Null Else ' +
        '   @RespAltLoteId End), NewId(), @Terminal)';

      // Clipboard.Clear;
      // try Clipboard.AsText := vSql; Except End;
      FConexao.Query.Sql.Add(vSql);
      if DebugHook <> 0 then
        FConexao.Query.Sql.SaveToFile('SalvarCheckinAgrupamento.Sql');
      FConexao.Query.ExecSql;
    End;
    FConexao.Query.connection.Commit;
    Result := TJsonObject.Create;
    Result.AddPair('status', TJsonNumber.Create(200));
  Except
    On E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Processo: SalvarCheckInItemAgrupamento - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceRecebimento.ValidarQtdCheckIn(pPedidoId, pCodProduto: Int64)
  : tJsonArray;
begin
  Try
    FConexao.Query.Sql.Add
      ('select Pl.CodProduto, Sum(QtdCheckIn+QtdDevolvida+QtdSegregada) QtdCheckIn');
    FConexao.Query.Sql.Add('From PedidoItensCheckIn PI');
    FConexao.Query.Sql.Add
      ('Inner Join vProdutoLotes Pl On Pl.LoteId = PI.Loteid');
    FConexao.Query.Sql.Add
      ('Inner Join Rhema_Data Rd On Rd.IdData = PI.CheckInDtInicio');
    FConexao.Query.Sql.Add
      ('Inner join Rhema_Hora Rh ON Rh.IdHora = Pi.CheckInHrInicio');
    FConexao.Query.Sql.Add
      ('where PedidoId = :pPedidoId and Pl.CodProduto = :pCodProduto');
    FConexao.Query.Sql.Add('Group by CodProduto');
    FConexao.Query.ParamByName('pPedidoId').Value := pPedidoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('ValidarQtdCheckIn.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := tJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: ValidarQtdCheckIn - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

end.
