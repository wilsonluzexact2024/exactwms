unit uEnderecoDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EnderecoClass, System.JSON, REST.Json, Rest.Types;

Type

  TEnderecoDao = class
  private
    FEndereco : TEndereco;
  public
    constructor Create;
    Function BloquearEndereco : tjsonObject;
    Function Delete : Boolean;
    Function GetEndereco(pEnderecoId : Integer = 0; pEstruturaId : Integer = 0; pZonaId : Integer = 0;  pRuaId : Integer = 0;
             pEnderecoIni : String = ''; pEnderecoFin : String = ''; pOcupacaoEndereco : String = 'T'; pStatus : Integer = 99;
             pBloqueado : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function GetEnderecoPorListaZona(pEnderecoId, pEstruturaID, pZonaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String; pStatus: Integer; pListaZona: String; pShowErro: Integer): TJsonArray;
    Function GetEnderecoToReposicao(pZonaId: Integer; pEnderecoIni, pEnderecoFin, pRuaInicial, pRuaFinal: String;
                                    pRuaParImpar: Integer; pPredioInicial, pPredioFinal: String; pPredioParImpar: Integer;
                                    pNivelInicial, pNivelFinal: String; pNivelParImpar: Integer; pAptoInicial, pAptoFinal: String;
                                    pAptoParImpar: Integer): TJsonArray;
    Function Manutencao(pJsonManutencao : TJsonObject) : TJsonObject;
    Function GetEnderecoPadraoMovimentacao : TJsonArray;
    Function GetReUsoPicking(pZonaId, pDias: Integer): TJsonArray;
    Function Salvar : tjsonObject;
    Function ExportFile(pCampos : String) : TJsonArray;
    Function DesvincularPicking(pJsonArrayEndereco :TjsonArray): TJsonArray;
    Property Endereco : TEndereco Read FEndereco Write FEndereco;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

function TEnderecoDao.BloquearEndereco : tjsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/bloquear';
//  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.Endereco.EnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := rmput;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  End
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

constructor TEnderecoDao.Create;
begin
  Self.FEndereco := TEndereco.Create;
end;

function TEnderecoDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/{id}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.Endereco.EnderecoId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TEnderecoDao.DesvincularPicking(pJsonArrayEndereco :TjsonArray): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RestRequestWMS.AddBody(pJsonArrayEndereco.ToJson, ContentTypeFromString('application/json'));
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/desvincular';
    DmeXactWMS.RESTRequestWMS.Method := rmPut;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := (DmeXactWMS.RESTResponseWMS.JSONValue) as TJsonArray
  Except On E: Exception do
    raise Exception.Create('Erro:' +E.Message);
  End;
end;

function TEnderecoDao.ExportFile(pCampos: String): TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/exportfile?campos='+pCampos;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
       (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
       Result := (DmeXactWMS.RESTResponseWMS.JSONValue) as TJsonArray
    End
    Else
      raise Exception.Create(DmeXactWMS.RESTResponseWMS.Content);
  Except On E: Exception do
      raise Exception.Create('Erro:' +E.Message);
  End;
end;

function TEnderecoDao.GetEndereco(pEnderecoId, pEstruturaId, pZonaId: Integer; pRuaId : Integer;
         pEnderecoIni : String; pEnderecoFin : String; pOcupacaoEndereco : String; pStatus : Integer;
         pBloqueado : Integer; pShowErro: Integer): tJsonArray;
Var jSonObj         : tJsonObject;
    xItens          : Integer;
    ObjEndereco     : TEndereco;
    vResourceURI    : String;
begin
Try
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  ///v1/saida/cubagem?DataIni=01/05/  &DataFin=21/05/21
  vResourceURI := 'v1/endereco/lista?';
  if pEnderecoId <> 0 then
     vResourceURI := vResourceURI+'&enderecoid='+pEnderecoId.ToString();
  if pEstruturaId <> 0 then
     vResourceURI := vResourceURI+'&estruturaid='+pEstruturaId.ToString();
  if pZonaid <> 0 then
     vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString();
  if pRuaid <> 0 then
     vResourceURI := vResourceURI+'&ruaid='+pRuaId.ToString();
  if pEnderecoIni <> '' then
     vResourceURI := vResourceURI+'&enderecoini='+pEnderecoIni;
  if pEnderecoFin <> '' then
     vResourceURI := vResourceURI+'&enderecofin='+pEnderecoFin;
  vResourceURI := vResourceURI+'&ocupacaoendereco='+pOcupacaoEndereco;
  vResourceURI := vResourceURI+'&status='+pStatus.Tostring();
  if pBloqueado <> 0 then
     vResourceURI := vResourceURI+'&bloqueado='+pBloqueado.Tostring();
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
Except ON E: Exception do
  raise Exception.Create('Erro: '+E.Message);
End;
End;

function TEnderecoDao.GetEnderecoPadraoMovimentacao: TJsonArray;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/padraomovimentacao'; //Pegar Endereco de Zona Padrao Area de Espera e Segregado
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
     raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEnderecoDao.GetEnderecoPorListaZona(pEnderecoId, pEstruturaID,
  pZonaId: Integer; pEnderecoIni, pEnderecoFin, pOcupacaoEndereco: String;
  pStatus: Integer; pListaZona: String; pShowErro: Integer): TJsonArray;
Var jSonObj         : tJsonObject;
    xItens          : Integer;
    ObjEndereco     : TEndereco;
    vResourceURI    : String;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  ///v1/saida/cubagem?DataIni=01/05/  &DataFin=21/05/21
  vResourceURI := 'v1/endereco/lista?';
  if pEnderecoId <> 0 then
     vResourceURI := vResourceURI+'&enderecoid='+pEnderecoId.ToString();
  if pEstruturaId <> 0 then
     vResourceURI := vResourceURI+'&estruturaid='+pEstruturaId.ToString();
  if pZonaid <> 0 then
     vResourceURI := vResourceURI+'&zonaid='+pZonaId.ToString();
  if pEnderecoIni <> '' then
     vResourceURI := vResourceURI+'&enderecoini='+pEnderecoIni;
  if pEnderecoFin <> '' then
     vResourceURI := vResourceURI+'&enderecofin='+pEnderecoFin;
  if pListaZona <> '' then
     vResourceURI := vResourceURI+'&listazona='+pListaZona;
  vResourceURI := vResourceURI+'&ocupacaoendereco='+pOcupacaoEndereco;
  vResourceURI := vResourceURI+'&status='+pStatus.Tostring();
  vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
  DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TEnderecoDao.GetEnderecoToReposicao(pZonaId: Integer; pEnderecoIni,
  pEnderecoFin, pRuaInicial, pRuaFinal: String; pRuaParImpar: Integer;
  pPredioInicial, pPredioFinal: String; pPredioParImpar: Integer; pNivelInicial,
  pNivelFinal: String; pNivelParImpar: Integer; pAptoInicial,
  pAptoFinal: String; pAptoParImpar: Integer): TJsonArray;
Var jSonObj         : tJsonObject;
    xItens          : Integer;
    ObjEndereco     : TEndereco;
    vResourceURI    : String;
    vCompl          : String;
begin
  Try
    DmeXactWMS.ResetRest;
    vCompl := '?';
    vResourceURI := 'v1/enderecotoreposicao';
    if pZonaid <> 0 then Begin
       vResourceURI := vResourceURI+vCompl+'zonaid='+pZonaId.ToString();
       vCompl := '&';
    End;
    if pEnderecoIni <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'enderecoini='+pEnderecoIni;
       vCompl := '&';
    End;
    if pEnderecoFin <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'enderecofin='+pEnderecoFin;
       vCompl := '&';
    End;
    if pRuaInicial <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'ruainicial='+pRuaInicial;
       vCompl := '&';
    End;
    if pRuaFinal <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'ruafinal='+pRuaFinal;
       vCompl := '&';
    End;
    vResourceURI := vResourceURI+vCompl+'ruaparimpar='+pruaparimpar.ToString();
    vCompl := '&';
    if pPredioInicial <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'predioinicial='+pPredioInicial;
       vCompl := '&';
    End;
    if pPredioFinal <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'prediofinal='+pPredioFinal;
       vCompl := '&';
    End;
    vResourceURI := vResourceURI+vCompl+'predioparimpar='+pruaparimpar.ToString();
    vCompl := '&';
    if pNivelInicial <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'Nivelinicial='+pNivelInicial;
       vCompl := '&';
    End;
    if pNivelFinal <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'nivelfinal='+pPredioFinal;
       vCompl := '&';
    End;
    vResourceURI := vResourceURI+vCompl+'nivelparimpar='+pruaparimpar.ToString();
    vCompl := '&';
    if pAptoInicial <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'aptoinicial='+pAptoInicial;
       vCompl := '&';
    End;
    if pAptoFinal <> '' then Begin
       vResourceURI := vResourceURI+vCompl+'aptoinal='+pAptoFinal;
       vCompl := '&';
    End;
    vResourceURI := vResourceURI+vCompl+'aptoparimpar='+pAptoparimpar.ToString();
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    //if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;

end;

function TEnderecoDao.GetReUsoPicking(pZonaId, pDias: Integer) : TJsonArray;
begin
  Try
    DmeXactWMS.ResetRest;
    DmeXactWMS.RestRequestWMS.ClearBody;
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/getreusopicking/{zonaid}/{dias}'; //5/28'; //{zonaid}/{dias}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pZonaId.ToString());
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('dias',   pDias.ToString());
    DmeXactWMS.RESTRequestWMS.Method := rmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJsonArray;
  Except On E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement( TJsonObject.Create.AddPair('Erro: ', E.Message) );
    End;
  End;
end;

function TEnderecoDao.Manutencao(pJsonManutencao: TJsonObject): TJsonObject;
begin
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(pJsonManutencao.ToJson, ContentTypeFromString('application/json'));
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/manutencao';
  DmeXactWMS.RESTRequestWMS.Method := rmPut;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else begin
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  end;
end;

(*
 function TEnderecoDao.GetEndereco(pEnderecoId, pEstruturaId, pZonaId: Integer;
   pEnderecoIni : String; pEnderecoFin : String; pShowErro: Integer): tJsonArray;
 Var jSonObj     : tJsonObject;
     xItens      : Integer;
     ObjEndereco  : TEndereco;
 begin
   Result := TJsonArray.Create;
   DmeXactWMS.ResetRest;
   if (pEnderecoId=0) and (pEstruturaId=0) and (pZonaId=0) and (pEnderecoIni='') and (pEnderecoFin='') then
      DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco'
   Else if (pEnderecoId <> 0) or (pEnderecoIni<>'') then Begin
      DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/{enderecoid}';
      if pEnderecoId <> 0 then
         DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoId.ToString())
      Else DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('enderecoid', pEnderecoIni);
   End
   Else if pEstruturaId <> 0 then Begin
      DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/estrutura/{estruturaid}';
      DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('estruturaid', pEnderecoId.ToString());
   End
   Else if pZonaId <> 0 then Begin
      DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/zona/{zonaid}';
      DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('zonaid', pEnderecoId.ToString());
   End;
   DmeXactWMS.RESTRequestWMS.Method := RmGet;
   DmeXactWMS.RESTRequestWMS.Execute;
   if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
      Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
   Else
     raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
 end;
*)

Function TEnderecoDao.Salvar: tjsonObject;
Var jSonEndereco : TJsonObject;
begin
  jSonEndereco := tJson.ObjectToJsonObject(Self.FEndereco);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonEndereco.ToJson, ContentTypeFromString('application/json'));
  if Self.Endereco.EnderecoId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/endereco/{id}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('id', Self.FEndereco.EnderecoId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
//  FreeAndNil(jSonEndereco);
//  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
//  Else begin
//   raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
//  end;
end;

end.
