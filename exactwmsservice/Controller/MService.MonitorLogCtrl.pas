{
  MService.UsuarioCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 22/04/2021
  Projeto: uEvolut
}
unit MService.MonitorLogCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  Horse, Exactwmsservice.lib.utils,
  Horse.utils.ClientIP,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TMonitorLogCtrl = Class
  Private
    // Fun��es de Valida��o
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
  End;

procedure Registry;
procedure GetListaLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure DeleteLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlUsuario }

uses uFuncoes, Services.MonitorLog;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1').Get('monitorlog/lista', GetListaLog)
    .Delete('monitorlog/delete/:idreq', DeleteLog);
end;

procedure DeleteLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceMonitorLog;
  jsonArrayRetorno, ErroJsonArray: TJsonArray;
  HrInicioLog: TTime;
begin
  Try
    try
      HrInicioLog := Time;
      LService := TServiceMonitorLog.Create;
      jsonArrayRetorno := LService.DeleteLog
        (StrToIntDef(Req.Params.Items['idreq'], 0));
      Res.Send<TJsonArray>(jsonArrayRetorno).Status(THttpStatus.Created);
      // Format('%f seg.', [((Time - HrInicioLog) / 1000)]);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/monitorlog/delete/:idreq', Trim(Req.Params.Content.Text), Req.Body,
        '', jsonArrayRetorno.ToString, 500, ((Time - HrInicioLog) / 1000),
        Req.Headers['appname']);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/monitorlog/delete/:idreq', Trim(Req.Params.Content.Text), Req.Body,
          '', ErroJsonArray.ToString, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']);
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure GetListaLog(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceMonitorLog;
  AQueryParam: TDictionary<String, String>;
  jsonArrayRetorno, ErroJsonArray: TJsonArray;
  xParam: Integer;
  pIdReq: Integer;
  pUsuarioId: Integer;
  pDataInicial, pDataFinal: TDateTime;
  pTerminal, pIpClient, pPorta: String;
  pStatusCode: Integer;
  vParamsOk: Integer;
  pUrl: String;
  HrInicioLog, HrFinalLog: TTime;
begin
  Try
    HrInicioLog := Time;
    try
      pIdReq := 0;
      pUsuarioId := 0;
      pDataInicial := 0;
      pDataFinal := 0;
      pTerminal := '';
      pIpClient := '';
      pPorta := '';
      pStatusCode := 0;
      pUrl := '';
      AQueryParam := Req.Query.Dictionary;
      LService := TServiceMonitorLog.Create;
      If AQueryParam.Count <= 0 then
        Raise Exception.Create('Par�metros da consulta n�o definidos!');
      if AQueryParam.ContainsKey('idreq') then
      Begin
        pIdReq := StrToIntDef(AQueryParam.Items['idreq'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('usuarioid') then
      Begin
        pUsuarioId := StrToIntDef(AQueryParam.Items['usuarioid'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('datainicial') then
      Begin
        pDataInicial := StrToDate(AQueryParam.Items['datainicial']);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('datafinal') then
      Begin
        pDataFinal := StrToDate(AQueryParam.Items['datafinal']);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('terminal') then
      Begin
        pTerminal := AQueryParam.Items['terminal'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('ipclient') then
      Begin
        pIpClient := AQueryParam.Items['ipclient'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('porta') then
      Begin
        pPorta := AQueryParam.Items['porta'];
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('statuscode') then
      Begin
        pStatusCode := StrToIntDef(AQueryParam.Items['statuscode'], 0);
        vParamsOk := vParamsOk + 1;
      End;
      if AQueryParam.ContainsKey('url') then
      Begin
        pUrl := AQueryParam.Items['url'];
        vParamsOk := vParamsOk + 1;
      End;
      HrFinalLog := Time;
      jsonArrayRetorno := LService.GetListaLog(pIdReq, pUsuarioId, pDataInicial,
        pDataFinal, pTerminal, pIpClient, pPorta, pStatusCode, pUrl);
      Res.Send<TJsonArray>(jsonArrayRetorno).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
        Req.Headers['terminal'], ClientIP(Req), THorse.Port,
        '/v1/monitorlog/lista', Trim(Req.Params.Content.Text), Req.Body, '',
        'Retorno: ' + jsonArrayRetorno.Count.ToString + ' Registros.', 201,
        ((HrFinalLog - HrInicioLog) / 1000), Req.Headers['appname']);
    Except
      On E: Exception do
      Begin
        ErroJsonArray := TJsonArray.Create;
        ErroJsonArray.AddElement(tJsonObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0),
          Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          'v1/monitorlog/lista', Trim(Req.Params.Content.Text), Req.Body, '',
          ErroJsonArray.ToString, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']);
        Res.Status(500).Send<TJsonArray>(ErroJsonArray);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
end;

{ TMonitorLogCtrl }

constructor TMonitorLogCtrl.Create;
begin
  //
end;

destructor TMonitorLogCtrl.Destroy;
begin
  //
  inherited;
end;

End.
