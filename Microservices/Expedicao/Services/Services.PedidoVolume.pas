unit Services.PedidoVolume;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  REST.JSON, Generics.Collections;

Type
  TServicePedidoVolume = class
    Function BaixarEstoqueExpedicao: Boolean;
  end;

implementation

uses
  Repository.SqlScripts.PedidoVolume, Server.Connection;

Function TServicePedidoVolume.BaixarEstoqueExpedicao: Boolean;
begin
  var
  Con := TConnection.Create();
  try
    Con.DB.ExecSQL(TScriptRepository.ScriptBaixaEstoqueReposicao);
  finally
    FreeAndNil(Con)
  end;

end;

end.
