unit MService.InventarioDAO;

interface

uses
  FireDAC.Comp.Client, InventarioClass, System.SysUtils, 
  DataSet.Serialize,
  FireDAC.Stan.Option, System.JSON, REST.JSON, System.Generics.Collections,
  Web.HTTPApp, exactwmsservice.lib.utils, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

type
  TInventarioDao = class(TBasicDao)
  private
    // FIndexConn : Integer;

    //
    ObjInventarioDAO: TInventario;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(pJsonInventario: TJsonObject): TJsonObject;
    Function ZerarContagem(pInventarioId, pEnderecoId, pProdutoId: Integer)
      : TJsonObject;
    Function SaveContagem(pJsonArray: TJsonArray): TJsonObject;
    function GetInventario(const AParams: TDictionary<string, string>)
      : TJsonArray;
    Function GetPendente: TJsonArray;
    Function GetItens(Const pInventarioId: Integer): TJsonArray;
    Function GetLoteInventariado(Const AParams: TDictionary<string, string>)
      : TJsonArray;
    function GetInventario4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    Function Cancelar(Const AParams: TDictionary<string, string>): Boolean;
    Function InventarioFechar(Const AParams
      : TDictionary<string, string>): Boolean;
    Function Contagem(pItem: Integer): TJsonArray;
    Function Delete(pInventarioId: Integer): Boolean;
    Function InventarioCancelar(pInventarioId: Integer): TJsonArray;
    Function ApuracaoInventarioEndereco(Const AParams
      : TDictionary<string, string>): TJsonArray;
    Function ApuracaoInventarioProduto(Const AParams
      : TDictionary<string, string>): TJsonArray;
    Function LimparContagem(pInventarioId, pEnderecoId, pProdutoId: Integer)
      : TJsonArray;
    Function GetInventarioConsultaIntegracao: TJsonArray;
    Function PutInventarioIntegracao(pInventarioId: String): TJsonArray;
    Function PutInventarioIntegracaoLote(pInventarioId: String): TJsonArray;

  
  end;

implementation

uses uSistemaControl, Constants;

{ TClienteDao }

function TInventarioDao.ApuracaoInventarioEndereco(const AParams
  : TDictionary<string, string>): TJsonArray;
Var
  pProcessoId: Integer;
  ErroJsonArray: TJsonArray;
