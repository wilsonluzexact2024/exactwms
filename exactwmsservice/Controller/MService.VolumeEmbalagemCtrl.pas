{
  VolumeEmbalagemCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 17/05/2021
  Projeto: uEvolut
}
Unit MService.VolumeEmbalagemCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  VolumeEmbalagemClass,
  Horse,
  System.Types,
  System.JSON,
  System.JSON.Types;

Type

  TVolumeEmbalagemCtrl = Class
  Private
    FVolumeEmbalagem: TVolumeEmbalagem;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjVolumeEmbalagem: TVolumeEmbalagem Read FVolumeEmbalagem
      Write FVolumeEmbalagem;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlVolumeEmbalagem }

uses MService.VolumeEmbalagemDAO, uFuncoes;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('/volumeembalagem', Get)
    .Get('/volumeembalagem/:volumeembalagemid', GetID).Post('/volumeembalagem',
    Insert).Put('/volumeembalagem/:volumeembalagemid', Update)
    .Delete('/volumeembalagem/:volumeembalagemid', Delete)
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  VolumeEmbalagemDAO: TVolumeEmbalagemDao;
  RetornoErro: TJsonArray;
begin
  Try
    Try
      VolumeEmbalagemDAO := TVolumeEmbalagemDao.Create;
      Res.Send<TJsonArray>(VolumeEmbalagemDAO.GetID('0'))
        .Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(VolumeEmbalagemDAO);
  End;
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  VolumeEmbalagemDAO: TVolumeEmbalagemDao;
  RetornoErro: TJsonArray;
begin
  Try
    try
      VolumeEmbalagemDAO := TVolumeEmbalagemDao.Create;
      Res.Send<TJsonArray>(VolumeEmbalagemDAO.GetID(Req.Params.Items
        ['volumeembalagemid'])).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        RetornoErro := TJsonArray.Create;
        RetornoErro.AddElement(tJsonObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(RetornoErro).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(VolumeEmbalagemDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonVolumeEmbalagem: tJsonObject;
  VolumeEmbalagemDAO: TVolumeEmbalagemDao;
begin
  Try
    Try
      VolumeEmbalagemDAO := TVolumeEmbalagemDao.Create;
      jsonVolumeEmbalagem := Req.Body<tJsonObject>;
      with VolumeEmbalagemDAO.ObjVolumeEmbalagemDAO do
      Begin
        EmbalagemId := jsonVolumeEmbalagem.GetValue<Integer>('embalagemId');
        Descricao := jsonVolumeEmbalagem.GetValue<String>('descricao');
        Identificacao := jsonVolumeEmbalagem.GetValue<String>('identificacao');
        Tipo := jsonVolumeEmbalagem.GetValue<string>('tipo');
        Altura := jsonVolumeEmbalagem.GetValue<Double>('altura');
        Largura := jsonVolumeEmbalagem.GetValue<Double>('largura');
        Comprimento := jsonVolumeEmbalagem.GetValue<Double>('comprimento');
        Aproveitamento := jsonVolumeEmbalagem.GetValue<Integer>
          ('aproveitamento');
        Tara := jsonVolumeEmbalagem.GetValue<Double>('tara');
        Capacidade := jsonVolumeEmbalagem.GetValue<Double>('capacidade');
        QtdLacres := jsonVolumeEmbalagem.GetValue<Integer>('qtdLacres');
        CodBarras := jsonVolumeEmbalagem.GetValue<Integer>('codBarras');
        Disponivel := jsonVolumeEmbalagem.GetValue<Integer>('disponivel');
        PrecoCusto := jsonVolumeEmbalagem.GetValue<real>('precoCusto');
        Status := jsonVolumeEmbalagem.GetValue<Integer>('status');
      End;
      VolumeEmbalagemDAO.InsertUpdate(VolumeEmbalagemDAO.ObjVolumeEmbalagemDAO);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(VolumeEmbalagemDAO);
    if Assigned(jsonVolumeEmbalagem) then
      FreeAndNil(jsonVolumeEmbalagem);

  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonVolumeEmbalagem: tJsonObject;
  VolumeEmbalagemDAO: TVolumeEmbalagemDao;
begin
  Try
    Try
      jsonVolumeEmbalagem := Req.Body<tJsonObject>;
      VolumeEmbalagemDAO := TVolumeEmbalagemDao.Create;
      VolumeEmbalagemDAO.ObjVolumeEmbalagemDAO :=
        VolumeEmbalagemDAO.ObjVolumeEmbalagemDAO.JsonToClass
        (jsonVolumeEmbalagem.ToString);
      VolumeEmbalagemDAO.InsertUpdate(VolumeEmbalagemDAO.ObjVolumeEmbalagemDAO);
      Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(VolumeEmbalagemDAO);
    if Assigned(jsonVolumeEmbalagem) then
      FreeAndNil(jsonVolumeEmbalagem);

  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: tJsonObject;
  VolumeEmbalagemDAO: TVolumeEmbalagemDao;
begin
  Try
    Try
      VolumeEmbalagemDAO := TVolumeEmbalagemDao.Create;
      If VolumeEmbalagemDAO.Delete
        (StrToIntDef(Req.Params.Items['volumeembalagemid'], 0)) Then
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Resultado',
          'Registro Exclu�do com Sucesso!'))).Status(THTTPStatus.Created)
      Else
        raise Exception.Create('N�o foi poss�vel Excluir o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<tJsonObject>(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(VolumeEmbalagemDAO);
  End;
end;

constructor TVolumeEmbalagemCtrl.Create;
begin
  FVolumeEmbalagem := TVolumeEmbalagem.Create;
end;

destructor TVolumeEmbalagemCtrl.Destroy;
begin
  FreeAndNil(FVolumeEmbalagem);
  inherited;
end;

End.
