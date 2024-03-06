{
  VolumeEmbalagemCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.CargasCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  CargasClass,
  Horse,
  Horse.Utils.ClientIP,
  System.Types,
  System.JSON,
  System.JSON.Types;

Type

  TCargasCtrl = Class
  Private
    FCarga: TCargas;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjCarga: TCargas Read FCarga Write FCarga;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCargaCarregarPedidos(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetCargaCarregarClientes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetCargaCarregarVolumes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetCargaCarregarVolumesPessoa(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure CancelarCarregamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure CancelarConferencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure CancelarCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);

Procedure CargaCarregamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure CargaCarregamentoFinalizar(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetCargaHearder(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaPessoas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaPedidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCargaPedidosRomaneio(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetCargaNotaFiscal(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetCargaPedidoVolumes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetMapaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure CargaLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PedidosParaCargas(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure PedidosParaCargasNFs(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetRelAnaliseConsolidada(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetResumoCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure PutAtualizarStatus(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);

implementation

{ tCtrlVolumeEmbalagem }

uses MService.CargasDAO, uFuncoes, exactwmsservice.lib.utils;

procedure Registry;
begin
  THorse.Group
  .Prefix('v1')
    .Get('/cargas', Get)
    .Get('/cargas4D', Get4D)
    .Get('/cargas/clientes/:cargaid', GetCargaCarregarClientes)
    .Get('/cargas/pedidos/:cargaid', GetCargaCarregarPedidos)
    .Get('/cargas/volumes/:cargaid/:pessoaid', GetCargaCarregarVolumesPessoa)
    .Delete('/cargas/cancelarcarregamento/:cargaid', CancelarCarregamento)
    .Delete('/cargas/cancelarconferencia/:cargaid', CancelarConferencia)
    .Post('/cargas', Insert)
    .Put('/cargas/:cargaid', Update)
    .Post('/cargas/carregamento', CargaCarregamento) // Registrar Carregamento
    .Put('/cargas/carregamentofinalizar', CargaCarregamentoFinalizar)
    .Delete('/cargas/:cargaid', Delete)
    .Get('/cargas/hearder/:cargaid', GetCargaHearder)
    .Get('/cargas/pessoas/:cargaid', GetCargaPessoas)
    .Get('/cargas/pedidos/:cargaid/:pessoaid/:processo', GetCargaPedidos)
    .Get('/cargas/pedidos/romaneio/:cargaid/:pessoaid/:processo', GetCargaPedidosRomaneio)
    .Get('/cargas/notafiscal/:cargaid', GetCargaNotaFiscal)
  // .Get('/cargas/volumes/:cargaid/:processo', GetCargaPedidoVolumes)     //
    .Get('/cargas/conferirvolumes/:cargaid/:processo', GetCargaPedidoVolumes)
  // GetCargaCarregarVolumes)
    .Get('/cargas/mapacarga/:cargaid', GetMapaCarga)
    .Get('/cargas/lista/:cargaid/:rotaid/:processoid/:pendente', CargaLista)
    .Put('/cargas/cancelar', CancelarCarga)
    .Get('/cargas/pedidosparacarga', PedidosParaCargas)
    .Get('/cargas/pedidosparacarganfs', PedidosParaCargasNFs)
    .Get('/cargas/analiseconsolidada', GetRelAnaliseConsolidada)
    .Get('/cargas/resumo', GetResumoCarga)
    .Put('/cargas/atualizarstatus', PutAtualizarStatus)
end;

Procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ObjCargasDAO: TCargasDao;
begin
  Try
    Try
      ObjCargasDAO := TCargasDao.Create;
      Res.Send(ObjCargasDAO.Get4D(Req.Query.Dictionary))
        .Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
      FreeAndNil(ObjCargasDAO);
  End;
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ObjCargaDAO: TCargasDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.Get(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

Procedure GetRelAnaliseConsolidada(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ObjCargaDAO: TCargasDao;
  JsonArrayErro: TJsonArray;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetRelAnaliseConsolidada
        (Req.Query.Dictionary)).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.ExpectationFailed).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetResumoCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ObjCargaDAO: TCargasDao;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
begin
  Try
    ObjCargaDAO := TCargasDao.Create;
    Try
      JsonArrayRetorno := ObjCargaDAO.GetResumoCarga(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno);
    Except
      on E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

procedure GetCargaCarregarClientes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaCarregarClientes
        (StrToIntDef(Req.Params.Items['cargaid'], 0))).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure GetCargaCarregarPedidos(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaCarregarPedidos
        (StrToIntDef(Req.Params.Items['cargaid'], 0))).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure GetCargaCarregarVolumes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaCarregarVolumes
        (StrToIntDef(Req.Params.Items['cargaid'], 0), 0,
        Req.Params.Items['processo'])).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;end;

procedure GetCargaCarregarVolumesPessoa(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaCarregarVolumes
        (StrToIntDef(Req.Params.Items['cargaid'], 0),
        StrToIntDef(Req.Params.Items['pessoaid'], 0),
        Req.Params.Items['processo'])).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      JsonArrayRetorno := ObjCargaDAO.InsertUpdate(0, Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create.AddPair('cargaid',
        TJsonNumber.Create(JsonArrayRetorno.Items[0].GetValue<Integer>('cargaid'))
        )).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.InsertUpdate(StrToIntDef(Req.Params.Items['cargaid'], 0),
        Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;end;

procedure CargaCarregamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CargaCarregamento(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registrado com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure CargaCarregamentoFinalizar(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CargaCarregamentoFinalizar(Req.Body<TJSONObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Carregamento Finalizado com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

Procedure CancelarCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
   Try
     ObjCargaDAO := TCargasDao.Create;
     ObjCargaDAO.CancelarCarga(TJSONObject.ParseJSONValue(Req.Body)
       as TJSONObject);
     Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
       'Carregamento Cancelado com Sucesso!'))).Status(THTTPStatus.Created);
   Except
     on E: Exception do
     Begin
       Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
         E.Message))).Status(THTTPStatus.ExpectationFailed);
     End;
   End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

procedure CancelarCarregamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CancelarCarregamento
        (StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Carregamento Cancelado com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure CancelarConferencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.CancelarConferencia
        (StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Confer�ncia Cancelado com Sucesso!'))).Status(THTTPStatus.ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      ObjCargaDAO.Delete(StrToIntDef(Req.Params.Items['cargaid'], 0),
        (TJSONObject.ParseJSONValue(Req.Body) as TJSONObject));
      // Req.Body<TJsonObject>);
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Exclu�do com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
end;

constructor TCargasCtrl.Create;
begin
  FCarga := TCargas.Create;
end;

destructor TCargasCtrl.Destroy;
begin
  FCarga.Free;
  inherited;
end;

Procedure GetCargaHearder(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaHearder
        (StrToIntDef(Req.Params.Items['cargaid'], 0))).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPessoas(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaPessoas
        (StrToIntDef(Req.Params.Items['cargaid'], 0))).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPedidos(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaPedidos
        (StrToIntDef(Req.Params.Items['cargaid'], 0),
        StrToIntDef(Req.Params.Items['pessoaid'], 0),
        Req.Params.Items['processo'])).Status(THTTPStatus.OK);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaNotaFiscal(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
  HrInicioLog: TTime;
  JsonRetorno: TJsonArray;
  JsonErro: TJsonArray;
begin
  Try
    HrInicioLog := Time;
    Try
      If StrToIntDef(Req.Params.Items['cargaid'], 0) <= 0 then
      Begin
        JsonErro := TJsonArray.Create();
        JsonErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          'Par�metros da consulta(Id da Carga) n�o definido!')));
        Res.Send<TJsonArray>(JsonErro).Status(THTTPStatus.BadRequest);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, 'v1/cargas/notafiscal/:cargaid',
          Trim(Req.Params.Content.Text), Req.Body, '',
          'Par�metros da consulta(Id da Carga) n�o definido!', 403,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname']);
        JsonErro := Nil;
        ObjCargaDAO.Free;
        Exit;
      End;
      ObjCargaDAO := TCargasDao.Create;
      JsonRetorno := ObjCargaDAO.GetCargaNotaFiscal
        (StrToIntDef(Req.Params.Items['cargaid'], 0));
      Res.Send<TJsonArray>(JsonRetorno).Status(THTTPStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
        0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/cargas/notafiscal/:cargaid', Trim(Req.Params.Content.Text), Req.Body,
        '', 'Retorno: ' + JsonRetorno.Count.ToString + ' Registros.', 201,
        ((Time - HrInicioLog) / 1000), Req.Headers['appname']);
    Except
      on E: Exception do
      Begin
        JsonErro := TJsonArray.Create;
        JsonErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonErro).Status(THTTPStatus.InternalServerError);
        Tutil.SalvarLog(Req.MethodType,
          StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'],
          ClientIP(Req), THorse.Port, '/v1/saida', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']);
        JsonErro := Nil;
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPedidosRomaneio(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaPedidosRomaneio
        (StrToIntDef(Req.Params.Items['cargaid'], 0),
        StrToIntDef(Req.Params.Items['pessoaid'], 0),
        Req.Params.Items['processo'])).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetCargaPedidoVolumes(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetCargaPedidoVolumes
        (StrToIntDef(Req.Params.Items['cargaid'], 0),
        Req.Params.Items['processo'])).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;End;

Procedure CargaLista(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>
        (ObjCargaDAO.CargaLista(StrToIntDef(Req.Params.Items['cargaid'], 0),
        StrToIntDef(Req.Params.Items['rotaid'], 0),
        StrToIntDef(Req.Params.Items['processoid'], 0),
        StrToIntDef(Req.Params.Items['pendente'], 0))).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure GetMapaCarga(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.GetMapaCarga
        (StrToIntDef(Req.Params.Items['cargaid'], 0))).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure PedidosParaCargas(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.PedidosParaCargas(Req.Query.Dictionary)).Status(THTTPStatus.ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure PedidosParaCargasNFs(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.PedidosParaCargasNFs
        (Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

Procedure PutAtualizarStatus(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ObjCargaDAO: TCargasDao;
Begin
  Try
    Try
      ObjCargaDAO := TCargasDao.Create;
      Res.Send<TJsonArray>(ObjCargaDAO.PutAtualizarStatus(Req.Body<TJSONObject>)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
        // Status(THTTPStatus.Created);
      End;
    End;
  Finally
    FreeAndNil(ObjCargaDAO);
  End;
End;

End.