begin
  Try
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.Close;
    FConexao.Query.SQL.Add('Declare @IntegraAjusteERP Integer;');
    FConexao.Query.SQL.Add
      ('If (Select IntegrarAjusteERP From Configuracao) = 0');
    FConexao.Query.SQL.Add('   Set @IntegraAjusteERP = 2');
    FConexao.Query.SQL.Add('Else Set @IntegraAjusteERP = 0');
    FConexao.Query.SQL.Add('Declare @InventarioId Integer = ' + AParams.Items
      ['inventarioid'] + sLineBreak +
      '-- Inserir Ajuste para Integração e Consultas Futuras' + sLineBreak +
      'Insert inventarioajuste' + sLineBreak +
      '  select @InventarioId, Ctg.enderecoid, Ctg.loteid, Ctg.Contagem, Ctg.Ajuste, @IntegraAjusteERP Status, NEWID()'
      + sLineBreak + '  From (Select Prd.CodProduto, II.enderecoid, II.loteid, '
      + sLineBreak +
      '               II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste'
      + sLineBreak + '        from InventarioInicial II' + sLineBreak +
      '        Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId'
      + sLineBreak +
      '        Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' + sLineBreak
      + '        Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      '        Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'
      + sLineBreak + '        Where InventarioId = @InventarioId) Ctg' +
      sLineBreak + '  --Where Ajuste <> 0');

    FConexao.Query.SQL.Add('--Incluir estoque de lotes inexistente');
    FConexao.Query.SQL.Add
      ('Insert Into Estoque Select Ctg.loteid, Ctg.enderecoid, 4, Ctg.Contagem, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),');
    FConexao.Query.SQL.Add
      ('           (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), Null, Null, Null, Null');
    FConexao.Query.SQL.Add
      ('from   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste');
    FConexao.Query.SQL.Add('		      from InventarioInicial II');
    FConexao.Query.SQL.Add
      ('       	Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId');
    FConexao.Query.SQL.Add
      ('        Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId');
    FConexao.Query.SQL.Add
      ('        Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId');
    FConexao.Query.SQL.Add
      ('       	Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))');
    FConexao.Query.SQL.Add
      ('	       Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg');
    FConexao.Query.SQL.Add
      ('Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid');
    FConexao.Query.SQL.Add
      ('where Coalesce(Est.EstoqueTipoId, 0) <> 6 and (Est.EnderecoId is Null)');

    FConexao.Query.SQL.Add('--Update no lotes já existentes' + sLineBreak +
      'Update Est Set Qtde = Ctg.Contagem' + sLineBreak +
      'from   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste'
      + sLineBreak + '		      from InventarioInicial II' + sLineBreak +
      '	       Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId'
      + sLineBreak +
      '		      Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' + sLineBreak
      + '		      Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      '		      Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'
      + sLineBreak +
      '		      Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg'
      + sLineBreak +
      'Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid'
      + sLineBreak +
      'where Coalesce(Est.EstoqueTipoId, 0) <> 6 and (Est.EnderecoId is Not Null)');
    FConexao.Query.SQL.Add('--Registrar Ajuste no Kardex');
    {
      FConexao.Query.Sql.Add(      'Insert Into Kardex'+sLineBreak+
      '  Select 4, A.LoteId, Null, 4, A.Ajuste, A.EstoqueInicial, A.Quantidade, '+#39+'Ajuste Inventario '+#39+'+Cast(@InventarioId as Varchar),'+sLineBreak+
      '         A.EnderecoId, A.EstoqueInicial, A.Quantidade, '+#39+'Ajuste Inventario'+#39+', '+sLineBreak+
      '         (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'+sLineBreak+
      '         (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), @Usuario, @Estacao'+sLineBreak+
      '  From ##Ajuste A');
    }

    FConexao.Query.SQL.Add('Delete Est' + sLineBreak +
      'from   (Select Prd.CodProduto, II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade Contagem, (Ic.Quantidade - II.EstoqueInicial) Ajuste'
      + sLineBreak + '		      from InventarioInicial II' + sLineBreak +
      '		      Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId'
      + sLineBreak +
      '		      Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' + sLineBreak
      + '		      Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      '		      Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'
      + sLineBreak +
      '		      Where InventarioId = @InventarioId and (Ic.Quantidade - II.EstoqueInicial) <> 0) Ctg'
      + sLineBreak +
      'Left Join Estoque Est on Est.EnderecoId = Ctg.enderecoid and Est.LoteId = Ctg.loteid'
      + sLineBreak + 'where Qtde = 0');
    // Apagar Estoque existente e não contado
    FConexao.Query.SQL.Add
      ('If (Select InventarioTipo From Inventarios Where InventarioId = @InventarioId) = 1 begin');
    FConexao.Query.SQL.Add('	  Insert Into InventarioAjuste ');
    FConexao.Query.SQL.Add
      ('           Select @InventarioId, Est.enderecoId, Est.LoteId, @IntegraAjusteERP, Est.Qtde*-1, 0, NewId()');
    FConexao.Query.SQL.Add('	          from Estoque Est');
    FConexao.Query.SQL.Add('	          inner Join (Select EnderecoId');
    FConexao.Query.SQL.Add('			                    From InventarioInicial');
    FConexao.Query.SQL.Add
      ('			                    Where InventarioId = @InventarioId');
    FConexao.Query.SQL.Add
      ('			                    Group By Enderecoid)  IE On IE.EnderecoId = Est.EnderecoId');
    FConexao.Query.SQL.Add
      ('	          Left Join InventarioInicial II On II.EnderecoId = Est.EnderecoId and II.Loteid = Est.LoteId');
    FConexao.Query.SQL.Add
      ('	          Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
    FConexao.Query.SQL.Add('');
    FConexao.Query.SQL.Add('	Delete Est');
    FConexao.Query.SQL.Add('	from Estoque Est');
    FConexao.Query.SQL.Add('	inner Join (Select EnderecoId');
    FConexao.Query.SQL.Add('			   From InventarioInicial');
    FConexao.Query.SQL.Add('			   Where InventarioId = @InventarioId');
    FConexao.Query.SQL.Add
      ('			   Group By Enderecoid)  IE On IE.EnderecoId = Est.EnderecoId');
    FConexao.Query.SQL.Add
      ('	Left Join InventarioInicial II On II.EnderecoId = Est.EnderecoId and II.Loteid = Est.LoteId');
    FConexao.Query.SQL.Add
      ('	Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
    FConexao.Query.SQL.Add('End');
    FConexao.Query.SQL.Add('Else Begin');
    FConexao.Query.SQL.Add
      ('  Insert Into InventarioAjuste Select @InventarioId, Est.enderecoId, Est.LoteId, @IntegraAjusteERP, Est.Qtde*-1, 0, NewId()');
    FConexao.Query.SQL.Add('  from Estoque Est');
    FConexao.Query.SQL.Add
      ('  Inner Join ProdutoLotes Pl On Pl.LoteId = Est.LoteId');
    FConexao.Query.SQL.Add('  inner Join (Select ProdutoId');
    FConexao.Query.SQL.Add('		      From InventarioInicial');
    FConexao.Query.SQL.Add('			  Where InventarioId = @InventarioId');
    FConexao.Query.SQL.Add
      ('	  	      Group By Produtoid)  IE On IE.ProdutoId = Pl.ProdutoId');
    FConexao.Query.SQL.Add
      ('  Left Join InventarioInicial II On II.ProdutoId = Pl.ProdutoId');
    FConexao.Query.SQL.Add('            and II.Loteid = Est.LoteId');
    FConexao.Query.SQL.Add('			and II.EnderecoId = Est.EnderecoId');
    FConexao.Query.SQL.Add
      ('  Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
    FConexao.Query.SQL.Add('');
    FConexao.Query.SQL.Add('  Delete Est');
    FConexao.Query.SQL.Add('  from Estoque Est');
    FConexao.Query.SQL.Add
      ('  Inner Join ProdutoLotes Pl On Pl.LoteId = Est.LoteId');
    FConexao.Query.SQL.Add('  inner Join (Select ProdutoId');
    FConexao.Query.SQL.Add('		      From InventarioInicial');
    FConexao.Query.SQL.Add('			  Where InventarioId = @InventarioId');
    FConexao.Query.SQL.Add
      ('	  	      Group By Produtoid)  IE On IE.ProdutoId = Pl.ProdutoId');
    FConexao.Query.SQL.Add
      ('  Left Join InventarioInicial II On II.ProdutoId = Pl.ProdutoId');
    FConexao.Query.SQL.Add('            and II.Loteid = Est.LoteId');
    FConexao.Query.SQL.Add('			and II.EnderecoId = Est.EnderecoId');
    FConexao.Query.SQL.Add
      ('  Where II.LoteId Is Null and Est.EstoqueTipoId In (1,4)');
    FConexao.Query.SQL.Add('End;');
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ApuracaoInventario.Sql');
    FConexao.Query.ExecSQL;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Select ProcessoId From ProcessoEtapas where Descricao = ' + #39 +
      'Inventario - Finalizado' + #39);
    FConexao.Query.Open();
    pProcessoId := FConexao.Query.FieldByName('ProcessoId').AsInteger;
    // Realizar Apuração de acordo com
    // v1/inventario/loteinventariado?inventarioid=XXX
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    // FConexao.Query.Sql.Add(TuEvolutConst.SqlInventarioFechar);
    // FConexao.Query.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'].ToInteger();
    // FConexao.Query.ParamByName('pEstacao').Value   := AParams.Items['terminal'];
    // FConexao.Query.ParamByName('pUsuario').value  := AParams.Items['usuarioid'];
    FConexao.Query.SQL.Add
      ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where ' +
      'InventarioId = ' + AParams.Items['inventarioid'] + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    FConexao.Query.ParamByName('pTerminal').Value := AParams.Items['terminal'];
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      AParams.Items['usuarioid'];
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ApuracaoInventarioFinalizar.Sql');
    FConexao.Query.ExecSQL;
    FConexao.Query.connection.Commit;
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Ok',
      'Apuração de resultado concluída!'));
  Except
    ON E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Tabela: Inventario Apuração(Fechar) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TInventarioDao.ApuracaoInventarioProduto(const AParams
  : TDictionary<string, string>): TJsonArray;
begin

end;

function TInventarioDao.Cancelar(Const AParams
  : TDictionary<string, string>): Boolean;
var
  pProcessoId: Integer;
begin
  Result := False;
  try
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Select ProcessoId From ProcessoEtapas where Descricao = ' + #39 +
      'inventario - Cancelado' + #39);
    FConexao.Query.Open();
    pProcessoId := FConexao.Query.FieldByName('ProcessoId').AsInteger;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlInventarioCancelar);
    FConexao.Query.ParamByName('pInventarioId').Value :=
      AParams.Items['inventarioid'].ToInteger();
    FConexao.Query.SQL.Add
      ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where ' +
      'InventarioId = ' + AParams.Items['inventarioid'] + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    FConexao.Query.ParamByName('pTerminal').Value := AParams.Items['terminal'];
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      AParams.Items['usuarioid'];
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('InventarioCancelar.Sql');

    FConexao.Query.ExecSQL;
    Result := True;
    FConexao.Query.connection.Commit;
  Except
    ON E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Tabela: Inventarios(Cancelar) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TInventarioDao.Contagem(pItem: Integer): TJsonArray;
