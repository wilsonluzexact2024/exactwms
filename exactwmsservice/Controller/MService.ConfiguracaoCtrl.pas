{
  MService.ConfiguracaoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.ConfiguracaoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  // ConfiguracaoClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TConfiguracaoCtrl = Class
  Private
    // Fun��es de Valida��o
    // FConfiguracao : TConfiguracaoWMS;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    // Property ObjConfiguracao: TConfiguracaoWMS Read FConfiguracao Write FConfiguracao;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure DoBackup(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ManutencaoLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetVersion(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tConfiguracaoCtrl }

uses MService.ConfiguracaoDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Get('/v1/configuracao', Get);
  // App.Get('/Configuracao/:id', GetID);
  // App.Get('/Configuracao/:id/:descricao', GetDescricao);
  THorse.Post('/v1/configuracao', Insert);
  THorse.Put('/v1/configuracao', Update);
  THorse.Delete('/v1/configuracao/:id', Delete);
  THorse.Get('/v1/backup', DoBackup);
  THorse.Delete('/v1/manutencaolog', ManutencaoLog);
  THorse.Get('/v1/getversion', GetVersion);
end;

Procedure DoBackup(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      Res.Send<TjsonObject>(ConfiguracaoDAO.Backup);
      ConfiguracaoDAO.Free;
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro',
          'N�o foi poss�vel realizar o backup. ' + E.Message)))
          .Status(THTTPStatus.ExpectationFailed);
        ConfiguracaoDAO.Free;
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      Res.Send<TJSonArray>(ConfiguracaoDAO.GetId(0)).Status(THTTPStatus.Ok);
    Except on E: Exception do Begin
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro', E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

Procedure GetVersion(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ConfiguracaoDAO: TConfiguracaoDao;
  JsonObjectRetorno: TjsonObject;
begin
  Try
    ConfiguracaoDAO := TConfiguracaoDao.Create;
    Try
      JsonObjectRetorno := ConfiguracaoDAO.GetVersion;
      Res.Send<TjsonObject>(JsonObjectRetorno).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjConfiguracao: TjsonObject;
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ObjConfiguracao := TjsonObject.Create;
      ObjConfiguracao := Req.Body<TjsonObject>;
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      // ConfiguracaoDAO.InsertUpdate(GetValueInjSon(ObjConfiguracao, 'id').ToInteger, //Objpessoatipo.Get('descricao').JsonValue.Value
      // GetValueInjSon(ObjConfiguracao, 'pessoatipo').ToInteger );
      ObjConfiguracao := Nil;
      ObjConfiguracao.DisposeOf;
      Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonConfiguracao: TjsonObject;
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      JsonConfiguracao := TjsonObject.Create;
      JsonConfiguracao := Req.Body<TjsonObject>;
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      ConfiguracaoDAO.InsertUpdate(JsonConfiguracao);
      Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado',
        'Configura��es salva com Sucesso!'))).Status(THTTPStatus.Created);
      JsonConfiguracao := Nil;
    Except
      on E: Exception do
      Begin
        JsonConfiguracao := Nil;
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

Procedure ManutencaoLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      Res.Send<TjsonObject>(ConfiguracaoDAO.ManutencaoLog).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
End;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TjsonObject;
  ConfiguracaoDAO: TConfiguracaoDao;
begin
  Try
    Try
      ConfiguracaoDAO := TConfiguracaoDao.Create;
      ConfiguracaoDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0));
      Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
    Except
      on E: Exception do
      Begin
        Res.Send<TjsonObject>(TjsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ConfiguracaoDAO);
  End;
end;

constructor TConfiguracaoCtrl.Create;
begin
  // FConfiguracao := TConfiguracaoWMS.Create;
end;

destructor TConfiguracaoCtrl.Destroy;
begin
  // FConfiguracao.Free;
  inherited;
end;

End.
