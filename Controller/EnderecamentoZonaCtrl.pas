{
   EnderecamentoZonaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automação Comercial) em 19/09/2020
   Projeto: RhemaWMS
}
unit EnderecamentoZonaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     EnderecamentoZonaClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TEnderecamentoZonaCtrl = Class
  Private
    //Funções de Validação
    FObjEnderecamentoZona : TEnderecamentoZona;
    LstEnderecamentoZona : TObjectList<TEnderecamentoZona>;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas Pública (CRUD)
    Function VerificaDados : Boolean;
    Function FindEnderecamentoZona(pEnderecamentoZonaId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : tJsonArray;
    Function GetEnderecamentoZona(pEnderecamentoZonaId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : TObjectList<TEnderecamentoZona>;
    Function GetEnderecamentoZonaJson(pEnderecamentoZonaId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1) : TJsonArray;
    Function GetZonaPicking(pZonaId, pPickingFixo, pDisponivel : Integer; ShowErro : Integer) : TJsonArray;
    Function Salvar : Boolean;  //(pHistorico: THistorico)
    Class Function DelEnderecamentoZona(pIdEnderecamentoZona : Integer) : Boolean;
    Property ObjEnderecamentoZona  : TEnderecamentoZona Read FObjEnderecamentoZona Write FObjEnderecamentoZona;
  End;

implementation

{ tCtrlEnderecamentoZona }

uses UDmeXactWMS, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tEnderecamentoZonaCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.ObjEnderecamentoZona do Begin
    if Descricao = '' then raise Exception.Create('Informe a Descrição da Zona de Endereçamentos!');
    if EstruturaId <= 0 then raise Exception.Create('Informe corretamente a estrutura de endereços para esta Zona/Setor.');
    if EstoqueTipoId <= 0 then raise Exception.Create('Informe o tipo estoque para esta Zona/Setor.');
    if RastroId <= 0 then raise Exception.Create('Informe o tipo de Rastreabilidade dos produtos desta Zona/Setor.');
  End;
  Result := True;
End;

constructor TEnderecamentoZonaCtrl.Create;
begin
  ObjEnderecamentoZona := TEnderecamentoZona.Create;
end;

class function TEnderecamentoZonaCtrl.DelEnderecamentoZona(pIdEnderecamentoZona : Integer): Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona/{zonaid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pIdEnderecamentoZona.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

destructor TEnderecamentoZonaCtrl.Destroy;
begin
  FreeAndNil(FObjEnderecamentoZona);
  inherited;
end;

Function tEnderecamentoZonaCtrl.FindEnderecamentoZona(pEnderecamentoZonaId : Integer = 0; pDescricao : String = ''; ShowErro : Integer = 1): tJsonArray;// TObjectList<TEnderecamentoZona>;
Var jSonEnderecamentoZona : tJsonObject;
    xItens : Integer;
    vErro  : String;
Begin
  //LstEnderecamentoZona := TObjectList<TEnderecamentoZona>.Create;
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pEnderecamentoZonaId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona/{zonaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pEnderecamentoZonaId.ToString());
  End
  Else if pDescricao = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona/{zonaid}{descricao}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', '0');
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
     if (Result.Count >= 1) and (Not Result.Items[0].TryGetValue('Erro', vErro)) then Begin
        xItens := 0;
//        repeat
          FObjEnderecamentoZona.ZonaId               := Result.Items[0].GetValue<Integer>('zonaid');
          FObjEnderecamentoZona.Descricao            := Result.Items[0].GetValue<String>('descricao');
          FObjEnderecamentoZona.EstruturaId          := Result.Items[0].GetValue<Integer>('estruturaid');
          FObjEnderecamentoZona.EstoqueTipoId        := Result.Items[0].GetValue<Integer>('estoquetipoid');
          FObjEnderecamentoZona.LoteReposicao        := Result.Items[0].GetValue<Integer>('lotereposicao');
          FObjEnderecamentoZona.SeparacaoConsolidada := Result.Items[0].GetValue<Integer>('separacaoconsolidada');
          FObjEnderecamentoZona.ProdutoSNGPC         := Result.Items[0].GetValue<Integer>('produtosngpc');
          FObjEnderecamentoZona.RastroId             := Result.Items[0].GetValue<TJsonObject>('rastro').GetValue<Integer>('rastroid');
          FObjEnderecamentoZona.Status               := Result.Items[0].GetValue<Integer>('status');
          xItens := xItens + 1;
//        until (xItens > Pred(Result.Count));
     End
     Else Raise Exception.Create('Registro não encontrado');
  End
  Else if ShowErro = 1 then
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  //LstEnderecamentoZona.Add(GetEnderecamentoZonaBD(Completa));
  //Result := LstEnderecamentoZona;
End;

function TEnderecamentoZonaCtrl.GetEnderecamentoZona(pEnderecamentoZonaId: Integer;
  pDescricao: String; ShowErro: Integer): TObjectList<TEnderecamentoZona>;
Var ReturnJson : tJsonArray;
    xItens     : Integer;
    jSonEnderecamentoZona : tJsonObject;
begin
  Result     := TObjectList<TEnderecamentoZona>.Create;
  ReturnJson := FindEnderecamentoZona(pEnderecamentoZonaId, '', ShowErro);
  if ReturnJson.Count >= 1 then Begin
     xItens := 0;
     //repeat
       jSonEnderecamentoZona := tJsonObject.Create;
       jSonEnderecamentoZona := ReturnJson.Items[xItens] as TJSONObject;
       ObjEnderecamentoZona  := ObjEnderecamentoZona.JsonToClass(jSonEnderecamentoZona.ToString());
       Result.Add(ObjEnderecamentoZona);
       jSonEnderecamentoZona           := Nil;
       jSonEnderecamentoZona.DisposeOf;
       xItens := xItens + 1;
     //until (xItens > Pred(ReturnJson.Count));
  End
  Else Raise Exception.Create('Registro de Zona de Endereçamento não encontrada');
end;

function TEnderecamentoZonaCtrl.GetEnderecamentoZonaJson(
  pEnderecamentoZonaId: Integer; pDescricao: String;
  ShowErro: Integer): TJsonArray;
Var jSonEnderecamentoZona : tJsonObject;
    xItens      : Integer;
Begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if pEnderecamentoZonaId <> 0 then  Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona/{zonaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pEnderecamentoZonaId.ToString());
  End
  Else if pDescricao = '' then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona'
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona/{zonaid}{descricao}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', '0');
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('descricao', pDescricao);
  End;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then Begin
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray;
  End
  Else if ShowErro = 1 then Begin
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  End;
end;

function TEnderecamentoZonaCtrl.GetZonaPicking(pZonaId, pPickingFixo,
  pDisponivel: Integer; ShowErro : Integer): TJsonArray;
Var jSonEnderecamentoZona : tJsonObject;
    xItens      : Integer;
Begin
  //LstEnderecamentoZona := TObjectList<TEnderecamentoZona>.Create;
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona/zonapicking/{zonaid}/{pickingfixo}/{disponivel}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pZonaId.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('pickingfixo', pPickingFixo.ToString());
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('disponivel', pDisponivel.Tostring());
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else if ShowErro = 1 then
    raise Exception.Create('Erro: '+(DmeXactWMS.RESTResponseWMS.JSONValue as TJsonObject).GetValue<String>('Erro'));   //DmeXactWMS.RESTResponseWMS.StatusText);
end;

Function tEnderecamentoZonaCtrl.Salvar : Boolean;       //(pHistorico: THistorico)
Var jSonEnderecamentoZona : TJsonObject;
Begin
  If Not Self.VerificaDados then Begin
     Result := False;
     Exit;
  End;
  Result := True;
  jSonEnderecamentoZona := tJson.ObjectToJsonObject(ObjEnderecamentoZona);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonEnderecamentoZona.ToJson, ContentTypeFromString('application/json'));
  if ObjEnderecamentoZona.ZonaId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/enderecamentozona/{zonaid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', ObjEnderecamentoZona.ZonaId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonEnderecamentoZona);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := True
  Else Begin
    Result := False;
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  End;
End;

End.