var
  vParamOk: Integer;
  vProcessoId: Integer;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetContagemLote);
    FConexao.Query.ParamByName('pItem').Value := pItem;
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

constructor TInventarioDao.Create;
begin
  ObjInventarioDAO := TInventario.Create;
  inherited;
end;

function TInventarioDao.Delete(pInventarioId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from Inventarios where InventarioId = ' +
      pInventarioId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Inventarios - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TInventarioDao.Destroy;
begin
  ObjInventarioDAO.Free;
  inherited;
end;

function TInventarioDao.InventarioCancelar(pInventarioId: Integer): TJsonArray;
begin

  Try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Update Inventario Set ProcessoId = (Select ProcessoId from Processo Where Descricao = '
      + QuotedStr('Inventario - Cancelar') +
      ') Where InventarioId = :InventarioId');
    Result := TJsonArray.Create;
    Result.AddElement(TJsonObject.Create.AddPair('Inventario',
      TJsonNumber.Create(FConexao.Query.FieldByName('InventarioId')
      .AsInteger)));
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: Inventarios - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TInventarioDao.InventarioFechar(const AParams
  : TDictionary<string, string>): Boolean;
var
  pProcessoId: Integer;
begin
  Result := False;
  try
    FConexao.Query.connection.StartTransaction;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Select ProcessoId From ProcessoEtapas where Descricao = ' + #39 +
      'Inventario - Finalizado' + #39);
    FConexao.Query.Open();
    pProcessoId := FConexao.Query.FieldByName('ProcessoId').AsInteger;
    // Realizar Apuração de acordo com
    // v1/inventario/loteinventariado?inventarioid=XXX
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlInventarioFechar);
    FConexao.Query.ParamByName('pInventarioId').Value :=
      AParams.Items['inventarioid'].ToInteger();
    FConexao.Query.ParamByName('pEstacao').Value := AParams.Items['terminal'];
    FConexao.Query.ParamByName('pUsuario').Value := AParams.Items['usuarioid'];
    FConexao.Query.SQL.Add
      ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where ' +
      'InventarioId = ' + AParams.Items['inventarioid'] + ')');
    FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
    FConexao.Query.ParamByName('pTerminal').Value := AParams.Items['terminal'];
    FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
    FConexao.Query.ParamByName('pUsuarioId').Value :=
      AParams.Items['usuarioid'];
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('InventarioFechar.Sql');
    FConexao.Query.ExecSQL;
    Result := True;
    FConexao.Query.connection.Commit;
  Except
    ON E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Tabela: Inventario Apuração(Fechar) - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TInventarioDao.LimparContagem(pInventarioId, pEnderecoId,
  pProdutoId: Integer): TJsonArray;
begin
  Result := TJsonArray.Create;
  Try
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add(TuEvolutConst.SqlLimparContagem);
    FConexao.Query.ParamByName('pInventarioId').Value := pInventarioId;
    FConexao.Query.ParamByName('pEnderecoId').Value := pEnderecoId;
    FConexao.Query.ParamByName('pProdutoId').Value := pProdutoId;
    FConexao.Query.SQL.Add('-- ' + pInventarioId.ToString);
    FConexao.Query.SQL.Add('-- ' + pEnderecoId.ToString);
    FConexao.Query.SQL.Add('-- ' + pProdutoId.ToString);
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('LimparContagem' + pInventarioId.ToString +
        '_' + pEnderecoId.ToString + '_' + pProdutoId.ToString + '.Sql');
    FConexao.Query.ExecSQL;
    Result.AddElement(TJsonObject.Create.AddPair('ok',
      'Endereço zerado com sucesso'));
  Except
    On E: Exception do
    Begin
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Tabela: LimparContagem - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  End;
end;

function TInventarioDao.PutInventarioIntegracao(pInventarioId: String)
  : TJsonArray;
var
  vQry, vQryStatus: TFdQuery;
  ErroJsonArray: TJsonArray;
