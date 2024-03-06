unit uTEnderecoLogistico;

interface

uses uTHistorico;

Type
  TEnderecoLogistico = Class
  Private
    FCodigo      : Integer;
    FSequencia   : Integer;
    FDescricao   : String;
    FPeso        : Integer;
    FValidaPeso  : Boolean;
    FAltura      : Integer;
    FLargura     : Integer;
    FComprimento : Integer;
    FVolume      : Integer;
    FStatus      : Boolean;
  Public
    Constructor Create(cCodigo : Integer = 0; cSequencia : Integer = 0; cDescricao : String = '';
                       cPeso : Integer = 0; cAltura : Integer = 0; cLargura : Integer = 0;
                       cComprimento : Integer = 0; cVolume : Integer = 0;
                       cValidaPeso : Boolean = False; cStatus : Boolean = False);
    Property Codigo      : Integer Read FCodigo      Write FCodigo;
    Property Sequencia   : Integer Read FSequencia   Write FSequencia;
    Property Descricao   : String  Read FDescricao   Write FDescricao;
    Property Peso        : Integer Read FPeso        Write FPeso;
    Property ValidaPeso  : Boolean Read FValidaPeso  Write FValidaPeso;
    Property Altura      : Integer Read FAltura      Write FAltura;
    Property Largura     : Integer Read FLargura     Write FLargura;
    Property Comprimento : Integer Read FComprimento Write FComprimento;
    Property Volume      : Integer Read FVolume      Write FVolume;
    Property Status      : Boolean Read FStatus      Write FStatus;

    class procedure Excluir(pCodigo  : Integer; pHistorico : THistorico);
    class function Pesquisar(pCodigo : Integer; pDescricao : String): TEnderecoLogistico;
    class function Lista(pCodigo : Integer; pDescricao : String): OleVariant;
    procedure Salvar(pHistorico: THistorico);
    Procedure ValidarDados;
  End;
implementation

{ TEnderecoLogistico }

Uses uDmEnderecoLogistico, System.Variants, System.SysUtils;

class procedure TEnderecoLogistico.Excluir(pCodigo: Integer;
  pHistorico: THistorico);
begin
  With DmEnderecoLogistico.QryExcluir do Begin
    Try
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;
      Close;
      Parameters.ParamByName('pCodigo').Value := pCodigo;
      ExecSql;
      pHistorico.CodigoRegistro := pCodigo;
      pHistorico.Observacao := 'Exclus�o Dados Log�sticos de Endere�os: ' + pCodigo.ToString();
      pHistorico.Salvar;
    Except On E:Exception do Begin
      Connection.RollbackTrans;
      raise Exception.Create('Erro na opera��o!' + #13 +
                             'N�o foi poss�vel exluir o os Dados log�stico de Endere�os!');
      End;
    End;
  End;
end;

class function TEnderecoLogistico.Lista(pCodigo: Integer;
  pDescricao: String): OleVariant;
begin
  With DmEnderecoLogistico.qryPesquisar do Begin
    Close;
    parameters.ParamByName('pCodigo').Value := pCodigo;
    Parameters.ParamByName('pDescricao').Value := pDescricao;
    Open;
  End;
  Result := DmEnderecoLogistico.DspPesquisar.Data;
end;

class function TEnderecoLogistico.Pesquisar(pCodigo: Integer;
  pDescricao: String): TEnderecoLogistico;
begin
  Result := Create(0, 0, '', 0, 0, 0, 0, 0, False, False); //TEquiptoTransit.
  With DmEnderecoLogistico.qryPesquisar do Begin
    Close;
    parameters.ParamByName('pCodigo').Value    := pCodigo;
    Parameters.ParamByName('pDescricao').Value := pDescricao;
    Open;
    if IsEmpty then raise Exception.Create('Dados Log�stico n�o encontrado!');
    Result.Codigo      := FieldByName('Codigo').AsInteger;
    Result.FSequencia  := FieldByName('Sequencia').AsInteger;
    Result.Descricao   := FieldByName('Descricao').AsString;
    Result.Peso        := FieldByName('Peso').AsInteger;
    Result.ValidaPeso  := FieldByname('ValidaPeso').AsBoolean = True;
    Result.Altura      := FieldByName('Altura').AsInteger;
    Result.Largura     := FieldByName('Largura').AsInteger;
    Result.Comprimento := FieldByName('Comprimento').AsInteger;
    Result.Status      := Not FieldByname('ValidaPeso').AsBoolean = True;
  End;
end;

procedure TEnderecoLogistico.Salvar(pHistorico: THistorico);
begin
  if (FCodigo = 0) then
      pHistorico.Observacao := 'Cadastro de novo  Dados Log�stico par Endere�os: '
  else
      pHistorico.Observacao := 'Altera��o de Dados Log�stico para Endere�os: ';
  With DmEnderecoLogistico.QrySalvar do Begin
    try
      Connection.Execute('SET NOCOUNT ON;');
      Connection.BeginTrans;
      Close;
      Parameters.ParamByName('pCodigo').Value      := Self.Codigo;
      Parameters.ParamByName('pSequencia').Value   := Self.Sequencia;
      Parameters.ParamByName('pDescricao').Value   := Self.Descricao;
      Parameters.ParamByName('pPeso').Value        := Self.Peso;
      Parameters.ParamByName('pValidaPeso').Value  := Self.ValidaPeso;
      Parameters.ParamByName('pAltura').Value      := Self.Altura;
      Parameters.ParamByName('pLargura').Value     := Self.Largura;
      Parameters.ParamByName('pComprimento').Value := Self.comprimento;
      Parameters.ParamByName('pStatus').Value      := Self.Status;
      Open;
      Self.Codigo := FieldByName('Codigo').AsInteger;
      pHistorico.CodigoRegistro := Self.Codigo;
      pHistorico.Salvar;
      Connection.CommitTrans;
    except on E: Exception do
      begin
        Connection.RollbackTrans;
        Self.Codigo := FCodigo;
        raise Exception.Create(E.Message);
      end;
    end;
  End;
end;

procedure TEnderecoLogistico.ValidarDados;
begin
  if Self.Descricao = '' then
     raise Exception.Create('Informe uma descri��o(Nome) para os Dados Log�stico.');
  if Self.Sequencia <= 0 then
     raise Exception.Create('Informe Sequ�ncia para os Dados Log�stico.');
end;

{ TEnderecoLogistico }

constructor TEnderecoLogistico.Create(cCodigo, cSequencia: Integer; cDescricao: String; cPeso, cAltura,
  cLargura, cComprimento, cVolume: Integer; cValidaPeso, cStatus: Boolean);
begin
  FCodigo      := cCodigo;
  FSequencia   := cSequencia;
  FDescricao   := cDescricao;
  FPeso        := cPeso;
  FValidaPeso  := cValidaPeso;
  FAltura      := cAltura;
  FLargura     := cLargura;
  FComprimento := cComprimento;
  FVolume      := cVolume;
  FStatus      := cStatus;
end;

end.
