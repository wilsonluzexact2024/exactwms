{
  MService.UnidadeCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.UnidadeCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  UnidadeClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TUnidadeCtrl = Class
  Private
    // Fun��es de Valida��o
    FUnidade: TUnidade;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjUnidade: TUnidade Read FUnidade Write FUnidade;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetUnidade4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlUnidade }

uses MService.UnidadeDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/unidade', Get);
  THorse.Get('/v1/unidade/:id', GetID);
  THorse.Get('/v1/unidade/:id/:descricao', GetDescricao);
  THorse.Post('/v1/unidade', Insert);
  THorse.Put('/v1/unidade/:id', Update);
  THorse.Delete('/v1/unidade/:id', Delete);
  THorse.Get('/v1/unidade4D', GetUnidade4D);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  UnidadeDAO: TUnidadeDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    Try
      UnidadeDAO := TUnidadeDao.Create;
      Res.Send<TJsonArray>(UnidadeDAO.GetID(0)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(UnidadeDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  UnidadeDAO: TUnidadeDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      UnidadeDAO := TUnidadeDao.Create;
      Res.Send<TJsonArray>(UnidadeDAO.GetDescricao(Req.Params.Items['descricao']
        )).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(UnidadeDAO);
  End;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  UnidadeDAO: TUnidadeDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      UnidadeDAO := TUnidadeDao.Create;
      Res.Send<TJsonArray>(UnidadeDAO.GetID(StrToIntDef(Req.Params.Items['id'],
        0))).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(UnidadeDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JSonUnidade: tJsonObject;
  UnidadeDAO: TUnidadeDao;
begin
  Try
    UnidadeDAO := TUnidadeDao.Create;
    Try
      JSonUnidade := tJsonObject.Create;
      JSonUnidade := Req.Body<tJsonObject>;
      UnidadeDAO.InsertUpdate(GetValueInjSon(JSonUnidade, 'id').ToInteger,
        // ObjUnidade.Get('descricao').JsonValue.Value
        GetValueInjSon(JSonUnidade, 'Sigla'), GetValueInjSon(JSonUnidade,
        'descricao'), GetValueInjSon(JSonUnidade, 'status').ToInteger);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    if Assigned(JSonUnidade) then
      FreeAndNil(JSonUnidade);
    FreeAndNil(UnidadeDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjUnidade: tJsonObject;
  UnidadeDAO: TUnidadeDao;
begin
  Try
    Try
      ObjUnidade := tJsonObject.Create;
      ObjUnidade := Req.Body<tJsonObject>;
      UnidadeDAO := TUnidadeDao.Create;
      UnidadeDAO.InsertUpdate(StrToIntDef(Req.Params.Items['id'], 0),
        // ObjUnidade.Get('descricao').JsonValue.Value
        GetValueInjSon(ObjUnidade, 'Sigla'), GetValueInjSon(ObjUnidade,
        'descricao'), GetValueInjSon(ObjUnidade, 'status').ToInteger);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(UnidadeDAO);
    if Assigned(ObjUnidade) then
      FreeAndNil(ObjUnidade);

  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: tJsonObject;
  UnidadeDAO: TUnidadeDao;
begin
  Try
    Try
      UnidadeDAO := TUnidadeDao.Create;
      If UnidadeDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0)) then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          'Registro Exclu�do com Sucesso!'))).Status(THTTPStatus.Ok)
      Else
        raise Exception.Create('N�o foi poss�vel excluir o registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(UnidadeDAO);
  End;
end;

procedure GetUnidade4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  UnidadeDAO: TUnidadeDao;
begin
  Try
    Try
      UnidadeDAO := TUnidadeDao.Create;
      Res.Send<tJsonObject>(UnidadeDAO.GetUnidade4D(Req.Query.Dictionary))
        .Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<tJsonObject>
          (tJsonObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(UnidadeDAO);
  End;
End;

constructor TUnidadeCtrl.Create;
begin
  FUnidade := TUnidade.Create;
end;

destructor TUnidadeCtrl.Destroy;
begin
  FreeAndNil(FUnidade);
  inherited;
end;

End.
