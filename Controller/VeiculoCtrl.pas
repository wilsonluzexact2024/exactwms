{
   VeiculoCtrl.Pas
   Criado por Genilson S Soares em 28/05/2021
   Projeto: eXactWMS
}
unit VeiculoCtrl;

interface

Uses VCL.Forms, System.UITypes, System.StrUtils, System.SysUtils, Vcl.Controls,
     Vcl.Dialogs, Generics.Collections, Rest.Json,
     System.Json, Rest.Types
     , VeiculoClass;

Type
  TVeiculoCtrl = Class
  Private
    FObjVeiculo : TVeiculo;
  Public
    constructor Create;
    destructor Destroy; override;
    Function VerificaDados : Boolean;
    Function GetVeiculo(pVeiculoId : Integer = 0; pPlaca : String = ''; pTransportadoraId : Integer = 0; pShowErro : Integer = 1) : TJsonArray;
    Function Salvar  : Boolean;  //(pHistorico: THistorico)
    Function DelVeiculo : Boolean;
    Property ObjVeiculo : TVeiculo Read FObjVeiculo Write FObjVeiculo;
  End;

implementation

{ tCtrlVeiculo }

uses uDmeXactWMS, uFuncoes, VeiculoDAO;

Function tVeiculoCtrl.VerificaDados : Boolean;
Begin
  Result := False;
  With Self.FObjVeiculo do Begin
    If Placa = '' Then
       raise Exception.Create('Informe a Placa do ve�culo.');
    if (CombustivelTipo<>'') and (Not (CombustivelTipo[1] in [' ', 'E', 'G', 'D', 'F'])) then
       raise Exception.Create('Informe o Tipo do Combust�vel.');
    if ObjVeiculo.Altura*ObjVeiculo.Largura*ObjVeiculo.Comprimento <= 0 then
       raise Exception.Create('Especifi��es de volumetria(Altura x Largura x Comprimento) inv�lido.');
    if Self.FObjVeiculo.Aproveitamento <= 0 then
       raise Exception.Create('Informe o percentual de aproveitamento(m�ximo) da Ve�culo.');
  End;
  Result := True;
End;

constructor TVeiculoCtrl.Create;
begin
  FObjVeiculo := TVeiculo.Create;
end;

function TVeiculoCtrl.DelVeiculo : Boolean;
Var ObjVeiculoDAO : TVeiculoDAO;
begin
  ObjVeiculoDAO := TVeiculoDAO.Create;
  //ObjVeiculoDAO.ObjVeiculo.VeiculoId := Self.ObjVeiculo.VeiculoId;
  Result := ObjVeiculoDAO.Delete(Self.ObjVeiculo.VeiculoId);
  if Result then
     Self.ObjVeiculo.VeiculoId := 0;
  ObjVeiculoDAO := Nil;
  ObjVeiculoDAO.DisposeOf;
end;

destructor TVeiculoCtrl.Destroy;
begin
  FreeAndNil(FObjVeiculo);
  inherited;
end;

function TVeiculoCtrl.GetVeiculo(pVeiculoId: Integer; pPlaca: String; pTransportadoraId : Integer;
  pShowErro : Integer): TJsonArray;
Var //ReturnJson    : TJsonArray;
    ObjVeiculoDAO : TVeiculoDAO;
    vErro         : String;
begin
  ObjVeiculoDAO := TVeiculoDAO.Create;
//  ObjVeiculoDAO.ObjVeiculo.VeiculoId        := pVeiculoId;
//  ObjVeiculoDAO.ObjVeiculo.Placa            := pPlaca;
//  ObjVeiculoDAO.ObjVeiculo.TransportadoraId := pTransportadoraId;
  Result := ObjVeiculoDAO.GetVeiculo(pVeiculoId, pPlaca, pTransportadoraId);
  ObjVeiculoDAO := Nil;
  ObjVeiculoDAO.DisposeOf;
  If (pShowErro = 1) and (Result.Get(0).TryGetValue('Erro', vErro)) then
     Raise Exception.Create('Erro: '+vErro);
end;

function TVeiculoCtrl.Salvar: Boolean;
Var ObjVeiculoDAO : TVeiculoDAO;
Begin
  if Not VerificaDados then
     Exit;
  ObjVeiculoDAO := TVeiculoDAO.Create;
//  ObjVeiculoDAO.ObjVeiculo := ObjVeiculo;
  Result := ObjVeiculoDAO.Salvar(ObjVeiculo);
  if Result then
     Self.ObjVeiculo.VeiculoId := 0;
  ObjVeiculoDAO := Nil;
  ObjVeiculoDAO.DisposeOf;
end;

End.

