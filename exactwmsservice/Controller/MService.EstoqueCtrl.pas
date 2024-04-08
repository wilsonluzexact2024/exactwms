{
  EstoqueCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automa��o Comercial) em 09/09/2020
  Projeto: RhemaWMS
}
unit MService.EstoqueCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  EstoqueClass, Web.HTTPApp,
  Horse,
  System.JSON; // , uTHistorico;

Type
  TipoConsulta = (Resumida, Completa);

  TEstoqueCtrl = Class
  Private
    // Fun��es de Valida��o
    FEstoque: TEstoque;
  Public
    // Rotinas P�blica (CRUD)
    constructor Create;
    destructor Destroy; override;
    Property ObjEstoque: TEstoque Read FEstoque Write FEstoque;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure ConsultaKardex(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetEstoqueLotePorTipo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetRelEstoqueLotePorTipo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetEstoqueEnderecoPorTipo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure GetEstoqueEnderecoPorTipoDetalhes(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
Procedure GetRelEstoqueSaldo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetRelEstoquePreOrVencido(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetEstoqueProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetMovimentacaoInterna(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetListaTransferencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
// Produtos dispon�veis da Coleta de Reposi��o para ser transferido para Picking
Procedure GetMotivoMovimentacaoSegregado(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
Procedure GetEstoqueSemPicking(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure ValidarMovimentacaoPallet(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure GetControleArmazenagem(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Procedure SalvarEstoqueChecklist(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);

implementation

{ tCtrlEstoque }

uses MService.EstoqueDAO, uFuncoes, Horse.Utils.ClientIP,
  exactwmsservice.lib.utils;

// uses UDmRhemaWMS, uFrmRhemaWms; //, uFrmPesquisa

procedure Registry;
begin
  THorse.Group.Prefix('v1')
    .Get('/estoque/:produtoid/:loteid/:enderecoid/:estoquetipoid/:producao/:distribuicao/:zerado/:negativo', Get)
    .Get('/estoque/kardex', ConsultaKardex)
    .Get('/estoqueenderecoportipodetalhes', GetEstoqueEnderecoPorTipoDetalhes)
    .Get('/estoque/saldo', GetRelEstoqueSaldo)
    .Get('/estoque/preorvencido', GetRelEstoquePreOrVencido)
    .Get('/estoqueloteportipo/:produtoid/:loteid/:enderecoid/:estoquetipoid/:producao/:distribuicao/:zerado/:negativo', GetEstoqueLotePorTipo)
    .Get('/estoque/lote/:produtoid/:loteid/:enderecoid/:zonaid/:estoquetipoid/:producao/:distribuicao/:zerado/:negativo/:ordem', GetRelEstoqueLotePorTipo)
    .Get('/estoque/produto', GetEstoqueProduto)
    .Get('/estoqueenderecoportipo/:produtoid/:loteid/:enderecoid/:estoquetipoid/:producao/:distribuicao/:zerado/:negativo', GetEstoqueEnderecoPorTipo)
    .Put('/estoque', Update)
    .Put('/estoque/checklist', SalvarEstoqueChecklist)
    .Delete('/estoque/:loteid/:enderecoid/:estoquetipoid', Delete)
    .Get('/estoque/movimentacaointerna', GetMovimentacaoInterna)
    .Get('/estoque/listatransferencia', GetListaTransferencia)
    .Get('/estoque/motivomovimentacaosegregado/:ativo', GetMotivoMovimentacaoSegregado)
    .Get('/estoquesempicking', GetEstoqueSemPicking)
    .Get('/estoque/validarmovimentacaopallet', ValidarMovimentacaoPallet)
    .Get('/estoque/controlearmazenagem', GetControleArmazenagem)

end;

procedure ConsultaKardex(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  AQueryParam: TDictionary<String, String>;
  EstoqueDAO: TEstoqueDao;
  vUsuarioId: Integer;
  vDataInicial: TDateTime;
  vDataFinal: TDateTime;
  vCodigoERP: Integer;
  vNomeEstacao: String;
  vOrigem: String;
  vDestino: String;
  JsonArrayRetorno: TJsonArray;
Begin
  Try
    Try
      EstoqueDAO := TEstoqueDao.Create;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para consultar o Kardex!')))
          .Status(THTTPStatus.Created)
      Else
      Begin
        if AQueryParam.ContainsKey('usuarioid') then
          vUsuarioId := StrToIntDef(AQueryParam.Items['usuarioid'], 0)
        Else
          vUsuarioId := 0;
        if AQueryParam.ContainsKey('datainicial') then
          vDataInicial := StrToDate(AQueryParam.Items['datainicial'])
        Else
          vDataInicial := 0;
        if AQueryParam.ContainsKey('datafinal') then
          vDataFinal := StrToDate(AQueryParam.Items['datafinal'])
        Else
          vDataFinal := 0;
        if AQueryParam.ContainsKey('codigoerp') then
          vCodigoERP := StrToIntDef(AQueryParam.Items['codigoerp'], 0)
        Else
          vCodigoERP := 0;
        if AQueryParam.ContainsKey('nomeestacao') then
          vNomeEstacao := AQueryParam.Items['nomeestacao']
        Else
          vNomeEstacao := '';
        if AQueryParam.ContainsKey('origem') then
          vOrigem := AQueryParam.Items['origem']
        Else
          vOrigem := '';
        if AQueryParam.ContainsKey('destino') then
          vDestino := AQueryParam.Items['destino']
        Else
          vDestino := '';
        Res.Send<TJsonArray>(EstoqueDAO.ConsultaKardex(vUsuarioId, vDataInicial,
          vDataFinal, vCodigoERP, vNomeEstacao, vOrigem, vDestino))
          .Status(THTTPStatus.Created);
      End;
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno)
          .Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      Res.Send<TJsonArray>(EstoqueDAO.Get(Req.Params.Items['produtoid']
        .ToInteger, Req.Params.Items['loteid'].ToInteger,
        Req.Params.Items['enderecoid'].ToInteger,
        Req.Params.Items['estoquetipoid'].ToInteger,
        Req.Params.Items['producao'].ToInteger, Req.Params.Items['distribuicao']
        .ToInteger, Req.Params.Items['zerado'], Req.Params.Items['negativo']))
        .Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno)
          .Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
end;

Procedure ValidarMovimentacaoPallet(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  Result: TJsonArray;
  AQueryParam: TDictionary<String, String>;
begin
  Try
    try
      AQueryParam := Req.Query.Dictionary;
      EstoqueDAO := TEstoqueDao.Create;
      Res.Send<TJsonArray>(EstoqueDAO.ValidarMovimentacaoPallet(AQueryParam))
        .Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Result.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(Result).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

Procedure GetEstoqueSemPicking(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  Result: TJsonArray;
  AQueryParam: TDictionary<String, String>;
begin
  Try
    try
      AQueryParam := Req.Query.Dictionary;
      EstoqueDAO := TEstoqueDao.Create;
      Res.Send<TJsonArray>(EstoqueDAO.GetEstoqueSemPicking(AQueryParam))
        .Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(Result);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

procedure GetEstoqueEnderecoPorTipo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  Result: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      Res.Send<TJsonArray>(EstoqueDAO.GetEstoqueEnderecoPorTipo(Req.Params.Items
        ['produtoid'].ToInteger, Req.Params.Items['loteid'].ToInteger,
        Req.Params.Items['enderecoid'].ToInteger,
        Req.Params.Items['estoquetipoid'].ToInteger,
        Req.Params.Items['producao'].ToInteger, Req.Params.Items['distribuicao']
        .ToInteger, Req.Params.Items['zerado'], Req.Params.Items['negativo']))
        .Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(Result);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

procedure GetEstoqueEnderecoPorTipoDetalhes(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      Res.Send<TJsonArray>(EstoqueDAO.GetEstoqueEnderecoPorTipoDetalhes
        (Req.Query.Dictionary)).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayRetorno)
          .Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

Procedure GetEstoqueProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  Result: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      Res.Send<TJsonArray>(EstoqueDAO.GetEstoqueProduto(Req.Query.Dictionary))
        .Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(Result);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

Procedure GetRelEstoquePreOrVencido(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      JsonArrayRetorno := EstoqueDAO.GetRelEstoquePreOrVencido
        (Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

Procedure GetRelEstoqueSaldo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      JsonArrayRetorno := EstoqueDAO.GetRelEstoqueSaldo(Req.Query.Dictionary);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

Procedure GetListaTransferencia(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  Result: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      Res.Send<TJsonArray>(EstoqueDAO.GetListaTransferencia)
        .Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(Result);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
end;

Procedure GetMovimentacaoInterna(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  AQueryParam: TDictionary<String, String>;
  EstoqueDAO: TEstoqueDao;
  vUsuarioId: Integer;
  vDataInicial: TDateTime;
  vDataFinal: TDateTime;
  vCodProduto: Integer;
  vEnderecoOrigem: String;
  vEnderecoDestino: String;
  vArmazenagem: Integer;
  vMovInterna: Integer;
  Result: TJsonArray;
  HrInicioLog: TTime;
  JsonArrayRetorno: TJsonArray;
begin
  HrInicioLog := Time;
  Try
    Try
      EstoqueDAO := TEstoqueDao.Create;
      AQueryParam := Req.Query.Dictionary;
      If AQueryParam.Count <= 0 then
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          'Defina os par�metros para consultar a movimenta��o!')))
          .Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/estoque/movimentacaointerna', Trim(Req.Params.Content.Text),
          Req.Body, '', 'Defina os par�metros para consultar o Kardex!', 201,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname']);
      End
      Else
      Begin
        if AQueryParam.ContainsKey('usuarioid') then
          vUsuarioId := StrToIntDef(AQueryParam.Items['usuarioid'], 0)
        Else
          vUsuarioId := 0;
        if AQueryParam.ContainsKey('datainicial') then
          vDataInicial := StrToDate(AQueryParam.Items['datainicial'])
        Else
          vDataInicial := 0;
        if AQueryParam.ContainsKey('datafinal') then
          vDataFinal := StrToDate(AQueryParam.Items['datafinal'])
        Else
          vDataFinal := 0;
        if AQueryParam.ContainsKey('codproduto') then
          vCodProduto := StrToIntDef(AQueryParam.Items['codproduto'], 0)
        Else
          vCodProduto := 0;
        if AQueryParam.ContainsKey('enderecoorigem') then
          vEnderecoOrigem := AQueryParam.Items['enderecoorigem']
        Else
          vEnderecoOrigem := '';
        if AQueryParam.ContainsKey('enderecodestino') then
          vEnderecoDestino := AQueryParam.Items['enderecodestino']
        Else
          vEnderecoDestino := '';
        if AQueryParam.ContainsKey('armazenagem') then
          vArmazenagem := StrToIntDef(AQueryParam.Items['armazenagem'], 0)
        Else
          vArmazenagem := 0;
        if AQueryParam.ContainsKey('movinterna') then
          vMovInterna := StrToIntDef(AQueryParam.Items['movinterna'], 0)
        Else
          vMovInterna := 0;
        JsonArrayRetorno := EstoqueDAO.GetMovimentacaoInterna(vUsuarioId,
          vDataInicial, vDataFinal, vCodProduto, vEnderecoOrigem,
          vEnderecoDestino, vArmazenagem, vMovInterna);
        Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/dshseparacao', Trim(Req.Params.Content.Text), Req.Body, '',
          'Retorno: ' + JsonArrayRetorno.Count.ToString + ' Registros.', 200,
          ((Time - HrInicioLog) / 1000), Req.Headers['appname']);
      End;
    Except
      on E: Exception do
      Begin
        Result := TJsonArray.Create;
        Result.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(Result);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'],
          0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
          '/v1/estoque/movimentacaointerna', Trim(Req.Params.Content.Text),
          Req.Body, '', E.Message, 500, ((Time - HrInicioLog) / 1000),
          Req.Headers['appname']);
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

Procedure GetControleArmazenagem(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
Begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      JsonArrayRetorno := EstoqueDAO.GetControleArmazenagem
        (Req.Query.Dictionary);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

Procedure GetMotivoMovimentacaoSegregado(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
Begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      JsonArrayRetorno := EstoqueDAO.GetMotivoMovimentacaoSegregado
        (Req.Params.Items['ativo'].ToInteger);
      Res.Status(200).Send<TJsonArray>(JsonArrayRetorno);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

procedure GetEstoqueLotePorTipo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      JsonArrayRetorno := EstoqueDAO.GetEstoqueLotePorTipo
        (Req.Params.Items['produtoid'].ToInteger,
        Req.Params.Items['loteid'].ToInteger, Req.Params.Items['enderecoid']
        .ToInteger, Req.Params.Items['estoquetipoid'].ToInteger,
        Req.Params.Items['producao'].ToInteger, Req.Params.Items['distribuicao']
        .ToInteger, Req.Params.Items['zerado'], Req.Params.Items['negativo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

procedure GetRelEstoqueLotePorTipo(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  EstoqueDAO: TEstoqueDao;
  JsonArrayRetorno: TJsonArray;
begin
  Try
    try
      EstoqueDAO := TEstoqueDao.Create;
      JsonArrayRetorno := EstoqueDAO.GetRelEstoqueLotePorTipo
        (Req.Params.Items['produtoid'].ToInteger,
        Req.Params.Items['loteid'].ToInteger, Req.Params.Items['enderecoid']
        .ToInteger, Req.Params.Items['zonaid'].ToInteger,
        Req.Params.Items['estoquetipoid'].ToInteger,
        Req.Params.Items['producao'].ToInteger, Req.Params.Items['distribuicao']
        .ToInteger, Req.Params.Items['zerado'], Req.Params.Items['negativo']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    end;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
end;

Procedure SalvarEstoqueChecklist(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  JsonArrayRetorno: TJsonArray;
  EstoqueDAO: TEstoqueDao;
begin
  Try
    Try
      EstoqueDAO := TEstoqueDao.Create;
      JsonArrayRetorno := EstoqueDAO.SalvarEstoqueChecklist
        (TJSONObject.ParseJSONValue(Req.Body) as TJSONObject);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Status(500).Send<TJsonArray>(JsonArrayRetorno);
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
End;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jsonEstoque: TJSONObject;
  EstoqueDAO: TEstoqueDao;
begin
  Try
    Try
      jsonEstoque := TJSONObject.ParseJSONValue(Req.Body) as TJSONObject;
      EstoqueDAO := TEstoqueDao.Create;
      if EstoqueDAO.Salvar(jsonEstoque) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro salvo com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  EstoqueDAO: TEstoqueDao;
begin
  Try
    Try
      EstoqueDAO := TEstoqueDao.Create;
      EstoqueDAO.ObjEstoque.LoteId :=
        StrToIntDef(Req.Params.Items['loteid'], 0);
      EstoqueDAO.ObjEstoque.EnderecoId :=
        StrToIntDef(Req.Params.Items['enderecoid'], 0);
      EstoqueDAO.ObjEstoque.EstoqueTipoId :=
        StrToIntDef(Req.Params.Items['estoquetipoid'], 0);
      EstoqueDAO.Delete;
      // Res.Send<TJSONObject>(tJsonObject.Create(TJSONPair.Create('Resultado', 'Registro Alterado com Sucesso!'))).Status(THTTPStatus.NoContent);
      Res.Status(200).Send<TJSONObject>
        (TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro exclu�do com Sucesso!'))).Status(THTTPStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Status(500).Send<TJSONObject>
          (TJSONObject.Create(TJSONPair.Create('Erro', E.Message)));
      End;
    End;
  Finally
    FreeAndNil(EstoqueDAO);
  End;
end;

constructor TEstoqueCtrl.Create;
begin
  FEstoque := TEstoque.Create;
end;

destructor TEstoqueCtrl.Destroy;
begin
  FreeAndNil(FEstoque);
  inherited;
end;

End.
