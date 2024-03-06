{
  UnidadeClass.Pas
  Criado por Genilson S Soares (RhemaSys) em 20/09/2020
  Projeto: RhemaWMS
}
unit EnderecoClass;

interface

Uses System.UITypes, System.StrUtils, System.SysUtils,
  Generics.Collections, Rest.Json, System.Json, Rest.Types,
  EnderecamentoRuaClass,
  EnderecamentoZonaClass,
  EnderecoEstruturaClass,
  DesenhoArmazemClass;

Type

  TEndereco = Class
  private
    FEnderecoId: Integer;
    FEnderecoRua: TEnderecoRua;
    FEnderecoEstrutura: TEnderecoEstrutura;
    FEnderecamentoZona: TEnderecamentoZona;
    FDescricao: String;
    FDesenhoArmazem: TDesenhoArmazem;
    FAltura: Double;
    FLargura: Double;
    FComprimento: Double;
    FVolume: Double;
    FCapacidade: Double; // Peso(g)
    FProdutoId: Integer;
    FCodProduto: Integer;
    FCurva: String;
    FStatus: Integer;
    procedure SetDescricao(const Value: String);
    procedure SetEnderecoId(const Value: Integer);
    procedure SetStatus(const Value: Integer);
  Public
    constructor Create;
    Destructor Destroy; OverRide;
    Class Function ClassToJson(Const ObjEndereco: TEndereco): String;
    Class Function JsonToClass(Json: String): TEndereco;
    Procedure Limpar;
    Class Procedure ConfigSizeField(Tabela: String; Sender: TObject);

    Property EnderecoId: Integer Read FEnderecoId Write SetEnderecoId;
    Property EnderecoRua: TEnderecoRua Read FEnderecoRua Write FEnderecoRua;
    Property EnderecoEstrutura: TEnderecoEstrutura Read FEnderecoEstrutura
      Write FEnderecoEstrutura;
    Property EnderecamentoZona: TEnderecamentoZona Read FEnderecamentoZona
      Write FEnderecamentoZona;
    Property Descricao: String Read FDescricao Write SetDescricao;
    Property DesenhoArmazem: TDesenhoArmazem Read FDesenhoArmazem
      Write FDesenhoArmazem;
    Property Altura: Double Read FAltura Write FAltura;
    Property Largura: Double Read FLargura Write FLargura;
    Property Comprimento: Double Read FComprimento Write FComprimento;
    Property Volume: Double Read FVolume Write FVolume;
    Property Capacidade: Double Read FCapacidade Write FCapacidade;
    Property ProdutoId: Integer Read FProdutoId Write FProdutoId;
    Property CodProduto: Integer Read FCodProduto Write FCodProduto;
    Property Curva: String Read FCurva Write FCurva;
    Property Status: Integer read FStatus write SetStatus;
  End;

implementation

{ TEndereco }

Uses uFuncoes;

class function TEndereco.ClassToJson(Const ObjEndereco: TEndereco): String;
begin
  Result := tJson.ObjectToJsonString(ObjEndereco);
end;

class procedure TEndereco.ConfigSizeField(Tabela: String; Sender: TObject);
begin

end;

constructor TEndereco.Create;
begin
  FEnderecoId := 0;
  FEnderecoRua := TEnderecoRua.Create;
  FEnderecoEstrutura := TEnderecoEstrutura.Create;
  FEnderecamentoZona := TEnderecamentoZona.Create;
  FDesenhoArmazem := TDesenhoArmazem.Create;
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FVolume := 0;
  FCapacidade := 0; // Peso(g)
  FProdutoId := 0;
  FCodProduto := 0;
  FCurva := '';
  FStatus := 0;
end;

destructor TEndereco.Destroy;
begin
  FEnderecoEstrutura.Free;
  FEnderecamentoZona.Free;
  FEnderecoRua.Free;
  FDesenhoArmazem.Free;
  inherited;
end;

class function TEndereco.JsonToClass(Json: String): TEndereco;
begin
  Result := tJson.JsonToObject<TEndereco>(Json, [joDateFormatUnix])
end;

procedure TEndereco.Limpar;
begin
  FEnderecoId := 0;
  FEnderecoRua.Limpar;
  FEnderecoEstrutura.Limpar;
  FEnderecamentoZona.Limpar;
  FDescricao := '';
  FDesenhoArmazem.Limpar;
  FAltura := 0;
  FLargura := 0;
  FComprimento := 0;
  FVolume := 0;
  FCapacidade := 0; // Peso(g)
  FProdutoId := 0;
  FCodProduto := 0;
  FCurva := '';
  FStatus := 0;
end;

procedure TEndereco.SetDescricao(const Value: String);
begin
  FDescricao := Value;
end;

procedure TEndereco.SetEnderecoId(const Value: Integer);
begin
  FEnderecoId := Value;
end;

procedure TEndereco.SetStatus(const Value: Integer);
begin
  FStatus := Value;
end;

end.
