unit Services.Usuarios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MSSQLDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL,
  DataSet.Serialize, System.JSON, REST.JSON, Generics.Collections,
  FireDAC.ConsoleUI.Wait, FireDAC.Comp.UI, exactwmsservice.lib.connection,
  exactwmsservice.dao.base;

Const
  SqlUsuario =
    'select U.UsuarioId, U.Login, U.Nome, U.Senha, U.SenhaPadrao, U.DiasSenhaValida, U.Senha, U.Email, '
    + #13 + #10 +
    '       P.PerfilId, P.Descricao, P.Status StatusPerfil, FORMAT(Dp.Data, ' +
    #39 + 'dd/MM/yyyy' + #39 + ') Data, CONVERT(Time(0), Hp.hora, 0) hora, ' +
    sLineBreak + '       FORMAT(UAS.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as DtUltimaAlteracaoSenha, CONVERT(VARCHAR(5), HAS.hora,108) as HrUltimaAlteracaoSenha, '
    + #13 + #10 + '       FORMAT(DI.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
    ') as DtInclusao, CONVERT(VARCHAR(5), HI.hora,108) as HrInclusao, U.Status '
    + #13 + #10 +
    '     , Coalesce(UL.IdLogOn, 0) IdLogOn, Ul.Terminal, Ul.DataInicio, Ul.HoraInicio'
    + sLineBreak + 'From Usuarios U ' + #13 + #10 +
    'Inner Join Perfil P On P.PerfilId = U.PerfilId' + sLineBreak +
    'Left Join Rhema_Data UAS ON UAS.IdData = U.DtUltimaAlteracaoSenha ' + #13 +
    #10 + 'Left Join Rhema_Hora HAS ON HAS.IdHora = U.HrUltimaAlteracaoSenha ' +
    #13 + #10 + 'Left Join Rhema_Data DI ON DI.IdData = U.DtInclusao ' + #13 +
    #10 + 'Left Join Rhema_Hora HI ON HI.IdHora = U.HrInclusao' + sLineBreak +
    'Left Join Rhema_Data DP ON DP.IdData = P.Data ' + #13 + #10 +
    'Left Join Rhema_Hora HP ON HP.IdHora = P.Hora' + sLineBreak +
    'Left Join (Select Top 1 UsuarioId, Coalesce(IdLogOn, 0) IdLogOn, Terminal, DataInicio, HoraInicio'
    + sLineBreak + '           From UsuarioLogOnOff' + sLineBreak +
    '		   Where OnOff = 1) Ul On Ul.UsuarioId = U.UsuarioId';

type
  TServiceUsuario = class(TBasicDao)
  private
    { Private declarations }

  public
    { Public declarations }
    Function AtualizarSenha(Const pJsonObject: TJsonObject): Boolean;
    function InsertUpdate(pUsuarioId: Integer; pLogin, pNome, pSenha: String;
      pSenhaPadrao, pDiasSenhaValida: Integer; pEmail: String;
      pPerfilId, pStatus: Integer): TjSonArray;
    function GetId(pUsuarioId: String): TjSonArray;
    function LogIn(pUsuarioId: String): TjSonArray;
    Function FindLoginNome(pLogin, pNome: String): TjSonArray;
    Function Delete(pUsuarioId: Integer): Boolean;
    Function AcessoFuncionalidade(pUsuarioId: Integer; pFuncionalidade: String)
      : TjSonArray;
    Function AcessoTopico(pUsuarioId: Integer; pTopico: String): TjSonArray;
    Function ControleAcesso(pUsuarioId: Integer): TJsonObject;
    Function ListaFuncionalidade(pUsuarioId: Integer): TjSonArray;
    Function SalvarAcesso(pUsuarioId: Integer; pJsonObject: TJsonObject)
      : TjSonArray;
    Function LogOnOff(pJsonObject: TJsonObject): TjSonArray;
    Function UsuarioConectado: TjSonArray;
    Function GetRelUsuarioLista(pUsuarioId, pFuncionalidadeId, pPerfilId,
      pStatus: Integer): TjSonArray;
    Function GetUsuario4D(const AParams: TDictionary<string, string>)
      : TJsonObject;
    constructor Create; overload;
    destructor Destroy; override;
  end;