begin
  Try
    vQry := FConexao.GetQuery;
    vQryStatus := FConexao.GetQuery;
    vQry.connection.StartTransaction;
    vQry.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
    vQry.SQL.Add('select * from vinventarioajusteintegracao');
    vQry.SQL.Add
      ('Where Cast(InventarioId as VarChar(36)) = @InventarioId or Cast(uuid as Varchar(36)) = @InventarioId');
    vQry.ParamByName('pInventarioId').Value := pInventarioId;
    vQry.Open();
    if DebugHook <> 0 then
      vQry.SQL.SaveToFile('InventarioIntegracaoretorno.Sql');
    vQry.Open();
    if vQry.IsEmpty then
    Begin
      Result := TJsonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
                        .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem', TuEvolutConst.QrySemDados));
    End
    Else
    Begin
      Result := vQry.ToJSONArray;
      vQryStatus.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
      vQryStatus.SQL.Add('Update IA Set Status = 1');
      vQryStatus.SQL.Add('From InventarioAjuste IA');
      vQryStatus.SQL.Add
        ('Inner Join Inventarios I On I.InventarioId = IA.InventarioId');
      vQryStatus.SQL.Add
        ('Where IA.Status = 0 And (Cast(IA.InventarioId as VarChar(36)) = @InventarioId or Cast(I.uuid as Varchar(36)) = @InventarioId)');
      vQryStatus.ParamByName('pInventarioId').Value := pInventarioId;
      If DebugHook <> 0 then
        vQryStatus.SQL.SaveToFile('RegInventarioRetorno.Sql');
      vQryStatus.ExecSQL;
    End;
    vQry.connection.Commit;
  Except
    On E: Exception do
    Begin
      vQry.connection.Rollback;
      ErroJsonArray := TJsonArray.Create;
      ErroJsonArray.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem',
        'Processo: InventarioAjusteIntegracao - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  End;
end;

function TInventarioDao.PutInventarioIntegracaoLote(pInventarioId: String)
  : TJsonArray;
var
  vQry, vQryStatus: TFdQuery;
  ErroJsonArray: TJsonArray;
