unit uTEnderecoTipo;

interface

uses uTHistorico, uDmCadastroGeral;

type
  TEnderecoTipo = class
    private
      FCodigo: Integer;
      FNome: string;
      FVolumePadrao : Integer;
    public
      property Codigo: Integer        Read FCodigo       Write FCodigo;
      property Nome: string           Read FNome         Write FNome;
      Property VolumePadrao : Integer Read FVolumePadrao Write FVolumePadrao;
      class function ListarEnderecoTipo: OleVariant;
      class function PegarEnderecoTipo(pCodigo: Integer): TEnderecoTipo;
      class function Pesquisar(pCodigo, pNome : string): OleVariant;
      procedure Salvar(pHistorico: THistorico);
      class procedure Excluir(pCodigo: Integer; pHistorico   : THistorico);
  end;

implementation

uses System.SysUtils, DBClient, DB, uFuncoes;

class procedure TEnderecoTipo.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    With DmCadastroGeral.qryVinculos do Begin
      Close;
      Sql.Clear;
      Sql.Add('Select Count(*) TotReg From TbEndereco Where CdEnderecoTipo = '+IntToStr(pCodigo));
      Open;
      if FieldByName('TotReg').AsInteger > 0 then Begin
       		raise Exception.Create('Procedimento n�o autorizado. Existem endere�o(s) vinculado(s) a este Tipo de Endere�o.');
         Exit;
      End;
    End;
    With DmCadastroGeral.qryExcluir do Begin
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;
      Close;
      Sql.Clear;
      Sql.Add('Delete From TbEnderecoTipo Where CdEnderecoTipo = '+IntToStr(pCodigo));
      ExecSQL;

      pHistorico.CodigoRegistro := pCodigo;
      pHistorico.Observacao     := 'Exclus�o de Tipo de Endere�os';
      pHistorico.Salvar;
      Connection.CommitTrans;
    End;
  except
    DmCadastroGeral.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Opera��o inv�lida!' + #13 +
                           'Existem v�nculos que impedem a exclus�o deste Tipo de Endere�o.');
  end;
end;

class function TEnderecoTipo.ListarEnderecoTipo: OleVariant;
begin
  With DmCadastroGeral.qryPesquisar do Begin
    Close;
    Sql.Clear;
    Sql.Add('Select CdEnderecoTipo, NmEnderecoTipo, Mascara, Coalesce(VolumePadrao, 0) as VolumePadrao From TbEnderecoTipo');
    Open;
  End;
  Result := DmCadastroGeral.DspPesquisar.Data;
end;

class function TEnderecoTipo.PegarEnderecoTipo(pCodigo: Integer): TEnderecoTipo;
var
  vlPesquisar  : TClientDataSet;
  vlEnderecoTipo : TEnderecoTipo;
begin
  vlPesquisar := TClientDataSet.Create(nil);
  try
    vlPesquisar.Close;
    vlPesquisar.Data := Pesquisar(IntToStr(pCodigo), '');
    if (vlPesquisar.IsEmpty = True) then
     		raise Exception.Create('C�digo do Tipo de Endere�o inv�lido!');
    vlEnderecoTipo        := TEnderecoTipo.Create;
    vlEnderecoTipo.Codigo := vlPesquisar.FieldByName('CdEnderecoTipo').AsInteger;
    vlEnderecoTipo.Nome   := vlPesquisar.FieldByName('nmEnderecoTipo').AsString;
    vlEnderecoTipo.VolumePadrao := vlPesquisar.FieldByName('VolumePadrao').AsInteger;
    Result := vlEnderecoTipo;
  finally
    FreeAndNil(vlPesquisar);
  end;
end;

class function TEnderecoTipo.Pesquisar(pCodigo, pNome: string): OleVariant;
begin
  if (Trim(pCodigo) = '') then pCodigo := '%';
  if (Trim(pNome) = '') then  pNome := '%';
  With DmCadastroGeral.qryPesquisar do Begin                                                                      Close;
    Sql.Clear;
    Sql.Add('Select NmEnderecoTipo, CdEnderecoTipo, VolumePadrao From TbEnderecoTipo');
    Sql.Add('Where CdEnderecoTipo like :pCdEnderecoTipo and NmEnderecoTipo like :pNmEnderecoTIpo');
    Parameters.ParamByName('pCdEnderecoTipo').Value := pCodigo;
    Parameters.ParamByName('pNmEnderecoTipo').Value := pNome;
    Open;
    Result := DmCadastroGeral.DspPesquisar.Data;
  End;
end;

procedure TEnderecoTipo.Salvar(pHistorico: THistorico);
begin
  With DmCadastroGeral do Begin
    QrySalvar.Connection.Execute('SET NOCOUNT ON;');
    QrySalvar.Connection.BeginTrans;
    try
      With QrySalvar do Begin
        Close;
        Sql.Clear;
        Sql.Add('Declare @Codigo As Integer = '+IntToStr(FCodigo)+';');
        Sql.Add('Declare @Descricao As VarChar(255) = '+QuotedStr(FNome)+';');
        Sql.Add('Declare @VolumePadrao Integer = '+FVolumePadrao.ToString());
        Sql.Add('if (@Codigo = 0)');
        Sql.Add('   Begin');
        Sql.Add('		   set @Codigo = (select coalesce(MAX(CdEnderecoTipo), 0) + 1 from TbEnderecoTipo);');
        Sql.Add('		   insert into TbEnderecoTipo (CdEnderecoTipo, NmEnderecoTipo, VolumePadrao) Values ('	);
        Sql.Add('         			@Codigo, @Descricao, @VolumePadrao);');
        Sql.Add('  	end');
        Sql.Add('else');
        Sql.Add('   begin ');
        Sql.Add('		   update TbEnderecoTipo Set');
        Sql.Add('   			    NmEnderecoTipo = @Descricao');
        Sql.Add('            , VolumePadrao   = @VolumePadrao');
        Sql.Add('   		where CdEnderecoTipo = @Codigo');
        Sql.Add('  	end;');
        Sql.Add('select @Codigo as CdEnderecoTipo;');
        if DebugHook <> 0 then Sql.SaveToFile('EnderecoTipo.Txt');
        ExecSQL;
      End;
      if FCodigo = 0 then pHistorico.Observacao     := 'Inclus�o de Novo Tipo de Endere�o'
      Else pHistorico.Observacao     := 'Altera��o do Cadastro de Tipo de Endere�os';
      pHistorico.CodigoRegistro := FCodigo;
      pHistorico.Salvar;
      QrySalvar.Connection.CommitTrans;
    except on e: Exception do
      begin
        QrySalvar.Connection.RollbackTrans;

        raise Exception.Create(e.Message);
      end;
    end;
  End;
end;

end.
