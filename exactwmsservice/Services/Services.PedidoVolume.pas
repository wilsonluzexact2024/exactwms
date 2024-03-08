unit Services.PedidoVolume;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TServicePedidoVolume = class(TBasicDao)
  private

    function IfThen(AValue: Boolean; const ATrue, AFalse: String): String;

    { Private declarations }
  public
    { Public declarations }
    function AtualizarKardex(pQuery: TFdQuery;
      pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId,
      pEstoqueTipoIdDestino, pQuantidade, pEnderecoIdDestino,
      pUsuarioId: Integer; pObservacaoOrigem, pObservacaoDestino,
      pNomeEstacao: String; pEstoqueInicial: Integer): Boolean;
    Function Cancelar(pConexao: TFdConnection; pJsonObject: TJsonObject)
      : TJsonArray;
    Function EtiquetaVolumePorRua(pJsonObject: TJsonObject): TJsonArray;
    Function RegistrarDocumentoEtapa(pJsonDocumentoEtapa: TJsonObject)
      : TJsonArray;
    Function RegistrarDocumentoEtapaComBaixaEstoque(pJsonDocumentoEtapa
      : TJsonObject): TJsonArray;
    Function RegistrarDocumentoEtapaSemBaixaEstoque(pJsonDocumentoEtapa
      : TJsonObject): TJsonArray;
    Function VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId, pZonaId, pPrintTag,
      pEmbalagem: Integer): TJsonArray;
    Function VolumeExpedicao: TJsonArray;
    Function VolumeExpedido: TJsonArray;
    Function GetVolume(pPedidoId, pPedidoVolumeId, pSequencia, pOrdem: Integer;
      pEmbalagem: String; pZonaId: Integer): TJsonArray;
    Function GetOpenVolumeParaSeparacao(pCaixaId, pPedidoVolumeId,
      pUsuarioId: Integer; pTerminal: String): TJsonArray;
    Function GetVolumeRegistrarExpedicao(pPedidoVolumeId: Integer): TJsonArray;
    Function GetVolumePrintTag(pPedidoId, pPedidoVolumeId, pSequencia,
      pOrdem: Integer; pZonaId: Integer; pPrintTag: Integer;
      pEmbalagem: Integer): TJsonArray;
    Function GerarVolumeExtra(pPedidoVolumeId, pUsuarioId: Integer;
      pJsonArrayProdutoCortes: TJsonArray): TJsonArray;
    Function GetAuditoriaVolumes(const AParams: TDictionary<string, string>)
      : TJsonArray;
    Function GetAuditoriaCorteAnalitico(const AParams
      : TDictionary<string, string>): TJsonArray;
    Function VolumeLoteSubstituicao(pJsonObjectLotes: TJsonObject): TJsonArray;
    Function CaixaSeparacao(pPedidoVolumeId, pCaixaEmbalagemId: Integer)
      : TJsonArray;
    Function Getdshvolumeevolucao_quantidade(pDataIni: TDateTime;
      pRotaId, pZonaId, pCodPessoaERP: Integer): TJsonArray;
    Function Getdshvolumeevolucao_Unidades(pDataIni: TDateTime;
      pRotaId, pZonaId, pCodPessoaERP: Integer): TJsonArray;
    Function ResetSeparacao(pPedidoVolumeId: Integer): TJsonArray;
    Function FinalizarSeparacao(pJsonObject: TJsonObject): TJsonObject;
    Function GetVolumeComDivergencia(pPedidoVolumeId: Integer): TJsonArray;
    Function GetPedidoVolumeProdutoLote(pPedidoId, pCodProduto: Integer)
      : TJsonArray;
    Function GetVolumeEAN(pPedidoVolumeId: Integer): TJsonArray;
    Function SaveApanheProdutos(pJsonArray: TJsonArray): TJsonArray;
    Function SalvarColetaComRegistro(pJsonColetaRegistro: TJsonObject)
      : TJsonArray;
    Function salvarultimoenderecocoletado(pPedidoVolumeId, pEnderecoId: Integer)
      : TJsonArray;
    Function BaixarEstoqueExpedicao: Boolean;
    Function GetPedidoCxaFechadaCheckOut(pPedidoVolumeId: Integer): TJsonObject;

    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServicePedidoVolume: TServicePedidoVolume;

implementation

uses Constants;

{ TProvidersBase1 }

function TServicePedidoVolume.IfThen(AValue: Boolean;
  const ATrue, AFalse: String): String;
begin
  if AValue then
    Result := ATrue
  else
    Result := AFalse;
end;

function TServicePedidoVolume.AtualizarKardex(pQuery: TFdQuery;
  pOperacaoTipoId, pLoteId, pEnderecoId, pEstoqueTipoId, pEstoqueTipoIdDestino,
  pQuantidade, pEnderecoIdDestino, pUsuarioId: Integer;
  pObservacaoOrigem, pObservacaoDestino, pNomeEstacao: String;
  pEstoqueInicial: Integer): Boolean;
Begin
  Try
    pQuery.Sql.Clear;
    pQuery.Sql.Add(TuEvolutConst.SqlKardexInsUpd);
    pQuery.ParamByName('pOperacaoTipoId').Value := pOperacaoTipoId;
    pQuery.ParamByName('pLoteId').Value := pLoteId;
    pQuery.ParamByName('pEnderecoId').Value := pEnderecoId;
    pQuery.ParamByName('pEstoqueTipoId').Value := pEstoqueTipoId;
    pQuery.ParamByName('pEstoqueTipoIdDestino').Value := pEstoqueTipoIdDestino;
    pQuery.ParamByName('pQuantidade').Value := pQuantidade;
    pQuery.ParamByName('pObservacaoOrigem').Value := pObservacaoOrigem;
    pQuery.ParamByName('pEnderecoIdDestino').Value := pEnderecoIdDestino;
    pQuery.ParamByName('pObservacaoDestino').Value := pObservacaoDestino;
    pQuery.ParamByName('pUsuarioId').Value := pUsuarioId;
    pQuery.ParamByName('pNomeEstacao').Value := pNomeEstacao;
    pQuery.ParamByName('pEstoqueInicial').Value := pEstoqueInicial;
    If DebugHook <> 0 then
      pQuery.Sql.SaveToFile('AtKardex.Sql');
    pQuery.ExecSQL;
    Result := True;
    pQuery.Close;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Kardex - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

Function TServicePedidoVolume.BaixarEstoqueExpedicao: Boolean;
var
  vQry, vQryEstoque, vQryKardex: TFdQuery;
