unit MService.RegistroTipoProcessoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections,
  // ProcessoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TRegistroTipoProcessoCtrl = Class
  Private
    // Fun��es de Valida��o
    // FRegistroTipoProcesso : TRegistroTipoProcessoWMS;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    // Property ObjRegistroTipoProcesso: TRegistroTipoProcessoWMS Read FRegistroTipoProcesso Write FRegistroTipoProcesso;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tRegistroTipoProcessoCtrl }

uses MService.RegistroTipoProcessoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/registrotipoprocesso', Get)
    .Get('/registrotipoprocesso/:id', GetID)
    .Get('/registrotipoprocesso/:id/:descricao', GetDescricao)
    .Post('/registrotipoprocesso', Insert).Put('/registrotipoprocesso/:id',
    Update).Delete('/registrotipoprocesso/:id', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RegistroTipoProcessoDAO: TRegistroTipoProcessoDao;
begin
  RegistroTipoProcessoDAO := TRegistroTipoProcessoDao.Create;
  Res.Send<TJSonArray>(RegistroTipoProcessoDAO.GetID(0));
  RegistroTipoProcessoDAO.Destroy;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RegistroTipoProcessoDAO: TRegistroTipoProcessoDao;
begin
  try
    RegistroTipoProcessoDAO := TRegistroTipoProcessoDao.Create;
    Res.Send<TJSonArray>(RegistroTipoProcessoDAO.GetDescricao(Req.Params.Items
      ['descricao'])).Status(THttpStatus.Created);
    RegistroTipoProcessoDAO.Destroy;
  Except
    On E: Exception do
    Begin
      Res.Status(404);
    End;
  end;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RegistroTipoProcessoDAO: TRegistroTipoProcessoDao;
begin
  try
    RegistroTipoProcessoDAO := TRegistroTipoProcessoDao.Create;
    try
      Res.Send<TJSonArray>(RegistroTipoProcessoDAO.GetID
        (StrToInt64Def(Req.Params.Items['id'], 0))).Status(THttpStatus.Created);
    finally
      FreeAndNil(RegistroTipoProcessoDAO)
    end;

  Except
    On E: Exception do
    Begin
      Res.Status(404);
    End;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonRegistroTipoProcesso: TJSONObject;
  RegistroTipoProcessoDAO: TRegistroTipoProcessoDao;
begin
  if Req.Body.IsEmpty then
    raise EHorseException.New.Error('Json com dados n�o enviado ao servidor!');
  Try
    JsonRegistroTipoProcesso := TJSONObject.Create;
    JsonRegistroTipoProcesso := Req.Body<TJSONObject>;
    RegistroTipoProcessoDAO := TRegistroTipoProcessoDao.Create;
    try
      RegistroTipoProcessoDAO.InsertUpdate
        (GetValueInjSon(JsonRegistroTipoProcesso, 'id').ToInt64,
        GetValueInjSon(JsonRegistroTipoProcesso, 'ProcessoId').ToInt64,
        GetValueInjSon(JsonRegistroTipoProcesso, 'RegistroTipoId').ToInt64, 1);
      JsonRegistroTipoProcesso := Nil;
      JsonRegistroTipoProcesso.DisposeOf;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Cadastro de RegistroTipoProcessos Salvo com Sucesso!')))
        .Status(THttpStatus.Created);
    finally
      FreeAndNil(RegistroTipoProcessoDAO);
    end;
  Except
    on E: Exception do
    Begin
      raise EHorseException.New.Error('N�o foi poss�vel salvar os dados!' + #13
        + E.Message);
    End;
  End;

end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjRegistroTipoProcesso: TJSONObject;
  RegistroTipoProcessoDAO: TRegistroTipoProcessoDao;
begin
  if Req.Body.IsEmpty then
    raise EHorseException.New.Error('Json com dados n�o enviado ao servidor!');
  Try
    ObjRegistroTipoProcesso := TJSONObject.Create;
    ObjRegistroTipoProcesso := Req.Body<TJSONObject>;
    RegistroTipoProcessoDAO := TRegistroTipoProcessoDao.Create;
    try
      RegistroTipoProcessoDAO.InsertUpdate(StrToInt64Def(Req.Params.Items['id'],
        0), GetValueInjSon(ObjRegistroTipoProcesso, 'ProcessoId').ToInt64,
        GetValueInjSon(ObjRegistroTipoProcesso, 'RegistroTipoId').ToInt64, 1);
      ObjRegistroTipoProcesso := Nil;
      ObjRegistroTipoProcesso.DisposeOf;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    finally
      FreeAndNil(RegistroTipoProcessoDAO);
    end;
  Except
    on E: Exception do
    Begin
      raise EHorseException.New.Error
        ('N�o foi poss�vel salvar as altera��es dos dados!');
      // Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THTTPStatus.ExpectationFailed);
    End;
  End;

end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  RegistroTipoProcessoDAO: TRegistroTipoProcessoDao;
begin
  Try
    RegistroTipoProcessoDAO := TRegistroTipoProcessoDao.Create;
    try
      RegistroTipoProcessoDAO.Delete(StrToInt64Def(Req.Params.Items['id'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Exclu�do com Sucesso!'))).Status(THttpStatus.NoContent);
    finally
      FreeAndNil(RegistroTipoProcessoDAO);
    end;
  Except
    on E: Exception do
    Begin
      raise EHorseException.New.Error('N�o foi poss�vel Excluir os dados!');
    End;
  End;
end;

constructor TRegistroTipoProcessoCtrl.Create;
begin
  // FRegistroTipoProcesso := TRegistroTipoProcessoWMS.Create;
end;

destructor TRegistroTipoProcessoCtrl.Destroy;
begin
  // FRegistroTipoProcesso.Free;
  inherited;
end;

End.
