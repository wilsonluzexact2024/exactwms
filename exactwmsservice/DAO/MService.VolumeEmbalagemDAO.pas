{
  VolumeEmbalagemCtrl.Pas
  Criado por Genilson S Soares (RhemaSys Automação Comercial) em 17/05/2021
  Projeto: uEvolut
}
unit MService.VolumeEmbalagemDAO;

interface

uses
  FireDAC.Comp.Client, System.SysUtils,  DataSet.Serialize,
  System.Types, System.JSON, REST.JSON, System.JSON.Types, VolumeEmbalagemClass,
  exactwmsservice.lib.connection, exactwmsservice.dao.base;

type
  TVolumeEmbalagemDao = class(TBasicDao)
  private
    
    FObjVolumeEmbalagemDAO: TVolumeEmbalagem;
  public
    constructor Create; overload;
    Destructor Destroy; OverRide;
    function InsertUpdate(Const ObjVolumeEmbalagem: TVolumeEmbalagem)
      : TjSonArray;
    // (pVolumeEmbalagemId : Integer; pDescricao : String; pStatus : Integer ) : TjSonArray;
    function GetId(pVolumeEmbalagemId_Descricao: String): TjSonArray;
    Function Delete(pVolumeEmbalagemId: Integer): Boolean;
    Property ObjVolumeEmbalagemDAO: TVolumeEmbalagem Read FObjVolumeEmbalagemDAO
      Write FObjVolumeEmbalagemDAO;
  end;

implementation

uses uSistemaControl, Constants, System.Math;

{ TClienteDao }

constructor TVolumeEmbalagemDao.Create;
begin
  ObjVolumeEmbalagemDAO := TVolumeEmbalagem.Create;
 inherited;
end;

function TVolumeEmbalagemDao.Delete(pVolumeEmbalagemId: Integer): Boolean;
var
  vSql: String;
begin
  Result := False;
  try
    vSql := 'Delete from VolumeEmbalagem where EmbalagemId = ' +
      pVolumeEmbalagemId.ToString;
    FConexao.Query.ExecSQL(vSql);
    Result := True;
  Except
    ON E: Exception do
    Begin
      raise Exception.Create('Tabela: VolumeEmbalagem - ' +
        StringReplace(E.Message,
        '[FireDAC][Phys][ODBC][Microsoft][SQL Server Native Client 11.0][SQL Server]',
        '', [rfReplaceAll]));
    End;
  end;
end;

destructor TVolumeEmbalagemDao.Destroy;
begin
  ObjVolumeEmbalagemDAO.Free;
  inherited;
end;

function TVolumeEmbalagemDao.GetId(pVolumeEmbalagemId_Descricao: String) : TjSonArray;
var vSql: String;
begin
  Result := TjSonArray.Create;
  try
    vSql := TuEvolutConst.SqlVolumeEmbalagem;
    FConexao.Query.SQL.Add(vSql);
    if pVolumeEmbalagemId_Descricao = '0' then Begin
       FConexao.Query.ParamByName('pEmbalagemId').Value := 0;
       FConexao.Query.ParamByName('pDescricao').Value := '%%';
    End
    Else If StrToIntDef(pVolumeEmbalagemId_Descricao, 0) > 0 then Begin
      FConexao.Query.ParamByName('pEmbalagemId').Value := StrToIntDef(pVolumeEmbalagemId_Descricao, 0);
      FConexao.Query.ParamByName('pDescricao').Value   := '';
    End
    Else
    Begin
      FConexao.Query.ParamByName('pEmbalagemId').Value := 0;
      FConexao.Query.ParamByName('pDescricao').Value   := '%' + pVolumeEmbalagemId_Descricao + '%';
    End;
    FConexao.Query.Open;
    if FConexao.Query.IsEmpty then
       Result.AddElement(tJsonObject.Create(tJsonPair.Create('Erro', 'Não há dados para gerar consulta.')));
    Result := FConexao.Query.ToJSONArray();
    ObjVolumeEmbalagemDAO := Nil;
  Except On E: Exception do
    Begin
      ObjVolumeEmbalagemDAO := Nil;
      Result.AddElement(tJsonObject.Create(tJsonPair.Create('Erro', E.Message)));
    End;
  end;