begin
  vQry := FConexao.GetQuery;
  vQryEstoque := FConexao.GetQuery;
  vQryKardex := FConexao.GetQuery;
  try
    vQry.connection.StartTransaction;
    try
      vQry.Sql.Add
        ('select Top 50 Pv.PedidoVolumeId, De.ProcessoId, De.UsuarioId');
      vQry.Sql.Add('From PedidoVolumes Pv');
      vQry.Sql.Add('inner join vDocumentoEtapas De On De.Documento = Pv.Uuid');
      vQry.Sql.Add
        ('Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)');
      vQry.Sql.Add
        ('  And De.ProcessoId >= 13 and De.ProcessoId Not In (15,31) and expedido = 0');
      vQry.Sql.Add('  and (Select ExpedicaoOffLine From Configuracao) = 1');
      vQry.Sql.Add('Order by De.Processoid Desc');
      vQry.Open;
      while Not vQry.Eof do
      Begin
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        // Atualizar Kardex
        vQryEstoque.Sql.Add('Insert Into Kardex');
        vQryEstoque.Sql.Add
          ('select 2, Vl.LoteId, Vl.EnderecoId, Vl.EstoqueTipoId, Vl.QtdSuprida,');
        vQryEstoque.Sql.Add
          ('      (Select Qtde From Estoque where LoteId = Vl.LoteId and EnderecoId = Vl.EnderecoId and EstoqueTipoId = Vl.EstoqueTipoId),');
        vQryEstoque.Sql.Add
          ('      (Select Qtde-Vl.QtdSuprida From Estoque where LoteId = Vl.LoteId and EnderecoId = Vl.EnderecoId and EstoqueTipoId = Vl.EstoqueTipoId),');
        vQryEstoque.Sql.Add('      ' + #39 + 'Baixa Volume: ' + #39 +
          '+Cast(Vl.PedidoVolumeId as VarChar), Null, 0, 0, ' + #39 +
          'Transfer�ncia para loja' + #39 + ', ');
        vQryEstoque.Sql.Add('	     ' + TuEvolutConst.SqlDataAtual + ', ' +
          TuEvolutConst.SqlHoraAtual + ', ' + vQry.FieldByName('UsuarioId')
          .AsString);
        vQryEstoque.Sql.Add('      , ' + #39 + 'API EXP OFF' + #39);
        vQryEstoque.Sql.Add('from PedidoVolumeLotes Vl');
        vQryEstoque.Sql.Add('Where Vl.PedidoVolumeId = ' +
          vQry.FieldByName('PedidoVolumeId').AsString +
          ' and Vl.QtdSuprida > 0');

        vQryEstoque.Sql.Add('Update Est Set Qtde = Est.Qtde - Vl.QtdSuprida');
        vQryEstoque.Sql.Add('from PedidoVolumeLotes Vl');
        vQryEstoque.Sql.Add
          ('inner join Estoque Est on Est.LoteId = Vl.LoteId  and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = Vl.EstoqueTipoId');
        vQryEstoque.Sql.Add('where Vl.pedidovolumeid = ' +
          vQry.FieldByName('PedidoVolumeId').AsString);
        vQryEstoque.Sql.Add('Update Est Set Qtde = Est.Qtde - Vl.QtdSuprida');
        vQryEstoque.Sql.Add('from PedidoVolumeLotes Vl');
        vQryEstoque.Sql.Add
          ('inner join Estoque Est on Est.LoteId = Vl.LoteId  and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = 6');
        vQryEstoque.Sql.Add('where Vl.pedidovolumeid = ' +
          vQry.FieldByName('PedidoVolumeId').AsString);
        vQryEstoque.Sql.Add('Update PedidoVolumes Set Expedido = 1');
        vQryEstoque.Sql.Add('where pedidovolumeid = ' +
          vQry.FieldByName('PedidoVolumeId').AsString);
        vQryEstoque.ExecSQL;
        vQry.Next;
      End;
      vQry.connection.Commit;
      vQryEstoque.Close;
      vQryEstoque.Sql.Clear;
      vQryEstoque.Sql.Add
        ('Delete From Estoque where Qtde < 0 and EstoqueTipoId = 6');
      vQryEstoque.ExecSQL;
      Result := True;
    Except
      Begin
        vQry.connection.Rollback;
        Result := False;
      End;
    end;
  finally
    vQry.Close;
    vQryEstoque.Close;
    vQryKardex.Close;
    FConexao.Query.Close;
  end;
end;

function TServicePedidoVolume.CaixaSeparacao(pPedidoVolumeId, pCaixaEmbalagemId
  : Integer): TJsonArray;
var
  vQry: TFdQuery;
begin
  vQry := FConexao.GetQuery;
  try
    Result := TJsonArray.Create;
    try
      vQry.Sql.Add('Update PedidoVolumes');
      if pCaixaEmbalagemId > 0 then
        vQry.Sql.Add('  Set CaixaEmbalagemId = ' + pCaixaEmbalagemId.ToString())
      Else
        vQry.Sql.Add('  Set CaixaEmbalagemId = Null');
      vQry.Sql.Add('Where PedidoVolumeId = :pPedidoVolumeId');
      vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      vQry.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Caixa Alterada com sucesso!'));
    Except
      ON E: Exception do
      Begin

        raise Exception.Create('Processo: Caixa Embalagem - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.Cancelar(pConexao: TFdConnection;
  pJsonObject: TJsonObject): TJsonArray;
var
  vQry, vQryCheckPedido: TFdQuery;
  vTransacao: Boolean;
  vProcesso: String;
begin
  vQry := FConexao.GetQuery;
  vQryCheckPedido := FConexao.GetQuery;

  try
    if pConexao = Nil then
      vQry.connection := FConexao.DB
    Else
      vQry.connection := pConexao;
    vQryCheckPedido.connection := vQry.connection;
    if pJsonObject.GetValue<Integer>('pedidoId') > 0 then
    Begin

      vQryCheckPedido.Sql.Add
        ('Select De.ProcessoId, Descricao Processo From Pedido Ped');
      vQryCheckPedido.Sql.Add
        ('Inner Join vDocumentoEtapas De On De.Documento = Ped.Uuid');
      vQryCheckPedido.Sql.Add('Where Ped.PedidoId = ' +
        pJsonObject.GetValue<Integer>('pedidoId').ToString);
      vQryCheckPedido.Sql.Add
        ('   And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)');
      vQryCheckPedido.Open;
      if vQryCheckPedido.FieldByName('ProcessoId').AsInteger >= 13 then
      Begin
        vProcesso := vQryCheckPedido.FieldByName('Processo').AsString;
        vQryCheckPedido.Close;

        raise Exception.Create('Cancelamento n�o permitido. Processo Atual: ' +
          vProcesso);
      End;

    End;
    vTransacao := False;
    If Not vQry.connection.InTransaction then
    Begin
      vQry.connection.StartTransaction;
      vQry.connection.TxOptions.Isolation := xiReadCommitted;
      vTransacao := True;
    End;
    try
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Declare @PedidoId Integer = ' +
        pJsonObject.GetValue<Integer>('pedidoId').ToString());
      vQry.Sql.Add('Declare @PedidoVolumeId Integer = ' +
        pJsonObject.GetValue<Integer>('pedidoVolumeId').ToString());
      vQry.Sql.Add('Declare @UsuarioId Integer = ' +
        pJsonObject.GetValue<Integer>('usuarioid').ToString());
      vQry.Sql.Add('Declare @Terminal VarChar(50) = ' +
        QuotedStr(pJsonObject.GetValue<String>('terminal')));
      vQry.Sql.Add('--Volumes N�o expedido');
      vQry.Sql.Add
        ('Update Est Set LoteId = Vl.LoteId, Qtde = Qtde - Vl.QtdSuprida');
      vQry.Sql.Add('	From Estoque Est');
      vQry.Sql.Add
        ('	Inner Join (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      vQry.Sql.Add('                from PedidoVolumeLotes Vl');
      vQry.Sql.Add
        ('                Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      vQry.Sql.Add
        ('				Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      vQry.Sql.Add
        ('                Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      vQry.Sql.Add
        ('                      (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      vQry.Sql.Add
        ('					  DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1) and DE.ProcessoId < 13');
      vQry.Sql.Add
        ('                Group by LoteId, EnderecoId) Vl On Vl.LoteId = Est.LoteId and Vl.EnderecoId=Est.EnderecoId');
      vQry.Sql.Add('	Where Est.EstoqueTipoId = 6');
      vQry.Sql.Add('--Volume Expedido');
      vQry.Sql.Add('Update Est Set Qtde = Qtde + Vl.QtdSuprida');
      vQry.Sql.Add('	From Estoque Est');
      vQry.Sql.Add
        ('	Inner Join (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      vQry.Sql.Add('                from PedidoVolumeLotes Vl');
      vQry.Sql.Add
        ('                Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      vQry.Sql.Add
        ('				Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      vQry.Sql.Add
        ('                Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      vQry.Sql.Add
        ('                      (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      vQry.Sql.Add
        ('					  DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1) and');
      vQry.Sql.Add('					  DE.ProcessoId >= 13 and DE.ProcessoId <> 15');
      vQry.Sql.Add
        ('                Group by LoteId, EnderecoId) Vl On Vl.LoteId = Est.LoteId');
      vQry.Sql.Add
        ('	Where est.EnderecoId = (Select EnderecoidVolumeExpedidoCancelado From Configuracao)');
      vQry.Sql.Add
        ('Insert Into Estoque select Vl.LoteId, (Select EnderecoidVolumeExpedidoCancelado From Configuracao), 1, SUM(QtdSuprida),');
      vQry.Sql.Add
        ('							   (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      vQry.Sql.Add
        ('							   (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
      vQry.Sql.Add('							   Null, Null, Null, Null');
      vQry.Sql.Add
        ('    from (Select LoteId, EnderecoId, SUM(Vl.QtdSuprida) QtdSuprida');
      vQry.Sql.Add('                from PedidoVolumeLotes Vl');
      vQry.Sql.Add
        ('                Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId');
      vQry.Sql.Add
        ('				Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      vQry.Sql.Add
        ('                Where (@PedidoId = 0 or @PedidoId = Pv.PedidoId) And');
      vQry.Sql.Add
        ('                      (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) And');
      vQry.Sql.Add
        ('					  DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1) and');
      vQry.Sql.Add('					  DE.ProcessoId >= 13 and DE.ProcessoId <> 15');
      vQry.Sql.Add('                Group by LoteId, EnderecoId) Vl');
      vQry.Sql.Add
        ('	Left Join Estoque Est On Est.LoteId = Vl.Loteid And Est.EnderecoId = (Select EnderecoidVolumeExpedidoCancelado From Configuracao)');
      vQry.Sql.Add('	where Est.LoteId Is Null');
      vQry.Sql.Add('	Group by Vl.LoteId, Vl.EnderecoId');
      vQry.Sql.Add('--Registrar Cancelamento');
      vQry.Sql.Add('Insert Into DocumentoEtapas');
      vQry.Sql.Add
        ('   Select Uuid, 15, (Case When @UsuarioId=0 Then Null Else @UsuarioId End),');
      vQry.Sql.Add
        ('          (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      vQry.Sql.Add
        ('		  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
      vQry.Sql.Add('		  GetDate(), @Terminal, 1');
      vQry.Sql.Add('   From PedidoVolumes');
      vQry.Sql.Add('   where (@PedidoId = 0 or @PedidoId = PedidoId) and');
      vQry.Sql.Add
        ('         (@PedidoVolumeId = 0 or @PedidoVolumeId = PedidoVolumeId)');

      vQry.Sql.Add
        ('Insert Into DocumentoEtapas Values ((Select Uuid From Pedido Where PedidoId = (Case when @PedidoId = 0 then (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId) Else @PedidoId End) ),');
      vQry.Sql.Add('       (select Coalesce(Min(DE.ProcessoId), 15)');
      vQry.Sql.Add('        From PedidoVolumes PV');
      vQry.Sql.Add
        ('        Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId');
      vQry.Sql.Add
        ('        Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid');
      vQry.Sql.Add
        ('        where (Pv.PedidoId = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId)) and');
      vQry.Sql.Add
        ('	             DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = PV.uuid and Status = 1) ),');
      vQry.Sql.Add
        ('       @UsuarioId, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
      vQry.Sql.Add
        ('       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), @Terminal, 1)');
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('VolumeCancelar.Sql');
      vQry.ExecSQL;
      if vTransacao then
        vQry.connection.Commit;
      vQry.Close;

      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Ok',
        'Volume Cancelado com sucesso!')));

    Except
      ON E: Exception do
      Begin
        if vTransacao then
          vQry.connection.Rollback;

        raise Exception.Create('Processo: Volumes Cancelar - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
    vQryCheckPedido.Close;
  end;
end;

constructor TServicePedidoVolume.Create;
begin
  inherited;
end;

destructor TServicePedidoVolume.Destroy;
begin

  inherited;
end;

function TServicePedidoVolume.EtiquetaVolumePorRua(pJsonObject: TJsonObject) : TJsonArray;
var vQry: TFdQuery;
    JsonRetorno: TJsonObject;
    xArray: Integer;
    vCompl, vListaPedido: String;
begin
  Try
    Result := TJsonArray.Create;
    vQry := FConexao.GetQuery;
    try
      vQry.Sql.Add(TuEvolutConst.SqlEtiquetaVolumePorRua);
      vCompl := '';
      vListaPedido := '';
      if pJsonObject.GetValue<TJsonArray>('pedido').Count > 0 then
        vQry.Sql.Add('     And Pv.PedidoId in (');
      for xArray := 0 to Pred(pJsonObject.GetValue<TJsonArray>('pedido')
        .Count) do
      Begin
        vListaPedido := vListaPedido + vCompl + pJsonObject.GetValue<TJsonArray>
          ('pedido').Items[xArray].GetValue<String>('pedidoid');
        vCompl := ', ';
      End;
      if pJsonObject.Count > 0 then
        vQry.Sql.Add(vListaPedido + ' )');
      vQry.ParamByName('pProcessoId').Value := pJsonObject.GetValue<Integer>
        ('processoid');
      vQry.ParamByName('pEmbalagemId').Value := pJsonObject.GetValue<Integer>
        ('embalagemid');
      vQry.ParamByName('pZonaId').Value := pJsonObject.GetValue<Integer>
        ('zonaid');
      vQry.Sql.Add('order by VL.Inicio, vCxaFechada.CodProduto');
      // --, Pv.PedidoVolumeId');
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('EtiquetaPorRua.Sql');
      vQry.Open;
      if vQry.IsEmpty then
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
          TuEvolutConst.QrySemDados)))
      Else
        Result := vQry.ToJsonArray;
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Processo: Etiqueta Por Rua - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  Finally
    vQry.Close;
  End;
end;

function TServicePedidoVolume.FinalizarSeparacao(pJsonObject: TJsonObject)
  : TJsonObject;
var
  vQry: TFdQuery;
  vVolumeSeparacaoId: Integer;
begin
  vQry := FConexao.GetQuery;
  try

    vQry.connection.StartTransaction;
    vQry.connection.TxOptions.Isolation := xiReadCommitted;
    try
      if pJsonObject.GetValue<Integer>('volumeseparacaoid') = 0 then
      Begin
        vQry.Sql.Add
          ('Insert Into PedidoVolumeSeparacao (CaixaEmbalagemId, PedidoVolumeId, Operacao, EnderecoId, ');
        vQry.Sql.Add
          ('        Usuarioid, DtInicio, HrInicio, Divergencia) Values (');
        vQry.Sql.Add(pJsonObject.GetValue<String>('caixaembalagemid') + ', ' +
          pJsonObject.GetValue<String>('pedidovolumeid') + ', ' +
          pJsonObject.GetValue<String>('operacao') + ', ' +
          pJsonObject.GetValue<String>('enderecoid') + ', ' +
          IfThen(pJsonObject.GetValue<Integer>('usuarioid') = 0, 'Null',
          pJsonObject.GetValue<String>('usuarioid')) + ', ' +
          TuEvolutConst.SqlDataAtual + ', ' + TuEvolutConst.SqlHoraAtual
          + ', 0)');
        vQry.Sql.Add
          ('Select Coalesce(VolumeSeparacaoId, 0) VolumeSeparacaoId From PedidoVolumeSeparacao ');
        vQry.Sql.Add('Where CaixaEmbalagemId = ' + pJsonObject.GetValue<string>
          ('caixaembalagemid'));
        vQry.Sql.Add('  and PedidoVolumeId   = ' + pJsonObject.GetValue<string>
          ('pedidovolumeid'));
        vQry.Sql.Add('  and UsuarioId        = ' + pJsonObject.GetValue<string>
          ('usuarioid'));
        vQry.Sql.Add('  and Operacao         = 0');
        if pJsonObject.GetValue<Integer>('caixaembalagemid') <> 0 then
        Begin
          vQry.Sql.Add('Update PedidoVolumes Set CaixaEmbalagemId = ' +
            pJsonObject.GetValue<string>('caixaembalagemid'));
          vQry.Sql.Add('Where PedidoVolumeId = ' + pJsonObject.GetValue<string>
            ('pedidovolumeid'));
        End;
      End
      Else
      Begin
        vQry.Sql.Add('-- Operacao  = ' + pJsonObject.GetValue<String>
          ('operacao') + '   UsuarioId = ' + pJsonObject.GetValue<String>
          ('usuarioid') + '  EnderecoId  = ' + pJsonObject.GetValue<String>
          ('enderecoid'));
        vQry.Sql.Add(' Update PedidoVolumeSeparacao ');
        vQry.Sql.Add('   Set Operacao  = ' + pJsonObject.GetValue<String>
          ('operacao'));
        vQry.Sql.Add('   , EnderecoId  = ' + pJsonObject.GetValue<String>
          ('enderecoid'));
        vQry.Sql.Add('   , UsuarioId   = ' +
          IfThen(pJsonObject.GetValue<Integer>('operacao') = 0,
          IfThen(pJsonObject.GetValue<Integer>('usuarioid') = 0, 'Null',
          pJsonObject.GetValue<String>('usuarioid')), 'Null'));
        vQry.Sql.Add(IfThen(pJsonObject.GetValue<Integer>('operacao') = 1,
          '   , DtFinalizacao  = ' + TuEvolutConst.SqlDataAtual, ''));
        vQry.Sql.Add(IfThen(pJsonObject.GetValue<Integer>('operacao') = 1,
          '   , HrFinalizacao  = ' + TuEvolutConst.SqlHoraAtual, ''));
        vQry.Sql.Add(' where VolumeSeparacaoId = ' +
          pJsonObject.GetValue<String>('volumeseparacaoid'));
        vQry.Sql.Add('Select ' + pJsonObject.GetValue<String>
          ('volumeseparacaoid') + ' as VolumeSeparacaoId');
      End;
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('RegistrarSeparacao.Sql');
      vQry.Open;
      Result := TJsonObject.Create.AddPair('volumeseparacaoid',
        vQry.FieldByName('VolumeSeparacaoId').AsString)
        .AddPair('Resultado', 'Registro salvo com Sucesso!');
      vQry.Close;

      // Status do Volume
      vQry.Sql.Clear;
      vQry.Sql.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes where '
        + 'PedidoVolumeId = ' + pJsonObject.GetValue<String>
        ('pedidovolumeid') + ')');
      vQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      if pJsonObject.GetValue<Integer>('operacao') = 1 then
      Begin
        if pJsonObject.GetValue<Integer>('consolidado') = 1 then
          vQry.ParamByName('pProcessoId').Value := 10
        Else
          vQry.ParamByName('pProcessoId').Value := 8;
      End
      Else
        vQry.ParamByName('pProcessoId').Value := 7;
      vQry.Sql.Add('--Processoid = ' + vQry.ParamByName('pProcessoId')
        .AsString);
      vQry.ParamByName('pUsuarioId').Value := pJsonObject.GetValue<Integer>
        ('usuarioid');
      vQry.ParamByName('pTerminal').Value := pJsonObject.GetValue<String>
        ('estacao');
      If DebugHook <> 0 then
        vQry.Sql.SaveToFile('RegistrarProcessoSeparacao.Sql ');
      if pJsonObject.GetValue<Integer>('usuarioid') > 0 then
        vQry.ExecSQL;

      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
      vQry.ParamByName('pPedidoVolumeId').Value := pJsonObject.GetValue<Integer>
        ('pedidovolumeid');
      vQry.ParamByName('pUsuarioId').Value := pJsonObject.GetValue<Integer>
        ('usuarioid');
      vQry.ParamByName('pTerminal').Value := pJsonObject.GetValue<String>
        ('estacao');
      if pJsonObject.GetValue<Integer>('usuarioid') > 0 then
        vQry.ExecSQL;

    Except
      ON E: Exception do
      Begin
        vQry.Close;
        vQry.connection.Rollback;

        FConexao.DB.Connected := False;
        raise Exception.Create('Processo: FinalizarSeparacao - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.GerarVolumeExtra(pPedidoVolumeId,
  pUsuarioId: Integer; pJsonArrayProdutoCortes: TJsonArray): TJsonArray;
var
  vQry: TFdQuery;
  JsonVolume: TJsonObject;
  xProd: Integer;
begin
  vQry := FConexao.GetQuery;
  try

    vQry.connection.StartTransaction;
    vQry.connection.TxOptions.Isolation := xiReadCommitted;
    try
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add(TuEvolutConst.SqlGerarVolumeExtra);
      vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      vQry.ParamByName('pUsuarioId').Value := pUsuarioId;
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('VolumeExtra.Sql');
      vQry.Open;
      if vQry.IsEmpty then
      Begin
        Result := TJsonArray.Create();
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
          TuEvolutConst.QrySemDados)))
      End
      Else
        Result := vQry.ToJsonArray;
      vQry.Close;
      vQry.connection.Commit;

      FConexao.DB.Connected := False;
    Except
      ON E: Exception do
      Begin

        vQry.connection.Rollback;

        raise Exception.Create('Processo: GerarVolumeExtra - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.GetAuditoriaCorteAnalitico(const AParams
  : TDictionary<string, string>): TJsonArray;
Var
  pDataInicial, pDataFinal: TDateTime;
  pRotaId, pCodPessoaERP, pProcessoId, pPedidoId, pCodProduto, pLinhaId,
    pTipoVolume, pUsuarioId: Integer;
  pDocumentoNr: String;

  vQry: TFdQuery;
begin
  Result := TJsonArray.Create;
  Try
    pDataInicial := 0;
    pDataFinal := 0;
    pRotaId := 0;
    pCodPessoaERP := 0;
    pProcessoId := 0;
    pPedidoId := 0;
    pCodProduto := 0;
    pLinhaId := 0;
    pTipoVolume := 0;
    pDocumentoNr := '';
    pUsuarioId := 0;
    vQry := FConexao.GetQuery;

    if AParams.ContainsKey('pedidoid') then
      pPedidoId := AParams.Items['pedidoid'].ToInteger;
    if AParams.ContainsKey('documentonr') then
      pDocumentoNr := AParams.Items['documentonr'];
    if AParams.ContainsKey('datainicial') then
      pDataInicial := StrToDate(AParams.Items['datainicial']);
    if AParams.ContainsKey('datafinalal') then
      pDataInicial := StrToDate(AParams.Items['datafinal']);
    if AParams.ContainsKey('rotaid') then
      pDataInicial := AParams.Items['rotaid'].ToInteger;
    if AParams.ContainsKey('codpessoaerp') then
      pCodPessoaERP := AParams.Items['codpessoaerp'].ToInteger;
    if AParams.ContainsKey('processoid') then
      pProcessoId := AParams.Items['processoid'].ToInteger;
    if AParams.ContainsKey('codproduto') then
      pCodProduto := AParams.Items['codproduto'].ToInteger;
    if AParams.ContainsKey('linhaid') then
      pLinhaId := AParams.Items['linhaid'].ToInteger;
    if AParams.ContainsKey('tipovolume') then
      pTipoVolume := AParams.Items['tipovolume'].ToInteger;
    if AParams.ContainsKey('usuarioid') then
      pUsuarioId := AParams.Items['usuarioid'].ToInteger;
    vQry.Sql.Add(TuEvolutConst.SqlAuditoriaCorteAnalitico);
    vQry.ParamByName('pPedidoid').Value := pPedidoId;
    vQry.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    if pDataInicial <> 0 then
      vQry.ParamByName('pDtInicio').Value := FormatDatetime('YYYY-MM-DD',
        pDataInicial)
    Else
      vQry.ParamByName('pDtInicio').Value := 0;
    if pDataFinal <> 0 then
      vQry.ParamByName('pDtFinal').Value := FormatDatetime('YYYY-MM-DD',
        pDataFinal)
    Else
      vQry.ParamByName('pDtFinal').Value := 0;
    vQry.ParamByName('pRotaId').Value := pRotaId;
    vQry.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    vQry.ParamByName('pProcessoId').Value := pProcessoId;
    vQry.ParamByName('pCodProduto').Value := pCodProduto;
    vQry.ParamByName('pLinhaId').Value := pLinhaId;
    vQry.ParamByName('pTipoVolume').Value := pTipoVolume;
    vQry.ParamByName('pUsuarioId').Value := pUsuarioId;
    If DebugHook <> 0 Then
      vQry.Sql.SaveToFile('AuditoriaCorteAnalitico.Sql');
    vQry.Open;
    if vQry.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para a consulta.'))
    Else
      Result := vQry.ToJsonArray();

  Except
    ON E: Exception do
    Begin

      raise Exception.Create('Tabela: Mapa Separa��o Lista - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  vQry.Close
end;

function TServicePedidoVolume.GetAuditoriaVolumes(const AParams
  : TDictionary<string, string>): TJsonArray;
Var
  pDataInicial, pDataFinal: TDateTime;
  pRotaId, pCodPessoaERP, pProcessoId, pPedidoId, pCodProduto: Integer;
  pLinhaId, pZonaId, pTipoVolume, pUsuarioId: Integer;
  pDocumentoNr: String;
  FIndexConnExact: Integer;

  vQry: TFdQuery;
begin
  Result := TJsonArray.Create;
  Try
    pDataInicial := 0;
    pDataFinal := 0;
    pRotaId := 0;
    pCodPessoaERP := 0;
    pProcessoId := 0;
    pPedidoId := 0;
    pCodProduto := 0;
    pLinhaId := 0;
    pZonaId := 0;
    pTipoVolume := 0;
    pDocumentoNr := '';
    pUsuarioId := 0;

    if AParams.ContainsKey('pedidoid') then
      pPedidoId := AParams.Items['pedidoid'].ToInteger;
    if AParams.ContainsKey('documentonr') then
      pDocumentoNr := AParams.Items['documentonr'];
    if AParams.ContainsKey('datainicial') then
      pDataInicial := StrToDate(AParams.Items['datainicial']);
    if AParams.ContainsKey('datafinal') then
      pDataFinal := StrToDate(AParams.Items['datafinal']);
    if AParams.ContainsKey('rotaid') then
      pRotaId := AParams.Items['rotaid'].ToInteger;
    if AParams.ContainsKey('codpessoaerp') then
      pCodPessoaERP := AParams.Items['codpessoaerp'].ToInteger;
    if AParams.ContainsKey('processoid') then
      pProcessoId := AParams.Items['processoid'].ToInteger;
    if AParams.ContainsKey('codproduto') then
      pCodProduto := AParams.Items['codproduto'].ToInteger;
    if AParams.ContainsKey('linhaid') then
      pLinhaId := AParams.Items['linhaid'].ToInteger;
    if AParams.ContainsKey('zonaid') then
      pZonaId := AParams.Items['zonaid'].ToInteger;
    if AParams.ContainsKey('tipovolume') then
      pTipoVolume := AParams.Items['tipovolume'].ToInteger;
    if AParams.ContainsKey('usuarioid') then
      pUsuarioId := AParams.Items['usuarioid'].ToInteger;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlAuditoriaVolumes);
    FConexao.Query.ParamByName('pPedidoid').Value := pPedidoId;
    FConexao.Query.ParamByName('pDocumentoNr').Value := pDocumentoNr;
    if pDataInicial <> 0 then
      FConexao.Query.ParamByName('pDtInicio').Value :=
        FormatDatetime('YYYY-MM-DD', pDataInicial)
    Else
      FConexao.Query.ParamByName('pDtInicio').Value := 0;
    if pDataFinal <> 0 then
      FConexao.Query.ParamByName('pDtFinal').Value :=
        FormatDatetime('YYYY-MM-DD', pDataFinal)
    Else
      FConexao.Query.ParamByName('pDtFinal').Value := 0;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pCodProduto').Value := pCodProduto;
    FConexao.Query.ParamByName('pLinhaId').Value := pLinhaId;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pTipoVolume').Value := pTipoVolume;
    FConexao.Query.ParamByName('pUsuarioId').Value := pUsuarioId;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('AuditoriaVolumes.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Sem Dados para a consulta.'))
    Else
      Result := FConexao.Query.ToJsonArray();
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: GetAuditoriaVolumes - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  FConexao.Query.Close;
end;

function TServicePedidoVolume.Getdshvolumeevolucao_quantidade
  (pDataIni: TDateTime; pRotaId, pZonaId, pCodPessoaERP: Integer): TJsonArray;
begin
  try
    FConexao.Query.Sql.Add(TuEvolutConst.SqlGetdshvolumeevolucao_quantidade);
    FConexao.Query.ParamByName('pData').Value := pDataIni;
    FConexao.Query.ParamByName('pRotaId').Value := pRotaId;
    FConexao.Query.ParamByName('pZonaId').Value := pZonaId;
    FConexao.Query.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('Getdshvolumeevolucao_quantidade.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    End
    Else
      Result := FConexao.Query.ToJsonArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: Getdshvolumeevolucao_quantidade - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  FConexao.Query.Close;
end;

function TServicePedidoVolume.Getdshvolumeevolucao_Unidades(pDataIni: TDateTime;
  pRotaId, pZonaId, pCodPessoaERP: Integer): TJsonArray;
var
  vQry: TFdQuery;
begin
  vQry := FConexao.GetQuery;

  Result := TJsonArray.Create;
  try
    vQry.Sql.Add(TuEvolutConst.SqlGetdshvolumeevolucao_Unidades);
    vQry.ParamByName('pData').Value := pDataIni;
    vQry.ParamByName('pRotaId').Value := pRotaId;
    vQry.ParamByName('pZonaId').Value := pZonaId;
    vQry.ParamByName('pCodPessoaERP').Value := pCodPessoaERP;
    if DebugHook <> 0 then
      vQry.Sql.SaveToFile('Getdshvolumeevolucao_Unidades.Sql');
    vQry.Open;
    if vQry.IsEmpty then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      Result := vQry.ToJsonArray;

  Except
    ON E: Exception do
    Begin

      raise Exception.Create('Processo: Getdshvolumeevolucao_Unidades - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoVolume.GetOpenVolumeParaSeparacao(pCaixaId,
  pPedidoVolumeId, pUsuarioId: Integer; pTerminal: String): TJsonArray;
var
  vQry: TFdQuery;
  vQrySeparacao: TFdQuery;
  MsgErro: String;
  vVolumeSeparacaoId: Integer;
begin
  MsgErro := '';
  if (pCaixaId = 0) and (pPedidoVolumeId = 0) and (pUsuarioId = 0) then
    raise Exception.Create('Par�metro inv�lidos para a pesquisa!');
  // Informe a Amanda
  try
    vQry := FConexao.GetQuery;
    if (pCaixaId > 0) and (pPedidoVolumeId = 0) then
    Begin
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Declare @CaixaId Integer = :pCaixaId');
      vQry.Sql.Add('select vEC.*, PVS.PedidoVolumeId, PVS.UsuarioId');
      vQry.Sql.Add('from vEmbalagemCaixa vEC');
      vQry.Sql.Add
        ('Left Join (Select CaixaEmbalagemId, PedidoVolumeId, UsuarioId');
      vQry.Sql.Add('           From PedidoVolumeSeparacao');
      vQry.Sql.Add
        ('		   Where Operacao = 0) PVS on PVS.CaixaEmbalagemId = vEC.CaixaEmbalagemId');
      vQry.Sql.Add('where vEC.CaixaEmbalagemId = @CaixaId');
      vQry.ParamByName('pCaixaId').Value := pCaixaId;
      If DebugHook <> 0 then
        vQry.Sql.SaveToFile('CaixaParaSeparacao.Sql');
      vQry.Open;
      if (vQry.IsEmpty) or (vQry.FieldByName('CaixaEmbalagemId').AsInteger = 0)
      then
        MsgErro := 'Caixa n�o encontrada!'
      Else if (vQry.FieldByName('Status').AsInteger = 0) then
        MsgErro := 'Caixa inativa!'
      Else if (vQry.FieldByName('UsuarioId').AsInteger <> 0) and
        (vQry.FieldByName('UsuarioId').AsInteger <> pUsuarioId) then
        MsgErro := 'Caixa em uso por outro Usu�rio(' +
          vQry.FieldByName('UsuarioId').AsString + ')!';
      if (MsgErro <> '') or (vQry.FieldByName('PedidoVolumeId').AsInteger = 0)
      then
      Begin
        Result := TJsonArray.Create;
        if MsgErro <> '' then
          Result.AddElement(TJsonObject.Create(tJsonPair.Create('MSG',
            MsgErro)))
        Else
          Result.AddElement
            (TJsonObject.Create(tJsonPair.Create('caixaseparacao',
            TJsonNumber.Create(pCaixaId))));

        Exit;
      End;
      pPedidoVolumeId := vQry.FieldByName('PedidoVolumeId').AsInteger;
    End;
    vQry.Close;
    vQry.Sql.Clear;
    vQry.Sql.Add(TuEvolutConst.SqlGetOpenVolumeParaSeparacao);
    // vQry.ParamByName('pCaixaId').Value        := pCaixaid;
    vQry.ParamByName('pPedidoVolumeid').Value := pPedidoVolumeId;
    vQry.ParamByName('pUsuarioId').Value := pUsuarioId;
    if DebugHook <> 0 then
      vQry.Sql.SaveToFile('OpenVolumeParaSeparacao.Sql');
    vQry.Open;
    if vQry.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      if pPedidoVolumeId <> 0 then
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('MSG',
          TuEvolutConst.QrySemDados)))
      Else
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('MSG',
          'Caixa Dispon�vel!')))
    End
    Else
    Begin
      If (vQry.FieldByName('ProcessoId').AsInteger <> 3) and
        (vQry.FieldByName('ProcessoId').AsInteger <> 7) Then
      Begin
        if vQry.FieldByName('ProcessoId').AsInteger < 3 then
          MsgErro := 'Imprima a etiqueta do volume!'
        Else if vQry.FieldByName('ProcessoId').AsInteger > 7 then
          MsgErro := 'Separa��o n�o permitida. Processo Atual: ' +
            vQry.FieldByName('Processo').AsString;
      End
      Else If (vQry.FieldByName('Operacao').AsInteger = 1) then
        MsgErro := 'Separa��o de Volume j� conclu�da.'
      Else If (vQry.FieldByName('VolumeSeparacaoId').AsInteger <> 0) Then
      Begin
        If (pCaixaId <> vQry.FieldByName('caixaembalagemid').AsInteger) then
        Begin
          If vQry.FieldByName('caixaembalagemid').AsInteger = 0 then
            MsgErro := 'Volume Em Separa��o na Caixa(' +
              vQry.FieldByName('caixaembalagemid').AsString + ' - Papel�o).'
          Else
            MsgErro := 'Volume Em Separa��o na Caixa(' +
              vQry.FieldByName('caixaembalagemid').AsString + ').';
        End
        else If (vQry.FieldByName('UsuarioIdSeparacao').AsInteger <> 0) and
          (pUsuarioId <> vQry.FieldByName('UsuarioIdSeparacao').AsInteger) then
          MsgErro := 'Volume em separa��o por outro usu�rio(' +
            vQry.FieldByName('UsuarioIdSeparacao').AsString + ').';
      End;
      if MsgErro <> '' then
      begin
        Result := TJsonArray.Create;
        Result.AddElement(TJsonObject.Create.AddPair('MSG', MsgErro));
      End
      Else
      Begin
        vQrySeparacao := FConexao.GetQuery;;
        vQrySeparacao.connection := vQry.connection;
        // Evitar DeadLock com transacao menor e mais r�pida
        vQrySeparacao.connection.StartTransaction;
        vQrySeparacao.connection.TxOptions.Isolation := xiReadCommitted;
        if vQry.FieldByName('VolumeSeparacaoId').AsInteger = 0 then
        Begin
          vQrySeparacao.Close;
          vQrySeparacao.Sql.Clear;
          vQrySeparacao.Sql.Add('Declare @VolumeSeparacaoId Integer = 0');
          vQrySeparacao.Sql.Add('Insert into PedidoVolumeSeparacao Values (');
          vQrySeparacao.Sql.Add(pCaixaId.ToString() + ', ' +
            pPedidoVolumeId.ToString() + ', 0, 0, ' + pUsuarioId.ToString() +
            ', ' + TuEvolutConst.SqlDataAtual + ', ' +
            TuEvolutConst.SqlHoraAtual + ', Null, Null, 0');
          vQrySeparacao.Sql.Add(')');
          vQrySeparacao.Sql.Add('Set @VolumeSeparacaoId = SCOPE_IDENTITY()');
          vQrySeparacao.Sql.Add
            ('Select @VolumeSeparacaoId As VolumeSeparacaoId');
          vQrySeparacao.Open;
          // Status do Volume
          vQrySeparacao.Sql.Clear;
          vQrySeparacao.Sql.Add
            ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes where '
            + 'PedidoVolumeId = ' + pPedidoVolumeId.ToString() + ')');
          vQrySeparacao.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
          vQrySeparacao.ParamByName('pProcessoId').Value := 7;
          vQrySeparacao.ParamByName('pUsuarioId').Value := pUsuarioId;
          vQrySeparacao.ParamByName('pTerminal').Value := pTerminal;
          If DebugHook <> 0 then
            vQrySeparacao.Sql.SaveToFile('RegSeparacaoOpenSeparacao.Sql');
          vQrySeparacao.ExecSQL;
          vQrySeparacao.Close;
          vQrySeparacao.Sql.Clear;
          vQrySeparacao.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
          vQrySeparacao.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
          vQrySeparacao.ParamByName('pUsuarioId').Value := pUsuarioId;
          vQrySeparacao.ParamByName('pTerminal').Value := pTerminal;
          If DebugHook <> 0 then
            vQrySeparacao.Sql.SaveToFile('PedidoStatusOpenSeparacao.Sql');
          vQrySeparacao.ExecSQL;
          vQry.Close;
          vQry.Open;
        End
        Else
        Begin
          vVolumeSeparacaoId := vQry.FieldByName('VolumeSeparacaoId').AsInteger;
          vQrySeparacao.Close;
          vQrySeparacao.Sql.Clear;
          vQrySeparacao.Sql.Add('update PedidoVolumeSeparacao Set');
          vQrySeparacao.Sql.Add('  UsuarioId = ' + pUsuarioId.ToString());
          vQrySeparacao.Sql.Add('Where VolumeSeparacaoId = ' +
            vVolumeSeparacaoId.ToString());
          vQrySeparacao.ExecSQL;
        End;
        if vQrySeparacao.connection.InTransaction then
          vQrySeparacao.connection.Commit;
        vQrySeparacao.Close;

        Result := vQry.ToJsonArray;
      End;
    End;
    if vQry.connection.InTransaction then
      vQry.connection.Commit;

  Except
    ON E: Exception do
    Begin
      if (vQrySeparacao.connection.InTransaction) then
      Begin
        vQrySeparacao.connection.Rollback;
        vQrySeparacao.Close;
      End;

      raise Exception.Create('Processo: GetOpenVolumeParaSeparacao - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;

  if Assigned(vQrySeparacao) then
    vQrySeparacao.Close;
  if Assigned(vQry) then
    vQry.Close;

end;

function TServicePedidoVolume.GetPedidoCxaFechadaCheckOut(pPedidoVolumeId
  : Integer): TJsonObject;
Var
  vErro: String;

Begin
  if (pPedidoVolumeId = 0) then
    raise Exception.Create('Informe o volume para CheckOut!');
  Result := TJsonObject.Create;
  try
    FConexao.Query.Close;
    FConexao.Query.Sql.Clear;
    FConexao.Query.Sql.Add(TuEvolutConst.SqlPedidoCxaFechadaCheckOut);
    FConexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    if DebugHook <> 0 then
      FConexao.Query.Sql.SaveToFile('GetPedidoCxaFechadaCheckOut.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      Result.AddPair('Erro', 'Volume n�o encontrado!');
    End
    Else
    Begin
      vErro := '';
      case FConexao.Query.FieldByName('ProcessoId').AsInteger of
        2:
          vErro := 'Imprima a Etiqueta.';
        10, 11, 12, 13:
          vErro := 'Situa��o Volume: ' + FConexao.Query.FieldByName
            ('Processo').AsString;
        15:
          vErro := 'Volume Cancelado.';
      end;
      if vErro <> '' then
      Begin
        Result.AddPair('Erro', vErro);
      End
      Else
      Begin
        Result.AddPair('volume', FConexao.Query.ToJsonArray);
        FConexao.Query.Close;
        FConexao.Query.Sql.Clear;
        FConexao.Query.Sql.Add(TuEvolutConst.SqlPedidoCxaFechadaCheckOutProd);
        FConexao.Query.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
        FConexao.Query.Open();
        if FConexao.Query.IsEmpty then
        Begin
          Result.RemovePair('Erro');
          Result.AddPair('Erro', 'Volume sem produtos.');
        End
        Else
        Begin
          Result.AddPair('produto', FConexao.Query.ToJsonArray);
          FConexao.Query.Close;
          FConexao.Query.Sql.Clear;
          FConexao.Query.Sql.Add
            (TuEvolutConst.SqlPedidoCxaFechadaCheckOutCodBarras);
          FConexao.Query.ParamByName('pPedidoVolumeId').Value :=
            pPedidoVolumeId;
          FConexao.Query.Open();
          Result.AddPair('codbarras', FConexao.Query.ToJsonArray);
        End;
      End;
    End;
  Except
    ON E: Exception do
    Begin;
      raise Exception.Create('Processo: GetPedidoCxaFechadaCheckOut - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
  FConexao.Query.Close;
end;

function TServicePedidoVolume.GetPedidoVolumeProdutoLote(pPedidoId,
  pCodProduto: Integer): TJsonArray;

begin
  if (pPedidoId = 0) and (pCodProduto = 0) then
    raise Exception.Create('Identifica��o de Pedido/volume n�o informado!');

  var
  vQry := FConexao.GetQuery;
  try
    Result := TJsonArray.Create;
    try
      vQry.Sql.Add(TuEvolutConst.SqlPedidoVolumeProdutoLote);
      vQry.ParamByName('pPedidoid').Value := pPedidoId;
      vQry.ParamByName('pCodProduto').Value := pCodProduto;
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('PedidoVolumeProdutoLote.Sql');
      vQry.Open;
      if vQry.IsEmpty then
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
          TuEvolutConst.QrySemDados)))
      Else
        Result := vQry.ToJsonArray;

    Except
      ON E: Exception do
      Begin;
        raise Exception.Create('Processo: Getdshvolumeevolucao_Unidades - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;

  end;
end;

function TServicePedidoVolume.GetVolume(pPedidoId, pPedidoVolumeId, pSequencia,
  pOrdem: Integer; pEmbalagem: String; pZonaId: Integer): TJsonArray;
var
  vQry: TFdQuery;
  JsonVolume, JsonPedido, JsonDestino, JsonRota: TJsonObject;
begin
  vQry := FConexao.GetQuery;
  Result := TJsonArray.Create;
  try
    vQry.Sql.Add(TuEvolutConst.SqlVolume);
    vQry.ParamByName('pPedidoId').Value := pPedidoId;
    vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    vQry.ParamByName('pSequencia').Value := pSequencia;
    vQry.ParamByName('pOrdem').Value := pOrdem;
    vQry.ParamByName('pEmbalagem').Value := pEmbalagem;
    vQry.ParamByName('pZonaId').Value := pZonaId;
    if DebugHook <> 0 then
      vQry.Sql.SaveToFile('PedidoVolumes.Sql');
    vQry.Open;
    if (vQry.IsEmpty) or (vQry.FieldByName('ConsultaRetorno').AsString = '')
    then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      Result := TJsonObject.ParseJSONValue
        (TEncoding.UTF8.GetBytes(vQry.FieldByName('ConsultaRetorno').AsString),
        0) as TJsonArray;

  Except
    ON E: Exception do
    Begin

      Try
        If Assigned(JsonVolume) Then
          JsonVolume.Free;
      Except
      End;
      FConexao.DB.Connected := False;
      raise Exception.Create('Processo: GetVolume - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoVolume.GetVolumeComDivergencia(pPedidoVolumeId: Integer)
  : TJsonArray;
var
  vQry: TFdQuery;
begin
  vQry := FConexao.GetQuery;;

  try
    vQry.Sql.Add('-- PedidoVOlumeId = ' + pPedidoVolumeId.ToString);
    vQry.Sql.Add(TuEvolutConst.SqlVolumeComDivergencia);
    vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;

    if DebugHook <> 0 then
      vQry.Sql.SaveToFile('VolumeComDivergencia.Sql');
    vQry.Open;
    if vQry.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutConst.QrySemDados)));
    End
    Else
      Result := vQry.ToJsonArray();

  Except
    ON E: Exception do
    Begin

      raise Exception.Create('Processo: GetVolumeComDivergencia - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoVolume.GetVolumeEAN(pPedidoVolumeId: Integer)
  : TJsonArray;
var
  vQry: TFdQuery;
  JsonVolume, JsonPedido, JsonDestino, JsonRota: TJsonObject;
begin
  vQry := FConexao.GetQuery;
  Result := TJsonArray.Create;
  try
    vQry.Sql.Add(TuEvolutConst.SqlGetVolumeEAN);
    vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
    if DebugHook <> 0 then
      vQry.Sql.SaveToFile('VolumeEAN.Sql');
    vQry.Open;
    if (vQry.IsEmpty) then
      Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
        TuEvolutConst.QrySemDados)))
    Else
      Result := vQry.ToJsonArray;

  Except
    ON E: Exception do
    Begin

      Try
        If Assigned(JsonVolume) Then
          JsonVolume.Free; // Model.Connection.Disconnected(FIndexConnExact);
      Except

      End;
      FConexao.DB.Connected := False;
      raise Exception.Create('Processo: VolumeEAN - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TServicePedidoVolume.GetVolumePrintTag(pPedidoId, pPedidoVolumeId,
  pSequencia, pOrdem, pZonaId, pPrintTag, pEmbalagem: Integer): TJsonArray;
