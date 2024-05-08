{
  Micro Servico - Controller - ProdutoCtrl.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}

unit MService.ProdutoCtrl;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils, Generics.Collections,
  ProdutoClass,
  Horse,
  System.JSON, Services.Produto,
  Exactwmsservice.lib.utils, Horse.utils.ClientIP;

Type

  TProdutoCtrl = Class
  Private
    FProduto: TProduto;
  Public
    constructor Create;
    destructor Destroy; override;
    Property ObjProduto: TProduto Read FProduto Write FProduto;
  End;

procedure Registry;
procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetCodigoERP(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure GetPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetCodProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure EnderecarProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Integração ERP
Procedure ImportDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Cadastro Basico Implantação
Procedure ExportarCubagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Exportar para o ERP dados logístico alterados no eXactWMS
Procedure ImportCubagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Cadastro Basico Implantação
Procedure ImportCubagemDC(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Cadastro Basico Implantação
Procedure ImportEstoque(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Cadastro Basico Implantação
Procedure ImportEnderecamento(Req: THorseRequest; Res: THorseResponse; Next: TProc); // Cadastro Basico Implantação
Procedure ImportEan(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure SalvarColetor(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetResumoEntrada(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetResumoSaida(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Relatorios
Procedure GetRelEnderecamento(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProdutoList(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetProdutoLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure ExportFile(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure GetRelProdutos01(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AtualizarCubagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AtualizarCubagemIntegracao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure AtualizarRastreabilidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Procedure UpdatePicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

{ tCtrlProduto }

uses MService.ProdutoDAO, uFuncoes;

procedure Registry;
begin

  THorse.Group.Prefix('v1').Get('/produto', Get)
    .Get('/produto/pesquisar/:codprodean', GetCodProduto)
    .Get('/produto/picking/:picking', GetPicking)
    .Get('/produto/:id', GetID).Get('/produto/codigoerp/:codigoerp', GetCodigoERP)
    .Get('/produto/:id/:descricao', GetDescricao)

    .Get('/produto/Estrutura', Estrutura)
    .Post('/produto', Insert)
    .Post('/produto/import', Import)
    .Put('/produto/enderecar', EnderecarProduto)
    .Put('/produto/:id', Update)
    .Delete('/produto/:id', Delete)
    .Get('/produto/montarpaginacao', MontarPaginacao)
    .Put('/produto/importdados', ImportDados) // Integração ERP x eXactWMS
    .Get('/produto/cubagem', ExportarCubagem)
    .Put('/produto/importcubagem', ImportCubagem)
    .Put('/produto/importcubagemdc', ImportCubagemDC)
    .Put('/produto/importestoque', ImportEstoque)
    .Put('/produto/importenderecamento', ImportEnderecamento)
    .Put('/produto/importean', ImportEan)
    .Get('/produto/relatorio/enderecamento', GetRelEnderecamento)
    .Put('/produto/salvarcoletor', SalvarColetor).Get('/produto4D', Get4D)
    .Get('/produto4D/ResumoEntrada/:pedidoid/:codproduto', GetResumoEntrada)
    .Get('/produto4D/:pedidoid/:codproduto', GetResumoSaida)
    .Get('/produto/produtolist', GetProdutoList)
    .Get('/produto/lotes/:produtoid/:descricao', GetProdutoLotes)
    .Get('/produto/exportfile', ExportFile)
    .Get('/produto/relatorio01', GetRelProdutos01)
    .Put('/produto/atualizarcubagem', AtualizarCubagem)
    .Put('/produto/atualizarcubagemintegracao', AtualizarCubagemIntegracao)
    .Put('/produto/atualizarrastreabilidade/:produtoid/:rastroid', AtualizarRastreabilidade)
    .Get('/produto/updatepicking/:codproduto', UpdatePicking);
end;

Procedure AtualizarCubagem(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService: TServiceProduto;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      JsonArrayRetorno := LService.AtualizarCubagem(Req.Body<TJSONObject>);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure AtualizarCubagemIntegracao(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService: TServiceProduto;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      JsonArrayRetorno := LService.AtualizarCubagemIntegracao
        (Req.Body<TJSONObject>);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure AtualizarRastreabilidade(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  LService: TServiceProduto;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      JsonArrayRetorno := LService.AtualizarRastreabilidade
        (Req.Params.Items['produtoid'].ToInteger,
        Req.Params.Items['rastroid'].ToInteger);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(200);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

Procedure Estrutura(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.Estrutura).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    end;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure GetCodProduto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceProduto;
  JsonRetorno: TJSONObject;
  JsonArrayErro: TJsonArray;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      JsonRetorno := LService.GetCodProdutoEan(Req.Params.Items['codprodean']);
      Res.Send<TJSONObject>(JsonRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.GetID('0', 1, '0', Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    end;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
end;

procedure GetDescricao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceProduto;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  AQueryParam: TDictionary<String, String>;
  pDescricao: String;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      if Req.Params.Items['descricao'] = '' then
        pDescricao := '%'
      Else
        pDescricao := Req.Params.Items['descricao'];
      AQueryParam := TDictionary<String, String>.Create;
      AQueryParam.Add('descricao', pDescricao);
      JsonArrayRetorno := LService.GetProduto(AQueryParam);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    If Assigned(AQueryParam) then
       FreeAndNil(AQueryParam);
    FreeAndNil(LService);
  End;
End;

procedure GetPicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LService: TServiceProduto;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      JsonArrayRetorno := LService.GetPicking(Req.Params.Items['picking']);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
        JsonArrayErro := Nil;
      End;
    end;
  Finally
    FreeAndNil(LService);
  End;
End;

procedure GetCodigoERP(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  pCodRequisicao: String;

  LService: TServiceProduto;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  AQueryParam: TDictionary<String, String>;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      if Req.Params.Items['codigoerp'] = '' then
        pCodRequisicao := '0'
      Else
        pCodRequisicao := Req.Params.Items['codigoerp'];
      AQueryParam := TDictionary<String, String>.Create;
      AQueryParam.Add('codigoerp', pCodRequisicao);
      JsonArrayRetorno := LService.GetProduto(AQueryParam);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
      End;
    end;
  Finally
    if Assigned(AQueryParam) then
       FreeAndNil(AQueryParam);
    FreeAndNil(LService);
  End;
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  pCodRequisicao: String;

  LService: TServiceProduto;
  JsonArrayRetorno: TJsonArray;
  JsonArrayErro: TJsonArray;
  AQueryParam: TDictionary<String, String>;
Begin
  Try
    Try
      LService := TServiceProduto.Create;
      if Req.Params.Items['id'] = '' then
        pCodRequisicao := '0'
      Else
        pCodRequisicao := Req.Params.Items['id'];
      AQueryParam := TDictionary<String, String>.Create;
      AQueryParam.Add('produtoid', pCodRequisicao);
      JsonArrayRetorno := LService.GetProduto(AQueryParam);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
      End;
  end;
  Finally
    if Assigned(AQueryParam) then
       FreeAndNil(AQueryParam);
    FreeAndNil(LService);
  End;
end;

Procedure GetProdutoList(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
Begin
  Try
    try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.GetProdutoList(Req.Query.Dictionary))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
      End;
  end;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure GetProdutoLotes(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  pDescricao: String;
  JsonArrayRetorno : TJsonArray;
  JsonArrayErro : TJsonArray;
Begin
  Try
    try
      ProdutoDAO := TProdutoDAO.Create;
      if Req.Params.Items['descricao'] = 'x.x.' then
        pDescricao := '%'
      Else
        pDescricao := Req.Params.Items['descricao'];
      JsonArrayRetorno := ProdutoDAO.GetProdutoLotes(Req.Params.Items['produtoid'].ToInteger(), pDescricao);
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
      End;
  end;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure Get4D(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send(ProdutoDAO.GetId4D(Req.Query.Dictionary)).Status(THTTPStatus.Ok);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure Import(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.Import(Req.Body<TJsonArray>))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message)));
        Res.Send<TJsonArray>(JsonArrayErro)
          .Status(THttpStatus.InternalServerError);
      End;
  end;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure ImportDados(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro: TJsonArray;
  JsonArrayProduto: TJsonArray;
  HrInicioLog: TTime;
Begin
  Try
    HrInicioLog := Time;
    ProdutoDAO := TProdutoDAO.Create;
    Try
      JsonArrayProduto := TJsonArray.Create;
      JsonArrayProduto := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJsonArray;
      Res.Send<TJsonArray>(ProdutoDAO.ImportDados(JsonArrayProduto)).Status(THttpStatus.Created);
      Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                      '/v1/monitorlog/lista', Trim(Req.Params.Content.Text), Req.Body, '','Retorno: ' + jsonArrayProduto.Count.ToString +
                      ' Registros.', 201, ((Time - HrInicioLog) / 1000), Req.Headers['appname']);
    Except ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
                     .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
        Tutil.SalvarLog(Req.MethodType, StrToIntDef(Req.Headers['usuarioid'], 0), Req.Headers['terminal'], ClientIP(Req), THorse.Port,
                        '/v1/monitorlog/delete/:idreq', Trim(Req.Params.Content.Text), Req.Body, '', JsonArrayErro.ToString,
                        500, ((Time - HrInicioLog) / 1000), Req.Headers['appname']);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure ExportarCubagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
// Exportar para o ERP dados logístico alterados no eXactWMS
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro: TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.ExportarCubagem)
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      end;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure ImportCubagem(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayRetorno: TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.ImportCubagem(Req.Body<TJsonArray>))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJsonArray>(ProdutoDAO.ImportCubagem(Req.Body<TJsonArray>))
          .Status(THttpStatus.InternalServerError);
      end;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure ImportCubagemDC(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayRetorno : TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.ImportCubagemDC(Req.Body<TJsonArray>))
        .Status(THttpStatus.Created);
    Except
      On E: Exception do
      begin
        JsonArrayRetorno := TJsonArray.Create;
        JsonArrayRetorno.AddElement(TJSONObject.Create.AddPair('Erro',
          E.Message));
        Res.Send<TJsonArray>(ProdutoDAO.ImportCubagem(Req.Body<TJsonArray>))
          .Status(THttpStatus.InternalServerError);
      end;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure ImportEan(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro: TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.ImportEan(Req.Body<TJsonArray>))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure ImportEnderecamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.ImportEnderecamento(Req.Body<TJsonArray>))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure ImportEstoque(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
Begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.ImportEstoque(Req.Body<TJsonArray>))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jSonProduto: TJSONObject;
  ProdutoDAO: TProdutoDAO;
begin
  Try
    ProdutoDAO := TProdutoDAO.Create;
    Try
      jSonProduto := TJSONObject.Create;
      jSonProduto := Req.Body<TJSONObject>;
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro salvo com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: EHorseException do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(JsonProduto);
    FreeAndNil(ProdutoDAO);
  End;
end;

procedure MontarPaginacao(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJSONObject>(ProdutoDAO.MontarPaginacao).Status(THTTPStatus.Ok);
    Except
      on E: EHorseException do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THTTPStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  jSonProduto, JSonProdutoTipo, JsonMedicamentoTipo, JSonLaboratorio,
    JSonUnidade, JSonUnidadeSecundaria, JSonEnderecamentoZona, JSonEndereco,
    JSonDesenhoArmazem, jsonRastro: TJSONObject;
  ProdutoDAO: TProdutoDAO;
begin
  Try
    Try
      //jSonProduto := TJSONObject.Create;
      jSonProduto := Req.Body<TJSONObject>;
      ProdutoDAO := TProdutoDAO.Create;
      ProdutoDAO := TProdutoDAO.Create;

      JSonProdutoTipo := TJSONObject.Create;
      JSonProdutoTipo := jSonProduto.GetValue('produtoTipo') as TJSONObject;

      JsonMedicamentoTipo := TJSONObject.Create;
      JsonMedicamentoTipo := jSonProduto.GetValue('medicamentoTipo')
        as TJSONObject;

      JSonLaboratorio := TJSONObject.Create;
      JSonLaboratorio := jSonProduto.GetValue('laboratorio') as TJSONObject;
      JSonEndereco := TJSONObject.Create;
      JSonEndereco := jSonProduto.GetValue('endereco') as TJSONObject;
      JSonUnidade := TJSONObject.Create;
      JSonUnidade := jSonProduto.GetValue('unid') as TJSONObject;
      JSonUnidadeSecundaria := TJSONObject.Create;
      JSonUnidadeSecundaria := jSonProduto.GetValue('unidSecundaria')
        as TJSONObject;
      JSonEnderecamentoZona := TJSONObject.Create;
      JSonEnderecamentoZona := jSonProduto.GetValue('enderecamentoZona')
        as TJSONObject;
      jsonRastro := TJSONObject.Create;
      jsonRastro := jSonProduto.GetValue('rastro') as TJSONObject;
      ProdutoDAO.InsertUpdate(GetValueInjSon(jSonProduto, 'IdProduto').ToInteger,
        GetValueInjSon(jSonProduto, 'CodProduto').ToInteger,
        GetValueInjSon(jSonProduto, 'CodigoMS'), GetValueInjSon(jSonProduto,
        'Descricao'), GetValueInjSon(jSonProduto, 'DescricaoRed'),
        StrToIntDef(GetValueInjSon(JSonUnidade, 'id'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'QtdUnid'), 0),
        StrToIntDef(GetValueInjSon(JSonUnidadeSecundaria, 'id'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'FatorConversao'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'SomenteCxaFechada'), 0),
        StrToIntDef(GetValueInjSon(JSonEndereco, 'EnderecoId'), 0),
        StrToIntDef(GetValueInjSon(jsonRastro, 'rastroid'), 0),
        StrToIntDef(IfThen(jSonProduto.GetValue<boolean>('importado') = true, '1',
        '0'), 0), StrToIntDef(IfThen(jSonProduto.GetValue<boolean>('sNGPC')
        = true, '1', '0'), 0), StrToIntDef(GetValueInjSon(JSonEnderecamentoZona,
        'ZonaId'), 0), GetValueInjSon(jSonProduto, 'EanPrincipal'),
        GetValueInjSon(JSonProdutoTipo, 'Descricao'),
        GetValueInjSon(JsonMedicamentoTipo, 'Descricao'),
        StrToIntDef(GetValueInjSon(jSonProduto, 'IdUnidMedIndustrial'), 0),
        StrToIntDef(GetValueInjSon(JSonLaboratorio, 'idlaboratorio'), 0),
        StrToIntDef(IfThen(jSonProduto.GetValue<boolean>('liquido') = true, '1',
        '0'), 0), StrToIntDef(IfThen(jSonProduto.GetValue<boolean>('perigoso')
        = true, '1', '0'), 0),
        StrToIntDef(IfThen(jSonProduto.GetValue<boolean>('inflamavel') = true,
        '1', '0'), 0),
        StrToIntDef(IfThen(jSonProduto.GetValue<boolean>('medicamento') = true,
        '1', '0'), 0),

        StrToFloatDef(StringReplace(jSonProduto.GetValue<String>('peso'), '.',
        ',', []), 0), StrToFloatDef(StringReplace(jSonProduto.GetValue<String>
        ('altura'), '.', ',', []), 0),
        StrToFloatDef(StringReplace(jSonProduto.GetValue<String>('largura'), '.',
        ',', []), 0), StrToFloatDef(StringReplace(jSonProduto.GetValue<String>
        ('comprimento'), '.', ',', []), 0),

        StrToIntDef(GetValueInjSon(jSonProduto, 'MinPicking'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'MaxPicking'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'QtdReposicao'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'PercReposicao'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'MesEntradaMinima'), 0),
        StrToIntDef(GetValueInjSon(jSonProduto, 'MesSaidaMinima'), 0),
        jSonProduto.GetValue<Integer>('status'));
      Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
        'Registro Alterado com Sucesso!'))).Status(THttpStatus.Created);
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    //If Assigned(jSonProduto) then FreeAndNil(JsonProduto);
    FreeAndNil(ProdutoDAO);
  End;
end;

constructor TProdutoCtrl.Create;
begin
  FProduto := TProduto.Create;
end;

destructor TProdutoCtrl.Destroy;
begin
  FreeAndNil(FProduto);
  inherited;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ObjArray: TJSONObject;
  ProdutoDAO: TProdutoDAO;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      If ProdutoDAO.Delete(StrToIntDef(Req.Params.Items['id'], 0), 1) then
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Resultado',
          'Registro Excluído com Sucesso!'))).Status(THttpStatus.Ok)
      Else
         raise Exception.Create('Não foi possível Excluir o Registro!');
    Except
      on E: Exception do
      Begin
        Res.Send<TJSONObject>(TJSONObject.Create(TJSONPair.Create('Erro',
          E.Message))).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
end;

Procedure EnderecarProduto(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.EnderecarProduto(Req.Body<TJSONObject>))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure ExportFile(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJSonArray;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.ExportFile(Req.Query.Dictionary))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure GetRelProdutos01(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.GetRelProdutos01(Req.Query.Dictionary))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
end;

Procedure GetRelEnderecamento(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      Res.Send<TJsonArray>(ProdutoDAO.GetRelEnderecamento(Req.Query.Dictionary))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure SalvarColetor(Req: THorseRequest; Res: THorseResponse; Next: TProc);
Var
  ProdutoDAO: TProdutoDAO;
  JsonProd: TJSONObject;
  JsonArrayErro : TJsonArray;
begin
  Try
    Try
      ProdutoDAO := TProdutoDAO.Create;
      JsonProd := Req.Body<TJSONObject>;
      Res.Send<TJsonArray>(ProdutoDAO.SalvarColetor(Req.Body<TJSONObject>))
        .Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
End;

Procedure GetResumoEntrada(Req: THorseRequest; Res: THorseResponse;
  Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
begin
  Try
    try
      JsonArrayErro := TJsonArray.Create;
      JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', 'Rotina não Desenvolvida!'));
      Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.NotFound);
      JsonArrayErro := TJsonArray.Create;
      JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '200')
                              .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem', 'Rotina não desenvolvida' ));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
//      ProdutoDAO := TProdutoDAO.Create;
//      Res.Send<TJSonArray>(ProdutoDAO.GetResumoEntrada(Req.Params.Items['pedidoid'].ToInteger, Req.Params.Items['codproduto'].ToInteger)).Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
end;

Procedure GetResumoSaida(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  JsonArrayErro : TJsonArray;
begin
  Try
    try
      JsonArrayErro := TJsonArray.Create;
      JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', 'Rotina não Desenvolvida!'));
      Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.NotFound);
      JsonArrayErro := TJsonArray.Create;
      JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '200')
                              .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem', 'Rotina não desenvolvida' ));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      // ProdutoDAO := TProdutoDAO.Create;
      // Res.Send<TJSonArray>(GetResumoSaida(Req.Params.Items['pedidoid'].ToInteger, Req.Params.Items['codproduto'].ToInteger).Status(THttpStatus.Created);
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('status', '500')
          .AddPair('codproduto', TJsonNumber.Create(0)).AddPair('mensagem',
          E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.ExpectationFailed);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
end;

Procedure UpdatePicking(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  ProdutoDAO: TProdutoDAO;
  JsonArrayRetorno : TJsonArray;
  JsonArrayErro : TJsonArray;
begin
  Try
    ProdutoDAO := TProdutoDAO.Create;
    try
      if StrToIntDef(Req.Params.Items['codproduto'], 0) <= 0 then
         raise Exception.Create('Código do produto inválido!!!');
      JsonArrayRetorno := ProdutoDAO.UpdatePicking(StrToIntDef(Req.Params.Items['codproduto'], 0));
      Res.Send<TJsonArray>(JsonArrayRetorno).Status(THttpStatus.Ok)
    Except
      ON E: Exception do
      Begin
        JsonArrayErro := TJsonArray.Create;
        JsonArrayErro.AddElement(TJSONObject.Create.AddPair('Erro', E.Message));
        Res.Send<TJsonArray>(JsonArrayErro).Status(THttpStatus.InternalServerError);
      End;
    End;
  Finally
    FreeAndNil(ProdutoDAO);
  End;
end;

End.
