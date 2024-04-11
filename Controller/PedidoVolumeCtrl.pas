{
   PedidoVolumeCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit PedidoVolumeCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     PedidoVolumeClass, Rest.Json, System.Json, Rest.Types;

Type

  TPedidoVolumeCtrl = Class
  Private
    //Fun��es de Valida��o
    PedidoVolume      : TPedidoVolume;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas P�blica (CRUD)
    Function VerificaDados(ObjPedidoVolume : TPedidoVolume) : Boolean;
    Function GetPedidoVolumeSeparacao(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TPedidoVolume>;
    Function GetPedidoVolumeSeparacaoJson(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pShowErro : Integer = 1) : TJsonArray;

    Function GetVolume(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pSequencia : Integer = 0; pOrdem : Integer = 0; pEmbalagem : String = 'T'; pZonaId : Integer = 0) : tJsonArray; //Embalagem: <T>odos  <F>racioando  <B>ox Cxa Fechada
    Function GetOpenVolumeParaSeparacao(pEmbalagemId, pPedidoVolumeId, pUsuarioId : Integer) : tJsonArray;
    Function GetVolumeRegistrarExpedicao(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetVolumePrintTag(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pSequencia : Integer = 0; pOrdem : Integer = 0; pZonaId : Integer = 0; pPrintTag : Integer = 2; pEmbalagem : Integer = 2) : tJsonArray; //Embalagem: <T>odos  <F>racioando  <B>ox Cxa Fechada
    Function GetVolumeProdutos(pPedidoVolumeId : Integer): tJsonArray;
    Function GetVolumeProdutosReconferencia(pPedidoVolumeId : Integer): tJsonArray;
    Function GetVolumeLotes(pPedidoVolumeId : Integer): tJsonArray;

    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelPedidoVolume : Boolean;
    Function MapaSeparacao(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0) : tjsonArray;
    Function VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId, pZonaId, pPrintTag, pEmbalagem : Integer) : tjsonArray;
    Function PrintEtiquetaPorRua(pJsonEtiqueta : TJsonObject) : TJsonArray;
    Function EtiquetasPorVolume(pPedidoVolumeId : Integer) : tjsonArray;
    Function IdentificaVolumeCxaFechada(pPedidoVolumeId : Integer) : TJsonArray;
    Function RegistrarDocumentoEtapa(pDocumentoEtapaid : Integer) : Boolean;
    Function CaixaSeparacao(pCaixaEmbalagemId : Integer) : Boolean;
    Function RegistrarDocumentoEtapaComBaixaEstoque(pDocumentoEtapaid : Integer) : TJsonArray;
    Function RegistrarDocumentoEtapaComBaixaEstoqueJson(pDocumentoEtapaid : Integer) : TJsonArray;
    Function RegistrarDocumentoEtapaSemBaixaEstoqueJson(pDocumentoEtapaid : Integer) : TJsonArray;
    Function VolumeExpedicao : TJsonArray;
    Function VolumeExpedido  : TJsonArray;
    Function AtualizarConferencia(pJsonArray : TJsonArray) : TjsonArray;
    Function FinalizarConferenciaComRegistro(pJsonFinalizacao : TJsonObject) : TJsonArray;
    Function CancelarVolume(pJsonObject : TJsonObject) : TjsonArray;
    Function GetVolumeEtapas(pPedidoVolumeId : Integer) : TJsonArray;
    Function GerarVolumeExtra(pJsonArrayProdutoCorte : TJsonArray) : TJsonArray;
    Function GetMapaSeparacaoLista (pPedidoIdInicial, pPedidoIdFinal, pPedidoVolumeIdInicial : Integer;
                                    pPedidoVolumeIdFinal, pRotaId, pCodPessoaErp : Integer;
                                    pDtPedidoInicial, pDtPedidoFinal : TDateTime) : TJsonArray;
    Function GetDshCheckOut(pDataInicialPedido, pDataFinalPedido,
         pDataInicialProducao, pDataFinalProducao : TDateTime; pUsuarioId, pEmbalagemId : Integer) : TJsonArray;
    Function GetAuditoriaVolumes( pDtInicio, pDtFInal : TDateTime; pPedidoId : Integer; pDocumentoNr : String;
             pRotaId, pDestinatario, pProcessoId, pCodProduto, pZonaId, pTipo, pUsuarioId : Integer ) : TJsonArray;
    Function GetAuditoriaCortes( pDtInicio, pDtFInal : TDateTime; pPedidoId : Integer; pDocumentoNr : String;
             pRotaId, pDestinatario, pProcessoId, pCodProduto, pLinhaId, pTipo, pUsuarioId : Integer) : TJsonArray;
    Function VolumeLoteSubstituicao(pJsonObjectLoteSubstituto : TJsonObject) : TJsonArray;
    Function DshVolumeEvolucao_Quantidade(aParams : TDictionary<String, String>) : TJsonArray;
    Function DshVolumeEvolucao_Unidades(aParams : TDictionary<String, String>) : TJsonArray;
    Function ResetSeparacao : TJsonArray;
    Function GetVolumeComDivergencia(pPedidoVolumeId : Integer) : TJsonArray;
    Function GetPedidoVolumeProduto(pPedidoid, pCodProduto : integer) : TJsonArray;
    function GetProducaoDiariaPorLoja(pDataInicial, pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
    function GetProducaoDiariaPorRota(pDataInicial, pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
    Function GetProducaoDiariaPorRua(pDataInicial, pDataFinal : TDateTime; pEstruturaId : Integer) : TJsonObject;
    Function GetProducaoDiariaPorSetor(pDataInicial, pDataFinal : TDateTime; pEstruturaId : Integer) : TJsonObject;
    Function GetVolumeConsulta(pDataInicial, pDataFinal : TDateTime; pPedidoId, pPedidoVolumeId : Integer;
                                  pDocumentoNr : String; pSequencia, pCodPessoa, pProcessoId, pRotaId, pCodProduto,
                                  pZonaId, pPendente : Integer; pEmbalagem : String) : TJsonArray;
    Function GetVolumeProdutosParaSeparacao(pPedidoId, pPedidoVolumeId : Integer) : TJsonArray;
    Function GetVolumeEAn(pPedidoVolumeId : Integer) : TJsonArray;
    Function SalvarColetaComRegistro(pJsonColetaRegistro : TJsonObject) : TJsonArray;
    Function SaveApanheProduto(pJsonApanhe: TJsonArray): TJsonArray;
    Function SalvarUltimoEnderecoColetado(pPedidoVolumeId, pEnderecoId : Integer) : TJsonArray;
    Function GetPedidoCxaFechadaCheckOut(pPedidoVolumeId : Integer) : TJsonObject;

    Property ObjPedidoVolume : TPedidoVolume Read PedidoVolume Write PedidoVolume;
  End;

implementation

{ tCtrlPedidoVolume }

uses PedidoVolumeDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tPedidoVolumeCtrl.VerificaDados(ObjPedidoVolume : TPedidoVolume) : Boolean;
Begin
  Result := False;
  With ObjPedidoVolume do Begin
    if ObjPedidoVolume.Numsequencia = 0 then
       raise Exception.Create('Informe o N�mero de Identifica��o da caixa!');
    if (ObjPedidoVolume.VolumeEmbalagem.EmbalagemId <= 0) then
       raise Exception.Create('Informe a tipo para as propriedades da Caixa!');
  End;
  Result := True;
End;

function TPedidoVolumeCtrl.GetVolumeEAn(pPedidoVolumeId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.GetVolumeEan(pPedidoVolumeId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoVolumeDAO.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End
  End;
end;

function TPedidoVolumeCtrl.GetVolumeEtapas(pPedidoVolumeId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetVolumeEtapas(pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.VolumeExpedicao: TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.VolumeExpedicao;
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.VolumeExpedido: TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.VolumeExpedido;
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId, pZonaId, pPrintTag, pEmbalagem : Integer): tjsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.VolumeParaEtiquetas(pPedidoId, pPedidoVolumeId, pZonaId, pPrintTag, pEmbalagem );
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.AtualizarConferencia(
  pJsonArray: TJsonArray): TjsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    Result := ObjPedidoVolumeDAO.AtualizarConferencia( pJsonArray );
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeCtrl.CaixaSeparacao(pCaixaEmbalagemId: Integer): Boolean;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    JsonArrayRetorno := ObjPedidoVolumeDAO.CaixaSeparacao(pCaixaEmbalagemId);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
       Result := False
    Else
       Result := True;
    ObjPedidoVolumeDAO.Free;
  Except Begin
    ObjPedidoVolumeDAO.Free;
    Result := False;
    End;
  End;
end;

function TPedidoVolumeCtrl.CancelarVolume(pJsonObject: TJsonObject): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.CancelarVolume( pJsonObject );
  ObjPedidoVolumeDAO.Free;
end;

constructor TPedidoVolumeCtrl.Create;
begin
  PedidoVolume      := TPedidoVolume.Create;
end;

function TPedidoVolumeCtrl.DelPedidoVolume : Boolean;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume.PedidoVolumeId := Self.PedidoVolume.PedidoVolumeId;
  Result := ObjPedidoVolumeDAO.Delete;
  if Result then
     Self.ObjPedidoVolume.PedidoVolumeId := 0;
  ObjPedidoVolumeDAO.Free;
end;

destructor TPedidoVolumeCtrl.Destroy;
begin
  PedidoVolume.Free;
  inherited;
end;

function TPedidoVolumeCtrl.DshVolumeEvolucao_Quantidade(
  aParams: TDictionary<String, String>): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.DshVolumeEvolucao_Quantidade(aParams);
    ObjPedidoVolumeDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.DshVolumeEvolucao_Unidades(
  aParams: TDictionary<String, String>): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.DshVolumeEvolucao_Unidades(aParams);
    ObjPedidoVolumeDAO.Free;
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.EtiquetasPorVolume(
  pPedidoVolumeId: Integer): tjsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.EtiquetasPorVolume(pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.FinalizarConferenciaComRegistro(
  pJsonFinalizacao: TJsonObject): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    Result := ObjPedidoVolumeDAO.FinalizarConferenciaComRegistro( pJsonFinalizacao );
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeCtrl.GetVolume(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pSequencia : Integer = 0; pOrdem : Integer = 0; pEmbalagem : String = 'T'; pZonaId : Integer = 0): tJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetVolume(pPedidoId, pPedidoVolumeId, pSequencia, pOrdem, pEmbalagem, pZonaId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetVolumeComDivergencia(
  pPedidoVolumeId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetVolumeComDivergencia(pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetVolumeConsulta(pDataInicial,
  pDataFinal: TDateTime; pPedidoId, pPedidoVolumeId: Integer;
  pDocumentoNr: String; pSequencia, pCodPessoa, pProcessoId, pRotaId,
  pCodProduto, pZonaId, pPendente : Integer; pEmbalagem : String): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.GetVolumeConsulta(pDataInicial, pDataFinal, pPedidoId, pPedidoVolumeId,
              pDocumentoNr, pSequencia, pCodPessoa, pProcessoId, pRotaId, pCodProduto, pZonaId, pPendente, pEmbalagem);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create();
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.GetVolumePrintTag(pPedidoId, pPedidoVolumeId,
  pSequencia, pOrdem, pZonaId, pPrintTag, pEmbalagem: Integer): tJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetVolumePrintTag(pPedidoId, pPedidoVolumeId, pSequencia, pOrdem, pZonaId, pPrintTag, pEmbalagem);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetVolumeProdutos(pPedidoVolumeId : Integer): tJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetVolumeProdutos(pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetVolumeProdutosParaSeparacao(pPedidoId,
  pPedidoVolumeId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.GetVolumeProdutosParaSeparacao(pPedidoId, pPedidoVolumeId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeCtrl.GetVolumeProdutosReconferencia(
  pPedidoVolumeId: Integer): tJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetVolumeProdutosReconferencia(pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetVolumeRegistrarExpedicao(
  pPedidoVolumeId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.GetVolumeRegistrarExpedicao(pPedidoVolumeId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TPedidoVolumeCtrl.IdentificaVolumeCxaFechada(
  pPedidoVolumeId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  //ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.IdentificaVolumeCxaFechada(pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetVolumeLotes(pPedidoVolumeId : Integer): tJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetVolumeLotes(pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.VolumeLoteSubstituicao(
  pJsonObjectLoteSubstituto: TJsonObject): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.VolumeLoteSubstituicao(pJsonObjectLoteSubstituto);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GerarVolumeExtra(pJsonArrayProdutoCorte : TJsonArray) : TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.GerarVolumeExtra(pJsonArrayProdutoCorte);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetAuditoriaCortes(pDtInicio, pDtFInal: TDateTime;
  pPedidoId: Integer; pDocumentoNr: String; pRotaId, pDestinatario, pProcessoId,
  pCodProduto, pLinhaId, pTipo, pUsuarioId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetAuditoriaCortes(pDtInicio, pDtFInal, pPedidoId,
            pDocumentoNr, pRotaId, pDestinatario, pProcessoId, pCodProduto, pLinhaId, pTipo, pUsuarioId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetAuditoriaVolumes(pDtInicio, pDtFInal: TDateTime;
  pPedidoId: Integer; pDocumentoNr: String; pRotaId, pDestinatario, pProcessoId,
  pCodProduto, pZonaId, pTipo, pUsuarioId : Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetAuditoriaVolumes(pDtInicio, pDtFInal, pPedidoId,
            pDocumentoNr, pRotaId, pDestinatario, pProcessoId, pCodProduto, pZonaId, pTipo, pUsuarioId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetDshCheckOut(pDataInicialPedido, pDataFinalPedido,
         pDataInicialProducao, pDataFinalProducao : TDateTime;
         pUsuarioId, pEmbalagemId: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetDshCheckOut(pDataInicialPedido, pDataFinalPedido,
            pDataInicialProducao, pDataFinalProducao, pUsuarioId, pEmbalagemId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetMapaSeparacaoLista(pPedidoIdInicial,
  pPedidoIdFinal, pPedidoVolumeIdInicial, pPedidoVolumeIdFinal, pRotaId,
  pCodPessoaErp : Integer; pDtPedidoInicial,
  pDtPedidoFinal: TDateTime): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.GetMapaSeparacaoLista(pPedidoIdInicial, pPedidoIdFinal, pPedidoVolumeIdInicial,
            pPedidoVolumeIdFinal, pRotaId, pCodPessoaErp, pDtPedidoInicial, pDtPedidoFinal);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetPedidoCxaFechadaCheckOut(
  pPedidoVolumeId: Integer): TJsonObject;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Try
      Result := ObjPedidoVolumeDAO.GetPedidoCxaFechadaCheckOut(pPedidoVolumeId);
    Except On E: Exception do Begin
      Result := TJsonObject.Create;
      Result := TJsonObject.Create.AddPair('Erro', E.Message);
      End;
    End;
  Finally
    ObjPedidoVolumeDAO.Free;
  End;
end;

function TPedidoVolumeCtrl.GetPedidoVolumeProduto(pPedidoid,
  pCodProduto: integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Try
    Result := ObjPedidoVolumeDAO.GetPedidoVolumeProduto(pPedidoid, pCodProduto);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoVolumeDAO.Free;
  End;
  End;
end;

Function tPedidoVolumeCtrl.GetPedidoVolumeSeparacao(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TPedidoVolume>;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
    ReturnJson     : TJsonArray;
    jsonPedidoVolume   : tjsonObject;
    xItensPedidoVolume : Integer;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume.PedidoVolumeId := ObjPedidoVolume.PedidoVolumeId;
  ReturnJson := ObjPedidoVolumeDAO.GetPedidoVolumeSeparacao(pPedidoId, pPedidoVolumeId, pShowErro);
  Result     := TObjectList<TPedidoVolume>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensPedidoVolume := 0;
     repeat
       jsonPedidoVolume := tJsonObject.Create;
       jsonPedidoVolume := ReturnJson.Items[xItensPedidoVolume] as TJSONObject;
       ObjPedidoVolume  := ObjPedidoVolume.JsonToClass(JsonPedidoVolume.ToString());
       Result.Add(ObjPedidoVolume);
       jsonPedidoVolume := Nil;
       jsonPedidoVolume.DisposeOf;
       Inc(xItensPedidoVolume);
     until (xItensPedidoVolume > Pred(ReturnJson.Count));
  End
  Else Begin
    ReturnJson := Nil;
    ObjPedidoVolumeDAO.Free;
    If pPedidoId = 0 then
       Raise Exception.Create('Volume(s) n�o encontrado!')
    Else Raise Exception.Create('Volume(s) n�o encontrado para o pedido!');
  End;
  ReturnJson := Nil;
  ObjPedidoVolumeDAO.Free;
End;

function TPedidoVolumeCtrl.GetPedidoVolumeSeparacaoJson(pPedidoId,
  pPedidoVolumeId, pShowErro: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
    ReturnJson     : TJsonArray;
    jsonPedidoVolume   : tjsonObject;
    xItensPedidoVolume : Integer;
begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume.PedidoVolumeId := ObjPedidoVolume.PedidoVolumeId;
  Result := ObjPedidoVolumeDAO.GetPedidoVolumeSeparacao(pPedidoId, pPedidoVolumeId, pShowErro);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetProducaoDiariaPorRua(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Try
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    Result := ObjPedidoVolumeDAO.GetProducaoDiariaPorRua(pDataInicial, pDataFinal, pEstruturaId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.GetProducaoDiariaPorLoja(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Try
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    Result := ObjPedidoVolumeDAO.GetProducaoDiariaPorLoja(pDataInicial, pDataFinal, pEstruturaId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.GetProducaoDiariaPorRota(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Try
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    Result := ObjPedidoVolumeDAO.GetProducaoDiariaPorRota(pDataInicial, pDataFinal, pEstruturaId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.GetProducaoDiariaPorSetor(pDataInicial,
  pDataFinal: TDateTime; pEstruturaId: Integer): TJsonObject;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Try
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    Result := ObjPedidoVolumeDAO.GetProducaoDiariaPorSetor(pDataInicial, pDataFinal, pEstruturaId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.MapaSeparacao(pPedidoId : Integer = 0; pPedidoVolumeId : Integer = 0) : tJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.MapaSeparacao(pPedidoId, pPedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.GetOpenVolumeParaSeparacao(pEmbalagemId, pPedidoVolumeId,
  pUsuarioId: Integer) : tJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.GetOpenVolumeParaSeparacao(pEmbalagemId, pPedidoVolumeId, pUsuarioId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.PrintEtiquetaPorRua(
  pJsonEtiqueta: TJsonObject): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.PrintEtiquetaPorRua(pJsonEtiqueta);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.RegistrarDocumentoEtapa(
  pDocumentoEtapaid: Integer): Boolean;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  ObjPedidoVolumeDAO.RegistrarDocumentoEtapa(pDocumentoEtapaId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.RegistrarDocumentoEtapaComBaixaEstoque(
  pDocumentoEtapaid: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
    Result := ObjPedidoVolumeDAO.RegistrarDocumentoEtapaComBaixaEstoque(pDocumentoEtapaId);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjPedidoVolumeDAO.Free;
    End;
  End;
end;

function TPedidoVolumeCtrl.RegistrarDocumentoEtapaComBaixaEstoqueJson( pDocumentoEtapaid: Integer ): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.RegistrarDocumentoEtapaComBaixaEstoque(pDocumentoEtapaId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.RegistrarDocumentoEtapaSemBaixaEstoqueJson(
  pDocumentoEtapaid: Integer): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.RegistrarDocumentoEtapaSemBaixaEstoque(pDocumentoEtapaId);
  ObjPedidoVolumeDAO.Free;
end;

function TPedidoVolumeCtrl.ResetSeparacao: TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.ResetSeparacao(ObjPedidovolume.PedidoVolumeId);
  ObjPedidoVolumeDAO.Free;
end;

Function tPedidoVolumeCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  ObjPedidoVolumeDAO.ObjPedidoVolume := ObjPedidoVolume;
  Result := ObjPedidoVolumeDAO.Salvar;
  ObjPedidoVolumeDAO.Free;
End;

function TPedidoVolumeCtrl.SalvarUltimoEnderecoColetado(pPedidoVolumeId,
  pEnderecoId: Integer) : TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
  Result := ObjPedidoVolumeDAO.SalvarUltimoEnderecoColetado(pPedidoVolumeId, pEnderecoId);
  ObjPedidoVolumeDAO.Free;
end;

Function TPedidoVolumeCtrl.SalvarColetaComRegistro(pJsonColetaRegistro : TJsonObject) : TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.SalvarColetaComRegistro(pJsonColetaRegistro);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoVolumeDAO.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
End;

function TPedidoVolumeCtrl.SaveApanheProduto(pJsonApanhe: TJsonArray): TJsonArray;
Var ObjPedidoVolumeDAO : TPedidoVolumeDAO;
Begin
  Try
    ObjPedidoVolumeDAO := TPedidoVolumeDAO.Create;
    Result := ObjPedidoVolumeDAO.SaveApanheProduto(pJsonApanhe);
    ObjPedidoVolumeDAO.Free;
  Except On E: Exception do Begin
    ObjPedidoVolumeDAO.Free;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

End.
