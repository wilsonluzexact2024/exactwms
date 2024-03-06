﻿{
  EmbalagemCaixaCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.EmbalagemCaixaCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  EmbalagemCaixaClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TCaixaEmbalagemCtrl = Class
  Private
    // Fun��es de Valida��o
    FCaixaEmbalagem: TCaixaEmbalagem;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEmbalagemCaixa: TCaixaEmbalagem Read FCaixaEmbalagem
      Write FCaixaEmbalagem;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlEmbalagemCaixa }

uses MService.EmbalagemCaixaDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group
  .Prefix('v1')
    .Get('/caixaembalagem', Get)
    .Get('/caixaembalagem/lista', GetLista)
    .Get('/caixaembalagem/:caixaembalagemid', GetId)
    .Get('/caixaembalagem/estrutura', Estrutura)
    .Post('/caixaembalagem', Insert)
    .Put('/caixaembalagem/:caixaembalagemid', Update)
    .Delete('/caixaembalagem/:caixaembalagemid', Delete)
end;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  CaixaEmbalagemDao: TCaixaEmbalagemDao;
Begin
  Try
    Try
      CaixaEmbalagemDao := TCaixaEmbalagemDao.Create;
      Res.Send<TJSonArray>(CaixaEmbalagemDao.Estrutura)
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.Created);
      End;
    end;
  Finally
    FreeAndNil(CaixaEmbalagemDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  CaixaEmbalagemDao: TCaixaEmbalagemDao;
begin
  Try
    Try
      CaixaEmbalagemDao := TCaixaEmbalagemDao.Create;
      Res.Send<TJSonArray>(CaixaEmbalagemDao.GetId(0)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
    End;
  Finally
    FreeAndNil(CaixaEmbalagemDAO);
  End;
end;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  CaixaEmbalagemDao: TCaixaEmbalagemDao;
begin
  try
    try
      CaixaEmbalagemDao := TCaixaEmbalagemDao.Create;
      Res.Send<TJSonArray>(CaixaEmbalagemDao.GetId(Req.Params.Items
        ['caixaembalagemid'].ToInteger)).Status(THttpStatus.Created);

    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    end;
  finally
    FreeAndNil(CaixaEmbalagemDao);
  end;
end;

procedure GetLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  CaixaEmbalagemDao: TCaixaEmbalagemDao;
  AQueryParam: TDictionary<String, String>;
  pSituacao: String;
  pCaixaEmbalagemId, pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId,
    pStatus: Integer;
  JsonArrayErro: TJSonArray;
Begin
  Try
    Try
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para pesquisar os endere�os.')))
          .Status(THttpStatus.Created);
      pCaixaEmbalagemId := 0;
      pSequenciaIni := 0;
      pSequenciaFin := 0;
      pVolumeEmbalagemId := 0;
      pSituacao := 'A';
      pStatus := 99;
      if AQueryParam.ContainsKey('caixaembalagemid') then
        pCaixaEmbalagemId := AQueryParam.Items['caixaembalagemid'].ToInteger;
      if AQueryParam.ContainsKey('sequenciaini') then
        pSequenciaIni := AQueryParam.Items['sequenciaini'].ToInteger;
      if AQueryParam.ContainsKey('sequenciafin') then
        pSequenciaFin := AQueryParam.Items['sequenciafin'].ToInteger;
      if AQueryParam.ContainsKey('volumeembalagemid') then
        pVolumeEmbalagemId := AQueryParam.Items['volumeembalagemid'].ToInteger;
      if AQueryParam.ContainsKey('situacao') then
        // A-All Todos  U-Em Uso  L-Liberada  D-Destinario   T-Tr�nsito
        pSituacao := AQueryParam.Items['situacao'];
      if AQueryParam.ContainsKey('operacao') then //Verificar qual a correta Situacao ou operacao
        // A-All Todos  U-Em Uso  L-Liberada  D-Destinario   T-Tr�nsito
        pSituacao := AQueryParam.Items['situacao'];
      If AQueryParam.ContainsKey('status') then // 1-Ativo  2-Desativada  >3 Todos
        pStatus := AQueryParam.Items['status'].ToInteger;
        CaixaEmbalagemDao := TCaixaEmbalagemDao.Create;
        Res.Send<TJSonArray>(CaixaEmbalagemDao.GetLista(pCaixaEmbalagemId,
          pSequenciaIni, pSequenciaFin, pVolumeEmbalagemId, pSituacao, pStatus)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        JsonArrayErro := TJSonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJSonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(CaixaEmbalagemDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonCaixaEmbalagem: TJSONObject;
  CaixaEmbalagemDao: TCaixaEmbalagemDao;
begin
  Try
    Try
      jsonCaixaEmbalagem := TJSONObject.Create;
      jsonCaixaEmbalagem := Req.Body<TJSONObject>;
      CaixaEmbalagemDao := TCaixaEmbalagemDao.Create;
      CaixaEmbalagemDao.ObjCaixaEmbalagem :=
        CaixaEmbalagemDao.ObjCaixaEmbalagem.JsonToClass
        (jsonCaixaEmbalagem.ToString());
      if CaixaEmbalagemDao.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
      FreeAndNil(jsonCaixaEmbalagem);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(CaixaEmbalagemDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonCaixaEmbalagem: TJSONObject;
  CaixaEmbalagemDao: TCaixaEmbalagemDao;
begin
  Try
    Try
      jsonCaixaEmbalagem := TJSONObject.Create;
      jsonCaixaEmbalagem := Req.Body<TJSONObject>;
      CaixaEmbalagemDao := TCaixaEmbalagemDao.Create;
      CaixaEmbalagemDao.ObjCaixaEmbalagem :=
        CaixaEmbalagemDao.ObjCaixaEmbalagem.JsonToClass
        (jsonCaixaEmbalagem.ToString());
      if CaixaEmbalagemDao.Salvar then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(jsonCaixaEmbalagem);
    FreeAndNil(CaixaEmbalagemDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  CaixaEmbalagemDao: TCaixaEmbalagemDao;
begin
  Try
    CaixaEmbalagemDao := TCaixaEmbalagemDao.Create;
    CaixaEmbalagemDao.ObjCaixaEmbalagem.CaixaEmbalagemid :=
      StrToIntDef(Req.Params.Items['embalagemid'], 0);
    CaixaEmbalagemDao.Delete;
    // Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
    Res.Status(200).Send<TJSONObject>
      (TJSONObject.Create(TJSONPair.Create('Resultado',
      'Registro exclu�do com Sucesso!'))).Status(THttpStatus.Created);
  Except
    on E: Exception do
    Begin
      Res.Status(500).Send<TJSONObject>
        (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
    End;
  End;
  FreeAndNil(CaixaEmbalagemDao);
end;

constructor TCaixaEmbalagemCtrl.Create;
begin
  FCaixaEmbalagem := TCaixaEmbalagem.Create;
end;

destructor TCaixaEmbalagemCtrl.Destroy;
begin
  FCaixaEmbalagem.Free;
  inherited;
end;

End.