end;

function TVolumeEmbalagemDao.InsertUpdate(Const ObjVolumeEmbalagem
  : TVolumeEmbalagem): TjSonArray;
// (pVolumeEmbalagemId : Integer; pDescricao : String; PStatus : Integer): TjSonArray;
var
  vSql: String;
  Function MontaValor(pValor: Single): String;
  Begin
    Result := FloatToStr(RoundTo(pValor, -2));
    Result := StringReplace(Result, ',', '.', [rfReplaceAll]);
  End;

begin
  try
    if ObjVolumeEmbalagem.EmbalagemId = 0 then
      vSql := 'Insert Into VolumeEmbalagem (Descricao, Identificacao, Tipo, Altura, Largura, Comprimento, Aproveitamento, Tara, Capacidade, '
        + 'QtdLacres, CodBarras, Disponivel, PrecoCusto, Status) Values (' +
        QuotedStr(ObjVolumeEmbalagem.Descricao) + ', ' +
        QuotedStr(ObjVolumeEmbalagem.Identificacao) + ', ' +
        QuotedStr(ObjVolumeEmbalagem.Tipo) + ', ' +
        MontaValor(ObjVolumeEmbalagem.Altura) + ', ' +
        MontaValor(ObjVolumeEmbalagem.Largura) + ', ' +
        MontaValor(ObjVolumeEmbalagem.Comprimento) + ', ' +
        ObjVolumeEmbalagem.Aproveitamento.ToString() + ', ' +
        MontaValor(ObjVolumeEmbalagem.Tara) + ', ' +
        MontaValor(ObjVolumeEmbalagem.Capacidade) + ', ' +
        ObjVolumeEmbalagem.QtdLacres.ToString() + ', ' +
        ObjVolumeEmbalagem.CodBarras.ToString + ', ' +
        ObjVolumeEmbalagem.Disponivel.ToString() + ', ' +
        MontaValor(ObjVolumeEmbalagem.PrecoCusto) + ', 1)'
      // TuEvolutConst.SqlDataAtual+', '+TuEvolutConst.SqlHoraAtual+', 1)'
    Else
      vSql := 'Update VolumeEmbalagem ' + '    Set Descricao    = ' +
        QuotedStr(ObjVolumeEmbalagem.Descricao) + #13 + #10 +
        '        ,Identificacao = ' +
        QuotedStr(ObjVolumeEmbalagem.Identificacao) + #13 + #10 +
        '        ,Tipo        = ' + QuotedStr(ObjVolumeEmbalagem.Tipo) + #13 +
        #10 + '        ,Altura      = ' + MontaValor(ObjVolumeEmbalagem.Altura)
        + #13 + #10 + '        ,Largura     = ' +
        MontaValor(ObjVolumeEmbalagem.Largura) + #13 + #10 +
        '        ,Comprimento = ' + MontaValor(ObjVolumeEmbalagem.Comprimento) +
        #13 + #10 + '        ,Tara        = ' +
        MontaValor(ObjVolumeEmbalagem.Tara) + #13 + #10 +
        '        ,Capacidade  = ' + MontaValor(ObjVolumeEmbalagem.Capacidade) +
        #13 + #10 + '        ,QtdLacres   = ' +
        ObjVolumeEmbalagem.QtdLacres.ToString() + #13 + #10 +
        '        ,CodBarras   = ' + ObjVolumeEmbalagem.CodBarras.ToString + #13
        + #10 + '        ,Disponivel  = ' +
        ObjVolumeEmbalagem.Disponivel.ToString() + #13 + #10 +
        '        ,PrecoCusto  = ' + MontaValor(ObjVolumeEmbalagem.PrecoCusto) +
        #13 + #10 + '        ,Status      = ' +
        ObjVolumeEmbalagem.Status.ToString() + #13 + #10 +
        'where EmbalagemId = ' + ObjVolumeEmbalagem.EmbalagemId.ToString;
    // ClipBoard.AsText := vSql;
    FConexao.Query.ExecSQL(vSql);
    Result := FConexao.Query.ToJSONArray;
  Except
    On E: Exception do
    Begin
      raise Exception.Create(E.Message);
    End;
  end;
end;

end.
