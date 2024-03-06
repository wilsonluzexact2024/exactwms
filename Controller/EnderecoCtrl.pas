{
   LaboratorioCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit EnderecoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     EnderecoClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TEnderecoCtrl = Class
  Private
    //Fun��es de Valida��o
    FEndereco      : TEndereco;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas P�blica (CRUD)
    Function BloquearEndereco(pEnderecoId : Integer) : tjsonObject;
    Function VerificaDados(ObjEndereco : TEndereco) : Boolean;
    Function GetEndereco(pEnderecoId : Integer = 0; pEstruturaID : Integer = 0; pZonaId : Integer = 0; pRuaId : Integer = 0; pEnderecoIni : String = ''; pEnderecoFin : String = ''; pOcupacaoEndereco : String = 'T'; pStatus : Integer = 2; pShowErro : Integer = 1) : TObjectList<TEndereco>;
    Function GetEnderecoJson(pEnderecoId : Integer = 0; pEstruturaID : Integer = 0; pZonaId : Integer = 0; pRuaId : Integer = 0; pEnderecoIni : String = ''; pEnderecoFin : String = '';  pOcupacaoEndereco : String = 'T'; pStatus : Integer = 99; pShowErro : Integer = 1) : TJsonArray;
    function GetEnderecoPorListaZonaJson(pEnderecoId, pEstruturaID,
      pZonaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
      pStatus: Integer; pListaZona: String; pShowErro: Integer): TJsonArray;
    Function GetEnderecoToReposicao(pZonaId : Integer = 0; pEnderecoIni : String = ''; pEnderecoFin : String = '';
             pRuaInicial : String = ''; pRuaFinal : String = ''; pRuaParImpar : Integer = 2;
             pPredioInicial : String = ''; pPredioFinal : String = ''; pPredioParImpar : Integer = 2;
             pNivelInicial : String = ''; pNivelFinal : String = ''; pNivelParImpar : Integer = 2;
             pAptoInicial : String = ''; pAptoFinal : String = ''; pAptoParImpar : Integer = 2) : TJsonArray;
    Function Manutencao(pJsonManutencao : TJsonObject) : TJsonObject;
    Function GetEnderecoPadraoMovimentacao : TJsonArray;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelEndereco : Boolean;
    Function ExportFile(pCampos : String) : TJsonArray;
    Function getreusopicking(pZonaId, pDias : Integer) : TJsonArray;
    Function DesvincularPicking(pJsonArrayEndereco :TjsonArray) : TJsonArray;
    Property ObjEndereco : TEndereco Read FEndereco Write FEndereco;
  End;

implementation

{ tCtrlEndereco }

uses uEnderecoDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tEnderecoCtrl.VerificaDados(ObjEndereco : TEndereco) : Boolean;
Begin
  Result := False;
  With ObjEndereco do Begin
    if ObjEndereco.EnderecoRua.RuaId = 0 then
       raise Exception.Create('Informe a Rua do Endere�o!');
    if ObjEndereco.EnderecoEstrutura.EstruturaId = 0 then
       raise Exception.Create('Informe a Estrutura do Endere�o!');
    if (ObjEndereco.EnderecamentoZona.ZonaId = 0) then
       raise Exception.Create('Informe a Zona do Setor!');
    if (ObjEndereco.Descricao = '') then
       raise Exception.Create('Informe a identifica��o(TAG) do Endere�o!');
  End;
  Result := True;
End;

function TEnderecoCtrl.BloquearEndereco(pEnderecoId: Integer): tjsonObject;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := Self.FEndereco.EnderecoId;
  Result := ObjEnderecoDAO.BloquearEndereco;
  ObjEnderecoDAO.Free;
end;

constructor TEnderecoCtrl.Create;
begin
  FEndereco      := TEndereco.Create;
end;

function TEnderecoCtrl.DelEndereco : Boolean;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  Result := False;
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := Self.FEndereco.EnderecoId;
  Result := ObjEnderecoDAO.Delete;
  if Result then
     Self.ObjEndereco.EnderecoId := 0;
  ObjEnderecoDAO.Free;
end;

destructor TEnderecoCtrl.Destroy;
begin
  FreeAndNil(FEndereco);
  inherited;
end;

function TEnderecoCtrl.DesvincularPicking(pJsonArrayEndereco :TjsonArray): TJsonArray;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  Try
    ObjEnderecoDAO := TEnderecoDAO.Create;
    Result := ObjEnderecoDAO.DesvincularPicking(pJsonArrayEndereco);
    ObjEnderecoDAO.Free;
  Except On E: Exception do begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjEnderecoDAO.Free;
    end;
  End;
end;

function TEnderecoCtrl.GetEnderecoPadraoMovimentacao: TJsonArray;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  Try
    ObjEnderecoDAO := TEnderecoDAO.Create;
    Result := ObjEnderecoDAO.GetEnderecoPadraoMovimentacao;
    ObjEnderecoDAO.Free;
  Except On E: Exception do begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    ObjEnderecoDAO.Free;
    end;
  End;
end;

function TEnderecoCtrl.ExportFile(pCampos: String): TJsonArray;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := ObjEndereco.EnderecoId;
  Result := ObjEnderecoDAO.ExportFile(pCampos);
  ObjEnderecoDAO.Free;
end;

Function tEnderecoCtrl.GetEndereco(pEnderecoId : Integer = 0; pEstruturaID : Integer = 0;
         pZonaId : Integer = 0; pRuaId : Integer = 0; pEnderecoIni : String = ''; pEnderecoFin : String = ''; pOcupacaoEndereco : String = 'T'; pStatus : Integer = 2; pShowErro : Integer = 1) : TObjectList<TEndereco>;
Var ObjEnderecoDAO : TEnderecoDAO;
    ReturnJson     : TJsonArray;
    jsonEndereco   : tjsonObject;
    xItensEndereco : Integer;
    vErro          : String;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  Try
    ObjEnderecoDAO.Endereco.EnderecoId := ObjEndereco.EnderecoId;
    ObjEndereco.EnderecoEstrutura.EstruturaId := 100;
    ReturnJson := ObjEnderecoDAO.GetEndereco(pEnderecoId, pEstruturaID, pZonaId, pRuaId, pEnderecoIni, pEnderecoFin, pOcupacaoEndereco, pStatus, pShowErro);
    ObjEndereco.EnderecoEstrutura.EstruturaId := 150;
    Result     := TObjectList<TEndereco>.Create;
    if (ReturnJson.Count >= 1) and (Not ReturnJson.Items[0].TryGetValue('Erro', verro)) then Begin
       xItensEndereco := 0;
       repeat
         jsonEndereco := tJsonObject.Create;
         jsonEndereco := ReturnJson.Items[xItensEndereco] as TJSONObject;
         ObjEndereco  := ObjEndereco.JsonToClass(JsonEndereco.ToString());
         ObjEndereco.ProdutoId  := JsonEndereco.GetValue<TJsonObject>('produto').getValue<Integer>('produtoid');
         ObjEndereco.CodProduto := JsonEndereco.GetValue<TJsonObject>('produto').getValue<Integer>('codproduto');
         Result.Add(ObjEndereco);
         //jsonEndereco.Free; //Create;
         Inc(xItensEndereco);
       until (xItensEndereco > Pred(ReturnJson.Count));
    End
    Else Begin
       If pShowErro = 1 then Begin
          ObjEnderecoDAO.Free;
          if ReturnJson.Items[0].TryGetValue('Erro', verro) then
             Raise Exception.Create(vErro)
          Else Raise Exception.Create('Endere�o n�o localizado!');
       End
       Else Begin
          Result.Add(ObjEndereco.Create());
       End;
    End;
    ObjEnderecoDAO.Free;
  Except On E: Exception do begin
    raise Exception.Create('Erro: '+E.Message);
    end;
  End;
End;

function TEnderecoCtrl.GetEnderecoJson(pEnderecoId, pEstruturaID,
  pZonaId: Integer; pRuaId : Integer; pEnderecoIni, pEnderecoFin: String; pOcupacaoEndereco : String;
  pStatus : Integer; pShowErro: Integer): TJsonArray;
Var ObjEnderecoDAO : TEnderecoDAO;
    vErro :  String;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := ObjEndereco.EnderecoId;
  Result := ObjEnderecoDAO.GetEndereco(pEnderecoId, pEstruturaID, pZonaId, pRuaId,
            pEnderecoIni, pEnderecoFin, pOcupacaoEndereco, pStatus, pShowErro);
  if ((Result.Count < 1) or (Result.Items[0].TryGetValue('Erro', vErro))) and (pShowErro = 1) then
     Raise Exception.Create('Endere�o n�o localizado!');
  ObjEnderecoDAO.Free;
end;

function TEnderecoCtrl.GetEnderecoToReposicao(pZonaId: Integer;
  pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal: String;
  pRuaParImpar: Integer; pPredioInicial, pPredioFinal: String;
  pPredioParImpar: Integer; pNivelInicial, pNivelFinal: String;
  pNivelParImpar: Integer; pAptoInicial, pAptoFinal: String;
  pAptoParImpar: Integer): TJsonArray;
Var ObjEnderecoDAO : TEnderecoDAO;
    vErro :  String;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := ObjEndereco.EnderecoId;
  Result := ObjEnderecoDAO.GetEnderecotoReposicao(pZonaId, pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal,
            pRuaParImpar, pPredioInicial, pPredioFinal, pPredioParImpar, pNivelInicial, pNivelFinal,
            pNivelParImpar, pAptoInicial, pAptoFinal, pAptoParImpar);
  ObjEnderecoDAO.Free;
end;

function TEnderecoCtrl.GetReUsoPicking(pZonaId, pDias: Integer): TJsonArray;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := ObjEndereco.EnderecoId;
  Result := ObjEnderecoDAO.GetReUsoPicking(pZonaId, pDias);
  if (Result.Count < 1) then
     Raise Exception.Create('Endere�o n�o localizado!');
  ObjEnderecoDAO.Free;
end;

function TEnderecoCtrl.GetEnderecoPorListaZonaJson(pEnderecoId, pEstruturaID,
  pZonaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
  pStatus: Integer; pListaZona: String; pShowErro: Integer): TJsonArray;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := ObjEndereco.EnderecoId;
  Result := ObjEnderecoDAO.GetEnderecoPorListaZona(pEnderecoId, pEstruturaID, pZonaId, pEnderecoIni, pEnderecoFin, pOcupacaoEndereco, pStatus, pListaZona, pShowErro);
  if (Result.Count < 1) and (pShowErro = 1) then
     Raise Exception.Create('Endere�o n�o localizado!');
  ObjEnderecoDAO.Free;
end;

function TEnderecoCtrl.Manutencao(pJsonManutencao: TJsonObject): TJsonObject;
Var ObjEnderecoDAO : TEnderecoDAO;
begin
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco.EnderecoId := ObjEndereco.EnderecoId;
  Result := ObjEnderecoDAO.Manutencao(pJsonManutencao);
  ObjEnderecoDAO.Free;
end;

Function tEnderecoCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjEnderecoDAO : TEnderecoDAO;
Begin
  if Not VerificaDados(ObjEndereco) then
     Exit;
  ObjEnderecoDAO := TEnderecoDAO.Create;
  ObjEnderecoDAO.Endereco := ObjEndereco;
  Result := ObjEnderecoDAO.Salvar;
  ObjEnderecoDAO.Free;
End;

End.
