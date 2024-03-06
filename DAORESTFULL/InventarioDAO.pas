unit InventarioDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, InventarioClass, System.JSON, REST.Json, Rest.Types;

Type

  TInventarioDao = class
  private
    FInventario : TInventario;
  public
    constructor Create;
    Function Delete : Boolean;
    Function Cancelar : Boolean;
    Function GetInventario(pInventarioId : Integer; pDataCriacao, pDataFinalizacao,
             pDataCancelamento : TDateTime; pProcessoId : Integer; pTipo : Integer;
             pPendente : Integer; pProdutoId : Integer; pDataCriacaoFinal : TDateTime) : tJsonArray;
    Function GetPendente : TJsonArray;
    Function GetContagem(pItem : Integer) : TJsonArray;
    Function GetInventarioItens(pInventarioId : Integer) : TJsonArray;
    Function GetLoteInventariado(pInventarioId, pEnderecoId, pProdutoId, pTipo, pShowErro : Integer) : TJsonArray;
    Function Salvar(pListaEndereco : TJsonArray) : TJsonObject;
    Function ZerarEndereco(pInventarioId, pEnderecoId, pProdutoId  : Integer) : TJsonObject;
    Function SaveContagem(pJsonArrayContagem : TJsonArray) : TJsonObject;
    Function InventarioFechar :  Boolean;
    Function LimparContagem(pInventarioId, pEnderecoId, pProdutoId: Integer): TJsonArray;
    Function GetDshInventarios(pDataInicial, pDataFinal: TDateTime; pInventarioIdInicial, pInventarioIdFinal: Integer): TJsonObject;
    Property ObjInventario : TInventario Read FInventario Write FInventario;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS, uFuncoes, uFrmeXactWMS;

function TInventarioDao.Cancelar: Boolean;
Var vResourceURI, vComplemento : String;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/inventario/cancelar';
  vResourceURI := vResourceURI+vcomplemento+'?inventarioid='+ObjInventario.InventarioId.Tostring;
  vResourceURI := vResourceURI+vcomplemento+'&terminal='+NomedoComputador;
  vResourceURI := vResourceURI+vcomplemento+'&usuarioid='+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString();
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

constructor TInventarioDao.Create;
begin
  Self.FInventario := TInventario.Create;
end;

function TInventarioDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/{inventarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', Self.ObjInventario.InventarioId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro do Inventário!');
end;