var
  vQry: TFdQuery;
  JsonVolume, JsonPedido, JsonDestino, JsonRota: TJsonObject;
begin
  vQry := FConexao.GetQuery;;
  try

    Result := TJsonArray.Create;
    try
      vQry.Sql.Add(TuEvolutConst.SqlVolumePrintTag);
      vQry.ParamByName('pPedidoId').Value := pPedidoId;
      vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      vQry.ParamByName('pSequencia').Value := pSequencia;
      vQry.ParamByName('pOrdem').Value := pOrdem;
      vQry.ParamByName('pZonaId').Value := pZonaId;
      vQry.ParamByName('pPrintTag').Value := pPrintTag;
      vQry.ParamByName('pEmbalagem').Value := pEmbalagem;
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('VolumePrintTag.Sql');
      vQry.Open;
      if (vQry.IsEmpty) then
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
          TuEvolutConst.QrySemDados)))
      Else
        Result := vQry.ToJsonArray;

    Except
      ON E: Exception do
      Begin

        Try
          If Assigned(JsonVolume) Then
            JsonVolume.Free; // Model.Connection.Disconnected(FIndexConnExact);]
        Except

        End;
        FConexao.DB.Connected := False;
        raise Exception.Create('Processo: GetVolumePrintTag - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.RegistrarDocumentoEtapa(pJsonDocumentoEtapa
  : TJsonObject): TJsonArray;
