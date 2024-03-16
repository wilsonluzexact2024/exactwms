unit Services.PedidoVolume;
interface
uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  REST.JSON, Generics.Collections,
  FireDAC.Comp.Client, FireDAC.Stan.Error;
Type
  TServicePedidoVolume = class
    Function BaixarEstoqueExpedicao: Boolean;
  end;
implementation
uses
  Repository.SqlScripts.PedidoVolume, Server.Connection;
Function TServicePedidoVolume.BaixarEstoqueExpedicao: Boolean;
Var vQryVolumeParaExpedicao, vQryLoteExistente, vQryLoteInexistente,
    vQryGerarKardex, vQryBaixaEstoque : TFdQuery;
begin
  var
  Con := TConnection.Create();
  try
    Try
      vQryVolumeParaExpedicao := TFdQuery.Create(Nil);
      vQryVolumeParaExpedicao.Connection := Con.DB;
      vQryLoteExistente   := TFdQuery.Create(Nil);
      vQryLoteExistente.Connection := vQryVolumeParaExpedicao.Connection;
      vQryLoteInexistente := TFdQuery.Create(Nil);
      vQryLoteInexistente.Connection := vQryVolumeParaExpedicao.Connection;
      vQryGerarKardex := TFdQuery.Create(Nil);
      vQryGerarKardex.Connection := vQryVolumeParaExpedicao.Connection;
      vQryBaixaEstoque := TFdQuery.Create(Nil);
      vQryBaixaEstoque.Connection := vQryVolumeParaExpedicao.Connection;

      vQryVolumeParaExpedicao.SQL.Add( TScriptRepository.GetVolumeParaExpedicao );
      vQryVolumeParaExpedicao.Open;
      While Not vQryVolumeParaExpedicao.Eof do Begin
        Writeln('       ' + FormatDateTime('hh:nn:ss.zzz', now) + ' - ' + 'Processando Volume: '+vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsString);
        Try
          vQryLoteInexistente.Close;
          vQryLoteInexistente.SQL.Clear;
          vQryLoteInexistente.Sql.Add(TScriptRepository.GetLoteInexistente);
          vQryLoteInexistente.ParamByName('pPedidoVolumeId').Value := vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsInteger;
          vQryLoteInexistente.Open;

          vQryVolumeParaExpedicao.connection.StartTransaction;
          vQryGerarKardex.Close;
          vQryGerarKardex.SQL.Clear;
          vQryGerarKardex.Sql.Add(TScriptRepository.GerarKardexReserva);
          vQryGerarKardex.ParamByName('pPedidoVolumeId').Value := vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsInteger;
          vQryGerarKardex.ParamByName('pUsuarioId').Value      := vQryVolumeParaExpedicao.FieldByName('UsuarioId').AsInteger;
          vQryGerarKardex.ExecSql;

          vQryLoteExistente.Close;
          vQryLoteExistente.SQL.Clear;
          vQryLoteExistente.Sql.Add(TScriptRepository.GetLoteExistente);
          vQryLoteExistente.ParamByName('pPedidoVolumeId').Value := vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsInteger;
          vQryLoteExistente.ExecSql;

          While Not vQryLoteInexistente.Eof do Begin
            vQryBaixaEstoque.Close;
            vQryBaixaEstoque.Sql.Clear;
//            vQryBaixaEstoque.SQL.Add('Declare @PedidoVolumeId Integer = :pPedidoVolumeId');
            vQryBaixaEstoque.Sql.Add('Insert Into Estoque Values (');
            vQryBaixaEstoque.Sql.Add(vQryLoteInexistente.FieldByName('LoteId').AsString+', '+
                                     vQryLoteInexistente.FieldByName('EnderecoId').AsString+', '+
                                     vQryLoteInexistente.FieldByName('EstoqueTipoId').AsString+', '+
                                     (vQryLoteInexistente.FieldByName('QtdSuprida').AsInteger*-1).ToString()+', ');
            //Select Vl.Loteid, Vl.EnderecoId, Vl.EstoqueTipoId, Vl.QtdSuprida*-1,');' +
  		        vQryBaixaEstoque.Sql.Add('   (SELECT IDDATA FROM RHEMA_DATA WHERE DATA = CAST(GETDATE() AS DATE)) ,');
            vQryBaixaEstoque.Sql.Add('   (SELECT IDHORA FROM RHEMA_HORA WHERE HORA = (SELECT SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), NULL, NULL, NULL, Null)');
            //vQryBaixaEstoque.Sql.Add('   FROM PEDIDOVOLUMELOTES VL');
            //vQryBaixaEstoque.Sql.Add('   Left join Estoque Est On Est.Loteid = Vl.Loteid and Est.EnderecoId = Vl.EnderecoId and Est.EstoqueTipoId = Vl.EstoqueTipoId');
            //vQryBaixaEstoque.Sql.Add('   WHERE VL.PEDIDOVOLUMEID = @PEDIDOVOLUMEID and Est.LoteId Is Null  ');
            //vQryBaixaEstoque.ParamByName('pPedidoVolumeId').Value := vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsInteger;
            vQryBaixaEstoque.Sql.SaveToFile('ExpLoteInexistenteBaixa.Sql');
            vQryBaixaEstoque.ExecSql;
            vQryLoteInexistente.Next;
          End;
          vQryVolumeParaExpedicao.connection.Commit;
          Sleep(10);
        Except On E: Exception do Begin
          if vQryVolumeParaExpedicao.connection.InTransaction then
             vQryVolumeParaExpedicao.connection.RollBack;
          Writeln('       ' + FormatDateTime('hh:nn:ss.zzz', now) + ' - ' + 'ERRO: Volume: '+
                  vQryVolumeParaExpedicao.FieldByName('PedidoVolumeId').AsString);
          Sleep(50);
          End;
        End;
        vQryVolumeParaExpedicao.Next;
      End;
    Except

    End;
    //Con.DB.ExecSQL(TScriptRepository.ScriptBaixaEstoqueReposicao);
  finally
    FreeAndNil(vQryVolumeParaExpedicao);
    FreeAndNil(vQryLoteExistente);
    FreeAndNil(vQryLoteInexistente);
    FreeAndNil(vQryGerarKardex);
    FreeAndNil(vQryBaixaEstoque);
    FreeAndNil(Con);
  end;
end;
end.