begin
  Try
    vQry := FConexao.GetQuery;
    vQryStatus := FConexao.GetQuery;
    vQryStatus.connection.StartTransaction;
    vQry.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
    vQry.SQL.Add
      ('select * from vinventarioajusteintegracaoLote where Cast(InventarioId as VarChar(36)) = @InventarioId or Cast(uuid as Varchar(36)) = @InventarioId');
    vQry.ParamByName('pInventarioId').Value := pInventarioId;
    if DebugHook <> 0 then
      vQry.SQL.SaveToFile('InventarioIntegracaoretornoLote.Sql');
    vQry.Open();
    if vQry.IsEmpty then
    Begin
      Result := TJsonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem',
        TuEvolutConst.QrySemDados));
    End
    Else
    Begin
      Result := vQry.ToJSONArray;
      vQryStatus.SQL.Add('Declare @InventarioId VarChar(36) = :pInventarioId');
      vQryStatus.SQL.Add('Update IA Set Status = 1');
      vQryStatus.SQL.Add('From InventarioAjuste IA');
      vQryStatus.SQL.Add
        ('Inner Join Inventarios I On I.InventarioId = IA.InventarioId');
      vQryStatus.SQL.Add
        ('Where IA.Status = 0 And (Cast(IA.InventarioId as VarChar(36)) = @InventarioId or Cast(I.uuid as Varchar(36)) = @InventarioId)');
      vQryStatus.ParamByName('pInventarioId').Value := pInventarioId;
      If DebugHook <> 0 then
        vQryStatus.SQL.SaveToFile('RegInventarioRetorno.Sql');
      vQryStatus.ExecSQL;
    End;
    vQry.connection.Commit;
  Except
    On E: Exception do
    Begin
      vQry.connection.Rollback;
      ErroJsonArray := TJsonArray.Create;
      ErroJsonArray.AddElement(TJsonObject.Create.AddPair('status', '500')
        .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem',
        'Processo: InventarioAjusteIntegracao - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll])));
    End;
  End;
end;

function TInventarioDao.SaveContagem(pJsonArray: TJsonArray): TJsonObject;
Var
  xItemContagem: Integer;
  vErro: Boolean;
  vErroMens: String;
  vInventarioId: Integer;
  vProcessoId: Integer;
  vUsuarioId: Integer;
  vEstacao: String;
begin
  FConexao.Query.connection.StartTransaction;
  FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
  FConexao.Query.SQL.Add(TuEvolutConst.SqlSaveContagem);
  vErro             := False;
  vInventarioId     := pJsonArray.Items[0].GetValue<Integer>('inventarioid');
  vUsuarioId        := pJsonArray.Items[0].GetValue<Integer>('usuarioid');
  vEstacao          := pJsonArray.Items[0].GetValue<String>('estacao');
  For xItemContagem := 0 to Pred(pJsonArray.Count) do
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add(TuEvolutConst.SqlSaveContagem);
      FConexao.Query.ParamByName('pInventarioId').Value := pJsonArray.Items[xItemContagem].GetValue<Integer>('inventarioid');
      FConexao.Query.ParamByName('pEnderecoId').Value   := pJsonArray.Items[xItemContagem].GetValue<Integer>('enderecoid');
      FConexao.Query.ParamByName('ProdutoId').Value     := pJsonArray.Items[xItemContagem].GetValue<Integer>('produtoid');
      FConexao.Query.ParamByName('pLoteId').Value       := pJsonArray.Items[xItemContagem].GetValue<Integer>('loteid');
      FConexao.Query.ParamByName('pDescrLote').Value    := pJsonArray.Items[xItemContagem].GetValue<String>('descrlote');
      if pJsonArray.Items[xItemContagem].GetValue<String>('descrlote') = '' then Begin
         FConexao.Query.ParamByName('pDtFabricacao').Value := 0;
         FConexao.Query.ParamByName('pDtVencimento').Value := 0;
      End
      Else begin
         FConexao.Query.ParamByName('pDtFabricacao').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(pJsonArray.Items[xItemContagem].GetValue<String>('dtfabricacao')));
         FConexao.Query.ParamByName('pDtVencimento').Value := FormatDateTime('YYYY-MM-DD', StrtoDate(pJsonArray.Items[xItemContagem].GetValue<String>('dtvencimento')));
      end;
      FConexao.Query.ParamByName('pItemId').Value     := pJsonArray.Items[xItemContagem].GetValue<Integer>('itemid');
      FConexao.Query.ParamByName('pQuantidade').Value := pJsonArray.Items[xItemContagem].GetValue<Integer>('quantidade');
      FConexao.Query.ParamByName('pStatus').Value     := pJsonArray.Items[xItemContagem].GetValue<String>('status');
      FConexao.Query.ParamByName('pUsuarioId').Value  := pJsonArray.Items[xItemContagem].GetValue<Integer>('usuarioid');
      FConexao.Query.ParamByName('pEstacao').Value    := pJsonArray.Items[xItemContagem].GetValue<String>('estacao');
      if DebugHook <> 0 then
         FConexao.Query.SQL.SaveToFile('SaveContagem' + pJsonArray.Items[xItemContagem].GetValue<Integer>('inventarioid').ToString + '_'+
                                       pJsonArray.Items[xItemContagem].GetValue<Integer>('enderecoid').ToString+
                                       '_' + pJsonArray.Items[xItemContagem].GetValue<Integer>('produtoid').ToString + '_'+
                                       pJsonArray.Items[xItemContagem].GetValue<Integer>('loteid').ToString + '.Sql');
      FConexao.Query.ExecSQL;
    Except
      On E: Exception do
      Begin
        vErro := True;
        vErroMens := E.Message;
        FConexao.Query.connection.Rollback;
        Break;
      End;
    End;
    if vErro then
      Break;
  End;
  Result := TJsonObject.Create;
  if vErro then
     Result.AddPair('Erro', 'Tabela: InventarioContagem - '+StringReplace( vErroMens,
                    '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))
  Else
  Begin
    Try
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add
        ('Select ProcessoId From ProcessoEtapas Where Descricao = ' + #39 +
        'Inventario - Em Contagem' + #39);
      FConexao.Query.Open;
      vProcessoId := FConexao.Query.FieldByName('ProcessoId').AsInteger;
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add('If (select De.Descricao ');
      FConexao.Query.SQL.Add('   From Inventarios I');
      FConexao.Query.SQL.Add('   Inner Join vDocumentoEtapas DE On De.Documento = I.uuid and');
      FConexao.Query.SQL.Add('                                     De.ProcessoId = (Select MAX(ProcessoId) From vDocumentoEtapas Where Documento = De.Documento ) ');
      FConexao.Query.SQL.Add('   where I.InventarioId = '+vInventarioId.ToString()+') = '#39+'Inventario - Gerado'+#39);
      FConexao.Query.SQL.Add('Begin');
      FConexao.Query.SQL.Add('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where InventarioId = '+vInventarioId.ToString() + ')');
      FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      FConexao.Query.ParamByName('pTerminal').Value := vEstacao;
      FConexao.Query.ParamByName('pProcessoId').Value := vProcessoId;
      FConexao.Query.ParamByName('pUsuarioId').Value := vUsuarioId;
      FConexao.Query.SQL.Add('End');
      FConexao.Query.ExecSQL;

      FConexao.Query.connection.Commit;
      Result.AddPair('ok', 'Contagem arquivada com sucesso')
    Except
      On E: Exception do
      Begin
        FConexao.Query.connection.Rollback;
        Result.AddPair('Erro', 'Tabela: InventarioContagem - '+StringReplace(vErroMens,
                       '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]))
      End;
    End;
  End;
end;

function TInventarioDao.ZerarContagem(pInventarioId, pEnderecoId,
  pProdutoId: Integer): TJsonObject;
begin
  Result := TJsonObject.Create;
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlZerarEndereco);
    FConexao.Query.ParamByName('pInventarioId').Value := pInventarioId;
    FConexao.Query.ParamByName('pEnderecoId').Value := pEnderecoId;
    FConexao.Query.ParamByName('pProdutoId').Value := pProdutoId;
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('ZerarContagem' + pInventarioId.ToString +
        '_' + pEnderecoId.ToString + '_' + pProdutoId.ToString + '.Sql');
    FConexao.Query.ExecSQL;
    Result.AddPair('ok', 'Endereço zerado com sucesso')
  Except
    On E: Exception do
    Begin
      Result.AddPair('Erro', 'Tabela: ZerarContagem - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]))
    End;
  End;
end;

Function TInventarioDao.GetPendente: TJsonArray;
var
  vParamOk: Integer;
  vProcessoId: Integer;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetInventarioPendente);
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TInventarioDao.GetInventario(Const AParams : TDictionary<string, string>): TJsonArray;
var vParamOk: Integer;
    vProcessoId: Integer;
begin
  Try
    FConexao.Query.SQL.Add(TuEvolutConst.SqlGetInventario);
    vParamOk := 0;
    if AParams.ContainsKey('inventarioid') then begin
       FConexao.Query.SQL.Add('and InventarioId = :pInventarioId');
       FConexao.Query.ParamByName('pInventarioId').Value := AParams.Items['inventarioid'];
       Inc(vParamOk);
    end;
    if AParams.ContainsKey('datacriacao') then begin
       FConexao.Query.SQL.Add('and Dc.Data >= :pDataCriacao');
       FConexao.Query.ParamByName('pDataCriacao').Value := AParams.Items['datacriacao'];
       Inc(vParamOk);
    end;
    if AParams.ContainsKey('datacriacaofinal') then begin
       FConexao.Query.SQL.Add('and Dc.Data <= :pDataCriacaoFinal');
       FConexao.Query.ParamByName('pDataCriacaoFinal').Value := AParams.Items['datacriacaofinal'];
       Inc(vParamOk);
    end;
    if AParams.ContainsKey('datafinalizacao') then begin
       FConexao.Query.SQL.Add('and datafinalizacao = :pDataFinalizacao');
       FConexao.Query.ParamByName('pDataFinalizacao').Value := AParams.Items['datafinalizacao'];
       Inc(vParamOk);
    end;
    if AParams.ContainsKey('datacancelamento') then begin
       FConexao.Query.SQL.Add('and DataCancelamento = :pDataCancelamento');
       FConexao.Query.ParamByName('pDataCancelamento').Value := AParams.Items['datacancelamento'];
       Inc(vParamOk);
    end;
    if AParams.ContainsKey('processoid') then begin
       vProcessoId := AParams.Items['processoid'].ToInteger();
       FConexao.Query.SQL.Add('and De.ProcessoId = :pProcessoId');
       FConexao.Query.ParamByName('pProcessoId').Value := AParams.Items['processoid'].ToInteger();
       Inc(vParamOk);
    end;
    if AParams.ContainsKey('tipo') then begin
      FConexao.Query.SQL.Add('and InventarioTipo = :pTipo');
      FConexao.Query.ParamByName('pTipo').Value := AParams.Items['tipo'].ToInteger();
      Inc(vParamOk);
    end;
    if AParams.ContainsKey('pendente') then begin
       if AParams.Items['pendente'].ToInteger() = 1 then
          FConexao.Query.SQL.Add('and (De.ProcessoId in (23, 25))');
       Inc(vParamOk);
    end;
    if AParams.ContainsKey('produtoid') then begin
       FConexao.Query.SQL.Add('And Exists (Select ProdutoId');
       FConexao.Query.SQL.Add('            From InventarioInicial');
       FConexao.Query.SQL.Add('            where InventarioId = I.InventarioID And ProdutoId = :pProdutoId)');
       FConexao.Query.ParamByName('pProdutoId').Value := AParams.Items['produtoid'].ToInteger();
       Inc(vParamOk);
    end;
    if vParamOk <> AParams.Count then
       Result.AddElement(TJsonObject.Create.AddPair('Erro', 'Parâmetros incorretos na requisição!'))
    Else
    begin
      // FConexao.Query.SQL.Add('order by InventarioId');
      FConexao.Query.SQL.Add('Order by InventarioId');
      If DebugHook <> 0 Then
         FConexao.Query.SQL.SaveToFile('Inventario.Sql');
      FConexao.Query.Open();
      if FConexao.Query.IsEmpty then Begin
         Result := TJsonArray.Create();
         Result.AddElement(TJsonObject.Create.AddPair('Erro', TuEvolutConst.QrySemDados))
      End
      Else
         Result := FConexao.Query.ToJSONArray;
    end;
  Except On E: Exception do
    Begin
      raise Exception.Create(StringReplace(E.Message, '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]', '', [rfReplaceAll]));
    End;
  End;
end;

Function TInventarioDao.GetInventario4D(const AParams
  : TDictionary<string, string>): TJsonObject;
var
  QryPesquisa, QryRecordCount: TFdQuery;
  vParamOk: Integer;
begin
  Try
    QryPesquisa := FConexao.GetQuery;
    QryPesquisa.SQL.Add(TuEvolutConst.SqlGetInventario);
    QryRecordCount := FConexao.GetQuery;
    QryRecordCount.SQL.Add(TuEvolutConst.SqlGetInventario);
    vParamOk := 0;
    if AParams.ContainsKey('inventarioid') then
    begin
      QryPesquisa.SQL.Add('and InventarioId = :pInventarioId');
      QryPesquisa.ParamByName('pInventarioId').Value :=
        AParams.Items['inventarioid'];
      QryRecordCount.SQL.Add('and InventarioId = :pInventarioId');
      QryRecordCount.ParamByName('pInventarioId').AsString :=
        AParams.Items['inventarioid'];
      Inc(vParamOk);
    end;
    if AParams.ContainsKey('datacriacao') then
    begin
      QryPesquisa.SQL.Add('and datacriacao = :pDataCriacao');
      QryPesquisa.ParamByName('pDataCriacao').Value :=
        AParams.Items['datacriacao'];
      QryRecordCount.SQL.Add('and datacriacao = :pDataCriacao');
      QryRecordCount.ParamByName('pDataCriacao').AsString :=
        AParams.Items['datacriacao'];
    end;
    if AParams.ContainsKey('datafinalizacao') then
    begin
      QryPesquisa.SQL.Add('and datafinalizacao = :pDataFinalizacao');
      QryPesquisa.ParamByName('pDataFinalizacao').Value :=
        AParams.Items['datafinalizacao'];
      QryRecordCount.SQL.Add('and datafinalizacao = :pDataFinalizacao');
      QryRecordCount.ParamByName('pDataFinalizacao').AsString :=
        AParams.Items['datafinalizacao'];
    end;
    if AParams.ContainsKey('datacancelamento') then
    begin
      QryPesquisa.SQL.Add('and DataCancelamento = :pDataCancelamento');
      QryPesquisa.ParamByName('pDataCancelamento').Value :=
        AParams.Items['datacancelamento'];
      QryRecordCount.SQL.Add('and datacancelamento = :pDataCancelamento');
      QryRecordCount.ParamByName('pDataCancelamento').AsString :=
        AParams.Items['datacancelamento'];
    end;
    if AParams.ContainsKey('processoid') then
    begin
      QryPesquisa.SQL.Add('and ProcessoId = :pProcessoId');
      QryPesquisa.ParamByName('pProcessoId').Value :=
        AParams.ContainsKey('datacancelamento').ToInteger();
      QryRecordCount.SQL.Add('and processoid = :pProcessoId');
      QryRecordCount.ParamByName('pProcessoId').AsString :=
        AParams.Items['processoid'];
    end;
    QryPesquisa.SQL.Add('order by InventarioId');
    QryPesquisa.Open();
    Result.AddPair('data', QryPesquisa.ToJSONArray());
    QryRecordCount.Open();
    Result.AddPair('records',
      TJsonNumber.Create(QryRecordCount.FieldByName('cReg').AsInteger));
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End
  End;
end;

function TInventarioDao.GetInventarioConsultaIntegracao: TJsonArray;
var
  ErroJsonArray: TJsonArray;
begin
  Try
    FConexao.Query.SQL.Add
      ('select Ia.inventarioid id, Inv.uuid, count(*) totaljuste, count(*) totalajuste');
    FConexao.Query.SQL.Add('From (Select Ia.InventarioId, Pl.ProdutoId');
    FConexao.Query.SQL.Add('      From InventarioAjuste IA');
    FConexao.Query.SQL.Add
      ('	  Inner Join ProdutoLotes Pl On Pl.LoteId = Ia.LoteId');
    FConexao.Query.SQL.Add('      where Ia.status = 0');
    FConexao.Query.SQL.Add('	  Group by Ia.inventarioid, Pl.ProdutoId ) Ia');
    FConexao.Query.SQL.Add
      ('Inner Join Inventarios Inv on Inv.InventarioId = Ia.inventarioid');
    FConexao.Query.SQL.Add('Group by Ia.inventarioid, Inv.uuid');
    FConexao.Query.Open();
    if DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('Sql/vInventarioIntegracaoConsulta.Sql');
    FConexao.Query.Open();
    if FConexao.Query.IsEmpty then
    Begin
      Result := TJsonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('status', '200')
        .AddPair('ajuste', TJsonNumber.Create(0)).AddPair('mensagem',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := FConexao.Query.ToJSONArray;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Processo: InventarioConsulta - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

function TInventarioDao.GetItens(const pInventarioId: Integer): TJsonArray;
var
  vQry, QryPesquisa: TFdQuery;
begin
  Try
    QryPesquisa := FConexao.GetQuery;
    vQry := FConexao.GetQuery;
    vQry.SQL.Add('Select InventarioTipo From Inventarios Where InventarioId = '
      + pInventarioId.ToString);
    vQry.Open();
    if vQry.FieldByName('InventarioTipo').AsInteger = 1 then
      QryPesquisa.SQL.Add(TuEvolutConst.SqlGetInventarioItensEndereco)
    Else if vQry.FieldByName('InventarioTipo').AsInteger = 2 then
      QryPesquisa.SQL.Add(TuEvolutConst.SqlGetInventarioItensProduto);
    vQry.Close;
   
    QryPesquisa.ParamByName('pInventarioId').Value := pInventarioId;
    if DebugHook <> 0 then
      QryPesquisa.SQL.SaveToFile('InventarioItens.Sql');

    QryPesquisa.Open();
    if QryPesquisa.IsEmpty then
    Begin
      Result := TJsonArray.Create();
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        TuEvolutConst.QrySemDados))
    End
    Else
      Result := QryPesquisa.ToJSONArray;
    QryPesquisa.Close;
    
  Except
    On E: Exception do
    Begin
      QryPesquisa.Close;
      
      raise Exception.Create(E.Message);
    End;
  End;
end;

function TInventarioDao.GetLoteInventariado(const AParams
  : TDictionary<string, string>): TJsonArray;
var
  vParamOk: Integer;
  vProcessoId: Integer;
begin
  Try
    vParamOk := 0;
    if AParams.ContainsKey('tipo') then
    Begin
      If AParams.Items['tipo'] = '2' then
        FConexao.Query.SQL.Add(TuEvolutConst.SqlGetLoteInventarioPorProduto)
      Else
        FConexao.Query.SQL.Add(TuEvolutConst.SqlGetLoteInventario);
      Inc(vParamOk);
    End
    Else
      FConexao.Query.SQL.Add(TuEvolutConst.SqlGetLoteInventario);
    if AParams.ContainsKey('inventarioid') then
    begin
      FConexao.Query.SQL.Add('and II.InventarioId = :pInventarioId');
      FConexao.Query.ParamByName('pInventarioId').Value :=
        AParams.Items['inventarioid'];
      Inc(vParamOk);
    end;
    if AParams.ContainsKey('produtoid') then
    begin
      FConexao.Query.SQL.Add('and II.ProdutoId = :pProdutoId');
      FConexao.Query.ParamByName('pProdutoId').Value :=
        AParams.Items['produtoid'];
      Inc(vParamOk);
    end;
    if AParams.ContainsKey('enderecoid') then
    begin
      FConexao.Query.SQL.Add('and II.EnderecoId = :pEnderecoId');
      FConexao.Query.ParamByName('pEnderecoId').Value :=
        AParams.Items['enderecoid'];
      Inc(vParamOk);
    end;
    if vParamOk <> AParams.Count then
    Begin
      Result := TJsonArray.Create;
      Result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Parâmetros incorretos na requisição!'))
    End
    Else
    begin
      // FConexao.Query.Sql.Add('Order by InventarioId, Endereco, ProdutoId, DescrLote');
      FConexao.Query.SQL.Add('Order by II.InventarioId, II.Status, ');
      FConexao.Query.SQL.Add
        ('         Case When Inv.inventariotipo = 1 then TEnd.Descricao--, ProdutoId, DescrLote');
      FConexao.Query.SQL.Add
        ('              When Inv.inventariotipo = 2 then II.ProdutoId --, Endereco, DescrLote');
      FConexao.Query.SQL.Add('	     End,');
      FConexao.Query.SQL.Add
        ('         Case When Inv.inventariotipo = 1 then II.ProdutoId--, DescrLote');
      FConexao.Query.SQL.Add
        ('              When Inv.inventariotipo = 2 then II.InventarioId--, ProdutoId, Endereco, DescrLote');
      FConexao.Query.SQL.Add('	     End');
      FConexao.Query.SQL.Add('		 , DescrLote');
      If DebugHook <> 0 Then
        FConexao.Query.SQL.SaveToFile('LoteInventariado.Sql');
      FConexao.Query.Open();
      if FConexao.Query.IsEmpty then
      Begin
        Result := TJsonArray.Create();
        Result.AddElement(TJsonObject.Create.AddPair('Erro',
          TuEvolutConst.QrySemDados))
      End
      Else
        Result := FConexao.Query.ToJSONArray;
    end;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End
  End;
end;

// https://stackoverflow.com/questions/7917695/sql-server-return-value-after-insert
Function TInventarioDao.InsertUpdate(pJsonInventario: TJsonObject): TJsonObject;
var
  vSql, vComplemento: String;
  InventarioId: Integer;
  pProcessoId, xEndereco: Integer;
  JsonArrayItens: TJsonArray;
  pDataLiberacao: String;
  InventarioTipo: Integer;
begin
  FConexao.Query.connection.StartTransaction;
  FConexao.Query.connection.TxOptions.Isolation := xiReadCommitted;
  If pJsonInventario.GetValue<TDateTime>('dataliberacao') = 0 then
    pDataLiberacao := 'Null'
  Else
    pDataLiberacao := #39 + FormatDateTime('YYYY-MM-DD',
      pJsonInventario.GetValue<TDateTime>('dataliberacao')) + #39;
  try
    FConexao.Query.Open
      ('(select processoid from processoetapas where descricao = ' +
      QuotedStr('Inventario - Gerado') + ')');
    pProcessoId := FConexao.Query.FieldByName('ProcessoId').AsInteger;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    if pJsonInventario.GetValue<Integer>('inventarioid') = 0 then
    Begin
      vSql := 'Declare @uuid UNIQUEIDENTIFIER = NewId()' + sLineBreak +
        'Insert Into Inventarios (inventariotipo, motivo, dataliberacao, tipoajuste, status, uuid) OUTPUT Inserted.InventarioId Values ('
        + pJsonInventario.GetValue<Integer>('inventariotipo').ToString() + ', '
        + QuotedStr(pJsonInventario.GetValue<String>('motivo')) + ', ' +
        pDataLiberacao + ', ' + pJsonInventario.GetValue<Integer>('tipoajuste')
        .ToString() + ', ' + pJsonInventario.GetValue<Integer>('status')
        .ToString() + ', @uuid)' + sLineBreak;
      // vSql := vSql+sLineBreak+TuEvolutConst.SqlRegistrarDocumentoEtapa;
    End
    Else
      vSql := 'Update Inventarios Set ' + sLineBreak +
        '     inventariotipo     = ' + pJsonInventario.GetValue<Integer>
        ('inventariotipo').ToString() + sLineBreak +
        '   , motivo             = ' +
        QuotedStr(pJsonInventario.GetValue<String>('motivo')) + sLineBreak +
        '   , dataliberacao      = ' + pDataLiberacao + sLineBreak +
        '   , TipoAjuste         = ' + pJsonInventario.GetValue<Integer>
        ('tipoajuste').ToString() + sLineBreak + '   , Status             = ' +
        pJsonInventario.GetValue<Integer>('status').ToString() + sLineBreak +
        '   OUTPUT Inserted.InventarioId as InventarioId' + sLineBreak +
        'where InventarioId = ' + pJsonInventario.GetValue<Integer>
        ('inventarioid').ToString();
    FConexao.Query.SQL.Add(vSql);

    If DebugHook <> 0 Then
      FConexao.Query.SQL.SaveToFile('Inventario.Sql');
    // FConexao.Query.ExecSQL;
    FConexao.Query.Open;
    InventarioId := FConexao.Query.FieldByName('InventarioId').AsInteger;
    Result := FConexao.Query.ToJSONObject();
    if pJsonInventario.GetValue<Integer>('inventarioid') = 0 then
    Begin
      FConexao.Query.Close;
      FConexao.Query.SQL.Clear;
      FConexao.Query.SQL.Add
        ('declare @uuid UNIQUEIDENTIFIER = (Select uuid From Inventarios where '
        + 'InventarioId = ' + InventarioId.ToString() + ')');
      FConexao.Query.SQL.Add(TuEvolutConst.SqlRegistrarDocumentoEtapa);
      FConexao.Query.ParamByName('pTerminal').Value :=
        pJsonInventario.GetValue<String>('terminal');
      FConexao.Query.ParamByName('pProcessoId').Value := pProcessoId;
      FConexao.Query.ParamByName('pUsuarioId').Value :=
        pJsonInventario.GetValue<Integer>('usuarioid');
      FConexao.Query.ExecSQL;
    End;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add('Delete From InventarioItens Where InventarioId = ' +
      InventarioId.ToString());
    FConexao.Query.ExecSQL;
    JsonArrayItens := pJsonInventario.GetValue<TJsonArray>('endereco');
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add
      ('Insert into InventarioItens (InventarioId, EnderecoId, ProdutoId) Values ');
    vComplemento := '';
    For xEndereco := 0 to Pred(JsonArrayItens.Count) do
    Begin
      If pJsonInventario.GetValue<Integer>('inventariotipo') = 1 Then
      Begin
        FConexao.Query.SQL.Add('       ' + vComplemento + '(' +
          InventarioId.ToString() + ', ' + JsonArrayItens.Items[xEndereco]
          .GetValue<Integer>('enderecoid').ToString + ', Null )');
      End
      Else If pJsonInventario.GetValue<Integer>('inventariotipo') = 2 Then
      Begin
        FConexao.Query.SQL.Add('       ' + vComplemento + '(' +
          InventarioId.ToString() + ', Null, ' + JsonArrayItens.Items[xEndereco]
          .GetValue<Integer>('produtoid').ToString + ' )');
      End;
      vComplemento := ', ';
    End;
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('InventarioItens.Sql');
    FConexao.Query.ExecSQL;
    FConexao.Query.Close;
    FConexao.Query.SQL.Clear;
    FConexao.Query.SQL.Add('Delete from InventarioInicial Where inventarioid = '
      + InventarioId.ToString());
    FConexao.Query.SQL.Add('Insert Into InventarioInicial');
    If pJsonInventario.GetValue<Integer>('inventariotipo') = 1 then
    Begin
      FConexao.Query.SQL.Add('select II.InventarioId, II.enderecoid, ');
      FConexao.Query.SQL.Add
        ('       Est.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
    End
    Else If pJsonInventario.GetValue<Integer>('inventariotipo') = 2 then
    Begin
      FConexao.Query.SQL.Add('select II.InventarioId, Est.enderecoid, ');
      FConexao.Query.SQL.Add
        ('       II.ProdutoId, Est.LoteId, Est.Fabricacao, Est.Vencimento, ');
    End;
    FConexao.Query.SQL.Add
      ('       Coalesce(Est.QtdeProducao, 0) EstoqueInicial, ' + #39 + 'I' + #39
      + ' Status, 1 as Automatico');
    FConexao.Query.SQL.Add('from inventarioitens II');
    If pJsonInventario.GetValue<Integer>('inventariotipo') = 1 then
      FConexao.Query.SQL.Add
        ('Left Join vestoque Est on Est.EnderecoId = II.enderecoid')
    Else If pJsonInventario.GetValue<Integer>('inventariotipo') = 2 then
      FConexao.Query.SQL.Add
        ('Left Join vestoque Est on Est.ProdutoId = II.Produtoid');
    FConexao.Query.SQL.Add('where II.inventarioid = ' +
      InventarioId.ToString());
    if pJsonInventario.GetValue<Integer>('inventariotipo') = 2 then
      FConexao.Query.SQL.Add('  And (Est.ZonaId Is Null Or Est.ZonaID > 3)');
    If DebugHook <> 0 then
      FConexao.Query.SQL.SaveToFile('InventarioInicial.Sql');
    FConexao.Query.ExecSQL;
    FConexao.Query.connection.Commit;
  Except
    ON E: Exception do
    Begin
      FConexao.Query.connection.Rollback;
      raise Exception.Create('Tabela: Inventarios - ' + StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

end.
