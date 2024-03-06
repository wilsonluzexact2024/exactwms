unit CaixaEmbalagemDAO;

interface

uses
  //FireDAC.Comp.Client, uConexao, DataSet.Serialize,
  System.SysUtils, EmbalagemCaixaClass, System.JSON, REST.Json, Rest.Types;

Type

  TCaixaEmbalagemDao = class
  private
    FCaixaEmbalagem : TCaixaEmbalagem;
  public
    constructor Create;
    Function Delete : Boolean;
    Function GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
    Function GetCaixaEmbalagemJson(pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin,
             pVolumeEmbalagemId : Integer; pSituacao : String; pStatus : Integer) : TJsonArray;
    Function Salvar : tjsonObject;
    Property ObjCaixaEmbalagem : TCaixaEmbalagem Read FCaixaEmbalagem Write FCaixaEmbalagem;
  end;

implementation

{ TLaboratorioDao }

uses UDmeXactWMS;

constructor TCaixaEmbalagemDao.Create;
begin
  Self.FCaixaEmbalagem := TCaixaEmbalagem.Create;
end;

function TCaixaEmbalagemDao.Delete: Boolean;
begin
  Result := False;
  DmeXactWMS.ResetRest;
  DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/{caixaembalagemid}';
  DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', Self.ObjCaixaEmbalagem.CaixaEmbalagemId.ToString());
  DmeXactWMS.RESTRequestWMS.Method := RmDelete;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) or
     (DmeXactWMS.RESTResponseWMS.StatusCode = 204) Then Begin //Lista de codigo de sucesso
     Result := True;
  End
  Else
    raise Exception.Create('não foi possível excluir o registro');
end;

function TCaixaEmbalagemDao.GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : tJsonArray;
Var jSonObj     : tJsonObject;
    xItens      : Integer;
    ObjCaixaEmbalagem  : TCaixaEmbalagem;
begin
  Result := TJsonArray.Create;
  DmeXactWMS.ResetRest;
  if (pCaixaEmbalagemId = 0) Then
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem'
  Else Begin
    DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem/{caixaembalagemid}';
    DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', pCaixaEmbalagemId.ToString());
  End;

  DmeXactWMS.RESTRequestWMS.Method := RmGet;
  DmeXactWMS.RESTRequestWMS.Execute;
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
  Else if pShowErro = 1 then
    raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

function TCaixaEmbalagemDao.GetCaixaEmbalagemJson(pCaixaEmbalagemId,
  pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus: Integer): TJsonArray;
Var jSonObj         : tJsonObject;
    vResourceURI    : String;
Begin
  Result := TJsonArray.Create;
  Try
    DmeXactWMS.ResetRest;
    ///v1/saida/cubagem?DataIni=01/05/  &DataFin=21/05/21
    vResourceURI := 'v1/caixaembalagem/lista?';
    if pCaixaEmbalagemId <> 0 then
       vResourceURI := vResourceURI+'&caixaembalagemid='+pCaixaEmbalagemId.ToString();
    if pSequenciaIni <> 0 then
       vResourceURI := vResourceURI+'&sequenciaini='+pSequenciaIni.ToString();
    if pSequenciaFin <> 0 then
       vResourceURI := vResourceURI+'&sequenciafin='+pSequenciaFin.ToString();
    if pVolumeEmbalagemId <> 0 then
       vResourceURI := vResourceURI+'&volumeembalagemid='+pVolumeEmbalagemId.ToString();
    vResourceURI := vResourceURI+'&situacao='+pSituacao;
    vResourceURI := vResourceURI+'&status='+pStatus.Tostring();
    vResourceURI := StringReplace(vResourceURI, '?&', '?', [rfReplaceAll]);
    DmeXactWMS.RESTRequestWMS.Resource := vResourceURI;
    DmeXactWMS.RESTRequestWMS.Method := RmGet;
    DmeXactWMS.RESTRequestWMS.Execute;
    if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
       Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONArray
    Else
      raise Exception.Create('Erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
  Except ON E: Exception do Begin
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Erro', E.Message));
    End;
  End;
end;

Function TCaixaEmbalagemDao.Salvar: tjsonObject;
Var jSonCaixaEmbalagem : TJsonObject;
begin
  jSonCaixaEmbalagem := tJson.ObjectToJsonObject(Self.FCaixaEmbalagem);
  DmeXactWMS.ResetRest;
  DmeXactWMS.RestRequestWMS.ClearBody;
  DmeXactWMS.RestRequestWMS.AddBody(jSonCaixaEmbalagem.ToJson, ContentTypeFromString('application/json'));
  if Self.ObjCaixaEmbalagem.CaixaEmbalagemId = 0 then Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1/caixaembalagem';
     DmeXactWMS.RESTRequestWMS.Method := rmPOST;
  End
  Else Begin
     DmeXactWMS.RESTRequestWMS.Resource := 'v1cCaixaembalagem/{caixaembalagemid}';
     DmeXactWMS.RESTRequestWMS.Params.AddUrlSegment('caixaembalagemid', Self.FCaixaEmbalagem.CaixaEmbalagemId.ToString());
     DmeXactWMS.RESTRequestWMS.Method := rmPut;
  End;
  DmeXactWMS.RESTRequestWMS.Execute;
  FreeAndNil(jSonCaixaEmbalagem);
  if (DmeXactWMS.RESTResponseWMS.StatusCode = 200) or (DmeXactWMS.RESTResponseWMS.StatusCode = 201) Then
     Result := DmeXactWMS.RESTResponseWMS.JSONValue as TJSONObject
  Else
    raise Exception.Create('Ocorreu um erro: '+DmeXactWMS.RESTResponseWMS.StatusText);
end;

end.