function TInventarioDao.GetContagem(pItem : Integer) : TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/contagem/{item}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('item', pItem.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TInventarioDao.GetDshInventarios(pDataInicial, pDataFinal: TDateTime;
  pInventarioIdInicial, pInventarioIdFinal: Integer): TJsonObject;
Var vResourceURI, vComplemento : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vResourceURI := 'v1/inventario/dshcontageminventario';
    vComplemento := '?';
    if pDataInicial <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'datainicial='+DateToStr(pDataInicial);
       vComplemento := '&';
    End;
    if pDataFinal <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'datafinal='+DateToStr(pDataFinal);
       vComplemento := '&';
    End;
    if pInventarioIdInicial <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'inventarioidinicial='+pInventarioIdInicial.ToString;
       vComplemento := '&';
    End;
    if pInventarioIdFinal <> 0 then Begin
       vResourceURI := vResourceURI+vcomplemento+'inventarioidfinal='+pInventarioIdFinal.ToString;
       vComplemento := '&';
    End;
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject
  Except On E: Exception do Begin
    Result := TJsonObject.Create;
    Result.AddPair('Erro', E.Message);
    End;
  End;
end;

function TInventarioDao.GetInventario(pInventarioId : Integer; pDataCriacao, pDataFinalizacao,
         pDataCancelamento : TDateTime; pProcessoId : Integer; pTipo : Integer;
         pPendente : Integer; pProdutoId : Integer; pDataCriacaoFinal : TDateTime) : tJsonArray;
Var jSonObj       : tJsonObject;
    xItens        : Integer;
    ObjInventario : TInventario;
    vResourceURI, vComplemento : String;
begin
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/inventario';
  vComplemento := '?';
  if pinventarioid <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'inventarioid='+pInventarioId.Tostring;
     vComplemento := '&';
  End;
  if pDataCriacao <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datacriacao='+FormatDateTime('YYYY-MM-DD', pDataCriacao);
     vComplemento := '&';
  End;
  if pDataCriacaoFinal <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datacriacaofinal='+FormatDateTime('YYYY-MM-DD', pDataCriacaoFinal);
     vComplemento := '&';
  End;
  if pDataFinalizacao <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datafinalizacao='+FormatDateTime('YYYY-MM-DD', pDataCriacao);
     vComplemento := '&';
  End;
  if pDataCancelamento <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'datacancelamento='+FormatDateTime('YYYY-MM-DD', pDataCancelamento);
     vComplemento := '&';
  End;
  if pProcessoId <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'processoid='+pProcessoId.ToString();
     vComplemento := '&';
  End;
  if pTipo <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'tipo='+ptipo.ToString();
     vComplemento := '&';
  End;
  if pProdutoId <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'produtoid='+pProdutoId.ToString();
     vComplemento := '&';
  End;
  vResourceURI := vResourceURI+vcomplemento+'pendente='+pPendente.ToString();
  vComplemento := '&';
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
end;

function TInventarioDao.GetInventarioItens(pInventarioId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/itens/{inventarioid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', pInventarioId.Tostring());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TInventarioDao.GetLoteInventariado(pInventarioId, pEnderecoId,
  pProdutoId, pTipo , pShowErro: Integer): TJsonArray;
Var jSonObj       : tJsonObject;
    xItens        : Integer;
    ObjInventario : TInventario;
    vResourceURI, vComplemento : String;
Begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/inventario/loteinventariado?tipo='+pTipo.ToString;
  vComplemento := '&';

  if pinventarioid <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'inventarioid='+pInventarioId.Tostring;
     vComplemento := '&';
  End;
  If pEnderecoId <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'enderecoid='+pEnderecoId.ToString();
     vComplemento := '&';
  End;
  if pProdutoId <> 0 then Begin
     vResourceURI := vResourceURI+vcomplemento+'produtoid='+pProdutoId.Tostring();
     vComplemento := '&';
  End;
  vResourceURI := vResourceURI+vcomplemento+'tipo='+pTipo.Tostring();
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  If (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else Begin
    if pShowErro = 1 then
       raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText)
    Else Result := TJsonArray.Create(TJsonObject.Create.AddPair('Erro', DmeXactWMS.RESTResponseWMS.StatusText));
  End;
end;

Function TInventarioDao.GetPendente: TJsonArray;
Begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/pendente';
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else
      raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
End;

Function TInventarioDao.InventarioFechar: Boolean;
Var vResourceURI, vComplemento : String;
Begin
  Result := False;
  DmeXactWMS.ResetRest;
  vResourceURI := 'v1/inventario/apuracao/endereco'; //'v1/inventario/fechar';
  vResourceURI := vResourceURI+vcomplemento+'?inventarioid='+ObjInventario.InventarioId.Tostring;
  vResourceURI := vResourceURI+vcomplemento+'&terminal='+NomedoComputador;
  vResourceURI := vResourceURI+vcomplemento+'&usuarioid='+FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString();
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmPost;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

function TInventarioDao.LimparContagem(pInventarioId, pEnderecoId, pProdutoId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/limparcontagem/{inventarioid}/{enderecoid}/{produtoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', pInventarioId.Tostring());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.Tostring());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid', pProdutoId.Tostring());
  DmeXactWMS.RESTRequestWMS.Method := RmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function TInventarioDao.Salvar(pListaEndereco : TJsonArray) : tjsonObject;
Var jSonInventario : TJsonObject;
Begin
  jSonInventario := tJson.ObjectToJsonObject(Self.FInventario);
  JsonInventario.AddPair('endereco', pListaEndereco);
  JsonInventario.AddPair('usuarioid', TJsonNumber.Create(FrmExactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
  JsonInventario.AddPair('terminal', NomeDoComputador());
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonInventario.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjInventario.InventarioId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/{inventarioid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', Self.FInventario.InventarioId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  jSonInventario.Free;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject)
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

Function TInventarioDao.SaveContagem(
  pJsonArrayContagem: TJsonArray): TJsonObject;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonArrayContagem.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/savecontagem';
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject)
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

Function TInventarioDao.ZerarEndereco(pInventarioId,
  pEnderecoId, pProdutoId : Integer): TJsonObject;
Begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/inventario/zerarendereco/{inventarioid}/{enderecoid}/{produtoid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('inventarioid', pInventarioId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('produtoid',  pProdutoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := (DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject)
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
End;

end.
