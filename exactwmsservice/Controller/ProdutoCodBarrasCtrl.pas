{
  ProdutoCodBarrasCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit ProdutoCodBarrasCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  ProdutoCodBarrasClass,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TProdutoCodBarrasCtrl = Class
  Private
    // Fun��es de Valida��o
    FProdutoCodBarras: TProdutoCodBarras;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjProdutoCodBarras: TProdutoCodBarras Read FProdutoCodBarras
      Write FProdutoCodBarras;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCodBarras(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlProdutoCodBarras }

uses ProdutoCodBarrasDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/produtocodbarras', Get)
    .Get('/produtocodbarras/:codbarrasid/:produtoid/:codbarras', GetCodBarras)
    .Post('/produtocodbarras', Insert).Put('/produtocodbarras/:codbarrasid',
    Update).Delete('/produtocodbarras/:codbarrasid', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
  RetornoErro: TJsonArray;
begin
  Try
    Try
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      Res.Send<TJsonArray>(ProdutoCodBarrasDAO.GetProdutoCodBarras(0, 0, 'Null')
        ).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
end;

procedure GetCodBarras(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
  RetornoErro: TJsonArray;
begin
  Try
    try
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      Res.Send<TJsonArray>(ProdutoCodBarrasDAO.GetProdutoCodBarras
        (Req.Params.Items['codbarrasid'].ToInteger(),
        Req.Params.Items['produtoid'].ToInteger(), Req.Params.Items['codbarras']
        )).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjJson: tJsonObject;
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
begin
  Try
    Try
      ObjJson := Req.Body<tJsonObject>;
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      ProdutoCodBarrasDAO.ProdutoCodBarras :=
        ProdutoCodBarrasDAO.ProdutoCodBarras.JsonToClass(ObjJson.ToString());
      if ProdutoCodBarrasDAO.Salvar then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created)
      Else
        raise Exception.Create('N�o foi poss�vel Salvar o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
    if Assigned(ObjJson) then
      FreeAndNil(ObjJson);

  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  JsonProdutoCodBarras: tJsonObject;
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
  ObjProdutoCodBarras: TProdutoCodBarras;
begin
  Try
    Try
      JsonProdutoCodBarras := Req.Body<tJsonObject>;
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      ProdutoCodBarrasDAO.ProdutoCodBarras :=
        ProdutoCodBarrasDAO.ProdutoCodBarras.JsonToClass
        (JsonProdutoCodBarras.ToString());
      // ObjProdutoCodBarras := ProdutoCodBarrasDAO.ProdutoCodBarras.JsonToClass(JsonProdutoCodBarras.ToString());
      if ProdutoCodBarrasDAO.Salvar then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created)
      Else
        raise Exception.Create('Error N�o poss�vel Salvar o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
    if Assigned(JsonProdutoCodBarras) then
      FreeAndNil(JsonProdutoCodBarras);

  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: tJsonObject;
  ProdutoCodBarrasDAO: TProdutoCodBarrasDao;
begin
  Try
    Try
      ProdutoCodBarrasDAO := TProdutoCodBarrasDao.Create;
      ProdutoCodBarrasDAO.ProdutoCodBarras.CodBarrasId :=
        StrToIntDef(Req.Params.Items['codbarrasid'], 0);
      If ProdutoCodBarrasDAO.Delete then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          'Registro Alterado com Sucesso!'))).Status(THTTPStatus.OK)
      Else
        raise Exception.Create('N�o foi poss�vel Excluir o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoCodBarrasDAO);
  End;
end;

constructor TProdutoCodBarrasCtrl.Create;
begin
  FProdutoCodBarras := TProdutoCodBarras.Create;
end;

destructor TProdutoCodBarrasCtrl.Destroy;
begin
  FreeAndNil(FProdutoCodBarras);
  inherited;
end;

End.
