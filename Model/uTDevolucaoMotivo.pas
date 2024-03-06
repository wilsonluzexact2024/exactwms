unit uTDevolucaoMotivo;

interface

uses uTHistorico;

type
  TDevolucaoMotivo = class
    private
      FCodigo: Integer;
      FNome: string;

      procedure ValidarDados;
    public
      property Codigo: Integer  read FCodigo  write FCodigo;
      property Nome: string     read FNome    write FNome;

      class procedure Excluir(pCodigo: Integer; pHistorico: THistorico);
      class function  Pesquisar(pCodigo, pNome: string): OleVariant;

      procedure Salvar(pHistorico: THistorico);
  end;

implementation

uses SysUtils, DB, DBClient, uDmDevolucaoMotivo;

{ TDevolucaoMotivo }

class procedure TDevolucaoMotivo.Excluir(pCodigo: Integer; pHistorico: THistorico);
begin
  try
    dmDevolucaoMotivo.qryExcluir.Connection.Execute('SET NOCOUNT ON;');
    dmDevolucaoMotivo.qryExcluir.Connection.BeginTrans;

    dmDevolucaoMotivo.qryExcluir.Close;
    dmDevolucaoMotivo.qryExcluir.Parameters.ParamByName('pCdDevolucaoMotivo').Value := pCodigo;
    dmDevolucaoMotivo.qryExcluir.ExecSQL;

    pHistorico.CodigoRegistro := pCodigo;
    pHistorico.Observacao     := 'Exclus�o do Motivo de Devolu��o';

    pHistorico.Salvar;

    dmDevolucaoMotivo.qryExcluir.Connection.CommitTrans;
  except
    dmDevolucaoMotivo.qryExcluir.Connection.RollbackTrans;

    raise Exception.Create('Opera��o inv�lida!' + #13 +
                           'Existem v�nculos que impedem a exclus�o deste Motivo.');
  end;
end;

class function TDevolucaoMotivo.Pesquisar(pCodigo, pNome: string): OleVariant;
begin
  pCodigo := Trim(pCodigo);
  pNome   := Trim(pNome);

  if (pCodigo = '') then
    begin
      pCodigo := '%';
    end;

  if (pNome = '') then
    begin
      pNome := '%';
    end;

  dmDevolucaoMotivo.qryPesquisar.Close;
  dmDevolucaoMotivo.qryPesquisar.Parameters.ParamByName('pCdDevolucaoMotivo').Value := pCodigo;
  dmDevolucaoMotivo.qryPesquisar.Parameters.ParamByName('pNmDevolucaoMotivo').Value := pNome;
  dmDevolucaoMotivo.qryPesquisar.Open;

  Result := dmDevolucaoMotivo.dspPesquisar.Data;
end;

procedure TDevolucaoMotivo.Salvar(pHistorico: THistorico);
var
  vlCodigo: Integer;
begin
  ValidarDados;

  if (FCodigo = 0) then
    begin
      pHistorico.Observacao := 'Cadastro de Novo Motivo de Devolu��o: ' + FNome;
    end
  else
    begin
      pHistorico.Observacao := 'Altera��o do Motivo de Devolu��o: ' + FNome;
    end;

  vlCodigo := FCodigo;

  try
    dmDevolucaoMotivo.qrySalvar.Connection.Execute('SET NOCOUNT ON;');
    dmDevolucaoMotivo.qrySalvar.Connection.BeginTrans;

    dmDevolucaoMotivo.qrySalvar.Close;
    dmDevolucaoMotivo.qrySalvar.Parameters.ParamByName('pCdDevolucaoMotivo').Value := FCodigo;
    dmDevolucaoMotivo.qrySalvar.Parameters.ParamByName('pNmDevolucaoMotivo').Value := FNome;
    dmDevolucaoMotivo.qrySalvar.Open;

    FCodigo := dmDevolucaoMotivo.qrySalvar.FieldByName('cdDevolucaoMotivo').AsInteger;

    pHistorico.CodigoRegistro := FCodigo;

    pHistorico.Salvar;

    dmDevolucaoMotivo.qrySalvar.Connection.CommitTrans;
  except on E: Exception do
    begin
      dmDevolucaoMotivo.qrySalvar.Connection.RollbackTrans;

      FCodigo := vlCodigo;

      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TDevolucaoMotivo.ValidarDados;
var
  vlPesquisar: TClientDataSet;
begin
  if (FCodigo < 0) then
    begin
      raise Exception.Create('C�digo do Motivo de Devolu��o inv�lido!');
    end;

  FNome := Trim(FNome);

  if (FNome = '') then
    begin
      raise Exception.Create('Informe o Nome do Motivo de Devolu��o!');
    end;

  vlPesquisar := TClientDataSet.Create(nil);

  try
    vlPesquisar.Data := Pesquisar('', FNome);

    if (vlPesquisar.IsEmpty = False) then
      begin
        if (vlPesquisar.FieldByName('cdDevolucaoMotivo').AsInteger <> FCodigo) then
          begin
            raise Exception.Create('Motivo inv�lido!' + #13 +
                                   'J� existe outro motivo registrado com essa descri��o.');
          end;
      end;
  finally
    FreeAndNil(vlPesquisar);
  end;
end;

end.
