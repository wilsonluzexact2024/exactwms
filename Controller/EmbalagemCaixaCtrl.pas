{
   EnderecamentoRuaCtrl.Pas
   Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
   Projeto: RhemaWMS
}
unit EmbalagemCaixaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
     EmbalagemCaixaClass, Rest.Json, System.Json, Rest.Types;

Type
  TipoConsulta = (Resumida, Completa);
  TCaixaEmbalagemCtrl = Class
  Private
    //Fun��es de Valida��o
    FObjCaixaEmbalagem      : TCaixaEmbalagem;
  Public
    constructor Create;
    destructor Destroy; override;
    //Rotinas P�blica (CRUD)
    Function VerificaDados(ObjCaixaEmbalagem : TCaixaEmbalagem) : Boolean;
    Function GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TCaixaEmbalagem>;
    Function GetCaixaEmbalagemJson(pCaixaEmbalagemId : Integer = 0; pSequenciaIni : Integer = 0;
             pSequenciaFin : Integer = 0; pVolumeEmbalagemId : Integer = 0; pSituacao : String = 'A'; pStatus: Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function Salvar : tjsonObject;  //(pHistorico: THistorico)
    Function DelCaixaEmbalagem : Boolean;
    Property ObjCaixaEmbalagem : TCaixaEmbalagem Read FObjCaixaEmbalagem Write FObjCaixaEmbalagem;
  End;

implementation

{ tCtrlCaixaEmbalagem }

uses CaixaEmbalagemDAO, uFrmeXactWMS, uFuncoes; //, uFrmPesquisa

Function tCaixaEmbalagemCtrl.VerificaDados(ObjCaixaEmbalagem : TCaixaEmbalagem) : Boolean;
Begin
  Result := False;
  With ObjCaixaEmbalagem do Begin
    if ObjCaixaEmbalagem.Numsequencia = 0 then
       raise Exception.Create('Informe o N�mero de Identifica��o da caixa!');
    if (ObjCaixaEmbalagem.VolumeEmbalagem.EmbalagemId <= 0) then
       raise Exception.Create('Informe a tipo para as propriedades da Caixa!');
  End;
  Result := True;
End;

constructor TCaixaEmbalagemCtrl.Create;
begin
  FObjCaixaEmbalagem      := TCaixaEmbalagem.Create;
end;

function TCaixaEmbalagemCtrl.DelCaixaEmbalagem : Boolean;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  ObjCaixaEmbalagemDAO.ObjCaixaEmbalagem.CaixaEmbalagemId := Self.ObjCaixaEmbalagem.CaixaEmbalagemId;
  Result := ObjCaixaEmbalagemDAO.Delete;
  if Result then
     Self.ObjCaixaEmbalagem.CaixaEmbalagemId := 0;
  ObjCaixaEmbalagemDAO := Nil;
  ObjCaixaEmbalagemDAO.DisposeOf;
end;

destructor TCaixaEmbalagemCtrl.Destroy;
begin
  FreeAndNil(FObjCaixaEmbalagem);
  inherited;
end;

Function tCaixaEmbalagemCtrl.GetCaixaEmbalagem(pCaixaEmbalagemId : Integer = 0; pShowErro : Integer = 1) : TObjectList<TCaixaEmbalagem>;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
    ReturnJson     : TJsonArray;
    jsonCaixaEmbalagem   : tjsonObject;
    xItensCaixaEmbalagem : Integer;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  ReturnJson := ObjCaixaEmbalagemDAO.GetCaixaEmbalagem(pCaixaEmbalagemId, pShowErro);
  Result     := TObjectList<TCaixaEmbalagem>.Create;
  if ReturnJson.Count >= 1 then Begin
     xItensCaixaEmbalagem := 0;
     repeat
       jsonCaixaEmbalagem := tJsonObject.Create;
       jsonCaixaEmbalagem := ReturnJson.Items[xItensCaixaEmbalagem] as TJSONObject;
       ObjCaixaEmbalagem  := ObjCaixaEmbalagem.JsonToClass(JsonCaixaEmbalagem.ToString());
       Result.Add(ObjCaixaEmbalagem);
       jsonCaixaEmbalagem := Nil;
       jsonCaixaEmbalagem.DisposeOf;
       Inc(xItensCaixaEmbalagem);
     until (xItensCaixaEmbalagem > Pred(ReturnJson.Count));
  End
  Else If pShowErro = 1 then
     Raise Exception.Create('Caixa n�o encontrada!');
  ObjCaixaEmbalagemDAO := Nil;
  ObjCaixaEmbalagemDAO.DisposeOf;
End;

function TCaixaEmbalagemCtrl.GetCaixaEmbalagemJson(pCaixaEmbalagemId,
  pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId: Integer; pSituacao: String;
  pStatus, pShowErro: Integer): TJsonArray;
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  Result := ObjCaixaEmbalagemDAO.GetCaixaEmbalagemJson(pCaixaEmbalagemId,
            pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId, pSituacao, pStatus);
  If (pShowErro = 1) and (Result.Count < 1) then
     Raise Exception.Create('Caixa n�o encontrada!');
  ObjCaixaEmbalagemDAO.Free;
end;

Function tCaixaEmbalagemCtrl.Salvar : tjsonObject;       //(pHistorico: THistorico)
Var ObjCaixaEmbalagemDAO : TCaixaEmbalagemDAO;
Begin
  ObjCaixaEmbalagemDAO := TCaixaEmbalagemDAO.Create;
  ObjCaixaEmbalagemDAO.ObjCaixaEmbalagem := ObjCaixaEmbalagem;
  Result := ObjCaixaEmbalagemDAO.Salvar;
  ObjCaixaEmbalagemDAO := Nil;
  ObjCaixaEmbalagemDAO.DisposeOf;
End;

End.
