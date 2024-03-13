unit MService.RegistroTipoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections,
  // ProcessoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TRegistroTipoCtrl = Class
  Private
    // Fun��es de Valida��o
    // FRegistroTipo : TRegistroTipoWMS;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    // Property ObjRegistroTipo: TRegistroTipoWMS Read FRegistroTipo Write FRegistroTipo;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tRegistroTipoCtrl }

uses MService.RegistroTipoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/registrotipo', Get).Get('/registrotipo/:id',
    GetID).Get('/registrotipo/:id/:descricao', GetDescricao)
    .Post('/registrotipo', Insert).Put('/registrotipo/:id', Update)
    .Delete('/registrotipo/:id', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RegistroTipoDAO: TRegistroTipoDao;
begin
  Try
    RegistroTipoDAO := TRegistroTipoDao.Create;
    try
      Res.Send<TJSonArray>(RegistroTipoDAO.GetID(0));
    finally
      FreeAndNil(RegistroTipoDAO);
    end;

  Except
    ON E: Exception do
      raise EHorseException.New.Error('N�o foi poss�vel consultar os dados!' +
        #13 + E.Message);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RegistroTipoDAO: TRegistroTipoDao;
begin
  try
    RegistroTipoDAO := TRegistroTipoDao.Create;
    try
    Res.Send<TJSonArray>(RegistroTipoDAO.GetDescricao(Req.Params.Items
      ['descricao'])).Status(THttpStatus.Created);
    finally
       FreeAndNil(RegistroTipoDAO)
    end;

  Except
    On E: Exception do
      raise EHorseException.New.Error('N�o foi poss�vel consultar os dados!' +
        #13 + E.Message);
  end;
End;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  RegistroTipoDAO: TRegistroTipoDao;
begin
  try
    RegistroTipoDAO := TRegistroTipoDao.Create;
    try
    Res.Send<TJSonArray>
      (RegistroTipoDAO.GetID(StrToInt64Def(Req.Params.Items['id'], 0)))
      .Status(THttpStatus.Created);
    finally
       FreeAndNil(RegistroTipoDAO)
    end;

  Except
    On E: Exception do
    Begin
      raise EHorseException.New.Error('N�o foi poss�vel consultar os dados!' +
        #13 + E.Message);
    End;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonRegistroTipo: TJSONObject;
  RegistroTipoDAO: TRegistroTipoDao;
begin
  if Req.Body.IsEmpty then
    raise EHorseException.New.Error('Json com dados n�o enviado ao servidor!');
  Try
    JsonRegistroTipo := TJSONObject.Create;
    try
      JsonRegistroTipo := Req.Body<TJSONObject>;
      RegistroTipoDAO := TRegistroTipoDao.Create;
      RegistroTipoDAO.InsertUpdate(GetValueInjSon(JsonRegistroTipo, 'id')
        .ToInt64, GetValueInjSon(JsonRegistroTipo, 'descricao'),
        GetValueInjSon(JsonRegistroTipo, 'registro_tipo').ToInt64, 1);
      JsonRegistroTipo := Nil;
    finally
      FreeAndNil(RegistroTipoDAO)
    end;
    JsonRegistroTipo.DisposeOf;
    Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
      'Cadastro de RegistroTipos Salvo com Sucesso!')))
      .Status(THttpStatus.Created);
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
  ObjRegistroTipo: TJSONObject;
  RegistroTipoDAO: TRegistroTipoDao;
begin
  if Req.Body.IsEmpty then
    raise EHorseException.New.Error('Json com dados n�o enviado ao servidor!');
  Try
    ObjRegistroTipo := TJSONObject.Create;
    ObjRegistroTipo := Req.Body<TJSONObject>;
    RegistroTipoDAO := TRegistroTipoDao.Create;
    try
      RegistroTipoDAO.InsertUpdate(StrToInt64Def(Req.Params.Items['id'], 0),
        GetValueInjSon(ObjRegistroTipo, 'descricao'),
        GetValueInjSon(ObjRegistroTipo, 'registro_tipo').ToInt64(), 1);
      ObjRegistroTipo := Nil;

      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    finally
      FreeAndNil(RegistroTipoDAO);
    end;
  Except
    on E: Exception do
      raise EHorseException.New.Error
        ('N�o foi poss�vel salvar as altera��es dos dados!');
  End;

end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  RegistroTipoDAO: TRegistroTipoDao;
begin
  Try
    RegistroTipoDAO := TRegistroTipoDao.Create;
    try
      RegistroTipoDAO.Delete(StrToInt64Def(Req.Params.Items['id'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Exclu�do com Sucesso!'))).Status(THttpStatus.NoContent);
    finally
      FreeAndNil(RegistroTipoDAO);
    end;
  Except
    on E: Exception do
      raise EHorseException.New.Error('N�o foi poss�vel Excluir os dados!');
  End;
end;

constructor TRegistroTipoCtrl.Create;
begin
  // FRegistroTipo := TRegistroTipoWMS.Create;
end;

destructor TRegistroTipoCtrl.Destroy;
begin
  // FRegistroTipo.Free;
  inherited;
end;

End.