var
  ServiceUsuario: TServiceUsuario;

implementation

{ TServiceUsuario }

function TServiceUsuario.AcessoFuncionalidade(pUsuarioId: Integer;
  pFuncionalidade: String): TjSonArray;
begin

end;

function TServiceUsuario.AcessoTopico(pUsuarioId: Integer; pTopico: String)
  : TjSonArray;
begin

end;

function TServiceUsuario.AtualizarSenha(const pJsonObject: TJsonObject)
  : Boolean;
begin

end;

function TServiceUsuario.ControleAcesso(pUsuarioId: Integer): TJsonObject;
begin

end;

constructor TServiceUsuario.Create;
begin
  inherited;
end;

function TServiceUsuario.Delete(pUsuarioId: Integer): Boolean;
begin

end;

destructor TServiceUsuario.Destroy;
begin

  inherited;

end;

function TServiceUsuario.FindLoginNome(pLogin, pNome: String): TjSonArray;
begin

end;

function TServiceUsuario.GetId(pUsuarioId: String): TjSonArray;
begin
  Try
    FConexao.Query.Close;
    FConexao.Query.Sql.Add(SqlUsuario);
    if pUsuarioId <> '0' then
    Begin
      if StrToInt64Def(pUsuarioId, 0) > 0 then
        FConexao.Query.Sql.Add('where U.UsuarioId = ' + pUsuarioId)
      Else
        FConexao.Query.Sql.Add('where U.Login = ' + QuotedStr(pUsuarioId) +
          ' or U.Nome  = ' + QuotedStr(pUsuarioId));
          //' or U.Nome  Like ' + QuotedStr('%' + pUsuarioId + '%'));
    End;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('GetUsuario.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      result := TjSonArray.Create;
      result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Dados n�o encontrado na pesquisa!'))
    End
    Else
      result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: Usu�rios GetId - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
end;

function TServiceUsuario.GetRelUsuarioLista(pUsuarioId, pFuncionalidadeId,
  pPerfilId, pStatus: Integer): TjSonArray;
begin

end;

function TServiceUsuario.GetUsuario4D(const AParams
  : TDictionary<string, string>): TJsonObject;
begin

end;

function TServiceUsuario.InsertUpdate(pUsuarioId: Integer;
  pLogin, pNome, pSenha: String; pSenhaPadrao, pDiasSenhaValida: Integer;
  pEmail: String; pPerfilId, pStatus: Integer): TjSonArray;
begin

end;

function TServiceUsuario.ListaFuncionalidade(pUsuarioId: Integer): TjSonArray;
begin

end;

function TServiceUsuario.LogIn(pUsuarioId: String): TjSonArray;
begin
 Try
    FConexao.DB.ResourceOptions.CmdExecTimeout := 30000;
    FConexao.Query.Close;
    FConexao.Query.ResourceOptions.CmdExecTimeout := 30000;
    FConexao.Query.Sql.Add(SqlUsuario);
    if pUsuarioId <> '0' then
    Begin
      if StrToInt64Def(pUsuarioId, 0) > 0 then
        FConexao.Query.Sql.Add('where U.UsuarioId = ' + pUsuarioId)
      Else
        FConexao.Query.Sql.Add('where U.Login = ' + QuotedStr(pUsuarioId) +
          ' or U.Nome  Like ' + QuotedStr('%' + pUsuarioId + '%'));
    End;
    If DebugHook <> 0 Then
      FConexao.Query.Sql.SaveToFile('GetUsuario.Sql');
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
    Begin
      result := TjSonArray.Create;
      result.AddElement(TJsonObject.Create.AddPair('Erro',
        'Dados n�o encontrado na pesquisa!'))
    End
    Else
      result := FConexao.Query.toJsonArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create('Processo: Usu�rios GetId - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  End;
 end;

function TServiceUsuario.LogOnOff(pJsonObject: TJsonObject): TjSonArray;
begin

end;

function TServiceUsuario.SalvarAcesso(pUsuarioId: Integer;
  pJsonObject: TJsonObject): TjSonArray;
begin

end;

function TServiceUsuario.UsuarioConectado: TjSonArray;
begin

end;

end.
