{
  PerfilCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.PerfilCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  PerfilClass,
  Horse,
  Horse.Utils.ClientIP,
  System.JSON,
  Exactwmsservice.lib.Utils; // , uTHistoric;

Type
  TipoConsulta = (Resumida, Completa);

  TPerfilCtrl = Class
  Private
    // Fun��es de Valida��o
    FPerfil: TPerfil;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjPerfil: TPerfil Read FPerfil Write FPerfil;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPerfil4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ControleAcessoFuncionalidades(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ControleAcessoTopicos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SalvarAcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AtualizarPermissao(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlPerfil }

uses MService.PerfilDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group
  .Prefix('v1')
    .Get('/perfil', Get)
    .Get('/perfil/:perfilid', GetId)
    .Get('/perfil4D', GetPerfil4D)
    .Get('/perfil/controleacessofuncionalidades/:perfilid/:listatopicos', ControleAcessoFuncionalidades)
    .Get('/perfil/controleacessotopicos/:perfilid', ControleAcessoTopicos)
    .Post('/perfil', Insert)
    .Put('/perfil/:perfilid', Update)
    .Put('/perfil/atualizar/:perfilid', AtualizarPermissao)
    .Put('/perfil/salvaracesso/:perfilid', SalvarAcesso)
    .Delete('/perfil/:perfilid', Delete)
end;

Procedure AtualizarPermissao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PerfilDAO: TPerfilDao;
begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      Res.Send<TJsonArray>(PerfilDAO.AtualizarPermissao(StrToIntDef(Req.Params.Items['perfilid'], 0)));
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
End;
Procedure ControleAcessoFuncionalidades(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var PerfilDAO: TPerfilDao;
begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      Res.Send<TJSONObject>(PerfilDAO.ControleAcessoFuncionalidades(StrToIntDef(Req.Params.Items['perfilid'], 0),
                            Req.Params.Items['listatopicos']));
    Except On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
End;

Procedure ControleAcessoTopicos(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  PerfilDAO: TPerfilDao;
begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      Res.Send<TJSONObject>(PerfilDAO.ControleAcessoTopicos(StrToIntDef(Req.Params.Items['perfilid'], 0))).Status(THTTPStatus.OK);
    Except on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
            E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
End;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PerfilDAO: TPerfilDao;
  ErroJsonArray: TjsonArray;
Begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      Res.Send<TjsonArray>(PerfilDAO.Estrutura).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(PerfilDAO);
  End;
End;

procedure GetPerfil4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PerfilDAO: TPerfilDao;
begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      Res.Send<TJSONObject>(PerfilDAO.GetPerfil4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PerfilDAO: TPerfilDao;
  ErroJsonArray: TjsonArray;
begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      Res.Send<TjsonArray>(PerfilDAO.GetId('0')).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
end;

procedure GetId(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  PerfilDAO: TPerfilDao;
  ErroJsonArray: TjsonArray;
begin
  Try
    try
      PerfilDAO := TPerfilDao.Create;
      Res.Send<TjsonArray>(PerfilDAO.GetId(Req.Params.Items['perfilid']))
        .Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TjsonArray.Create;
        ErroJsonArray.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TjsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(PerfilDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PerfilDAO: TPerfilDao;
begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      // PerfilDAO.ObjPerfil := PerfilDAO.ObjPerfil.JsonToClass(jsonPerfil.ToString());
      if PerfilDAO.Salvar(Req.Body<TJSONObject>) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created)
      Else
        raise Exception.Create('N�o Foi PRegistro salvo com Sucesso!');
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PerfilDAO: TPerfilDao;
begin
  Try
    PerfilDAO := TPerfilDao.Create;
    Try
      // PerfilDAO.ObjPerfil := PerfilDAO.ObjPerfil.JsonToClass(req.Body<tJsonObject>.ToString());
      if PerfilDAO.Salvar(Req.Body<TJSONObject>) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created)
      Else
        raise Exception.Create('N�o foi poss�vel salvar o Perfil!');
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  PerfilDAO: TPerfilDao;
  HrInicioLog: TTime;
begin
  HrInicioLog := Time;
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      PerfilDAO.ObjPerfil.Perfilid := StrToIntDef(Req.Params.Items['perfilid'], 0);
      If PerfilDAO.Delete Then Begin
         Res.Status(200).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Registro exclu�do com Sucesso!'))).Status(THTTPStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                         'v1/perfil/:perfilid', Trim(Req.Params.Content.Text), Req.Body, '', 'Exclu�do com sucesso!',
                         201, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);

      End
      Else Begin
         Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado', 'Exclus�o n�o permitida!'))).Status(THTTPStatus.Created);
         Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                'v1/perfil/:perfilid', Trim(Req.Params.Content.Text), Req.Body, '', 'Exclus�o n�o permitida!',
                500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    Except on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                'v1/perfil/:perfilid', Trim(Req.Params.Content.Text), Req.Body, '', E.Message,
                500, ((Time - HrInicioLog) / 1000), Req.Headers['appname'] + '_V: ' + Req.Headers['versao']);
      End;
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
end;

Procedure SalvarAcesso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  PerfilDAO: TPerfilDao;
begin
  Try
    Try
      PerfilDAO := TPerfilDao.Create;
      PerfilDAO.SalvarAcesso(StrToIntDef(Req.Params.Items['perfilid'], 0), Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Controle de Acesso Rgistrado com Sucesso!'))).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
    End;
  Finally
    FreeAndNil(PerfilDAO);
  End;
end;

constructor TPerfilCtrl.Create;
begin
  FPerfil := TPerfil.Create;
end;

destructor TPerfilCtrl.Destroy;
begin
  FreeAndNil(FPerfil);
  inherited;
end;

End.
