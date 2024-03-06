{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit EntradaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     EntradaClass, Rest.Json, System.Json, Rest.Types, EntradaItensCtrl;

Type
  TipoConsulta = (Resumida, Completa);
  TEntradaCtrl = Class
  Private
    //Fun��es de Valida��o
    FEntrada      : TEntrada;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas P�blica (CRUD)
    Function CancelarEntrada(pJsonPedidoCancelar : TJsonObject) : Boolean;
    Function VerificaDados(ObjEntrada : TEntrada) : Boolean;
    Function GetHeader(pEntradaId, pAgrupamentoId : Integer) : TJsonArray;
    Function GetEntrada(pEntradaId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = '';
                        pRazao : String = ''; pRegistroERP : String = ''; pPendente : Integer = 0; pShowErro : Integer = 1) : TObjectList<TEntradaCtrl>;
    Function GetEntradaBasica(pEntradaId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = '';
                        pRazao : String = ''; pRegistroERP : String = ''; pDtNotaFiscal : TDateTime = 0; pPendente : Integer = 0; pAgrupamentoId : Integer = 0; pShowErro : Integer = 0) : TjsonArray;
    Function GetEspelho(pPedidoId : Integer; pDocumentoNr, pRegistroERP : String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckDtFin : TDateTime; pDivergencia, pShowErro : Integer) : TJsonArray;
    Function GetEntradaOcorrencia(pPedidoId : Integer; pDocumentoNr, pRegistroERP : String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckDtFin : TDateTime) : TJsonArray;
    Function GetResumoCheckIn(pEntradaId : Integer) : TJsonArray;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Function DelEntrada(pJsonPedidoDelete : TJsonObject) : Boolean;
    Function SalvarCheckInItem(pAgrupamentoId : Integer; pjsonEntrada : TJsonObject) : TJsonObject;
    Function FinalizarCheckIn(pjsonEntrada : TJsonObject) : Boolean;
    Property Entrada : TEntrada Read FEntrada Write FEntrada;
    Function MontarPaginacao : Integer;
    Function RegistrarDocumentoEtapa(pDocumentoEtapaid : Integer) : Boolean;
    Function GetPlanilhaCega(pEntradaId : Integer) : TJsonArray;
    Function GetMovimentacao(pPedidoId : Integer; pDataInicial, pDataFinal : TDateTime; pProdutoId : Integer) : TJsonArray;
    Function GetRelRecebimento(pPedidoId: Integer; pCodigoERP, pPessoaId : Integer; pDataIni, pDataFin : TDateTime;
                               pDocumentoNr, pRazao, pRegistroERP : String; pProcessoId : Integer; pCodProduto : Int64; pPedidoPendente : Integer) : TJsonArray;
    Function GetEtiquetaArmazenagem(pDtInicio, pDtTermino : TDateTime;
             pPedidoId : Integer; pDocumentoNr : String; pZonaId, pCodProduto, pSintetico : Integer) : TjsonArray;
    Function GetRelDshRecebimentos(pDataInicial, pDataFinal : TDateTime) : TjsonArray;
    Function ExcluirPreEntrada(pJsonArray : TjsonArray) : TJsonArray;
    Function GetValidaQtdCheckIn(pPedidoid, pCodProduto : Integer) : TjsonArray;
    Function GetProdutoSemPicking(pDataInicial, pDataFinal : TDateTime; pPedidoId, pCodPessoaERP : Integer; pDocumentoNr : String) : TJsonArray;
    Function GetEntradaProduto(pEntradaId, pAgrupamentoId : Integer) : TJsonArray;
    Function GetEntradaLotes(pEntradaId, pAgrupamentoId, pCodProduto, pLoteId : Integer) : TJsonArray;
    Function SalvarAgrupamento(pAgrupamentojsonArray : TJsonArray) : TjsonArray;
    Function GetAgrupamentoLista(pAgrupamentoId, pCodPessoa : Integer) : TJsonArray;
    Function GetAgrupamentoPedido(pAgrupamentoId, pPedidoId : Integer) : TJsonArray;
    Function GetAgrupamentoFatorarLoteXML(pAgrupamentoId : Integer) : TjsonArray;
    Function GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId : Integer) : TjsonArray;
    Function DeleteAgrupamento(pAgrupamentoId, pPedidoId : Integer) : TJsonArray;
    Function GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId, pCodProduto : Integer) : TJsonArray;
    Function GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId, pCodProduto : Integer) : TJsonArray;
    Function GetAcompanhamentoCheckIn(pPedidoId, pCodPessoaERP : Integer; pDataInicial, pDataFinal : TDateTime) : TJsonArray;
  End;

implementation

{ tCtrlEntrada }