var
  vQry, vQryPedStatus: TFdQuery;
begin
  vQry := FConexao.GetQuery;;
  try
    vQryPedStatus := FConexao.GetQuery;;
    vQryPedStatus.connection := FConexao.DB;;
    try
      vQry.Sql.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes where '
        + 'PedidoVolumeId = ' + pJsonDocumentoEtapa.GetValue<Integer>
        ('pedidovolumeid').ToString() + ')');
      vQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      vQry.ParamByName('pProcessoId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('processoid');
      vQry.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      vQry.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<String>('estacao');
      vQry.ExecSQL;
      vQry.Close;
      vQryPedStatus.Close;
      vQryPedStatus.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
      vQryPedStatus.ParamByName('pPedidoVolumeId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid');
      vQryPedStatus.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      vQryPedStatus.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<String>('estacao');
      vQryPedStatus.ExecSQL;

      Result := TJsonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Processo registrado com sucesso!'));
      FConexao.DB.Connected := False;
    Except
      ON E: Exception do
      Begin

        FConexao.DB.Connected := False;
        raise Exception.Create('Processo: Volumes para Etiquetas - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.RegistrarDocumentoEtapaComBaixaEstoque
  (pJsonDocumentoEtapa: TJsonObject): TJsonArray;
Var
  vQry, vQryVolumeLotes, vQryEstoque, vQryPedStatus, vQryKardex: TFdQuery;
  vEstoqueInicial: Integer;
begin
  Result := TJsonArray.Create;
  vQry := FConexao.GetQuery;
  vQryEstoque := FConexao.GetQuery;
  vQryVolumeLotes := FConexao.GetQuery;
  vQryPedStatus := FConexao.GetQuery;
  vQryKardex := FConexao.GetQuery;
  vQry.connection := FConexao.DB;
  vQryEstoque.connection := vQry.connection;
  vQryVolumeLotes.connection := vQry.connection;
  vQryPedStatus.connection := vQry.connection;
  vQryKardex.connection := vQry.connection;
  try
    vQry.connection.StartTransaction;
    try
      vQry.Sql.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes ' +
        '                                  Where PedidoVolumeId = ' +
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid')
        .ToString() + ')');
      vQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      vQry.Sql.Add('--  ');
      vQry.Sql.Add
        ('Update PedidoVolumes Set Expedido = 1 Where PedidoVolumeId = ' +
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid').ToString());
      vQry.ParamByName('pProcessoId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('processoid');
      vQry.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      vQry.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<String>('estacao');
      vQry.Sql.SaveToFile('RegistrarDocumentoEtapaComBaixaEstoque');

      vQry.ExecSQL;
      // BaixarEstoque
      vQryVolumeLotes.Close;
      vQryVolumeLotes.Sql.Clear;
      vQryVolumeLotes.Sql.Add
        ('Select LoteId, EnderecoId, EstoqueTipoId, Quantidade, QtdSuprida');
      vQryVolumeLotes.Sql.Add('From PedidoVolumeLotes');
      vQryVolumeLotes.Sql.Add('where PedidoVolumeId =' +
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid').ToString);
      vQryVolumeLotes.Open;
      While Not vQryVolumeLotes.Eof do
      Begin
        // Pegar Saldo inicial do Lote
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        vQryEstoque.Sql.Add('select Qtde From Estoque');
        vQryEstoque.Sql.Add('Where LoteId = ' + vQryVolumeLotes.FieldByName
          ('LoteId').AsString);
        vQryEstoque.Sql.Add('  And EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString);
        vQryEstoque.Sql.Add('  And EstoqueTipoId = ' +
          vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString);
        vQryEstoque.Open;
        vEstoqueInicial := vQryEstoque.FieldByName('Qtde').AsInteger;
        // Baixar Estoque Reserva
        vQryEstoque.Close;
        vQryEstoque.Sql.Clear;
        vQryEstoque.Sql.Add
          ('If Exists (Select LoteId From Estoque Where EstoqueTipoId = 6' +
          ' and LoteId = ' + vQryVolumeLotes.FieldByName('LoteId').AsString +
          ' and EnderecoId = ' + vQryVolumeLotes.FieldByName('EnderecoId')
          .AsString + ') Begin');
        // Verificar se Estoque Saldo Estoque Reservado maior que zero, sen�o Delete
        vQryEstoque.Sql.Add('   Update Estoque Set Qtde = Qtde - ' +
          vQryVolumeLotes.FieldByName('Quantidade').AsString +
          '      Where EstoqueTipoId = 6 and LoteId = ' +
          vQryVolumeLotes.FieldByName('LoteId').AsString +
          '            and EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString);
        vQryEstoque.Sql.Add('End');

        // Baixar Estoque Produ��o

        vQryEstoque.Sql.Add('If Exists (Select LoteId From Estoque');
        vQryEstoque.Sql.Add('Where EstoqueTipoId = ' +
          vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString +
          '      and LoteId = ' + vQryVolumeLotes.FieldByName('LoteId').AsString
          + '      and EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString + ') Begin');
        vQryEstoque.Sql.Add('   Update Estoque Set Qtde = Qtde - ' +
          vQryVolumeLotes.FieldByName('QtdSuprida').AsString +
          '      Where EstoqueTipoId = ' + vQryVolumeLotes.FieldByName
          ('EstoqueTipoId').AsString + '            and LoteId = ' +
          vQryVolumeLotes.FieldByName('LoteId').AsString +
          '            and EnderecoId = ' + vQryVolumeLotes.FieldByName
          ('EnderecoId').AsString);
        vQryEstoque.Sql.Add('   End');
        vQryEstoque.Sql.Add('Else Begin');
        vQryEstoque.Sql.Add
          ('   Insert Into Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao ) Values (');
        vQryEstoque.Sql.Add('         ' + vQryVolumeLotes.FieldByName('LoteId')
          .AsString + ', ' + vQryVolumeLotes.FieldByName('EnderecoId').AsString
          + ', ' + vQryVolumeLotes.FieldByName('EstoqueTipoId').AsString + ', '
          + (vQryVolumeLotes.FieldByName('QtdSuprida').AsInteger * (-1))
          .ToString + ', ' + TuEvolutConst.SqlDataAtual + ', ' +
          TuEvolutConst.SqlHoraAtual + ')');
        vQryEstoque.Sql.Add('End;');
        vQryEstoque.ExecSQL;

        AtualizarKardex(vQryKardex, 2, vQryVolumeLotes.FieldByName('LoteId')
          .AsInteger, vQryVolumeLotes.FieldByName('EnderecoId').AsInteger,
          vQryVolumeLotes.FieldByName('EstoqueTipoId').AsInteger, 0,
          (vQryVolumeLotes.FieldByName('QtdSuprida').AsInteger), 0,
          pJsonDocumentoEtapa.GetValue<Integer>('usuarioid'),
          'Baixa Volume: ' + pJsonDocumentoEtapa.GetValue<Integer>
          ('pedidovolumeid').ToString(), 'Transfer�ncia para loja',
          pJsonDocumentoEtapa.GetValue<String>('estacao'), vEstoqueInicial);
        vQryVolumeLotes.Next;
      End;
      vQryPedStatus.Close;
      vQryPedStatus.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
      vQryPedStatus.ParamByName('pPedidoVolumeId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid');
      vQryPedStatus.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      vQryPedStatus.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<String>('estacao');
      vQryPedStatus.ExecSQL;
      vQry.connection.Commit;
      Result.AddElement(TJsonObject.Create.AddPair('pedidovolumeid',
        TJsonNumber.Create(pJsonDocumentoEtapa.GetValue<Integer>
        ('pedidovolumeid'))));
    Except
      ON E: Exception do
      Begin
        vQry.connection.Rollback;
        raise Exception.Create
          ('Tabela_Service: RegistrarDocumentoEtapaComBaixaEstoque - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
    vQryVolumeLotes.Close;
    vQryEstoque.Close;
    vQryPedStatus.Close;
    vQryKardex.Close;
  end;
end;

function TServicePedidoVolume.RegistrarDocumentoEtapaSemBaixaEstoque
  (pJsonDocumentoEtapa: TJsonObject): TJsonArray;
Var
  vQry, vQryVolumeLotes, vQryEstoque, vQryPedStatus, vQryKardex: TFdQuery;
  vEstoqueInicial: Integer;
begin
  Result := TJsonArray.Create;
  vQry := FConexao.GetQuery;
  vQryPedStatus := FConexao.GetQuery;
  vQryPedStatus.connection := vQry.connection;
  try
    vQry.connection.StartTransaction;
    try
      vQry.Sql.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes ');
      vQry.Sql.Add('                                  where ' +
        'PedidoVolumeId = ' + pJsonDocumentoEtapa.GetValue<Integer>
        ('pedidovolumeid').ToString() + ')');
      vQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      vQry.ParamByName('pProcessoId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('processoid');
      vQry.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      vQry.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<String>('estacao');
      vQry.ExecSQL;
      vQryPedStatus.Close;
      vQryPedStatus.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
      vQryPedStatus.ParamByName('pPedidoVolumeId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('pedidovolumeid');
      vQryPedStatus.ParamByName('pUsuarioId').Value :=
        pJsonDocumentoEtapa.GetValue<Integer>('usuarioid');
      vQryPedStatus.ParamByName('pTerminal').Value :=
        pJsonDocumentoEtapa.GetValue<String>('estacao');
      vQryPedStatus.ExecSQL;
      vQry.connection.Commit;
      Result.AddElement(TJsonObject.Create.AddPair('pedidovolumeid',
        TJsonNumber.Create(pJsonDocumentoEtapa.GetValue<Integer>
        ('pedidovolumeid'))));
    Except
      ON E: Exception do
      Begin
        vQry.connection.Rollback;
        raise Exception.Create
          ('Tabela_Service: RegistrarDocumentoEtapaSemBaixaEstoque - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
    vQryPedStatus.Close;
  end;
end;

function TServicePedidoVolume.ResetSeparacao(pPedidoVolumeId: Integer)
  : TJsonArray;
var
  vQry: TFdQuery;
begin
  vQry := FConexao.GetQuery;
  Result := TJsonArray.Create;
  try
    try
      vQry.Sql.Add('Update PedidoVolumeLotes');
      vQry.Sql.Add('  Set QtdSuprida = Quantidade');
      vQry.Sql.Add('    --, usuarioId  = Null');
      vQry.Sql.Add('where PedidoVolumeid = ' + pPedidoVolumeId.ToString);
      vQry.Sql.Add
        ('Update PedidoVolumes Set CaixaEmbalagemId = Null where PedidoVolumeid = '
        + pPedidoVolumeId.ToString);
      vQry.Sql.Add('Delete PedidoVolumeSeparacao where PedidoVolumeid = ' +
        pPedidoVolumeId.ToString);
      vQry.Sql.Add('Delete pedidooperacao where PedidoVolumeid = ' +
        pPedidoVolumeId.ToString);
      vQry.Sql.Add('Delete De');
      vQry.Sql.Add('From DocumentoEtapas De');
      vQry.Sql.Add('Inner Join PedidoVolumes Pv On Pv.Uuid = De.Documento');
      vQry.Sql.Add('where PedidoVolumeid = ' + pPedidoVolumeId.ToString +
        ' and De.Processoid > 3');
      If DebugHook <> 0 Then
        vQry.Sql.SaveToFile('ResetVolume.Sql');
      vQry.ExecSQL;
      Result.Add(TJsonObject.Create.AddPair('Ok',
        'Opera��o conclu�da com sucesso!'));

    Except
      ON E: Exception do
      Begin

        raise Exception.Create('Processo: Reset Volume - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;

end;

function TServicePedidoVolume.salvarultimoenderecocoletado(pPedidoVolumeId,
  pEnderecoId: Integer): TJsonArray;
Var
  vQry: TFdQuery;
begin
  vQry := FConexao.GetQuery;
  Result := TJsonArray.Create;
  try
    Try
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Update PedidoVOlumeSeparacao ');
      vQry.Sql.Add('  Set EnderecoId = ' + pEnderecoId.ToString());
      vQry.Sql.Add('Where PedidoVolumeId = ' + pPedidoVolumeId.ToString());
      vQry.ExecSQL;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Endereco salvo com sucesso!'));

    Except
      ON E: Exception do
      Begin

        vQry.connection.Rollback;

        raise Exception.Create(StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.SalvarColetaComRegistro(pJsonColetaRegistro
  : TJsonObject): TJsonArray;
Var
  vQry, vQryAtualiza: TFdQuery;
  xColeta, vQtdConferida: Integer;
  pJsonArrayColeta: TJsonArray;
  JsonVolumeExtra: TJsonArray;
  pVolumeExtra: Integer;
begin
  vQry := FConexao.GetQuery;
  vQry.connection := FConexao.DB;
  vQryAtualiza := FConexao.GetQuery;
  vQryAtualiza.connection := vQry.connection;
  vQry.connection.StartTransaction;
  vQry.connection.TxOptions.Isolation := xiReadCommitted;
  try
    pVolumeExtra := 0;
    Try
      vQry.Sql.Add
        ('select Prd.IdProduto ProdutoId, Prd.CodProduto, Vl.LoteId, Vl.EnderecoId, Vl.Quantidade, Vl.QtdSuprida');
      vQry.Sql.Add('From PedidoVolumeLotes VL');
      vQry.Sql.Add('Inner Join ProdutoLotes PL On Pl.LoteId = Vl.LoteId');
      vQry.Sql.Add('Inner Join Produto Prd on Prd.IdProduto = Pl.ProdutoId');
      vQry.Sql.Add
        ('Where Prd.CodProduto = :pCodProduto and Vl.PedidoVolumeId = :pPedidoVolumeId');
      vQryAtualiza.Sql.Add('Update PedidoVolumeLotes ');
      vQryAtualiza.Sql.Add('   Set QtdSuprida  = :pQtdSuprida');
      vQryAtualiza.Sql.Add
        ('      , DtInclusao = (Select IdData From Rhema_Data where Data = :pDtSeparacao)');
      vQryAtualiza.Sql.Add
        ('      , HrInclusao = (Select IdHora From Rhema_Hora where Hora = Substring(:pHrSeparacao, 1, 5))');
      vQryAtualiza.Sql.Add('      , UsuarioId  = :pUsuarioid');
      vQryAtualiza.Sql.Add('      , Terminal   = :pTerminal');
      vQryAtualiza.Sql.Add
        ('Where LoteId = :pLoteId and PedidoVolumeId = :pPedidoVolumeId');
      vQryAtualiza.Sql.Add
        ('Insert Into PedidoOperacao (pedidovolumeid, loteid, enderecoid, quantidade,	qtdsuprida,	processoetapaid,');
      vQryAtualiza.Sql.Add
        ('                           	data,	hora,	usuarioid,	estacao) Values ');
      vQryAtualiza.Sql.Add
        ('                           (:poperpedidovolumeid, :poperloteid, :poperenderecoid, :poperquantidade,	:poperqtdsuprida,	');
      vQryAtualiza.Sql.Add
        ('                           	(Select Processoid from ProcessoEtapas where Descricao = :poperprocessoetapa), :poperdata,	:poperhora,	:poperusuarioid,	:poperestacao)');
      pJsonArrayColeta := pJsonColetaRegistro.GetValue<TJsonArray>('coleta');
      For xColeta := 0 to Pred(pJsonArrayColeta.Count) do
      Begin
        vQry.Close();
        vQry.ParamByName('pCodProduto').Value := pJsonArrayColeta.Items[xColeta]
          .GetValue<Integer>('codproduto');
        vQry.ParamByName('pPedidoVolumeId').Value := pJsonArrayColeta.Items
          [xColeta].GetValue<Integer>('pedidovolumeid');
        vQry.Open;
        vQtdConferida := pJsonArrayColeta.Items[xColeta].GetValue<Integer>
          ('qtdsuprida');
        // pJsonArray.Items[xProd].GetValue<Integer>('quantidade');  //Quantidade Suprida
        While (Not vQry.Eof) do
        Begin // and (vQtdConferida>0)
          vQryAtualiza.Close;
          vQryAtualiza.ParamByName('pPedidoVolumeId').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('pLoteid').Value := pJsonArrayColeta.Items
            [xColeta].GetValue<Integer>('loteid');
          vQryAtualiza.ParamByName('pUsuarioId').Value := pJsonArrayColeta.Items
            [xColeta].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pDtSeparacao').Value :=
            FormatDatetime('YYYY-MM-DD',
            StrToDate(pJsonArrayColeta.Items[xColeta].GetValue<String>
            ('data')));
          vQryAtualiza.ParamByName('pHrSeparacao').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('pTerminal').Value := pJsonArrayColeta.Items
            [xColeta].GetValue<String>('terminal');
          vQryAtualiza.ParamByName('pQtdSuprida').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // vQtdConferida;
          vQryAtualiza.ParamByName('poperquantidade').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // vQtdConferida;
          vQryAtualiza.ParamByName('poperqtdsuprida').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // vQtdConferida;
          vQtdConferida := 0;
          // Gravar acompanhamento da operacao para an�lise de resultados
          vQryAtualiza.ParamByName('poperPedidoVolumeId').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('poperLoteid').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('loteid');
          // vQry.FieldByName('LoteId').AsInteger;
          vQryAtualiza.ParamByName('poperEnderecoid').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('enderecoid');
          // vQry.FieldByName('EnderecoId').AsInteger;
          vQryAtualiza.ParamByName('poperquantidade').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('demanda');
          // vQry.FieldByName('Quantidade').AsInteger;
          vQryAtualiza.ParamByName('poperqtdsuprida').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // pJsonArray.Items[xProd].GetValue<Integer>('quantidade');
          vQryAtualiza.ParamByName('poperUsuarioId').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pOperData').Value :=
            FormatDatetime('YYYY-MM-DD',
            StrToDate(pJsonArrayColeta.Items[xColeta].GetValue<String>
            ('data')));
          // pJsonArray.Items[xProd].GetValue<String>('data'); //
          vQryAtualiza.ParamByName('pOperHora').Value := pJsonArrayColeta.Items
            [xColeta].GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('poperestacao').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<String>('terminal');
          vQryAtualiza.ParamByName('poperprocessoetapa').Value :=
            pJsonArrayColeta.Items[xColeta].GetValue<String>('processoetapa');
          If DebugHook <> 0 then
            vQryAtualiza.Sql.SaveToFile('AtualizacaoReservar.Sql');
          vQryAtualiza.ExecSQL;
          vQry.Next
        End;
      End;
      vQry.Close;
      vQry.Sql.Clear;
      vQry.Sql.Add('Update PedidoVolumeSeparacao Set');
      vQry.Sql.Add('    UsuarioId = Null');
      vQry.Sql.Add('  , Operacao = ' + pJsonColetaRegistro.GetValue<Integer>
        ('operacao').ToString());
      if pJsonColetaRegistro.GetValue<Integer>('operacao') = 1 then
      Begin
        vQry.Sql.Add('  , EnderecoId = 0');
        vQry.Sql.Add('  , DtFinalizacao = ' + TuEvolutConst.SqlDataAtual);
        vQry.Sql.Add('  , HrFinalizacao = ' + TuEvolutConst.SqlHoraAtual);
      End
      Else
      Begin
        vQry.Sql.Add('  , EnderecoId = ' + pJsonColetaRegistro.GetValue<Integer>
          ('enderecoid').ToString());
      End;
      vQry.Sql.Add('Where VolumeSeparacaoId = ' +
        pJsonColetaRegistro.GetValue<Integer>('volumeseparacaoid').ToString());
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('ColetaSeparacaoRegistro.Sql');
      vQry.ExecSQL;
      if pJsonColetaRegistro.GetValue<Integer>('operacao') = 1 then
      Begin
        // Status do Volume
        vQry.Sql.Clear;
        vQry.Sql.Add
          ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From PedidoVolumes where '
          + 'PedidoVolumeId = ' + pJsonColetaRegistro.GetValue<Integer>
          ('pedidovolumeid').ToString() + ')');
        vQry.Sql.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
        if pJsonColetaRegistro.GetValue<Integer>('consolidado') = 1 then
          vQry.ParamByName('pProcessoId').Value := 10
        Else
          vQry.ParamByName('pProcessoId').Value := 8;
        vQry.ParamByName('pUsuarioId').Value :=
          pJsonColetaRegistro.GetValue<Integer>('usuarioid');
        vQry.ParamByName('pTerminal').Value :=
          pJsonColetaRegistro.GetValue<String>('terminal');
        If DebugHook <> 0 then
          vQry.Sql.SaveToFile('RegSeparacaoOpenSeparacao.Sql ');
        vQry.ExecSQL;
        vQry.Close;
        vQry.Sql.Clear;
        vQry.Sql.Add(TuEvolutConst.AtualizaStatusPedido);
        vQry.ParamByName('pPedidoVolumeId').Value :=
          pJsonColetaRegistro.GetValue<Integer>('pedidovolumeid');
        vQry.ParamByName('pUsuarioId').Value :=
          pJsonColetaRegistro.GetValue<Integer>('usuarioid');
        vQry.ParamByName('pTerminal').Value :=
          pJsonColetaRegistro.GetValue<String>('terminal');
        vQry.ExecSQL;
        If pJsonColetaRegistro.GetValue<String>('volumeextra') = 'YES' then
        Begin
          vQry.Close;
          vQry.Sql.Clear;
          vQry.Sql.Add(TuEvolutConst.SqlGerarVolumeExtra);
          vQry.ParamByName('pPedidoVolumeId').Value :=
            pJsonColetaRegistro.GetValue<Integer>('pedidovolumeid');
          vQry.ParamByName('pUsuarioId').Value :=
            pJsonColetaRegistro.GetValue<Integer>('usuarioid');
          vQry.Open;
          if Not vQry.IsEmpty then
            pVolumeExtra := vQry.FieldByName('PedidoVolumeId').AsInteger;
          vQry.Close;
        End;
      End;
      vQry.connection.Commit;
      Result := TJsonArray.Create;
      if pVolumeExtra = 0 then
        Result.AddElement(TJsonObject.Create.AddPair('Ok',
          'Coleta Salva com sucesso!'))
      Else
        Result.AddElement(TJsonObject.Create.AddPair('volumeextra',
          TJsonNumber.Create(pVolumeExtra)));
    Except
      ON E: Exception do
      Begin
        vQry.connection.Rollback;
        raise Exception.Create(StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
    vQryAtualiza.Close;
  end;
end;

function TServicePedidoVolume.SaveApanheProdutos(pJsonArray: TJsonArray)
  : TJsonArray;
Var
  vQry, vQryAtualiza: TFdQuery;
  xColeta, vQtdConferida: Integer;
begin
  vQry := FConexao.GetQuery;
  vQry.connection := FConexao.DB;
  vQry.connection.StartTransaction;
  vQry.connection.TxOptions.Isolation := xiReadCommitted;
  vQryAtualiza := FConexao.GetQuery;
  vQryAtualiza.connection := vQry.connection;
  try
    Try
      vQry.Sql.Add
        ('select Prd.IdProduto ProdutoId, Prd.CodProduto, Vl.LoteId, Vl.EnderecoId, Vl.Quantidade, Vl.QtdSuprida');
      vQry.Sql.Add('From PedidoVolumeLotes VL');
      vQry.Sql.Add('Inner Join ProdutoLotes PL On Pl.LoteId = Vl.LoteId');
      vQry.Sql.Add('Inner Join Produto Prd on Prd.IdProduto = Pl.ProdutoId');
      vQry.Sql.Add
        ('Where Prd.CodProduto = :pCodProduto and Vl.PedidoVolumeId = :pPedidoVolumeId');

      vQryAtualiza.Sql.Add('Update PedidoVolumeLotes ');
      vQryAtualiza.Sql.Add('   Set QtdSuprida  = :pQtdSuprida');
      vQryAtualiza.Sql.Add
        ('      , DtInclusao = (Select IdData From Rhema_Data where Data = :pDtSeparacao)');
      vQryAtualiza.Sql.Add
        ('      , HrInclusao = (Select IdHora From Rhema_Hora where Hora = Substring(:pHrSeparacao, 1, 5))');
      vQryAtualiza.Sql.Add('      , UsuarioId  = :pUsuarioid');
      vQryAtualiza.Sql.Add('      , Terminal   = :pTerminal');
      vQryAtualiza.Sql.Add
        ('Where LoteId = :pLoteId and PedidoVolumeId = :pPedidoVolumeId');

      vQryAtualiza.Sql.Add
        ('Insert Into PedidoOperacao (pedidovolumeid, loteid, enderecoid, quantidade,	qtdsuprida,	processoetapaid,');
      vQryAtualiza.Sql.Add
        ('                           	data,	hora,	usuarioid,	estacao) Values ');
      vQryAtualiza.Sql.Add
        ('                           (:poperpedidovolumeid, :poperloteid, :poperenderecoid, :poperquantidade,	:poperqtdsuprida,	');
      vQryAtualiza.Sql.Add
        ('                           	(Select Processoid from ProcessoEtapas where Descricao = :poperprocessoetapa), :poperdata,	:poperhora,	:poperusuarioid,	:poperestacao)');

      For xColeta := 0 to Pred(pJsonArray.Count) do
      Begin
        vQry.Close();
        vQry.ParamByName('pCodProduto').Value := pJsonArray.Items[xColeta]
          .GetValue<Integer>('codproduto');
        vQry.ParamByName('pPedidoVolumeId').Value := pJsonArray.Items[xColeta]
          .GetValue<Integer>('pedidovolumeid');
        vQry.Open;
        vQtdConferida := pJsonArray.Items[xColeta].GetValue<Integer>
          ('qtdsuprida');
        // pJsonArray.Items[xProd].GetValue<Integer>('quantidade');  //Quantidade Suprida
        While (Not vQry.Eof) do
        Begin // and (vQtdConferida>0)
          vQryAtualiza.Close;
          // vQryAtualiza.ParamByName('pLoteIdRes').Value         := pJsonArray.Items[xProd].GetValue<Integer>('loteid'); //vQry.FieldByName('LoteId').AsInteger;
          // vQryAtualiza.ParamByName('pPedidoVolumeIdRes').Value := pJsonArray.Items[xProd].GetValue<Integer>('pedidovolumeid');
          // vQryAtualiza.ParamByName('pLoteIdEst').Value         := pJsonArray.Items[xProd].GetValue<Integer>('loteid'); //vQry.FieldByName('LoteId').AsInteger;

          vQryAtualiza.ParamByName('pPedidoVolumeId').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('pLoteid').Value := pJsonArray.Items[xColeta]
            .GetValue<Integer>('loteid');
          // vQry.FieldByName('LoteId').AsInteger;
          vQryAtualiza.ParamByName('pUsuarioId').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pDtSeparacao').Value :=
            FormatDatetime('YYYY-MM-DD',
            StrToDate(pJsonArray.Items[xColeta].GetValue<String>('data')));
          // pJsonArray.Items[xProd].GetValue<String>('data'); //
          vQryAtualiza.ParamByName('pHrSeparacao').Value :=
            pJsonArray.Items[xColeta].GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('pTerminal').Value :=
            pJsonArray.Items[xColeta].GetValue<String>('terminal');

          // vQryAtualiza.ParamByName('pQtdeRes').Value        := pJsonArray.Items[xColeta].GetValue<Integer>('demanda'); //vQtdConferida;
          vQryAtualiza.ParamByName('pQtdSuprida').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // vQtdConferida;
          vQryAtualiza.ParamByName('poperquantidade').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // vQtdConferida;
          vQryAtualiza.ParamByName('poperqtdsuprida').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // vQtdConferida;

          vQtdConferida := 0;
          // End;
          // Gravar acompanhamento da operacao para an�lise de resultados
          vQryAtualiza.ParamByName('poperPedidoVolumeId').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('pedidovolumeid');
          vQryAtualiza.ParamByName('poperLoteid').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('loteid');
          // vQry.FieldByName('LoteId').AsInteger;
          vQryAtualiza.ParamByName('poperEnderecoid').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('enderecoid');
          // vQry.FieldByName('EnderecoId').AsInteger;
          vQryAtualiza.ParamByName('poperquantidade').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('demanda');
          // vQry.FieldByName('Quantidade').AsInteger;
          vQryAtualiza.ParamByName('poperqtdsuprida').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('qtdsuprida');
          // pJsonArray.Items[xProd].GetValue<Integer>('quantidade');
          vQryAtualiza.ParamByName('poperUsuarioId').Value :=
            pJsonArray.Items[xColeta].GetValue<Integer>('usuarioid');
          vQryAtualiza.ParamByName('pOperData').Value :=
            FormatDatetime('YYYY-MM-DD',
            StrToDate(pJsonArray.Items[xColeta].GetValue<String>('data')));
          // pJsonArray.Items[xProd].GetValue<String>('data'); //
          vQryAtualiza.ParamByName('pOperHora').Value :=
            pJsonArray.Items[xColeta].GetValue<String>('horariotermino');
          vQryAtualiza.ParamByName('poperestacao').Value :=
            pJsonArray.Items[xColeta].GetValue<String>('terminal');
          vQryAtualiza.ParamByName('poperprocessoetapa').Value :=
            pJsonArray.Items[xColeta].GetValue<String>('processoetapa');

          If DebugHook <> 0 then
            vQryAtualiza.Sql.SaveToFile('AtualizacaoReservar.Sql');
          vQryAtualiza.ExecSQL;
          vQry.Next
        End;
      End;
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Coleta Salva com sucesso!'));

    Except
      ON E: Exception do
      Begin

        vQry.connection.Rollback;

        raise Exception.Create(StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.VolumeExpedicao: TJsonArray;
var
  vQry: TFdQuery;
  JsonVolume: TJsonObject;
begin
  vQry := FConexao.GetQuery;
  vQry.connection := FConexao.DB;
  Result := TJsonArray.Create;
  try
    try
      vQry.Sql.Add(TuEvolutConst.SqlVolumeEmExpedicao);
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('ExpedicaoVOlume');
      vQry.Open();
      if vQry.IsEmpty() then
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          TuEvolutConst.QrySemDados))
      Else
        While Not vQry.Eof do
        Begin
          JsonVolume := TJsonObject.Create;
          JsonVolume.AddPair('pedidoid',
            TJsonNumber.Create(vQry.FieldByName('PedidoId').AsInteger));
          JsonVolume.AddPair('pedidovolumeid',
            TJsonNumber.Create(vQry.FieldByName('PedidoVolumeId').AsInteger));
          JsonVolume.AddPair('volumetipo',
            TJsonNumber.Create(vQry.FieldByName('VolumeTipo').AsInteger));
          JsonVolume.AddPair('embalagem', vQry.FieldByName('Embalagem')
            .AsString);
          JsonVolume.AddPair('processo', vQry.FieldByName('Processo').AsString);
          JsonVolume.AddPair('razao', vQry.FieldByName('Razao').AsString);
          JsonVolume.AddPair('documentodata', vQry.FieldByName('data')
            .AsString);
          JsonVolume.AddPair('rotaid', vQry.FieldByName('rotaid').AsString);
          Result.AddElement(JsonVolume);
          vQry.Next();
        End;

    Except
      ON E: Exception do
      Begin

        Try
          if Assigned(JsonVolume) then
            JsonVolume.Free;
        Except

        End;

        raise Exception.Create('Processo: VolumeExpedicao - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.VolumeExpedido: TJsonArray;
var
  vQry: TFdQuery;
  JsonVolume: TJsonObject;
begin
  vQry := FConexao.GetQuery;
  vQry.connection := FConexao.DB;
  try
    Result := TJsonArray.Create;
    try
      vQry.Open(TuEvolutConst.SqlVolumemExpedido);
      if vQry.IsEmpty() then
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          TuEvolutConst.QrySemDados))
      Else
        While Not vQry.Eof do
        Begin
          JsonVolume := TJsonObject.Create;
          JsonVolume.AddPair('pedidoid',
            TJsonNumber.Create(vQry.FieldByName('PedidoId').AsInteger));
          JsonVolume.AddPair('pedidovolumeid',
            TJsonNumber.Create(vQry.FieldByName('PedidoVolumeId').AsInteger));
          JsonVolume.AddPair('volumetipo',
            TJsonNumber.Create(vQry.FieldByName('VolumeTipo').AsInteger));
          JsonVolume.AddPair('embalagem', vQry.FieldByName('Embalagem')
            .AsString);
          JsonVolume.AddPair('processo', vQry.FieldByName('Processo').AsString);
          Result.AddElement(JsonVolume);
          vQry.Next();
        End;

    Except
      ON E: Exception do
      Begin

        raise Exception.Create('Processo: VolumeExpedido - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.VolumeLoteSubstituicao(pJsonObjectLotes
  : TJsonObject): TJsonArray;
var
  vQryLoteSubstituicao: TFdQuery;
  xLotes: Integer;
  JsonArrayLotes: TJsonArray;
begin
  vQryLoteSubstituicao := FConexao.GetQuery;
  try
    vQryLoteSubstituicao.connection.StartTransaction;
    try
      vQryLoteSubstituicao.Close;
      vQryLoteSubstituicao.Sql.Clear;
      vQryLoteSubstituicao.Sql.Add('UPdate Est');
      vQryLoteSubstituicao.Sql.Add('  Set Qtde = Qtde - Vl.Quantidade');
      vQryLoteSubstituicao.Sql.Add('From PedidoVolumeLotes Vl');
      vQryLoteSubstituicao.Sql.Add
        ('Inner join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId');
      vQryLoteSubstituicao.Sql.Add
        ('Inner join Estoque Est On Est.LoteId = Vl.LoteId and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = 6');
      vQryLoteSubstituicao.Sql.Add
        ('Where Vl.PedidoVolumeId = :pPedidoVolumeID And Pl.ProdutoId = :pProdutoId');
      vQryLoteSubstituicao.ParamByName('pPedidoVolumeId').Value :=
        pJsonObjectLotes.GetValue<Integer>('pedidovolumeid');
      vQryLoteSubstituicao.ParamByName('pProdutoId').Value :=
        pJsonObjectLotes.GetValue<Integer>('produtoid');
      vQryLoteSubstituicao.ExecSQL;

      vQryLoteSubstituicao.Close;
      vQryLoteSubstituicao.Sql.Clear;
      vQryLoteSubstituicao.Sql.Add('Delete Vl');
      vQryLoteSubstituicao.Sql.Add('From PedidoVolumeLotes Vl');
      vQryLoteSubstituicao.Sql.Add
        ('Inner join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId');
      vQryLoteSubstituicao.Sql.Add
        ('Where Vl.PedidoVolumeId = :pPedidoVolumeId And');
      vQryLoteSubstituicao.Sql.Add('      Pl.ProdutoId = :pProdutoId');
      vQryLoteSubstituicao.ParamByName('pPedidoVolumeId').Value :=
        pJsonObjectLotes.GetValue<Integer>('pedidovolumeid');
      vQryLoteSubstituicao.ParamByName('pProdutoId').Value :=
        pJsonObjectLotes.GetValue<Integer>('produtoid');
      vQryLoteSubstituicao.ExecSQL;
      JsonArrayLotes := pJsonObjectLotes.GetValue<TJsonArray>('lotes');
      for xLotes := 0 to Pred(JsonArrayLotes.Count) do
      Begin
        vQryLoteSubstituicao.Close;
        vQryLoteSubstituicao.Sql.Clear;
        vQryLoteSubstituicao.Sql.Add
          ('Declare @PedidoVolumeId Integer = :pPedidoVolumeId');
        vQryLoteSubstituicao.Sql.Add('Declare @LoteId Integer = :pLoteId');
        vQryLoteSubstituicao.Sql.Add
          ('Declare @EnderecoId Integer = :pEnderecoId');
        vQryLoteSubstituicao.Sql.Add
          ('Declare @quantidade Integer  = :pQuantidade');
        vQryLoteSubstituicao.Sql.Add
          ('Declare @EmbalagemPadrao Integer = :pEmbalagemPadrao');
        vQryLoteSubstituicao.Sql.Add
          ('Declare @UsuarioId Integer = :pUsuarioId');
        vQryLoteSubstituicao.Sql.Add
          ('Declare @terminal Varchar(50) = :pTerminal');
        vQryLoteSubstituicao.Sql.Add
          ('Insert Into PedidoVolumeLotes (PedidoVolumeId, LoteId,');
        vQryLoteSubstituicao.Sql.Add
          ('       EnderecoId, EstoqueTipoId, Quantidade, EmbalagemPadrao,');
        vQryLoteSubstituicao.Sql.Add
          ('       QtdSuprida, DtInclusao, HrInclusao, Terminal, UsuarioId) Values (');
        vQryLoteSubstituicao.Sql.Add
          ('  @PedidoVolumeId, @LoteId, @EnderecoId, 4,');
        vQryLoteSubstituicao.Sql.Add
          ('  @Quantidade, @EmbalagemPadrao, @quantidade,');
        vQryLoteSubstituicao.Sql.Add
          ('  (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
        vQryLoteSubstituicao.Sql.Add
          ('  (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),');
        vQryLoteSubstituicao.Sql.Add('  @Terminal, @usuarioId)');
        vQryLoteSubstituicao.ParamByName('pPedidoVolumeId').Value :=
          JsonArrayLotes.Items[xLotes].GetValue<Integer>('pedidovolumeid');
        vQryLoteSubstituicao.ParamByName('pLoteId').Value :=
          JsonArrayLotes.Items[xLotes].GetValue<Integer>('loteid');
        vQryLoteSubstituicao.ParamByName('pEnderecoId').Value :=
          JsonArrayLotes.Items[xLotes].GetValue<Integer>('enderecoid');
        vQryLoteSubstituicao.ParamByName('pQuantidade').Value :=
          JsonArrayLotes.Items[xLotes].GetValue<Integer>('quantidade');
        vQryLoteSubstituicao.ParamByName('pEmbalagemPadrao').Value :=
          JsonArrayLotes.Items[xLotes].GetValue<Integer>('embalagempadrao');
        vQryLoteSubstituicao.ParamByName('pUsuarioId').Value :=
          pJsonObjectLotes.GetValue<Integer>('usuarioid');
        vQryLoteSubstituicao.ParamByName('pTerminal').Value :=
          pJsonObjectLotes.GetValue<String>('terminal');
        if DebugHook <> 0 then
          vQryLoteSubstituicao.Sql.SaveToFile('PutSubstituirLote.Sql');
        vQryLoteSubstituicao.ExecSQL;
      End;
      vQryLoteSubstituicao.Close;
      vQryLoteSubstituicao.Sql.Clear;
      vQryLoteSubstituicao.Sql.Add
        ('Declare @PedidoVolumeId Integer = :pPedidoVolumeId');
      vQryLoteSubstituicao.Sql.Add('Declare @ProdutoId Integer = :pProdutoId');
      vQryLoteSubstituicao.Sql.Add('UPdate Est');
      vQryLoteSubstituicao.Sql.Add('  Set Qtde = Qtde + Vl.Quantidade');
      vQryLoteSubstituicao.Sql.Add('From PedidoVolumeLotes Vl');
      vQryLoteSubstituicao.Sql.Add
        ('Inner join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId');
      vQryLoteSubstituicao.Sql.Add
        ('Inner join Estoque Est On Est.LoteId = Vl.LoteId and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = 6');
      vQryLoteSubstituicao.Sql.Add
        ('Where Vl.PedidoVolumeId = @PedidoVolumeId And Pl.ProdutoId = @ProdutoId');
      vQryLoteSubstituicao.Sql.Add('');
      vQryLoteSubstituicao.Sql.Add
        ('Insert Estoque (LoteId, EnderecoId, EstoqueTipoId, Qtde, DtInclusao, HrInclusao, UsuarioIdInc)');
      vQryLoteSubstituicao.Sql.Add
        ('Select Vl.LoteId, Vl.EnderecoId, 6, Vl.Quantidade, Vl.DtInclusao, Vl.HrInclusao, Vl.UsuarioId');
      vQryLoteSubstituicao.Sql.Add('From PedidoVolumeLotes Vl');
      vQryLoteSubstituicao.Sql.Add
        ('Inner join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId');
      vQryLoteSubstituicao.Sql.Add
        ('Left join Estoque Est On Est.LoteId = Vl.LoteId and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = 6');
      vQryLoteSubstituicao.Sql.Add
        ('Where Vl.PedidoVolumeId = @PedidoVolumeId And Pl.ProdutoId = @ProdutoId and Est.LoteId Is Null');
      vQryLoteSubstituicao.ParamByName('pPedidoVolumeId').Value :=
        pJsonObjectLotes.GetValue<Integer>('pedidovolumeid');
      vQryLoteSubstituicao.ParamByName('pProdutoId').Value :=
        pJsonObjectLotes.GetValue<Integer>('produtoid');
      vQryLoteSubstituicao.ExecSQL;
      vQryLoteSubstituicao.connection.Commit;
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Ok',
        'Substituicao com sucesso!'));
    Except
      ON E: Exception do
      Begin
        vQryLoteSubstituicao.connection.Rollback;
        vQryLoteSubstituicao.Close;

        raise Exception.Create('Processo: Volumes Lotes Substitui��o - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQryLoteSubstituicao.Close;
  end;
end;

function TServicePedidoVolume.VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId,
  pZonaId, pPrintTag, pEmbalagem: Integer): TJsonArray;
var
  vQry: TFdQuery;
begin
  vQry := FConexao.GetQuery;
  vQry.connection := FConexao.DB;
  try
    try
      vQry.Sql.Add(TuEvolutConst.SqlVolumeParaEtiquetas);
      vQry.ParamByName('pPedidoId').Value := pPedidoId;
      vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      vQry.ParamByName('pZonaId').Value := pZonaId;
      vQry.ParamByName('pPrintTag').Value := pZonaId;
      vQry.ParamByName('pEmbalagem').Value := pZonaId;
      vQry.Open;
      Result := vQry.ToJsonArray();

    Except
      ON E: Exception do
      Begin

        raise Exception.Create('Processo: Volumes para Etiquetas - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

function TServicePedidoVolume.GetVolumeRegistrarExpedicao(pPedidoVolumeId
  : Integer): TJsonArray;
var
  vQry: TFdQuery;
begin
  vQry := FConexao.GetQuery;
  Result := TJsonArray.Create;
  try
    try
      vQry.Sql.Add(TuEvolutConst.SqlVolumeRegistrarExpedicao);
      vQry.ParamByName('pPedidoVolumeId').Value := pPedidoVolumeId;
      if DebugHook <> 0 then
        vQry.Sql.SaveToFile('VolumeRegistrarExpedicao.Sql');
      vQry.Open;
      if (vQry.IsEmpty) then
        Result.AddElement(TJsonObject.Create(tJsonPair.Create('Erro',
          TuEvolutConst.QrySemDados)))
      Else
        Result := vQry.ToJsonArray;
    Except
      ON E: Exception do
      Begin
        raise Exception.Create('Processo: GetVolumeRegistrarExpedicao - ' +
          StringReplace(E.Message,
          '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
          '', [rfReplaceAll]));
      End;
    end;
  finally
    vQry.Close;
  end;
end;

end.