uses uEntradaDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tEntradaCtrl.VerificaDados(ObjEntrada : TEntrada) : Boolean;
Begin
  Result := False;
  With ObjEntrada do Begin
    if OperacaoTipo.OperacaoTipoId = 0 then
       raise Exception.Create('Informe o Tipo da Opera��o!');
    if (Pessoa.PessoaId = 0) then
       raise Exception.Create('Informe o fornecedor!');
  End;
  Result := True;
End;

function TEntradaCtrl.CancelarEntrada(pJsonPedidoCancelar : TJsonObject) : Boolean;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.CancelarEntrada(pJsonPedidoCancelar);
  if Result then
     Self.Entrada.EntradaId := 0;
  ObjEntradaDAO.Free;
end;

constructor TEntradaCtrl.Create;
begin
  FEntrada      := TEntrada.Create;
end;

function TEntradaCtrl.DelEntrada(pJsonPedidoDelete : TJsonObject) : Boolean;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.Delete(pJsonPedidoDelete);
  if Result then
     Self.Entrada.EntradaId := 0;
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.DeleteAgrupamento(pAgrupamentoId,
  pPedidoId: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.DeleteAgrupamento(pAgrupamentoId, pPedidoId);
  ObjEntradaDAO.Free;
end;

destructor TEntradaCtrl.Destroy;
begin
  FreeAndNil(FEntrada);
  inherited;
end;

function TEntradaCtrl.ExcluirPreEntrada(pJsonArray: TjsonArray): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.ExcluirPreEntrada(pJsonArray);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.FinalizarCheckIn(pjsonEntrada: TJsonObject): Boolean;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.FinalizarCheckIn(pjsonEntrada);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.GetAcompanhamentoCheckIn(pPedidoId,
  pCodPessoaERP: Integer; pDataInicial, pDataFinal: TDateTime): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  if (pPedidoId=0) and (pCodPessoaERP=0) and (pDataInicial=0) and (pDataFinal=0) then Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Informe par�metros para a pesquisa.'));
     Exit;
  End;
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetAcompanhamentoCheckIn(pPedidoId, pCodPessoaERP, pDataInicial, pDataFinal);
    ObjEntradaDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    End;
  End;
end;

function TEntradaCtrl.GetAgrupamentoFatorarLoteXML(
  pAgrupamentoId: Integer): TjsonArray;
begin
  Try
    Result := Self.FEntrada.GetAgrupamentoFatorarLoteXML(pAgrupamentoId);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaCtrl.GetAgrupamentoFatorarPedidoLotes(
  pAgrupamentoId: Integer): TjsonArray;
begin
  Try
    Result := Self.FEntrada.GetAgrupamentoFatorarPedidoLotes(pAgrupamentoId);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaCtrl.GetAgrupamentoLista(pAgrupamentoId, pCodPessoa: Integer): TJsonArray;
begin
  Try
    Result := Self.FEntrada.GetAgrupamentoLista(pAgrupamentoId, pCodPessoa);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaCtrl.GetAgrupamentoPedido(pAgrupamentoId,
  pPedidoId: Integer): TJsonArray;
begin
  Try
    Result := Self.FEntrada.GetAgrupamentoPedido(pAgrupamentoId, pPedidoId);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

Function tEntradaCtrl.GetEntrada(pEntradaId : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = '';
                                 pRazao : String = ''; pRegistroERP : String = ''; pPendente : Integer = 0; pShowErro : Integer = 1): TObjectList<TEntradaCtrl>;
Var ReturnJson  : TJsonArray;
    JsonEntrada : TJsonObject;
    xItens      : Integer;
    ObjEntradaCtrl  : TEntradaCtrl;
    vErro       : String;
begin
  Result     := TObjectList<TEntradaCtrl>.Create;
  ReturnJson := Self.FEntrada.GetEntrada(pEntradaId, pPessoaId, pDocumentoNr, pRazao, pRegistroERP, pPendente, 0);
  If (pShowErro= 1) and (ReturnJson.Get(0).tryGetValue<String>('Erro', vErro)) then
     Raise Exception.Create('Erro: '+vErro)
  Else if (ReturnJson.Count >= 1) and (Not ReturnJson.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     xItens := 0;
     repeat
       ObjEntradaCtrl := TEntradaCtrl.Create;
       JsonEntrada := tJsonObject.Create;
       JsonEntrada := ReturnJson.Items[xItens] as TJSONObject;
       ObjEntradaCtrl.FEntrada    := Self.FEntrada.JsonToClass(JsonEntrada.ToString());
       Result.Add(ObjEntradaCtrl);
       JsonEntrada := Nil;
       JsonEntrada.DisposeOf;
       ObjEntradaCtrl := Nil;
       ObjEntradaCtrl.DisposeOf;
       xItens := xItens + 1;
     until (xItens > Pred(ReturnJson.Count));
  End;
  //Else Raise Exception.Create('Registro de Entrada n�o encontrado');
End;

function TEntradaCtrl.GetEntradaBasica(pEntradaId, pPessoaId: Integer;
  pDocumentoNr, pRazao, pRegistroERP: String; pDtNotaFiscal : TDateTime; pPendente, pAgrupamentoId,
  pShowErro: Integer): TjsonArray;
Var vErro       : String;
begin
  Result := Self.FEntrada.GetEntradaBasica(pEntradaId, pPessoaId, pDocumentoNr, pRazao, pRegistroERP, pDtNotaFiscal, pPendente, pAgrupamentoId, 0);
  If (Result.Get(0).tryGetValue<String>('Erro', vErro)) then
     If (pShowErro= 1) then
        Raise Exception.Create('Erro: '+vErro)
end;

function TEntradaCtrl.GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId, pCodProduto: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  if (pPedidoId=0) and (pAgrupamentoId=0) then Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Informe o Id da Entrada ou Agrupamento.'));
     Exit;
  End;
  if (pCodProduto=0) then Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Informe o C�digo do produto!'));
     Exit;
  End;
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetEntradaLoteCheckIn(pPedidoId, pAgrupamentoId, pCodProduto);
    ObjEntradaDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    End;
  End;
end;

function TEntradaCtrl.GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId,
  pCodProduto: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  if (pPedidoId=0) and (pAgrupamentoId=0) then Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Informe o Id da Entrada ou Agrupamento.'));
     Exit;
  End;
  if (pCodProduto=0) then Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Informe o C�digo do produto!'));
     Exit;
  End;
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetEntradaLoteDevolucao(pPedidoId, pAgrupamentoId, pCodProduto);
    ObjEntradaDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    End;
  End;
end;

function TEntradaCtrl.GetEntradaLotes(pEntradaId, pAgrupamentoId, pCodProduto,
  pLoteId: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    //ObjEntradaDAO.Entrada := Entrada;
    Result := ObjEntradaDAO.GetEntradaLotes(pEntradaId, pAgrupamentoId, pCodProduto, pLoteId);
    ObjEntradaDAO.Free;
  Except on E: Exception do begin
    Result := TJsonArray.Create;
    Result.AddElement(TjsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    end;
  End;
end;

function TEntradaCtrl.GetEntradaOcorrencia(pPedidoId: Integer; pDocumentoNr,
  pRegistroERP: String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni,
  pCheckDtFin: TDateTime): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetEntradaOcorrencia(pPedidoId, pDocumentoNr, pRegistroERP, pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckDtFin);
    ObjEntradaDAO.Free;
  Except on E: Exception do begin
    Result := TJsonArray.Create;
    Result.AddElement(TjsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    end;
  End;
end;

function TEntradaCtrl.GetEntradaProduto(pEntradaId, pAgrupamentoId : Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    //ObjEntradaDAO.Entrada := Entrada;
    Result := ObjEntradaDAO.GetEntradaProduto(pEntradaId, pAgrupamentoId);
    ObjEntradaDAO.Free;
  Except on E: Exception do begin
    Result := TJsonArray.Create;
    Result.AddElement(TjsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    end;
  End;
end;

function TEntradaCtrl.GetEspelho(pPedidoId: Integer; pDocumentoNr,
  pRegistroERP: String; pDoctoDataIni, pDoctoDataFin, pCheckInDtIni,
  pCheckDtFin: TDateTime; pDivergencia, pShowErro : Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    ObjEntradaDAO.Entrada := Entrada;
    Result := ObjEntradaDAO.GetEspelho(pPedidoId, pDocumentoNr, pRegistroERP, pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckDtFin, pDivergencia);
    ObjEntradaDAO.Free;
  Except on E: Exception do begin
    Result := TJsonArray.Create;
    Result.AddElement(TjsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    end;
  End;
end;

function TEntradaCtrl.GetEtiquetaArmazenagem(pDtInicio, pDtTermino : TDateTime;
            pPedidoId : Integer; pDocumentoNr : String; pZonaId, pCodProduto, pSintetico : Integer) : TjsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  ObjEntradaDAO.Entrada := Entrada;
  Result := ObjEntradaDAO.GetEtiquetaArmazenagem(pDtInicio, pDtTermino, pPedidoId, pDocumentoNr, pZonaId, pCodProduto, pSintetico);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.GetHeader(pEntradaId,
  pAgrupamentoId: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  if (pEntradaId=0) and (pAgrupamentoId=0) then Begin
     Result := TJsonArray.Create;
     Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Informe o Id da Entrada ou Agrupamento.'));
     Exit;
  End;
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    //ObjEntradaDAO.Entrada := Entrada;
    Result := ObjEntradaDAO.GetHeader(pEntradaId, pAgrupamentoId);
    ObjEntradaDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaCtrl.GetMovimentacao(pPedidoId: Integer; pDataInicial,
  pDataFinal: TDateTime; pProdutoId: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  ObjEntradaDAO.Entrada := Entrada;
  Result := ObjEntradaDAO.GetMovimentacao(pPedidoId, pDataInicial, pDataFinal, pProdutoId);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.GetPlanilhaCega(pEntradaId: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  ObjEntradaDAO.Entrada := Entrada;
  Result := ObjEntradaDAO.GetPlanilhaCega(pEntradaId);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.GetProdutoSemPicking(pDataInicial, pDataFinal: TDateTime;
  pPedidoId, pCodPessoaERP: Integer; pDocumentoNr: String): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  //ObjEntradaDAO.Entrada := Entrada;
  Result := ObjEntradaDAO.GetProdutoSemPicking(pDataInicial, pDataFinal, pPedidoId,
            pCodPessoaERP, pDocumentoNr);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.GetRelDshRecebimentos(pDataInicial,
  pDataFinal: TDateTime): TjsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    ObjEntradaDAO.Entrada := Entrada;
    Result := ObjEntradaDAO.GetRelDshRecebimentos(pDataInicial, pDataFinal);
    ObjEntradaDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    End;
  End;
end;

function TEntradaCtrl.GetRelRecebimento(pPedidoId, pCodigoERP,
  pPessoaId: Integer; pDataIni, pDataFin: TDateTime; pDocumentoNr, pRazao,
  pRegistroERP: String; pProcessoId: Integer; pCodProduto: Int64;
  pPedidoPendente: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.GetRelRecebimento(pPedidoId, pCodigoERP, pPessoaId, pDataIni, pDataFin, pDocumentoNr,
                                          pRazao, pRegistroERP, pProcessoId, pCodProduto, pPedidoPendente);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.GetResumoCheckIn(pEntradaId: Integer): TJsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.GetResumoCheckIn(pEntradaId);
    ObjEntradaDAO.Free;
  Except on E: Exception do begin
    Result := TJsonArray.Create;
    Result.AddElement(TjsonObject.Create.AddPair('Erro', E.Message));
    ObjEntradaDAO.Free;
    end;
  End;
end;

function TEntradaCtrl.GetValidaQtdCheckIn(pPedidoid,
  pCodProduto: Integer): TjsonArray;
Var ObjEntradaDAO : TEntradaDAO;
begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.GetValidaQtdCheckIn(pPedidoid, pCodProduto);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.MontarPaginacao: Integer;
Var ObjEntradaDAO : TEntradaDAO;
Begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.MontarPaginacao.GetValue<integer>('paginacao', 1);
  ObjEntradaDAO.Free;
end;

function TEntradaCtrl.RegistrarDocumentoEtapa(
  pDocumentoEtapaid: Integer): Boolean;
Var ObjEntradaDAO : TEntradaDAO;
Begin
  ObjEntradaDAO := TEntradaDAO.Create;
  ObjEntradaDAO.Entrada.EntradaId := Entrada.EntradaId;
  ObjEntradaDAO.RegistrarDocumentoEtapa(pDocumentoEtapaId);
  ObjEntradaDAO.Free;
end;

Function tEntradaCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var ObjEntradaDAO : TEntradaDAO;
Begin
  ObjEntradaDAO := TEntradaDAO.Create;
  Result := ObjEntradaDAO.Salvar;
  if Result then
     Self.Entrada.EntradaId := 0;
  ObjEntradaDAO.Free;
End;

function TEntradaCtrl.SalvarAgrupamento(
  pAgrupamentojsonArray: TJsonArray): TjsonArray;
Var ObjEntradaDAO : TEntradaDAO;
    ErroJsonArray : TJsonArray;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.SalvarAgrupamento(pAgrupamentojsonArray);
    ObjEntradaDAO.Free;
  Except On E: Exception do Begin
    ErroJsonArray := TJsonArray.Create;
    ErroJsonArray.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

function TEntradaCtrl.SalvarCheckInItem(pAgrupamentoId : Integer; pJsonEntrada: TJsonObject): TJsonObject;
Var ObjEntradaDAO : TEntradaDAO;
begin
  Try
    ObjEntradaDAO := TEntradaDAO.Create;
    Result := ObjEntradaDAO.SalvarCheckInItem(pAgrupamentoId, pJsonEntrada);
    ObjEntradaDAO.Free;
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    End;
  End;
end;

End.

