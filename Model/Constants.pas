unit Constants;

interface

Type

  { Verificar se existe chave json
    JSON_OBJETO.has("chave")
    https://maguscode.blogspot.com/2019/01/como-verificar-se-uma-chave-existe-em.html

    Cm3 em M3
    http://www.conversorfacil.com.br/conversor-de-medidas/unidades-de-volume#:~:text=O%20calculo%20de%20volume%20deve,volume%20de%202000%20cm3.
  }
  TuEvolutConst = record
    // Pedidos Cubagem
  Const
    SqlZerarIdentify = 'DBCC CHECKIDENT (' + #39 + 'Produto' + #39 +
      ', RESEED, 0)';

  Const
    QrySemDados = 'N�o foram encontrados dados na pesquisa!';

    // https://dbasqlserverbr.com.br/descobrir-ip-do-servidor-sql-server/
  Const
    DadosServerSql = 'SELECT @@SERVERNAME,' + sLineBreak + 'CONNECTIONPROPERTY('
      + #39 + 'net_transport' + #39 + ') AS net_transport,' + sLineBreak +
      'CONNECTIONPROPERTY(' + #39 + 'protocol_type' + #39 +
      ') AS protocol_type,' + sLineBreak + 'CONNECTIONPROPERTY(' + #39 +
      'auth_scheme' + #39 + ') AS auth_scheme,' + sLineBreak +
      'CONNECTIONPROPERTY(' + #39 + 'local_net_address' + #39 +
      ') AS local_net_address,' + sLineBreak + 'CONNECTIONPROPERTY(' + #39 +
      'local_tcp_port' + #39 + ') AS local_tcp_port,' + sLineBreak +
      'CONNECTIONPROPERTY(' + #39 + 'client_net_address' + #39 +
      ') AS client_net_address';

    // https://www.devmedia.com.br/criptografia-de-dados-no-sql-server/37027
Const SqlCriptografia = '';

    // Hash Md5
Const SqlHashMd5 = 'Select CONVERT(VARCHAR(32), HashBytes(' + #39 + 'MD5' + #39 +
      ', ' + #39 + '189.112.121.58' + #39 + '), 2) as MD5Hash';

Const SqlDataAtual = '(Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))';

Const SqlHoraAtual = '(select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)))';

Const SqlRetornoDataFormatDataHora = 'Cast(CONVERT(DATETIME, CONVERT(CHAR(8), De.Data, 112)+'#39 + ' ' + #39 +
      '+CONVERT(CHAR(8),He.Hora, 108)) as DateTime) AS Horario)';

Const SqlGetUsuarioAcessoFuncionalidade = 'select UF.* From Funcionalidades F' +
      sLineBreak +
      'Inner join UsuarioFuncionalidades UF On UF.FuncionalidadeId = F.Funcionalidadeid'
      + sLineBreak + 'Inner Join usuarios U on U.usuarioid = UF.UsuarioId' +
      sLineBreak +
      'where F.Descricao = :pFuncionalidade and U.UsuarioId = :pUsuarioId';

Const SqlGetUsuarioAcessoTopico = 'select UT.* From Topicos T' + sLineBreak +
      'Inner join UsuarioTopicos UT On UT.TopicoId = T.TopicoId' + sLineBreak +
      'Inner Join usuarios U on U.usuarioid = UT.UsuarioId' + sLineBreak +
      'where T.Descricao = :pTopico and U.UsuarioId = :pUsuarioId';

Const SqlGetUsuarioListaFuncionalidade = 'select UF.* From Funcionalidades F' +
      sLineBreak +
      'Inner join UsuarioFuncionalidades UF On UF.FuncionalidadeId = F.Funcionalidadeid'
      + sLineBreak + 'Inner Join usuarios U on U.usuarioid = UF.UsuarioId' +
      sLineBreak + 'where U.UsuarioId = :pUsuarioId';

  Const
    SqlGetControleAcessoModulo =
      'select T.TopicoId, T.Descricao, T.Status, (Case When UT.TopicoId Is Not Null Then 1 Else 0 End) as Acesso'
      + sLineBreak + 'from Topicos T' + sLineBreak +
      'Left Join UsuarioTopicos UT ON UT.TopicoId = T.TopicoId and UT.Usuarioid = :pUsuarioId';

  Const
    SqlGetPerfilControleAcessoTopico =
      'select T.TopicoId, T.Descricao, T.Status, (Case When PT.PerfilId Is Not Null Then 1 Else 0 End) as Acesso'
      + sLineBreak + 'from Topicos T' + sLineBreak +
      'Left Join PerfilTopicos PT ON PT.TopicoId = T.TopicoId and PT.Perfilid = :pPerfilId';

Const
    SqlGetControleAcessoFuncionalidade =
      'Declare @Usuarioid Integer = :pUsuarioId' + sLineBreak +
      'select T.TopicoId, F.FuncionalidadeId, F.Descricao, F.Status, (Case When UF.FuncionalidadeId Is Not Null Then 1 Else 0 End) as Acesso'
      + sLineBreak + 'from Funcionalidades F' + sLineBreak +
      'Inner Join TopicoFuncionalidades TF ON TF.FuncionalidadeId = F.Funcionalidadeid'
      + sLineBreak + 'Inner join Topicos T ON T.TopicoId = TF.TopicoId' +
      sLineBreak +
      'Left Join UsuarioFuncionalidades UF ON UF.FuncionalidadeId = F.FuncionalidadeId and UF.Usuarioid = @usuarioid'
      + sLineBreak + 'Order by T.TopicoId, F.Descricao';

  Const
    SqlSalvarPerfilAcessoTopico = 'Declare @PerfilId Integer = :pPerfilId' +
      sLineBreak + 'Declare @TopicoId Integer  = :pTopicoId' + sLineBreak +
      'Declare @Acesso    Integer = :pAcesso' + sLineBreak +
      'If @Acesso = 0 Begin' + sLineBreak +
      '   Delete from PerfilTopicos where Perfilid = @PerfilId and TopicoId = @TopicoId'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '  If Not Exists (Select PerfilId From PerfilTopicos Where PerfilId = @PerfilId and TopicoId = @TopicoId) Begin'
      + sLineBreak +
      '     Insert into PerfilTopicos Values (@PerfilId, @TopicoId, 1)' +
      sLineBreak + '  End' + sLineBreak + '  Else Begin' + sLineBreak +
      '     Update PerfilTopicos Set Status = 1 where PerfilId = @PerfilId and TopicoId = @TopicoId'
      + sLineBreak + '  End' + sLineBreak + 'End';

  Const
    SqlRelUsuarioLista = 'Declare @UsuarioId Integer = :pUsuarioId' + sLineBreak
      + 'Declare @FuncionalidadeId Integer = :pFuncionalidadeId' + sLineBreak +
      'Declare @PerfilId  Integer = :pPerfilId' + sLineBreak +
      'Declare @Status    Integer = :pStatus' + sLineBreak +
      'select U.UsuarioId, U.Nome, P.PerfilId, P.Descricao Perfil, T.TopicoId, T.Descricao Topico,'
      + sLineBreak +
      '       UF.FuncionalidadeId, F.Descricao Funcionalidade, U.Status' +
      sLineBreak + 'From Usuarios U' + sLineBreak +
      'Left Join Perfil P On P.PerfilId = U.PerfilId' + sLineBreak +
      'Left Join UsuarioFuncionalidades Uf On Uf.Usuarioid = U.UsuarioId' +
      sLineBreak +
      'Left join Funcionalidades F On F.Funcionalidadeid = Uf.FuncionalidadeId'
      + sLineBreak +
      'Left join TopicoFuncionalidades TF On Tf.FuncionalidadeId = F.Funcionalidadeid'
      + sLineBreak + 'Left Join Topicos T On T.TopicoId = TF.TopicoId' +
      sLineBreak + 'where (@UsuarioId = 0 or U.UsuarioId = @UsuarioId)' +
      sLineBreak +
      '  and (@FuncionalidadeId = 0 or F.FuncionalidadeId = @FuncionalidadeId)'
      + sLineBreak + '  and (@PerfilId = 0 or U.PerfilId = @PerfilId)' +
      sLineBreak + '  and (@Status = 3 or U.Status = @Status)' + sLineBreak +
      'Order by U.Nome, T.Descricao, F.Descricao';

  Const
    SqlSalvarAcessoTopico = 'Declare @UsuarioId Integer = :pUsuarioId' +
      sLineBreak + 'Declare @TopicoId Integer  = :pTopicoId' + sLineBreak +
      'Declare @Acesso    Integer = :pAcesso' + sLineBreak +
      'If @Acesso = 0 Begin' + sLineBreak +
      '   Delete from UsuarioTopicos where Usuarioid = @UsuarioId and TopicoId = @TopicoId'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '  If Not Exists (Select UsuarioId From UsuarioTopicos Where Usuarioid = @UsuarioId and TopicoId = @TopicoId) Begin'
      + sLineBreak +
      '     Insert into UsuarioTopicos Values (@UsuarioId, @TopicoId, 1)' +
      sLineBreak + '  End' + sLineBreak + '  Else Begin' + sLineBreak +
      '     Update UsuarioTopicos Set Status = 1 where Usuarioid = @UsuarioId and TopicoId = @TopicoId'
      + sLineBreak + '  End' + sLineBreak + 'End';

  Const
    SqlSalvarPerfilAcessoFuncionalidade =
      'Declare @PerfilId Integer = :pPerfilId' + sLineBreak +
      'Declare @FuncionalidadeId Integer = :pFuncionalidadeId' + sLineBreak +
      'Declare @Acesso    Integer = :pAcesso' + sLineBreak +
      'If @Acesso = 0 Begin' + sLineBreak +
      '   Delete from PerfilFuncionalidades where PerfilId = @PerfilId and FuncionalidadeId = @FuncionalidadeId'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '  If Not Exists (Select PerfilId From PerfilFuncionalidades Where Perfilid = @PerfilId and FuncionalidadeId = @FuncionalidadeId) Begin'
      + sLineBreak +
      '     Insert into PerfilFuncionalidades Values (@PerfilId, @FuncionalidadeId, 1)'
      + sLineBreak + '  End' + sLineBreak + '  Else Begin' + sLineBreak +
      '     Update PerfilFuncionalidades Set Status = 1 where Perfilid = @PerfilId and FuncionalidadeId = @FuncionalidadeId'
      + sLineBreak + '  End' + sLineBreak + 'End';

  Const
    SqlSalvarAcessoFuncionalidade = 'Declare @UsuarioId Integer = :pUsuarioId' +
      sLineBreak + 'Declare @FuncionalidadeId Integer = :pFuncionalidadeId' +
      sLineBreak + 'Declare @Acesso    Integer = :pAcesso' + sLineBreak +
      'If @Acesso = 0 Begin' + sLineBreak +
      '   Delete from UsuarioFuncionalidades where Usuarioid = @UsuarioId and FuncionalidadeId = @FuncionalidadeId'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '  If Not Exists (Select UsuarioId From UsuarioFuncionalidades Where Usuarioid = @UsuarioId and FuncionalidadeId = @FuncionalidadeId) Begin'
      + sLineBreak +
      '     Insert into UsuarioFuncionalidades Values (@UsuarioId, @FuncionalidadeId, 1)'
      + sLineBreak + '  End' + sLineBreak + '  Else Begin' + sLineBreak +
      '     Update UsuarioFuncionalidades Set Status = 1 where Usuarioid = @UsuarioId and FuncionalidadeId = @FuncionalidadeId'
      + sLineBreak + '  End' + sLineBreak + 'End';

  Const
    SqlInsFabricante = 'Declare @CodERP   Integer     = :pCodERP' + sLineBreak +
      'Declare @Nome     VarChar(50) = :pNome' + sLineBreak +
      'Declare @Fone     VarChar(11) = :pFone' + sLineBreak +
      'Declare @Email    VarChar(100) = :pEmail' + sLineBreak +
      'Declare @HomePage VarChar(100) = :pHomePage' + sLineBreak +
      'If Not Exists (Select IdLaboratorio From Laboratorios Where CodErp = @CodERP) Begin'
      + sLineBreak +
      '   insert into  Laboratorios (CodERP, Nome, Fone, Email, HomePage, Status, uuii)'
      + sLineBreak + '        Values (@CodERP, @Nome, (Case When @Fone = ' + #39
      + #39 + ' then Null Else @Fone End), ' + sLineBreak +
      '               (Case When @Email = ' + #39 + #39 +
      ' Then Null Else @Email End), ' + sLineBreak +
      '               (Case When @Homepage = ' + #39 + #39 +
      ' then Null Else @HomePage End), 1, NewId())' + sLineBreak + 'End' +
      sLineBreak + 'Begin' + sLineBreak + '  Update Laboratorios' + sLineBreak +
      '    Set Nome = @Nome' + sLineBreak + '        , Fone = @Fone' +
      sLineBreak + '        , Email = @Email' + sLineBreak +
      '        , HomePage = @HomePage' + sLineBreak + '  Where CodERP = @CodERP'
      + sLineBreak + 'End';

  Const
    SqlInsUnidades = 'Declare @Sigla     Varchar(10) = :pSigla' + sLineBreak +
      'Declare @Descricao VarChar(30) = :pDescricao' + sLineBreak +
      'If Not Exists (Select Id From Unidades Where Sigla = @Sigla) Begin' +
      sLineBreak + '   Insert Into Unidades Values (@Sigla, @Descricao, 1)' +
      sLineBreak + 'End;';

  Const
    SqlInsProduto = 'Declare @CodProduto Integer              = :pCodProduto' +
      sLineBreak + 'Declare @Descricao VarChar(80)           = :pDescricao' +
      sLineBreak +
      'Declare @SiglaUnidPrimaria VarChar(10)   = :pSiglaUnidPrimaria' +
      sLineBreak +
      'Declare @QtdUnidPrimaria Integer         = :pQtdUnidPrimaria' +
      sLineBreak +
      'Declare @SiglaUnidSecundaria VarChar(10) = :pSiglaUnidSecundaria' +
      sLineBreak + 'Declare @QtdUnidSecundaria Integer       = :pFatorConversao'
      + sLineBreak +
      'Declare @LaboratorioId Integer           = :pLaboratorioId' + sLineBreak
      + 'Declare @Peso Integer                    = :pPeso' + sLineBreak +
      'Declare @Liquido Integer                 = :pLiquido' + sLineBreak +
      'Declare @Perigoso Integer                = :pPerigoso' + sLineBreak +
      'Declare @Inflamavel Integer              = :pInflamavel' + sLineBreak +
      'Declare @Altura Integer                  = :pAltura' + sLineBreak +
      'Declare @Largura Integer                 = :pLargura' + sLineBreak +
      'Declare @Comprimento Integer             = :pComprimento' + sLineBreak +
      'Declare @Ean VarChar(20)                 = :PEan' + sLineBreak +
      'If Not Exists (Select CodProduto From Produto Where CodProduto = @CodProduto) Begin'
      + sLineBreak +
      ' 		insert into Produto (CodProduto, Descricao, DescrReduzida, RastroId, ProdutoTipoId, UnidadeId, QtdUnid, UnidadeSecundariaId, '
      + sLineBreak +
      '          FatorConversao, LaboratorioId, PesoLiquido, Liquido, Perigoso, Inflamavel, Altura, '
      + sLineBreak +
      '          Largura, Comprimento, MesEntradaMinima, MesSaidaMinima, Status, uuid)'
      + sLineBreak +
      '        Values (@CodProduto, @Descricao, SubString(@Descricao, 1, 40), 3, 1, (Select Id From Unidades where Sigla = @SiglaUnidPrimaria), '
      + sLineBreak +
      '                @QtdUnidPrimaria, (Select Id From Unidades where Sigla = @SiglaUnidSecundaria), '
      + sLineBreak +
      '                @QtdUnidSecundaria, (Case When @LaboratorioId = 0 Then Null Else (Select IdLaboratorio From Laboratorios Where CodERP = @LaboratorioId) End),'
      + sLineBreak +
      '                @Peso, @Liquido, @Perigoso, @Inflamavel, @Altura, @Largura, @Comprimento,'
      + sLineBreak +
      '                (Select ShelflifeRecebimento From Configuracao), (Select ShelflifeExpedicao From Configuracao), 1, NewId())'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '   Update Produto Set ' + sLineBreak + '     Descricao = @Descricao' +
      sLineBreak + '   Where CodProduto = @CodProduto' + sLineBreak + 'End;';

Const SqlInsProdutoCodBarras =
      'Declare @ProdutoId Integer = (Select IdProduto From Produto Where CodProduto = :pCodProdutoERP)'+ sLineBreak +
      'Declare @CodBarras Varchar(25) = :pCodBarras' + sLineBreak+
      'If Not Exists (Select Produtoid From ProdutoCodBarras Where ProdutoId = @ProdutoId) Begin'+ sLineBreak +
      '   Insert Into ProdutoCodBarras  Values (@ProdutoId, @CodBarras, 1, ' + SqlDataAtual + ', ' + SqlHoraAtual + ', ' + sLineBreak +
      '																	 (Case When Exists (Select Principal From ProdutoCodBarras Where ProdutoId = @ProdutoId and Principal = 1) '+sLineBreak+
      '                           then 0 Else 1 End), 1)' + sLineBreak + 'End;';

Const SqlGetProduto = 'Declare @IdProduto Varchar(30) = :pProdutoid' + sLineBreak
      + 'Select Top 1 IdProduto ProdutoId, CodProduto, Descricao, ' + sLineBreak
      + '             (Select CodBarras From ProdutoCodBarras where ProdutoId = P.IdProduto and principal=1) As EanPrincipal'
      + sLineBreak +
      '             , Pc.CodBarras Ean, P.EnderecoDescricao Endereco' +
      sLineBreak + 'From vProduto P WITH (READUNCOMMITTED)' + sLineBreak +
      'Left Join ProdutoCodBarras PC  WITH (READUNCOMMITTED) On PC.ProdutoId = P.IdProduto'
      + sLineBreak +
      'where (P.CodProduto = Cast(@IdProduto as BigInt)) or (PC.CodBarras = @IdProduto) --Cast(@IdProduto as Varchar(20)))';

  Const
    SqlProdutoEan = 'Declare @ProdutoId Integer = :pProdutoId' + sLineBreak +
      'Declare @Status Integer = :pStatus' + sLineBreak +
      'Select * from ProdutoCodBarras WITH (READUNCOMMITTED)' + sLineBreak +
      'Where ProdutoId = @ProdutoId and (@Status = -1 or Status = @Status)' +
      sLineBreak + 'Order by Principal Desc';

  Const
    SqlZonaPicking = 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @PickingFixo Integer = :pPickingFixo' + sLineBreak +
      'Declare @Disponivel Integer = :pDisponivel' + sLineBreak +
      'select Zo.ZonaId, Zo.Descricao, COUNT(E.EnderecoId) EndDisponivel' +
      sLineBreak + 'from EnderecamentoZonas Zo' + sLineBreak +
      'Inner join Enderecamentos E On E.ZonaID = Zo.ZonaId' + sLineBreak +
      'Inner join EnderecamentoEstruturas Est ON Est.EstruturaId = Zo.EstruturaID' + sLineBreak +
      'Where ((@ZonaId=0) or (Zo.ZonaId=@ZonaId)) and ((@PickingFixo=0) or (Est.PickingFixo = @PickingFixo)) ' + sLineBreak +
      '      and ((@Disponivel=0) or (@Disponivel=1 and Not Exists (Select EnderecoId From PRoduto where EnderecoId = E.EnderecoId) ))' + sLineBreak +
      'Group by Zo.ZonaId, Zo.Descricao' + sLineBreak +
      'Order by Zo.Descricao';

  Const SqlReUsoPicking = 'Declare @PeriodoMovimento Integer = :pDias' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'select vEnd.EnderecoId, Endereco, vEnd.CodProduto, ' + sLineBreak +
      '       vEnd.Descricao Produto, Mascara, Zona, Status, Coalesce(Est.Saldo, 0) Saldo' + sLineBreak +
      'From vEnderecamentos vEnd' + sLineBreak +
      'Left Join (Select CodigoERP ' + sLineBreak +
      '           From vPedidoItemProdutos ' + sLineBreak +
      '		         Where Data > GetDate()-@PeriodoMovimento and ProcessoId <> 31) Ent On Ent.CodigoERP = vEnd.CodProduto' + sLineBreak +
      'Left Join (Select Pl.CodProduto --, Sum(QtdSuprida) QtdSuprida' + sLineBreak +
      '           From PedidoVolumeLotes Vl' + sLineBreak +
      '		         Inner join PedidoVolumes Pv on Pv.PedidoVolumeId = Vl.PedidoVolumeid' + sLineBreak +
      '		         Inner join vPedidos Ped On Ped.PedidoId = Pv.Pedidoid' + sLineBreak +
      '		         Inner join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' + sLineBreak +
      '		         Where Ped.DocumentoData > GetDate()-@PeriodoMovimento) Sai On Sai.CodProduto = vEnd.CodProduto' + sLineBreak +
      'Left Join (select CodigoERP, Sum(QtdeProducao) Saldo' + sLineBreak +
      '           From vEstoque' + sLineBreak +
      '		   where Producao=1' + sLineBreak +
      '		   Group by CodigoERP) Est On Est.CodigoERP = vEnd.CodProduto' + sLineBreak +
      'Left Join (select CodProduto, Sum(Qtde) Reserva' + sLineBreak +
      '           From Estoque Est' + sLineBreak +
      '		         Inner join vProdutoLotes Pl ON Pl.LoteId = Est.LoteId' + sLineBreak+
      '		         where EstoqueTipoId = 6' + sLineBreak +
      '		         Group by CodProduto) EstReserva On EstReserva.CodProduto = vEnd.CodProduto' + sLineBreak +
      'Left join (Select Pl.CodProduto, Sum(Coalesce(Qtde, 0)) Qtde'+sLineBreak+
      '           From ReposicaoEstoqueTransferencia RET'+sLineBreak+
      '           inner join vProdutoLotes Pl On Pl.Loteid = RET.LoteId'+sLineBreak+
      '           Where Coalesce(Qtde, 0) > 0'+sLineBreak+
      '           Group by Pl.CodProduto) RET On RET.CodProduto = vEnd.CodProduto'+sLineBreak+
      'where vEnd.EstruturaId = 2 and (@ZonaId = 0 or vEnd.ZonaId = @ZonaId)'+sLineBreak +
      '  and vEnd.CodProduto Is Not Null' +
      '  and Ent.CodigoERP Is Null and Sai.CodProduto Is Null' + sLineBreak +
      '  and vEnd.Enderecoid Is Not Null' + sLineBreak +
      '  And Coalesce(Est.Saldo, 0) = 0 and Coalesce(EstReserva.Reserva, 0) = 0 and Coalesce(Ret.Qtde, 0) = 0';

  Const
    SqlEnderecarProduto = 'Declare @EnderecoId Integer = :pEnderecoId' +
      sLineBreak + 'Update Produto Set' + sLineBreak +
      '    EnderecoId = (Case When @EnderecoId = 0 Then Null Else @EnderecoId End)'
      + sLineBreak + 'Where IdProduto = :pProdutoId';

  Const
    SqlSalvarProdutoColetor = 'Update Produto Set ' + sLineBreak +
      '  CodProduto	   = :pCodProduto ' + sLineBreak +
      '  --, Descricao		   = :pDescricao ' + sLineBreak +
      '  --, DescricaoRed	 = :DescricaoRed ' + sLineBreak +
      '  , QtdUnid		   = :pQtdUnid ' + sLineBreak +
      '  , FatorConversao   = :pFatorConversao ' + sLineBreak +
      '  --, SomenteCxaFechada = :pSomenteCxaFechada' + sLineBreak +
      '  , EnderecoId	   = (Select EnderecoId From Enderecamentos where Descricao = :pEndereco) '
      + sLineBreak + '  , rastroid		   = :pRastroId ' + sLineBreak +
      '  , pesoliquido  = :pPeso ' + sLineBreak + '  , altura		   = :pAltura '
      + sLineBreak + '  , largura		   = :pLargura ' + sLineBreak +
      '  , comprimento	   = :pComprimento ' + sLineBreak +
      '  , MesEntradaMinima = :pmesentradaminima ' + sLineBreak +
      '  , MesSaidaMinima   = :pMesSaidaMinima ' + sLineBreak +
      'Where IdProduto = :pIdProduto';

Const SqlPedido = //'SET STATISTICS IO OFF' + sLineBreak +
      //'SET STATISTICS TIME OFF'+ sLineBreak +
      //'SET NOCOUNT ON' + sLineBreak +
      //'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED' + sLineBreak +
      'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'Declare @ProdutoId integer = (select IdProduto From Produto Where CodProduto = @CodigoERP)'+sLineBreak+
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @RotaIdFinal Integer = :pRotaIdFinal' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @OperacaoTipoId Integer = :pOperacaoTipoId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @MontarCarga Integer = :pMontarCarga' + sLineBreak +
      'Declare @CodProduto integer = :pCodProduto' + sLineBreak +
      'Declare @PedidoPendente Integer = :pPedidoPendente' + sLineBreak +
      'Declare @CargaId Integer = :pCargaId' + sLineBreak +
      'Declare @NotaFiscalERP Varchar(50) = :pNotaFiscalERP' + sLineBreak +
      'Select Ped.PedidoId,	Ped.OperacaoTipoId,	Ped.OperacaoTipo,	Ped.Operacao,	Ped.Pessoaid,	Ped.CodPessoaERP,	Ped.Razao,	Ped.Fantasia,	Ped.DocumentoOriginal,	'+sLineBreak+
      '       Ped.DocumentoNr, Ped.DocumentoData,	Ped.RegistroERP,	Ped.DtInclusao, Ped.HrInclusao,	Ped.RotaId,	Ped.Rota,	Ped.ArmazemId,	Ped.Status,	'+sLineBreak+
      '       Ped.uuid,	PNF.NotaFiscal as NotaFiscalERP, Ped.ProcessoId, Ped.processo, Ped.Processo Etapa, Ped.DtProcesso,' + sLineBreak +
      '       Pp.Itens, PP.Demanda, Coalesce(Vl.QtdSuprida, 0) QtdSuprida,' + sLineBreak +
      '       Coalesce(Etapa.TCxaFechada, 0) as TVolCxaFechada, Coalesce(Etapa.TCxaFracionada, 0) TVolFracionado,' + sLineBreak +
      '       Coalesce(Etapa.TCxaFechada, 0)+Coalesce(Etapa.TCxaFracionada, 0)+Coalesce(Etapa.Cancelado, 0) as TVolumes,'+sLineBreak+
      '       (Case When PPick.QtdeProducao > 0 then 0 Else 1 End) Picking,'+sLineBreak+
      '       Coalesce(Etapa.Cancelado, 0) as Cancelado' + sLineBreak +
      '     , Coalesce(VL.Peso, 0) Peso, Coalesce(VL.VolCm3, 0) VolCm3, Coalesce(VL.Volm3, 0) Volm3, Coalesce(VL.Processado, 0) Processado, Coalesce(VL.Concluido, 0) Concluido' + sLineBreak +
      '     ,  Coalesce(Cp.CargaId, 0) CargaId, Coalesce(Cp.CarregamentoId, 0) Carregamentoid, Coalesce(Cp.ProcessoId, 0) ProcessoIdCarga, Cp.Processo ProcessoCarga' + sLineBreak +
      'Into #Pedidos'+sLineBreak+
      'From (select Ped.PedidoId, Ped.OperacaoTipoId, Ped.OperacaoNome as OperacaoTipo, Ped.OperacaoNome Operacao, Ped.Pessoaid, Ped.CodPessoaERP,' + sLineBreak +
      '      Ped.Razao, Ped.Fantasia, ped.DocumentoOriginal, Ped.DocumentoNr, FORMAT(Ped.DocumentoData, '+#39+'dd/MM/yyyy'+#39+') as DocumentoData,' + sLineBreak +
      '	     Ped.RegistroERP' + sLineBreak +
      '    , FORMAT(ped.DtProcesso, '+#39+'dd/MM/yyyy'+#39+') DtProcesso, FORMAT(ped.DocumentoData, '+#39+'dd/MM/yyyy'+#39+') as DtInclusao, Null as HrInclusao' + sLineBreak +
      '    , Coalesce(Ped.Rotaid, 0) RotaId, Ped.Rota, 1 as ArmazemId, Ped.Status, Ped.uuid, Ped.ProcessoId, Ped.processo' + sLineBreak +
      'From dbo.vpedidos Ped' + sLineBreak +
      'Where (@DataIni=0 or Ped.DocumentoData >= @DataIni) and (@DataFin=0 or Ped.DocumentoData <= @DataFin) And' + sLineBreak +
      '      (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId) and' + sLineBreak +
      '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' + sLineBreak +
      '	     (@CodigoERP=0 or @CodigoERP = Ped.CodPessoaERP) and' + sLineBreak +
      '      (@PessoaId = 0 or Ped.PessoaId = @PessoaId) and' + sLineBreak +
      '	  (@DocumentoNr = '+#39+#39+' or @DocumentoNr=Ped.DocumentoNr) and' + sLineBreak +
      '	  (@Razao = '+#39+#39+' or Ped.Razao Like @Razao) and' + sLineBreak +
      '      (@Razao = '+#39+#39+' or Ped.Fantasia Like @Razao) and' + sLineBreak +
      '	  (@RegistroERP = '+#39+#39+' or Ped.RegistroERP = @RegistroERP) and' + sLineBreak +
      '      (@NotaFiscalERP = '+#39+#39+' or Ped.NotaFiscalERP = @NotaFiscalERP) and' + sLineBreak +
      '      (@RotaId = 0 or Ped.RotaId >= @RotaId) and (@RotaIdFinal = 0 or Ped.RotaId <= @RotaIdFinal) and' + sLineBreak +
      '      (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId) and' + sLineBreak +
      '	  Ped.ProcessoId <> 31 and' + sLineBreak +
      '	  (@PedidoPendente=0 or Ped.ProcessoId<13) and' + sLineBreak +
      '      (@ProcessoId = 0  or Ped.ProcessoId = @ProcessoId or (@ProcessoId=13 and Ped.ProcessoId>13 and Ped.processoId <> 15 ))) Ped' + sLineBreak +
      'Left Join (select pp.PedidoId, Coalesce(SUM(QtdeProducao), 0) QtdeProducao'+sLineBreak+
      'From PedidoProdutos pp'+sLineBreak+
      'Inner join Produto Prd on Prd.IdProduto = pp.Produtoid'+sLineBreak+
      'Left Join vEstoqueProducao est on est.Produtoid = pp.Produtoid'+sLineBreak+
      'where Prd.EnderecoId Is null'+sLineBreak+
      'Group by Pp.PedidoId) PPick On PPick.PedidoId = Ped.PedidoId'+sLineBreak+
      'Left Join (Select C.CargaId, Cp.PedidoId, De.Processoid, De.Descricao Processo, 0 CarregamentoId' + sLineBreak +
      '           From dbo.Cargas C' + sLineBreak +
      '		   Inner Join dbo.CargaPedidos Cp On Cp.CargaId = C.CargaId' + sLineBreak +
      '		   Left Join dbo.vDocumentoEtapas DE On De.Documento = C.Uuid' + sLineBreak +
      '		   Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = C.Uuid and Status = 1)' + sLineBreak +
      '             And (@CargaId = 0 or @CargaId = Cp.CargaId) And De.ProcessoId <> 21) Cp ON Cp.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join (Select Pv.PedidoId, Sum((Case When EmbalagemId Is Null and Etapa.ProcessoId not in (15,31) then 1 Else 0 End)) TCxaFechada,' + sLineBreak +
      '                               Sum((Case When EmbalagemId Is not Null and Etapa.ProcessoId not in (15,31)then 1 Else 0 End)) TCxaFracionada,' + sLineBreak +
      '				               Sum((Case When Etapa.ProcessoId = 15 then 1 Else 0 End)) Cancelado' + sLineBreak +
      '			        From dbo.Pedido Ped' + sLineBreak +
      '			        Left Join dbo.PedidoVolumes PV On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      '			        Left Join dbo.vDocumentoEtapas Etapa On Etapa.Documento = Pv.uuid and Etapa.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)' + sLineBreak +
      '			        Group by Pv.PedidoId) Etapa On Etapa.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join (Select Vp.PedidoId, Sum(Vl.Quantidade) as Demanda, Sum(Vl.QtdSuprida) as QtdSuprida,' + sLineBreak +
      '           Cast(Sum(vl.QtdSuprida*Prd.PesoLiquido)/1000 as decimal(15,3)) as Peso,' + sLineBreak +
      '           Sum(cast(Cast(vl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,3)) as Decimal(15,3))) VolCm3,' + sLineBreak +
      '           Sum(cast(Cast(vl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,6))/1000000 as Decimal(15,6))) Volm3,' + sLineBreak +
      '           Sum((Case When De.ProcessoId < 13 then vl.QtdSuprida Else 0 End)) Processado,' + sLineBreak +
      '      	   Sum((Case When De.ProcessoId >= 13 and De.ProcessoId Not in (15, 31) then vl.QtdSuprida Else 0 End)) Concluido' + sLineBreak +
      '		   From dbo.PedidoVolumes VP' + sLineBreak +
      '           Inner Join dbo.PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Vp.PedidoVolumeId' + sLineBreak +
      '		   Inner Join dbo.ProdutoLotes Pl On Pl.LoteId = Vl.Loteid' + sLineBreak +
      '		   Inner Join vDocumentoEtapas De On De.Documento = Vp.Uuid' + sLineBreak +
      '           Inner Join dbo.Produto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      '	       Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vp.uuid and Status = 1)' + sLineBreak +
      '             And De.ProcessoId <> 15' + sLineBreak +
      '		   Group by Vp.PedidoId) as VL On Vl.PedidoId = Ped.PedidoId' + sLineBreak +
      '' + sLineBreak +
      'inner Join (Select Vp.PedidoId, Count(Produtoid) as Itens, Sum(Vp.Quantidade) as Demanda' + sLineBreak +
      '           From dbo.PedidoProdutos VP' + sLineBreak +
      '		   where @CodProduto=0 or Vp.ProdutoId = @ProdutoId' + sLineBreak +
      '		   Group by Vp.PedidoId) as PP On Pp.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join vPedidoNotaFiscalPrincipal PNF On PNF.PedidoID = Ped.PedidoId' + sLineBreak +
      'Where ((@MontarCarga=0 and (Cp.CargaId Is Null or Cp.cargaid = @CargaId)) or (@MontarCarga=1 and Cp.CargaId Is Not Null) or @MontarCarga=2)' + sLineBreak +
      '  and (@CodProduto = 0 or Pp.Itens > 0)' + sLineBreak +
      'select * From  #Pedidos Ped'+sLineBreak+
      'Order by Ped.DocumentoData, Ped.PedidoId';

Const PedidoAllResto =      '' + sLineBreak +
      'Select Ped.*, PNF.NotaFiscal NotaFiscalERP, De.ProcessoId, De.Descricao Etapa, De.Data DtProcesso,' + sLineBreak +
      '       Pp.Itens, PP.Demanda, Vl.QtdSuprida,' + sLineBreak +
      '       Coalesce(Etapa.TCxaFechada, 0) as tvolCxaFechada, Coalesce(Etapa.TCxaFracionada, 0) TVolFracionado,' + sLineBreak +
      '(Case When Exists (Select Prd.EnderecoId From PedidoProdutos PP' + sLineBreak +
      '                   Inner join Produto Prd On Prd.IdProduto = PP.Produtoid' + sLineBreak +
      '                   Left Join vEstoque Est ON Est.CodigoERP = Prd.CodProduto' + sLineBreak +
      '				               Where PP.PedidoId = Ped.PedidoId and Prd.EnderecoId Is Null and Est.CodigoERP is Not Null) then 0 Else 1' + sLineBreak +
      ' End) As Picking, Coalesce(Etapa.Cancelado, 0) as Cancelado' + sLineBreak +
      '   , PCub.Peso, PCub.VolCm3, PCub.Volm3, pCub.Processado, pCub.Concluido' + sLineBreak +
      'From (select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, Op.Descricao Operacao, P.Pessoaid, P.CodPessoaERP, P.Razao, ' + sLineBreak +
      '      P.Fantasia, ped.DocumentoOriginal, Ped.DocumentoNr, FORMAT(Rd.Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') as DocumentoData, Ped.RegistroERP, ' + sLineBreak +
      '      Cp.CargaId, Cp.CarregamentoId, Cp.ProcessoId ProcessoIdCarga, Cp.Processo ProcessoCarga' + sLineBreak +
      '    , FORMAT(RE.Data, ' + #39 + 'dd/MM/yyyy' + #39 +') as DtInclusao, cast( Rh.Hora as Time) as HrInclusao ' + sLineBreak +
      '    , Rp.Rotaid, Ro.Descricao Rota, ArmazemId, Ped.Status, Cast(Ped.uuid as Varchar(36)) as uuid ' + sLineBreak +
      'From dbo.pedido Ped ' + sLineBreak +
      'Inner Join dbo.OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId ' + sLineBreak +
      'Inner Join dbo.Pessoa P ON p.PessoaId     = Ped.PessoaId ' + sLineBreak +
      'Left Join dbo.RotaPessoas RP On Rp.PessoaId = P.Pessoaid' + sLineBreak +
      'Left Join dbo.Rotas Ro On Ro.RotaId = Rp.RotaId' + sLineBreak +
      'Left Join dbo.Rhema_Data RD On Rd.IdData = Ped.DocumentoData ' + sLineBreak + 'Left Join dbo.Rhema_Data RE On Re.IdData = Ped.DtInclusao ' + sLineBreak +
      'Left Join dbo.Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao ' + sLineBreak +
      'Left Join (Select C.CargaId, Cp.PedidoId, De.Processoid, De.Descricao Processo, Min(CarregamentoId) CarregamentoId' + sLineBreak + '           From dbo.Cargas C' + sLineBreak +
      '		         Inner Join dbo.CargaPedidos Cp On Cp.CargaId = C.CargaId' + sLineBreak +
      '		         Left Join dbo.vDocumentoEtapas DE On De.Documento = C.Uuid' + sLineBreak +
      '		         Left Join dbo.CargaCarregamento CC ON Cc.CargaId = C.CargaId' + sLineBreak +
      '		         Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = C.Uuid and Status = 1)' + sLineBreak + '             And (@CargaId = 0 or @CargaId = Cp.CargaId) And De.ProcessoId <> 21' + sLineBreak +
      '           Group by C.CargaId, Cp.PedidoId, De.Processoid, De.Descricao) Cp ON Cp.PedidoId = Ped.PedidoId' + sLineBreak +
      'Where (@DataIni=0 or Rd.Data >= @DataIni) and (@DataFin=0 or Rd.Data <= @DataFin) And (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId) and' + sLineBreak +
      '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and (@CodigoERP=0 or @CodigoERP = P.CodPessoaERP) and ' + sLineBreak +
      '      (@PessoaId = 0 or P.PessoaId = @PessoaId) and (@DocumentoNr = ' + #39 + #39 + ' or @DocumentoNr=Ped.DocumentoNr) and' + sLineBreak +
      '				  (@Razao = ' + #39 + #39 + ' or P.Razao Like @Razao) and' + sLineBreak +
      '      (@Razao = ' + #39 + #39 + ' or P.Fantasia Like @Razao) and' + sLineBreak +
      '				  (@RegistroERP = ' + #39 + #39 + ' or Ped.RegistroERP = @RegistroERP) and' + sLineBreak +
      '      (@NotaFiscalERP = ' + #39 + #39 + ' or Ped.NotaFiscalERP = @NotaFiscalERP) and' + sLineBreak +
      '      (@RotaId = 0 or RP.RotaId >= @RotaId) and(@RotaIdFinal = 0 or RP.RotaId <= @RotaIdFinal) and' + sLineBreak +
      '      (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId)) Ped' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Left Join (Select Pv.PedidoId, Sum((Case When EmbalagemId Is Null then 1 Else 0 End)) TCxaFechada,' + sLineBreak +
      '                               Sum((Case When EmbalagemId Is not Null then 1 Else 0 End)) TCxaFracionada,' + sLineBreak +
      '				                           Sum((Case When Etapa.ProcessoId = 15 then 1 Else 0 End)) Cancelado' + sLineBreak +
      '			        From dbo.Pedido Ped' + sLineBreak +
      '			        Left Join dbo.PedidoVolumes PV On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      '			        Left Join dbo.vDocumentoEtapas Etapa On Etapa.Documento = Pv.uuid and Etapa.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)' + sLineBreak +
      '			        Group by Pv.PedidoId) Etapa On Etapa.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join (Select Vp.PedidoId, Count(Produtoid) as Itens, Sum(Vp.Quantidade) as Demanda' + sLineBreak +
      '           From dbo.PedidoProdutos VP' + sLineBreak +
      '		         Group by Vp.PedidoId) as PP On Pp.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join (Select Vp.PedidoId, Sum(Vl.Quantidade) as Demanda, Sum(Vl.QtdSuprida) as QtdSuprida' + sLineBreak +
      '           From dbo.PedidoVolumes VP' + sLineBreak +
      '           Inner Join dbo.PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Vp.PedidoVolumeId' + sLineBreak +
      '		         Inner Join dbo.ProdutoLotes Pl On Pl.LoteId = Vl.Loteid' + sLineBreak +
      '		         Inner Join vDocumentoEtapas De On De.Documento = Vp.Uuid' + sLineBreak +
      '	          Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vp.uuid and Status = 1)' + sLineBreak +
      '           And De.ProcessoId <> 15' + sLineBreak +
      '		         Group by Vp.PedidoId) as VL On Vl.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join (select Pv.PedidoId, Cast(Sum(Pvl.QtdSuprida*Prd.PesoLiquido)/1000 as decimal(15,3)) as Peso, ' + sLineBreak +
      '           Sum(cast(Cast(Pvl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,3)) as Decimal(15,3))) VolCm3,' + sLineBreak +
      '           Sum(cast(Cast(Pvl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,6))/1000000 as Decimal(15,6))) Volm3,' + sLineBreak +
      '           Sum((Case When De.ProcessoId < 13 then Pvl.QtdSuprida Else 0 End)) Processado,' + sLineBreak +
      '      		   Sum((Case When De.ProcessoId = 13 then Pvl.QtdSuprida Else 0 End)) Concluido' + sLineBreak +
      '           From dbo.PedidoVolumes PV' + sLineBreak +
      '           Inner Join dbo.PedidoVolumeLotes PVL ON PVL.PedidoVolumeId = Pv.PedidoVolumeId' + sLineBreak +
      '           Inner Join dbo.ProdutoLotes PL On Pl.LoteId = PVL.LoteId' + sLineBreak +
      '           Inner Join dbo.Produto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      '		         Inner join dbo.vDocumentoEtapas De ON De.Documento = Pv.Uuid' + sLineBreak +
      '           where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)' + sLineBreak +
      '           Group by PV.PedidoId' + sLineBreak +
      '           ) as PCub ON PCub.PedidoId = Ped.PedidoId' + sLineBreak +
      '--Left Join vPedidoNotaFiscalPrincipal PNF On PNF.PedidoId = Ped.PedidoId' + sLineBreak +
      'Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2 And De.ProcessoId <> 31' + sLineBreak +
    // Documentos Exclu�dos
      '  and (@ProcessoId = 0  or De.ProcessoId = @ProcessoId or (@ProcessoId=13 and De.ProcessoId>13 and De.processoId<>15))'+ sLineBreak +
      '  and ((@MontarCarga=0 and (Ped.CargaId Is Null or Ped.cargaid = @CargaId)) or (@MontarCarga=1 and Ped.CargaId Is Not Null) or @MontarCarga=2)' + sLineBreak + // 0 Sem Carga 1 Com Carga 2 Todos
      '  and (@CodProduto = 0 or Exists (select ProdutoId from PedidoProdutos PP' + sLineBreak +
      '                                  Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId' + sLineBreak +
      '                                  where Pp.PedidoId = Ped.PedidoId and Prd.CodProduto = @CodProduto))' + sLineBreak +
      '  and (@PedidoPendente=0 or De.ProcessoId<13)' + sLineBreak + 'Order by Ped.DocumentoData, Ped.PedidoId';

 Const
    SqlPedidoParaProcessamento = 'Declare @PedidoId Integer    = :pPedidoId' +
      sLineBreak + 'Declare @DataIni DateTime    = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime    = :pDataFin' + sLineBreak +
      'Declare @CodigoERP Integer   = :pCodigoERP' + sLineBreak +
      'Declare @ProcessoId Integer  = :pProcessoId' + sLineBreak +
      'Declare @RotaId Integer      = :pRotaId' + sLineBreak +
      'Declare @RotaIdFinal Integer = :pRotaIdFinal' + sLineBreak +
      'Declare @ZonaId Integer      = :pZonaId' + sLineBreak +
      'Declare @Recebido Integer    = :pRecebido' + sLineBreak +
      'Declare @Cubagem Integer     = :pCubagem' + sLineBreak +
      'Declare @Etiqueta Integer    = :pEtiqueta'+sLineBreak +
      'select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid, '+sLineBreak+
      '       P.CodPessoaERP, P.Razao, P.Fantasia, Rp.Rotaid, Ped.Rota, Ped.DocumentoNr, '+sLineBreak+
      '       FORMAT(Ped.DocumentoData, '+#39+'dd/MM/yyyy'+#39+') as DocumentoData,'+sLineBreak+
      '       1 as ArmazemId, Coalesce(Ped.Status, 0) as Status, Ped.uuid, Ped.RegistroERP, Ped.ProcessoId,'+sLineBreak+
      '	   Ped.ProcessoEtapa as ProcessoEtapa, Vs.StatusMin, Vs.StatusMax, Iv.QtdProdutos, Iv.Peso, Iv.Volume into #Pedidos'+sLineBreak+
      'From vpedidos Ped'+sLineBreak+
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId'+sLineBreak+
      'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId'+sLineBreak+
      'Left join RotaPessoas RP ON RP.PessoaId = P.PessoaId'+sLineBreak+
      'Left Join (Select Pv.PedidoId, Coalesce(Min(De.ProcessoId), 0) StatusMin, Coalesce(Max(De.ProcessoId), 0) StatusMax'+sLineBreak+
      '                   From PedidoVolumes Pv'+sLineBreak+
      '				   Inner Join vDocumentoEtapas DE On De.Documento = Pv.Uuid'+sLineBreak+
      '				   Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'+sLineBreak+
      '				   Group by Pv.PedidoId) Vs On Vs.PedidoId = Ped.PedidoId'+sLineBreak+
      'Left Join (Select PP.PedidoId, Coalesce(Count(PP.ProdutoId), 0) QtdProdutos,'+sLineBreak+
      '                  Coalesce(Sum(Prd.PesoLiquido * (PP.Quantidade)), 0) as Peso,'+sLineBreak+
      '           Coalesce(Cast(Sum((Prd.Altura*Prd.Largura*Prd.Comprimento) * (PP.Quantidade)) / 1000000 as decimal(15,6)), 0) as Volume'+sLineBreak+
      '           From PedidoProdutos PP'+sLineBreak+
      '		   Inner Join Produto Prd On Prd.IdProduto = PP.ProdutoId'+sLineBreak+
      '		   Group by PP.PedidoId) Iv On Iv.PedidoId = Ped.PedidoId'+sLineBreak+
      'Where (@DataIni=0   or Ped.DocumentoData >= @DataIni) and (@DataFin=0 or Ped.DocumentoData <= @DataFin) And Ped.OperacaoTipoId = 2 and'+sLineBreak+
      '      (@PedidoId=0  or @PedidoId = Ped.PedidoId) and'+sLineBreak+
      '      (@CodigoERP=0 or @CodigoERP = P.CodPessoaERP) and'+sLineBreak+
      '      (@RotaId = 0  or RP.RotaId >= @RotaId) And'+sLineBreak+
      '      (@RotaIdFinal = 0 or RP.RotaId <= @RotaIdFinal) And'+sLineBreak+
      '	     (@ZonaId = 0 or (Exists (Select ZonaId From PedidoProdutos PP'+sLineBreak+
      '	                              Inner Join vProduto Prd on Prd.IdProduto = PP.Produtoid'+sLineBreak+
      '							                  Where ZonaID = @ZonaId and PP.PedidoId = Ped.Pedidoid )))'+sLineBreak+
      ''+sLineBreak+
      'Select Distinct P.*,'+sLineBreak+
      '(Case'+sLineBreak+
      '   When Exists (Select Prd.EnderecoId'+sLineBreak+
      '                From PedidoProdutos PP'+sLineBreak+
      '                Inner join Produto Prd On Prd.IdProduto = PP.Produtoid'+sLineBreak+
      '                left Join vEstoque Est On Est.CodigoERP = Prd.CodProduto'+sLineBreak+
      '				Where PP.PedidoId = P.PedidoId and Prd.EnderecoId Is Null and Est.CodigoERP is Not Null) then'+sLineBreak+
      '     0'+sLineBreak+
      '   Else 1'+sLineBreak+
      ' End) As Picking'+sLineBreak+
      'From #Pedidos P'+sLineBreak+
      'Where  ( (@ProcessoId = 0 or @ProcessoId = P.ProcessoId) or (@PedidoId<>0 and P.ProcessoId<>15)) and'+sLineBreak+
      '         ((@Recebido=0 and @Cubagem=0 and @Etiqueta=0) OR (@Recebido = 1 AND P.ProcessoId=1) OR'+sLineBreak+
      '		        (@Cubagem=1 and P.ProcessoId in (2,21)) OR'+sLineBreak+
      '		        (@Etiqueta=1 and P.ProcessoId = 3) )';

  Const
    SqlPedidoPrintTag = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @RotaIdFinal Integer = :pRotaIdFinal' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @PrintTag Integer  = :pPrintTag  -- 0 N�o impresso   1 Reimpresso   2 Todos'+sLineBreak +
      'Declare @Embalagem Integer = :pEmbalagem -- 0 Cxa Fechada    1 Fracioandos  2 Todos'+sLineBreak +
      'select Ped.PedidoId, Ped.OperacaoTipoId, Ped.OperacaoNome as OperacaoTipo, Ped.Pessoaid, Ped.CodPessoaERP, Ped.Razao,'+sLineBreak +
      '       Ped.Fantasia, Ped.Rotaid, Ped.Rota, FORMAT(Ped.DocumentoData, '+#39+'dd/MM/yyyy'+#39+') as DocumentoData,'+sLineBreak +
      '       Ped.ProcessoEtapa ProcessoEtapa , Coalesce(Ped.Status, 0) as Status, Pv.QtdVolume' + sLineBreak +
      'From vpedidos Ped'+sLineBreak +
      'Inner Join (select Vlm.PedidoId, Count(*) QtdVolume'+sLineBreak +
      '            From PedidoVolumes Vlm' + sLineBreak +
      '            Inner join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' +sLineBreak +
      '			         Inner Join (select PedidoVolumeId, Count(*) VolZona' +sLineBreak +
      '			                    From PedidoVolumeLotes Vl' +sLineBreak +
      '					                  Inner join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' + sLineBreak +
      '					                  Where (@ZonaId=0 or Pl.ZonaId = @ZonaId)' +sLineBreak +
      '					                  Group by Vl.PedidoVolumeId) VZ On Vz.PedidoVolumeId = Vlm.PedidoVolumeId'+ sLineBreak +
      '                        Where (De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1))'+ sLineBreak +
      '              And (@PedidoId = 0 or Vlm.PedidoId = @PEdidoId)' +sLineBreak +
      '              And ((@PedidoVolumeId = Vlm.PedidoVolumeId) or ((@PedidoVolumeId = 0)' + sLineBreak +
      '			           And ((@PrintTag=2 and De.ProcessoId in (2,3)) or (@PrintTag=0 and De.ProcessoId=2) or'+ sLineBreak +
      '			                  (@PrintTag=1 and De.ProcessoId=3))' + sLineBreak +
      '              And (@Embalagem=2 or (@Embalagem=0 and Vlm.EmbalagemId Is null) or' + sLineBreak +
      '			                   (@Embalagem=1 and Vlm.EmbalagemId Is Not Null))))' + sLineBreak +
      'Group by Vlm.pedidoid) Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Where (@DataIni=0 or Ped.DocumentoData >= @DataIni) and (@DataFin=0 or Ped.DocumentoData <= @DataFin) And Ped.OperacaoTipoId = 2 and'+ sLineBreak +
      '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' + sLineBreak +
      '      (@CodigoERP=0 or @CodigoERP = Ped.CodPessoaERP) and' +sLineBreak +
      '      (@PessoaId = 0 or Ped.PessoaId = @PessoaId) and' + sLineBreak +
      '      (@RotaId = 0 or Ped.RotaId >= @RotaId) and (@RotaId = 0 or Ped.RotaId <= @RotaIdFinal)' + sLineBreak +
      '--Order by Ped.DocumentoData, Ped.PedidoId';

  Const
    SqlPedidoProcessar = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @RotaIdFinal Integer = :pRotaIdFinal' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @Recebido Integer = :pRecebido' + sLineBreak +
      'Declare @Cubagem Integer = :pCubagem' + sLineBreak +
      'Declare @Etiqueta Integer  = :pEtiqueta' + sLineBreak +
      'Declare @PrintTag Integer  = :pPrintTag  -- 0 N�o impresso   1 Reimpresso   2 Todos'
      + sLineBreak +
      'Declare @Embalagem Integer = :pEmbalagem -- 0 Cxa Fechada    1 Fracioandos  2 Todos'
      + sLineBreak + ';With ' + sLineBreak +
      'Pedidos As (select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid, P.CodPessoaERP, P.Razao,'
      + sLineBreak +
      '       P.Fantasia, Rp.Rotaid, R.Descricao Rota, Ped.DocumentoNr, FORMAT(Rd.Data, '
      + #39 + 'dd/MM/yyyy' + #39 + ') as DocumentoData' + sLineBreak +
      '       , FORMAT(RE.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
      ') as DtInclusao, Rh.Hora as HrInclusao' + sLineBreak +
      '       , ArmazemId, Coalesce(Ped.Status, 0) as Status, Ped.uuid, Ped.RegistroERP'
      + sLineBreak + 'From pedido Ped' + sLineBreak +
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId' +
      sLineBreak + 'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId' +
      sLineBreak + 'Left join RotaPessoas RP ON RP.PessoaId = P.PessoaId' +
      sLineBreak + 'Left Join Rotas R On R.RotaId = Rp.RotaId' + sLineBreak +
      'Left Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Left Join Rhema_Data RE On Re.IdData = Ped.DtInclusao' + sLineBreak +
      'Left Join Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao' + sLineBreak +
      'Where (@DataIni=0 or Rd.Data >= @DataIni) and (@DataFin=0 or Rd.Data <= @DataFin) And Ped.OperacaoTipoId = 2 and'
      + sLineBreak + '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' +
      sLineBreak + '      (@CodigoERP=0 or @CodigoERP = P.CodPessoaERP) and' +
      sLineBreak + '      (@PessoaId = 0 or P.PessoaId = @PessoaId) and' +
      sLineBreak + ' 			  (@DocumentoNr = ' + #39 + #39 +
      ' or @DocumentoNr=Ped.DocumentoNr) and' + sLineBreak +
      '				  (@Razao = ' + #39 + #39 + ' or P.Razao Like @Razao) and' +
      sLineBreak + '				  (@Razao = ' + #39 + #39 +
      ' or P.Fantasia Like @Razao) and' + sLineBreak +
      '				  (@RegistroERP = ' + #39 + #39 +
      ' or Ped.RegistroERP = @RegistroERP) and' + sLineBreak +
      '      (@RotaId = 0 or RP.RotaId >= @RotaId) and (@RotaId = 0 or RP.RotaId <= @RotaIdFinal) And'
      + sLineBreak +
      '      (@ZonaId = 0 or (Exists (Select ZonaId From PedidoProdutos PP' +
      sLineBreak +
      '                               Inner Join vProduto Prd on Prd.IdProduto = PP.Produtoid'
      + sLineBreak +
      '                               Where ZonaID = @ZonaId and PP.PedidoId = Ped.Pedidoid ))))'
      + sLineBreak + '    ' + sLineBreak + ', Etapas as (select DE.*' +
      sLineBreak + '		From vDocumentoEtapas DE' + sLineBreak +
      '		Inner Join Pedidos P ON P.uuid = DE.Documento' + sLineBreak +
      '		Where DE.Documento = P.Uuid and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = P.uuid and Status = 1) )'
      + sLineBreak + '   ' + sLineBreak +
      ', ItensVolume as (Select PP.PedidoId, Count(PP.ProdutoId) QtdProdutos, Sum(Prd.PesoLiquido * (PP.Quantidade)) as Peso,'
      + sLineBreak +
      '                  Cast(Sum((Prd.Altura*Prd.Largura*Prd.Comprimento) * (PP.Quantidade)) / 1000000 as decimal(15,6)) as Volume'
      + sLineBreak + '                  From PedidoProdutos PP' + sLineBreak +
      '                  Inner Join Pedidos P On P.PedidoId = PP.PedidoId' +
      sLineBreak +
      '				  Inner Join Produto Prd On Prd.IdProduto = PP.ProdutoId' +
      sLineBreak + '				  Group by PP.PedidoId)' + sLineBreak + '   ' +
      sLineBreak +
      ', VolumeStatus as (Select Pv.PedidoId, Min(De.ProcessoId) StatusMin, Max(De.ProcessoId) StatusMax'
      + sLineBreak + '                   From PedidoVolumes Pv' + sLineBreak
      + '				   Inner Join Pedidos Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak +
      '				   Inner Join vDocumentoEtapas DE On De.Documento = Pv.Uuid' +
      sLineBreak +
      '				   Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + '				   Group by Pv.PedidoId)' + sLineBreak + '   ' +
      sLineBreak +
      'Select Distinct P.*, E.ProcessoId, E.Descricao as ProcessoEtapa, Coalesce(IV.QtdProdutos, 0) QtdProdutos, Coalesce(IV.Peso, 0) as Peso, Coalesce(IV.Volume, 0) Volume, '
      + sLineBreak + '(Case' + sLineBreak +
      '   When Exists (Select Prd.EnderecoId' + sLineBreak +
      '                From PedidoProdutos PP' + sLineBreak +
      '                Inner join Produto Prd On Prd.IdProduto = PP.Produtoid' +
      sLineBreak +
      '                Left Join vEstoque Est ON Est.CodigoERP = Prd.CodProduto'
      + sLineBreak +
      '				Where PP.PedidoId = P.PedidoId and Prd.EnderecoId Is Null and Est.CodigoERP is Not Null) then'
      + sLineBreak + '     0' + sLineBreak + '   Else 1' + sLineBreak +
      ' End) As Picking' + sLineBreak + '   , Vs.StatusMin, Vs.StatusMax' +
      sLineBreak + 'From Pedidos P' + sLineBreak +
      'Inner join PedidoProdutos PP ON PP.PedidoId = P.PedidoId' + sLineBreak +
      'Left Join VolumeStatus VS ON Vs.PedidoId = P.PedidoId' + sLineBreak +
      'Left Join Etapas E ON E.Documento = P.uuid' + sLineBreak +
      'Left join ItensVolume IV ON Iv.PedidoId = P.PedidoId' + sLineBreak +
      'Where  ( (@ProcessoId = 0 or @ProcessoId = E.ProcessoId) or (@PedidoId<>0 and E.ProcessoId<>15)) and'
      + sLineBreak +
      '           ((@Recebido=0 and @Cubagem=0 and @Etiqueta=0) OR (@Recebido = 1 AND E.ProcessoId=1) OR'
      + sLineBreak + '		   (@Cubagem=1 and E.ProcessoId in (2,21)) OR' +
      sLineBreak + '		   (@Etiqueta=1 and E.ProcessoId = 3) )' + sLineBreak +
      '  And  (Case When @PrintTag=2 then 2' + sLineBreak +
      '        When @PrintTag=0 and  Exists (Select PedidoId From PedidoVolumes Pv'
      + sLineBreak +
      '		                              Inner join vDocumentoEtapas De On De.Documento = Pv.Uuid'
      + sLineBreak +
      '					                  Where DE.Documento = Pv.Uuid and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '						                And De.ProcessoId = 2 and Pv.PedidoId = P.PedidoId'
      + sLineBreak +
      '						                And (@Embalagem=2 or (@Embalagem=0 and Pv.EmbalagemId Is Null) or (@Embalagem=1 and Pv.EmbalagemId is Not Null) )) then 0'
      + sLineBreak +
      '        When @PrintTag=1 and Exists (Select PedidoId From PedidoVolumes Pv'
      + sLineBreak +
      '		                             Inner join vDocumentoEtapas De On De.Documento = Pv.Uuid'
      + sLineBreak +
      '							         Where DE.Documento = Pv.Uuid and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '							           And De.ProcessoId = 3 and Pv.PedidoId = P.PedidoId'
      + sLineBreak +
      '									   and (@Embalagem=2 or (@Embalagem=0 and Pv.EmbalagemId Is Null) or (@Embalagem=1 and Pv.EmbalagemId is Not Null) )) then 1'
      + sLineBreak + '        End) = @PrintTag' + sLineBreak +
      'Order by P.DocumentoData, P.PedidoId';

  Const
    SqlPedidoRotas = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @PessoaId Integer = Coalesce((Select PessoaId From Pessoa where CodPessoaERP = :pPessoaId and PessoaTipoId = 1), 0)'
      + sLineBreak + 'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' +
      sLineBreak + 'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @Recebido Integer = :pRecebido' + sLineBreak +
      'Declare @Cubagem Integer = :pCubagem' + sLineBreak +
      'Declare @Etiqueta Integer = :pEtiqueta' + sLineBreak +
      'Select Distinct Ped.RotaId, Ped.Rota Descricao ' + sLineBreak +
      'From vpedidos Ped' + sLineBreak +
      'Where (@DataIni=0 or Ped.DocumentoData >= @DataIni) and (@DataFin=0 or Ped.DocumentoData <= @DataFin) And Ped.OperacaoTipoId = 2 and'
      + sLineBreak + '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' +
      sLineBreak + '      (@PessoaId = 0 or Ped.CodPessoaERP = @PessoaId) and' +
      sLineBreak + ' 	    (@DocumentoNr = ' + #39 + #39 +
      ' or @DocumentoNr=Ped.DocumentoNr) and' + sLineBreak + '	    (@Razao = '
      + #39 + #39 + ' or Ped.Razao Like @Razao) and' + sLineBreak +
      '	    (@RegistroERP = ' + #39 + #39 +
      ' or Ped.RegistroERP = @RegistroERP) and' + sLineBreak +
      '      (@RotaId = 0 or @RotaId = Ped.RotaId) and' + sLineBreak +
      '      ((@Recebido=0 and @Cubagem=0 and @Etiqueta=0) OR (@Recebido = 1 AND Ped.ProcessoId=1) OR'
      + sLineBreak + '	    (@Cubagem=1 and Ped.ProcessoId in (2,21)) OR' +
      sLineBreak + '      (@Etiqueta=1 and Ped.ProcessoId = 3) )';

    { ';With'+sLineBreak+
      'Pedidos As (select Ro.RotaId, Ro.Descricao, Ped.uuid '+sLineBreak+
      '            From pedido Ped '+sLineBreak+
      '            Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId '+sLineBreak+
      '            Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId '+sLineBreak+
      '            Inner Join RotaPessoas RP On Rp.PessoaId = P.PessoaId '+sLineBreak+
      '            Left Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData '+sLineBreak+
      '            Left join Rotas Ro ON Ro.RotaId = Rp.RotaId '+sLineBreak+
      'Where (@DataIni=0 or Rd.Data >= @DataIni) and (@DataFin=0 or Rd.Data <= @DataFin) And Ped.OperacaoTipoId = 2 and'+sLineBreak+
      '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and'+sLineBreak+
      '      (@PessoaId = 0 or P.CodPessoaERP = @PessoaId) and'+sLineBreak+
      ' 			--(@DocumentoNr = '+#39+#39+' or @DocumentoNr=Ped.DocumentoNr) and'+sLineBreak+
      '			(@Razao = '+#39+#39+' or P.Razao Like @Razao) and'+sLineBreak+
      '			--(@RegistroERP = '+#39+#39+' or Ped.RegistroERP = @RegistroERP) and'+sLineBreak+
      '      (@RotaId = 0 or @RotaId = RP.RotaId))'+sLineBreak+
      '    '+sLineBreak+
      ', Etapas as (select DE.*'+sLineBreak+
      'From vDocumentoEtapas DE'+sLineBreak+
      'Inner Join Pedidos P ON P.uuid = DE.Documento'+sLineBreak+
      'Where DE.Documento = P.Uuid and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = P.uuid and Status = 1) )'+sLineBreak+
      ' '+sLineBreak+
      'select P.RotaId, P.Descricao From Pedidos P'+sLineBreak+
      'Left Join Etapas E ON E.Documento = P.uuid'+sLineBreak+
      'Where  ( (@ProcessoId = 0 or @ProcessoId = E.ProcessoId) or (@PedidoId<>0 and E.ProcessoId<>15)) and'+sLineBreak+
      '          ((@Recebido=0 and @Cubagem=0 and @Etiqueta=0) OR (@Recebido = 1 AND E.ProcessoId=1) OR'+sLineBreak+
      '		   (@Cubagem=1 and E.ProcessoId in (2,21)) OR'+sLineBreak+
      '		   (@Etiqueta=1 and E.ProcessoId = 3) )'+sLineBreak+
      'Group by P.RotaId, P.Descricao';
    }
  Const
    SqlPedidoPessoa = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @PessoaId Integer = Coalesce((Select PessoaId From Pessoa where CodPessoaERP = :pPessoaId and PessoaTipoId = 1), 0)'
      + sLineBreak + 'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' +
      sLineBreak + 'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @Recebido Integer = :pRecebido' + sLineBreak +
      'Declare @Cubagem Integer = :pCubagem' + sLineBreak +
      'Declare @Etiqueta Integer = :pEtiqueta' + sLineBreak +
      'select Distinct Ped.PessoaId, Ped.CodPessoaERP, Ped.Razao, Ped.RotaId' +
      sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Where (@DataIni=0 or Ped.DocumentoData >= @DataIni) and (@DataFin=0 or Ped.DocumentoData <= @DataFin) And Ped.OperacaoTipoId = 2 and'
      + sLineBreak + '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' +
      sLineBreak + '      (@PessoaId = 0 or Ped.CodPessoaERP = @PessoaId) and' +
      sLineBreak + ' 	    (@DocumentoNr = ' + #39 + #39 +
      ' or @DocumentoNr=Ped.DocumentoNr) and' + sLineBreak + '	    (@Razao = '
      + #39 + #39 + ' or Ped.Razao Like @Razao) and' + sLineBreak +
      '	    (@RegistroERP = ' + #39 + #39 +
      ' or Ped.RegistroERP = @RegistroERP) and' + sLineBreak +
      '      (@RotaId = 0 or @RotaId = Ped.RotaId) and' + sLineBreak +
      '      ((@Recebido=0 and @Cubagem=0 and @Etiqueta=0) OR (@Recebido = 1 AND Ped.ProcessoId=1) OR'
      + sLineBreak + '	    (@Cubagem=1 and Ped.ProcessoId in (2,21)) OR' +
      sLineBreak + '      (@Etiqueta=1 and Ped.ProcessoId = 3) )';

    { ';With'+sLineBreak+
      'Pedidos As (select P.PessoaId, P.CodPessoaERP, p.Razao, Rp.RotaId, Ped.uuid '+sLineBreak+
      'From pedido Ped '+sLineBreak+
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId '+sLineBreak+
      'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId '+sLineBreak+
      'Left Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData '+sLineBreak+
      'Left Join RotaPessoas RP On Rp.PessoaId = P.PessoaId '+sLineBreak+
      'Left join Rotas Ro ON Ro.RotaId = Rp.RotaId '+sLineBreak+
      'Where (@DataIni=0 or Rd.Data >= @DataIni) and (@DataFin=0 or Rd.Data <= @DataFin) And Ped.OperacaoTipoId = 2 and'+sLineBreak+
      '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and'+sLineBreak+
      '      (@PessoaId = 0 or P.PessoaId = @PessoaId) and'+sLineBreak+
      ' 			  (@DocumentoNr = '+#39+#39+' or @DocumentoNr=Ped.DocumentoNr) and'+sLineBreak+
      '				  (@Razao = '+#39+#39+' or P.Razao Like @Razao) and'+sLineBreak+
      '				  (@RegistroERP = '+#39+#39+' or Ped.RegistroERP = @RegistroERP) and'+sLineBreak+
      '      (@RotaId = 0 or @RotaId = RP.RotaId))'+sLineBreak+
      '    '+sLineBreak+
      ', Etapas as (select DE.*'+sLineBreak+
      'From vDocumentoEtapas DE'+sLineBreak+
      'Inner Join Pedidos P ON P.uuid = DE.Documento'+sLineBreak+
      'Where DE.Documento = P.Uuid and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = P.uuid and Status = 1) )'+sLineBreak+
      ' '+sLineBreak+
      'select P.PessoaId, P.CodPessoaERP, p.Razao, p.RotaId From Pedidos P'+sLineBreak+
      'Left Join Etapas E ON E.Documento = P.uuid'+sLineBreak+
      'Where  ( (@ProcessoId = 0 or @ProcessoId = E.ProcessoId) or (@PedidoId<>0 and E.ProcessoId<>15)) and'+sLineBreak+
      '           ((@Recebido=0 and @Cubagem=0 and @Etiqueta=0) OR (@Recebido = 1 AND E.ProcessoId=1) OR'+sLineBreak+
      '		   (@Cubagem=1 and E.ProcessoId in (2,21)) OR'+sLineBreak+
      '		   (@Etiqueta=1 and E.ProcessoId = 3) )'+sLineBreak+
      'Group by P.PessoaId, P.CodPessoaERP, p.Razao, p.RotaId';
    }
  Const
    SqlPedidoProdutos =
      'select PP.PedidoId, PP.PedidoItemId, Prd.IdProduto, Prd.CodProduto CodigoERP, Prd.Descricao DescrProduto, Prd.QtdUnid, '
      + sLineBreak + 'Prd.EnderecoId, TEnd.Descricao as EnderecoDescricao, ' +
      sLineBreak +
      'Prd.FatorConversao, PP.Quantidade as QtdSolicitada, 0 as QtdAtendida, 0 as QtdCorte '
      + sLineBreak + 'From PedidoProdutos PP ' + sLineBreak +
      'Inner Join Produto Prd On Prd.IdProduto = PP.ProdutoId ' + sLineBreak +
      'Left Join Enderecamentos TEnd ON TENd.EnderecoId = Prd.EnderecoId ' +
      sLineBreak + 'Where PedidoId = @Pedido';

  Const
    SqlReservaCorrecao = 'Delete From Estoque Where EstoqueTipoId = 6' +
      sLineBreak +
      'Insert Into Estoque select LoteId, EnderecoId, 6, QtdReserva, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date))'
      + sLineBreak +
      '                           , (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), 1, Null, Null, Null'
      + sLineBreak +
      '                                                        From (' +
      sLineBreak +
      '														Select Vl.LoteId, Vl.EnderecoId, Sum(QtdSuprida) QtdReserva'
      + sLineBreak + '														From PedidoVolumeLotes Vl' +
      sLineBreak +
      '														Inner Join PedidoVOlumes PV ON Pv.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '														Inner Join vDocumentoEtapas De On De.Documento = Pv.uuid'
      + sLineBreak +
      '														where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1) and'
      + sLineBreak +
      '															 De.processoId > 2 and De.Processoid < 13' +
      sLineBreak +
      '														Group by Vl.EnderecoId, Vl.LoteId) Res';

    // Cubagem de Pedidos - Estoque Dispon�vel para atender pedido Caixa Fechada
  Const
    SqlEstoqueCubagemCxaFechada = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak +
      'Select  Ep.ProdutoId, Ep.CodigoERP, Ep.Produto, Ep.EmbPrim, Ep.FatorConversao, Ep.EmbSec,'
      + sLineBreak +
      '   	    Ep.MesSaidaMinima, Ep.LoteId, Ep.DescrLote, Ep.Fabricacao, Ep.Vencimento,'
      + sLineBreak +
      '	  	    Ep.EnderecoId,	Ep.Endereco, Ep.EstruturaId, Ep.Estrutura, Ep.PickingFixo	Status,'
      + sLineBreak +
      '	  	    Ep.ZonaID	Zona, Ep.QtdeProducao, Ep.QtdeReserva, Ep.EstoqueTipoId,'
      + sLineBreak +
      '        ((Ep.Qtde / Ep.FatorConversao) * Ep.FatorConversao)  Qtde,' +
      sLineBreak +
      '	  	    Ep.EstoqueTipo, Ep.DtEntrada, Ep.HrEntrada, Ep.Horario, Ep.Producao, Ep.Distribuicao,'
      + sLineBreak +
      '	       Ep.Ordem, Ep.UsuarioId, Ep.UnidadeId, Ep.UnidadeSecundariaId, Ep.UnidadeSecundariaSigla,'
      + sLineBreak +
      '	       Ep.UnidadeSigla, Ep.UnidadeDescricao, Ep.UnidadeSecundariaDescricao,'
      + sLineBreak +
      '        ((PP.Quantidade / Prd.FatorConversao) * Prd.FatorConversao) as QtdPedido,'
      + sLineBreak +
      '        PP.EmbalagemPadrao, PP.Quantidade / EmbSec as CxaFechada' +
      sLineBreak + 'From Pedido Ped' + sLineBreak +
      'Inner Join PedidoProdutos PP ON PP.PedidoId = Ped.PedidoId' + sLineBreak
      + 'Inner Join Produto Prd on Prd.IdProduto = Pp.ProdutoId' + sLineBreak +
      'Inner Join vEstoqueProducao EP ON Ep.ProdutoId = PP.ProdutoId and Ep.Qtde >= Ep.FatorConversao'
      + sLineBreak + 'WHERE Ped.OperacaoTipoId = 2 and ' + sLineBreak +
      '      ((PP.Quantidade / Ep.FatorConversao) > 0) And (EP.FatorConversao > 1 or Prd.SomenteCxaFechada = 1) and'
      + sLineBreak +
    // '	     (PP.EmbalagemPadrao=1 or PP.EmbalagemPadrao=EP.FatorConversao) and'+sLineBreak+
      '      Vencimento > Cast(getdate()+(COALESCE (Ep.MesSaidaMinima, 0)*30) as date)'
      + sLineBreak + '      and Distribuicao = 1 and Ped.PedidoId = @PedidoId' +
      sLineBreak +
      'order by ProdutoId, Vencimento, Dtentrada, HrEntrada, Endereco';

    // https://pt.stackoverflow.com/questions/156661/como-concatenar-data-no-sql-server
  Const
    SqlMaxDocumentoEtapa = 'Declare @Documento VarChar(36) = :pDocumento' +
      sLineBreak + 'select Top 1 PE.Descricao, DE.*, DED.Data, DEH.Hora' +
      sLineBreak + ', Cast(CONVERT(DATETIME, CONVERT(CHAR(8), Ded.Data, 112) + '
      + #39 + ' ' + #39 +
      ' + CONVERT(CHAR(8),He.Hora, 108)) as DateTime) Horario' + sLineBreak +
      'From DocumentoEtapas DE' + sLineBreak +
      'Inner Join ProcessoEtapas PE ON Pe.ProcessoId = De.ProcessoId' +
      sLineBreak + 'Inner Join Rhema_data DED On DED.IdData = DE.DataId' +
      sLineBreak + 'Inner Join Rhema_Hora DEH On DEH.IdHora = DE.HoraId' +
      sLineBreak + 'Where Documento = @Documento  and DE.Status = 1' +
      sLineBreak +
      'Order By CAST(CONVERT(VARCHAR(10), CAST(DED.Data  AS DATE), 101) + ' +
      #39 + ' ' + #39 +
      ' SUBSTRING(CONVERT(VARCHAR, DEH.Hora),1,8) AS DATETIME)  Desc';

    // Get Status dos Volumes
  Const
    SqlStatusVolume = 'Declare @PedidoId Int = :PedidoId' + sLineBreak +
      'Declare @PedidoVolumeId Int = :pPedidoVolumeId' + sLineBreak +
      'select PV.PedidoVolumeId,  DE.ProcessoId' + sLineBreak +
      'From PedidoVolumes PV' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid' + sLineBreak +
      'where ((@PedidoId=0 or Pv.PedidoId = @PedidoId) and' + sLineBreak +
      '       (@PedidoVolumeId=0 or PV.PedidoVolumeId = @PedidoVolumeId)) and' +
      sLineBreak +
      '	   DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = PV.uuid and Status = 1)';

  Const
    SqlPedidoProcesso = 'Declare @Pedidoid Integer = :pPedidoId' + sLineBreak +
      'select Ped.PedidoId, E.ProcessoId, E.Descricao Etapa, E.UsuarioId, U.Nome Usuario, Horario, Terminal'
      + sLineBreak + 'FROM Pedido Ped' + sLineBreak +
      'Inner Join vDocumentoEtapas E On E.Documento = Ped.uuid' + sLineBreak +
      'Left Join Usuarios U On U.UsuarioId = E.UsuarioId' + sLineBreak +
      'Where Ped.PedidoId = @PedidoId' + sLineBreak + 'order by e.Horario';

  Const
    SqlPedidoVolumeEtapas = 'Declare @PedidoVolumeid Integer = :pPedidoVolumeId'
      + sLineBreak +
      'select Pv.PedidoVolumeId, Pv.Sequencia, E.ProcessoId, E.Descricao Etapa, E.UsuarioId, U.Nome Usuario, Horario, Terminal'
      + sLineBreak + 'FROM PedidoVolumes PV' + sLineBreak +
      'Inner Join vDocumentoEtapas E On E.Documento = Pv.uuid' + sLineBreak +
      'Inner Join Usuarios U On U.UsuarioId = E.UsuarioId' + sLineBreak +
      'Where Pv.PedidoVolumeId = @PedidoVolumeId' + sLineBreak +
      'order by e.Horario';

    // Cadastro de Caixas
  Const
    SqlCaixaEmbalagem = 'Declare @CaixaEmbalagemId Integer = :pCaixaEmbalagemId'
      + sLineBreak +
      'Select Ce.CaixaEmbalagemId,  Ce.NumSequencia, Ce.Observacao, Ce.Status,'
      + sLineBreak +
      '       VE.EmbalagemId, VE.Descricao, VE.Identificacao, VE.Tipo,' +
      sLineBreak + '   (Case When Tipo = ' + #39 + 'R' + #39 + ' then ' + #39 +
      'Retorn�vel' + #39 + sLineBreak + '          When Tipo = ' + #39 + 'P' +
      #39 + ' then '#39 + 'Pr�pria' + #39 + sLineBreak +
      '           When Tipo = ' + #39 + 'C' + #39 + ' then '#39 + 'Pacote' + #39
      + sLineBreak + '           WHen Tipo = ' + #39 + 'U' + #39 + ' then '#39 +
      'Reutiliz�vel' + #39 + sLineBreak +
      '    End) as TipoDescricao, VE.Altura, VE.Largura, VE.Comprimento,' +
      sLineBreak +
      '	   (VE.Altura*VE.Largura*VE.Comprimento) Volume, VE.Aproveitamento,' +
      sLineBreak +
      '	   cast(Cast((VE.Altura*VE.Largura*VE.Comprimento)*VE.Aproveitamento as Decimal(15,3)) as Decimal(15,3)) VolCm3,'
      + sLineBreak +
      '    VE.Capacidade, Tara, QtdLacres, CodBarras, Ce.Disponivel, PrecoCusto'
      + sLineBreak + 'From CaixaEmbalagem CE' + sLineBreak +
      'Inner Join VolumeEmbalagem VE  On VE.EmbalagemId = CE.EmbalagemId' +
      sLineBreak +
      'Where (@CaixaEmbalagemId = 0 or @CaixaEmbalagemId = CE.CaixaEmbalagemID)';

  Const
    SqlCaixaEmbalagemLista =
      'Declare @CaixaEmbalagemId Integer  = :pCaixaEmbalagemId' + sLineBreak +
      'Declare @SequenciaIni Integer      = :pSequenciaIni' + sLineBreak +
      'Declare @SequenciaFin Integer      = :pSequenciaFin' + sLineBreak +
      'Declare @VolumeEmbalagemid Integer = :pVolumeEmbalagemId' + sLineBreak +
      'Declare @Situacao Varchar(1)       = :pSituacao' + sLineBreak +
      'Declare @Status Integer            = :pStatus' + sLineBreak +
      'Select (Select Ce.caixaembalagemid,  Ce.numsequencia, coalesce(Ce.observacao, '
      + #39 + #39 + ') observacao, Ce.status, ' + sLineBreak +
      '        Coalesce(Ce.disponivel, 0) disponivel, (Case When Ce.Disponivel = 1 Then '
      + #39 + 'Dispon�vel' + #39 + ' Else ' + #39 + 'Em Uso' + #39 +
      ' End) situacao,' + sLineBreak +
      '       VolumeEmbalagem.embalagemid, VolumeEmbalagem.descricao, VolumeEmbalagem.identificacao, VolumeEmbalagem.tipo,'
      + sLineBreak + '       (Case When Tipo = ' + #39 + 'R' + #39 + ' then ' +
      #39 + 'Retorn�vel' + #39 + sLineBreak + '             When Tipo = ' + #39
      + 'P' + #39 + ' then ' + #39 + 'Pr�pria' + #39 + sLineBreak +
      '             When Tipo = ' + #39 + 'C' + #39 + ' then ' + #39 + 'Pacote'
      + #39 + sLineBreak + '             WHen Tipo = ' + #39 + 'U' + #39 +
      ' then ' + #39 + 'Reutiliz�vel' + #39 + sLineBreak +
      '        End) as tipodescricao, Cast(VolumeEmbalagem.altura as Decimal(15,2)) as altura,'
      + sLineBreak +
      '	    Cast(VolumeEmbalagem.Largura as Decimal(15,2)) as largura,' +
      sLineBreak +
      '		Cast(VolumeEmbalagem.Comprimento as Decimal(15,2)) as comprimento,' +
      sLineBreak +
      '	    Cast((VolumeEmbalagem.Altura*VolumeEmbalagem.Largura*VolumeEmbalagem.Comprimento) as Decimal(15,3)) as volume, VolumeEmbalagem.aproveitamento,'
      + sLineBreak +
      '	   cast(Cast((VolumeEmbalagem.Altura*VolumeEmbalagem.Largura*VolumeEmbalagem.Comprimento)*VolumeEmbalagem.Aproveitamento as Decimal(15,3))/100 as Decimal(15,3)) volcm3,'
      + sLineBreak +
      '    Cast(VolumeEmbalagem.Capacidade as Decimal(15,3)) as capacidade, Cast(Tara as Decimal(15,3)) tara, qtdlacres, codbarras, Cast(PrecoCusto as Decimal(15,2)) precocusto'
      + sLineBreak + 'From CaixaEmbalagem CE' + sLineBreak +
      'Inner Join VolumeEmbalagem On VolumeEmbalagem.EmbalagemId = CE.EmbalagemId'
      + sLineBreak +
      'Where (@CaixaEmbalagemId = 0 or @CaixaEmbalagemId = CE.CaixaEmbalagemID) and '
      + sLineBreak +
      '      (@SequenciaIni = 0 or Ce.NumSequencia >= @SequenciaIni) and ' +
      sLineBreak +
      '      (@SequenciaFin = 0 or Ce.NumSequencia <= @SequenciaFin) and ' +
      sLineBreak +
      '      (@VolumeEmbalagemId = 0 or @VolumeEmbalagemId = Ce.EmbalagemId) and '
      + sLineBreak +
    // '      (@Situacao = '+#39+'A'+#39+' or
      '      (@Status>1 or @Status = Ce.Status) For Json Auto) as JsonRetorno';
    // --, root('caixaembalagem') , INCLUDE_NULL_VALUES

    // Volume Tipo
  Const
    SqlVolumeEmbalagem = 'Declare @EmbalagemId Integer = :pEmbalagemId' +
      sLineBreak + 'Declare @Descricao VarChar(30) = :pDescricao' + sLineBreak +
      'Select *, ' + sLineBreak + ' (Case' + sLineBreak + '     When Tipo = ' +
      #39 + 'R' + #39 + ' then ' + #39 + 'Retorn�vel' + #39 + sLineBreak +
      '     When Tipo = ' + #39 + 'P' + #39 + ' then ' + #39 + 'Pr�pria' + #39 +
      sLineBreak + '     When Tipo = ' + #39 + 'C' + #39 + ' then ' + #39 +
      'Pacote' + #39 + sLineBreak + '     WHen Tipo = ' + #39 + 'U' + #39 +
      ' then ' + #39 + 'Reutiliz�vel' + #39 + sLineBreak +
      '		End) as TipoDescricao' + sLineBreak + 'From VolumeEmbalagem' +
      sLineBreak + 'Where (@EmbalagemId = 0 or @EmbalagemId = EmbalagemID) and '
      + sLineBreak + '      (@Descricao = ' + #39 + #39 +
      ' or Descricao like @Descricao)';

  Const
    SqlRegistrarDocumentoEtapa = '--Adicionar a instru��o conforme abaixo' +
      sLineBreak +
      '--declare @uuid UNIQUEIDENTIFIER = (Select uuid From PEdido where PedidoId = :pPedidoId)   '
      + sLineBreak + 'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @UsuarioId  Integer = :pUsuarioId' + sLineBreak +
      '   Update DocumentoEtapas Set Status = 0 where Documento = @uuid and ProcessoId = @ProcessoId'
      + sLineBreak +
      '   Insert Into DocumentoEtapas Values (@uuid, @ProcessoId, (Case When @UsuarioId=0 Then Null Else @UsuarioId End), '
      + sLineBreak + SqlDataAtual + ', ' + SqlHoraAtual +
      ', GetDate(), :pTerminal, 1)';

Const SqlCreateVolume = 'Declare @PedidoId Integer  = :pPedidoId' + sLineBreak +
      'Declare @NewId Varchar(38) = :pNewId' + sLineBreak +
      'Declare @NumVolume Integer = (Select Coalesce(Max(Sequencia), 0)+1 From PedidoVolumes Where PedidoId = @PedidoId)'+ sLineBreak +
      'Declare @EmbalagemId integer = :pEmbalagemId' + sLineBreak+
      'Insert Into PedidoVolumes Values ((Case When @EmbalagemId<>0 then @EmbalagemId '+sLineBreak+
      '                                        Else Null End), @PedidoId, @NumVolume, Null, 1, '+sLineBreak+
      '                                  Cast(@NewId AS UNIQUEIDENTIFIER), '#39+ 'N' + #39 + ', 0)' + sLineBreak +
      '   ' + sLineBreak +
      'Update DocumentoEtapas Set Status = 0 where Documento = @NewId and ProcessoId = 2' + sLineBreak +
      'Insert Into DocumentoEtapas Values (Cast(@NewId AS UNIQUEIDENTIFIER), 2, :pUsuarioId, '+sLineBreak +
                                           SqlDataAtual + ', ' + SqlHoraAtual + ', GetDate(), :pTerminal, 1)';

Const SqlEstoqueVolumeCaixaFracionada = 'Declare @PedidoId Integer = :pPedidoId' +sLineBreak +
      ';With' + sLineBreak +
      'PedProd as (select PP.ProdutoId, PP.EmbalagemPadrao,' + sLineBreak +
      '            ((Pp.Quantidade / Pp.EmbalagemPadrao)*EmbalagemPadrao) - Coalesce(EstVol.QtdVol, 0) QtdSolicitada, Prd.MesSaidaMinima' + sLineBreak +
      '            From PedidoProdutos PP' + sLineBreak +
      '            Inner Join Produto Prd On Prd.IdProduto = Pp.Produtoid' + sLineBreak +
      '            Left Join (Select Pv.PedidoId, Pl.ProdutoId, Sum(Vl.Quantidade) QtdVol' + sLineBreak +
      '            	       From PedidoVolumeLotes Vl' + sLineBreak +
      '            		   Inner Join PedidoVolumes Pv ON Pv.PedidoVolumeId = Vl.PedidoVolumeId' + sLineBreak +
      '               		   Inner Join ProdutoLotes PL On Pl.LoteId = VL.LoteId' + sLineBreak +
      '            		   Group By Pv.PedidoId, Pl.ProdutoId) EstVol On EstVol.PedidoId = Pp.PedidoId and EstVol.ProdutoId = Pp.Produtoid' + sLineBreak +
      '            where PP.PedidoId = @PedidoId and ((Pp.Quantidade / Pp.EmbalagemPadrao)*EmbalagemPadrao) - Coalesce(EstVol.QtdVol, 0) <> 0 And PP.Quantidade >= PP.EmbalagemPadrao)' + sLineBreak +
      ', EstoqPicking as (Select Ep.ProdutoId, Ep.LoteId, Ep.Vencimento, Sum(Ep.Qtde) Qtde' + sLineBreak +
      '            From vEstoque Ep' + sLineBreak +
      '            Inner Join Pedprod PP ON PP.ProdutoId = EP.ProdutoId' + sLineBreak +
      '			       Where EstruturaId = 2' + sLineBreak +
      '            Group by Ep.ProdutoId, Ep.LoteId, Ep.Vencimento' + sLineBreak+
      '            UNION All' + sLineBreak +
      '            Select Rc.ProdutoId, Rc.LoteId, Pl.Vencimento, Sum(Rc.Qtde) Qtde' + sLineBreak +
      '            FROM REPOSICAOENDERECOCOLETA RC' + sLineBreak +
      '            INNER JOIN REPOSICAO REP ON REP.REPOSICAOID = RC.REPOSICAOID' + sLineBreak +
      '			       Inner Join Pedprod Pp ON Pp.ProdutoId = Rc.Produtoid' + sLineBreak +
      '		         Inner join vProdutolotes Pl On Pl.LoteId = Rc.LoteId' + sLineBreak +
      '			       WHERE Rep.PROCESSOID IN (27, 28) and rc.usuarioId is Null' + sLineBreak +
      '            Group by Rc.ProdutoId, Rc.LoteId, Pl.Vencimento' + sLineBreak +
      '            UNION All' + sLineBreak +
      '            Select Pl.IdProduto, RT.LoteId, Pl.Vencimento, Sum(RT.Qtde) Qtde' + sLineBreak +
      '            FROM ReposicaoEstoqueTransferencia RT' + sLineBreak +
      '			       Inner join vProdutoLotes Pl On Pl.Loteid = RT.LoteId' + sLineBreak +
      '			       Inner Join Pedprod Pp ON Pp.ProdutoId = Pl.IdProduto' + sLineBreak +
      '			       Group by Pl.IdProduto, RT.LoteId, Pl.Vencimento)' + sLineBreak +
      ', EstoqPulmao as (Select Ep.ProdutoId, Ep.LoteId, Ep.Vencimento, sum(Ep.Qtde) QtdeP, sum(EPick.Qtde) Qtde2,'+sLineBreak+
      '                         Sum(Ep.Qtde + Coalesce(EPick.Qtde, 0)) Qtde   --- (Case When Coalesce(EPick.Qtde, 0) < 0 then EPick.Qtde Else 0 End)) Qtde'+sLineBreak+
      '            From vEstoqueProducao Ep'+sLineBreak+
      '            Inner Join Pedprod PP ON PP.ProdutoId = EP.ProdutoId'+sLineBreak+
      '			Left Join (Select ProdutoId, LoteId, Sum(Qtde) QTde'+sLineBreak+
      '			           From vEstoque Est'+sLineBreak+
      '					   Where EstruturaId = 2 and Qtde<0'+sLineBreak+
      '					   Group by ProdutoId, LoteId) EPick On EPick.ProdutoId = Ep.ProdutoId and EPick.LoteId = Ep.LoteId'+sLineBreak+
      '			Where EstruturaId = 1'+sLineBreak+
      '            Group by Ep.ProdutoId, Ep.LoteId, Ep.Vencimento'+sLineBreak+
      '			Having Sum(Ep.Qtde + Coalesce(EPick.Qtde, 0)) <> 0--- (Case When Coalesce(EPick.Qtde, 0) < 0 then EPick.Qtde Else 0 End))>0'+sLineBreak+
      '			)'+sLineBreak+
      ', Estoq as (Select Produtoid, LoteId, Vencimento, 1 As PickingFixo, Sum(Qtde) Qtde' + sLineBreak +
      '            From EstoqPicking' + sLineBreak +
      '			Where Qtde <> 0' + sLineBreak +
      '			Group By Produtoid, LoteId, Vencimento' + sLineBreak +
      '			UNION' + sLineBreak +
      '			Select Produtoid, LoteId, Vencimento, 0 As PickingFixo, Sum(Qtde) Qtde' + sLineBreak +
      '            From EstoqPulmao' + sLineBreak +
      '			Where Qtde <> 0' + sLineBreak +
      '			Group By Produtoid, LoteId, Vencimento)' + sLineBreak +
      'Select Prd.ZonaID, P.Produtoid, Prd.EnderecoDescricao, Prd.FatorConversao, P.EmbalagemPadrao,' + sLineBreak +
      '       Prd.Volume*P.EmbalagemPadrao VolumeCm3,' + sLineBreak +
      '       cast(cast(PesoLiquido as Decimal(10,3))/1000*P.EmbalagemPadrao as decimal(10, 3)) as PesoLiquidoKg,' + sLineBreak +
      '   	   Prd.EnderecoId, Prd.EnderecoId EnderecoOrigem, Prd.RuaId, P.QtdSolicitada, Est.LoteId,'+ sLineBreak +
      '	      4 as EstoqueTipoId, Est.Vencimento, 0 Horario,' + sLineBreak +
      '       1 Ordem, 0 Distribuicao, Est.PickingFixo, ' + sLineBreak+
      '	   Est.Qtde, 0 as Bloqueado' + sLineBreak +
      'From Pedprod P' + sLineBreak +
      'Inner Join vProduto Prd on Prd.IdProduto = P.ProdutoId' + sLineBreak +
      'Inner Join Estoq Est ON Est.Produtoid = P.ProdutoId' + sLineBreak +
      '                    and Est.Vencimento > Cast(getdate()+(COALESCE (Prd.MesSaidaMinima, 0)*30) as date)' + sLineBreak +
      'Left Join vEstoque vEst On vEst.LoteId = Est.LoteId and vEst.EnderecoId = Prd.EnderecoId'+sLineBreak+
      'Where Est.Qtde >= P.EmbalagemPadrao' + sLineBreak +
      'Order by Prd.ZonaID, RuaId, EnderecoDescricao, P.ProdutoId, Est.PickingFixo Desc, Est.Vencimento, vEst.DtEntrada --Desc';

Const SqlEstoqueVolumeCaixaFracionadaOLD = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      ';With' + sLineBreak +
      'PedProd as (select PP.ProdutoId, Prd.FatorConversao, PP.EmbalagemPadrao,'
      + sLineBreak +
      '            PP.Quantidade - Coalesce((Select Sum(Vl.Quantidade)' +
      sLineBreak + '	           From PedidoVolumes Vp' + sLineBreak +
      '								    Inner Join PedidoVolumeLotes VL ON VL.PedidoVolumeId = VP.PedidoVolumeId'
      + sLineBreak +
      '   								 Inner Join ProdutoLotes PL On Pl.LoteId = VL.LoteId'
      + sLineBreak +
      '   								 Where VP.PedidoId = PP.PedidoId and PL.ProdutoId = PP.ProdutoId), 0) as QtdSolicitada'
      + sLineBreak + 'From PedidoProdutos PP' + sLineBreak +
      'Inner Join Produto Prd On Prd.IdProduto = Pp.Produtoid' + sLineBreak +
      'where PP.PedidoId = @PedidoId)' + sLineBreak +
      ', Estoq as (Select Ep.ProdutoId, EP.LoteId, Ep.EnderecoId EnderecoOrigem, EP.Ordem, Ep.PickingFixo, EP.Distribuicao, EP.Vencimento,'
      + sLineBreak +
      '                   Ep.EstoqueTipoId, Ep.DtEntrada, Ep.HrEntrada, Sum(EP.Qtde) Qtde'
      + sLineBreak + '            From vEstoqueProducao EP' + sLineBreak +
      '            Inner Join Pedprod PP ON PP.ProdutoId = EP.ProdutoId' +
      sLineBreak +
      '            where Ep.Qtde >= PP.EmbalagemPadrao and Vencimento > Cast(getdate()+(COALESCE (MesSaidaMinima, 0)*30) as date)'
      + sLineBreak +
      '		         Group by Ep.ProdutoId, EP.LoteId, Ep.EnderecoId, EP.Ordem, Ep.PickingFixo, EP.Distribuicao, EP.Vencimento, Ep.EstoqueTipoId, Ep.DtEntrada, Ep.HrEntrada'
      + sLineBreak + '            Union --Reserva Reposi��o' + sLineBreak +
      '			       Select Rc.ProdutoId, Rc.LoteId, Pl.EnderecoId EnderecoOrigem, 1 As Ordem, 1 PickingFixo, 1 Distribuicao,'
      + sLineBreak +
      '			              Pl.Vencimento, 4 As EstoqueTipoId, FORMAT(Est.DtEntrada, '
      + #39 + 'dd/MM/yyyy' + #39 + ')  as DtEntrada, Est.HrEntrada, ' +
      sLineBreak + '                   (Rc.Qtde + Coalesce(Est.Qtde, 0)) Qtde' +
      sLineBreak + '			       From ReposicaoEnderecoColeta RC' +
      sLineBreak +
      '			       Inner Join Reposicao Rep On Rep.ReposicaoId = Rc.ReposicaoId'
      + sLineBreak +
      '			       Inner join vProdutoLotes Pl On Pl.LoteId = Rc.LoteId' +
      sLineBreak +
      '            Left Join vestoque Est on Est.LoteId = Rc.LoteId and Est.EnderecoId = Pl.EnderecoId and Est.Qtde < 0'
      + sLineBreak +
      '			       Where Rep.ProcessoId in (27, 28) and (Rc.QtdRepo Is Null) and (Rc.Qtde + Coalesce(Est.Qtde, 0)) > 0)'
      + sLineBreak +
      'Select Prd.ZonaID, PP.Produtoid, Prd.EnderecoDescricao, PP.FatorConversao, PP.EmbalagemPadrao, Prd.Volume*PP.EmbalagemPadrao VolumeCm3,'
      + sLineBreak +
      '       cast(cast(PesoLiquido as Decimal(10,3))/1000*PP.EmbalagemPadrao as decimal(10, 3)) as PesoLiquidoKg,'
      + sLineBreak +
      '   	   Prd.EnderecoId, Est.EnderecoOrigem, Prd.RuaId, PP.QtdSolicitada, Est.LoteId,'
      + sLineBreak + '	      Est.EstoqueTipoId, Est.Vencimento, 0 Horario,' +
      sLineBreak + '       Est.Ordem, 0 Distribuicao, Est.PickingFixo,' +
      sLineBreak + '	      Sum(Est.Qtde) Qtde,' + sLineBreak +
      '       Coalesce(Sum(Bloq.Qtde), 0) Bloqueado' + sLineBreak +
      'From PedProd PP' + sLineBreak +
      'Inner join Estoq Est On Est.ProdutoId = PP.ProdutoId' + sLineBreak +
      'Left Join (select LoteId, Sum(Qtde) Qtde From Estoque Res Where EstoqueTipoId = 6 and'
      + sLineBreak +
      '                  Not Exists (Select LoteId From Estoque where EstoqueTipoId <> 6 and LoteId = Res.Loteid and Enderecoid = Res.EnderecoId)'
      + sLineBreak +
      '		   Group By LoteId) as Bloq On Bloq.LoteId = Est.LoteId' + sLineBreak
      + 'Inner Join vProduto Prd On Prd.IdProduto = PP.ProdutoId' + sLineBreak +
      'where PP.QtdSolicitada >= PP.EmbalagemPadrao' + sLineBreak +
      'Group by Prd.ZonaID, PP.Produtoid, Prd.EnderecoDescricao, PP.FatorConversao, PP.EmbalagemPadrao, Prd.Volume*PP.EmbalagemPadrao,'
      + sLineBreak +
      '      cast(cast(PesoLiquido as Decimal(10,3))/1000*PP.EmbalagemPadrao as decimal(10, 3)),'
      + sLineBreak +
      '   	  Prd.EnderecoId, Prd.RuaId, PP.QtdSolicitada, Est.LoteId, Est.EnderecoOrigem,'
      + sLineBreak +
      '	     Est.Vencimento, est.Ordem, Est.PickingFixo, Est.DtEntrada, Est.EstoqueTipoId, Est.HrEntrada'
      + sLineBreak +
      'Order by Prd.ZonaID, RuaId, EnderecoDescricao, PP.ProdutoId, Est.PickingFixo Desc, --Est.Ordem, --Est.Distribuicao'
      + sLineBreak + '      Est.Vencimento, Est.DtEntrada, Est.HrEntrada';

Const SqlGerarVolumeLoteCaixaFechada = 'Declare @PedidoVolumeId Integer = (Select PedidoVolumeId From PedidoVolumes Where uuid = :pNewId)'+sLineBreak +
      'Declare @Quantidade Integer = :pQuantidade' + sLineBreak +
      'Declare @LoteId Integer = :pLoteId ' + sLineBreak +
      'Declare @EnderecoId Integer    = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Terminal Varchar(50)  = :pTerminal' + sLineBreak +
      'Declare @UsuarioId Integer = :pUsuarioId' + sLineBreak +
      'If Not Exists (Select PedidoVolumeLoteId From pedidoVolumelotes ' +
      sLineBreak +
      '               Where PedidoVolumeId = @PedidoVolumeId and LoteId = @LoteId and EnderecoId = @EnderecoId) Begin'
      + sLineBreak +
      '   Insert Into PedidoVolumeLotes Values (@PedidoVolumeId, @LoteId, @EnderecoId, @EstoqueTipoId, '
      + sLineBreak +
      '               @Quantidade, :pEmbalagemPadrao, @Quantidade, ' +
      SqlDataAtual + ', ' + SqlHoraAtual + ', @Terminal, @UsuarioId, Null)' +
      sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '  Update PedidoVolumeLotes Set Quantidade = Quantidade + @Quantidade, QtdSuprida = QtdSuprida + @Quantidade'
      + sLineBreak +
      '  Where PedidoVolumeId = @PedidoVolumeId and LoteId = @LoteId and EnderecoId = @EnderecoId'
      + sLineBreak + 'End';

  Const
    SqlGetEstoque = 'SET NOCOUNT ON' + sLineBreak +
      'SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED' + sLineBreak +
      'Declare @ProdutoId     Integer = :pProdutoId' + sLineBreak +
      'Declare @LoteId        Integer = :pLoteId' + sLineBreak +
      'Declare @EnderecoId    Integer = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Producao      Integer = :pProducao' + sLineBreak +
      'Declare @Distribuicao  Integer = :pDistribuicao' + sLineBreak +
      'Declare @Zerado        Char(1) = :pZerado' + sLineBreak +
      'Declare @Negativo      Char(1) = :pNegativo' + sLineBreak +
      'select * From vEstoque' + sLineBreak +
      'Where (@ProdutoId = 0 or ProdutoId = @ProdutoId) and' + sLineBreak +
      '   (@LoteId = 0 or LoteId = @LoteId) and' + sLineBreak +
      '	  (@EnderecoId = 0 or EnderecoId = @EnderecoId) and' + sLineBreak +
      '	  (@EstoqueTipoId = 0  or EstoqueTipoId = @EstoqueTipoId) and' +
      sLineBreak + '	  (@Producao = 2 or Producao = @Producao) and' +
      sLineBreak +
      '	  (@Distribuicao = 2 or Distribuicao = @Distribuicao) And ' + sLineBreak
      + '   (@Zerado<>' + #39 + 'N' + #39 +
      ' or QtdeProducao-QtdeReserva>0) and ' + sLineBreak + '   (@Negativo<>' +
      #39 + 'N' + #39 + ' or Qtde>=0)' + sLineBreak +
      'Order by Vencimento, Horario';

  Const
    SqlGetEstoqueLotePorTipo = 'Declare @ProdutoId     Integer = :pProdutoId' +
      sLineBreak + 'Declare @LoteId        Integer = :pLoteId' + sLineBreak +
      'Declare @EnderecoId    Integer = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Producao      Integer = :pProducao' + sLineBreak +
      'Declare @Distribuicao  Integer = :pDistribuicao' + sLineBreak +
      'Declare @Zerado        Char(1) = :pZerado' + sLineBreak +
      'Declare @Negativo      Char(1) = :pNegativo' + sLineBreak +
      'SELECT ProdutoId ProdutoId, CodigoERP, FatorConversao, Pvt.LoteId, DescrLote, Fabricacao, Vencimento, '
      + sLineBreak + 'Coalesce([1], 0) AS ' + #39 + 'Stage'#39 + ', ' +
      sLineBreak + 'Coalesce([2], 0) AS ' + #39 + 'Crossdocking'#39 + ', ' +
      sLineBreak + 'Coalesce([3], 0) AS ' + #39 + 'Segregado' + #39 + ', ' +
      sLineBreak + 'Coalesce([4], 0) AS ' + #39 + 'Producao' + #39 + ', ' +
      sLineBreak + 'Coalesce([5], 0) AS ' + #39 + 'Expedicao' + #39 + ', ' +
      sLineBreak + 'Coalesce([6], 0) AS ' + #39 + 'Reserva' + #39 + ', ' +
      sLineBreak +
      'Coalesce([1], 0) + Coalesce([2], 0) + Coalesce([3], 0) + Coalesce([4], 0) + Coalesce([5], 0) - Coalesce([6], 0) as Saldo, Mov.Data DtUltimaMovimentacao '
      + sLineBreak + 'FROM ' + sLineBreak +
      '(SELECT Pl.IdProduto ProdutoId, Pl.CodProduto CodigoERP, Prd.FatorConversao, Pl.LoteId, Pl.Lote DescrLote, Pl.Data Fabricacao, Vencimento, Qtde, Est.EstoqueTipoId'
      + sLineBreak + 'FROM Estoque Est' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.LoteId = Est.LoteId' + sLineBreak +
      'Inner Join Produto Prd On Prd.IdProduto = Pl.IdProduto' + sLineBreak +
      'Inner Join EstoqueTipo ET ON ET.Id = Est.EstoqueTipoId' + sLineBreak +
      'Inner join Enderecamentos TEnd On TEnd.EnderecoId = Est.EnderecoId' +
      sLineBreak +
      'Inner Join EnderecamentoEstruturas EE On EE.EstruturaId = TEnd.EstruturaID'
      + sLineBreak + 'Where --Qtde <> 0 And' + sLineBreak +
      '      (@ProdutoId = 0 or Pl.IdProduto = @ProdutoId) and' + sLineBreak +
      '      (@LoteId = 0 or Est.LoteId = @LoteId) and' + sLineBreak +
      '      (@EnderecoId = 0 or Est.EnderecoId = @EnderecoId) and' + sLineBreak
      + '      --(@ZonaId = 0 or ZonaId = @ZonaId) and' + sLineBreak +
      '      (@EstoqueTipoId = 0  or Est.EstoqueTipoId = @EstoqueTipoId) and' +
      sLineBreak + '      (@Producao = 2 or Et.Producao = @Producao) and' +
      sLineBreak +
      '	     (@Distribuicao = 2 or EE.Distribuicao = @Distribuicao) And' +
      sLineBreak + '      (@Zerado<>' + #39 + 'N' + #39 + ' or Qtde<>0) and ' +
      sLineBreak + '       (@Negativo<>' + #39 + 'N' + #39 + ' or Qtde>0)' +
      sLineBreak + ') AS Tbl ' + sLineBreak +
      'PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt '
      + sLineBreak + 'Left Join (select LoteId, Max(Data) Data' + sLineBreak +
      '           From (select Pc.LoteId, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoItensCheckIn Pc' + sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pc.Pedidoid' +
      sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'
      + sLineBreak + '                 Group by Pc.LoteId' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Vl.LoteId, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoVolumeLotes Vl' + sLineBreak +
      '                 Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pv.Pedidoid' +
      sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'
      + sLineBreak + '                 Group by Vl.LoteId' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Ia.LoteId, Max(De.Data) Data' + sLineBreak +
      '                 from InventarioAjuste Ia' + sLineBreak +
      '                 Inner join Inventarios Inv On Inv.InventarioId = Ia.InventarioId'
      + sLineBreak +
      '                 Inner Join vDocumentoEtapas De ON De.Documento = Inv.uuid and De.ProcessoId = 26'
      + sLineBreak + '                 Group by Ia.LoteId) MovEst' + sLineBreak
      + '           Group by LoteId) Mov On Mov.LoteId = Pvt.LoteId' +
      sLineBreak + 'Order by Vencimento';

  Const SqlRelEstoqueLotePorTipo = 'Declare @ProdutoId     Integer = :pProdutoId' + sLineBreak +
      'Declare @LoteId        Integer = :pLoteId' + sLineBreak +
      'Declare @EnderecoId    Integer = :pEnderecoId' + sLineBreak +
      'Declare @ZonaId        Integer = :pZonaId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Producao      Integer = :pProducao' + sLineBreak +
      'Declare @Distribuicao  Integer = :pDistribuicao' + sLineBreak +
      'Declare @Zerado        Char(1) = :pZerado' + sLineBreak +
      'Declare @Negativo      Char(1) = :pNegativo' + sLineBreak +
      'SELECT ProdutoId, CodProduto, Descricao, Pvt.LoteId, DescrLote, Fabricacao, Vencimento, '+ sLineBreak +
      '       Coalesce([1], 0) AS ' + #39 + 'QtdEspera'#39 + ', ' + sLineBreak +
      '       Coalesce([2], 0) AS ' + #39 + 'QtdCrosDocking'#39 + ', ' + sLineBreak +
      '       Coalesce([3], 0) AS ' + #39 + 'Segregado' + #39 + ', ' + sLineBreak +
      '       Coalesce([4], 0) AS ' + #39 + 'QtdProducao' + #39 + ', ' + sLineBreak +
      '       Coalesce([5], 0) AS ' + #39 + 'Expedicao' + #39 + ', ' + sLineBreak +
      '       Coalesce([6], 0) AS ' + #39 + 'Reserva' + #39 + ', ' + sLineBreak +
      '       Coalesce([7], 0) AS ' + #39 + 'QtdeTransfPicking' + #39 + ', ' + sLineBreak +
      '       Coalesce([1], 0) + Coalesce([4], 0) + Coalesce([7], 0) - Coalesce([6], 0) as Saldo, '+sLineBreak+
      '       Mov.Data DtUltimaMovimentacao ' + sLineBreak +
      'FROM (SELECT ProdutoId, CodigoERP CodProduto, Produto Descricao, LoteId, '+sLineBreak+
      '             DescrLote, Fabricacao, Vencimento, Qtde, EstoqueTipoId ' + sLineBreak +
      '      FROM vEstoque ' + sLineBreak +
      '      Where Qtde <> 0 And ' + sLineBreak +
      '        (@ProdutoId = 0 or ProdutoId = @ProdutoId) and ' + sLineBreak +
      '        (@LoteId = 0 or LoteId = @LoteId) and ' + sLineBreak +
      '        (@EnderecoId = 0 or EnderecoId = @EnderecoId) and ' + sLineBreak +
      '        (@ZonaId = 0 or ZonaId = @ZonaId) and ' + sLineBreak +
      '        (@EstoqueTipoId = 0  or EstoqueTipoId = @EstoqueTipoId) and ' + sLineBreak +
      '        (@Producao = 2 or Producao = @Producao) and ' + sLineBreak +
      '	       (@Distribuicao = 2 or Distribuicao = @Distribuicao) And ' + sLineBreak +
      '        (@Zerado<>' + #39 + 'N' + #39 + ' or Qtde<>0) and ' + sLineBreak +
      '        (@Negativo<>' + #39 + 'N' + #39 + ' or Qtde>0) '+sLineBreak+
      '      Union' + sLineBreak +
      '      SELECT Pl.IdProduto ProdutoId, Pl.CodProduto, Pl.Descricao, Pl.LoteId, Pl.Lote DescrLote, Pl.Data Fabricacao,' + sLineBreak +
      '             Pl.Vencimento, Qtde, 7 as EstoqueTipoId' + sLineBreak +
      '       FROM ReposicaoEstoqueTransferencia RET' + sLineBreak +
      '       Inner Join vProdutoLotes Pl on Pl.LoteId = RET.Loteid' + sLineBreak +
      '       Where Qtde <> 0 And' + sLineBreak +
      '             (@ProdutoId = 0 or IdProduto = @ProdutoId) and' + sLineBreak +
      '             (@LoteId = 0 or Ret.LoteId = @LoteId) and' + sLineBreak +
      '             (@EnderecoId = 0 or Pl.EnderecoId = @EnderecoId) and' + sLineBreak +
      '             (@ZonaId = 0 or ZonaId = @ZonaId) and' + sLineBreak +
      '             (@EstoqueTipoId in (0,4)) and' + sLineBreak +
      '             (@Producao = 2) and (@Distribuicao = 2) ) AS Tbl ' + sLineBreak +
      'PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6], [7])) AS Pvt ' + sLineBreak +
      'Left Join (select LoteId, Max(Data) Data' + sLineBreak +
      '           From (select Pc.LoteId, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoItensCheckIn Pc' + sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pc.Pedidoid' + sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      '                 Group by Pc.LoteId' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Vl.LoteId, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoVolumeLotes Vl' + sLineBreak +
      '                 Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId' + sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pv.Pedidoid' + sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      '                 Group by Vl.LoteId' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Ia.LoteId, Max(De.Data) Data' + sLineBreak +
      '                 from InventarioAjuste Ia' + sLineBreak +
      '                 Inner join Inventarios Inv On Inv.InventarioId = Ia.InventarioId' + sLineBreak +
      '                 Inner Join vDocumentoEtapas De ON De.Documento = Inv.uuid and De.ProcessoId = 26' + sLineBreak +
      '                 Group by Ia.LoteId) MovEst' + sLineBreak+
      '           Group by LoteId) Mov On Mov.LoteId = Pvt.LoteId' + sLineBreak +
      'Order by Vencimento';

  Const
    SqlGetEstoqueEnderecoPorTipo =
      'Declare @ProdutoId     Integer = :pProdutoId' + sLineBreak +
      'Declare @LoteId        Integer = :pLoteId' + sLineBreak +
      'Declare @EnderecoId    Integer = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Producao      Integer = :pProducao' + sLineBreak +
      'Declare @Distribuicao  Integer = :pDistribuicao' + sLineBreak +
      'Declare @Zerado        Char(1) = :pZerado' + sLineBreak +
      'Declare @Negativo      Char(1) = :pNegativo' + sLineBreak +
      'SELECT ProdutoId, CodigoERP, Produto, Picking, Endereco, ' + sLineBreak +
      '       Estrutura, LoteId, DescrLote, Fabricacao, Vencimento, Horario, Mascara,'
      + sLineBreak + '       Coalesce([1], 0) AS ' + #39 + 'Stage'#39 + ', ' +
      sLineBreak + '       Coalesce([2], 0) AS ' + #39 + 'Crossdocking'#39 +
      ', ' + sLineBreak + '       Coalesce([3], 0) AS ' + #39 + 'Segregado' +
      #39 + ', ' + sLineBreak + '       Coalesce([4], 0) AS ' + #39 + 'Producao'
      + #39 + ', ' + sLineBreak + '       Coalesce([5], 0) AS ' + #39 +
      'Expedicao' + #39 + ', ' + sLineBreak + '       Coalesce([6], 0) AS ' +
      #39 + 'Reserva' + #39 + ', ' + sLineBreak +
      '       (Case When (select Producao from EstoqueTipo where Id = 1) = 1 ' +
      sLineBreak +
      '             then Coalesce([1], 0) Else 0 End)+ --Coalesce([2], 0) + Coalesce([3], 0) +'
      + sLineBreak + '	      Coalesce([4], 0) - --Coalesce([5], 0) +' +
      sLineBreak + '	      Coalesce([6], 0) as Saldo --select 5 + -7 - 3' +
      sLineBreak + 'FROM' + sLineBreak +
      '(SELECT Prd.IdProduto ProdutoId, PRd.CodProduto CodigoERP, Prd.Descricao Produto,'
      + sLineBreak +
      '        Prd.Endereco Picking, vEnd.Endereco, vEnd.Estrutura, Est.LoteId, Prd.Lote DescrLote,'
      + sLineBreak +
      '		      Prd.Data Fabricacao, Prd.Vencimento, --CAST(CONVERT(DATETIME, CONVERT(CHAR(8), '
      + sLineBreak + '            --DE.Data, 112) + ' + #39 + ' ' + #39 +
      ' + CONVERT(CHAR(8), HE.Hora, 108)) AS DateTime)' + sLineBreak +
      '        Null AS Horario, Est.Qtde, Est.EstoqueTipoId, vEnd.Mascara' +
      sLineBreak + 'FROM Estoque Est' + sLineBreak +
      'Inner join EstoqueTipo ET On ET.Id = Est.EstoquetipoId' + sLineBreak +
      'Inner join VEnderecamentos vEnd ON vEnd.EnderecoId = Est.EnderecoId' +
      sLineBreak + 'Left Join vProdutoLotes PRd on Prd.LoteId = Est.LoteId' +
      sLineBreak +
      '--LEFT OUTER JOIN dbo.Rhema_Data AS DE ON DE.IdData = Est.DtInclusao' +
      sLineBreak +
      '--LEFT OUTER JOIN dbo.Rhema_Hora AS HE ON HE.IdHora = Est.HrInclusao' +
      sLineBreak + 'Where (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId) and' +
      sLineBreak + '         (@LoteId = 0 or Est.LoteId = @LoteId) and' +
      sLineBreak +
      '         (@EnderecoId = 0 or Est.EnderecoId = @EnderecoId) and' +
      sLineBreak +
      '     	   (@EstoqueTipoId = 0  or Est.EstoqueTipoId = @EstoqueTipoId) and'
      + sLineBreak + '         (@Producao = 2 or Et.Producao = @Producao) and' +
      sLineBreak +
      '         (@Distribuicao = 2 or vEnd.Distribuicao = @Distribuicao) and' +
      sLineBreak + '         (@Zerado<>' + #39 + 'N' + #39 +
      ' or Est.Qtde<>0) and' + sLineBreak + '         (@Negativo<>' + #39 + 'N'
      + #39 + ' or Qtde>0)' + sLineBreak + ') AS Tbl' + sLineBreak +
      'PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt'
      + sLineBreak + 'Order by Vencimento';

  Const
    SqlGetEstoqueEnderecoPorTipoOLD =
      'Declare @ProdutoId     Integer = :pProdutoId' + sLineBreak +
      'Declare @LoteId        Integer = :pLoteId' + sLineBreak +
      'Declare @EnderecoId    Integer = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Producao      Integer = :pProducao' + sLineBreak +
      'Declare @Distribuicao  Integer = :pDistribuicao' + sLineBreak +
      'Declare @Zerado        Char(1) = :pZerado' + sLineBreak +
      'Declare @Negativo      Char(1) = :pNegativo' + sLineBreak +
      'SELECT ProdutoId, CodigoERP, Produto, Picking, Endereco, Estrutura, LoteId, DescrLote, Fabricacao, Vencimento, Horario, Mascara,'
      + sLineBreak + '       Coalesce([1], 0) AS ' + #39 + 'Stage'#39 + ', ' +
      sLineBreak + '       Coalesce([2], 0) AS ' + #39 + 'Crossdocking'#39 +
      ', ' + sLineBreak + '       Coalesce([3], 0) AS ' + #39 + 'Segregado' +
      #39 + ', ' + sLineBreak + '       Coalesce([4], 0) AS ' + #39 + 'Producao'
      + #39 + ', ' + sLineBreak + '       Coalesce([5], 0) AS ' + #39 +
      'Expedicao' + #39 + ', ' + sLineBreak + '       Coalesce([6], 0) AS ' +
      #39 + 'Reserva' + #39 + ', ' + sLineBreak +
      '       Coalesce([1], 0) + Coalesce([2], 0) + Coalesce([3], 0) + Coalesce([4], 0) + Coalesce([5], 0) + Coalesce([6], 0) as Saldo '
      + sLineBreak + 'FROM' + sLineBreak +
      '(SELECT Est.ProdutoId, Est.CodigoERP, Est.Produto, Prd.EnderecoDescricao Picking, Est.Endereco, Est.Estrutura, Est.LoteId,'
      + sLineBreak +
      '        Est.DescrLote, Est.Fabricacao, Est.Vencimento, Est.Horario, Est.Qtde, Est.EstoqueTipoId, Est.Mascara'
      + sLineBreak + 'FROM vEstoque Est' + sLineBreak +
      'Left Join vProduto PRd on Prd.CodProduto = Est.CodigoERP' + sLineBreak +
      'Where --Est.Qtde <> 0 And' + sLineBreak +
      '      (@ProdutoId = 0 or Est.ProdutoId = @ProdutoId) and' + sLineBreak +
      '         (@LoteId = 0 or Est.LoteId = @LoteId) and' + sLineBreak +
      '         (@EnderecoId = 0 or Est.EnderecoId = @EnderecoId) and' +
      sLineBreak +
      '     	   (@EstoqueTipoId = 0  or Est.EstoqueTipoId = @EstoqueTipoId) and'
      + sLineBreak + '         (@Producao = 2 or Est.Producao = @Producao) and'
      + sLineBreak +
      '         (@Distribuicao = 2 or Est.Distribuicao = @Distribuicao) and' +
      sLineBreak + '         (@Zerado<>' + #39 + 'N' + #39 +
      ' or (Est.QtdeProducao<>0 or Est.QtdeReserva<>0)) and ' + sLineBreak +
      '         (@Negativo<>' + #39 + 'N' + #39 + ' or Qtde>0)' + sLineBreak +
      ') AS Tbl' + sLineBreak +
      'PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt'
      + sLineBreak + 'Order by Vencimento, Horario';

  Const
    SqlGetEstoqueSemPicking = 'Declare @ProdutoId     Integer = :pProdutoId' +
      sLineBreak + 'Declare @LoteId        Integer = :pLoteId' + sLineBreak +
      'Declare @EstruturaId   Integer = :pEstruturaId' + sLineBreak +
      'Declare @EnderecoId    Integer = :pEnderecoId' + sLineBreak +
      'Declare @ZonaId        Integer = :pZonaId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
    // 'Declare @Producao      Integer = :pProducao'+sLineBreak+
    // 'Declare @Distribuicao  Integer = :pDistribuicao'+sLineBreak+
    // 'Declare @Zerado        Char(1) = :pZerado'+sLineBreak+
    // 'Declare @Negativo      Char(1) = :pNegativo'+sLineBreak+
      'select ProdutoId, Codproduto, Descricao, Sum(Saldo) Saldo' + sLineBreak +
      'From (SELECT ProdutoId, CodigoERP Codproduto, Produto Descricao, Picking, Endereco, Estrutura, LoteId, DescrLote, Fabricacao, Vencimento, Horario, Mascara,'
      + sLineBreak + '       Coalesce([1], 0) AS ' + #39 + 'Stage'#39 + ', ' +
      sLineBreak + '       Coalesce([2], 0) AS ' + #39 + 'Crossdocking'#39 +
      ', ' + sLineBreak + '       Coalesce([3], 0) AS ' + #39 + 'Segregado' +
      #39 + ', ' + sLineBreak + '       Coalesce([4], 0) AS ' + #39 + 'Producao'
      + #39 + ', ' + sLineBreak + '       Coalesce([5], 0) AS ' + #39 +
      'Expedicao' + #39 + ', ' + sLineBreak + '       Coalesce([6], 0) AS ' +
      #39 + 'Reserva' + #39 + ', ' + sLineBreak +
      '       Coalesce([1], 0) + Coalesce([2], 0) + Coalesce([3], 0) + Coalesce([4], 0) + Coalesce([5], 0) + Coalesce([6], 0) as Saldo '
      + sLineBreak + 'FROM' + sLineBreak +
      '(SELECT Est.ProdutoId, Est.CodigoERP, Est.Produto, Prd.EnderecoDescricao Picking, Est.Endereco, Est.Estrutura, Est.LoteId,'
      + sLineBreak +
      '        Est.DescrLote, Est.Fabricacao, Est.Vencimento, Est.Horario, Est.Qtde, Est.EstoqueTipoId, Est.Mascara'
      + sLineBreak + 'FROM vEstoque Est' + sLineBreak +
      'Left Join vProduto PRd on Prd.CodProduto = Est.CodigoERP' + sLineBreak +
      'Where Est.Qtde <> 0 And' + sLineBreak +
      '      (@ProdutoId = 0 or Est.ProdutoId = @ProdutoId) and' + sLineBreak +
      '         (@LoteId = 0 or Est.LoteId = @LoteId) and' + sLineBreak +
      '         (@EnderecoId = 0 or Est.EnderecoId = @EnderecoId) and' +
      sLineBreak +
      '     	   (@EstoqueTipoId = 0  or Est.EstoqueTipoId = @EstoqueTipoId) and'
      + sLineBreak +
    // '         (@Producao = 2 or Est.Producao = @Producao) and'+sLineBreak+
    // '         (@Distribuicao = 2 or Est.Distribuicao = @Distribuicao) and'+sLineBreak+
    // '         (@Zerado<>'+#39+'N'+#39+' or Qtde<>0) and '+sLineBreak+
    // '         (@Negativo<>'+#39+'N'+#39+' or Qtde>0) and'+sLineBreak+
      '      (Prd.EnderecoId Is Null) and Prd.CodProduto Is Not Null' +
      sLineBreak + ') AS Tbl' + sLineBreak +
      'PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt) Prod'
      + sLineBreak + 'Group by ProdutoId, Codproduto, Descricao';

  Const
    SqlGetEstoqueEnderecoPorTipoDetalhesOLD =
      'Declare @EstoqueTipoId Integer = 0' + sLineBreak +
      'select EET.ProdutoId, Prd.CodProduto, Prd.Descricao, Prd.UnidadeSecundariaSigla, Prd.FatorConversao, '
      + sLineBreak +
      '       (Case When Prd.FatorConversao = 1 then Prd.UnidadeDescricao Else Prd.UnidadeSecundariaDescricao+'
      + #39 + ' c/' + #39 +
      '+Cast(FatorConversao As Char) End) Embalagem, EET.EnderecoId,' +
      sLineBreak + '       EET.Endereco, VE.Estrutura, VE.Zona,' + sLineBreak +
      '       EET.DescrLote, EET.Vencimento, EET.Producao, EET.QtdEspera, EET.QtdProducao, EET.Reserva, (EET.QtdEspera + EET.QtdProducao - EET.Reserva) Saldo, EET.QtdCrosDocking,'
      + sLineBreak +
      '       EET.Segregado, EET.Expedicao, Mov.Data DtUltimaMovimentacao' +
      sLineBreak +
      'From (SELECT        ProdutoId, EnderecoId, Endereco, DescrLote, Vencimento, Producao, TipoId, COALESCE ([1], 0) AS '
      + #39 + 'QtdEspera' + #39 + sLineBreak + ', COALESCE ([2], 0) AS ' + #39 +
      'QtdCrosDocking' + #39 + ', COALESCE ([3], 0) AS ' + #39 + 'Segregado' +
      #39 + ', COALESCE ([4], 0) AS ' + sLineBreak + #39 + 'QtdProducao' + #39 +
      ', COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 + ',' + sLineBreak +
      '                         COALESCE ([6], 0) AS ' + #39 + 'Reserva' + #39 +
      sLineBreak +
      'FROM            (SELECT        ProdutoId, EnderecoId, Endereco, DescrLote, Vencimento, Producao, Qtde, EstoqueTipoId, EstoqueTipoId As TipoId'
      + sLineBreak +
      '                 FROM vEstoque) AS Tbl PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt) As EET'
      + sLineBreak + 'Inner Join vProduto Prd On Prd.IdProduto = EET.ProdutoId'
      + sLineBreak +
      'Inner join vEnderecamentos VE On VE.EnderecoId = EET.EnderecoId' +
      sLineBreak + 'Left Join (select CodProduto, Max(Data) Data' + sLineBreak +
      '           From (select Pl.CodProduto, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoItensCheckIn Pc' + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Pc.LoteId' +
      sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pc.Pedidoid' +
      sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'
      + sLineBreak + '                 Group by Pl.CodProduto' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Pl.CodProduto, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoVolumeLotes Vl' + sLineBreak +
      '                 Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pv.Pedidoid' +
      sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'
      + sLineBreak + '                 Group by Pl.CodProduto' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Pl.CodProduto, Max(De.Data) Data' + sLineBreak +
      '                 from inventarioajuste Ia' + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Ia.LoteId' +
      sLineBreak +
      '                 Inner join Inventarios Inv On Inv.InventarioId = Ia.InventarioId'
      + sLineBreak +
      '                 Inner Join vDocumentoEtapas De ON De.Documento = Inv.uuid and De.ProcessoId = 26'
      + sLineBreak + '                 Group by Pl.CodProduto) MovEst' +
      sLineBreak +
      '           Group by CodProduto) Mov On Mov.CodProduto = Prd.CodProduto' +
      sLineBreak + 'Where 1 = 1';

  Const
    SqlGetEstoqueEnderecoPorTipoDetalhes = 'Declare @EstoqueTipoId Integer = :pEstoqueTipoId'+sLineBreak +
      'select EET.ProdutoId, Prd.CodProduto, Prd.Descricao, Prd.UnidadeSecundariaSigla,'+sLineBreak +
      '       Prd.FatorConversao, (Case When Prd.FatorConversao = 1 then Prd.UnidadeDescricao '+ sLineBreak +
      '                                 Else Prd.UnidadeSecundariaDescricao+'+#39+' c/'+#39+'+Cast(FatorConversao As Char) End) Embalagem,'+sLineBreak +
      '       EET.EnderecoId, Ve.Endereco, VE.Estrutura, VE.Zona, EET.DescrLote,'+sLineBreak+
      '       EET.Vencimento, 0 as Producao, EET.QtdeTransfPicking, EET.QtdEspera, EET.QtdProducao, EET.Reserva,'+sLineBreak +
      '       (EET.QtdEspera+EET.QtdProducao+EET.QtdeTransfPicking - EET.Reserva) Saldo, EET.QtdCrosDocking,'+sLineBreak +
      '       EET.Segregado, EET.Expedicao, Mov.Data DtUltimaMovimentacao' +sLineBreak +
      'From (SELECT ProdutoId, EnderecoId, --Endereco,'+sLineBreak +
      '             DescrLote, Vencimento, --Producao, --TipoId,' +sLineBreak +
      '             COALESCE ([1], 0) AS ' + #39 + 'QtdEspera' +#39 + ', ' + sLineBreak +
      '             COALESCE ([2], 0) AS ' + #39 + 'QtdCrosDocking' + #39 + ', ' + sLineBreak +
      '             COALESCE ([3], 0) AS ' + #39 + 'Segregado' + #39 + ', ' +sLineBreak +
      '             COALESCE ([4], 0) AS ' + #39 + 'QtdProducao' + #39 + ', ' + sLineBreak +
      '             COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 + ', ' + sLineBreak +
      '             COALESCE ([6], 0) AS ' + #39 + 'Reserva' + #39 +', '+ sLineBreak+
      '             COALESCE ([7], 0) AS ' + #39 + 'QtdeTransfPicking' + #39 + sLineBreak+
      '      FROM (SELECT ProdutoId, EnderecoId, ---Endereco,' + sLineBreak +
      '             						DescrLote, Rd.Data as Vencimento, --Producao,' + sLineBreak +
      '                   Qtde, EstoqueTipoId --, EstoqueTipoId As TipoId' + sLineBreak +
      '            FROM Estoque Est' + sLineBreak +
      '       				 Inner Join ProdutoLotes Pl ON Pl.LoteId = Est.LoteId' + sLineBreak +
      '            Left Join Rhema_Data Rd On Rd.IdData = Pl.Vencimento'+sLineBreak+
      '            Where (@EstoqueTipoId = 0) or (Est.EstoqueTipoId = @EstoqueTipoId)'+sLineBreak+
      '			         Union'+sLineBreak+
      '			         Select Pl.IdProduto ProdutoId, Pl.EnderecoId, Pl.Lote DescrLote, Pl.Vencimento, Ret.Qtde, 7 as EstoqueTipoId'+sLineBreak+
      '			         From ReposicaoEstoqueTransferencia RET'+sLineBreak+
      '			         Inner Join vProdutoLotes Pl On Pl.LoteId = RET.LoteId) AS Tbl' + sLineBreak +
      '    		      PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6], [7])) AS Pvt) As EET' + sLineBreak +
      'Inner Join vProduto Prd On Prd.IdProduto = EET.ProdutoId' + sLineBreak +
      'Inner join vEnderecamentos VE On VE.EnderecoId = EET.EnderecoId' + sLineBreak +
      'Left Join (select CodProduto, Max(Data) Data' + sLineBreak +
      '           From (select Pl.CodProduto, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoItensCheckIn Pc' + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Pc.LoteId' + sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pc.Pedidoid' + sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      '                 Group by Pl.CodProduto' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Pl.CodProduto, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoVolumeLotes Vl' + sLineBreak +
      '                 Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId' + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' + sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pv.Pedidoid' + sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      '                 Group by Pl.CodProduto' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Pl.CodProduto, Max(De.Data) Data' + sLineBreak +
      '                 from inventarioajuste Ia' + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Ia.LoteId' + sLineBreak +
      '                 Inner join Inventarios Inv On Inv.InventarioId = Ia.InventarioId' + sLineBreak +
      '                 Inner Join vDocumentoEtapas De ON De.Documento = Inv.uuid and De.ProcessoId = 26' + sLineBreak +
      '                 Group by Pl.CodProduto) MovEst' + sLineBreak +
      '           Group by CodProduto) Mov On Mov.CodProduto = Prd.CodProduto' + sLineBreak +
      'Where 1 = 1';

  Const SqlGetEstoqueEnderecoPorTipoDetalhesReserva = 'Declare @EstoqueTipoId Integer = 0' + sLineBreak +
      'select EET.ProdutoId, Prd.CodProduto, Prd.Descricao, Prd.UnidadeSecundariaSigla, Prd.FatorConversao, ' + sLineBreak +
      '       (Case When Prd.FatorConversao = 1 then Prd.UnidadeDescricao Else Prd.UnidadeSecundariaDescricao+' + #39 + ' c/' + #39 +sLineBreak+
      '+Cast(FatorConversao As Char) End) Embalagem, EET.EnderecoId,' + sLineBreak +
      '       EET.Endereco, VE.Estrutura, VE.Zona,' + sLineBreak +
      '       EET.DescrLote, EET.Vencimento, EET.Producao, EET.QtdEspera, EET.QtdProducao, EET.Reserva, '+sLineBreak+
      '       (EET.QtdEspera + EET.QtdProducao - EET.Reserva) Saldo, EET.QtdCrosDocking,' + sLineBreak +
      '       EET.Segregado, EET.Expedicao' + sLineBreak +
      'From (SELECT ProdutoId, EnderecoId, Endereco, DescrLote, Vencimento, Producao'+sLineBreak+
      '             , COALESCE ([1], 0) AS ' + #39 + 'QtdEspera' + #39 + sLineBreak +
      '             , COALESCE ([2], 0) AS ' + #39+'QtdCrosDocking' + #39 + sLineBreak+
      '             , COALESCE ([3], 0) AS ' + #39 + 'Segregado'+#39 +
      '             , COALESCE ([4], 0) AS ' + #39 + 'QtdProducao' + #39 +
      '             , COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 + sLineBreak +
      '             , COALESCE ([6], 0) AS ' + #39 + 'Reserva' + #39 + sLineBreak +
      '             , COALESCE ([7], 0) AS ' + #39 + 'QtdeTransfPicking' + #39 + sLineBreak +
      'FROM (SELECT ProdutoId, EnderecoId, Endereco, DescrLote, Vencimento, Producao, Qtde, EstoqueTipoId' + sLineBreak +
      '      FROM vEstoqueReserva) AS Tbl PIVOT (sum(Qtde) FOR EstoqueTipoId IN ([1], [2], [3], [4], [5], [6], [7])) AS Pvt) As EET'+sLineBreak +
      'Inner Join vProduto Prd On Prd.IdProduto = EET.ProdutoId'+ sLineBreak +
      'Inner join vEnderecamentos VE On VE.EnderecoId = EET.EnderecoId' +sLineBreak +
      'Where 1 = 1';

  Const
    SqlRelEstoqueSaldo = '--Inicio do C�digo Enviando pela Chamada' + sLineBreak
      + 'Left Join (select CodProduto, Max(Data) Data' + sLineBreak +
      '           From (select Pl.CodProduto, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoItensCheckIn Pc' + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Pc.LoteId' +
      sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pc.Pedidoid' +
      sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'
      + sLineBreak + '                 Group by Pl.CodProduto' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Pl.CodProduto, Max(Rd.Data) Data' + sLineBreak +
      '                 from PedidoVolumeLotes Vl' + sLineBreak +
      '                 Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '                 Inner join Pedido Ped On Ped.PedidoId = Pv.Pedidoid' +
      sLineBreak +
      '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'
      + sLineBreak + '                 Group by Pl.CodProduto' + sLineBreak +
      '                 Union' + sLineBreak +
      '                 select Pl.CodProduto, Max(De.Data) Data' + sLineBreak +
      '                 from inventarioajuste Ia' + sLineBreak +
      '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Ia.LoteId' +
      sLineBreak +
      '                 Inner join Inventarios Inv On Inv.InventarioId = Ia.InventarioId'
      + sLineBreak +
      '                 Inner Join vDocumentoEtapas De ON De.Documento = Inv.uuid and De.ProcessoId = 26'
      + sLineBreak + '                 Group by Pl.CodProduto) MovEst' +
      sLineBreak +
      '           Group by CodProduto) Mov On Mov.CodProduto = Est.CodProduto' +
      sLineBreak + 'Order by Descricao';

Const SqlRelEstoquePreOrVencido = 'Declare @CodProduto Integer   = :pCodProduto'+sLineBreak+
                                  'Declare @ZonaId Integer       = :pZonaId'+sLineBreak+
                                  'Declare @DataInicial DateTime = :pDataInicial'+sLineBreak+
                                  'Declare @DataFinal DateTime   = :pDataFinal'+sLineBreak+
                                  'Declare @PreVencido integer   = :pPreVencido'+sLineBreak+
                                  'Declare @Vencido Integer      = :pVencido'+sLineBreak+
                                  'Select Est.*, Mov.Data DtUltimaMovimentacao'+sLineBreak+
                                  'From (select CodigoERP CodProduto, Produto Descricao, Month(Vencimento) MesVencimento, year(Vencimento) AnoVencimento, SUM(Qtde) Saldo'+sLineBreak+
                                  '      from vEstoque'+sLineBreak+
                                  '      where EstoqueTipoId in (1, 4)'+sLineBreak+
                                  '	       And (@CodProduto = 0 or CodigoERP = @CodProduto)'+sLineBreak+
                                  '        And (@ZonaId= 0 or ZonaId = @ZonaId)'+sLineBreak+
                                  '		      And (@PreVencido = 0 or (Vencimento > GetDate() and Vencimento <= GetDate()+(Select MesesParaPreVencido*30 From Configuracao)))'+sLineBreak+
                                  '        And (@Vencido=0 or (Vencimento >= @DataInicial and Vencimento <= @DataFinal))'+sLineBreak+
                                  '      Group by CodigoERP, Produto, Month(Vencimento), year(Vencimento)) Est'+sLineBreak+
                                  '--Inicio do C�digo Enviando pela Chamada'+sLineBreak+
                                  'Left Join (select CodProduto, Max(Data) Data'+sLineBreak+
                                  '           From (select Pl.CodProduto, Max(Rd.Data) Data'+sLineBreak+
                                  '                 from PedidoItensCheckIn Pc'+sLineBreak+
                                  '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Pc.LoteId'+sLineBreak+
                                  '                 Inner join Pedido Ped On Ped.PedidoId = Pc.Pedidoid'+sLineBreak+
                                  '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'+sLineBreak+
                                  '                 Group by Pl.CodProduto'+sLineBreak+
                                  '                 Union'+sLineBreak+
                                  '                 select Pl.CodProduto, Max(Rd.Data) Data'+sLineBreak+
                                  '                 from PedidoVolumeLotes Vl'+sLineBreak+
                                  '                 Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak+
                                  '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId'+sLineBreak+
                                  '                 Inner join Pedido Ped On Ped.PedidoId = Pv.Pedidoid'+sLineBreak+
                                  '                 Inner Join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData'+sLineBreak+
                                  '                 Group by Pl.CodProduto'+sLineBreak+
                                  '                 Union'+sLineBreak+
                                  '                 select Pl.CodProduto, Max(De.Data) Data'+sLineBreak+
                                  '                 from inventarioajuste Ia'+sLineBreak+
                                  '                 Inner Join vProdutoLotes Pl On Pl.LoteId = Ia.LoteId'+sLineBreak+
                                  '                 Inner join Inventarios Inv On Inv.InventarioId = Ia.InventarioId'+sLineBreak+
                                  '                 Inner Join vDocumentoEtapas De ON De.Documento = Inv.uuid and De.ProcessoId = 26'+sLineBreak+
                                  '                 Group by Pl.CodProduto) MovEst'+sLineBreak+
                                  '           Group by CodProduto) Mov On Mov.CodProduto = Est.CodProduto'+sLineBreak+
                                  'Order by Descricao, AnoVencimento, MesVencimento';

// Insert And Update
  Const
    SqlEstoque = 'Declare @LoteId Integer        = :pLoteId' + sLineBreak +
      'Declare @EnderecoId Integer    = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Quantidade Integer    = :pQuantidade' + sLineBreak +
      'Declare @UsuarioId Integer     = :pUsuarioId' + sLineBreak +
      'If Exists (Select LoteId From Estoque Where LoteId = @LoteId and EnderecoId = @EnderecoId and EstoqueTipoId = @EstoqueTipoId) Begin'
      + sLineBreak + '   Update Estoque Set Qtde = Qtde + @Quantidade ' +
      sLineBreak + '        , UsuarioIdAlt = @UsuarioId' + sLineBreak +
      '      Where LoteId = @LoteId and EnderecoId = @EnderecoId and EstoqueTipoId = @EstoqueTipoId'
      + sLineBreak + 'End' + sLineBreak + 'Else' + sLineBreak +
      '   Insert Into Estoque Values (@LoteId, @EnderecoId, @EstoqueTipoId, @Quantidade, '
      + SqlDataAtual + ', ' + SqlHoraAtual + ', @UsuarioId, Null, Null, Null)';

  Const
    SqlReposicaoSalvarItemColetado =
      'Declare @LoteId Integer           = :pLoteId' + sLineBreak +
      'Declare @EnderecoId Integer       = :pEnderecoId' + sLineBreak +
      'Declare @ReposicaoId Integer      = :pReposicaoId' + sLineBreak +
      'Declare @EnderecoOrigemId Integer = :pEnderecoOrigemId' + sLineBreak +
      'Declare @EstoqueTipoId Integer    = :pEstoqueTipoId' + sLineBreak +
      'Declare @Quantidade Integer       = :pQuantidade' + sLineBreak +
      'Declare @UsuarioId Integer        = :pUsuarioId' + sLineBreak +
      'Declare @Terminal Varchar(50)     = :pTerminal' + sLineBreak +
      'If Exists (Select LoteId From ReposicaoEstoqueTransferencia ' +
      sLineBreak +
      '           Where LoteId = @LoteId and EnderecoId = @EnderecoId and EstoqueTipoId = @EstoqueTipoId'
      + sLineBreak +
      '             and EnderecoOrigemId = @EnderecoOrigemId and ReposicaoId = @ReposicaoId) Begin'
      + sLineBreak +
      '   Update ReposicaoEstoqueTransferencia Set Qtde = Qtde + @Quantidade ' +
      sLineBreak + '        , DtAlteracao = ' + SqlDataAtual +
      ', HrAlteracao = ' + SqlHoraAtual + sLineBreak +
      '        , UsuarioIdAlt = @UsuarioId' + sLineBreak +
      '   Where LoteId = @LoteId and EnderecoId = @EnderecoId and EstoqueTipoId = @EstoqueTipoId'
      + sLineBreak +
      '     and EnderecoOrigemId = @EnderecoOrigemId and ReposicaoId = @ReposicaoId'
      + sLineBreak + 'End' + sLineBreak + 'Else' + sLineBreak +
      '   Insert Into ReposicaoEstoqueTransferencia Values (' + sLineBreak +
      '          @LoteId, @EnderecoId, @EstoqueTipoId, @ReposicaoId, @EnderecoOrigemId, '
      + sLineBreak + '          @Quantidade, ' + SqlDataAtual + ', ' +
      SqlHoraAtual + ', @UsuarioId, Null, Null, Null)';

  Const
    SqlReposicaoEstoqueTransferencia =
      'Declare @LoteId Integer           = :pLoteId' + sLineBreak +
      'Declare @EnderecoId Integer       = :pEnderecoId' + sLineBreak +
      'Declare @ReposicaoId Integer      = :pReposicaoId' + sLineBreak +
      'Declare @EnderecoOrigemId Integer = :pEnderecoOrigemId' + sLineBreak +
      'Declare @EstoqueTipoId Integer    = :pEstoqueTipoId' + sLineBreak +
      'Declare @Quantidade Integer       = :pQuantidade' + sLineBreak +
      'Declare @UsuarioId Integer        = :pUsuarioId' + sLineBreak +
      'Declare @Terminal Varchar(50)     = :pTerminal' + sLineBreak +
      'If Exists (Select LoteId From ReposicaoEstoqueTransferencia ' +
      sLineBreak +
      '           Where LoteId = @LoteId and EnderecoId = @EnderecoId and EstoqueTipoId = @EstoqueTipoId'
      + sLineBreak +
      '             and EnderecoOrigemId = @EnderecoOrigemId and ReposicaoId = @ReposicaoId) Begin'
      + sLineBreak +
      '   Update ReposicaoEstoqueTransferencia Set Qtde = Qtde + @Quantidade ' +
      sLineBreak + '        , DtAlteracao = ' + SqlDataAtual +
      ', HrAlteracao = ' + SqlHoraAtual + sLineBreak +
      '        , UsuarioIdAlt = @UsuarioId' + sLineBreak +
      '   Where LoteId = @LoteId and EnderecoId = @EnderecoId and EstoqueTipoId = @EstoqueTipoId'
      + sLineBreak +
      '     and EnderecoOrigemId = @EnderecoOrigemId and ReposicaoId = @ReposicaoId'
      + sLineBreak + 'End' + sLineBreak + 'Else' + sLineBreak +
      '   Insert Into ReposicaoEstoqueTransferencia Values (' + sLineBreak +
      '          @LoteId, @EnderecoId, @EstoqueTipoId, @ReposicaoId, @EnderecoOrigemId, '
      + sLineBreak + '          @Quantidade, ' + SqlDataAtual + ', ' +
      SqlHoraAtual + ', @UsuarioId, Null, Null, Null)' + sLineBreak + '' +
      sLineBreak + 'Insert into ReposicaoEstoqueTransferenciaHistorico' +
      sLineBreak +
      '       values ((select Id From ReposicaoEstoqueTransferencia' +
      sLineBreak +
      '                Where LoteId = @LoteId and EnderecoId = @EnderecoId and EstoqueTipoId = @EstoqueTipoId'
      + sLineBreak +
      '                  and EnderecoOrigemId = @EnderecoOrigemId and ReposicaoId = @ReposicaoId),'
      + sLineBreak +
      '			            @LoteId, @EnderecoId, @ReposicaoId, @EnderecoOrigemId, @Quantidade*-1, @UsuarioId, @Terminal, getdate(), getdate(), getdate())';

  Const
    SqlKardexInsUpd = 'Declare @OperacaoTipoId Integer = :pOperacaoTipoId' +sLineBreak +
      'Declare @LoteId Integer                 = :pLoteId' + sLineBreak +
      'Declare @EnderecoId Integer             = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer          = :pEstoqueTipoId' + sLineBreak +
      'Declare @EstoqueTipoIdDestino Integer   = :pEstoqueTipoIdDestino' +sLineBreak +
      'Declare @Quantidade Integer             = :pQuantidade' + sLineBreak+
      'Declare @ObservacaoOrigem Varchar(200)  = :pObservacaoOrigem' +sLineBreak +
      'Declare @EnderecoIdDestino Integer      = :pEnderecoIdDestino' +sLineBreak +
      'Declare @ObservacaoDestino Varchar(200) = :pObservacaoDestino' +sLineBreak +
      'Declare @UsuarioId Integer              = :pUsuarioId' +sLineBreak +
      'Declare @NomeEstacao Varchar(40)        = :pNomeEstacao' +sLineBreak +
      'Declare @SaldoInicialOrigem  Integer    = :pEstoqueInicial '+ sLineBreak + // +@Quantidade
      'Declare @SaldoInicialDestino Integer    = (Case When @EnderecoIdDestino <> 0 then '+sLineBreak+
      '                                                  Coalesce((Select Qtde From Estoque '+sLineBreak+
      '                                                            Where LoteId=@LoteId and EnderecoId=@EnderecoIdDestino and EstoqueTipoId=@EstoqueTipoIdDestino), 0)-@Quantidade'+sLineBreak+
      '                                                Else 0 End)' + sLineBreak +
      'Insert Into Kardex (OperacaoTipoId,	LoteId,	EnderecoId,	EstoqueTipoId,	'+ sLineBreak +
      '                    Qtde, SaldoInicialOrigem, SaldoFinalOrigem, ObservacaoOrigem, ' + sLineBreak +
      '                    EnderecoIdDestino, SaldoInicialDestino,	SaldoFinalDestino,	' + sLineBreak +
      '                    ObservacaoDestino,	Data,	Hora,	UsuarioId, NomeEstacao) values (' + sLineBreak +
      '       @operacaoTipoId, @LoteId, (Case When @EnderecoId = 0 then Null Else @EnderecoId End), @EstoqueTipoId, @Quantidade, ' + sLineBreak +
      '       (Case When @OperacaoTipoId = 3 Then Null Else @SaldoInicialOrigem End), (Case When @OperacaoTipoId = 3 Then Null Else @SaldoInicialOrigem-@quantidade End), ' + sLineBreak + // Saldo Origem
      '       @ObservacaoOrigem, (Case When @EnderecoIdDestino = 0 Then Null Else @EnderecoIdDestino End), @SaldoInicialDestino, ' + sLineBreak +
      '       (Case When @EnderecoIdDestino = 0 then Null Else (@SaldoInicialDestino+@Quantidade) End), ' + sLineBreak +
      '       @ObservacaoDestino, '+SqlDataAtual+', '+SqlHoraAtual+', (Case When @UsuarioId = 0 Then Null Else @UsuarioId End), @NomeEstacao)';

Const SqlCancelarCubagemPedidoOLD = 'Declare @PedidoId Integer = :pPedido' +sLineBreak +
      ';With' + sLineBreak +
      'EstPedido as (select Pl.LoteId, Pl.EnderecoId, Pl.EstoqueTipoId, Sum(Pl.QtdSuprida) QtdSuprida'
      + sLineBreak + 'From PedidoVolumes PV' + sLineBreak +
      'Inner Join PedidoVolumeLotes PL On Pl.PedidoVolumeId = PV.PedidoVolumeId'
      + sLineBreak + 'where Pv.PedidoId = @PedidoId' + sLineBreak +
      'Group by Pl.LoteId, Pl.EnderecoId, Pl.EstoqueTipoId)' + sLineBreak + '  '
      + sLineBreak + 'Update Est Set Est.Qtde = Est.Qtde - Pv.QtdSuprida' +
      sLineBreak + 'From EstPedido PV' + sLineBreak +
      'Left Join Estoque Est On Est.LoteId = Pv.LoteId and ' + sLineBreak +
      '                         Est.EnderecoId = Pv.EnderecoId and' + sLineBreak
      + '                         Est.EstoqueTipoId = 6' + sLineBreak + '  ' +
      sLineBreak + 'delete From Estoque Where EstoqueTipoId = 6 And Qtde <= 0' +
      sLineBreak + '  ' + sLineBreak + 'Update  DE Set Status = 0' + sLineBreak
      + 'From Pedido P' + sLineBreak +
      'Inner Join DocumentoEtapas DE ON De.Documento = P.uuid' + sLineBreak +
      'Where P.PedidoId = @PedidoId and DE.Status = 1 and DE.ProcessoId in (2, 3, 21)'
      + sLineBreak + 'Delete from PedidoVolumes Where PedidoId = @PedidoId';

  Const
    SqlCancelarCubagemPedido = 'Declare @PedidoId Integer = :pPedido' +
      sLineBreak + ';With' + sLineBreak +
      'EstPedidoPulmao as (select Pl.LoteId, Pl.EnderecoId, Pl.EstoqueTipoId, Sum(Pl.QtdSuprida) QtdSuprida'
      + sLineBreak + 'From PedidoVolumes PV' + sLineBreak +
      'Inner Join PedidoVolumeLotes PL On Pl.PedidoVolumeId = PV.PedidoVolumeId'
      + sLineBreak +
      'Inner Join Enderecamentos TEnd On TEnd.EnderecoId = Pl.EnderecoId' +
      sLineBreak + 'where Pv.PedidoId = @PedidoId and TEnd.EstruturaId = 1' +
      sLineBreak + 'Group by Pl.LoteId, Pl.EnderecoId, Pl.EstoqueTipoId)' +
      sLineBreak + '   ' + sLineBreak +
      'Update Est Set Est.Qtde = Est.Qtde - Pv.QtdSuprida' + sLineBreak +
      'From EstPedidoPulmao PV' + sLineBreak +
      'Left Join Estoque Est On Est.LoteId = Pv.LoteId and Est.EnderecoId = Pv.EnderecoId and Est.EstoqueTipoId = 6'
      + sLineBreak + '   ' + sLineBreak + ';With' + sLineBreak +
      'EstPedidoPicking as (select Pl.LoteId, Pl.EnderecoId, Pl.EstoqueTipoId,'
      + sLineBreak +
      '                     (Sum(Pl.QtdSuprida)-Coalesce(Sum(Pr.Demanda), 0)) QtdSuprida'
      + sLineBreak + 'From PedidoVolumes PV' + sLineBreak +
      'Inner Join PedidoVolumeLotes PL On Pl.PedidoVolumeId = PV.PedidoVolumeId'
      + sLineBreak +
      'Inner Join Enderecamentos TEnd On TEnd.EnderecoId = Pl.EnderecoId' +
      sLineBreak +
      'Left join PedidoReposicao PR On Pr.PedidoId = @PedidoId and Pr.LoteId = Pl.LoteId'
      + sLineBreak + 'where Pv.PedidoId = @PedidoId and TEnd.EstruturaId = 2' +
      sLineBreak + 'Group by Pl.LoteId, Pl.EnderecoId, Pl.EstoqueTipoId)' +
      sLineBreak + '' + sLineBreak +
      'Update Est Set Est.Qtde = Est.Qtde - Pv.QtdSuprida' + sLineBreak +
      'From EstPedidoPicking PV' + sLineBreak +
      'Left Join Estoque Est On Est.LoteId = Pv.LoteId and Est.EnderecoId = Pv.EnderecoId and Est.EstoqueTipoId = 6'
      + sLineBreak + '' + sLineBreak + 'Update Est Set Qtde = Qtde - Pr.Demanda'
      + sLineBreak + 'From Estoque Est' + sLineBreak +
      'Inner Join (select Pr.Loteid, Pr.EnderecoId, Sum(Demanda) Demanda' +
      sLineBreak + 'From pedidoreposicao Pr' + sLineBreak +
      'Where Pr.PedidoId = @PedidoId' + sLineBreak +
      'Group by Pr.EnderecoId, Pr.LoteId) Pr on Pr.LoteId = Est.LoteId and Pr.EnderecoId = Est.EnderecoId'
      + sLineBreak + 'where Est.EstoqueTipoId = 6' + sLineBreak + '  ' +
      sLineBreak + 'delete From Estoque Where EstoqueTipoId = 6 And Qtde <= 0' +
      sLineBreak + '  ' + sLineBreak + 'Update  DE Set Status = 0' + sLineBreak
      + 'From Pedido P' + sLineBreak +
      'Inner Join DocumentoEtapas DE ON De.Documento = P.uuid' + sLineBreak +
      'Where P.PedidoId = @PedidoId and DE.Status = 1 and DE.ProcessoId in (2, 3, 21)'
      + sLineBreak + 'Delete from PedidoVolumes Where PedidoId = @PedidoId' +
      sLineBreak +
      'delete pedidoreposicao where PedidoId = @PedidoId and Status = 0';

  Const
    SqlDocumentoStatusAtual = 'Declare @Documento VarChar(36) = :pDocumento' +
      sLineBreak + 'select DE.*' + sLineBreak + 'From vDocumentoEtapas DE' +
      sLineBreak +
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = @Documento and Status = 1)'
      + sLineBreak + '      and   Documento =  @Documento';

  Const
    SqlVolumePrintTag = 'Declare @PedidoId Int  = :pPedidoId' + sLineBreak +
      'Declare @PedidoVolumeId Int = :pPedidoVolumeId' + sLineBreak +
      'Declare @Sequencia Int = :pSequencia' + sLineBreak +
      'Declare @Ordem Int = :pOrdem' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @PrintTag Integer  = :pPrintTag  -- 0 N�o impresso   1 Reimpresso   2 Todos'
      + sLineBreak +
      'Declare @Embalagem Integer = :pEmbalagem -- 0 Cxa Fechada    1 Fracioandos  2 Todos'
      + sLineBreak +
      'select Vlm.PedidoId, Vlm.PedidoVolumeId, (case When Vlm.EmbalagemId IS Null then'
      + sLineBreak + '             ' + #39 + 'Caixa Fechada' + #39 + ' else ' +
      #39 + 'Fracionado' + #39 + ' End) Embalagem,' + sLineBreak +
      '             VE.Identificacao, Vlm.Sequencia, De.ProcessoId, DE.Descricao as Processo, Ms.Rua,'
      + sLineBreak + '			 Ms.Rua, SUBSTRING(Ms.Endereco, 1, 2)+' + #39 + '.'
      + #39 + '+SUBSTRING(Ms.Endereco, 3, 2) PredioInicial, Ms.Zona' +
      sLineBreak + 'From PedidoVolumes Vlm' + sLineBreak +
      'Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId' +
      sLineBreak + 'Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' +
      sLineBreak +
      'Left Join (Select Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona, Min(Tend.Endereco) Endereco'
      + sLineBreak + '           From PedidoVolumeLotes VL' + sLineBreak +
      '           Inner Join vEnderecamentos Tend On Tend.EnderecoId = VL.EnderecoId'
      + sLineBreak +
      '		   Group by Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona) MS ON Ms.PedidoVolumeId = Vlm.PedidoVolumeId'
      + sLineBreak +
      '      Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak +
      '        And (@PedidoId = 0 or Vlm.PedidoId = @PedidoId) and (@PedidoVolumeId = 0 or Vlm.PedidoVolumeId = @PedidoVolumeId)'
      + sLineBreak +
      '        And (@ZonaId = 0 or (Exists (Select ZonaId From PedidoVolumeLotes VL'
      + sLineBreak +
      '                                     Inner join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId'
      + sLineBreak +
      '                                     Where ZonaID = @ZonaId and Vl.PedidoVolumeId = Vlm.PedidoVolumeid )))'
      + sLineBreak +
      '        And ((@PrintTag=2 and De.ProcessoId in (2,3)) or (@PrintTag=0 and De.ProcessoId=2) or '
      + sLineBreak +
      '			                   (@PrintTag=1 and De.ProcessoId=3))' + sLineBreak
      + '        And (@Embalagem=2 or (@Embalagem=0 and Vlm.EmbalagemId Is null) or'
      + sLineBreak +
      '			                   (@Embalagem=1 and Vlm.EmbalagemId Is Not Null))'
      + sLineBreak + 'Order By Case' + sLineBreak +
      '           when @Ordem = 0 then Vlm.Pedidoid' + sLineBreak +
      '           when @Ordem = 1 then SUBSTRING(Ms.Endereco, 1, 4)' +
      sLineBreak + '		 End,' + sLineBreak + '         Vlm.PedidoVolumeId';

Const SqlVolume = 'Declare @PedidoId Int  = :pPedidoId' + sLineBreak +
      'Declare @PedidoVolumeId Int = :pPedidoVolumeId' + sLineBreak +
      'Declare @Sequencia Int = :pSequencia' + sLineBreak +
      'Declare @Ordem Int = :pOrdem' + sLineBreak +
      'Declare @Embalagem Char(1) = :pEmbalagem' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Select (' + sLineBreak +
      'Select Pv.pedidoid, Pv.pedidovolumeid, Pv.volumetipo, Pv.embalagem, Pv.descricao, Pv.identificacao, ' + sLineBreak +
      '       Coalesce(Cast(tara as Numeric(10)), 0) tara, Pv.sequencia, Coalesce(Pv.volumecaixa, 0) volumecaixa, Pv.processoid, Pv.processo, Pv.usuarioid, Pv.usuario,'+ sLineBreak +
      '	      Pv.pedidoid ' + #39 + 'pedido.pedidoid' + #39 +
      '     , Pv.documentonr as ' + #39 + 'pedido.documentonr' + #39 + sLineBreak +
      '     , Pv.documentodata ' + #39 + 'pedido.documentodata' + #39 + ', ' +sLineBreak +
      '   	   Pv.pessoaid ' + #39 + 'destino.pessoaid' + #39 + ', Pv.razao ' + #39 + 'destino.razao' + #39 + ', ' + sLineBreak +
      '       Pv.Rotaid ' + #39 + 'rota.rotaid' + #39 + ', ' + sLineBreak +
      '	      Pv.rota ' + #39 + 'rota.rota' + #39 + ', Pv.ordem ' + #39 + 'rota.ordem' + #39 + sLineBreak +
      '     , VL.Demanda, VL.QtdSuprida' + sLineBreak +
      '     , Ms.Zona, Ms.RuaId, Ms.Rua, SUBSTRING(Ms.Endereco, 1, 2)+' + #39 + '.' + #39 + '+SUBSTRING(Ms.Endereco, 3, 2) PredioInicial' + sLineBreak +
      '     , Coalesce(Cc.CarregamentoId, 0) carregamentoid' + sLineBreak +
      'From (select Vlm.PedidoId, Vlm.PedidoVolumeId, Coalesce(Vlm.EmbalagemId, 0) VolumeTipo, (case When Vlm.EmbalagemId IS Null then' + sLineBreak +
      '             ' + #39 + 'Caixa Fechada' + #39 + ' else ' + #39 + 'Fracionado' + #39 + ' End) Embalagem,' + sLineBreak +
      '             VE.Descricao, VE.Identificacao, VE.Tara,' + sLineBreak +
      '   	         Vlm.Sequencia, Vlm.CaixaEmbalagemId VolumeCaixa,' + sLineBreak +
      '             DE.ProcessoId, DE.Descricao as Processo, De.UsuarioId, U.Nome Usuario'+ sLineBreak +
      '           , PEd.DocumentoNr, Rd.Data As DocumentoData' + sLineBreak +
      '           , P.PessoaId, P.Razao' + sLineBreak +
      '	          , Rp.Rotaid, R.Descricao Rota, Rp.Ordem' + sLineBreak +
      '      From PedidoVolumes Vlm' + sLineBreak +
      '      Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId' + sLineBreak +
      '      Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' + sLineBreak +
      '      Inner join Pedido Ped ON Ped.PedidoId = Vlm.PedidoId' + sLineBreak +
      '      Inner join Rhema_Data RD on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      '      Inner join Pessoa P On P.Pessoaid = Ped.PessoaId ' + sLineBreak +
      '      Inner Join RotaPessoas Rp On Rp.PessoaId = P.PessoaId' + sLineBreak +
      '      Inner Join Rotas R On R.RotaId = Rp.RotaId' +sLineBreak +
      '      Inner Join Usuarios U On U.UsuarioId = De.UsuarioId' + sLineBreak +
      '      Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'+ sLineBreak +
      '            and (@PedidoId = 0 or Vlm.PedidoId = @PedidoId) and (@PedidoVolumeId = 0 or Vlm.PedidoVolumeId = @PedidoVolumeId)'+ sLineBreak +
      '            and (@Embalagem = ' + #39 + 'T' + #39 + ' or (@Embalagem = ' + #39 + 'F' + #39 + ' and Vlm.EmbalagemId Is Not Null) or ' + sLineBreak +
      '                (@Embalagem=' + #39 + 'B' + #39 + ' and Vlm.EmbalagemId Is Null)) ' + sLineBreak +
      '            And (@ZonaId = 0 or (Exists (Select ZonaId From PedidoVolumeLotes VL'+ sLineBreak +
      '                                         Inner Join vProdutoLotes Pl on Pl.LoteId = VL.LoteId' + sLineBreak +
      '                                         Where ZonaID = @ZonaId and Vl.PedidoVolumeId = Vlm.PedidoVolumeid ))) ) as PV' + sLineBreak +
      'Left join (Select PedidoVolumeId, SUM(Quantidade) Demanda, SUM(QtdSuprida) QtdSuprida' + sLineBreak +
      '           From PedidoVolumeLotes' + sLineBreak +
      '		   Group By PedidoVolumeId) VL On Vl.PedidoVolumeId = Pv.PedidoVolumeId' + sLineBreak +
      'Left Join (Select Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona, Min(Tend.Endereco) Endereco' + sLineBreak + // Corrigir essa rotira e quebrar volume por zona
      '           From PedidoVolumeLotes VL' + sLineBreak +
      '           Inner Join vEnderecamentos Tend On Tend.EnderecoId = VL.EnderecoId' + sLineBreak +
      '		   Group by Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona) MS ON Ms.PedidoVolumeId = Vl.PedidoVolumeId--Mapa Separacao' + sLineBreak +
      'Left Join CargaCarregamento Cc On Cc.PedidoVOlumeId = Pv.PedidoVolumeId' + sLineBreak +
      'Order By Case' + sLineBreak +
      '           when @Ordem = 0 then Pv.Pedidoid   --+ProcessoId Desc' + sLineBreak +
      '           when @Ordem = 1 then SUBSTRING(Ms.Endereco, 1, 4)' +sLineBreak +
      '		 End,' + sLineBreak + '		 Case' + sLineBreak +
      '           when @Ordem = 0 then Vl.PedidoVolumeId' + sLineBreak +
      '		 End' + sLineBreak +
      'For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno';

Const SqlVolumeRegistrarExpedicao = 'Declare @PedidoVolumeId Int = :pPedidoVolumeId' + sLineBreak +
      'Select Vlm.PedidoId, Vlm.PedidoVolumeId, iif(Vlm.EmbalagemId IS Null, ' + #39 + 'Caixa Fechada' + #39 + ', ' + #39 + 'Fracionado' + #39 + ') Embalagem,' + sLineBreak +
      '       DE.ProcessoId, DE.Descricao as Processo, PEd.DocumentoData, Ped.CodPessoaERP, Ped.Fantasia, Ped.Rotaid, Ped.Rota' + sLineBreak +
      'From PedidoVolumes Vlm' + sLineBreak +
      'Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' + sLineBreak +
      'Inner join vPedidos Ped ON Ped.PedidoId = Vlm.PedidoId' + sLineBreak +
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)' + sLineBreak +
      '  And Vlm.PedidoVolumeId = @PedidoVolumeId';

  Const
    SqlGetVolumeConsulta = 'Declare @Datainicial DateTime    = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal DateTime      = :pDataFinal' + sLineBreak
      + 'Declare @PedidoId Int            = :pPedidoId' + sLineBreak +
      'Declare @PedidoVolumeId Int      = :pPedidoVolumeId' + sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @Sequencia Int           = :pSequencia' + sLineBreak +
      'Declare @CodPessoa int           = :pCodPessoa' + sLineBreak +
      'Declare @ProcessoId Int          = :pProcessoid' + sLineBreak +
      'Declare @Rotaid Int              = :pRotaId' + sLineBreak +
      'Declare @CodProduto int          = :pCodProduto' + sLineBreak +
      'Declare @Ordem Int               = :pOrdem' + sLineBreak +
      'Declare @Embalagem Char(1)       = :pEmbalagem' + sLineBreak +
    // <T>odos <F>racionado <B>ox Cxa Fechada
      'Declare @ZonaId Integer          = :pZonaId' + sLineBreak +

      'select Vlm.PedidoId, Vlm.PedidoVolumeId, Coalesce(Vlm.EmbalagemId, 0) VolumeTipo, (case When Vlm.EmbalagemId IS Null then'+sLineBreak+
      '             '+#39+'Caixa Fechada'+#39+' else '+#39+'Fracionado'+#39+' End) Embalagem,'+sLineBreak+
      '             VE.Descricao, VE.Identificacao, VE.Tara, Vlm.Sequencia, Coalesce(Vlm.CaixaEmbalagemId, 0) VolumeCaixa,'+sLineBreak+
      '             DE.ProcessoId, DE.Descricao as Processo, De.UsuarioId, U.Nome Usuario'+sLineBreak+
      '           , PEd.DocumentoNr, Ped.DocumentoData, Ped.CodPessoaERP, Ped.Razao, Ped.Rotaid, Ped.Rota--, Rp.Ordem'+sLineBreak+
      'Into #Volumes'+sLineBreak+
      'From PedidoVolumes Vlm'+sLineBreak+
      'Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId'+sLineBreak+
      'Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid'+sLineBreak+
      'Inner join vPedidos Ped ON Ped.PedidoId = Vlm.PedidoId'+sLineBreak+
      'Inner Join Usuarios U On U.UsuarioId = De.UsuarioId'+sLineBreak+
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'+sLineBreak+
      '  and (@PedidoId = 0 or Vlm.PedidoId = @PedidoId)'+sLineBreak+
      '  and (@PedidoVolumeId = 0 or Vlm.PedidoVolumeId = @PedidoVolumeId)'+sLineBreak+
      '  and (@Embalagem = '+#39+'T'+#39+' or (@Embalagem = '+#39+'F'+#39+' and Vlm.EmbalagemId Is Not Null) or (@Embalagem='#39_'B'+#39+' and Vlm.EmbalagemId Is Null))'+sLineBreak+
      '  And (@ZonaId = 0 or (Exists (Select ZonaId From PedidoVolumeLotes VL'+sLineBreak+
      '						                         Inner Join vProdutoLotes Pl on Pl.LoteId = VL.LoteId'+sLineBreak+
      '						                          Where ZonaID = @ZonaId and Vl.PedidoVolumeId = Vlm.PedidoVolumeid )))'+sLineBreak+
      '  And (@DataInicial = 0 or Ped.DocumentoData >= @DataInicial)'+sLineBreak+
      '  And (@DataFinal = 0 or Ped.DocumentoData <= @DataFinal)'+sLineBreak+
      '  And (@DocumentoNr = '+#39+#39+' or Ped.DocumentoNr = @DocumentoNr)'+sLineBreak+
      '  And (@Sequencia = 0 or Vlm.Sequencia = @Sequencia)'+sLineBreak+
      '  And (@CodPessoa = 0 Or ped.CodPessoaERP = @CodPessoa)'+sLineBreak+
      '  And (@ProcessoId = 0 or De.ProcessoId = @ProcessoId)'+sLineBreak+
      '  And (@Rotaid = 0 or Ped.RotaId = @RotaId)'+sLineBreak+
      '  And (@CodProduto = 0 or (@CodProduto <> 0 and Exists (Select CodProduto From PedidoVolumeLotes Vl'+sLineBreak+
      '                                         Inner join vProdutolotes Pl On Pl.Loteid=Vl.LoteId'+sLineBreak+
      '					                                    Where Vl.PedidoVOlumeid = Vlm.PedidoVolumeId and Pl.CodProduto = @CodProduto)))'+sLineBreak+
      ''+sLineBreak+
      'Select Pv.PedidoVolumeId, SUM(Quantidade) Demanda, SUM(QtdSuprida) QtdSuprida'+sLineBreak+
      'Into #VolumeLotes'+sLineBreak+
      'From PedidoVolumeLotes Vl'+sLineBreak+
      'Inner join #Volumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak+
      'Group By Pv.PedidoVolumeId'+sLineBreak+
      ''+sLineBreak+
      'Select Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona, Min(Tend.Endereco) Endereco'+sLineBreak+
      'Into #MS'+sLineBreak+
      'From PedidoVolumeLotes VL'+sLineBreak+
      'Inner join #Volumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak+
      'Inner Join vEnderecamentos Tend On Tend.EnderecoId = VL.EnderecoId'+sLineBreak+
      'Group by Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona'+sLineBreak+
      ''+sLineBreak+
      'Select Cc.PedidoVOlumeId, Cc.cargaid'+sLineBreak+
      'Into #Carregamento'+sLineBreak+
      'From CargaCarregamento Cc'+sLineBreak+
      'Inner join #Volumes Pv On Pv.PedidoVolumeId = Cc.PedidoVolumeId'+sLineBreak+
      ''+sLineBreak+
      'Select Pv.PedidoId, Pv.PedidoVolumeId, Pv.VolumeTipo, Pv.Embalagem, Pv.Descricao, Pv.Identificacao, Pv.Tara, Pv.Sequencia, Pv.VolumeCaixa,'+sLineBreak+
      '      Pv.ProcessoId, Pv.Processo, Pv.UsuarioId, Pv.Usuario, Pv.DocumentoNr, Pv.DocumentoData, Pv.CodPessoaERP, Pv.Razao, Pv.Rotaid, Pv.Rota,'+sLineBreak+
      '       VL.Demanda, VL.QtdSuprida, Ms.Zona, Ms.RuaId, Ms.Rua, SUBSTRING(Ms.Endereco, 1, 2)+'+#39+'.'+#39+'+SUBSTRING(Ms.Endereco, 3, 2) PredioInicial, IsNull(Cc.CargaId, 0) CargaId'+sLineBreak+
      'From #Volumes Pv'+sLineBreak+
      'Left Join #VolumeLotes Vl On Vl.PedidoVOlumeId = PV.PedidoVOlumeId'+sLineBreak+
      'Left join #MS MS On MS.PedidoVOlumeId = Pv.PedidoVOlumeId'+sLineBreak+
      'Left join #Carregamento Cc On Cc.cargaid = Pv.PedidoVolumeId'+sLineBreak+
      'Order By Case'+sLineBreak+
      '           when @Ordem = 0 then Pv.Pedidoid'+sLineBreak+
      '           when @Ordem = 1 then (SUBSTRING(Ms.Endereco, 1, 2)+SUBSTRING(Ms.Endereco, 3, 2))'+sLineBreak+
      '		 End,'+sLineBreak+
      '		 Case'+sLineBreak+
      '           when @Ordem = 0 then Pv.PedidoVolumeId'+sLineBreak+
      '		 End';

{      'Select Pv.*, VL.Demanda, VL.QtdSuprida' + sLineBreak +
      '       , Ms.Zona, Ms.RuaId, Ms.Rua, SUBSTRING(Ms.Endereco, 1, 2)+' + #39
      + '.' + #39 + '+SUBSTRING(Ms.Endereco, 3, 2) PredioInicial' + sLineBreak +
      '       , Coalesce(Cc.CargaId, 0) CargaId' + sLineBreak +
      'From (select Vlm.PedidoId, Vlm.PedidoVolumeId, Coalesce(Vlm.EmbalagemId, 0) VolumeTipo, (case When Vlm.EmbalagemId IS Null then'
      + sLineBreak + '             ' + #39 + 'Caixa Fechada' + #39 + ' else ' +
      #39 + 'Fracionado' + #39 + ' End) Embalagem,' + sLineBreak +
      '             VE.Descricao, VE.Identificacao, VE.Tara, Vlm.Sequencia, Coalesce(Vlm.CaixaEmbalagemId, 0) VolumeCaixa,'
      + sLineBreak +
      '             DE.ProcessoId, DE.Descricao as Processo, De.UsuarioId, U.Nome Usuario'
      + sLineBreak +
      '           , PEd.DocumentoNr, Ped.DocumentoData, Ped.CodPessoaERP, Ped.Razao, Ped.Rotaid, Ped.Rota--, Rp.Ordem'
      + sLineBreak + '      From PedidoVolumes Vlm' + sLineBreak +
      '      Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId' +
      sLineBreak +
      '      Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' +
      sLineBreak +
      '	     Inner join vPedidos Ped ON Ped.PedidoId = Vlm.PedidoId' +
      sLineBreak + '      Inner Join Usuarios U On U.UsuarioId = De.UsuarioId' +
      sLineBreak +
      '	     Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak + '		      and (@PedidoId = 0 or Vlm.PedidoId = @PedidoId)'
      + sLineBreak +
      '		      and (@PedidoVolumeId = 0 or Vlm.PedidoVolumeId = @PedidoVolumeId)'
      + sLineBreak + '		      and (@Embalagem = ' + #39 + 'T' + #39 +
      ' or (@Embalagem = ' + #39 + 'F' + #39 +
      ' and Vlm.EmbalagemId Is Not Null) or (@Embalagem=' + #39 + 'B' + #39 +
      ' and Vlm.EmbalagemId Is Null))' + sLineBreak +
      '		      And (@ZonaId = 0 or (Exists (Select ZonaId From PedidoVolumeLotes VL'
      + sLineBreak +
      '												                         Inner Join vProdutoLotes Pl on Pl.LoteId = VL.LoteId'
      + sLineBreak +
      '												                          Where ZonaID = @ZonaId and Vl.PedidoVolumeId = Vlm.PedidoVolumeid )))'
      + sLineBreak +
      '		      And (@DataInicial = 0 or Ped.DocumentoData >= @DataInicial)' +
      sLineBreak +
      '		      And (@DataFinal = 0 or Ped.DocumentoData <= @DataFinal)' +
      sLineBreak + '        And (@DocumentoNr = ' + #39 + #39 +
      ' or Ped.DocumentoNr = @DocumentoNr)' + sLineBreak +
      '        And (@Sequencia = 0 or Vlm.Sequencia = @Sequencia)' + sLineBreak
      + '        And (@CodPessoa = 0 Or ped.CodPessoaERP = @CodPessoa)' +
      sLineBreak +
      '        And (@ProcessoId = 0 or De.ProcessoId = @ProcessoId)' +
      sLineBreak + '        And (@Rotaid = 0 or Ped.RotaId = @RotaId)' +
      sLineBreak +
      '        And (@CodProduto = 0 or (@CodProduto <> 0 and Exists (Select CodProduto From PedidoVolumeLotes Vl'
      + sLineBreak +
      '		                                             Inner join vProdutolotes Pl On Pl.Loteid=Vl.LoteId'
      + sLineBreak +
      '											                                    Where Vl.PedidoVOlumeid = Vlm.PedidoVolumeId and Pl.CodProduto = @CodProduto)))	) as PV'
      + sLineBreak +
      '		Left join (Select PedidoVolumeId, SUM(Quantidade) Demanda, SUM(QtdSuprida) QtdSuprida'
      + sLineBreak + '				   From PedidoVolumeLotes' + sLineBreak +
      '				   Group By PedidoVolumeId) VL On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      '		Left Join (Select Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona, Min(Tend.Endereco) Endereco'
      + sLineBreak + '				   From PedidoVolumeLotes VL' + sLineBreak +
      '				   Inner Join vEnderecamentos Tend On Tend.EnderecoId = VL.EnderecoId'
      + sLineBreak +
      '				   Group by Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona) MS ON Ms.PedidoVolumeId = Vl.PedidoVolumeId--Mapa Separacao'
      + sLineBreak +
      'Left Join CargaCarregamento Cc On Cc.PedidoVOlumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Order By Case' + sLineBreak +
      '           when @Ordem = 0 then Pv.Pedidoid   --+ProcessoId Desc' +
      sLineBreak +
      '           when @Ordem = 1 then SUBSTRING(Ms.Endereco, 1, 4)' +
      sLineBreak + '		 End,' + sLineBreak + '		 Case' + sLineBreak +
      '           when @Ordem = 0 then Vl.PedidoVolumeId' + sLineBreak
      + '		 End';
}
  Const
    SqlAuditoriaVolumes = 'Declare @DtInicio DateTime = :pDtInicio' + sLineBreak
      + 'Declare @DtFInal  DateTime = :pDtFinal' + sLineBreak +
      'Declare @PedidoId Integer  = :pPedidoId' + sLineBreak +
      'Declare @DocumentoNr Varchar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @RotaId Integer          = :pRotaId' + sLineBreak +
      'Declare @PessoaId Integer        = Coalesce((Select PessoaId From Pessoa Where CodPessoaERP = :pCodPessoaErp and PessoaTipoId = 1), 0)'
      + sLineBreak + 'Declare @ProcessoId Integer      = :pProcessoId' +
      sLineBreak + 'Declare @CodProduto Integer      = :pCodProduto' +
      sLineBreak + 'Declare @LinhaId Integer         = :pLinhaId' + sLineBreak +
      'Declare @ZonaId Integer          = :pZonaId' + sLineBreak +
      'Declare @TipoVolume Integer      = :pTipoVolume -- 0-Todos 1-Cxa.Fechada 2-Fracionados 3-Extra'
      + sLineBreak + 'Declare @UsuarioId Integer       = :pUsuarioId' +
      sLineBreak +
      'Declare @IdentificacaoCaixa Integer = (Select IdentCaixaApanhe From Configuracao)'
      + sLineBreak +
      'select Ped.PedidoId, Ped.DocumentoData Data, Ped.DocumentoNr, Pv.PedidoVolumeId, Pv.Sequencia,'
      + sLineBreak + '       (Case When Pv.EmbalagemId Is Null then ' + #39 +
      'Cxa.Fechada' + #39 + ' Else ' + #39 + 'Fracionados' + #39 +
      ' End) Embalagem,' + sLineBreak +
      '       (Case When (Pv.EmbalagemId Is Not Null) and (@IdentificacaoCaixa = 1) and (Pv.CaixaEmbalagemId Is Null) then 1 Else 0 End) Papelao,'
      + sLineBreak +
      '   	   Pv.Tipo, CaixaEmbalagemId, De.ProcessoId, De.Descricao Processo,'
      + sLineBreak +
      '	      Ped.CodPessoaERP, Ped.Razao, Ped.Fantasia, Ped.Rotaid, Ped.Rota' +
      sLineBreak + '       , VE.UsuarioId, VE.Usuario' + sLineBreak +
      'from PedidoVolumes Pv' + sLineBreak +
      'Inner Join vPedidos Ped On Ped.PedidoId = Pv.PedidoId' + sLineBreak +
      'Inner Join vDocumentoEtapas De On De.Documento = Pv.Uuid' + sLineBreak +
      'Left Join (Select Documento, De.UsuarioId, U.nome Usuario' + sLineBreak +
      '           From DocumentoEtapas De' + sLineBreak +
      '		   Inner Join usuarios U On U.usuarioid = De.UsuarioId' + sLineBreak
      + '		   Where De.ProcessoId = 2 and De.Status = 1) VE On VE.Documento = Pv.Uuid and Pv.Tipo = '
      + #39 + 'E' + #39 + sLineBreak + 'Inner Join (Select Vl.PedidoVolumeid' +
      sLineBreak + '            From PedidoVolumeLotes Vl' + sLineBreak +
      '			         Inner join vProdutoLotes Pl On Pl.LoteId = Vl.Loteid' +
      sLineBreak + '			         Where (@ZonaId = 0 or (@ZonaId = Pl.ZonaId))'
      + sLineBreak +
      '              and (@CodProduto = 0 or @CodProduto = Pl.CodProduto)' +
      sLineBreak +
      '            Group by vl.PedidoVOlumeId) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '   And (@TipoVolume = 0 or (@TipoVolume=1 and Pv.EmbalagemId Is Null) or'
      + sLineBreak + '       (@TipoVolume=2 and Pv.EmbalagemId Is Not Null) or'
      + sLineBreak + '	      (@TipoVolume=3 and Pv.Tipo = ' + #39 + 'E' + #39 +
      '))' + sLineBreak + '	  And (@PedidoId = 0 or @PedidoId = Ped.PedidoId)' +
      sLineBreak + '	  And (@DocumentoNr = ' + #39 + #39 +
      ' or @DocumentoNr = Ped.DocumentoNr)' + sLineBreak +
      '   And (@DtInicio=0 Or Ped.DocumentoData >= @DtInicio)' + sLineBreak +
      '	  And (@DtFinal=0 Or Ped.DocumentoData <= @DtFinal)' + sLineBreak +
      '	  And (@RotaId = 0 Or @RotaId = Ped.RotaId)' + sLineBreak +
      '	  And (@PessoaId = 0 or @PessoaId = Ped.PessoaId)' + sLineBreak +
      '	  And (@ProcessoId = 0 or @ProcessoId = De.ProcessoId)' + sLineBreak +
      '   --And (@LinhaId = 0 or @LinhaId = Pt.Id)' + sLineBreak +
      '   And (@UsuarioId = 0 or @UsuarioId = VE.UsuarioId)' + sLineBreak +
      'Order By Ped.DocumentoData, Pv.EmbalagemId, Pv.PedidoVolumeId--, Pes.Razao';

  Const
    SqlVolumeEmExpedicao =
      'select Vlm.PedidoId, Vlm.PedidoVolumeId, Vlm.EmbalagemId VolumeTipo, ' +
      sLineBreak + '       (case When Vlm.EmbalagemId IS Null then ' +
      sLineBreak + '               ' + #39 + 'Caixa Fechada' + #39 + sLineBreak
      + '             else ' + #39 + 'Fracionado' + #39 + sLineBreak +
      '        End) Embalagem,' + sLineBreak +
      '   	   DE.Descricao as Processo, P.PessoaId, P.Razao, R.Descricao, Rd.Data, Rp.RotaId'
      + sLineBreak + 'From PedidoVolumes Vlm' + sLineBreak +
      '     Inner Join Pedido Ped On Ped.PedidoId = Vlm.PedidoId' + sLineBreak +
      '     Inner Join Pessoa P On P.PessoaId = Ped.Pessoaid' + sLineBreak +
      '     Left Join RotaPessoas Rp On Rp.PessoaId = P.PessoaId' + sLineBreak +
      '     Left Join Rotas R On R.RotaId = Rp.Rotaid' + sLineBreak +
      '     Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId' +
      sLineBreak +
      '     Left Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      '     Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' +
      sLineBreak +
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak + '      and De.ProcessoId in (10, 12)'; // (8, 10, 24)';

  Const
    SqlVolumemExpedido =
      'select Vlm.PedidoId, Vlm.PedidoVolumeId, Vlm.EmbalagemId VolumeTipo, ' +
      sLineBreak + '       (case When Vlm.EmbalagemId IS Null then ' +
      sLineBreak + '               ' + #39 + 'Caixa Fechada' + #39 + sLineBreak
      + '             else ' + #39 + 'Fracionado' + #39 + sLineBreak +
      '        End) Embalagem,' + sLineBreak +
      '   	   DE.Descricao as Processo, P.PessoaId, P.Razao, R.Descricao' +
      sLineBreak + 'From PedidoVolumes Vlm' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Vlm.PedidoId' + sLineBreak +
      'Inner Join Pessoa P On P.PessoaId = Ped.Pessoaid' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.PessoaId = P.PessoaId' + sLineBreak +
      'Left Join Rotas R On R.RotaId = Rp.Rotaid' + sLineBreak +
      'Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId' +
      sLineBreak + 'Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' +
      sLineBreak +
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak + '      and De.ProcessoId in (11, 12)';

  Const SqlGetOpenVolumeParaSeparacao =
    // 'Declare @CaixaId Integer = :pCaixaId'+sLineBreak+
      'Declare @PedidoVolumeId Int = :pPedidoVolumeid' + sLineBreak +
      'Declare @UsuarioId Integer = :pUsuarioid' + sLineBreak + '' + sLineBreak
      + 'Select Ped.Pedidoid, Ped.Fantasia, Ped.DocumentoData, Ped.RotaId, Ped.Rota, Pv.PedidoVolumeId, Coalesce(Pv.EmbalagemId, 0) VolumeTipo,'
      + sLineBreak + '      (case When Pv.EmbalagemId IS Null then ' + #39 +
      'Caixa Fechada' + #39 + ' else ' + #39 + 'Fracionado' + #39 +
      ' End) Embalagem,' + sLineBreak +
      '       PV.Sequencia, Vz.ZonaId, Vz.Zona, PVS.VolumeSeparacaoId, PVS.CaixaEmbalagemId, Coalesce(PVS.Operacao, 0) Operacao, Coalesce(PVS.EnderecoId, 0) EnderecoIdSeparacao,'
      + sLineBreak + '	   Coalesce(PVS.Usuarioid, 0) UsuarioIdSeparacao,' +
      sLineBreak + '	   De.ProcessoId, De.Descricao Processo' + sLineBreak +
      'From PedidoVolumes Pv' + sLineBreak +
      'Inner join vDocumentoEtapas DE On De.Documento = Pv.Uuid' + sLineBreak +
      'Inner join vPedidos Ped ON Ped.PedidoId = Pv.PedidoId' + sLineBreak +
      'Inner Join Usuarios U On U.UsuarioId = De.UsuarioId' + sLineBreak +
      'Left Join PedidoVolumeSeparacao PVS on PVS.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Left join (select top 1 Vl.PedidoVolumeid, Pl.ZonaId, Pl.Zona' +
      sLineBreak + '           From PedidoVolumeLotes Vl' + sLineBreak +
      '		   Inner join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' + sLineBreak
      + '		   where Vl.PedidoVolumeId = @PedidoVolumeid) Vz On Vz.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + '  And (Pv.PedidoVolumeId = @PedidoVolumeId)';

  Const
    SqlPedidoVolume = 'Declare @PedidoId Int  = :pPedidoId' + sLineBreak +
      'Declare @PedidoVolumeId Int = :pPedidoVolumeId' + sLineBreak +
      'select Vlm.PedidoVolumeId, Vlm.EmbalagemId, (case When Vlm.EmbalagemId IS Null then '
      + sLineBreak + '       ' + #39 + 'Caixa Fechada' + #39 + ' else ' + #39 +
      'Fracionado' + #39 + ' End) VolumeEmbalgem, ' + sLineBreak +
      '       VE.Descricao, VE.Identificacao, Ve.Tipo, ' + sLineBreak +
      '       (Case' + sLineBreak + '          When Ve.Tipo = ' + #39 + 'R' +
      #39 + ' then ' + #39 + 'Retorn�vel' + #39 + sLineBreak +
      '          When Ve.Tipo = ' + #39 + 'P' + #39 + ' then ' + #39 + 'Pr�pria'
      + #39 + sLineBreak + '          When Ve.Tipo = ' + #39 + 'C' + #39 +
      ' then ' + #39 + 'Pacote' + #39 + sLineBreak + '          WHen Ve.Tipo = '
      + #39 + 'U' + #39 + ' then ' + #39 + 'Reutiliz�vel' + #39 + sLineBreak +
      '		     End) as TipoDescricao, ' + sLineBreak +
      '   	   VE.Altura, VE.Largura, VE.Comprimento, (VE.Altura*VE.Largura*VE.Comprimento) As Volume, VE.Aproveitamento,'
      + sLineBreak +
      '   	   cast((VE.Altura*VE.Largura*VE.Comprimento)*Cast(Cast(VE.Aproveitamento as decimal(15,4))/Cast(100 as decimal(15,4)) as decimal(10,2)) as Decimal(10,2)) VolCm3, VE.Capacidade, VE.Tara, VE.QtdLacres, VE.CodBarras,'
      + sLineBreak + '   	   VE.Disponivel, VE.PrecoCusto,' + sLineBreak +
      '   	   Vlm.PedidoId, PD.Data DtPedido, Ped.RegistroERP, Ped.PessoaId, Pes.Razao, Vlm.Sequencia, Vlm.CaixaEmbalagemId,'
      + sLineBreak +
      '        DE.ProcessoId, DE.Descricao as Processo, Vlm.Status' + sLineBreak
      + 'From PedidoVolumes Vlm' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Vlm.PedidoId' + sLineBreak +
      'Inner Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId' +
      sLineBreak + 'Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' +
      sLineBreak + 'Inner Join Rhema_data PD On Pd.iddata = Ped.DocumentoData' +
      sLineBreak +
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak +
      '      and (@PedidoId = 0 or Vlm.PedidoId = @PedidoId) and (@PedidoVolumeId = 0 or Vlm.PedidoVolumeId = @PedidoVolumeId)';

  Const
    SqlPedidoVolumeProduto =
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'select Pvl.PedidoVolumeid, Prd.IdProduto ProdutoId, Prd.CodProduto, Pc.CodBarras, Prd.Descricao, Prd.UnidadeSecundariaSigla, Pvl.EmbalagemPadrao,'
      + sLineBreak +
      '       VEnd.Endereco, VEnd.Mascara, Sum(Pvl.Quantidade) Demanda, Sum(Pvl.QtdSuprida) QtdSuprida'
      + sLineBreak + 'From PedidoVolumeLotes Pvl' + sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.Loteid = Pvl.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      'Inner Join vEnderecamentos VEnd ON Vend.EnderecoId = Pvl.EnderecoId' +
      sLineBreak +
      'Left Join ProdutoCodBarras Pc On Pc.ProdutoId = Prd.IdProduto and Pc.Principal = 1'
      + sLineBreak + 'where Pvl.PedidoVolumeId = @PedidoVolumeId' + sLineBreak +
      'Group by Pvl.PedidoVolumeid, Prd.IdProduto, Prd.CodProduto, Pc.CodBarras, Prd.Descricao, Prd.UnidadeSecundariaSigla, Pvl.EmbalagemPadrao, VEnd.Endereco, VEnd.Mascara'
      + sLineBreak + 'Order by Prd.Descricao';

  Const
    SqlPedidoVolumeProdutoReconferencia =
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'select Pvl.PedidoVolumeid, Prd.IdProduto ProdutoId, Prd.CodProduto, Pc.CodBarras, Prd.Descricao, Prd.UnidadeSecundariaSigla, Pvl.EmbalagemPadrao,'
      + sLineBreak +
      '       VEnd.Endereco, VEnd.Mascara, Sum(Pvl.QtdSuprida) Demanda, Sum(Pvl.QtdSuprida) QtdSuprida'
      + sLineBreak + 'From PedidoVolumeLotes Pvl' + sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.Loteid = Pvl.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      'Inner Join vEnderecamentos VEnd ON Vend.EnderecoId = Pvl.EnderecoId' +
      sLineBreak +
      'Left Join ProdutoCodBarras Pc On Pc.ProdutoId = Prd.IdProduto and Pc.Principal = 1'
      + sLineBreak + 'where Pvl.PedidoVolumeId = @PedidoVolumeId' + sLineBreak +
      '  And Pvl.QtdSuprida > 0' + sLineBreak +
      'Group by Pvl.PedidoVolumeid, Prd.IdProduto, Prd.CodProduto, Pc.CodBarras, Prd.Descricao, Prd.UnidadeSecundariaSigla, Pvl.EmbalagemPadrao, VEnd.Endereco, VEnd.Mascara'
      + sLineBreak + 'Order by Prd.Descricao';

  Const
    SqlPedidoVolumeProdutoLote = 'Declare @PedidoId Integer   = :pPedidoid' +
      sLineBreak + 'Declare @Codproduto Integer = :pCodProduto' + sLineBreak +
      'select Vl.PedidovolumeId, (Case When Pv.EmbalagemId Is Null Then ' + #39
      + 'Cxa.Fechada' + #39 + ' Else ' + #39 + 'Fracionado' + #39 +
      ' End) Embalagem,' + sLineBreak +
      '       Pl.Lote, Pl.Vencimento, Vl.QtdSuprida, TEnd.Endereco, TEnd.Mascara'
      + sLineBreak + 'From PedidoVolumeLotes Vl' + sLineBreak +
      'inner join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId' +
      sLineBreak + 'Inner Join vProdutolotes Pl on Pl.Loteid = Vl.LoteId' +
      sLineBreak +
      'Inner Join vEnderecamentos TEnd on TEnd.EnderecoId = Vl.Enderecoid' +
      sLineBreak + 'where (@PedidoId = 0 or Pv.pedidoid = @Pedidoid)' +
      sLineBreak + '  And (@Codproduto = 0 or Pl.CodProduto = @CodProduto)' +
      sLineBreak + 'Order by Pv.Sequencia, Pl.Lote';

  Const
    SqlPedidoVolumeProdutoSeparacao =
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'select Pvl.PedidoVolumeid, Prd.IdProduto ProdutoId, Prd.CodProduto, Pc.CodBarras, Prd.Descricao,'
      + sLineBreak +
      '       Prd.EnderecoId, Prd.EnderecoDescricao Endereco, Prd.mascara,' +
      sLineBreak + '	      (Case When Pvl.EmbalagemPadrao = 1 then' +
      sLineBreak + '	              Prd.UnidadeSigla' + sLineBreak +
      '			    Else' + sLineBreak + '			       Prd.UnidadeSecundariaSigla' +
      sLineBreak + '		     End) as Embalagem,' + sLineBreak +
      '       Pvl.EmbalagemPadrao, Sum(Pvl.Quantidade) Demanda, Sum(Pvl.QtdSuprida) QtdSuprida, --0 as QtdSuprida, --'
      + sLineBreak + '       Prd.SeparacaoConsolidada,' + sLineBreak +
      '       Prd.ZonaID, Prd.ZonaDescricao Zona, Prd.LoteReposicao,' +
      sLineBreak + '       Prd.ExigirLote as LoteSeparacao' + sLineBreak +
      'From PedidoVolumeLotes Pvl' + sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.Loteid = Pvl.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      'Left Join ProdutoCodBarras Pc On Pc.ProdutoId = Prd.IdProduto and Pc.Principal = 1'
      + sLineBreak + 'where Pvl.PedidoVolumeId = @PedidoVolumeId' + sLineBreak +
      'Group by Pvl.PedidoVolumeid, Prd.IdProduto, Prd.CodProduto, Pc.CodBarras, Prd.Descricao,'
      + sLineBreak +
      '         Prd.EnderecoId, Prd.EnderecoDescricao, Prd.mascara, Pvl.EmbalagemPadrao, Prd.UnidadeSigla,'
      + sLineBreak +
      '         Prd.UnidadeSecundariaSigla, Prd.SeparacaoConsolidada, Prd.ZonaID, Prd.ZonaDescricao, '
      + sLineBreak +
      '         Prd.LoteReposicao, Prd.ProdutoSNGPC, Prd.ExigirLote' +
      sLineBreak + 'Order by Prd.EnderecoDescricao';

  Const
    SqlPedidoVolumeLote = 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' +
      sLineBreak +
      'select Vl.PedidoVolumeLoteId, Vl.PedidoVolumeId, Vl.LoteId, Pl.DescrLote, Pl.DescrLote Lote, Lv.Data Vencimento,'
      + sLineBreak + 'Prd.IdProduto ProdutoId, Prd.CodProduto, Prd.Descricao,' +
      sLineBreak +
      'TEnd.RuaId, TEnd.Rua, Vl.EnderecoId, TEnd.Endereco, TEnd.ZonaID, TEnd.Zona, EndE.EstruturaId, EndE.Descricao AS Estrutura, EndE.Mascara, '
      + sLineBreak + '   Vl.EstoqueTipoId, ET.Descricao EstoqueTipo,' +
      sLineBreak +
      '   Vl.Quantidade Demanda, Vl.EmbalagemPadrao, Vl.QtdSuprida, ' +
      sLineBreak +
      '   Cast((Prd.PesoLiquido*Vl.QtdSuprida)/1000 as Decimal(15,3)) as PesoKg,'
      + sLineBreak +
      '  Cast(Cast((Prd.Altura*Prd.Largura*Prd.Comprimento)*Vl.QtdSuprida as Decimal(15,6))/1000000 as Decimal(15,6)) Volm3,'
      + sLineBreak + '   Vl.Terminal, Vl.UsuarioId, Usu.Nome,' + sLineBreak +
      '   Rd.Data as DtInclusao, RH.Hora as HrInclusao,' + sLineBreak +
      '   Cast(CONVERT(DATETIME, CONVERT(CHAR(8), Rd.Data, 112) + ' + #39 + ' '
      + #39 + ' + CONVERT(CHAR(8),Rh.Hora, 108)) as DateTime) AS Horario' +
      sLineBreak + 'From PedidoVolumes Vlm' + sLineBreak +
      'Inner Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Vlm.PedidoVolumeId'
      + sLineBreak +
      'Inner join vEnderecamentos TEnd on TEnd.EnderecoId = Vl.EnderecoId' +
      sLineBreak +
      'Inner Join EnderecamentoEstruturas EndE On EndE.EstruturaId = TEnd.EstruturaID'
      + sLineBreak + 'Inner Join ProdutoLotes PL on PL.LoteId = Vl.LoteId' +
      sLineBreak + 'Inner Join vProduto Prd on Prd.IdProduto = PL.ProdutoId' +
      sLineBreak + 'Inner Join EstoqueTipo ET ON ET.Id = Vl.EstoqueTipoId' +
      sLineBreak + 'Inner Join Usuarios Usu On usu.UsuarioId = Vl.UsuarioId' +
      sLineBreak + 'Inner Join Rhema_Data RD ON RD.IdData = Vl.DtInclusao' +
      sLineBreak + 'Inner Join Rhema_Hora RH On RH.IdHora = Vl.HrInclusao' +
      sLineBreak + 'Inner Join Rhema_Data LV On LV.IdData = Pl.Vencimento' +
      sLineBreak + 'where Vl.PedidoVolumeId = @PedidoVolumeId';

  Const
    SqlVolumeComDivergencia =
      'declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'select PedidoVolumeId, Coalesce(Sum(Quantidade), 0) Quantidade, Coalesce(Sum(QtdSuprida), 0) QtdSuprida '
      + sLineBreak + 'From PedidoVOlumeLotes' + sLineBreak +
      'Where PedidoVOlumeId = @PedidoVOlumeId' + sLineBreak +
      'Group by PedidoVolumeId';

  Const
    SqlPedidoVolumeProdutoLotes =
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'Declare @ProdutoId Integer = :pProdutoId' + sLineBreak +
      'select Pl.IdProduto, Pl.CodProduto, Pvl.LoteId, Pl.Lote, Pl.Data Fabricacao, Pl.Vencimento, Pvl.Quantidade Demanda,'
      + sLineBreak +
      '       Pvl.EmbalagemPadrao, Rd.Data DtInclusao, RH.Hora HrInclusao, Pvl.UsuarioId, Pvl.Terminal'
      + sLineBreak + 'From PedidoVolumeLotes Pvl' + sLineBreak +
      'Inner join vProdutoLotes Pl On Pl.LoteId = Pvl.LoteId' + sLineBreak +
      'Inner join Rhema_Data Rd On Rd.IdData = Pvl.DtInclusao' + sLineBreak +
      'Inner join Rhema_Hora Rh On Rh.IdHora = Pvl.HrInclusao' + sLineBreak +
      'where PedidoVolumeid = @PedidoVolumeId and' + sLineBreak +
      '      (@ProdutoId = 0 or Pl.IdProduto = @ProdutoId)';

  Const
    SqlPedidoVolumeCheckIn =
      'Declare @CaixaEmbalagemId Integer = :pCaixaEmbalagemId' + sLineBreak +
      'Declare @PedidoVolumeId Integer   = :pPedidoVolumeId' + sLineBreak +
      'Declare @Operacao Integer = :pOperacao' + sLineBreak +
      'Select * From PedidoVolumeSeparacao' + sLineBreak +
      'Where (@CaixaEmbalagemId = 0 or CaixaEmbalagemId = @CaixaEmbalagemId) and '
      + sLineBreak +
      '      (@PedidoVolumeId = 0 or PedidoVolumeId = @PedidoVolumeId) and ' +
      '      Operacao = @Operacao';

  Const
    SqlAuditoriaCorteAnalitico = 'Declare @DtInicio DateTime = :pDtInicio' +
      sLineBreak + 'Declare @DtFInal DateTime = :pDtFinal' + sLineBreak +
      'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DocumentoNr Varchar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @PessoaId Integer = Coalesce((Select PessoaId From Pessoa Where CodPessoaERP = :pCodPessoaErp and PessoaTipoId = 1), 0)'
      + sLineBreak + 'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Declare @LinhaId Integer = :pLinhaId' + sLineBreak +
      'Declare @TipoVolume Integer = :pTipoVolume -- 0-Todos 1-Cxa.Fechada 2-Fracionados 3-Extra'
      + sLineBreak + 'Declare @UsuarioId Integer = :pUsuarioId' + sLineBreak +
      'select Po.Data, Po.PedidoVolumeid, Pv.Sequencia, Pv.Tipo, Po.loteid, Pl.Lote,'
      + sLineBreak + '       Po.enderecoid, TEnd.Descricao Endereco,' +
      sLineBreak +
      '       Po.quantidade, Po.qtdsuprida QtdAtendida, (Po.quantidade - Po.qtdsuprida) Corte, Vl.Quantidade Demanda, Vl.Corte CorteFinal,'
      + sLineBreak +
      '	      Po.ProcessoEtapaId, Po.usuarioid, U.Nome, Pes.CodPessoaERP, Pes.Razao, Rp.rotaid, Ro.Descricao Rota'
      + sLineBreak + '       , Pl.CodProduto, Pl.Descricao Produto' + sLineBreak
      + 'from PedidoOperacao  Po' + sLineBreak +
      'Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Po.pedidovolumeid' +
      sLineBreak + 'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak + 'Inner Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' +
      sLineBreak + 'Inner join RotaPessoas Rp On Rp.PessoaId = Pes.PessoaId' +
      sLineBreak + 'Inner Join Rotas Ro On Ro.RotaId = Rp.RotaId' + sLineBreak +
      'Inner Join usuarios U On U.usuarioid = Po.UsuarioId' + sLineBreak +
      'Inner join vProdutoLotes Pl On Pl.LoteId = Po.loteid' + sLineBreak +
      'Inner Join Enderecamentos TEnd On TEnd.EnderecoId = Po.EnderecoId' +
      sLineBreak + 'Inner Join vDocumentoEtapas De On De.Documento = Pv.Uuid' +
      sLineBreak +
      'Left Join (Select PedidoVolumeId, LoteId, EnderecoId, Quantidade, Quantidade-QtdSuprida Corte'
      + sLineBreak +
      '           From PedidoVolumeLotes ) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId and Vl.LoteId = Po.loteid And Vl.EnderecoId = Po.EnderecoId'
      + sLineBreak + 'where Po.quantidade <> Po.qtdsuprida' + sLineBreak +
      '   And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '   And (@TipoVolume = 0 or (@TipoVolume=1 and Pv.EmbalagemId Is Null) or'
      + sLineBreak + '        (@TipoVolume=2 and Pv.EmbalagemId Is Not Null) or'
      + sLineBreak + '	       (@TipoVolume=3 and Pv.Tipo = ' + #39 + 'E' + #39
      + '))' + sLineBreak + '	  And (@PedidoId = 0 or @PedidoId = Ped.PedidoId)'
      + sLineBreak + '	  And (@DocumentoNr = ' + #39 + #39 +
      ' or @DocumentoNr = Ped.DocumentoNr)' + sLineBreak +
      '   And (@DtInicio=0 or Po.Data >= @DtInicio)' + sLineBreak +
      '	  And (@DtFinal=0 or Po.Data <= @DtFinal)' + sLineBreak +
      '	  And (@RotaId = 0 Or @RotaId = Rp.RotaId)' + sLineBreak +
      '	  And (@PessoaId = 0 or @PessoaId = Pes.PessoaId)' + sLineBreak +
      '	  And (@CodProduto = 0 or @CodProduto = Pl.CodProduto)' + sLineBreak +
      '   --And (@LinhaId = 0 or @LinhaId = Pt.Id)' + sLineBreak +
      '   And (@UsuarioId = 0 or @UsuarioId = Po.UsuarioId)' + sLineBreak +
      '   --And De.ProcessoId <> 15' + sLineBreak +
      'Order by Po.data, Po.PedidoVolumeid, Po.loteid, Po.enderecoid, Po.ProcessoEtapaId';

  Const
    SqlMapaSeparacao = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'select P.PedidoId, P.DocumentoNr, RP.Data,' + sLineBreak +
      '       Pv.PedidoVolumeId, Pv.Sequencia' + sLineBreak +
      '	  ,Pe.PessoaId, Pe.CodPessoaErp, Pe.Razao' + sLineBreak +
      '	  ,Pr.RotaId, Ro.Descricao RotaDescricao' + sLineBreak +
      '	  ,TEnd.Endereco, TEnd.Mascara, TEnd.Rua, TEnd.Zona' + sLineBreak +
      '	  ,Lt.DescrLote, LV.Data as Vencimento, Lt.ProdutoId, Prd.CodProduto, Prd.Descricao ProdutoDescricao'
      + sLineBreak +
      '   , (Select top 1 CodBarras From ProdutoCodBarras where ProdutoId = Prd.IdProduto) Ean'
      + sLineBreak +
      '   ,Pl.Quantidade, (Case When Pl.EmbalagemPadrao = 1 then ' + #39 + 'Un'
      + #39 + ' Else ' + #39 + 'Cx' + #39 +
      ' End) as Unidade, Pl.EmbalagemPadrao, (Case when Embalagemid  Is Null then '
      + #39 + 'Cxa.Fechada' + #39 + '       Else ' + #39 + 'Fracionado' + #39 +
      ' End) as VolumeTipo' + sLineBreak + 'From PedidoVolumes PV' + sLineBreak
      + 'Inner Join Pedido P On P.PedidoId = Pv.PedidoId' + sLineBreak +
      'Inner Join PedidoVolumeLotes PL On PL.PedidoVolumeId = PV.PedidoVolumeId'
      + sLineBreak + 'Inner Join Pessoa Pe On Pe.PessoaId = P.PessoaId' +
      sLineBreak + 'Inner Join RotaPessoas PR On PR.PessoaId = Pe.PessoaId' +
      sLineBreak + 'Inner Join Rotas Ro On Ro.RotaId = Pr.RotaId' + sLineBreak +
      'Inner Join Rhema_Data RP On Rp.IdData = P.DocumentoData' + sLineBreak +
      'Inner Join vEnderecamentos TEnd ON TEnd.EnderecoId = Pl.EnderecoId' +
      sLineBreak + 'Inner Join ProdutoLotes Lt On Lt.LoteId = Pl.LoteId' +
      sLineBreak + 'Inner Join Rhema_Data LV ON LV.IdData = Lt.Vencimento' +
      sLineBreak + 'Inner join Produto Prd on Prd.IdProduto = Lt.ProdutoId' +
      sLineBreak +
      'Where (@PedidoId = 0 or P.PedidoId = @PedidoId) and (@PedidoVolumeId = 0 or PV.PedidoVolumeId = @PedidoVolumeId) and (Embalagemid Is Not Null)'
      + sLineBreak + 'Order by Pv.PedidoVolumeId, TEnd.Endereco, LV.Data';

  Const
    SqlMapaSeparacaoLista = 'Declare @PedidoIdInicial Int  = :pPedidoIdInicial'
      + sLineBreak + 'Declare @PedidoIdFinal   Int  = :pPedidoIdFinal' +
      sLineBreak +
      'Declare @PedidoVolumeIdInicial Int = :pPedidoVolumeIdInicial' +
      sLineBreak + 'Declare @PedidoVolumeIdFinal Int = :pPedidoVolumeIdFinal' +
      sLineBreak +
      'Declare @PessoaId Int = Coalesce((Select PessoaId From Pessoa Where PessoaTipoId = 1 and CodPessoaERP = :pCodPessoaERP), 0)'
      + sLineBreak + 'Declare @RotaId Int = :pRotaId' + sLineBreak +
      'Declare @DtPedidoInicial DateTime = :pDtPedidoInicial' + sLineBreak +
      'Declare @DtPedidoFinal DateTime = :pDtPedidoFinal' + sLineBreak +
      'Select Pv.*,' + sLineBreak + '       VL.Demanda, VL.QtdSuprida' +
      sLineBreak +
      '       , Ms.Zona, Ms.RuaId, Ms.Rua, SUBSTRING(Ms.Endereco, 1, 2)+' + #39
      + '.' + #39 + '+SUBSTRING(Ms.Endereco, 3, 2) PredioInicial' + sLineBreak +
      '       , Cc.CarregamentoId' + sLineBreak +
      'From (select Vlm.PedidoId, Vlm.PedidoVolumeId, Coalesce(Vlm.EmbalagemId, 0) VolumeTipo, (case When Vlm.EmbalagemId IS Null then'
      + sLineBreak +
      '                                                              ' + #39 +
      'Caixa Fechada' + #39 + ' else ' + #39 + 'Fracionado' + #39 +
      ' End) Embalagem,' + sLineBreak +
      '       VE.Descricao, VE.Identificacao, VE.Tara,' + sLineBreak +
      '   	   Vlm.Sequencia, Vlm.CaixaEmbalagemId VolumeCaixa,' + sLineBreak +
      '       DE.ProcessoId, DE.Descricao as Processo' + sLineBreak +
      '       , PEd.DocumentoNr, Rd.Data As DocumentoData' + sLineBreak +
      '       , P.PessoaId, P.Razao, P.Fantasia' + sLineBreak +
      '	      , Rp.Rotaid, R.Descricao Rota, Rp.Ordem' + sLineBreak +
      'From PedidoVolumes Vlm' + sLineBreak +
      'Left Join VolumeEmbalagem VE ON VE.EmbalagemId = Vlm.EmbalagemId' +
      sLineBreak + 'Left join vDocumentoEtapas DE On De.Documento = Vlm.Uuid' +
      sLineBreak + 'Inner join Pedido Ped ON Ped.PedidoId = Vlm.PedidoId' +
      sLineBreak + 'Inner join Rhema_Data RD on Rd.IdData = Ped.DocumentoData' +
      sLineBreak + 'Inner join Pessoa P On P.Pessoaid = Ped.PessoaId' +
      sLineBreak + 'Inner Join RotaPessoas Rp On Rp.PessoaId = P.PessoaId' +
      sLineBreak + 'Inner Join Rotas R On R.RotaId = Rp.RotaId' + sLineBreak +
      'Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak +
      '      and (@PedidoIdInicial = 0 or Vlm.PedidoId >= @PedidoIdInicial)' +
      sLineBreak +
      '      and (@PedidoIdFinal = 0 or Vlm.PedidoId <= @PedidoIdFinal)' +
      sLineBreak +
      '	  and (@PedidoVolumeIdInicial = 0 or Vlm.PedidoVolumeId >= @PedidoVolumeIdInicial)'
      + sLineBreak +
      '	  and (@PedidoVolumeIdFinal = 0 or Vlm.PedidoVolumeId <= @PedidoVolumeIdFinal)'
      + sLineBreak + '	  And (@RotaId = 0 or Rp.RotaId = @RotaId)' + sLineBreak
      + '	  And (@PessoaId = 0 or Ped.PessoaId = @PessoaId)' + sLineBreak +
      '	  And (@DtPedidoInicial = 0 or Rd.Data >= @DtPedidoInicial)' +
      sLineBreak + '	  And (@DtPedidoFinal = 0 or Rd.Data <= @DtPedidoFinal)' +
      sLineBreak + '   And Vlm.EmbalagemId Is Not Null) as PV' + sLineBreak +
      'Left join (Select PedidoVolumeId, SUM(Quantidade) Demanda, SUM(QtdSuprida) QtdSuprida'
      + sLineBreak + '           From PedidoVolumeLotes' + sLineBreak +
      '		   Group By PedidoVolumeId) VL On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Left Join (Select Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua, Tend.Zona, Min(Tend.Endereco) Endereco'
      + sLineBreak + '           From PedidoVolumeLotes VL' + sLineBreak +
      '           Inner Join vEnderecamentos Tend On Tend.EnderecoId = VL.EnderecoId'
      + sLineBreak + '		   Group by Vl.PedidoVolumeId, Tend.RuaId, TEnd.Rua,'
      + sLineBreak +
      '		            Tend.Zona) MS ON Ms.PedidoVolumeId = Pv.PedidoVolumeId' +
      sLineBreak +
      'Left Join CargaCarregamento Cc On Cc.PedidoVOlumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Order By Cast(Pv.Pedidoid As varchar)+Cast(Vl.PedidoVolumeId  As varchar)';

  Const
    jsonSaidaRetornoCheckInFinalizado =
      'Select (select Ped.PedidoId, Nat.Descricao ' + #39 + 'natureza' + #39 +
      ', Ped.DocumentoNr, Ped.RegistroERP, PD.Data As ' + #39 + 'documentodata'
      + #39 + ',' + sLineBreak + '        P.PessoaId As ' + #39 +
      'destinatario.destinatarioid' + #39 + ', P.Razao as ' + #39 +
      'destinatario.razao' + #39 + ', P.Fantasia As ' + #39 +
      'destinatario.fantasia' + #39 + ',' + sLineBreak +
      '	       P.CnpjCpf as ' + #39 + 'destinatario.cnpj' + #39 +
      ', P.Email as ' + #39 + 'destinatario.email' + #39 + ', ' + sLineBreak +
      '	       (Select COUNT(PedidoId) from PedidoVolumes where PedidoId = Ped.PedidoId) As qtdvolumes '
      + sLineBreak + '        , De.Descricao As Processo' + sLineBreak +
      'From Pedido Ped ' + sLineBreak +
      'Inner Join OperacaoTipo OT ON OT.OperacaoTipoId = Ped.OperacaoTipoId ' +
      sLineBreak +
      'Left join OperacaoNatureza Nat On Nat.OperacaoNaturezaId = OT.OperacaoNaturezaId '
      + sLineBreak + 'Inner Join Pessoa P On P.PessoaId = Ped.PessoaId ' +
      sLineBreak + 'Inner Join vDocumentoEtapas De On DE.Documento = Ped.Uuid '
      + sLineBreak +
      'Inner Join Rhema_Data PD On PD.IdData = Ped.DocumentoData ' + sLineBreak
      + 'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak +
      '      and De.ProcessoId in (13, 14, 15) and De.Status = 1 and Ped.OperacaoTipoId = 2 and Ped.Status<>5'
      + sLineBreak + // De.ProcessoId <> 6 and
      'Order by PD.Data, Ped.PedidoId ' + sLineBreak +
      'For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno';
    // , INCLUDE_NULL_VALUES, WITHOUT_ARRAY_WRAPPER  op��es na gera��o de Json
    // Est� sendo usado processoid = 10 para integrar ap�s conferencia
    // For Json Auto inclue subjsonarray no return quando usando Join

  Const
    jsonSaidaRetornoCheckInFinalizadoV2 = 'Declare @Versao Char(2) = :pVersao' +
      sLineBreak + 'Select (select Ped.PedidoId, Nat.Descricao ' + #39 +
      'natureza' + #39 + ', Ped.DocumentoNr, Ped.RegistroERP, PD.Data As ' + #39
      + 'documentodata' + #39 + ',' + sLineBreak + '        P.PessoaId As ' +
      #39 + 'destinatario.destinatarioid' + #39 + ', P.Razao as ' + #39 +
      'destinatario.razao' + #39 + ', P.Fantasia As ' + #39 +
      'destinatario.fantasia' + #39 + ',' + sLineBreak +
      '	       P.CnpjCpf as ' + #39 + 'destinatario.cnpj' + #39 +
      ', P.Email as ' + #39 + 'destinatario.email' + #39 + ', ' + sLineBreak +
      '	       (Select COUNT(PedidoId) from PedidoVolumes where PedidoId = Ped.PedidoId) As qtdvolumes '
      + sLineBreak + '        , De.Descricao As Processo, DocumentoOriginal' +
      sLineBreak + 'From Pedido Ped ' + sLineBreak +
      'Inner Join OperacaoTipo OT ON OT.OperacaoTipoId = Ped.OperacaoTipoId ' +
      sLineBreak +
      'Left join OperacaoNatureza Nat On Nat.OperacaoNaturezaId = OT.OperacaoNaturezaId '
      + sLineBreak + 'Inner Join Pessoa P On P.PessoaId = Ped.PessoaId ' +
      sLineBreak + 'Inner Join vDocumentoEtapas De On DE.Documento = Ped.Uuid '
      + sLineBreak +
      'Inner Join Rhema_Data PD On PD.IdData = Ped.DocumentoData ' + sLineBreak
      + 'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '      and De.ProcessoId >= 13 --in (13, 14, 15) ' +
      sLineBreak + '      and De.Status = 1 and Ped.OperacaoTipoId = 2' +
      sLineBreak + // De.ProcessoId <> 6 and
      '      and ((@Versao = ' + #39 + 'V2' + #39 +
      ' and Ped.Status<>5) or (@Versao = ' + #39 + 'V3' + #39 +
      ' and Ped.NotaFiscalERP is Null))' + sLineBreak +
      'Order by PD.Data, Ped.PedidoId ' + sLineBreak +
      'For Json Path, INCLUDE_NULL_VALUES) as ConsultaRetorno';

    // Pessoas
  Const
    SqlSalvarDestinatario = 'Declare @PessoaTipoId Integer = :pPessoaTipoId' +
      sLineBreak + 'Declare @CodPessoaERP Integer    = :pCodPessoaERP' +
      sLineBreak + 'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @Fantasia VarChar(100) = :pFantasia' + sLineBreak +
      'Declare @CnpjCpf VarChar(14)   = :pCnpjCpf' + sLineBreak +
      'Declare @Email Varchar(100)  = :pEmail' + sLineBreak +
      'Declare @HomePage Varchar(100)  = :pHomePage' + sLineBreak +
      'Declare @ShelfLife Integer      = :pShelfLife' + sLineBreak +
      'If Not Exists (Select CodPessoaERP From Pessoa Where CodPessoaERP = @CodPessoaERP and PessoaTipoId = @PessoaTipoId) Begin'
      + sLineBreak +
      ' 		insert into pessoa (CodPessoaERP, Razao, Fantasia, PessoaTipoID, CnpjCpf, Email, HomePage, ShelfLife, Status)'
      + sLineBreak +
      '      		Values (@CodPessoaERP, @Razao, @Fantasia, @PessoaTipoId, @CnpjCpf, @Email, @HomePage, @ShelfLife, 1)'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '   Update Pessoa ' + sLineBreak + '       Set Razao     = @Razao' +
      sLineBreak + '           ,Fantasia = @Fantasia' + sLineBreak +
      '           ,CnpjCpf  = @CnpjCpf' + sLineBreak +
      '           ,Email    = @Email' + sLineBreak +
      '           ,ShelfLife = @ShelfLife' + sLineBreak +
      '   Where CodPessoaERP = @CodPessoaERP and PessoaTipoId = @PessoaTipoId' +
      sLineBreak + 'End';

  Const
    SqlSalvarPedidoProduto = 'Declare @PedidoId        Integer = :pPedidoId' +
      sLineBreak +
      'Declare @ProdutoId       Integer = (Select IdProduto From Produto Where CodProduto = :pCodProduto)'
      + sLineBreak + 'Declare @Quantidade      Integer = :pQuantidade' +
      sLineBreak + 'Declare @EmbalagemPadrao Integer = :pEmbalagemPadrao' +
      sLineBreak + 'Declare @Itemid          Integer = :pItemid' + sLineBreak +
      'Insert Into PedidoProdutos Values (@PedidoId, @ProdutoId, @Quantidade, @EmbalagemPadrao, '
      + sLineBreak +
      '                                   (Case When @ItemId = 0 then Null Else @ItemId End))';

  Const
    SqlSaidaIntegracaoRetornoPedido = 'Declare @Pedido VarChar(36) = :pPedido' +
      sLineBreak +
      'select P.Pedidoid, OpN.Descricao as Natureza, Dp.Data as DocumentoData, P.DocumentoNr, '
      + sLineBreak +
      '       (Case When (DoctoEt.ProcessoId >= 13 and DoctoEt.ProcessoId <> 15 and DoctoEt.ProcessoId <> 31) then '
      + #39 + 'Expedida' + #39 + sLineBreak +
      '             When DoctoEt.ProcessoId = 15 then ' + #39 + 'Cancelada' +
      #39 + sLineBreak + '             When DoctoEt.ProcessoId = 31 then ' + #39
      + 'Documento Excluido' + #39 + sLineBreak + '             Else ' + #39 +
      'N�o Indentificado' + #39 + ' End) as Situacao,' + sLineBreak +
      '	   P.RegistroERP, Pes.CodPessoaERP as DestinatarioId, Pes.Razao, ' +
      sLineBreak +
      '	   pes.Fantasia, Pes.CnpjCpf as cnpj, Pes.email, p.DocumentoOriginal' +
      sLineBreak + 'From Pedido P' + sLineBreak +
      'Inner join OperacaoTipo Op On Op.OperacaotipoId = p.OperacaoTipoId' +
      sLineBreak +
      'Inner Join OperacaoNatureza OpN  On OpN.OperacaoNaturezaId = Op.OperacaoNaturezaId'
      + sLineBreak + 'Inner join Pessoa Pes On Pes.PessoaId = P.PessoaId' +
      sLineBreak + 'Inner join Rhema_Data DP ON Dp.IdData = P.DocumentoData' +
      sLineBreak +
      'Inner Join (select De.Documento, Max(De.ProcessoId) Processoid' +
      sLineBreak + '            from DocumentoEtapas De' + sLineBreak +
      '            Inner join Pedido PV On PV.Uuid = De.Documento' + sLineBreak
      + '            where De.Status = 1 and De.Status <> 6' + sLineBreak +
      '            Group By De.Documento) DoctoEt On DoctoEt.Documento = P.Uuid'
      + sLineBreak + 'where P.OperacaoTipoId = 2 ' + sLineBreak +
    // and DoctoEt.Processoid in (6, 10)'+sLineBreak+
      '      AND (Cast(P.PEDIDOID as varchar(36)) = @Pedido or Cast(P.RegistroERP as VarChar(36)) = @Pedido)'
      + sLineBreak + '      And DoctoEt.ProcessoId >= 13';
    // and DoctoEt.ProcessoId <> 15';

  Const
    SqlSaidaIntegracaoRetornoVolume = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'select PedidoVolumeId, Sequencia, EmbalagemId' + sLineBreak
      + 'from PedidoVolumes' + sLineBreak +
      'Inner Join vDocumentoEtapas DE on De.Documento = PedidoVolumes.Uuid' +
      sLineBreak +
      'Where PedidoId = @PedidoId and De.ProcessoId <> 15 and De.Horario = (Select Max(Horario) '
      + sLineBreak +
      '                 From vDocumentoEtapas where Documento = PedidoVolumes.uuid and Status = 1)';

  Const
    SqlSaidaIntegracaoRetornoVolumeLotes =
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'select Prd.CodProduto, Ean.CodBarras, (Case When Prd.RastroId <> 30000 then Pl.DescrLote Else '
      + #39 + 'ND' + #39 + ' End) DescrLote, ' + sLineBreak +
      'Cast(Prd.PesoLiquido*QtdSuprida as Decimal(15, 3)) Peso, Cast(((Prd.Altura*Prd.Largura*Prd.Comprimento)*QtdSuprida)/1000000 as Decimal(15,6)) Volumem3, '
      + sLineBreak +
    // --(Case When (Prd.SNGPC = 1 '+sLineBreak+
    // --'       or TEnd.ProdutoSNGPC=1) then Pl.DescrLote Else '+#39+'SL'+#39+' End) DescrLote,
      'Fab.Data as Fabricacao, ' + sLineBreak +
      'Venc.Data as Vencimento, Vl.PedidoVolumeId, Vl.LoteId, Vl.Quantidade, ' + sLineBreak +
      '(Case When Vl.QtdSuprida>Vl.Quantidade then VL.Quantidade Else Vl.QtdSuprida End) as QtdSuprida, '
      + sLineBreak + 'Vl.EmbalagemPadrao, Coalesce(PP.ItemIdERP, 0) ItemIdERP' +
      sLineBreak + 'From PedidoVolumeLotes VL' + sLineBreak +
      'Inner Join PedidoVolumes PV on PV.PedidoVolumeId = VL.PedidoVolumeId' +
      sLineBreak + 'Inner Join ProdutoLotes PL On Pl.LoteId = Vl.LoteId' +
      sLineBreak + 'Inner Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      'Inner Join PedidoProdutos PP on PP.PedidoId = Pv.PedidoId and PP.ProdutoId = PL.ProdutoId'
      + sLineBreak +
      'Left join ProdutoCodBarras Ean On Ean.ProdutoId = Pl.Produtoid And Ean.Principal = 1'
      + sLineBreak + 'Inner join Rhema_Data Fab  On Fab.IdData = Pl.Fabricacao'
      + sLineBreak + 'Inner join Rhema_Data Venc On Venc.IdData = Pl.Vencimento'
      + sLineBreak + 'Where PV.PedidoVolumeId = @PedidoVolumeId' + sLineBreak +
      'Order by Vl.PedidoVolumeId, Sequencia, Pl.ProdutoId, Pl.DescrLote';

  Const
    SqlRelatorioPedidoDemandaXExpedicao = ';with' + sLineBreak +
      'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Ped as (select * From PedidoProdutos where PedidoId = :pPedidoid)' +
      sLineBreak +
      ',Expedido as (Select Pl.ProdutoId, sum(Vl.QtdSuprida) as QtdSuprida' +
      sLineBreak + '              From PedidoVolumeLotes VL' + sLineBreak +
      '              Inner Join PedidoVolumes PV on Pv.Pedidovolumeid = Vl.PedidoVolumeId' + sLineBreak +
      '			  Inner Join ProdutoLotes Pl on Pl.LoteId = Vl.LoteID' + sLineBreak
      + '			  --inner Join Ped as P ON P.PedidoId = Pv.PedidoId' + sLineBreak
      + '			  group By Pl.ProdutoId )' + sLineBreak +
      'Select Ped.PedidoId, Prd.IdProduto, Prd.Descricao, Prd.EnderecoDescricao As Picking, Ped.Quantidade Demanda, Coalesce(Ex.QtdSuprida, 0) QtdExpedida, (Ped.Quantidade - Coalesce(Ex.QtdSuprida, 0)) as Corte'
      + sLineBreak + 'From Ped' + sLineBreak +
      'Inner Join vProduto Prd On Prd.IdProduto = Ped.ProdutoId' + sLineBreak +
      'Left Join Expedido Ex On Ex.ProdutoId = Ped.ProdutoId';

  Const
    SqlVolumeParaEtiquetas = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' +
      sLineBreak + 'Declare @ZonaId Integer    = :pZonaId' + sLineBreak +
      'Declare @PrintTag Integer  = :pPrintTag' + sLineBreak +
      'Declare @Embalagem Integer = :pEmbalagem' + sLineBreak +
      'select Pv.PedidoVolumeId, Coalesce(Pv.EmbalagemId, 0) EmbalagemId, Max(De.ProcessoId) Processoid'
      + sLineBreak + 'from DocumentoEtapas De' + sLineBreak +
      'Inner join PedidoVolumes PV On PV.Uuid = De.Documento' + sLineBreak +
      'where (Pv.PedidoId = @Pedidoid and De.Status = 1 and De.Status <> 6)' +
      sLineBreak +
      '  And (@PedidoVolumeId=0 or Pv.PedidoVolumeId = @PedidoVolumeId) ' +
      sLineBreak +
      '  And (@ZonaId = 0 or (Exists (Select ZonaId From PedidoVolumeLotes VL' +
      sLineBreak + '      Inner Join vProdutoLotes Pl on Pl.LoteId = VL.LoteId'
      + sLineBreak +
      '      Where ZonaID = @ZonaId and Vl.PedidoVolumeId = Pv.PedidoVolumeid )))'
      + sLineBreak + 'Group By Pv.PedidoVolumeId, Pv.EmbalagemId' + sLineBreak +
      'having Max(De.ProcessoId) <> 15'; // in ( 2, 3 )';

  //Indenficacao Etiqueta Volume Caixa Fracionada
  Const SqlEtiquetaVolumePorRua = 'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @EmbalagemId Integer = :pEmbalagemId --0 Todos 1-Cxa.Fechada 2-Fracionada' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'select Pv.PedidoId, Pd.DocumentoOriginal, Pv.PedidoVolumeId, Pv.Sequencia,' + sLineBreak +
      '       Pe.CodPessoaERP, Pe.Razao, Pe.Fantasia, Ro.RotaId, Ro.Descricao Rotas, FORMAT(Dp.Data, '+#39+'dd/MM/yyyy'+#39+') as DtPedido,' + sLineBreak +
      '	   De.ProcessoId, De.Descricao ProcessoEtapa, Vl.Itens, VL.QtdSuprida,'+ sLineBreak +
      '	   VL.Inicio, VL.Termino, Vl.Mascara, Vl.Zona, Pr.Ordem, Coalesce(Pv.EmbalagemId, 0) EmbalagemId,' + sLineBreak +
      '	   vCxaFechada.CodProduto, vCxaFechada.Descricao, VCxaFechada.Picking, vCxaFechada.Lote, FORMAT(vCxaFechada.Vencimento, '+#39+'dd/MM/yyyy'+#39+') AS Vencimento' + sLineBreak +
      '    , TotalVolumes' + sLineBreak + 'From PedidoVolumes Pv' + sLineBreak +
      'Inner join Pedido Pd On Pd.PedidoId = Pv.PedidoId' + sLineBreak +
      'Inner Join Pessoa Pe On Pe.PessoaId = Pd.PessoaId' + sLineBreak +
      'Inner Join RotaPessoas Pr on Pr.PessoaId = Pe.PessoaId' + sLineBreak +
      'Inner Join Rotas Ro On Ro.RotaId = Pr.RotaId' + sLineBreak +
      'Inner join Rhema_Data DP On Dp.IdData = Pd.DocumentoData' + sLineBreak +
      'Inner Join vDocumentoEtapas De On De.Documento = Pv.Uuid' + sLineBreak +
      'Inner Join (Select PedidoId, COUNT(*) TotalVolumes From PedidoVolumes Group by PedidoId) TPv ON TPv.PedidoId = Pd.PedidoId ' + sLineBreak +
      'Left Join (Select Vl.PedidoVolumeId, Pl.ZonaId, COUNT(Distinct Pl.IdProduto) Itens,' + sLineBreak +
      '                  Sum(Vl.QtdSuprida) QtdSuprida, Min(TEnd.Endereco) Inicio,'+ sLineBreak +
      '				       Max(TEnd.Endereco) Termino, TEnd.Mascara, TEnd.Zona' + sLineBreak +
      '           From PedidoVolumeLotes Vl' + sLineBreak +
      '	          Inner Join vEnderecamentos TEnd On TEnd.EnderecoId = Vl.EnderecoId' +sLineBreak +
      '	          Inner join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' + sLineBreak +
      '	          Group by Vl.PedidoVolumeId, Pl.ZOnaId, TEnd.Mascara, TEnd.Zona) VL On VL.PedidoVolumeId = Pv.PedidoVolumeId' + sLineBreak +
      'Left Join (Select Vl.PedidoVolumeId, Prd.CodProduto, Prd.Descricao, Prd.EnderecoDescricao Picking, Pl.DescrLote Lote, Dv.Data Vencimento' + sLineBreak +
      '           From PedidoVolumeLotes Vl' + sLineBreak +
      '		         Inner Join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId' + sLineBreak +
      '		         Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' +sLineBreak +
      '		         Inner Join Rhema_Data DV On DV.IdData = Pl.Vencimento' + sLineBreak +
      '		         ) VCxaFechada ON VCxaFechada.PedidoVolumeId = Pv.PedidoVolumeId and Pv.EmbalagemId Is Null' + sLineBreak +
      'where ((@ProcessoId = 0 and De.ProcessoId < 13) or (@ProcessoId = 2 and De.ProcessoId = 2) or (@ProcessoId = 3 and De.ProcessoId > 2 and De.ProcessoId < 13)) ' + sLineBreak +
      '   And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.Uuid and Status = 1)' + sLineBreak +
      '	  And (@EmbalagemId = 0 or  (@EmbalagemId = 1 and PV.EmbalagemId Is Null) or (@EmbalagemId = 2 and PV.EmbalagemId Is Not Null))' + sLineBreak +
      '   And (@ZonaId = 0 or @ZonaId = Vl.ZonaId)';
    // '     And Pv.PedidoId in (18362)'+sLineBreak+
    // 'order by VL.Inicio';

  Const
    SqlEtiquetaPorVolume = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'Select Pv.PedidoId, Pd.DocumentoOriginal, Pv.PedidoVolumeId, Pv.Sequencia, Pe.CodPessoaERP, Pe.Razao, pe.Fantasia, '
      + sLineBreak +
      '       Ro.RotaId, Ro.Descricao Rotas, Dp.Data as DtPedido, De.ProcessoId, De.Descricao ProcessoEtapa,'
      + sLineBreak +
      '	   Vl.Itens, PVL.QtdSuprida, LEnd.Inicio, LEnd.Termino, LEnd.Mascara, Pr.Ordem, TotalVolumes'
      + sLineBreak + 'From PedidoVolumes Pv' + sLineBreak +
      'Inner join Pedido Pd On Pd.PedidoId = Pv.PedidoId' + sLineBreak +
      'Inner Join Pessoa Pe On Pe.PessoaId = Pd.PessoaId' + sLineBreak +
      'Inner Join RotaPessoas Pr on Pr.PessoaId = Pe.PessoaId' + sLineBreak +
      'Inner Join Rotas Ro On Ro.RotaId = Pr.RotaId' + sLineBreak +
      'Inner join Rhema_Data DP On Dp.IdData = Pd.DocumentoData' + sLineBreak +
      'Inner Join (Select PedidoId, COUNT(*) TotalVolumes From PedidoVolumes Group by PedidoId) TPv ON TPv.PedidoId = Pd.PedidoId '
      + sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid' +
      sLineBreak +
      'Left Join (Select PedidoVolumeId, Sum(QtdSuprida) QtdSuprida From PedidoVolumeLotes'
      + sLineBreak +
      '           Group By PedidoVolumeId ) PVL ON Pvl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Left Join (Select vPrd.PedidoVolumeId, Count(vPrd.ProdutoId) Itens' +
      sLineBreak + '           From (Select PedidoVolumeId, Pl.ProdutoId' +
      sLineBreak + '  		         From PedidoVolumeLotes VL' + sLineBreak +
      '		         Inner Join ProdutoLotes PL On Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '		         Inner join Produto Prd on Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak + '		         Where Vl.PedidoVolumeId = @PedidoVolumeId' +
      sLineBreak +
      '                 Group By Vl.PedidoVolumeId, Pl.ProdutoId) As VPrd' +
      sLineBreak +
      '           Group by vPrd.PedidoVolumeId ) VL ON Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Left Join (Select Pvl.PedidoVolumeId, Ee.Mascara, Min(TEnd.Descricao) Inicio, Max(TEnd.Descricao) Termino'
      + sLineBreak + '           From PedidoVolumeLotes PVL' + sLineBreak +
      '		   Inner Join Enderecamentos TEnd ON TEnd.EnderecoId = Pvl.EnderecoId'
      + sLineBreak +
      '     Inner Join EnderecamentoEstruturas EE On EE.EstruturaId = TEnd.EstruturaID'
      + sLineBreak +
      '		   Group By Pvl.PedidoVolumeId, Ee.Mascara) as LEnd On LEnd.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Where Pv.PedidoVolumeId = @PedidoVolumeId' + sLineBreak +
      '   And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)';

    // Indenficacao Etiqueta Volume Caixa Fechada
  Const
    SqlIdentificaVolumeCxaFechada = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' + sLineBreak +
      'Select Pv.PedidoId, Pd.documentooriginal, Pv.PedidoVolumeId, Pv.Sequencia,Pe.CodPessoaERP, Pe.Razao, Pe.Fantasia, '
      + sLineBreak + '       Ro.RotaId, Ro.Descricao Rotas,' + sLineBreak +
      '	      Dp.Data as DtPedido, Prd.IdProduto ProdutoId, Prd.CodProduto, Prd.Descricao, Prd.EnderecoDescricao Picking,'
      + sLineBreak + '       Pl.Descrlote, DL.Data as Vencimento,' + sLineBreak
      + '	      PVl.QtdSuprida, Tend.Endereco, TEnd.Zona,' + sLineBreak +
      '       De.ProcessoId, De.Descricao ProcessoEtapa' + sLineBreak +
      'From PedidoVolumes Pv' + sLineBreak +
      'Inner join Pedido Pd On Pd.PedidoId = Pv.PedidoId' + sLineBreak +
      'Inner Join Pessoa Pe On Pe.PessoaId = Pd.PessoaId' + sLineBreak +
      'Inner Join RotaPessoas Pr on Pr.PessoaId = Pe.PessoaId' + sLineBreak +
      'Inner Join Rotas Ro On Ro.RotaId = Pr.RotaId' + sLineBreak +
      'Inner join Rhema_Data DP On Dp.IdData = Pd.DocumentoData' + sLineBreak +
      'Inner join PedidoVolumeLotes PVL ON Pvl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join ProdutoLotes PL ON Pl.LoteId = Pvl.LoteId' +
      sLineBreak + 'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      'Inner Join vEnderecamentos TENd On Tend.EnderecoId = PVL.EnderecoId' +
      sLineBreak + 'Inner join Rhema_Data DL On DL.IdData = PL.Vencimento' +
      sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = PV.uuid' +
      sLineBreak + 'Where Pv.PedidoVolumeId = @PedidoVolumeId' + sLineBreak +
      '      And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + 'Order by Pv.PedidoVolumeId, Tend.Descricao';

  Const
    SqlTopicos = 'Declare @TopicoId Integer      = :pTopicoId' + sLineBreak +
      'Declare @Descricao VarChar(50) = :pDescricao' + sLineBreak +
      'select T.TopicoId, T.Descricao, T.Status, Rd.Data, Rh.Hora' + sLineBreak
      + 'from Topicos T' + sLineBreak +
      'Inner Join Rhema_Data RD On Rd.IdData = T.Data' + sLineBreak +
      'Inner join Rhema_Hora RH ON RH.IdHora = T.Hora' + sLineBreak +
      'Where (@TopicoId = ' + #39 + '0' + #39 + ' or TopicoId = @TopicoId) and'
      + sLineBreak + '      (@Descricao = ' + #39 + #39 +
      ' or Descricao Like @Descricao)';

  Const
    SqlFuncionalidades =
      'Declare @FuncionalidadeId Integer = :pFuncionalidadeId' + sLineBreak +
      'Declare @Descricao VarChar(50)    = :pDescricao' + sLineBreak +
      'select F.FuncionalidadeId, F.Descricao, F.Status, Rd.Data, Rh.Hora' +
      sLineBreak + 'from Funcionalidades F' + sLineBreak +
      'Inner Join Rhema_Data RD On Rd.IdData = F.Data' + sLineBreak +
      'Inner join Rhema_Hora RH ON RH.IdHora = F.Hora' + sLineBreak +
      'Where (@FuncionalidadeId = ' + #39 + '0' + #39 +
      ' or FuncionalidadeId = @FuncionalidadeId) and' + sLineBreak +
      '      (@Descricao = ' + #39 + #39 + ' or Descricao Like @Descricao)';

  Const
    SqlTopicoFuncionalidades =
      'select F.FuncionalidadeId, F.Descricao, (Case When TF.TopicoId is Not Null Then 1 Else 0 End) as Status From Funcionalidades F'
      + sLineBreak +
      'Left Join TopicoFuncionalidades TF ON TF.FuncionalidadeId = F.Funcionalidadeid and TF.TopicoId = :pTopicoId';

  Const
    SqlSaveTopicoFuncionalidade = 'Declare @TopicoId Integer = :pTopicoId' +
      sLineBreak + 'Declare @FuncionalidadeId Integer = :pFuncionalidadeId' +
      sLineBreak + 'Declare @Status Integer = :pStatus' + sLineBreak +
      'If Exists (Select FuncionalidadeId From TopicoFuncionalidades Where Funcionalidadeid = @FuncionalidadeId) Begin'
      + sLineBreak + '   If @Status = 0 ' + sLineBreak +
      '      Delete TopicoFuncionalidades Where FuncionalidadeId = @FuncionalidadeId and TopicoId = @TopicoId'
      + sLineBreak + '   Else' + sLineBreak +
      '      Update TopicoFuncionalidades Set TopicoId = @TopicoId where FuncionalidadeId = @FuncionalidadeId'
      + sLineBreak + 'End' + sLineBreak + 'else' + sLineBreak +
      '   Insert Into TopicoFuncionalidades Values (@Topicoid, @FuncionalidadeId, @Status, '
      + SqlDataAtual + ', ' + SqlHoraAtual + ')';

  Const
    SqlPerfil = 'Declare @PerfilId Integer      = :pPerfilId' + sLineBreak +
      'Declare @Descricao VarChar(50) = :pDescricao' + sLineBreak +
      'select P.PerfilId, P.Descricao, P.Status, Rd.Data, Rh.Hora' + sLineBreak
      + 'from Perfil P' + sLineBreak +
      'Inner Join Rhema_Data RD On Rd.IdData = P.Data' + sLineBreak +
      'Inner join Rhema_Hora RH ON RH.IdHora = P.Hora' + sLineBreak +
      'Where (@PerfilId = ' + #39 + '0' + #39 + ' or PerfilId = @PerfilId) and'
      + sLineBreak + '      (@Descricao = ' + #39 + #39 +
      ' or Descricao Like @Descricao)';

  Const
    SqlConsultaKardex = 'Declare @UsuarioId Integer = :pUsuarioId' + sLineBreak
      + 'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal   DateTime = :pDataFinal' + sLineBreak +
      'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'Declare @NomeEstacao Varchar(30) = :pNomeEstacao' + sLineBreak +
      'Declare @Origem  Varchar(11) = :pOrigem' + sLineBreak +
      'Declare @Destino Varchar(11) = :pDestino' + sLineBreak +
      'select Pl.ProdutoId, P.CodProduto CodigoERP, P.Descricao, Pl.LoteId, Pl.DescrLote, Dv.Data Vencimento, Et.Descricao As EstoqueTipo,'
      + sLineBreak +
      '	      Eo.Descricao EnderecoOrigem, ESO.Mascara MascaraOrigem, K.SaldoInicialOrigem, K.Qtde Retirada, '
      + sLineBreak +
      '       ED.Descricao Destino, ESD.Mascara MascaraDestino, K.SaldoInicialDestino, K.NomeEstacao,'
      + sLineBreak + '	      U.nome Usuario, Rd.Data, RH.Hora' + sLineBreak +
      'From Kardex K' + sLineBreak +
      'Inner Join ProdutoLotes PL ON Pl.LoteId = K.LoteId' + sLineBreak +
      'Inner join Produto P ON P.IdProduto = Pl.Produtoid' + sLineBreak +
      'Left Join Rhema_Data DV On DV.IdData = Pl.Vencimento' + sLineBreak +
      'Inner Join Enderecamentos EO On EO.EnderecoId = K.EnderecoId' +
      sLineBreak +
      'Inner Join EnderecamentoEstruturas ESO ON ESO.EstruturaId = EO.EstruturaID'
      + sLineBreak +
      'Inner Join Enderecamentos ED ON ED.EnderecoId = K.EnderecoIdDestino' +
      sLineBreak +
      'Inner Join EnderecamentoEstruturas ESD ON ESD.EstruturaId = ED.EstruturaID'
      + sLineBreak + 'Inner Join EstoqueTipo ET On Et.id = K.EstoqueTipoId' +
      sLineBreak + 'Inner JOin Usuarios U On U.UsuarioId = K.UsuarioId' +
      sLineBreak + 'Left Join Rhema_Data RD ON Rd.IdData = K.Data' + sLineBreak
      + 'Left join Rhema_Hora RH On Rh.IdHora = K.Hora' + sLineBreak +
      'where (@UsuarioId = 0 or K.Usuarioid = @Usuarioid) and' + sLineBreak +
      '      (@DataInicial = 0 or @DataInicial = Rd.Data) and' + sLineBreak +
      '	  (@DataFinal = 0 or @DataFinal = Rd.Data) and' + sLineBreak +
      '	  (ObservacaoOrigem like ' + #39 + 'Movimenta��o interna%' + #39 +
      ') and ' + sLineBreak +
      '   (@CodigoERP = 0 or P.CodProduto = @CodigoERP) and ' + sLineBreak +
      '   (@NomeEstacao = ' + #39 + #39 +
      ' or K.NomeEstacao = @NomeEstacao) and ' + sLineBreak + '   (@Origem = ' +
      #39 + #39 + ' or EO.Descricao = @Origem) and ' + sLineBreak +
      '   (@Destino = ' + #39 + #39 + ' or ED.Descricao = @Destino) ' +
      sLineBreak + 'Order by Data, Hora';

  Const
    SqlGetEnderecoTipo = 'Declare @Id Integer = :pEnderecoTipoId' + sLineBreak +
      'Declare @Descricao VarChar(30) = :pDescricao' + sLineBreak +
      'Select * From EnderecoTipo' + sLineBreak +
      'Where (@Id = 0 or @Id = EnderecoTipoId) and ' + sLineBreak +
      '      (@Descricao=' + #39 + #39 + ') or (@Descricao = Descricao)';

  Const
    SqlGetPessoa = 'Declare @PessoaTipoId Integer = :pPessoaTipoId' + sLineBreak
      + 'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @CodPessoaERP Integer = :pCodPessoaERP' + sLineBreak +
      'Declare @Razao Varchar(100) = :pRazao' + sLineBreak +
      'Declare @Fantasia VarChar(100) = :pFantasia' + sLineBreak +
      'Select P.*, T.PessoaTipoId, T.Descricao, T.Status as PessoaTipoStatus, Rp.RotaId '
      + 'From Pessoa P ' +
      'Inner join PessoaTipo T On T.PessoaTipoId= P.PessoaTipoId ' +
      'Left Join RotaPessoas RP On Rp.Pessoaid = P.PessoaId' + sLineBreak +
      'Where (P.PessoaTipoID = @PessoaTipoId) and' + sLineBreak +
      '      (@PessoaId = 0 or P.PessoaId = @Pessoaid) and ' + sLineBreak +
      '      (@CodPessoaERP = 0 or P.CodPessoaERP = @CodPessoaERP) and ' +
      sLineBreak + '      (@Razao = ' + #39 + #39 +
      ' or Razao Like @Razao) and ' + sLineBreak + '      (@Fantasia = ' + #39 +
      #39 + ' or Fantasia Like @Fantasia)';

  Const
    SqlGetPessoaEndereco = 'Declare @Id Integer = :pId' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Select Pe.*, Et.EnderecotipoId, Et.Descricao As EnderecoTipoDescricao, Et.Status As EnderecoTipoStatus'
      + sLineBreak + 'From PessoaEndereco PE' + sLineBreak +
      'Inner Join EnderecoTipo Et ON Et.EnderecoTipoId = PE.EnderecoTipoId' +
      sLineBreak + 'Where (@Id = 0 or @Id = Id) and ' + sLineBreak +
      '      (@PessoaId = 0 or @PessoaId = PessoaId)';

  Const
    SqlSavePessoaEndereco = 'Declare @PessoaId Integer = :PpessoaId' +
      sLineBreak +
      'Declare @EnderecoTipoId Integer = (Select EnderecoTipoId From EnderecoTipo Where Descricao = :pEnderecoTipoDescricao)'
      + sLineBreak + 'Declare @Endereco VarChar(80) = :pEndereco' + sLineBreak +
      'Declare @Numero	VarChar(5) = :pNumero' + sLineBreak +
      'Declare @Complemento VarChar(100) = :pComplemento' + sLineBreak +
      'Declare @Referencia  VarChar(100) = :pReferencia' + sLineBreak +
      'Declare @Bairro VarChar(40)    = :pBairro' + sLineBreak +
      'Declare @Municipio VarChar(30) = :pMunicipio' + sLineBreak +
      'Declare @Uf VarChar(2) = :pUf' + sLineBreak +
      'Declare @Cep VarChar(8) = :pCep' + sLineBreak +
      'Declare @CodIbge VarChar(78) = :pCodIbge' + sLineBreak +
      'Declare @Status Integer = :pStatus' + sLineBreak +
      'If Not Exists (Select Id From PessoaEndereco Where PessoaId = @PessoaId and EnderecoTipoId = @EnderecoTipoId) Begin'
      + sLineBreak +
      '   Insert Into PessoaEndereco (PessoaId, EnderecoTipoId, Endereco, ' +
      'Numero, Complemento, Referencia, Bairro, ' +
      'Municipio, Uf, Cep, CodIbge, Status) Values (' + sLineBreak +
      '                               @PessoaId, @EnderecoTipoId,	@Endereco,	'
      + sLineBreak +
      '                               @Numero, @Complemento,	@Referencia,	@Bairro, @Municipio, @Uf, '
      + sLineBreak + '                               @Cep, @CodIbge, @Status)' +
      sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '   Update PessoaEndereco' + sLineBreak +
      '     Set Endereco    = @Endereco' + sLineBreak +
      '       , Numero      = @Numero' + sLineBreak +
      '       , Complemento = @Complemento' + sLineBreak +
      '       , Referencia  = @Referencia' + sLineBreak +
      '       , Bairro      = @Bairro' + sLineBreak +
      '       , Municipio   = @Municipio' + sLineBreak +
      '       , Uf          = @Uf' + sLineBreak + '       , Cep         = @Cep'
      + sLineBreak + '       , CodIbge     = @CodIbge' + sLineBreak +
      '       , Status      = @Status' + sLineBreak +
      '   Where PessoaId = @PessoaId and EnderecoTipoId = @EnderecoTipoId' +
      sLineBreak + 'End';

  Const
    SqlGetPessoaTelefone = 'Declare @IndFone Integer = :pIndFone' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Select * From PessoaTelefone' + sLineBreak +
      'Where (@IndFone = 0 or @IndFone = IndFone) and ' + sLineBreak +
      '      (@PessoaId = 0 or @PessoaId = PessoaId)';

  Const
    SqlSavePessoaTelefone = 'Declare @IndFone Integer = :pIndFone' + sLineBreak
      + 'Declare @PessoaId Integer = :PpessoaId' + sLineBreak +
      'Declare @Tipo VarChar(20) = :pTipo' + sLineBreak +
      'Declare @Telefone VarChar(80) = :pTelefone' + sLineBreak +
      'Declare @Contato VarChar(60) = :pContato' + sLineBreak +
      'Declare @Observacao VarChar(100) = :pObservacao' + sLineBreak +
      'Declare @CodPais	VarChar(2) = :pCodPais' + sLineBreak +
      'If Not Exists (Select Id From PessoaTelefone Where PessoaId = @PessoaId and IndFone = @IndFone) Begin'
      + sLineBreak +
      '   Insert Into PessoaTelefone (IndFone, PessoaId, Tipo, Telefone, Contato, Observacao, CodPais) Values ('
      + sLineBreak +
      '                               @IndFone, @PessoaId, @Tipo,	@Telefone,	@Contato, @Observacao, @CodPais)'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '   Update PessoaTelefone' + sLineBreak + '     Set Tipo        = @Tipo' +
      sLineBreak + '       , Telefone    = @Telefone' + sLineBreak +
      '       , Contato     = @Contato' + sLineBreak +
      '       , Observacao  = @Observacao' + sLineBreak +
      '       , CodPais     = @CodPais' + sLineBreak +
      '   Where PessoaId = @PessoaId and IndFone = @IndFone' +
      sLineBreak + 'End';

  Const
    SqlSaveRotaPessoa = 'Declare @RotaId   Integer = :pRotaId' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak + 'If @RotaId = 0' +
      sLineBreak + '   Delete From RotaPessoas Where Pessoaid = @PessoaId' +
      sLineBreak + 'Else Begin' + sLineBreak +
      '   If Exists (Select RotaId From RotaPessoas Where PessoaId = @PessoaId)'
      + sLineBreak +
      '      Update RotaPessoas Set RotaId = @RotaId Where PessoaId = @PessoaId'
      + sLineBreak + '   Else' + sLineBreak +
      '      Insert Into RotaPessoas (PessoaId, RotaId, Ordem, DtInclusao, HrInclusao) Values'
      + sLineBreak +
      '      (@PessoaId, @RotaId, (Select Coalesce(Max(Ordem), 0) From RotaPessoas Where RotaId = @Rotaid), 44444, 912 )'
      + sLineBreak + 'End';

  Const
    SqlRota = 'select R.RotaId, R.Descricao, R.GoogleMaps, R.Latitude, R.Longitude, Format(Rd.Data, '
      + #39 + 'dd/MM/yyyy' + #39 + ') as DtInclusao,  ' + sLineBreak +
      'convert(varchar(5),Rh.Hora, 108) as HrInclusao, R.Status ' + sLineBreak +
      ', (Select Count(*) From RotaPessoas WHere RotaId = R.RotaId) as NrParticipante '
      + sLineBreak + 'From Rotas R' + sLineBreak +
      'Left Join Rhema_Data RD ON RD.IdData = R.DtInclusao' + sLineBreak +
      'Left Join Rhema_Hora RH ON RH.IdHora = R.HrInclusao';

  Const
    SqlRotaPessoaOLD =
      'select RP.RotaId, P.PessoaId, P.CodPessoaERP, P.Razao, Rp.Ordem' +
      sLineBreak + 'From Pessoa P' + sLineBreak +
      'Inner Join RotaPessoas RP On Rp.PessoaId = P.PessoaId' + sLineBreak +
      'Where (@RotaID = 0 or RotaId = @RotaId) and ' + sLineBreak +
      '      (@PessoaId=0 or @Pessoaid=P.PessoaId)';

  Const
    SqlRotaDesativar =
      'If (Select Status From Rotas Where RotaId = @RotaId) = 1 Begin' +
      sLineBreak + '   Update Rotas Set Status = 0 Where RotaId = @RotaId' +
      sLineBreak + '   Delete From RotaPessoas Where RotaId = @RotaId' +
      sLineBreak + 'End' + sLineBreak + 'Else' + sLineBreak +
      '   Update Rotas Set Status = 1 Where RotaId = @RotaId';

  Const
    SqlInsUpdRotaParticipante = 'Declare @RotaId Integer   = :pRotaId' +
      sLineBreak + 'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @Posicao Integer  = :pPosicao' + sLineBreak +
      'If Exists (Select PessoaId From RotaPessoas Where PessoaId = @PessoaId) Begin'
      + sLineBreak +
      '   Update RotaPessoas Set Ordem = Ordem + 1 Where RotaId = @RotaId and Ordem >= @Posicao'
      + sLineBreak +
      '   Update RotaPessoas Set RotaId = @RotaId, Ordem = (Case When @Posicao = 0 then (Select Coalesce(Max(Ordem), 0)+1'
      + sLineBreak +
      '                                            From RotaPessoas Where RotaId = @RotaId)'
      + sLineBreak +
      '                                          Else @Posicao End) where PessoaId = @PessoaId'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin ' + sLineBreak +
      '   If @Posicao > 0' + sLineBreak +
      '      Update RotaPessoas Set Ordem = Ordem + 1 Where RotaId = @Rotaid and Ordem >= @Posicao'
      + sLineBreak + '   Insert into RotaPessoas Values (@PessoaId, @RotaId, ' +
      sLineBreak + '               (Case When @Posicao = 0 then' + sLineBreak +
      '                   (Select Coalesce(Max(Ordem), 0)+1 From RotaPessoas Where RotaId = @RotaId) '
      + sLineBreak + '                Else @Posicao End), ' + SqlDataAtual +
      ', ' + SqlHoraAtual + ')' + sLineBreak + 'End';

  Const
    SqlRotaParticipante = 'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'select P.pessoaid, P.codpessoaerp, P.razao, P.Fantasia, Rp.rotaid, ordem'
      + sLineBreak + 'from RotaPessoas Rp' + sLineBreak +
      'Inner join Pessoa P On P.PessoaId = Rp.PessoaId' + sLineBreak +
      'Where (@RotaId = 0 or @RotaId = Rp.RotaId) and (@Pessoaid=0 or @PessoaId = RP.PessoaId)'
      + sLineBreak + 'Order by P.Razao';

  Const
    SqlGetVeiculo = 'Declare @VeiculoId Integer = :pVeiculoId' + sLineBreak +
      'Declare @Placa VarChar(8) = :pPlaca' + sLineBreak +
      'Declare @TransportadoraId Integer = :pTransportadoraId' + sLineBreak +
      'Select V.*, P.Razao as Transportadora' + sLineBreak + 'From Veiculos V' +
      sLineBreak + 'Left Join Pessoa P On P.PessoaId = V.TransportadoraId' +
      sLineBreak + 'Where (@VeiculoId = 0 or VeiculoId = @VeiculoId) And ' +
      sLineBreak + '      (@Placa = ' + #39 + #39 + ' or @Placa = Placa) And ' +
      sLineBreak +
      '      (@TransportadoraId = 0 or @TransportadoraId = V.TransportadoraId)';

  Const
    SqlGetVeiculoPesquisa =
      'select V.VeiculoId, V.Placa, V.Tipo, V.Marca, V.Modelo, V.Cor, ' +
      sLineBreak +
      'Cast(V.TaraKg as Decimal(15,3)) as TaraKg, Cast(CapacidadeKg as Decimal(15,3)) Capacidade, '
      + sLineBreak +
      'Cast((V.Altura*V.Largura*V.Comprimento*V.Aproveitamento/100) as decimal(15,3)) as Volume,'
      + sLineBreak + 'V.TransportadoraId, P.Razao Transportadora, V.Status' +
      sLineBreak + 'From Veiculos V' + sLineBreak +
      'Left Join Pessoa P On P.PessoaId = V.TransportadoraId'; // +sLineBreak+

    // 'Where (@VeiculoId = 0 or V.VeiculoId = @VeiculoId) and (@TransportadoraId = 0 or P.PessoaId = V.TransportadoraId) or '+sLineBreak+
    // '      (@Transportadora = '+#39+#39+' or (P.Razao Like @Transportadora or P.Fantasia like @Transportadora))';
  Const
    SqlConsPlanilhaCega = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak
      + 'select PIt.PedidoId, PIt.PedidoItemId, Pl.LoteId, Pl.ProdutoId, Prd.CodProduto CodigoERP, '
      + sLineBreak +
      'Prd.Descricao DescrProduto, Prd.UnidadeSigla, Prd.QtdUnid, Prd.UnidadeSecundariaSigla, FatorConversao, '
      + sLineBreak +
      'Prd.EnderecoDescricao, Prd.PesoLiquido, Prd.Altura, Prd.Largura, Prd.Comprimento, Prd.Volume,'
      + sLineBreak +
      'Pl.DescrLote, DF.Data as Fabricacao, DV.Data as Vencimento  ' +
      sLineBreak +
      ', RD.Data as DtEntrada, Rh.Hora HrEntrada, PIt.QtdXml, De.Descricao ProcessoEtapa'
      + sLineBreak + 'From PedidoItens PIt' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Pit.PedidoId' + sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      'Inner Join Rhema_Data DF On DF.IdData = Pl.Fabricacao ' + sLineBreak +
      'Inner Join Rhema_Data DV On DV.IdData = Pl.Vencimento ' + sLineBreak +
      'Inner join Rhema_Data RD on Rd.IdData = Pl.DtEntrada' + sLineBreak +
      'Inner Join Rhema_Hora RH on Rh.IdHora = Pl.HrEntrada' + sLineBreak +
      'Left join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Where Pit.PedidoId = @PedidoId and Pit.QtdXml <> 0 and ' + sLineBreak +
      'De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and De.ProcessoId in (1, 4, 5)';

  Const
    AtualizaStatusPedido =
      'Declare @PedidoId Int = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = :pPedidoVolumeId)'
      + sLineBreak + 'Declare @UsuarioId Int = :pUsuarioId' + sLineBreak +
      'Declare @Terminal Varchar(50) = :pTerminal' + sLineBreak +
      'Declare @PedidoStatus Integer = ' + sLineBreak +
      '(select Min(DE.ProcessoId)' + sLineBreak + 'From PedidoVolumes PV' +
      sLineBreak +
    // Desativado em 22/07/2022 sem necessidada aparente
    // 'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId'+sLineBreak+
      'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid' + sLineBreak +
      'where ((@PedidoId=0 or Pv.PedidoId = @PedidoId)) and' + sLineBreak +
      '	   DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = PV.uuid and Status = 1) )'
      + sLineBreak +
      'if Not Exists (Select ProcessoId from DocumentoEtapas where Documento = (Select Uuid From Pedido Where PedidoId = @Pedidoid) and ProcessoId = @PedidoStatus and Status = 1)'
      + sLineBreak +
      '   Insert Into DocumentoEtapas Values ((Select Uuid From Pedido Where PedidoId = @Pedidoid), @PedidoStatus, @UsuarioId, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'
      + sLineBreak +
      '                                       (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), GetDate(), @Terminal, 1)';

  Const
    SqlPedidoCarga = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @OperacaoTipoId Integer = :pOperacaoTipoId' + sLineBreak + ' ' +
      sLineBreak +
      'Select Ped.PessoaId, Ped.CodPessoaERP, Ped.Razao, Ped.Fantasia, Ped.Ordem, '
      + sLineBreak +
      '      COUNT(Ped.PedidoId) TotPed, Sum(Coalesce(Etapa.TCxaFechada, 0)) as TVolCxaFechada, Sum(Coalesce(Etapa.TCxaFracionada, 0)) TVolFracionado'+sLineBreak + '   , Sum(PCub.Peso) Peso, Sum(PCub.Volm3) Volm3'+sLineBreak+
      'Into #Pedidos'+sLineBreak+
      'From (' + sLineBreak +
      'select Ped.PedidoId, Op.OperacaoTipoId, P.Pessoaid, P.CodPessoaERP, P.Razao,'
      + sLineBreak +
      '       P.Fantasia, Rp.Ordem, Rp.Rotaid, ArmazemId, Cast(Ped.uuid as Varchar(36)) as uuid'
      + sLineBreak + 'From pedido Ped' + sLineBreak +
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId' +
      sLineBreak + 'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId' +
      sLineBreak + 'Left Join RotaPessoas RP On Rp.PessoaId = P.Pessoaid' +
      sLineBreak + 'Left Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      'Where (@DataIni=0 or Rd.Data >= @DataIni) and (@DataFin=0 or Rd.Data <= @DataFin) And (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId) and'
      + sLineBreak + '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' +
      sLineBreak + '      (@PessoaId = 0 or P.PessoaId = @PessoaId) and' +
      sLineBreak + '				  (@Razao = ' + #39 + #39 +
      ' or P.Razao Like @Razao) and' + sLineBreak +
      '      (@RotaId = 0 or @RotaId = RP.RotaId) and (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId)) Ped'
      + sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid'
      + sLineBreak +
      'Left Join (Select Pv.PedidoId, Sum((Case When EmbalagemId Is Null then 1 Else 0 End)) TCxaFechada,'
      + sLineBreak +
      '                               Sum((Case When EmbalagemId Is not Null then 1 Else 0 End)) TCxaFracionada,'
      + sLineBreak +
      '				               Sum((Case When Etapa.ProcessoId = 13 then 1 Else 0 End)) Cancelado'
      + sLineBreak + '			        From Pedido Ped' + sLineBreak +
      '			        Left Join PedidoVolumes PV On Pv.PedidoId = Ped.PedidoId' +
      sLineBreak +
      '			        Left Join vDocumentoEtapas Etapa On Etapa.Documento = Pv.uuid and Etapa.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '			        Group by Pv.PedidoId) Etapa On Etapa.PedidoId = Ped.PedidoId'
      + sLineBreak + 'Left Join (Select Vp.PedidoId, Count(Produtoid) as Itens'
      + sLineBreak + '           From PedidoProdutos VP' + sLineBreak +
      '		         Group by Vp.PedidoId) as PP On Pp.PedidoId = Ped.PedidoId' +
      sLineBreak +
      'Left Join (Select Vp.PedidoId, Sum(Vl.Quantidade) as Demanda, Sum(Vl.QtdSuprida) as QtdSuprida'
      + sLineBreak + '           From PedidoVolumes VP' + sLineBreak +
      '           Inner Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Vp.PedidoVolumeId'
      + sLineBreak +
      '		         Inner Join ProdutoLotes Pl On Pl.LoteId = Vl.Loteid' +
      sLineBreak +
      '		         Group by Vp.PedidoId) as VL On Vl.PedidoId = Ped.PedidoId' +
      sLineBreak +
      'Left Join (select Pv.PedidoId, Cast(Sum(Pvl.QtdSuprida*Prd.PesoLiquido)/100 as decimal(15,3)) as Peso, '
      + sLineBreak +
      '           Sum(cast(Cast(Pvl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,6))/1000000 as Decimal(15,6))) Volm3'
      + sLineBreak + '           From PedidoVolumes PV' + sLineBreak +
      '           Inner Join PedidoVolumeLotes PVL ON PVL.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      '           Inner Join ProdutoLotes PL On Pl.LoteId = PVL.LoteId' +
      sLineBreak +
      '           Inner Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak + '           Group by PV.PedidoId' + sLineBreak +
      '           ) as PCub ON PCub.PedidoId = Ped.PedidoId' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak + '      and (De.ProcessoId In (13, 14))' + sLineBreak +
      'Group by Ped.PessoaId, Ped.CodPessoaERP, Ped.Razao, Ped.Fantasia, Ped.Ordem' +sLineBreak+
      'Select * from #Pedidos'+sLineBreak+
      'Order by Razao';

  Const
    SqlGetCargas = 'Declare @CargaId Integer = :pCargaid' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId;' + sLineBreak +
      'Select C.CargaId, C.RotaId, R.Descricao Rota, C.transportadoraid, T.Razao Transportadora,'+sLineBreak +
      '       C.VeiculoId, V.Placa, V.Modelo, V.Marca, V.Cor, C.MotoristaId, M.Razao Motorista, C.UsuarioId,'+ sLineBreak +
      '	      U.nome Usuario, C.Status, C.uuid, De.ProcessoId, De.Descricao Processo'+ sLineBreak +
      '      ,C.Dtinclusao, C.HrInclusao,' + sLineBreak +
      '	     (Case When (Cf.PedidoVolumeId Is Null) or (Cc.PedidoVolumeId Is Not Null) Then 0 Else 1 End) EmConferencia,'+ sLineBreak +
      '   	  (Case When Cc.PedidoVolumeId Is Null Then 0 Else 1 End) Carregando, '+sLineBreak + '		    (Case When De.ProcessoId = 16 and' + sLineBreak +
      '		          Exists (Select Processo From CargaCarregamento' + sLineBreak
      + '		          where cargaid = C.cargaid And processo = ' + #39 + 'CO' +#39 + ') then 1' + sLineBreak +
      '				When (De.ProcessoId in (16, 18) and' + sLineBreak +
      '		          Exists (Select Processo From CargaCarregamento' + sLineBreak
      + '		          where cargaid = C.cargaid And processo = ' + #39 + 'CA' +#39 + ')) then 2' + sLineBreak +
      '				Else 0 End) StatusOper, Cp.TPedido, Cv.TVolume, CUnid.TUnidade' + sLineBreak +
      'from Cargas C' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = C.Uuid' + sLineBreak +
      'Inner join Rotas R On R.RotaId = C.RotaId' + sLineBreak +
      'Left Join Pessoa T ON T.PessoaId = C.transportadoraid' + sLineBreak +
      'Inner Join Pessoa M On M.Pessoaid = C.motoristaid' + sLineBreak +
      'Inner Join Veiculos V ON V.VeiculoId = C.veiculoid' + sLineBreak +
      'Inner Join usuarios U On U.UsuarioId = C.Usuarioid' + sLineBreak +
      'Inner Join (Select CargaId, Count(*) TPedido' + sLineBreak +
      '            From CargaPedidos Cp' + sLineBreak +
      '			Group by CargaId) Cp On Cp.CargaId = C.CargaId' + sLineBreak +
      'Inner Join (Select Cp.CargaId, Count(Pv.PedidoVolumeId) TVolume' +sLineBreak +
      '            From CargaPedidos Cp' + sLineBreak +
      '			Inner join PedidoVolumes Pv On Pv.PedidoId = Cp.pedidoId'+sLineBreak +
      '			Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid' +sLineBreak +
      '			Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas' +sLineBreak +
      '                                where Documento = Pv.uuid and Status = 1) and De.ProcessoId Not in (15,31)'+sLineBreak+
      '		    Group by Cp.CargaId) Cv On Cv.CargaId = C.CargaId'+sLineBreak +
      'Inner Join (Select Cp.CargaId, Sum(Vl.QtdSuprida) TUnidade' + sLineBreak
      + '            From CargaPedidos Cp' + sLineBreak +
      '			Inner join PedidoVolumes Pv On Pv.PedidoId = Cp.pedidoId' +sLineBreak +
      '			Inner Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'+ sLineBreak +
      '			Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid' +sLineBreak +
      '			Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas' +sLineBreak +
      '                                where Documento = Pv.uuid and Status = 1) and De.ProcessoId Not in (15,31)'+sLineBreak +
      '		    Group by Cp.CargaId) CUnid On CUnid.CargaId = C.CargaId'+sLineBreak +
      'Left Join (Select Top 1 CargaId, PedidoVolumeId From CargaCarregamento'+sLineBreak +
      '		         Where cargaid = @CargaId and Processo = ' + #39 + 'CO' + #39 + ') Cf On Cf.CargaId = C.CargaId' + sLineBreak +
      'Left Join (Select Top 1 CargaId, PedidoVolumeId From CargaCarregamento' +sLineBreak +
      '		         Where cargaid = @CargaId and Processo = ' + #39+'CA' + #39 + ') Cc On Cc.CargaId = C.CargaId ' + sLineBreak +
      'Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas ' + sLineBreak +
      '                    where Documento = C.uuid and Status = 1) and (@ProcessoId = 0 or @ProcessoId = DE.ProcessoId)';

  Const
    SqlCargaCarregarPedido =
      'select Pc.CargaId, Pc.PedidoId, P.PessoaId, P.Razao, Rp.Ordem, sum(Case When Vlm.EmbalagemId Is Null then 1 Else 0 End) as VlmCxaFechada, '
      + sLineBreak +
      'Sum(Case When Vlm.EmbalagemId Is Not Null then 1 Else 0 End) as VlmCxaFracionado'
      + sLineBreak + 'From CargaPedidos Pc' + sLineBreak +
      'Inner Join Pedido Ped ON Ped.PedidoId = Pc.PedidoId' + sLineBreak +
      'Inner Join PedidoVolumes Vlm On Vlm.PedidoId = Ped.PedidoId' + sLineBreak
      + 'Inner Join Pessoa P On P.Pessoaid = Ped.PessoaId' + sLineBreak +
      'Inner Join RotaPessoas RP ON Rp.PessoaId = P.PessoaId' + sLineBreak +
      'Left Join vDocumentoEtapas De On De.Documento = Vlm.uuid' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas Where Documento = Vlm.Uuid and Status = 1) and De.ProcessoId <> 15'
      + sLineBreak + '      And Pc.CargaId = :CargaId' + sLineBreak +
      'Group by Pc.CargaId, Pc.PedidoId, P.PessoaId, P.Razao, Rp.Ordem' +
      sLineBreak + 'Order by Rp.Ordem, Pc.PedidoId';

  Const
    SqlCargaCarregarCliente =
      'select Pc.CargaId, P.PessoaId, P.Razao, Rp.Ordem, Count(Ped.PedidoId) QtdPedido'
      + sLineBreak + 'From CargaPedidos Pc' + sLineBreak +
      'Inner Join Pedido Ped ON Ped.PedidoId = Pc.PedidoId' + sLineBreak +
      'Inner Join Pessoa P On P.Pessoaid = Ped.PessoaId' + sLineBreak +
      'Inner Join RotaPessoas RP ON Rp.PessoaId = P.PessoaId' + sLineBreak +
      'Left Join vDocumentoEtapas De On De.Documento = Ped.uuid' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas Where Documento = Ped.Uuid and Status = 1) and De.ProcessoId <> 15'
      + sLineBreak + '      And Pc.CargaId = :CargaId' + sLineBreak +
      'Group by Pc.CargaId, Pc.PedidoId, P.PessoaId, P.Razao, Rp.Ordem' +
      sLineBreak + 'Order by Rp.Ordem';

  Const
    SqlCargaCarregarVolumes = 'Declare @Cargaid Integer  = :pCargaId' +
      sLineBreak + 'Declare @Pessoaid Integer = :pPessoaId' + sLineBreak +
      'Declare @Processo Char(2) = :pProcesso' + sLineBreak +
      'select Pc.CargaId, Ped.PedidoId, Vlm.PedidoVolumeId, Ped.PessoaId, ' +
      sLineBreak + '       Coalesce(Vlm.EmbalagemId, 0) EmbalagemId,' +
      sLineBreak +
      '(Case When CC.PedidoVolumeId Is Not Null then 1 Else 0 End) As Conferido'
      + sLineBreak + '       , Cc.Data, Cc.Hora' + sLineBreak +
      'From CargaPedidos Pc' + sLineBreak +
      'Inner Join Pedido Ped ON Ped.PedidoId = Pc.PedidoId' + sLineBreak +
      'Inner Join PedidoVolumes Vlm On Vlm.PedidoId = Ped.PedidoId' + sLineBreak
      + 'Left Join vDocumentoEtapas De On De.Documento = Vlm.uuid' + sLineBreak
      + 'Left Join CargaCarregamento CC ON Cc.CargaId = Pc.CargaId and CC.PedidoVolumeid = Vlm.PedidoVolumeId And CC.Processo = @Processo'
      + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas Where Documento = Vlm.Uuid and Status = 1) and De.ProcessoId <> 15'
      + sLineBreak + '      And Pc.CargaId = @CargaId' + sLineBreak +
      '      And (@PessoaId = 0 or @PessoaId = Ped.PessoaId)' + sLineBreak +
    // '      And CC.Processo = @Processo'+sLineBreak+
      'Order by Conferido, Pc.PedidoId, Vlm.PedidoVolumeId';

  Const
    SqlRelCargaResumo = 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal   DateTime = :pDataFinal' + sLineBreak +
      'Declare @ProcessoId  Integer  = :pProcessoId' + sLineBreak +
      'Declare @RotaIdInicial Integer = :pRotaIdInicial' + sLineBreak +
      'Declare @RotaIdFinal   Integer = :pRotaIdFinal' + sLineBreak +
      'Declare @Pendente      Integer = :pPendente' + sLineBreak +
      'select De.ProcessoId, C.transportadoraid, Pes.Razao Transportadora, V.Placa,'
      + sLineBreak +
      '       C.motoristaid, Pm.Razao Motorista, C.DtInclusao Data, C.UsuarioId, U.Nome,'
      + sLineBreak +
      '	      De.Descricao Processo, Cp.QtdPedido, Cv.QtdVolume, Cc.QtdVolumeCarregado,'
      + sLineBreak + '       C.*' + sLineBreak + 'from cargas C' + sLineBreak +
      'Inner join vDocumentoEtapas De On De.Documento = C.Uuid' + sLineBreak +
      'Inner join Pessoa Pes on Pes.PessoaId = C.transportadoraid and Pes.PessoaTipoID = 3'
      + sLineBreak + 'Inner Join Veiculos V On V.VeiculoId = C.VeiculoId' +
      sLineBreak +
      'Inner join Pessoa Pm On Pm.PessoaId = C.motoristaid and Pm.PessoaTipoID = 4'
      + sLineBreak + 'Inner join Usuarios U on U.UsuarioId = C.UsuarioId' +
      sLineBreak +
      'Inner Join (Select CargaId, Count(*) QtdPedido From CargaPedidos' +
      sLineBreak + '            Group by CargaId) Cp On Cp.CargaId = C.CargaId'
      + sLineBreak + 'Inner Join (Select CargaId, Count(*) QtdVolume' +
      sLineBreak + '            From CargaPedidos Cp' + sLineBreak +
      'Inner Join PedidoVolumes Pv ON Pv.PedidoId = Cp.PedidoId' + sLineBreak +
      '            Group by CargaId) Cv On Cv.CargaId = C.CargaId' + sLineBreak
      + 'Left Join (Select CargaId, Count(*) QtdVolumeCarregado' + sLineBreak +
      '            From CargaCarregamento Cc' + sLineBreak +
      'Inner Join PedidoVolumes Pv ON Pv.PedidoVolumeId = Cc.PedidoVolumeId' +
      sLineBreak + '            Group by CargaId) CC On CC.CargaId = C.CargaId'
      + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = C.uuid and Status = 1)'
      + sLineBreak + '  and (@ProcessoId  = 0 or De.ProcessoId = @ProcessoId)' +
      sLineBreak +
      '  And (@Pendente = 0 or (@Pendente=1 and De.Processoid In (16)))' +
      sLineBreak + '  and (@DataInicial = 0 or C.dtinclusao >= @DataInicial)' +
      sLineBreak + '  and (@DataFinal   = 0 or C.dtinclusao <= @DataFinal)' +
      sLineBreak + '  And (@RotaIdInicial = 0 or (C.RotaId>=@RotaIdInicial))' +
      sLineBreak + '  And (@RotaIdFinal = 0 or (C.RotaId<=@RotaIdFinal))' +
      sLineBreak + 'Order By C.CargaId';

  Const
    SqlRelPedidosParaCargas = 'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @RotaId Integer       = :pRotaId' + sLineBreak +
      'Declare @ProcessoId Integer   = :pProcessoId' + sLineBreak +
      'Declare @ZonaId Integer       = :pZonaId' + sLineBreak +
      'Declare @CodPessoaERP Integer = :pCodPessoaERP' + sLineBreak +
      'select DocumentoData, CodPessoaERP, Fantasia, ' + sLineBreak +
      '       PNF.NotaFiscal NotaFiscalERP, DocumentoOriginal, Ped.PedidoId, ' + sLineBreak +
      '       Vl.QtdVolume, Ped.Processo, Vl.Zona' + sLineBreak +
      'from vPedidos Ped' + sLineBreak +
      'Left Join (Select PedidoId, Count(*) QtdVolume From PedidoVolumes' +sLineBreak +
      '           Group by PedidoId) Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join (select PedidoId, Pl.Zona, Pl.ZonaId, Count(Distinct Pv.PedidoVolumeId) QtdVolume' + sLineBreak +
      '           From PedidovolumeLotes vl' + sLineBreak +
      '           inner join PedidoVOlumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeid' + sLineBreak +
      '           Inner join vProdutoLotes Pl On Pl.Loteid = vl.Loteid' + sLineBreak +
      'Inner Join vDocumentoEtapas Dev On Dev.Documento = Pv.uuid'+sLineBreak+
		    'Where Dev.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'+sLineBreak+
		     'And Dev.ProcessoId Not In (15, 31)'+sLineBreak+
      '		         Group by PedidoId, Pl.Zona, Pl.ZonaId) Vl On Vl.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join vPedidoNotaFiscalPrincipal PNF On PNF.PedidoId =  Ped.PedidoId'
      + sLineBreak + 'where operacaotipoid = 2  --NotaFiscalERP is not null' +
      sLineBreak +
      '  and Ped.OperacaoTipoId = 2 '
      + sLineBreak +
      '  And (@DataInicial = 0 or DocumentoData >= @DataInicial) ' + sLineBreak
      + '  And (@DataFinal = 0 or DocumentoData <= @DataFinal) ' + sLineBreak +
      '  And (@CodPessoaERP = 0 or Ped.CodPessoaERP = @CodPessoaERP)' +
      sLineBreak + '  And (@RotaId = 0 or RotaId =  @Rotaid) ' + sLineBreak +
      '  And (@ZonaId = 0 or Vl.ZonaId = @ZonaId)' + sLineBreak +
      '  And (@ProcessoId = 0 or (@ProcessoId<>13 and Ped.ProcessoId =  @ProcessoId)'
      + sLineBreak +
      '       or (@ProcessoId=13 and (Ped.ProcessoId >= 13 and Ped.ProcessoId Not in (15,31))) )'
      + sLineBreak + 'order by documentodata, Ped.PedidoId, PNF.NotaFiscal';

  Const
    SqlRelPedidosParaCargasNFs = 'Declare @DataInicial DateTime = :pDataInicial'
      + sLineBreak + 'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak
      + 'Declare @RotaId Integer       = :pRotaId' + sLineBreak +
      'Declare @ProcessoId Integer   = :pProcessoId' + sLineBreak +
      'Declare @ZonaId Integer       = :pZonaId' + sLineBreak +
      'Declare @CodPessoaERP Integer = :pCodPessoaERP' + sLineBreak +
      'Select PNF.*' + sLineBreak + 'From PedidoNotaFiscal PNF' + sLineBreak +
      'Inner Join (Select NF.PedidoId, Count(*) TPed' + sLineBreak +
      'From PedidoNotaFiscal NF' + sLineBreak + 'Inner Join (' + sLineBreak +
      'select Ped.PedidoId' + sLineBreak + 'from vPedidos Ped' + sLineBreak +
      'Inner join vDocumentoEtapas De on De.Documento = Ped.uuid' + sLineBreak +
      'Left Join (Select PedidoId, Count(*) QtdVolume From PedidoVolumes' +
      sLineBreak +
      '           Group by PedidoId) Pv On Pv.PedidoId = Ped.PedidoId' +
      sLineBreak +
      'Left Join (select PedidoId, Pl.Zona, Pl.ZonaId, Count(Distinct Pv.PedidoVolumeId) QtdVolume'
      + sLineBreak + '           From PedidovolumeLotes vl' + sLineBreak +
      '           inner join PedidoVOlumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeid'
      + sLineBreak +
      '           Inner join vProdutoLotes Pl On Pl.Loteid = vl.Loteid' +
      sLineBreak +
      '		         Group by PedidoId, Pl.Zona, Pl.ZonaId) Vl On Vl.PedidoId = Ped.PedidoId'
      + sLineBreak + 'where operacaotipoid = 2  --NotaFiscalERP is not null' +
      sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak + '  And (@DataInicial = 0 or DocumentoData >= @DataInicial)'
      + sLineBreak + '  And (@DataFinal = 0 or DocumentoData <= @DataFinal)' +
      sLineBreak +
      '  And (@CodPessoaERP = 0 or Ped.CodPessoaERP = @CodPessoaERP)' +
      sLineBreak + '  And (@RotaId = 0 or RotaId =  @Rotaid)' + sLineBreak +
      '  And (@ZonaId = 0 or Vl.ZonaId = @ZonaId)' + sLineBreak +
      '  And (@ProcessoId = 0 or (@ProcessoId<>13 and Ped.ProcessoId =  @ProcessoId)'
      + sLineBreak +
      '       or (@ProcessoId=13 and (Ped.ProcessoId >= 13 and Ped.ProcessoId Not in (15,31))) )'
      + sLineBreak + 'Group by Ped.PedidoId' + sLineBreak +
      ') Ped On Ped.PedidoId = NF.PedidoId' + sLineBreak +
      'Group by Nf.PedidoId' + sLineBreak +
      'having Count(Nf.PedidoId) > 1) Ped On Ped.PedidoId = PNF.PedidoId' +
      sLineBreak + 'Order by Ped.PedidoId, NotaFiscal';

  Const
    SqlRelCargaAnaliseConsolidadaOLD = 'Declare @PedidoId Integer = :pPedidoId'
      + sLineBreak + 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal DateTime  = :pDataFinal' + sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @RotaInicial Integer = :pRotaInicial' + sLineBreak +
      'Declare @RotaFinal Integer = :pRotaFinal' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @CodPessoa Integer = :pCodPessoa' + sLineBreak +
      'Declare @ProcessoId integer = :pProcessoId' + sLineBreak +
      'Declare @Ordem Integer = :pOrdem' + sLineBreak +
      'select Ped.CodPessoaERP, Fantasia, RotaId, Rota' + sLineBreak +
      '     , Count(Distinct Ped.PedidoId) TotPedido' + sLineBreak +
      '	    , Count(Pv.PedidoVolumeId) TotVolume' + sLineBreak +
      '	    , Sum((Case When De.ProcessoId >= 13 and De.ProcessoId <> 15 then 1 else 0 End)) TotVolumeExpedido'
      + sLineBreak +
      '	    , sum((Case When De.ProcessoId = 15 then 1 else 0 End)) TotVolumeCancelado'
      + sLineBreak +
      '	    , Count(Pv.PedidoVolumeId) - (Sum((Case When De.ProcessoId >= 13 and De.ProcessoId <> 15 then 1 else 0 End))+sum((Case When De.ProcessoId = 15 then 1 else 0 End))) TotVolumePendente'
      + sLineBreak +
      '	    , Sum(Vl.VolCm3) VolCm3, Sum(Vl.Volm3) VolM3, Sum(Vl.PesoKg) PesoKg'
      + sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Left Join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join vDocumentoEtapas De On De.Documento = Pv.Uuid' + sLineBreak +
      'Left Join (Select Vl.PedidoVolumeId,' + sLineBreak +
      '           Sum(cast(Cast(Vl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,3)) as Decimal(15,3))) VolCm3,'
      + sLineBreak +
      '           Sum(cast(Cast(Vl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,6))/1000000 as Decimal(15,6))) Volm3,'
      + sLineBreak +
      '           Cast(Sum(vl.QtdSuprida*Prd.PesoLiquido)/1000 as decimal(15,3)) as PesoKg'
      + sLineBreak + '           From PedidoVolumeLotes Vl' + sLineBreak +
      '      		   inner Join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '		         Inner Join Produto Prd on Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      '		         Group by Vl.PedidoVolumeId) VL On Vl.PedidoVolumeId = Pv.PedidoVolumeId and De.ProcessoId <> 15'
      + sLineBreak + 'Where (@PedidoId = 0 or Ped.PedidoId = @PedidoId)' +
      sLineBreak +
      '  And (@DataInicial = 0 or Ped.DocumentoData >= @DataInicial)' +
      sLineBreak + '  And (@DataFinal = 0 or Ped.DocumentoData <= @DataFinal)' +
      sLineBreak + '  And (@DocumentoNr=' + #39 + #39 +
      ' or Ped.DocumentoNr=@DocumentoNr)' + sLineBreak +
      '  And (@RotaInicial=0 or Ped.rotaid>=@RotaInicial)' + sLineBreak +
      '  And (@RotaFinal=0 or Ped.rotaid<=@RotaFinal)' + sLineBreak +
      '  And (@CodPessoa=0 or Ped.CodPessoaERP=@CodPessoa)' + sLineBreak +
      '  And (@ProcessoId = 0 Or Ped.ProcessoId = @ProcessoId)' + sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + '  and Ped.OperacaoTipoId = 2 and Ped.ProcessoId <> 15' +
      sLineBreak + 'Group by Ped.CodPessoaERP, Fantasia, RotaId, Rota' +
      sLineBreak + 'Order by (Case When @Ordem = 0 then Ped.CodPessoaERP' +
      sLineBreak + '               When @Ordem = 1 then Ped.Fantasia' +
      sLineBreak + '			            When @Ordem = 2 then Ped.Rota End)';

  Const
    SqlRelCargaAnaliseConsolidada =
      'Declare @DataInicial     DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal       DateTime = :pDataFinal' + sLineBreak +
      'Declare @CodPessoaERP    Integer  = :pCodPessoa' + sLineBreak +
      'Declare @RotaInicial Integer = :pRotaInicial' + sLineBreak +
      'Declare @RotaFinal Integer = :pRotaFinal' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @SomenteExpedido Integer  = :pSomenteExpedido' + sLineBreak +
      'Declare @Ordem Integer = :pOrdem' + sLineBreak +
      'select Ped.CodPessoaERP, Ped.Razao, Ped.Fantasia, Ped.RotaId, Ped.Rota' +
      sLineBreak + '     , Count(Ped.PedidoId) TotPedido' + sLineBreak +
      '     , Sum(Coalesce(Pv.TotalVolumeExpedicao,0)+Coalesce(Pv.TotalVolumeCancelado,0)+Coalesce(Pv.TotalVolumePendente,0)) TotVolume'
      + sLineBreak + '     , Sum(Pv.TotalVolumeExpedicao) TotVolumeExpedido' +
      sLineBreak + '	    , Sum(Pv.TotalVolumeCancelado) TotVolumeCancelado' +
      sLineBreak + '	    , Sum(Pv.TotalVolumePendente)  TotVolumePendente' +
      sLineBreak +
      '	    , Sum(PesoCaixa) TaraCaixa_gr, Sum(VolumeCaixa) VolumeCaixa_cm3' +
      sLineBreak +
      '	    , Sum(Pv.PesoProduto) PesoProduto_gr, Sum(Pv.CubagemProduto) CubagemProduto_cm3'
      + sLineBreak + '	    , Sum(Pv.CubagemTotal) Volcm3' + sLineBreak +
      '	    , Sum(Pv.PesoTotal) PesoTotal_gr' + sLineBreak +
      '	    , Cast(Sum(Pv.PesoTotal)/1000 as decimal(15,3)) as PesoKg' +
      sLineBreak +
      '	    , cast(Sum(Pv.CubagemTotal)/1000000 as Decimal(15,6)) Volm3' +
      sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Inner Join (Select Ped.CodPessoaERP, Pv.PedidoId' + sLineBreak +
      '                 , Sum( Case When De.ProcessoId >= 13 and De.ProcessoId Not in (15,31) then 1 Else 0 End) TotalVolumeExpedicao'
      + sLineBreak +
      '                 , Sum( Case When De.ProcessoId = 15 then 1 Else 0 End) TotalVolumeCancelado'
      + sLineBreak +
      '                 , Sum( Case When De.ProcessoId < 13 then 1 Else 0 End) TotalVolumePendente'
      + sLineBreak +
    // '				             , Sum(Case when (Pv.EmbalagemId Is Null or Pv.CaixaEmbalagemId Is Null) then 0 Else Ve.Tara End) PesoCaixa'+sLineBreak+
    // '				             , Sum(Case when (Pv.EmbalagemId Is Null or Pv.CaixaEmbalagemId Is Null) then 0 Else (Ve.Altura*Ve.Largura*Ve.Comprimento) End) VolumeCaixa'+sLineBreak+
      '				             , Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId < 13)) then 0'
      + sLineBreak + '							Else Ve.Tara End) PesoCaixa' + sLineBreak
      + '				 , Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId >= 13)) then 0'
      + sLineBreak +
      '							Else (Ve.Altura*Ve.Largura*Ve.Comprimento) End) VolumeCaixa'
      + sLineBreak +
      '				             , Sum(Vl.PesoProduto) PesoProduto , Sum(Vl.CubagemProduto) CubagemProduto'
      + sLineBreak +
    // '				             , Sum(Case when (Pv.EmbalagemId Is Null or Pv.CaixaEmbalagemId Is Null) then Vl.PesoProduto'+sLineBreak+
    // '				                        Else Vl.PesoProduto+Ve.Tara End) PesoTotal'+sLineBreak+
    // '				             , Sum(Case when (Pv.EmbalagemId Is Null or Pv.CaixaEmbalagemId Is Null) then Vl.CubagemProduto'+sLineBreak+
    // '				                        Else (Ve.Altura*Ve.Largura*Ve.Comprimento) End) CubagemTotal'+sLineBreak+
      '	           			 , Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId >= 13)) then Vl.PesoProduto'
      + sLineBreak +
      '				                       Else Vl.PesoProduto+Ve.Tara End) PesoTotal'
      + sLineBreak +
      '				            , Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId >= 13)) then Vl.CubagemProduto'
      + sLineBreak +
      '				                       Else (Ve.Altura*Ve.Largura*Ve.Comprimento) End) CubagemTotal'
      + sLineBreak + '			         From PedidoVolumes Pv' + sLineBreak +
      '			         Inner Join vPedidos Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak + '			         Inner join (Select Vl.PedidoVolumeId,' +
      sLineBreak +
      '			                            Sum(Prd.PesoLiquido*Vl.QtdSuprida) PesoProduto,'
      + sLineBreak +
      '							                        Sum(Prd.Volume*Vl.QtdSuprida) CubagemProduto'
      + sLineBreak + '			                     From PedidoVolumeLotes Vl' +
      sLineBreak +
      '						                  Inner Join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId'
      + sLineBreak +
      '						                  Inner join vProduto Prd on Prd.IdProduto = Pl.IdProduto'
      + sLineBreak +
      '						                  Where (@ZonaId=0 or (@ZonaId = Pl.ZonaId))'
      + sLineBreak +
      '						                  Group By Vl.PedidoVolumeId) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      '			         Left Join VolumeEmbalagem Ve on Ve.EmbalagemId = Pv.Embalagemid'
      + sLineBreak +
      '			         Inner join vDocumentoEtapas De On De.Documento = Pv.Uuid' +
      sLineBreak +
      '			         where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + '			           and De.ProcessoId Not in (31)' +
      sLineBreak +
      '			         Group by Ped.CodPessoaERP, Pv.PedidoId) Pv On Pv.CodPessoaERP = Ped.CodPessoaERP and Pv.Pedidoid = Ped.PedidoId'
      + sLineBreak +
      'where (@SomenteExpedido=0 or (@SomenteExpedido<>0 and Ped.ProcessoId >= 13))'
      + sLineBreak + '  And Ped.ProcessoId Not in (15,31)' + sLineBreak +
      '  And (Ped.DocumentoData >= @DataInicial and Ped.DocumentoData <= @DataFinal)'
      + sLineBreak +
      '  And (@CodPessoaERP = 0 or @CodPessoaERP = Ped.CodPessoaERP)' +
      sLineBreak + '  And (@RotaInicial = 0 or (Ped.RotaId >= @RotaInicial))' +
      sLineBreak + '  And (@RotaFinal = 0   or (Ped.RotaId <= @RotaFinal))' +
      sLineBreak + 'Group by --Ped.PedidoId,' + sLineBreak +
      '         Ped.CodPessoaERP, Ped.Razao, Ped.Fantasia, Ped.RotaId, Ped.Rota'
      + sLineBreak + 'Order by (Case When @Ordem = 0 then Ped.CodPessoaERP' +
      sLineBreak + '               When @Ordem = 1 then Ped.Fantasia' +
      sLineBreak + '			            When @Ordem = 2 then Ped.Rota End)';

  Const
    SqlRelResumoParaCarregamento =
      'Declare @DataInicial     DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal       DateTime = :pDataFinal' + sLineBreak +
      'Declare @CodPessoaERP    Integer  = :pCodPessoa' + sLineBreak +
      'Declare @RotaInicial Integer = :pRotaInicial' + sLineBreak +
      'Declare @RotaFinal Integer = :pRotaFinal' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @SomenteExpedido Integer  = :pSomenteExpedido' + sLineBreak +
      'Select Ped.CodPessoaERP, Ped.Fantasia, Pv.PedidoId, Pv.PedidoVolumeId, Pv.EmbalagemId, Pv.CaixaEmbalagemId,'
      + sLineBreak +
      '	      Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId < 13)) then 0'
      + sLineBreak + '		            		Else Ve.Tara End) PesoCaixa' +
      sLineBreak +
      '	    , Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId >= 13)) then 0'
      + sLineBreak +
      '				            Else (Ve.Altura*Ve.Largura*Ve.Comprimento) End) VolumeCaixa'
      + sLineBreak +
      '	    , Sum(Vl.PesoProduto) PesoProduto, Sum(Vl.CubagemProduto) CubagemProduto'
      + sLineBreak +
      '	    , Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId >= 13)) then Vl.PesoProduto'
      + sLineBreak +
      '		            		Else Vl.PesoProduto+Ve.Tara End) PesoTotal' +
      sLineBreak +
      '	    , Sum(Case when (Pv.EmbalagemId Is Null or (Pv.CaixaEmbalagemId Is Null And De.ProcessoId >= 13)) then Vl.CubagemProduto'
      + sLineBreak +
      '		         	    Else (Ve.Altura*Ve.Largura*Ve.Comprimento) End) CubagemTotal'
      + sLineBreak + 'From PedidoVolumes Pv' + sLineBreak +
      'Inner Join vPedidos Ped On Ped.PedidoId = Pv.PedidoId' + sLineBreak +
      'Inner join (Select Vl.PedidoVolumeId,' + sLineBreak +
      '     	             Sum(Prd.PesoLiquido*Vl.QtdSuprida) PesoProduto,' +
      sLineBreak +
      '		                 Sum(Prd.Volume*Vl.QtdSuprida) CubagemProduto' +
      sLineBreak + '            From PedidoVolumeLotes Vl' + sLineBreak +
      '            Inner Join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '            Inner join vProduto Prd on Prd.IdProduto = Pl.IdProduto' +
      sLineBreak + '            --Where (@ZonaId=0 or (@ZonaId = Pl.ZonaId))' +
      sLineBreak +
      '            Group By Vl.PedidoVolumeId) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      'Left Join VolumeEmbalagem Ve on Ve.EmbalagemId = Pv.Embalagemid' +
      sLineBreak + 'Inner join vDocumentoEtapas De On De.Documento = Pv.Uuid' +
      sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '  And (Ped.DocumentoData >= @DataInicial and Ped.DocumentoData <= @DataFinal)'
      + sLineBreak + '  and De.ProcessoId Not in (15, 31)' + sLineBreak +
      '  And (@SomenteExpedido=0 or (@SomenteExpedido<>0 and Ped.ProcessoId >= 13))'
      + sLineBreak +
      '  And (@CodPessoaERP = 0 or @CodPessoaERP = Ped.CodPessoaERP)' +
      sLineBreak + '  And (@RotaInicial = 0 or (Ped.RotaId >= @RotaInicial))' +
      sLineBreak + '  And (@RotaFinal = 0   or (Ped.RotaId <= @RotaFinal))' +
      sLineBreak +
      'Group by Ped.CodPessoaERP, Ped.Fantasia, Pv.PedidoId, Pv.PedidoVolumeId, Pv.EmbalagemId, Pv.CaixaEmbalagemId'
      + sLineBreak + 'Order by CodPessoaERP, Pv.PedidoId, Pv.PedidoVolumeId';

  Const
    SqlCargaAtualizarStatus = 'Declare @ProcessoId Integer = :pProcessoId' +
      sLineBreak + 'Declare @UsuarioId  Integer = :pUsuarioid' + sLineBreak +
      'Declare @Terminal VarChar(50) = :pTerminal' + sLineBreak +
      'Insert Into DocumentoEtapas' + sLineBreak +
      'Select C.Uuid, @ProcessoId, @UsuarioId, ' + SqlDataAtual + ', ' +
      sLineBreak + '      ' + SqlHoraAtual + ', GetDate(), @Terminal, 1' +
      sLineBreak + 'From Cargas C' + sLineBreak +
      'Inner join vDocumentoEtapas De On De.Documento = C.Uuid' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = C.uuid and Status = 1)'
      + sLineBreak +
    // '  and C.CargaId in (8977,9977, 9996)'+sLineBreak+
      'and De.ProcessoId < @ProcessoId';

  Const
    SqlRelProdutoEnderecamento =
      'select IdProduto, Prd.CodProduto, Prd.Descricao, Prd.FatorConversao Embalagem, TEnd.Descricao Endereco, Z.Descricao Zona'
      + sLineBreak + 'From Produto Prd ' + sLineBreak +
      'Left Join Enderecamentos TEnd On TEnd.EnderecoId = Prd.EnderecoId' +
      sLineBreak + 'Left Join EnderecamentoZonas Z On Z.ZonaId = TEnd.ZonaID';

    // Pegar os Produtos que precisam serem Reposto.
  Const
    SqlGetReposicaoCapacidade =
      'Declare @PercDownMaxPicking Integer = :pPercDownMaxPicking' + sLineBreak
      + 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @PickingInicial VarChar(11) = :pPickingInicial' + sLineBreak +
      'Declare @PickingFinal   Varchar(11) = :pPickingFinal' + sLineBreak +
      'Declare @Negativo       Integer     = :pNegativo' + sLineBreak +
      'Delete ReposicaoDemandaItens' + sLineBreak +
      'Insert Into ReposicaoDemandaItens ' + sLineBreak +
      'select Prd.IdProduto ProdutoId, prd.FatorConversao, 0 as CxaFechada, ' +
      sLineBreak +
      '       Prd.MaxPicking-EstPick.Qtde Fracionado, EstPallet.Qtde SaldoPalletCxaFechada, '
      + sLineBreak +
      '       EstPick.Qtde SaldoPicking, Prd.MaxPicking-EstPick.Qtde Demanda' +
      sLineBreak + 'from vProduto prd' + sLineBreak +
      'inner join (select CodigoERP, SUM(Qtde) Qtde' + sLineBreak +
      '            From vEstoque Est' + sLineBreak +
      '			where EstruturaId = 2' + sLineBreak +
      '			Group by Est.CodigoERP ) EstPick On EstPick.CodigoERP = prd.CodProduto'
      + sLineBreak + 'inner join (select CodigoERP, SUM(Qtde) Qtde' + sLineBreak
      + '            From vEstoque Est' + sLineBreak +
      '			where EstruturaId = 1' + sLineBreak +
      '			Group by Est.CodigoERP ) EstPallet On EstPallet.CodigoERP = prd.CodProduto'
      + sLineBreak +
      'where prd.ZonaID = @ZonaId And EstPick.Qtde < (prd.MaxPicking*@PercDownMaxPicking/100)'
      + sLineBreak + '  and EstPallet.Qtde > 0' + sLineBreak +
      '      And (@PickingInicial=' + #39 + #39 +
      ' or SubString(Prd.EnderecoDescricao,1,len(@PickingInicial)) >= @PickingInicial)'
      + sLineBreak + '      And (@PickingFinal=' + #39 + #39 +
      ' or SubString(Prd.EnderecoDescricao,1,len(@PickingFinal)) <= @PickingFinal)'
      + sLineBreak + ' ' + sLineBreak + 'select Prd.CodProduto, Prd.Descricao,'
      + sLineBreak +
      '   	   Prd.EnderecoId PickingId, Prd.Mascara MascaraPicking,' +
      sLineBreak +
      '	      Prd.EnderecoDescricao Picking, prd.FatorConversao Embalagem,' +
      sLineBreak + '       RDI.*, Prd.ZonaID, Prd.ZonaDescricao Zona' +
      sLineBreak + 'from reposicaodemandaitens RDI' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = RDI.ProdutoId' + sLineBreak +
      'Order by Prd.Descricao ';

    // Pegar os Produtos que precisam serem Reposto.
  Const
    SqlGetReposicaoDemanda = 'Declare @DocumentoData Date = :pDocumentoData' +
      sLineBreak + 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @PickingInicial VarChar(11) = :pPickingInicial' + sLineBreak +
      'Declare @PickingFinal   Varchar(11) = :pPickingFinal' + sLineBreak +
      'Declare @TipoGeracao Varchar(1)     = :pTipoGeracao' + sLineBreak +
      'Delete ReposicaoDemandaItens' + sLineBreak +
      'Insert Into ReposicaoDemandaItens ' + sLineBreak +
      'select Prd.IdProduto ProdutoId, Dem.EmbalagemPadrao, ' + sLineBreak +
      '       Dem.CxaFechada, Dem.Fracionado,' + sLineBreak +
      '       Coalesce(EstPallet.QtdeCxaFec, 0) SaldoPalletCxaFechada,' +
      sLineBreak +
      '   	   (Case When (Coalesce(Est.Qtde, 0)+Coalesce(ResCol.Qtde, 0)) <=0 then 0 Else (Coalesce(Est.Qtde, 0)+Coalesce(ResCol.Qtde, 0)) End) SaldoPicking,'
      + sLineBreak +
      '       (Case when Coalesce(Dem.CxaFechada, 0) > Coalesce(EstPallet.QtdeCxaFec, 0) then'
      + sLineBreak +
      '	                  Coalesce(Dem.CxaFechada, 0) - Coalesce(EstPallet.QtdeCxaFec, 0)'
      + sLineBreak +
      '		           Else 0 End) + Coalesce(Fracionado, 0) - (Coalesce(Est.Qtde, 0)+Coalesce(ResCol.Qtde, 0)) Demanda --QtdeReposicao'
      + sLineBreak +
      'From (Select Demanda.ProdutoId, Demanda.EmbalagemPadrao, Demanda.FatorConversao, -- Demanda.Quantidade,'
      + sLineBreak + '             sum(Demanda.' + #34 + 'Cx.Fechada' + #34 +
      ') ' + #34 + 'CxaFechada' + #34 + ', Sum(Demanda.Fracionado) Fracionado' +
      sLineBreak + '      From (select PP.PedidoId,' + sLineBreak +
      '                   PP.ProdutoId, PP.EmbalagemPadrao, PP.Quantidade, Prd.FatorConversao,'
      + sLineBreak +
      '                  (Case When FatorConversao > 1 then (PP.Quantidade / FatorConversao)*Prd.FatorConversao'
      + sLineBreak + '				                    Else 0 End) ' + #34 +
      'Cx.Fechada' + #34 + ',' + sLineBreak +
      '				              (Case When FatorConversao > 1 then (Quantidade % FatorConversao)'
      + sLineBreak +
      '				                    Else Quantidade End) Fracionado' + sLineBreak
      + '            from PedidoProdutos PP' + sLineBreak +
      '            Inner join (select PedidoId, rd.data DocumentoData, De.ProcessoId, P.OperacaoTipoId'
      + sLineBreak + '                        From Pedido P' + sLineBreak +
      '			                     Inner Join vDocumentoEtapas De On De.Documento = p.UUid'
      + sLineBreak +
      '						                  Inner join Rhema_Data Rd On Rd.IdData = P.DocumentoData'
      + sLineBreak +
      '						                  where DE.Horario = (Select Max(Horario) From vDocumentoEtapas'
      + sLineBreak +
      '                              where Documento = P.uuid and Status = 1) and P.OperacaoTipoId = 2) Ped on Ped.PedidoId = PP.PedidoId'
      + sLineBreak +
      '            Inner Join vProduto Prd on Prd.IdProduto = PP.ProdutoId' +
      sLineBreak + '            where DocumentoData = @DocumentoData And' +
      sLineBreak +
      '			              --(@ZonaId = 0 or Prd.ZonaID = @ZonaId) and' +
      sLineBreak +
      '                  Ped.ProcessoId = 1 and Ped.OperacaoTipoId = 2' +
      sLineBreak +
      '                  And Coalesce(Prd.SomenteCxaFechada, 0) <> 1) Demanda' +
      sLineBreak +
      '            Group by Demanda.ProdutoId, Demanda.EmbalagemPadrao, Demanda.FatorConversao ) Dem'
      + sLineBreak +
      '      Inner Join vProduto Prd On Prd.IdProduto = Dem.ProdutoId' +
      sLineBreak +
      '      Left Join (Select Produtoid, Sum(Qtde) Qtde, SUM(Qtde / FatorConversao*FatorConversao) QtdeCxaFec'
      + sLineBreak + '                 From vEstoqueProducao' + sLineBreak +
      '             	   Where Qtde > 0 and EstruturaId = 1 and (Qtde / FatorConversao)*FatorConversao > 0'
      + sLineBreak + '                   And (@TipoGeracao <> ' + #39 + 'A' +
      #39 + ' or ZonaId <> 1)' + sLineBreak +
      '            		   Group by ProdutoId,FatorConversao,FatorConversao) EstPallet On EstPallet.ProdutoId=Dem.ProdutoId and Qtde > Dem.FatorConversao --Saldo Pallet para Caixa Fechada'
      + sLineBreak + '      Left Join (Select Produtoid, Sum(Qtde) Qtde' +
      sLineBreak + '                 From vEstoqueProducao' + sLineBreak +
      '            		 Where EstruturaId = 2' + sLineBreak +
      '                 Group by ProdutoId) Est On Est.ProdutoId=Dem.ProdutoId'
      + sLineBreak +
      '     		                              --And Est.Qtde >= Dem.EmbalagemPadrao'
      + sLineBreak +
    // Incluir Estoque j� reservado para Reposi��o
      '      Left Join (Select ProdutoId, Sum(Rc.Qtde) Qtde --Reserva para Coleta'
      + sLineBreak + '                 From ReposicaoEnderecoColeta Rc' +
      sLineBreak +
      '                 Inner Join Reposicao Rep On Rep.ReposicaoId = Rc.ReposicaoId'
      + sLineBreak +
      '                 Where Rep.ProcessoId In (27,28) and Rc.QtdRepo Is Null'
      + sLineBreak +
      '                 Group by ProdutoId) ResCol On ResCol.ProdutoId = Dem.ProdutoId'
      + sLineBreak +
      '      Left Join (Select Produtoid, Sum(Qtde) Qtde, SUM(Qtde) QtdeCxaFec'
      + sLineBreak + '                 From vEstoqueProducao' + sLineBreak +
      '		             Where Qtde > 0 and EstruturaId = 1' + sLineBreak +
      '                   And (@TipoGeracao <> ' + #39 + 'A' + #39 +
      ' or ZonaId <> 1)' + sLineBreak +
      '		               Group by ProdutoId) EstDisponivel On EstDisponivel.ProdutoId=Dem.ProdutoId'
      + sLineBreak +
      'Where (Case when Coalesce(Dem.CxaFechada, 0) > Coalesce(EstPallet.QtdeCxaFec, 0) then'
      + sLineBreak +
      '               Coalesce(Dem.CxaFechada, 0) - Coalesce(EstPallet.QtdeCxaFec, 0)'
      + sLineBreak +
      '		          Else 0 End) + Coalesce(Fracionado, 0) - (Coalesce(Est.Qtde, 0)+Coalesce(ResCol.Qtde, 0)) > 0 And'
      + sLineBreak + '      (Coalesce(EstDisponivel.Qtde, 0) -' + sLineBreak +
      '	              (Case When Dem.CxaFechada>0 Then' + sLineBreak +
      '				                   (Case When Coalesce(EstPallet.QtdeCxaFec, 0) > Dem.CxaFechada then'
      + sLineBreak + '							                         Dem.CxaFechada' +
      sLineBreak +
      '								                     Else Coalesce(EstPallet.QtdeCxaFec, 0) End)'
      + sLineBreak + '				                    Else 0 End)) > 0' + sLineBreak
      + '      And (@ZonaId = 0 or Prd.ZonaID = @ZonaId)' + sLineBreak +
      '      And (@PickingInicial=' + #39 + #39 +
      ' or SubString(Prd.EnderecoDescricao,1,len(@PickingInicial)) >= @PickingInicial)'
      + sLineBreak + '      And (@PickingFinal=' + #39 + #39 +
      ' or SubString(Prd.EnderecoDescricao,1,len(@PickingFinal)) <= @PickingFinal)'
      + sLineBreak + ' ' + sLineBreak + 'select Prd.CodProduto, Prd.Descricao,'
      + sLineBreak +
      '   	   Prd.EnderecoId PickingId, Prd.Mascara MascaraPicking,' +
      sLineBreak +
      '	      Prd.EnderecoDescricao Picking, prd.FatorConversao Embalagem,' +
      sLineBreak + '       RDI.*, Prd.ZonaID, Prd.ZonaDescricao Zona' +
      sLineBreak + 'from reposicaodemandaitens RDI' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = RDI.ProdutoId' + sLineBreak +
      'Order by Prd.Descricao ' + sLineBreak + 'OPTION (RECOMPILE);';

  Const
    SqlGetReposicaoDemandaColeta =
      'Declare @TipoGeracao Varchar(1) = :pTipoGeracao' + sLineBreak +
      'select Ep.Produtoid, Ep.CodigoERP CodProduto, Ep.Produto Descricao, Prd.EnderecoId PikcingId, Prd.EnderecoDescricao Picking,'
      + sLineBreak +
      '	      Prd.Mascara MascaraPicking, Prd.ZonaId, Prd.ZonaDescricao Zona,	Ep.LoteId, Ep.DescrLote, Ep.Vencimento,'
      + sLineBreak +
      '	      Prd.FatorConversao Embalagem, Ep.EnderecoId, Ep.Endereco, ep.Mascara, Ep.EstoqueTipoId, DRI.Demanda, Ep.Qtde	Disponivel'
      + sLineBreak + 'from ReposicaoDemandaItens DRI' + sLineBreak +
      'Inner Join vEstoqueProducao Ep On Ep.ProdutoId = Dri.ProdutoId and Qtde > 0 and EstruturaId = 1'
      + sLineBreak + 'Inner join vproduto Prd on Prd.IdProduto = Ep.Produtoid' +
      sLineBreak + 'where (@TipoGeracao <> ' + #39 + 'A' + #39 +
      ' or Ep.ZonaId <> 1)' + sLineBreak +
      'Order by Ep.ProdutoId, Ep.PickingFixo Desc, Ep.Vencimento, Ep.Horario , Ep.Endereco-- Ep.DtEntrada, Ep.HrEntrada, Ep.Endereco --'
      + sLineBreak +
    // 'Order by Ep.ProdutoId, Ep.Vencimento'+sLineBreak+
      'OPTION (RECOMPILE);';

  Const
    SqlRelProdutoReposicao =
      'Select ProdutoId, Descricao, EnderecoId, Endereco, FatorConversao, EmbalagemPadrao, Quantidade, Fracionado, EstPicking,'
      + sLineBreak + '       (Fracionado-EstPicking) QtdReposicao' + sLineBreak
      + 'From' + sLineBreak +
      '   (Select PP.ProdutoId, Prd.Descricao, TEnd.EnderecoId, TEnd.Descricao Endereco, Prd.FatorConversao, PP.EmbalagemPadrao,'
      + sLineBreak + '           Sum(PP.Quantidade) Quantidade,' + sLineBreak +
      '           Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade /  Prd.FatorConversao) Else 0 End)) CaixaFechada ,'
      + sLineBreak +
      '		   Sum((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End)) Fracionado'
      + sLineBreak +
      '           , Est.Estoque EstPicking--, ((Case When Prd.FatorConversao > 1 then (PP.Quantidade %  Prd.FatorConversao) Else PP.Quantidade End) - Est.Estoque) As QtdReposicao'
      + sLineBreak + '            From Pedido Ped' + sLineBreak +
      '            Inner Join PedidoProdutos PP ON PP.PedidoId = Ped.PedidoId' +
      sLineBreak +
      '			Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId' + sLineBreak
      + '			Left Join Enderecamentos TEnd On TEnd.EnderecoId = Prd.EnderecoId'
      + sLineBreak +
      '            Inner join Rhema_Data DP On Dp.IdData = Ped.DocumentoData' +
      sLineBreak +
      '            Left  Join vDocumentoEtapas De On De.Documento = Ped.uuid' +
      sLineBreak +
      '			Left Join (Select ProdutoId, SUM(Qtde) Estoque From vEstoqueProducao where PickingFixo = 1 Group by ProdutoId) Est ON Est.ProdutoId = PP.ProdutoId'
      + sLineBreak + '			Where Ped.PedidoId in (20, 1044) --= @PedidoId' +
      sLineBreak +
      '			      And DE.Horario = (Select Max(Horario) From vDocumentoEtapas Where Documento = Ped.Uuid and Status = 1) and De.ProcessoId <> 15'
      + sLineBreak +
    // '	              and De.ProcessoId < 13'+sLineBreak+
      '   -- Inserir Parametros' + sLineBreak +
      '				  and Ped.OperacaoTipoId = 2' + sLineBreak +
      '			Group by PP.ProdutoId, Prd.Descricao, TEnd.EnderecoId, TEnd.Descricao, Prd.FatorConversao, PP.EmbalagemPadrao, Est.Estoque'
      + sLineBreak + ') as ProdReposicao' + sLineBreak +
      'where (Fracionado-EstPicking) > 0';

  Const
    SqlRelReposicaoHistorico = 'Declare @ReposicaoId Integer = :pReposicaoId' +
      sLineBreak + 'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Declare @ZonaReposicaoId Integer = :pZonaReposicaoId' + sLineBreak +
      'Declare @ZonaColetaId Integer = :pZonaColetaId' + sLineBreak +
      'Declare @UsuarioId Integer = :pUsuarioId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @DtReposicaoInicial DateTime = :pDtReposicaoInicial' + sLineBreak
      + 'Declare @DtReposicaoFinal DateTime = :pDtReposicaoFinal' + sLineBreak +
      'Declare @EnderecoColetaId Integer = :pEnderecoColetaId' + sLineBreak +
      'Declare @Divergencia integer = :pDivergencia' + sLineBreak +
      'select Rep.ReposicaoId, Rep.DtReposicao, Rep.HrReposicao, Pe.Descricao Processo,'
      + sLineBreak +
      '       Rc.EnderecoId EnderecoColetaId, Ec.Descricao EnderecoColeta, Ec.ZonaID ZonaColetaId, Ez.Descricao ZonaColeta, '
      + sLineBreak +
      '	      Pl.CodProduto, Pl.Descricao, Pl.Endereco Picking, Pl.ZonaId, Pl.Zona, Rc.LoteId, Pl.Lote, Pl.Vencimento,'
      + sLineBreak +
      '	      Rc.Qtde Demanda, Rc.QtdRepo, Rc.EstoqueTipoId, Et.Descricao EstoqueTipo, Rc.Terminal,'
      + sLineBreak +
      '	      Rc.UsuarioId, U.Nome Usuario, Rc.DtEntrada DtColeta, Rc.HrEntrada HrColeta'
      + sLineBreak + 'From Reposicao Rep' + sLineBreak +
      'Inner Join ReposicaoEnderecoColeta Rc ON Rc.reposicaoid= Rep.ReposicaoId'
      + sLineBreak +
      'Inner Join ProcessoEtapas Pe ON Pe.ProcessoId=Rep.ProcessoId' +
      sLineBreak +
      'Inner Join Enderecamentos Ec On Ec.EnderecoId = Rc.EnderecoId' +
      sLineBreak + 'Inner Join EnderecamentoZonas Ez On Ez.Zonaid = Ec.ZonaId' +
      sLineBreak + 'Inner join vProdutoLotes Pl On Pl.LoteId = Rc.LoteId' +
      sLineBreak + 'Inner join usuarios U On U.usuarioid = Rc.UsuarioId' +
      sLineBreak + 'Inner join EstoqueTipo ET On ET.Id = Rc.EstoqueTipoId' +
      sLineBreak + 'where (@ReposicaoId = 0 or @ReposicaoId = Rep.ReposicaoId)'
      + sLineBreak +
      '      And (@CodProduto = 0 or @CodProduto = Pl.CodProduto)' + sLineBreak
      + '      And (@ZonaColetaId = 0 or @ZonaColetaId = Ec.ZonaID)' +
      sLineBreak +
      '      And (@ZonaReposicaoId = 0 or @ZonaReposicaoId = Pl.ZonaID)' +
      sLineBreak + '      And (@UsuarioId = 0 or @UsuarioId = U.UsuarioId)' +
      sLineBreak + '      And (@ProcessoId = 0 Or @ProcessoId = Rep.ProcessoId)'
      + sLineBreak +
      '      And (@DtReposicaoInicial = 0 or Rep.DtReposicao >= @DtReposicaoInicial)'
      + sLineBreak +
      '      And (@DtReposicaoFinal = 0 or Rep.DtReposicao <= @DtReposicaoFinal)'
      + sLineBreak +
      '      And (@EnderecoColetaId = 0 or @EnderecoColetaId = Ec.EnderecoId)' +
      sLineBreak + '      And (@Divergencia = 0 or Rc.Qtde <> Rc.QtdRepo)';

  Const
    SqlRelRupturaAbastecimento = 'Declare @DataIni DateTime = :pDataIni' +
      sLineBreak + 'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Select IdProduto, CodProduto, Descricao, Embalagem, Sum(Quantidade) Quantidad, Sum(Estoque) Estoque'
      + sLineBreak +
      'From (select Prd.IdProduto, Prd.CodProduto, Prd.Descricao, ' + sLineBreak
      + '       Quantidade, (Case When Pp.EmbalagemPadrao = 1 then ' + #39 +
      'Un' + #39 + ' Else ' + #39 + 'Cxa.C/' + #39 +
      '+Cast(PP.EmbalagemPadrao as varchar) End) "Embalagem", Coalesce(Est.Estoque, 0) Estoque'
      + sLineBreak + 'from pedidoProdutos  PP' + sLineBreak +
      'Inner join Pedido Ped On ped.PedidoId = Pp.Pedidoid' + sLineBreak +
      'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Inner Join Produto Prd ON Prd.Idproduto = Pp.ProdutoId' + sLineBreak +
      'Left Join (Select Produtoid, Sum(Qtde) Estoque  from vEstoque Group By Produtoid) est On Est.Produtoid = PP.ProdutoId'
      + sLineBreak + 'Inner Join vDocumentoEtapas DE On De.Documento = Ped.Uuid'
      + sLineBreak +
      '--where est.Estoque is not null and PP.Quantidade <= Est.Estoque and Quantidade >= EmbalagemPadrao'
      + sLineBreak +
      'Where (Est.Estoque is Null or PP.quantidade < PP.EmbalagemPadrao)' +
      sLineBreak +
      '     And De.ProcessoId = 1 and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak +
      '     AND (@DataIni = 0 or Rd.Data>=@DataIni) and (@DataFin=0 or Rd.Data<=@DataFin) ) Rup'
      + sLineBreak + 'Group by IdProduto, CodProduto, Descricao, Embalagem' +
      sLineBreak + 'Order by Descricao';

Const SqlRelColetaPulmao = 'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @CodPessoaERP Integer = :pCodPessoaERP;' + sLineBreak +
      'Declare @PessoaId Integer = 0;' + sLineBreak +
      'If @CodPessoaERP <> 0' + sLineBreak +
      '   Set @PessoaId = (Select Pessoaid From Pessoa Where PessoaTipoId = 1 and CodPessoaERP = @CodPessoaERP)'+sLineBreak +
      'Declare @RotaId Integer = :pRotaId'+sLineBreak +
      'Declare @ZonaId Integer = :pZonaId'+sLineBreaK+
      'select Prd.idProduto ProdutoID, Prd.CodProduto, Prd.Descricao, '+sLineBreak +
      '       Prd.FatorConversao, Tend.EnderecoId, Tend.Endereco, Prd.ZonaId, Prd.ZonaDescricao Zona,'+sLineBreak+
      '       (Case When EmbalagemPadrao>1 then ' + #39 + 'Cxa.C/'+#39'+Cast(EmbalagemPadrao As Char) else Cast(EmbalagemPadrao as Char) End) Embalagem, '+sLineBreak+
      '       TEnd.Mascara, Count(*) As Demanda, Sum(Vl.Quantidade) Unidade'+sLineBreak+
      'From PedidoVolumeLotes Vl ' + sLineBreak +
      'Inner Join PedidoVolumes Vlm On Vlm.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak +
      'Inner Join vPedidos Ped on Ped.PedidoId = Vlm.PedidoId'+sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId'+sLineBreak +
      'Inner Join vProduto Prd On Prd.IdProduto = Pl.ProdutoId'+sLineBreak +
      'Inner join vEnderecamentos TEnd On Tend.EnderecoId = Vl.EnderecoId'+sLineBreak +
      'Inner Join vDocumentoEtapas DE On De.Documento = Vlm.Uuid'+sLineBreak +
      'Where Vlm.EmbalagemId Is Null' + sLineBreak +
      '  And De.ProcessoId in (1, 2, 3) and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'+sLineBreak+
      '  And (@DataIni = 0 or Ped.DocumentoData >= @DataIni) and (@DataFin = 0 or Ped.DocumentoData <= @DataFin)'+sLineBreak+
      '  And (@PessoaId = 0 or Ped.Pessoaid = @Pessoaid)'+sLineBreak +
      '  And (@RotaId = 0 or Ped.RotaId = @RotaId)' + sLineBreak+
      '	 And (@ZonaId = 0 or Prd.ZonaId = @ZonaId)'+sLineBreak+
	     '  And (De.ProcessoId Not in (15, 31))'+sLineBreak+
      'Group by Prd.idProduto, Prd.CodProduto, Prd.Descricao, Prd.FatorConversao, Tend.EnderecoId, Tend.Endereco, Prd.ZonaId, Prd.ZonaDescricao, EmbalagemPadrao, TEnd.Mascara'+sLineBreak +
      'Order by Tend.Endereco Asc, Prd.CodProduto Asc';

  Const
    SqlRelApahaPicking = 'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @PessoaId Integer = Coalesce((Select Pessoaid From Pessoa Where CodPessoaERP = :pCodPessoaERP and PessoaTipoId = 1), 0)'
      + sLineBreak + 'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'select Prd.idProduto ProdutoID, Prd.CodProduto, Prd.Descricao, ' +
      sLineBreak + '       (Case When Prd.FatorConversao = 1 then '#39 + 'Unid'
      + #39 + ' Else ' + #39 + 'Caixa c/' + #39 +
      '+Cast(Prd.FatorConversao as VarChar) End) FatorConversao, Tend.EnderecoId, Tend.Descricao Endereco, Pl.DescrLote, Est.Mascara, '
      + sLineBreak +
      '       Coalesce(Estoq.Qtde, 0) Disponivel, Sum(Vl.Quantidade) As Demanda, Sum(Vl.Qtdsuprida) as QtdSuprida, Count(Vlm.PedidoVolumeId) As Apanhe'
      + sLineBreak + 'From PedidoVolumeLotes Vl' + sLineBreak +
      'Inner Join PedidoVolumes Vlm On Vlm.PedidoVolumeId = Vl.PedidoVolumeId' +
      sLineBreak + 'Inner Join Pedido Ped on Ped.PedidoId = Vlm.PedidoId' +
      sLineBreak + 'Inner Join RotaPessoas RP On Rp.PessoaId = Ped.PessoaId' +
      sLineBreak + 'Inner join Rhema_Data RD on Rd.IdData = Ped.DocumentoData' +
      sLineBreak + 'Inner Join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak + 'Inner Join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      'Inner join Enderecamentos TEnd On Tend.EnderecoId = Vl.EnderecoId' +
      sLineBreak +
      'Inner Join EnderecamentoEstruturas Est On Est.EstruturaId = Tend.EstruturaID'
      + sLineBreak + 'Inner Join vDocumentoEtapas DE On De.Documento = Vlm.Uuid'
      + sLineBreak +
      'Left Join Estoque Estoq On Estoq.LoteId = Vl.LoteId and Estoq.EnderecoId = vl.EnderecoId and Estoq.EstoqueTipoId = 4'
      + sLineBreak + 'Where Vlm.EmbalagemId Is Not Null' + sLineBreak +
      '      And De.ProcessoId in (1, 2, 3) and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak +
      '      And (@DataIni = 0 or Rd.Data >= @DataIni) and (@DataFin = 0 or Rd.Data <= @DataFin)'
      + sLineBreak + '      And (@PessoaId = 0 or Ped.Pessoaid = @Pessoaid)' +
      sLineBreak + '      And (@RotaId = 0 or Rp.RotaId = @RotaId)' + sLineBreak
      + 'Group by Prd.idProduto, Prd.CodProduto, Prd.Descricao, Prd.FatorConversao, Tend.EnderecoId, '
      + sLineBreak +
      '         Pl.DescrLote, Tend.Descricao, EmbalagemPadrao, Est.Mascara, Estoq.Qtde'
      + sLineBreak + 'Having Sum(Vl.Qtdsuprida) > 0' + sLineBreak +
      'Order by Tend.Descricao';

  Const
    SqlRelAnaliseRessuprimento = 'declare @DtInicio DateTime = :pDtInicio' +
      sLineBreak + 'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'Declare @RotaId integer = :pRotaId' + sLineBreak +
      'Declare @CodPessoaERP Integer = :pCodPessoaERP' + sLineBreak +
      'SELECT Pvt.PessoaId, Pe.CodPessoaERP, Pe.Razao, Pe.Fantasia, R.Descricao Rota,'
      + sLineBreak +
      'Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '
      + #39 + 'Demanda' + #39 + ',' + sLineBreak +
      '       COALESCE ([1], 0) AS ' + #39 + 'Recebido' + #39 +
      ', COALESCE ([2], 0) AS ' + #39 + 'Cubagem' + #39 +
      ', COALESCE ([3], 0) AS ' + #39 + 'Apanhe' + #39 + ', ' + sLineBreak +
      'COALESCE ([4], 0) AS ' + #39 + 'CheckOut' + #39 + ',' + sLineBreak +
      '	   COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 +
      ',COALESCE ([6], 0) AS ' + #39 + 'Cancelado' + #39 +
      ',Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) / ' + sLineBreak +
      'Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) MedProducao'
      + sLineBreak + 'FROM   (SELECT PessoaId, ProcessoId, Total' + sLineBreak +
      '        FROM (select Ped.PessoaId,' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10) then 4' + sLineBreak +
      '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak +
      'From (Select Ped.Pessoaid, De.ProcessoId, Count(*) As Total' + sLineBreak
      + 'From Pedido Ped' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join Pessoa P On P.PessoaId = Ped.Pessoaid' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '   and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak +
      '	  and (@RotaId = 0 or @RotaId = Rp.RotaId) and (@CodPessoaERP = 0 or @CodPessoaERP = P.CodPessoaERP)'
      + sLineBreak + '   And De.ProcessoId <> 31' + sLineBreak +
      'Group By Ped.Pessoaid, De.ProcessoId) as Ped) as P' + sLineBreak +
      '		) AS Tbl PIVOT (sum(Total)' + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt' + sLineBreak
      + 'Left Join Pessoa Pe On Pe.PessoaId = Pvt.PessoaId' + sLineBreak +
      'Left Join RotaPessoas Pr On Pr.PessoaId = Pe.PessoaId' + sLineBreak +
      'Left Join Rotas R On R.RotaId = Pr.RotaId';

  Const
    SqlRelAnaliseRessuprimentoVolume = 'declare @DtInicio DateTime = :pDtInicio'
      + sLineBreak + 'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'Declare @RotaId integer = :pRotaId' + sLineBreak +
      'Declare @CodPessoaERP Integer = :pCodPessoaERP' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'SELECT Pvt.PessoaId, Pe.CodPessoaERP, Pe.Razao, Pe.Fantasia, R.Descricao Rota,'
      + sLineBreak +
      'Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '
      + #39 + 'Demanda' + #39 + ',' + sLineBreak +
      '       COALESCE ([1], 0) AS ' + #39 + 'Recebido' + #39 +
      ', COALESCE ([2], 0) AS ' + #39 + 'Cubagem' + #39 +
      ', COALESCE ([3], 0) AS ' + #39 + 'Apanhe' + #39 + ', ' + sLineBreak +
      'COALESCE ([4], 0) AS ' + #39 + 'CheckOut' + #39 + ',' + sLineBreak +
      '	   COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 +
      ',COALESCE ([6], 0) AS ' + #39 + 'Cancelado' + #39 +
      ',Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) / ' + sLineBreak +
      'Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) MedProducao'
      + sLineBreak + 'FROM   (SELECT PessoaId, ProcessoId, Total' + sLineBreak +
      '        FROM (select Ped.PessoaId,' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10) then 4' + sLineBreak +
      '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak +
      'From (Select Ped.Pessoaid, De.ProcessoId, Count(*) As Total' + sLineBreak
      + 'From Pedido Ped' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join Pessoa P On P.PessoaId = Ped.Pessoaid' + sLineBreak +
      'Inner Join (Select Pv.PedidoId, Pv.PedidoVolumeId, DE.ProcessoId' +
      sLineBreak + '            From Pedido Ped' + sLineBreak +
      '            Inner Join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' +
      sLineBreak +
      '            Inner Join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      '            Inner Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' +
      sLineBreak +
      '            Inner Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      '            Inner Join vProdutoLotes Pl on Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '            Inner Join vDocumentoEtapas DE On De.Documento = Pv.uuid' +
      sLineBreak + '            Where DE.Horario = (Select Max(Horario)' +
      sLineBreak + '            		            From vDocumentoEtapas' +
      sLineBreak +
      '            		            where Documento = Pv.uuid and ProcessoId <= 15 and Status = 1)'
      + sLineBreak +
      '                  and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak +
      '                  And (@ZonaId = 0 or Pl.ZonaId = @ZonaId)' + sLineBreak
      + '                  and (@CodPessoaERP = 0 or @CodPessoaERP = Pes.CodPessoaERP)'
      + sLineBreak +
      '            Group by Pv.PedidoId, Pv.PedidoVolumeId, DE.ProcessoId) ResVol On ResVol.PedidoId = Ped.PedidoId'
      + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '   and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak +
      '	  and (@RotaId = 0 or @RotaId = Rp.RotaId) and (@CodPessoaERP = 0 or @CodPessoaERP = P.CodPessoaERP)'
      + sLineBreak + '   and De.ProcessoId <> 31' + sLineBreak +
      'Group By Ped.Pessoaid, De.ProcessoId) as Ped) as P' + sLineBreak +
      '		) AS Tbl PIVOT (sum(Total)' + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt' + sLineBreak
      + 'Left Join Pessoa Pe On Pe.PessoaId = Pvt.PessoaId' + sLineBreak +
      'Left Join RotaPessoas Pr On Pr.PessoaId = Pe.PessoaId' + sLineBreak +
      'Left Join Rotas R On R.RotaId = Pr.RotaId';

  Const
    SqlDashboad0102 = 'declare @DtInicio DateTime = :pDtInicio' + sLineBreak +
      'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'SELECT Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '
      + #39 + 'Demanda' + #39 + ',' + sLineBreak + '	   COALESCE ([5], 0) AS '
      + #39 + 'Expedicao' + #39 + ',COALESCE ([6], 0) AS ' + #39 + 'Cancelado' +
      #39 + sLineBreak + 'FROM   (SELECT ProcessoId, Total' + sLineBreak +
      '        FROM (select' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10) then 4' + sLineBreak +
      '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak +
      'From (Select De.ProcessoId, Count(*) As Total' + sLineBreak +
      'From Pedido Ped' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join Pessoa P On P.PessoaId = Ped.Pessoaid' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and ProcessoId <= 15 and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak + 'Group By De.ProcessoId) as Ped) as P' + sLineBreak +
      '		) AS Tbl PIVOT (sum(Total)' + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt';

  Const
    SqlDashBoard030405 = 'declare @DtInicio DateTime = :pDtInicio' + sLineBreak
      + 'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'SELECT Pe.CodPessoaERP, Pe.Fantasia,' + sLineBreak +
      '       Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '
      + #39 + 'Demanda' + #39 + ',' + sLineBreak + '	   COALESCE ([5], 0) AS '
      + #39 + 'Expedicao' + #39 + ',COALESCE ([6], 0) AS ' + #39 + 'Cancelado' +
      #39 + sLineBreak + 'FROM   (SELECT PessoaId, ProcessoId, Total' +
      sLineBreak + '        FROM (select Ped.PessoaId,' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10) then 4' + sLineBreak +
      '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak +
      'From (Select Ped.Pessoaid, De.ProcessoId, Count(*) As Total' + sLineBreak
      + 'From Pedido Ped' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join Pessoa P On P.PessoaId = Ped.Pessoaid' + sLineBreak +
      '                      where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and ProcessoId <= 15 and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak + 'Group By Ped.Pessoaid, De.ProcessoId) as Ped) as P' +
      sLineBreak + '		) AS Tbl PIVOT (sum(Total)' + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt' + sLineBreak
      + 'Left Join Pessoa Pe On Pe.PessoaId = Pvt.PessoaId' + sLineBreak +
      'Left Join RotaPessoas Pr On Pr.PessoaId = Pe.PessoaId' + sLineBreak +
      'Left Join Rotas R On R.RotaId = Pr.RotaId';

  Const
    SqlDashBoard06 = 'declare @DtInicio DateTime = :pDtInicio' + sLineBreak +
      'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'SELECT RotaId, Descricao Rota,' + sLineBreak +
      '       Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '
      + #39 + 'Demanda' + #39 + ',' + sLineBreak + '	   COALESCE ([5], 0) AS '
      + #39 + 'Expedicao' + #39 + ',COALESCE ([6], 0) AS ' + #39 + 'Cancelado' +
      #39 + sLineBreak + 'FROM   (SELECT RotaId, Descricao, ProcessoId, Total' +
      sLineBreak + '        FROM (select Ped.RotaId, Ped.Descricao,' +
      sLineBreak + '              (Case When Ped.ProcessoId = 1 then 1' +
      sLineBreak + '		   	      When Ped.Processoid in (2, 22) then 2' +
      sLineBreak + '		          When Ped.ProcessoId in (3, 7, 8) then 3' +
      sLineBreak + '		          When Ped.ProcessoId in (9, 10) then 4' +
      sLineBreak + '			      When Ped.ProcessoId = 15 then 6' + sLineBreak
      + '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak +
      'From (Select R.RotaId, R.Descricao, De.ProcessoId, Count(*) As Total' +
      sLineBreak + 'From Pedido Ped' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join Rotas R On R.RotaId = Rp.Rotaid' + sLineBreak +
      'Left Join Pessoa P On P.PessoaId = Ped.Pessoaid' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and ProcessoId <= 15 and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak +
      'Group By R.Rotaid, R.Descricao, De.ProcessoId) as Ped) as P' + sLineBreak
      + '		) AS Tbl PIVOT (sum(Total)' + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt';

  Const
    SqlGetPedidoResumoAtendimento = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'Declare @Divergencia Integer = :pDivergencia' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime =  :pDataFinal' + sLineBreak +
      'select Ped.PedidoId, Rd.Data, PP.Produtoid, Prd.CodProduto, Descricao, EnderecoDescricao Picking, '
      + sLineBreak +
      'Zonaid, ZonaDescricao, Sum(PP.Quantidade) Demanda,  (Case When PP.EmbalagemPadrao = 1 then '
      + sLineBreak + '	            Prd.UnidadeSigla ' + sLineBreak +
      '             Else ' + sLineBreak + '			     ' + #39 + 'Cxa c/ ' + #39 +
      '+Cast(PP.EmbalagemPadrao as Varchar)' + sLineBreak +
      '	       End) Embalagempadrao, Sum(Coalesce(QtdSuprida, 0)) QtdSuprida' +
      sLineBreak + '      , Prd.Volume*Sum(Coalesce(QtdSuprida, 0)) ' + #39 +
      'Volume(Cm3)' + #39 + sLineBreak +
      '      , Cast(Prd.PesoLiquido*Sum(Coalesce(QtdSuprida, 0))/1000 as decimal(15,3)) Peso'
      + sLineBreak + 'From PedidoProdutos PP' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Pp.PedidoId' + sLineBreak +
      'inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Inner Join vProduto Prd On Prd.IdProduto = PP.ProdutoId' + sLineBreak +
      'Left Join (select Vlm.PedidoId, Pl.Produtoid, Sum(Vl.QtdSuprida) QtdSuprida'
      + sLineBreak + '           From PedidoVolumeLotes Vl' + sLineBreak +
      '           Inner Join PedidoVolumes Vlm On Vlm.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '           Inner join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '           Inner Join vDocumentoEtapas De on De.Documento = Vlm.Uuid' +
      sLineBreak +
      '           Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1)'
      + sLineBreak + '                 And De.ProcessoId <> 15' + sLineBreak +
      '           Group by Vlm.PedidoId, Pl.Produtoid) As VolLote On VolLote.PedidoId = Pp.PedidoId and PP.ProdutoId = VolLote.ProdutoId'
      + sLineBreak + 'Where(@PedidoId = 0 or Pp.PedidoId = @PedidoId)' +
      sLineBreak +
      '      and (@Divergencia = 0 or PP.Quantidade <> Coalesce(QtdSuprida, 0))'
      + sLineBreak +
      '	  and (@DataInicial = 0 or Rd.Data >= @DataInicial) and (@DataFinal = 0 or Rd.Data <= @DataFinal)'
      + sLineBreak +
      'Group by Ped.PedidoId, Rd.Data, PP.Produtoid, Prd.CodProduto, Descricao, EnderecoDescricao, Zonaid, ZonaDescricao, '
      + sLineBreak +
      '         Embalagempadrao, Prd.UnidadeSigla, Prd.UnidadeSecundariaSigla, Prd.FatorConversao, Prd.Volume, Prd.PesoLiquido'
      + sLineBreak + 'order by descricao, Rd.Data, Pedidoid, ProdutoId';

  Const
    SqlGetEntradaOcorrencia = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'Declare @DocumentoNr Varchar(20) = :pDocumentoNr' +
      sLineBreak + 'Declare @RegistroERP Varchar(36) = :pRegistroERP' +
      sLineBreak + 'Declare @DoctoDataIni DateTime = :pDoctoDataIni' +
      sLineBreak + 'Declare @DoctoDataFin DateTime = :pDoctoDataFin' +
      sLineBreak + 'Declare @CheckInDtIni DateTime = :pCheckInDtIni' +
      sLineBreak + 'Declare @CheckInDtFin DateTime = :pCheckInDtFin' +
      sLineBreak + 'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Select P.PedidoId, P.DocumentoData,' + sLineBreak +
      '       Pl.IdProduto, Pl.CodProduto, Pl.Descricao, Pl.LoteId, Pl.Lote,' +
      sLineBreak +
      '       Pl.Vencimento, Pc.LoteId, Pc.QtdDevolvida, Pc.QtdSegregada,' +
      sLineBreak + '	      Null DataCheckin, Null HoraCheckIn,' + sLineBreak +
      '	      Null AS CheckInHrInicio,' + sLineBreak +
      '	      U.UsuarioId, U.Nome, Sc.Descricao Motivo' + sLineBreak +
      'from vPedidos P' + sLineBreak +
      'Inner Join (Select PedidoId, LoteId, CausaId, UsuarioId, Sum(QtdDevolvida) QtdDevolvida, Sum(QtdSegregada) QtdSegregada'
      + sLineBreak + '            From PedidoItensCheckIn' + sLineBreak +
      '			         Group by PedidoId, LoteId, CausaId, UsuarioId) Pc On Pc.PedidoId = P.PedidoId'
      + sLineBreak + 'Inner Join vProdutoLotes Pl on Pl.LoteId = Pc.LoteId' +
      sLineBreak + 'Inner Join Usuarios U On U.UsuarioId = Pc.UsuarioId' +
      sLineBreak +
      'Inner join SegregadoCausa Sc On SC.SegregadoCausaId = Pc.CausaId' +
      sLineBreak + 'where (@PedidoId=0 or P.PedidoId = @PedidoId) and' +
      sLineBreak + '      (@DocumentoNr = ' + #39 + #39 +
      ' or P.DocumentoNr = @DocumentoNr) and' + sLineBreak +
      '      (@RegistroERP = ' + #39 + #39 +
      ' or P.RegistroERP = @RegistroERP) and' + sLineBreak +
      '	     (@DoctoDataIni=0 or P.DocumentoData >= @DoctoDataIni) and' +
      sLineBreak +
      '	     (@DoctoDataFin=0 or P.DocumentoData <= @DoctoDataFin) and' +
      sLineBreak + '      (@CodProduto = 0 or Pl.CodProduto = @CodProduto) and'
      + sLineBreak + '      (Pc.QtdDevolvida+Pc.QtdSegregada>0) and ' +
      sLineBreak + '      P.OperacaoTipoid = 3' + sLineBreak +
      'Order by P.PedidoId, Pl.Descricao';

  Const
    SqlGetEspelhoEntrada = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak
      + 'Declare @DocumentoNr Varchar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @RegistroERP Varchar(36) = :pRegistroERP' + sLineBreak +
      'Declare @DoctoDataIni DateTime = :pDoctoDataIni' + sLineBreak +
      'Declare @DoctoDataFin DateTime = :pDoctoDataFin' + sLineBreak +
      'Declare @CheckInDtIni DateTime = :pCheckInDtIni' + sLineBreak +
      'Declare @CheckInDtFin DateTime = :pCheckInDtFin' + sLineBreak +
      'Declare @Divergencia Integer   = :pDivergencia' + sLineBreak +
      'Select P.PedidoId, FORMAT(Rd.Data, ' + #39'dd/MM/yyyy' +
      #39') DocumentoData, Pl.IdProduto ProdutoId, Prd.CodProduto, Prd.Descricao, Pl.LoteId, Pl.Lote DescrLote,'
      + sLineBreak + '       FORMAT(Pl.Data, ' + #39'dd/MM/yyyy' +
      #39') Fabricacao, FORMAT(Pl.Vencimento, ' + #39'dd/MM/yyyy' +
      #39') Vencimento, PI.*, Null DataCheckin, Null Hora,' + sLineBreak +
      '	     Null AS CheckInHrInicio,' + sLineBreak +
      '	     U.UsuarioId, U.Nome, ' + #39 + #39 + ' as RespAltLote' + sLineBreak
      + 'from Pedido P' + sLineBreak +
      'Inner Join Pedidoitens PI On PI.PedidoId = P.PedidoId' + sLineBreak +
      'Inner Join vProdutoLotes Pl on Pl.LoteId = PI.LoteId' + sLineBreak +
      'Inner Join Produto Prd On Prd.IdProduto = Pl.IdProduto' + sLineBreak +
      'Inner Join Usuarios U On U.UsuarioId = 1 --Pic.UsuarioId' + sLineBreak +
      'Inner Join Rhema_Data RD ON RD.IdData = P.DocumentoData' + sLineBreak +
      'where (@PedidoId=0 or Pi.PedidoId = @PedidoId) and' + sLineBreak +
      '      (@DocumentoNr = ' + #39 + #39 +
      ' or P.DocumentoNr = @DocumentoNr) and' + sLineBreak +
      '	    (@RegistroERP = ' + #39 + #39 +
      ' or P.RegistroERP = @RegistroERP) and' + sLineBreak +
      '	    (@DoctoDataIni=0 or RD.Data >= @DoctoDataIni) and' + sLineBreak +
      '	    (@DoctoDataFin=0 or RD.Data <= @DoctoDataFin) and' + sLineBreak +
      '      (@Divergencia=0 or (@Divergencia=1 and (Pi.QtdDevolvida+Pi.QtdSegregada>0))) and'
      + sLineBreak + '      P.OperacaoTipoid = 3' + sLineBreak +
      'Order by Pl.IdProduto, (Case When Pi.QtdXml = 0 then 1 Else 0 End)';

  Const
    SqlGetResumoCheckIn = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak
      + 'select Pi.PedidoId, Pl.CodProduto, Pl.Descricao, Pl.Endereco, Pl.Zona, Pl.Lote, Pl.Vencimento,'
      + sLineBreak +
      '       Pi.QtdXml, Pic.QtdCheckIn, Pic.QtdDevolvida, Pic.QtdSegregada, U.Nome, Dc.Data DtConferencia,'
      + sLineBreak +
      '       Hc.Hora HrConferencia, Ur.Nome ResponsavelLote, Pic.Terminal, Sc.Descricao Causa'
      + sLineBreak + 'from PedidoItens Pi' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.LoteId = Pi.LoteId' + sLineBreak +
      'Left Join pedidoitensCheckIn Pic On Pic.PedidoId = Pi.PedidoId and Pic.LoteId = Pi.LoteId'
      + sLineBreak +
      'Left join Usuarios U On U.UsuarioId = Pic.UsuarioId --Conferente' +
      sLineBreak +
      'Left join Usuarios UR On UR.UsuarioId = Pic.RespAltLote --Respons�vel pela Entrada do Lote'
      + sLineBreak +
      'Left Join Rhema_Data Dc On Dc.IdData = Pic.CheckInDtInicio' + sLineBreak
      + 'Left Join Rhema_Hora Hc On Hc.IdHora = Pic.CheckInHrInicio' +
      sLineBreak +
      'Left Join SegregadoCausa Sc on Sc.SegregadoCausaId = Pic.CausaId' +
      sLineBreak + 'where Pi.pedidoid = @PedidoId' + sLineBreak +
      'Order by Pi.Pedidoid, Pl.Descricao, Pl.Lote';

  Const
    SqlGetAcompanhamentoCheckIn = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak +
      'Declare @PessoaId Integer = (Select PessoaId From Pessoa Where CodPessoaERP = :pCodPessoaERP And PessoaTipoId = 2)'
      + sLineBreak + 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal   DateTime = :pDataFinal' + sLineBreak +
      'Select PessoaId, CodPessoaERP, Fantasia, Count(Ped.PedidoId) TotalPedido, Sum(PedidoConferido) PedidoConferido,'
      + sLineBreak +
      '       Sum(TItens) TItens, Sum(TItensConferido) TItensConferido,' +
      sLineBreak +
      '       Sum(UnidQtdXml) UnidQtdXml, Sum(UnidTotalCheckIn) UnidTotalCheckIn'
      + sLineBreak +
      'From (select Ped.PessoaId, Ped.CodPessoaERP, Fantasia, Ped.PedidoId,' +
      sLineBreak + '             Count(Distinct Pl.ProdutoId) TItens,' +
      sLineBreak +
      '             (Case When Sum(QtdCheckIn+QtdDevolvida+QtdSegregada) >= Sum(QtdXml) Then 1 Else 0 End) PedidoConferido,'
      + sLineBreak + '             Sum(QtdXml) UnidQtdXml,' + sLineBreak +
      '			          Sum(QtdCheckIn+QtdDevolvida+QtdSegregada) UnidTotalCheckIn'
      + sLineBreak + '      From PedidoItens Pi' + sLineBreak +
      '      Inner join vPedidos Ped On Ped.PedidoId = Pi.PedidoId' + sLineBreak
      + '	     Inner Join ProdutoLotes Pl On Pl.LoteId = Pi.LoteId' + sLineBreak
      + '      where (@PessoaId = 0 or Ped.PessoaId = @PessoaId)' + sLineBreak
      + '	        And (@PedidoId = 0 or Ped.PedidoId = @PedidoId)' + sLineBreak
      + '		       And (@DataInicial = 0 or Ped.DocumentoData >= @DataInicial)'
      + sLineBreak +
      '		       And (@DataFinal = 0 or Ped.DocumentoData >= @DataFinal)' +
      sLineBreak +
      '      Group By Ped.PessoaId, Ped.CodPessoaERP, Fantasia, Ped.PedidoId ) Ped'
      + sLineBreak +
      'Left Join (Select PedidoId, Sum(TItensConferido) TItensConferido' +
      sLineBreak +
      '           From (Select PedidoId, Pl.ProdutoId, (Case When Sum(QtdCheckIn+QtdDevolvida+QtdSegregada) >= Sum(QtdXml) Then 1 Else 0 End) TItensConferido'
      + sLineBreak + '           From PedidoItens Pi' + sLineBreak +
      '           Inner join Produtolotes Pl on Pl.LoteId = Pi.LoteId' +
      sLineBreak + '           Group by PedidoId, Pl.ProdutoId) PC' + sLineBreak
      + '		   Group by PedidoId) Ic On Ic.PedidoId = Ped.Pedidoid' + sLineBreak
      + 'Group by PessoaId, CodPessoaERP, Fantasia';

    // https://rockcontent.com/br/blog/inventario/
  Const
    SqlGetInventario =
      'Select I.InventarioId, I.InventarioTipo, I.Motivo, Dc.Data DataCricao, I.DataLiberacao, I.TipoAjuste, I.Uuid, '
      + sLineBreak +
      '       (Select Data From vDocumentoEtapas Where Documento = I.Uuid and ProcessoId = '
      + sLineBreak +
      '       (Select ProcessoId From ProcessoEtapas where Descricao = ' + #39 +
      'Inventario - Gerado' + #39 + ') and Status = 1) DataCriacao,' +
      sLineBreak + '        (Case When InventarioTipo = 1 then ' + #39 +
      'Por Endere�o' + #39 + sLineBreak +
      '         When inventarioTipo = 2 then ' + #39 + 'Priorit�rio' + #39 +
      sLineBreak + '         When InventarioTipo = 3 then ' + #39 + 'Ciclico' +
      #39 + ' End) Tipo, ' + sLineBreak +
      '       De.ProcessoId, De.Descricao Processo, De.Data, De.Hora, De.Horario, De.UsuarioId, U.Nome USuario, De.Terminal'
      + sLineBreak + '       , (Case When TipoAjuste=0 then ' + #39 +
      'Definitivo' + #39 + ' Else ' + #39 + 'Tempor�rio' + #39 + ' End) Ajuste'
      + sLineBreak + 'From Inventarios I' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = I.uuid' + sLineBreak +
      'Left Join vDocumentoEtapas DC On DC.Documento = I.uuid and Dc.ProcessoID = 23 and Dc.Status = 1'
      + sLineBreak + 'Left Join Usuarios U ON U.Usuarioid = De.UsuarioId' +
      sLineBreak +
      'Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = I.uuid and Status = 1) '
      + sLineBreak + ''; // 'Order by InventarioId';

  Const
    SqlGetInventarioPendente =
      'Declare @EtapaGerado   Integer = (Select ProcessoId from ProcessoEtapas where Descricao = '
      + #39 + 'Inventario - Gerado' + #39 + ')' + sLineBreak +
      'Declare @EtapaContagem Integer = (Select ProcessoId from ProcessoEtapas where Descricao = '
      + #39 + 'Inventario - Em Contagem' + #39 + ')' + sLineBreak +
      'Select I.*, (Select Data From vDocumentoEtapas Where Documento = I.Uuid and ProcessoId = (Select ProcessoId From ProcessoEtapas where Descricao = '
      + #39 + 'Inventario - Gerado' + #39 + ') and Status = 1) DataCriacao,' +
      sLineBreak + '        (Case When InventarioTipo = 1 then ' + #39 +
      'Por Endere�o' + #39 + sLineBreak +
      '         When inventarioTipo = 2 then ' + #39 + 'Priorit�rio' + #39 +
      sLineBreak + '         When InventarioTipo = 3 then ' + #39 + 'Ciclico' +
      #39 + ' End) Tipo,' + sLineBreak +
      '        De.ProcessoId, De.Descricao Processo, De.Data, De.Hora, De.Horario, De.UsuarioId, U.Nome USuario, De.Terminal'
      + sLineBreak + 'From Inventarios I' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = I.uuid' + sLineBreak +
      'Left Join Usuarios U ON U.Usuarioid = De.UsuarioId' + sLineBreak +
      'Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = I.uuid and Status = 1)'
      + sLineBreak + 'And De.ProcessoId in (@EtapaGerado, @EtapaContagem)' +
      sLineBreak + 'order by InventarioId';

  Const
    SqlGetInventarioItensEndereco =
      'Declare  @InventarioId Integer = :pInventarioId' + sLineBreak +
      'Select II.InventarioItemid, II.InventarioId, II.EnderecoId, ' +
      sLineBreak +
      '       II.ProdutoId, Prd.CodProduto codigoERP, Prd.Descricao Produto, PRd.EnderecoDescricao Picking, E.Endereco, '
      + sLineBreak +
      '       (Case When I.inventariotipo = 1 then E.Estrutura When I.inventariotipo = 2 then Prd.EstruturaDescricao End) Estrutura,'
      + sLineBreak +
      '       (Case When I.inventariotipo = 1 then E.Zona When I.inventariotipo = 2 then Prd.ZonaDescricao End) Zona,'
      + sLineBreak +
      '       (Case When I.inventariotipo = 1 then E.Mascara When I.inventariotipo = 2 then Prd.Mascara End) Mascara, '
      + sLineBreak +

      '       (Case When TINI > 0 Then ' + #39 + 'I' + #39 + sLineBreak +
      '             When TCon > 0 Then ' + #39 + 'C' + #39 + sLineBreak +
      '			     Else ' + #39 + 'F' + #39 + ' End) Status,' + sLineBreak +
      '	      (Case When TINI > 0 Then ' + #39 + '0' + #39 + sLineBreak +
      '             When TCON > 0 Then ' + #39 + '1' + #39 + sLineBreak +
      '		           Else ' + #39 + '2' + #39 + ' End) Ordem,' + sLineBreak +

    // '       (Case When TFin > 0 and TCon <= 0 and TIni <= 0 Then '+#39+'F'+#39+sLineBreak+
    // '             When TCon > 0 Then '+#39+'C'+#39+sLineBreak+
    // '			   Else '+#39+'I'+#39+' End) Status,'+sLineBreak+
    // '	      (Case When TCon > 0 Then '+#39+'1'+#39+sLineBreak+
    // '             When TIni > 0 Then '#39+'0'#39+sLineBreak+
    // '			   Else '+#39+'2'+#39+' End) Ordem, '+sLineBreak+

      '      Coalesce(Prd.Sngpc, 0) SNGPC' + sLineBreak +
      'From InventarioItens  II' + sLineBreak +
      'Inner Join inventarios I On I.inventarioid = II.inventarioid' +
      sLineBreak +
      'Left Join (	Select EnderecoId, Sum(TFin)TFin, Sum(TCon) TCon, Sum(TIni) TIni'
      + sLineBreak + '            From (Select EnderecoId' + sLineBreak +
      '			                      , (Case When Status = ' + #39 + 'F' + #39 +
      ' then 1 Else 0 End) TFin' + sLineBreak +
      '		                       , (Case When Status = ' + #39 + 'C' + #39 +
      ' then 1 Else 0 End) TCon' + sLineBreak +
      '			                      , (Case When Status = ' + #39 + 'I' + #39 +
      ' then 1 Else 0 End) TIni' + sLineBreak +
      '			               From InventarioInicial Where InventarioId = @InventarioId ) St Group By EnderecoId) IINi ON IIni.EnderecoId = II.EnderecoId'
      + sLineBreak + 'Left Join vProduto Prd On Prd.IdProduto = II.ProdutoId' +
      sLineBreak + 'Left Join vEnderecamentos E On E.EnderecoId = II.EnderecoId'
      + sLineBreak + 'Where II.InventarioId = @InventarioId' + sLineBreak +
      'Order by Ordem';

  Const
    SqlGetInventarioItensProduto =
      'Declare  @InventarioId Integer = :pInventarioId' + sLineBreak +
      'Select II.InventarioItemid, II.InventarioId, II.EnderecoId, ' +
      sLineBreak +
      '       II.ProdutoId, Prd.CodProduto codigoERP, Prd.Descricao Produto, PRd.EnderecoDescricao Picking, E.Endereco, '
      + sLineBreak +
      '       (Case When I.inventariotipo = 1 then E.Estrutura When I.inventariotipo = 2 then Prd.EstruturaDescricao End) Estrutura,'
      + sLineBreak +
      ' (Case When I.inventariotipo = 1 then E.Zona When I.inventariotipo = 2 then Prd.ZonaDescricao End) Zona,'
      + sLineBreak +

      '       (Case When (TINI > 0 or TINI Is Null) Then ' + #39 + 'I' + #39 +
      sLineBreak + '             When TCon > 0 Then ' + #39 + 'C' + #39 +
      sLineBreak + '			     Else ' + #39 + 'F' + #39 + ' End) Status,' +
      sLineBreak + '	      (Case When TINI > 0 Then ' + #39 + '0' + #39 +
      sLineBreak + '             When TCON > 0 Then ' + #39 + '1' + #39 +
      sLineBreak + '		           Else ' + #39 + '2' + #39 + ' End) Ordem,' +
      sLineBreak +
      '       (Case When I.inventariotipo = 1 then E.Mascara When I.inventariotipo = 2 then Prd.Mascara End) Mascara, '
      + sLineBreak +

    // '       (Case When TFin > 0 Then '+#39+'F'+#39+sLineBreak+
    // '             When TCon > 0 Then '+#39+'C'+#39+sLineBreak+
    // '			   Else '+#39+'I'+#39+' End) Status,'+sLineBreak+
    // '	      (Case When TCon > 0 Then '+#39+'1'+#39+sLineBreak+
    // '             When TIni > 0 Then '#39+'0'#39+sLineBreak+

      '			    Coalesce(Prd.Sngpc, 0) SNGPC' + sLineBreak +
      'From InventarioItens  II' + sLineBreak +
      'Inner Join inventarios I On I.inventarioid = II.inventarioid' +
      sLineBreak +
      'Left Join (	Select ProdutoId, Sum(TFin)TFin, Sum(TCon) TCon, Sum(TIni) TIni'
      + sLineBreak + '            From (Select ProdutoId' + sLineBreak +
      '			                      , (Case When Status = ' + #39 + 'F' + #39 +
      ' then 1 Else 0 End) TFin' + sLineBreak +
      '		                       , (Case When Status = ' + #39 + 'C' + #39 +
      ' then 1 Else 0 End) TCon' + sLineBreak +
      '			                      , (Case When Status = ' + #39 + 'I' + #39 +
      ' then 1 Else 0 End) TIni' + sLineBreak +
      '			               From InventarioInicial Where InventarioId = @InventarioId ) St Group By ProdutoId) IINi ON IIni.ProdutoId = II.ProdutoId'
      + sLineBreak + 'Left Join vProduto Prd On Prd.IdProduto = II.ProdutoId' +
      sLineBreak + 'Left Join vEnderecamentos E On E.EnderecoId = II.EnderecoId'
      + sLineBreak + 'Where II.InventarioId = @InventarioId' + sLineBreak +
      'Order by Ordem';

    { 'Select Distinct II.*, Prd.Descricao Produto, E.Endereco, E.Estrutura, E.Mascara, E.Zona, (Case When IIni.Status Is Null Then '+#39+'I'+#39+' Else IIni.Status End) Status'+sLineBreak+
      'From InventarioItens II'+sLineBreak+
      'Left Join vProduto Prd On Prd.IdProduto = II.ProdutoId'+sLineBreak+
      'Left Join vEnderecamentos E On E.EnderecoId = II.EnderecoId'+sLineBreak+
      'Left Join InventarioInicial IINi ON IIni.InventarioId = II.inventarioid and IIni.EnderecoId = II.enderecoid'+sLineBreak+
      'Where II.inventarioid = @InventarioId and (IIni.Status IS Null or IIni.Status in ('+#39+'I'+#39+', '+#39+'C'+#39+'))';
    }

  Const
    SqlGetLoteInventario =
      'Select Inv.inventariotipo, II.itemid, II.inventarioid, II.enderecoid, TEnd.Descricao Endereco, II.produtoid, Prd.CodProduto, Prd.Descricao, II.loteid, Pl.DescrLote,'
      + sLineBreak +
      '       II.Fabricacao, II.Vencimento, II.EstoqueInicial, Ic.contagemid, Null as Quantidade, '
      + sLineBreak + '       (Case When II.status = ' + #39 + 'I' + #39 +
      ' then II.estoqueinicial Else ' + sLineBreak +
      '	   (Case When Ic.Quantidade Is Null and II.Loteid Is Null then 0' +
      sLineBreak + '	         Else Ic.Quantidade End) End) QtdContagem, ' +
      sLineBreak + '       II.status, II.automatico' + sLineBreak +
      'from InventarioInicial II' + sLineBreak +
      'Inner Join Inventarios Inv On Inv.InventarioId = II.InventarioId' +
      sLineBreak +
      'Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId' +
      sLineBreak + 'Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' +
      sLineBreak + 'Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      'Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'
      + sLineBreak + 'Where 1 = 1';

  Const
    SqlGetLoteInventarioPorProduto =
      'Select Inv.inventariotipo, II.itemid, II.inventarioid, II.enderecoid, TEnd.Descricao Endereco, II.produtoid, Prd.CodProduto, Prd.Descricao, II.loteid, Pl.DescrLote,'
      + sLineBreak +
      '       II.Fabricacao, II.Vencimento, II.EstoqueInicial, Ic.contagemid, Null as Quantidade, '
      + sLineBreak + '       (Case When II.status = ' + #39 + 'I' + #39 +
      ' then II.estoqueinicial Else ' + sLineBreak +
      '	   (Case When Ic.Quantidade Is Null and II.Loteid Is Null then 0' +
      sLineBreak + '	         Else Ic.Quantidade End) End) QtdContagem, ' +
      sLineBreak + '       II.status, II.automatico' + sLineBreak +
      'from InventarioInicial II' + sLineBreak +
      'Inner Join Inventarios Inv On Inv.InventarioId = II.InventarioId' +
      sLineBreak +
      'Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId' +
      sLineBreak + 'Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' +
      sLineBreak + 'Left Join Produto Prd On Prd.IdProduto = II.ProdutoId' +
      sLineBreak +
      'Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'
      + sLineBreak + 'Where 1 = 1';

  Const
    SqlZerarEndereco = 'Declare @EnderecoId Integer   = :pEnderecoId' +
      sLineBreak + 'Declare @ProdutoId  Integer   = :pProdutoId' + sLineBreak +
      'Declare @InventarioId Integer = :pInventarioId' + sLineBreak +
      'If (@EnderecoId<>0 and (Exists (Select EnderecoId From InventarioInicial where InventarioId = @InventarioId and Enderecoid = @EnderecoId))) or'
      + sLineBreak +
      '   (@Produtoid<>0 and (Exists (Select ProdutoId From InventarioInicial where InventarioId = @Produtoid and Produtoid = @Produtoid))) Begin'
      + sLineBreak + '	  Update II' + sLineBreak + '       Set Status = ' + #39
      + 'F' + #39 + sLineBreak +
    // '	    set Status = (Case When ((Status = '+#39+'I'+#39+') and ((Select InventarioForcarMaxContagem From configuracao) = 0)) then '+#39+'C'+#39+sLineBreak+
    // '					                   When Status = '+#39+'I'+#39+' then '+#39+'C'+#39+sLineBreak+
    // '					                   Else '+#39+'F'+#39+' End)'+sLineBreak+
      '   From InventarioInicial II' + sLineBreak +
      '	  Where II.InventarioId = @InventarioId' + sLineBreak +
      '		       and ((@Enderecoid>0 and II.EnderecoId = @EnderecoId)' +
      sLineBreak +
      '			            or (@ProdutoId>0 and II.ProdutoId = @ProdutoId))' +
      sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '  If @EnderecoId <> 0' + sLineBreak +
      '     Insert InventarioInicial Values (@InventarioId, @EnderecoId, Null, NULL,	NULL,	NULL,	NULL,	'
      + #39 + 'I' + #39 + ',	1 )' + sLineBreak + '  If @ProdutoId <> 0' +
      sLineBreak +
      '     Insert InventarioInicial Values (@InventarioId, Null, @ProdutoId, NULL,	NULL,	NULL,	NULL,	'
      + #39 + 'I' + #39 + ',	1 )' + sLineBreak + 'End';

  Const
    SqlLimparContagem = 'Declare @inventarioId Integer = :pInventarioId' +
      sLineBreak + 'Declare @EnderecoId Integer = :pEnderecoid' + sLineBreak +
      'Declare @ProdutoId  Integer = :pProdutoId' + sLineBreak +
      'If @EnderecoId > 0 Begin' + sLineBreak +
      '   Delete From InventarioInicial Where InventarioId = @InventarioId And EnderecoId = @EnderecoId  and Automatico = 0'
      + sLineBreak + '   Update InventarioInicial Set Status = ' + #39 + 'I' +
      #39 + ' Where InventarioId = @InventarioId And EnderecoId = @EnderecoId' +
      sLineBreak + '   Delete Ic' + sLineBreak + '   From InventarioContagem Ic'
      + sLineBreak +
      '   Inner Join inventarioinicial II On II.itemid = Ic.itemid' + sLineBreak
      + '   Where II.EnderecoId = @EnderecoId' + sLineBreak + 'End' + sLineBreak
      + 'Else Begin' + sLineBreak +
      '   Delete InventarioInicial Where InventarioId = @InventarioId And ProdutoId = @ProdutoId  and Automatico = 0'
      + sLineBreak + '   Update InventarioInicial Set Status = ' + #39 + 'I' +
      #39 + ' Where InventarioId = @InventarioId' + sLineBreak +
      '                                               And ProdutoId = @ProdutoId'
      + sLineBreak + '   Delete Ic' + sLineBreak +
      '   From InventarioContagem Ic' + sLineBreak +
      '   Inner Join inventarioinicial II On II.itemid = Ic.itemid' + sLineBreak
      + '   Where II.ProdutoId = @ProdutoId' + sLineBreak + 'End';

  Const
    SqlSaveContagem = 'Declare @InventarioId Integer  = :pInventarioId' +
      sLineBreak + 'Declare @Enderecoid Integer    = :pEnderecoId' + sLineBreak
      + 'Declare @ProdutoId Integer     = :ProdutoId' + sLineBreak +
      'Declare @LoteId Integer        = :pLoteId' + sLineBreak +
      'Declare @DescrLote VarChar(30) = :pDescrLote' + sLineBreak +
      'Declare @DtFabricacao DateTime = :pDtFabricacao' + sLineBreak +
      'Declare @DtVencimento DateTime = :pDtVencimento' + sLineBreak +
      'Declare @Itemid Integer        = :pItemId' + sLineBreak +
      'Declare @Quantidade Integer    = :pQuantidade' + sLineBreak +
      'Declare @Usuarioid Integer     = :pUsuarioId' + sLineBreak +
      'Declare @StatusItem Char(1)    = :pStatus' + sLineBreak +
      'Declare @Estacao Varchar(50)   = :pEstacao' + sLineBreak +
      'if @DescrLote <> ' + #39 + #39 + ' Begin ' + sLineBreak +
      '   If @LoteId = 0 Begin' + sLineBreak +
      '      Insert ProdutoLotes Values (@ProdutoId, @DescrLote, ' + sLineBreak
      + '            (Select IdData From Rhema_Data Where Data = @DtFabricacao),'
      + sLineBreak +
      '            (Select IdData From Rhema_Data Where Data = @DtVencimento), '
      + sLineBreak + '          ' + SqlDataAtual + ', ' + SqlHoraAtual +
      ', NewId())' + sLineBreak + '   	  Set @LoteId = SCOPE_IDENTITY()' +
      sLineBreak + '   End' + sLineBreak + '   Else Begin' + sLineBreak +
      '      Update ProdutoLotes set Fabricacao = (Select IdData From Rhema_Data Where Data = @DtFabricacao), '
      + sLineBreak +
      '                              Vencimento = (Select IdData From Rhema_Data Where Data = @DtVencimento)'
      + sLineBreak + '      Where LoteId = @LoteId' + sLineBreak + '   End' +
      sLineBreak + '   If @ItemId = 0 Begin' + sLineBreak +
      '      Insert Into InventarioInicial Values (@InventarioId, @EnderecoId, @ProdutoId, @LoteId, @DtFabricacao,	@DtVencimento,	0,	'
      + #39 + 'C' + #39 + ',	0)' + sLineBreak +
      '     	Set @ItemId = SCOPE_IDENTITY()' + sLineBreak +
      '      Set @StatusItem = (Select Status From InventarioInicial Where ItemId = @ItemId)'
      + sLineBreak + '   End' + sLineBreak + '--   Else' + sLineBreak +
      '--      Set @StatusItem = (Select Status From InventarioInicial Where ItemId = @ItemId)'
      + sLineBreak +
      '   Insert Into InventarioContagem Values (@ItemId, @Quantidade, @UsuarioId, GetDate(), CONVERT (time, SYSDATETIME()), 1, @Estacao)'
      + sLineBreak + '   declare @ContagemId integer =  SCOPE_IDENTITY()' +
      sLineBreak +
      '   Update InventarioInicial Set Status = @StatusItem Where ItemId = @ItemId'
      + sLineBreak +
    // +#39+'F'+#39+' Where ItemId = @ItemId and (((Select InventarioForcarMaxContagem From configuracao) = 0 and Status='+#39+'I'+#39+sLineBreak+
    // '                                                                                              and @Quantidade = EstoqueInicial) or (Status = '+#39+'C'+#39+' and @Quantidade ='+sLineBreak+
    // '                                                                                                  (Select Quantidade From InventarioContagem Where ContagemId = '+sLineBreak+
    // '                                                                                                  (Select Max(ContagemId) From InventarioContagem'+sLineBreak+
    // '                                                                                      Where Itemid=@ItemId and Contagemid <> @ContagemId))) )'+sLineBreak+
      'End' + sLineBreak + 'else Begin' + sLineBreak +
      '   Update InventarioInicial Set Status = @StatusItem Where (ItemId = @ItemId) --'
      + #39 + 'F' + #39 + '  Where (ItemId = @ItemId)' + sLineBreak +
      '                            --and ((Select Status From InventarioInicial where InventarioId = @InventarioId and ItemId = @ItemId) <> '
      + #39 + 'I' + #39 + ')' + sLineBreak + 'end;' + sLineBreak +
      '--Update InventarioInicial Set Status = ' + #39 + 'C' + #39 +
      ' Where ItemId = @ItemId and Status <> ' + #39 + 'F' + #39;

  Const
    SqlInventarioCancelar = 'Declare @InventarioId Integer = :pInventarioId' +
      sLineBreak +
      'Update Inventarios Set Status = 0 Where InventarioId = @InventarioId' +
      sLineBreak + 'Update Ic Set Status  = 0' + sLineBreak +
      'From InventarioContagem Ic' + sLineBreak +
      'Left Join InventarioInicial I On I.ItemId = Ic.ItemId' + sLineBreak +
      'where I.Inventarioid = @InventarioId';

  Const
    SqlGetContagemLote = 'select Ic.*, U.nome' + sLineBreak +
      'From InventarioContagem Ic' + sLineBreak +
      'Inner join Usuarios U On U.Usuarioid = Ic.UsuarioId' + sLineBreak +
      'where Itemid = :pItem';

  Const
    SqlInventarioFechar = 'Declare @InventarioId Integer = :pInventarioId' +
      sLineBreak + 'Declare @Usuario Integer = :pUsuario' + sLineBreak +
      'Declare @Estacao Varchar(30) = :pEstacao' + sLineBreak +
      'CREATE TABLE ##Ajuste' + sLineBreak + '    (' + sLineBreak +
      '        EnderecoId   INT   NOT NULL ,' + sLineBreak +
      '        Loteid Int,' + sLineBreak + '		EstoqueInicial Int,' +
      sLineBreak + '		Quantidade Int,' + sLineBreak + '		Ajuste Int,' +
      sLineBreak + '		Qtde Int);' + sLineBreak +

      'Insert Into ##Ajuste Select II.enderecoid, II.loteid, II.EstoqueInicial, Ic.Quantidade, (Coalesce(Ic.Quantidade, 0) - Coalesce(II.EstoqueInicial, 0)) as Ajuste, Est.Qtde'
      + sLineBreak + 'from InventarioInicial II' + sLineBreak +
      'Left Join Enderecamentos TEnd On TEnd.EnderecoId  = II.EnderecoId' +
      sLineBreak + 'Left Join ProdutoLotes Pl On Pl.LoteId = II.LoteId' +
      sLineBreak + 'Left Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak +
      'Left Join InventarioContagem Ic on Ic.Itemid = II.ItemId And (Ic.ContagemId = (Select Max(ContagemId) From InventarioContagem Where ItemId=Ic.ItemId))'
      + sLineBreak +
      'Left join Estoque Est On Est.EnderecoId = II.EnderecoId and Est.LoteId = II.LoteId'
      + sLineBreak +
      'Where InventarioId = @InventarioId and (Coalesce(Ic.Quantidade, 0) - Coalesce(II.EstoqueInicial, 0)) <> 0'
      + sLineBreak +

      'Delete Est' + sLineBreak + 'from ##Ajuste A' + sLineBreak +
      'Left Join Estoque Est On Est.EnderecoId = A.EnderecoId and Est.LoteId = A.Loteid'
      + sLineBreak + 'Where A.Quantidade = 0' + sLineBreak +

      'Update Est Set Qtde =  Quantidade' + sLineBreak + 'From ##Ajuste A' +
      sLineBreak +
      'Left Join Estoque Est On Est.EnderecoId = A.EnderecoId and Est.LoteId = A.Loteid'
      + sLineBreak + 'Where A.Qtde Is Not Null' + sLineBreak +

      'Insert Into Estoque' + sLineBreak +
      '  Select A.LoteId, A.EnderecoId, 4, A.quantidade, (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'
      + sLineBreak +
      '         (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), @Usuario,'
      + sLineBreak + '	       Null, Null, Null' + sLineBreak +
      '  From ##Ajuste A' + sLineBreak +
      '  Left Join Estoque Est On Est.EnderecoId = A.EnderecoId and Est.LoteId = A.Loteid'
      + sLineBreak + '  Where A.Qtde Is Null' + sLineBreak +

      'Insert Into Kardex' + sLineBreak +
      '  Select 4, A.LoteId, Null, 4, A.Ajuste, A.EstoqueInicial, A.Quantidade, '
      + #39 + 'Ajuste Inventario ' + #39 + '+Cast(@InventarioId as Varchar),' +
      sLineBreak + '         A.EnderecoId, A.EstoqueInicial, A.Quantidade, ' +
      #39 + 'Ajuste Inventario' + #39 + ', ' + sLineBreak +
      '         (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)),'
      + sLineBreak +
      '         (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), @Usuario, @Estacao'
      + sLineBreak + '  From ##Ajuste A' + sLineBreak +

      'Drop Table ##Ajuste';

  Const
    SqlDSHAcompanhamentoContagemInventario =
      'Declare @InventarioIdInicial Integer = :pInventarioIdInicial' +
      sLineBreak + 'Declare @InventarioIdFinal   Integer = :pInventarioIdFinal'
      + sLineBreak + 'Declare @DataInicial   DateTime      = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal     DateTime      = :pDataFinal' +
      sLineBreak +
      'select De.ProcessoId, De.Descricao Processo, Count(*) TotalInventario' +
      sLineBreak + 'From inventarios I' + sLineBreak +
      'inner join vdocumentoetapas De on De.Documento = I.uuid' + sLineBreak +
      'Left Join vDocumentoEtapas DC On DC.Documento = I.uuid and Dc.ProcessoID = 23 and Dc.Status = 1'
      + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = I.uuid and Status = 1)'
      + sLineBreak + '  and I.inventariotipo = 1' + sLineBreak +
      '  and (@InventarioIdInicial = 0 or I.InventarioId >= @InventarioIdInicial)'
      + sLineBreak +
      '  and (@InventarioIdFinal   = 0 or I.InventarioId <= @InventarioIdFinal)'
      + sLineBreak + '  And (@DataInicial = 0 or Dc.Data >= @DataInicial)' +
      sLineBreak + '  And (@DataFinal = 0 or Dc.Data <= @DataFinal)' +
      sLineBreak + 'group by De.ProcessoId, De.Descricao' + sLineBreak +
      'order by Processo';

  Const
    SqlDSHAcompanhamentoContagemEndereco =
      'Declare @InventarioIdInicial Integer = :pInventarioIdInicial' +
      sLineBreak + 'Declare @InventarioIdFinal   Integer = :pInventarioIdFinal'
      + sLineBreak + 'Declare @DataInicial   DateTime      = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal     DateTime      = :pDataFinal' +
      sLineBreak + 'Select Status, (Case When Status = ' + #39 + 'I' + #39 +
      ' then ' + #39 + 'Pendente' + #39 + sLineBreak +
      '                        When Status = ' + #39 + 'C' + #39 + ' then ' +
      #39 + 'Em Contagem' + #39 + sLineBreak + '						When Status = ' +
      #39 + 'F' + #39 + ' then ' + #39 + 'Finalizado' + #39 +
      ' End) Status, Count(*) TotalEndereco' + sLineBreak + 'From (' +
      sLineBreak + 'Select (Case When TINI > 0 Then ' + #39 + 'I' + #39 +
      sLineBreak + '             When TCon > 0 Then ' + #39 + 'C' + #39 +
      sLineBreak + '			          Else ' + #39 + 'F' + #39 + ' End) Status' +
      sLineBreak + 'From InventarioItens  II' + sLineBreak +
      'Inner Join inventarios I On I.inventarioid = II.inventarioid' +
      sLineBreak +
      'Left Join (	Select InventarioId, EnderecoId, Sum(TFin)TFin, Sum(TCon) TCon, Sum(TIni) TIni'
      + sLineBreak + '            From (Select InventarioId, EnderecoId' +
      sLineBreak + '			                    , (Case When Status = ' + #39 +
      'F' + #39 + ' then 1 Else 0 End) TFin' + sLineBreak +
      '		                     , (Case When Status = ' + #39 + 'C' + #39 +
      ' then 1 Else 0 End) TCon' + sLineBreak +
      '			                    , (Case When Status = ' + #39 + 'I' + #39 +
      ' then 1 Else 0 End) TIni' + sLineBreak +
      '			               From InventarioInicial' + sLineBreak +
      '				           Where (@InventarioIdInicial = 0 or InventarioId >= @InventarioIdInicial)'
      + sLineBreak +
      '                             and (@InventarioIdFinal   = 0 or InventarioId <= @InventarioIdFinal) ) St'
      + sLineBreak +
      '				           Group By InventarioId, EnderecoId) IIni ON IIni.EnderecoId = II.EnderecoId and IIni.InventarioId = I.InventarioId'
      + sLineBreak +

    (* 'Left Join (	Select EnderecoId, Sum(TFin)TFin, Sum(TCon) TCon, Sum(TIni) TIni'+sLineBreak+
      '            From (Select EnderecoId'+sLineBreak+
      '			                    , (Case When Status = '+#39+'F'+#39+' then 1 Else 0 End) TFin'+sLineBreak+
      '		                     , (Case When Status = '+#39+'C'+#39+' then 1 Else 0 End) TCon'+sLineBreak+
      '			                    , (Case When Status = '+#39+'I'+#39+' then 1 Else 0 End) TIni'+sLineBreak+
      '			               From InventarioInicial'+sLineBreak+
      '				              Where (@InventarioIdInicial = 0 or InventarioId >= @InventarioIdInicial)'+sLineBreak+
      '                    and (@InventarioIdFinal   = 0 or InventarioId <= @InventarioIdFinal) ) St'+sLineBreak+
      '				              Group By EnderecoId) IIni ON IIni.EnderecoId = II.EnderecoId'+sLineBreak+
    *)
      'Left Join vProduto Prd On Prd.IdProduto = II.ProdutoId' + sLineBreak +
      'Left Join vEnderecamentos E On E.EnderecoId = II.EnderecoId' + sLineBreak
      + 'Left Join vDocumentoEtapas DC On DC.Documento = I.uuid and Dc.ProcessoID = 23 and Dc.Status = 1'
      + sLineBreak +
      'Where (@InventarioIdInicial = 0 or I.InventarioId >= @InventarioIdInicial)'
      + sLineBreak +
      '  and (@InventarioIdFinal   = 0 or I.InventarioId <= @InventarioIdFinal)'
      + sLineBreak + '  And (@DataInicial = 0 or Dc.Data >= @DataInicial)' +
      sLineBreak + '  And (@DataFinal = 0 or Dc.Data <= @DataFinal) ) EndCont' +
      sLineBreak + 'Group by Status';

Const SqlGerarVolumeExtra = 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId'+sLineBreak +
      'Declare @PedidoVolumeIdNovo Integer' + sLineBreak +
      'Declare @UsuarioId Integer = :pUsuarioId' + sLineBreak +
      'Insert Into PedidoVolumes Select EmbalagemId, Pedidoid, '+sLineBreak+
      '            (Select Max(Sequencia)+1 From PedidoVolumes Where PedidoId = '+sLineBreak+
      '            (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId)), Null, ' +sLineBreak +
      '            1, NewId(), '#39 + 'E' + #39 + ', 0'+sLineBreak+
      ' from PedidoVolumes where PedidoVolumeid = @PedidoVolumeId' + sLineBreak
      + 'Set @PedidoVolumeIdNovo = SCOPE_IDENTITY()' + sLineBreak +
      'Insert Into PedidoVolumeLotes' + sLineBreak +
      '       Select @PedidoVolumeIdNovo, LoteId, EnderecoId, EstoqueTipoId, Quantidade-QtdSuprida, EmbalagemPadrao, Quantidade-QtdSuprida,'
      + sLineBreak +
      '              (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), '
      + sLineBreak +
      '              (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))), '
      + sLineBreak + #39 + 'VOL.Extra(' + #39 +
      '+Cast(@PedidoVolumeId as varchar)' + #39 + ')+' + #39 +
      ', @UsuarioId, Processado' + sLineBreak + ' 	     from PedidoVolumeLotes'
      + sLineBreak +
      '       where PedidoVolumeid = @PedidoVolumeId and QtdSuprida <> Quantidade'
      + sLineBreak + '' + sLineBreak +
      'Delete From PedidoVolumeLotes Where QtdSuprida = 0 And PedidoVolumeId = @PedidoVolumeId'
      + sLineBreak +
      'Update PedidoVolumeLotes Set Quantidade = QtdSuprida Where PedidoVolumeId = @PedidoVolumeId'
      + sLineBreak + '' + sLineBreak +
      'Insert Into DocumentoEtapas Values ((Select uuid from PedidoVolumes where PedidoVolumeId = @PedidoVolumeIdNovo), 2, @UsuarioId,'
      + sLineBreak +
      '                                           (Select IdData From Rhema_Data Where Data = Cast(GetDate() as Date)), (select IdHora From Rhema_Hora where Hora = (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5))),'
      + sLineBreak + '										   GetDate(), ' + #39 + 'Volume Extra'
      + #39 + ', 1)' + sLineBreak +
      'Update DocumentoEtapas Set Status = 0 Where Documento = (Select Uuid from Pedido Where PedidoId = (Select PedidoId From PedidoVolumes Where PedidoVolumeId = @PedidoVolumeId)) and ProcessoId > 2'
      + sLineBreak +
    // 'Rollback '+sLineBreak+
      'Select @PedidoVolumeIdNovo as pedidovolumeid';

    // Gerar MD5 do Registro
    // (select CONVERT(VARCHAR(32), HashBytes('MD5', ( select convert(varchar, ItemId)+Convert(varchar, inventarioid)+Convert(varchar, enderecoid)+Convert(varchar, produtoid)+
    // Convert(varchar, loteid)+Convert(varchar, fabricacao)+Convert(varchar, vencimento)+Convert(varchar, estoqueinicial)+
    // Convert(varchar, status)+Convert(varchar, automatico)
    // From InventarioInicial Where ItemId = 1)), 2))

  Const
    SqlGetGerarReposicaoOLD = // 'Declare @Data DateTime = :pData'+sLineBreak+
      'select Df.ProdutoID, Prd.CodProduto, Prd.Descricao, Prd.EnderecoId, Prd.EnderecoDescricao, Prd.ZonaID, Prd.ZonaDescricao, Prd.FatorConversao, Df.DemandaCxaFechada, Df.DemandaFracionada'
      + sLineBreak + '       , Coalesce(EPick.EstPick, 0) EstPick' + sLineBreak
      + '' + sLineBreak +
      '	   , (Case When (Case When Coalesce(EPick.EstPick, 0) < DemandaFracionada then'
      + sLineBreak +
      '						 DemandaFracionada - Coalesce(EPick.EstPick, 0)' + sLineBreak
      + '					   Else' + sLineBreak + '						 0' + sLineBreak +
      '					   End) > (EstPulmao-(DemandaCxaFechada-DemandaFracionada)) then'
      + sLineBreak +
      '					   (EstPulmao-(DemandaCxaFechada-DemandaFracionada))' +
      sLineBreak + '				   Else' + sLineBreak +
      '				   (Case When Coalesce(EPick.EstPick, 0) < DemandaFracionada then'
      + sLineBreak + '					 DemandaFracionada - Coalesce(EPick.EstPick, 0)'
      + sLineBreak + '				   Else' + sLineBreak + '					 0' + sLineBreak
      + '				   End)' + sLineBreak + '			   End) As QtdReposicao' +
      sLineBreak + '	  , EPulmao.EstPulmao' + sLineBreak + 'From (' +
      sLineBreak +
      'Select PedDemanda.ProdutoId, SUM(DemandaCxFechada) DemandaCxaFechada, Sum(DemandaFracionada) DemandaFracionada'
      + sLineBreak + 'From' + sLineBreak +
      '(Select PP.PedidoId, PP.ProdutoId, Pp.FatorConversao, PP.EmbalagemPadrao, PP.QtdPedido, PP.DemandaCxFechada'
      + sLineBreak + '       , Sum(estProd.Qtde) EstCxFechada' + sLineBreak + ''
      + sLineBreak + '	   , (Case When PP.DemandaCxfechada > 0 then' +
      sLineBreak +
      '			  (Case When Sum(estProd.Qtde) >= PP.DemandaCxFechada then' +
      sLineBreak + '					  PP.QtdPedido - PP.DemandaCxFechada' + sLineBreak
      + '				   Else' + sLineBreak +
      '					  PP.QtdPedido - Sum(estProd.Qtde)' + sLineBreak +
      '			  End)' + sLineBreak + '			 Else' + sLineBreak +
      '			    PP.QtdPEdido End) DemandaFracionada' + sLineBreak + '' +
      sLineBreak + 'From vEstoqueProducao EstProd' + sLineBreak +
      'Inner join (Select PP.PedidoId, PP.ProdutoId, Prd.FatorConversao, PP.EmbalagemPadrao, PP.Quantidade as QtdPedido'
      + sLineBreak + '           , (Case When Prd.FatorConversao > 1 then' +
      sLineBreak +
      '		              PP.Quantidade / Prd.FatorConversao * Prd.FatorConversao'
      + sLineBreak + '				   Else' + sLineBreak + '				      0' +
      sLineBreak + '				   End) DemandaCxFechada' + sLineBreak +
      'From Pedido Ped' + sLineBreak +
      'Inner Join PedidoProdutos PP ON PP.PedidoId = Ped.PedidoId' + sLineBreak
      + 'Inner join Rhema_Data DP On Dp.IdData = Ped.DocumentoData' + sLineBreak
      + 'Inner jOin Produto Prd On Prd.IdProduto = PP.ProdutoId' + sLineBreak +
      'Left  Join vDocumentoEtapas De On De.Documento = Ped.uuid' + sLineBreak +
      'WHERE Ped.OperacaoTipoId = 2 and' + sLineBreak +
      '      DE.Horario = (Select Max(Horario) From vDocumentoEtapas Where Documento = Ped.Uuid and Status = 1)'
      + sLineBreak + '	  and De.ProcessoId = 1' + sLineBreak +
      '	  and Dp.Data = :pData) PP ON PP.ProdutoId = EstProd.ProdutoId' +
      sLineBreak + 'where EstProd.Distribuicao = 1' + sLineBreak +
      '      and Vencimento > Cast(getdate()+(COALESCE (MesSaidaMinima, 0)*30) as date)'
      + sLineBreak + '      and EstProd.Qtde >= PP.FatorConversao' + sLineBreak
      + 'Group by PP.PedidoId, PP.ProdutoId, Pp.FatorConversao, PP.EmbalagemPadrao, PP.QtdPedido, PP.DemandaCxFechada'
      + sLineBreak + 'Having (Case When PP.DemandaCxfechada > 0 then' +
      sLineBreak +
      '			  (Case When Sum(estProd.Qtde) >= PP.DemandaCxFechada then' +
      sLineBreak + '					  PP.QtdPedido - PP.DemandaCxFechada' + sLineBreak
      + '				   Else' + sLineBreak +
      '					  PP.QtdPedido - Sum(estProd.Qtde)' + sLineBreak +
      '			  End)' + sLineBreak + '			 Else' + sLineBreak +
      '			    PP.QtdPEdido End) > 0) PedDemanda' + sLineBreak +
      'Group by PedDemanda.Produtoid) DF --DemandaFracionada' + sLineBreak +
      'Left Join (Select ProdutoId, Sum(Qtde) EstPick From vEstoqueProducao Where PickingFixo = 1 Group By ProdutoId) EPick On EPick.ProdutoId = DF.ProdutoId'
      + sLineBreak +
      'Left Join (Select ProdutoId, Sum(Qtde) EstPulmao From vEstoqueProducao Where Distribuicao = 1 and Qtde>0 Group By ProdutoId) EPulmao On EPulmao.ProdutoId = DF.ProdutoId'
      + sLineBreak + 'Inner join vProduto Prd On Prd.IdProduto = DF.ProdutoId' +
      sLineBreak +
      'Where (Case When (Case When Coalesce(EPick.EstPick, 0) < DemandaFracionada then'
      + sLineBreak +
      '						 DemandaFracionada - Coalesce(EPick.EstPick, 0)' + sLineBreak
      + '					   Else' + sLineBreak + '						 0' + sLineBreak +
      '					   End) > (EstPulmao-(DemandaCxaFechada-DemandaFracionada)) then'
      + sLineBreak +
      '					   (EstPulmao-(DemandaCxaFechada-DemandaFracionada))' +
      sLineBreak + '				   Else' + sLineBreak +
      '				   (Case When Coalesce(EPick.EstPick, 0) < DemandaFracionada then'
      + sLineBreak + '					 DemandaFracionada - Coalesce(EPick.EstPick, 0)'
      + sLineBreak + '				   Else' + sLineBreak + '					 0' + sLineBreak
      + '				   End)' + sLineBreak + '			   End) > 0'; // +sLineBreak+
    // 'Order by Prd.ZonaDescricao, Prd.Descricao--Df.ProdutoId';

  Const
    SqlReposicaoCreate = 'Declare @PedidoId Integer  = :pPedidoId' + sLineBreak
      + 'Declare @UsuarioId integer = :pUsuarioId' + sLineBreak +
      'Declare @Terminal Varchar(50) = :pTerminal' + sLineBreak +
      'Declare @DtProducao DateTime = (Select Data From Rhema_Data Rd' +
      sLineBreak +
      '                                Inner Join Pedido Ped on Ped.DocumentoData = Rd.IdData'
      + sLineBreak +
      '								                        Where Ped.PedidoId = @PedidoId)' +
      sLineBreak +
      'Declare @ReposicaoId Integer = Coalesce((Select ReposicaoId From Reposicao Where DtRessuprimento = @DtProducao), 0)'
      + sLineBreak + 'If @ReposicaoId = 0 Begin' + sLineBreak +
      '   Insert Into Reposicao Values ( @DtProducao, ' + #39 + 'A' + #39 +
      ', (select ProcessoId from ProcessoEtapas Where Descricao = ' + #39 +
      'Reposi��o - Criada' + #39 + '),' + sLineBreak +
      '               @UsuarioId, @Terminal, GETDATE(), (select SUBSTRING(CONVERT(VARCHAR,SYSDATETIME()),12,5)), NEWID() )'
      + sLineBreak + '   Set @ReposicaoId = SCOPE_IDENTITY()' + sLineBreak +

      'End' + sLineBreak + 'Else Begin' + sLineBreak + '   Select @ReposicaoId'
      + sLineBreak + 'End;';

  Const
    SqlGetGerarReposicao = 'Declare @DataPedido DateTime = :pDataPedido' +
      sLineBreak + 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @EnderecoIni Varchar(11) = :pEnderecoIni' + sLineBreak +
      'Declare @EnderecoFin Varchar(11) = :pEnderecoFin' + sLineBreak + 'select'
      + sLineBreak +
      '       Prd.IdProduto, Prd.CodProduto, Prd.Descricao, Prd.FatorConversao, Prd.EnderecoId,'
      + sLineBreak +
      '	   Prd.EnderecoDescricao Endereco, prd.mascara, Prd.ZonaId, Prd.ZonaDescricao Zona,'
      + sLineBreak +
      '	   Coalesce(EstPicking.Qtde, 0) SaldoPicking, DE.Demanda, De.EmbalagemPadrao, DE.Disponivel,'
      + sLineBreak + '	   (Case When Prd.FatorConversao = 1 then ' + #39 +
      'Unid' + #39 + sLineBreak +
      '	         Else Prd.UnidadeSecundariaDescricao+' + #39 + ' c/ ' +
      #39'+Cast(Prd.FatorConversao as VarChar) End) Embalagem' + sLineBreak +
      'From (Select P.Produtoid, P.EmbalagemPadrao, P.Demanda, Sum(Est.Qtde / P.EmbalagemPadrao) Disponivel'
      + sLineBreak + 'From vEstoque Est' + sLineBreak +
      'Inner join (Select Pl.ProdutoId, Vl.EmbalagemPadrao, sum(Quantidade) Demanda'
      + sLineBreak + '      From PedidoVolumeLotes VL' + sLineBreak +
      '      Inner join PedidoVolumes Vlm On Vlm.PedidoVOlumeId = Vl.PedidoVOlumeID'
      + sLineBreak +
      '      Inner Join Pedido Ped On ped.PedidoId = Vlm.Pedidoid' + sLineBreak
      + '      Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      '      Inner Join vDocumentoEtapas DE On De.Documento = Vlm.uuid' +
      sLineBreak + '      Inner Join ProdutoLotes Pl On Pl.LoteId = VL.LoteId' +
      sLineBreak +
      '	  Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1) and'
      + sLineBreak +
      '	        Ped.OperacaoTipoId = 2 And De.ProcessoId < 13 and' + sLineBreak
      + '	        Vlm.EmbalagemId Is Not Null And (@DataPedido = 0 or Rd.Data = @DataPedido)'
      + sLineBreak +
      '	  Group by Pl.ProdutoId, Vl.EmbalagemPadrao) P ON P.ProdutoId= Est.ProdutoId'
      + sLineBreak +
      'Where Est.Qtde >= P.EmbalagemPadrao and Est.PickingFixo = 0' + sLineBreak
      + 'Group by P.Produtoid, P.EmbalagemPadrao, P.Demanda' + sLineBreak +
      'having Sum(Est.Qtde / P.EmbalagemPadrao) > 0) DE --Demanda e Estoque' +
      sLineBreak + 'Inner Join vProduto Prd ON Prd.Idproduto = DE.ProdutoId' +
      sLineBreak +
      'Left Join (Select ProdutoID, SUM(Qtde) Qtde From vEstoqueProducao vEst' +
      sLineBreak + '           Where PickingFixo = 1' + sLineBreak +
      '		   Group by ProdutoId) As EstPicking ON EstPicking.ProdutoId = Prd.IdProduto'
      + sLineBreak +

      'Where --Prd.EstruturaID = 2 --and P.Demanda > Coalesce(Est.Estoque, 0)' +
      sLineBreak + '	  (@ZonaId = 0 or Prd.ZonaId = @ZonaId)' + sLineBreak +
      '	  And (@EnderecoIni = ' + #39 + #39 +
      ' or Prd.EnderecoDescricao >= @EnderecoIni)' + sLineBreak +
      '	  And (@EnderecoFin = ' + #39 + #39 +
      ' or Prd.EnderecoDescricao <= @EnderecoFin)' + sLineBreak +
      '   and DE.Demanda > Coalesce(EstPicking.qtde, 0)' + sLineBreak +
      'Order by Endereco';

  Const
    GetReposicaoEnderecoColeta = 'Declare @DataPedido DateTime = :pDataPedido' +
      sLineBreak + 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @EnderecoIni Varchar(11) = :pEnderecoInicial' + sLineBreak +
      'Declare @EnderecoFin Varchar(11) = :pEnderecoFinal' + sLineBreak +
      'select ProdToReposicao.*, Est.EnderecoId, EndP.Endereco, Est.Vencimento, Est.EstoqueTipoId,Est.Qtde, Est.DtEntrada, est.HrEntrada'
      + sLineBreak +
      'From (select Prd.IdProduto, Prd.CodProduto, Prd.Descricao, ' + sLineBreak
      + '             (Case When Prd.FatorConversao = 1 then ' + #39 + 'Unid' +
      #39 + ' Else Prd.UnidadeSecundariaDescricao' + #39 + 'c/ ' + #39 +
      '+Cast(Prd.FatorConversao as VarChar) End) Embalagem, Prd.FatorConversao, Prd.UnidadeSecundariaDescricao, TEnd.EnderecoId, Tend.Endereco Picking, TEnd.ZonaId, TEnd.Zona, vl.loteid,'
      + sLineBreak +
      '             Pl.DescrLote, ( QtdSuprida - Coalesce(Estoque, 0) ) Reabastecer'
      + sLineBreak + 'from PedidoVolumeLotes VL' + sLineBreak +
      'Inner join PedidoVolumes Vlm On Vlm.PedidoVOlumeId = Vl.PedidoVOlumeID' +
      sLineBreak + 'Inner Join Pedido Ped On ped.PedidoId = Vlm.Pedidoid' +
      sLineBreak +
      'Inner Join vEnderecamentos TEnd on TEnd.EnderecoId = Vl.EnderecoId' +
      sLineBreak + 'Inner Join ProdutoLotes Pl On Pl.LoteId = VL.LoteId' +
      sLineBreak + 'Inner Join Produto Prd ON Prd.Idproduto = Pl.ProdutoId' +
      sLineBreak + 'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' +
      sLineBreak + 'Left Join (Select LoteId, EnderecoId, Sum(Qtde*-1) Estoque'
      + sLineBreak + '           from vEstoque' + sLineBreak +
      '		   Where (Vencimento > Cast(getdate()+(COALESCE (MesSaidaMinima, 0)*30) as date)) and Qtde > 0'
      + sLineBreak +
      '		   Group By LoteId, EnderecoId) est On Est.LoteId = vl.LoteId and Est.Enderecoid = Prd.EnderecoId'
      + sLineBreak + 'Inner Join vDocumentoEtapas DE On De.Documento = Ped.uuid'
      + sLineBreak +
      'Where TEnd.EstruturaID = 2 and Vl.QtdSuprida > Coalesce(Est.Estoque, 0)'
      + sLineBreak +
      '      And De.ProcessoId <= 13 and De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '	  And (@DataPedido = 0 or Rd.Data = @DataPedido)' +
      sLineBreak + '	  And (@ZonaId = 0 or TEnd.ZonaId = @ZonaId)' + sLineBreak
      + '	  And (@EnderecoIni = ' + #39 + #39 +
      ' or Tend.Endereco >= @EnderecoIni)' + sLineBreak +
      '	  And (@EnderecoFin = ' + #39 + #39 +
      ' or Tend.Endereco <= @EnderecoFin)) ProdToReposicao' + sLineBreak +
      'Inner join vEstoque Est on Est.LoteId = ProdToReposicao.LoteId' +
      sLineBreak +
      'Inner Join vEnderecamentos EndP on EndP.EnderecoId = Est.EnderecoId' +
      sLineBreak + 'Where est.Distribuicao = 1' + sLineBreak +
      'Order by Est.ProdutoId, Est.Vencimento, Est.DtEntrada, Est.HrEntrada';

    // Gerar Reposi��o Autom�tica
  Const
    SqlGerarPedidoReposicao = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'Declare @LoteId Integer = :pLoteId' + sLineBreak +
      'Declare @EnderecoId Integer = :pEnderecoId' + sLineBreak +
      'Declare @EstoqueTipoId Integer = :pEstoqueTipoId' + sLineBreak +
      'Declare @Quantidade Integer =  :pQuantidade' + sLineBreak +
      'If Not Exists (Select PedidoReposicaoId From PedidoReposicao' +
      sLineBreak + '               Where PedidoId = @PedidoId and' + sLineBreak
      + '			         LoteId = @LoteId and' + sLineBreak +
      '					 EnderecoId = @EnderecoId) Begin' + sLineBreak +
      '  Insert Into PedidoReposicao (PedidoId, LoteId, EnderecoId, EstoqueTipoId, Demanda, Reposicao)'
      + sLineBreak +
      '         Values (@PedidoId, @Loteid, @EnderecoId, @EstoqueTipoId, @Quantidade, 0)'
      + sLineBreak + 'End' + sLineBreak + 'Else Begin' + sLineBreak +
      '  Update PedidoReposicao' + sLineBreak +
      '    Set Demanda = Demanda + @Quantidade' + sLineBreak +
      '  Where PedidoId = @PedidoId and' + sLineBreak +
      '		      LoteId = @LoteId and' + sLineBreak +
      '		      EnderecoId = @EnderecoId And' + sLineBreak +
      '        EstoqueTipoId = @EstoqueTipoId' + sLineBreak + 'End;';

  Const
    SqlGetConsultaReposicaoBasico = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @ReposicaoId Integer  = :pReposicaoId' + sLineBreak +
      'Declare @ProcessoId Integer   = :pProcessoid' + sLineBreak +
      'Declare @Pendente Integer     = :pPendente' + sLineBreak +
      'Select Rep.*, (Case When ReposicaoTipo = 1 then ' + #39 + 'Demanda' + #39
      + sLineBreak + '                    When ReposicaoTipo = 2 then ' + #39 +
      'Capacidade' + #39 + sLineBreak + '					When ReposicaoTipo = 3 then '
      + #39 + 'Automat�ca' + #39 + sLineBreak +
      '					When ReposicaoTipo = 4 then ' + #39 + 'Corretiva' + #39 +
      ' End) Tipo, URep.Nome UsuarioReposicao, Pe.Descricao Processo, Zn.Descricao Zona'
      + sLineBreak +
      '     , CONVERT(VARCHAR(10), CAST(rep.DtReposicao  AS DATE), 103) DataReposicao  '
      + sLineBreak + 'from Reposicao Rep' + sLineBreak +
      'Inner Join Usuarios URep On uRep.UsuarioId = Rep.UsuarioId' + sLineBreak
      + 'Inner Join ProcessoEtapas Pe On Pe.ProcessoId = Rep.ProcessoId' +
      sLineBreak + 'Left Join EnderecamentoZonas Zn On Zn.Zonaid = Rep.ZonaId' +
      sLineBreak + 'Where (@Datainicial = 0 or Rep.DtReposicao>=@DataInicial)' +
      sLineBreak + '  And (@DataFinal = 0 or Rep.DtReposicao<=@DataFinal)' +
      sLineBreak + '  And (@ReposicaoId = 0 or Rep.ReposicaoId = @ReposicaoId)'
      + sLineBreak + '  And (@ProcessoId = 0 or Rep.ProcessoId = @ProcessoId)' +
      sLineBreak + '  And (@Pendente <> 1 or Rep.ProcessoId in (27,28))' +
      sLineBreak + '  And (Rep.ProcessoId <> 31)' + sLineBreak +
      'Order by Rep.DtReposicao';

  Const
    SqlGetConsultaReposicao = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @ReposicaoId Integer = :pReposicaoId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoid' + sLineBreak +
      'Declare @Pendente Integer     = :pPendente' + sLineBreak +
      'Select Rep.ReposicaoId, --Rep.*, URep.Nome UsuarioReposicao,' +
      sLineBreak +
      '       Prd.IdProduto ProdutoId, Prd.CodProduto, Prd.Descricao,' +
      sLineBreak +
      '	   (Case When Prd.FatorConversao = 1 then Prd.UnidadeSigla' + sLineBreak
      + '	         Else Prd.UnidadeSecundariaSigla+' + #39 + ' c/' + #39 +
      '+Cast(Prd.FatorConversao as Char) End) Embalagem, Prd.FatorConversao,' +
      sLineBreak +
      '	   Prd.EnderecoId Pickingid, Prd.EnderecoDescricao Picking, Prd.Mascara MascaraPicking, '
      + sLineBreak +
      '	   vEnd.EnderecoId, vEnd.Endereco, VEnd.Mascara, vEnd.ZonaId, vEnd.Zona,'
      + sLineBreak +
      '	   Pl.LoteId, Pl.DescrLote, CONVERT(VARCHAR(10), CAST(Lv.Data  AS DATE), 103) Vencimento, '
      + sLineBreak +
      '    Coalesce(Rec.EstoqueDisponivel, 0) Disponivel, Rec.Qtde Demanda, Rec.EstoqueTipoId,'
      + sLineBreak +
      '	   Rec.QtdRepo Reposicao, URec.UsuarioId, URec.Nome, Rec.Terminal,' +
      sLineBreak +
      '	   CONVERT(VARCHAR(10), CAST(Rec.DtEntrada  AS DATE), 103) DataEntrada, Rec.HrEntrada'
      + sLineBreak + 'from Reposicao Rep' + sLineBreak +
      'Inner Join ReposicaoEnderecoColeta Rec On Rec.Reposicaoid = Rep.ReposicaoId'
      + sLineBreak + 'Inner join vProduto Prd on Prd.IdProduto = Rec.ProdutoId'
      + sLineBreak + 'Inner Join ProdutoLotes Pl On Pl.LoteId = Rec.LoteId' +
      sLineBreak + 'Inner Join Rhema_Data Lv on Lv.IdData = Pl.Vencimento' +
      sLineBreak +
      'Inner Join vEnderecamentos vEnd On VEnd.EnderecoId = Rec.EnderecoId' +
      sLineBreak + 'Inner Join Usuarios URep On uRep.UsuarioId = Rep.UsuarioId'
      + sLineBreak + 'Left Join Usuarios URec On uRec.UsuarioId = Rec.UsuarioId'
      + sLineBreak + 'Where (@Datainicial = 0 or Rep.DtReposicao>=@DataInicial)'
      + sLineBreak + '    And (@DataFinal = 0 or Rep.DtReposicao<=@DataFinal)' +
      sLineBreak +
      '    And (@ReposicaoId = 0 or Rep.ReposicaoId = @ReposicaoId)' +
      sLineBreak +
      '    And (@ReposicaoId = 0 or Rep.ReposicaoId = @ReposicaoId)' +
      sLineBreak + '    And (@ProcessoId = 0 or Rep.ProcessoId = @ProcessoId)' +
      sLineBreak + '    And (@Pendente <> 1 or Rep.ProcessoId in (27,28))' +
      sLineBreak + 'Order By Rep.ReposicaoId, vEnd.Endereco --Prd.IdProduto --';

  Const
    SqlGetConsultaReposicaoProduto = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @ReposicaoId Integer = :pReposicaoId' + sLineBreak +
      'Select Rep.ReposicaoId, --URep.Nome UsuarioReposicao,' + sLineBreak +
      '       Prd.IdProduto ProdutoId, Prd.CodProduto, Prd.Descricao,' +
      sLineBreak +
      '	   Prd.EnderecoId Pickingid, Prd.EnderecoDescricao Picking,' +
      sLineBreak +
      '	   Prd.Mascara MascaraPicking, Prd.ZonaId, Prd.ZonaDescricao Zona,' +
      sLineBreak +
      '	   Coalesce(Rec.Qtde, 0) Demanda, Coalesce(Sum(Rec.QtdRepo), 0) Reposicao'
      + sLineBreak + 'from Reposicao Rep' + sLineBreak +
      'Inner Join ReposicaoEnderecoColeta Rec On Rec.Reposicaoid = Rep.ReposicaoId'
      + sLineBreak + 'Inner join vProduto Prd on Prd.IdProduto = Rec.ProdutoId'
      + sLineBreak + '--Inner Join ProdutoLotes Pl On Pl.LoteId = Rec.LoteId' +
      sLineBreak + '--Inner Join Rhema_Data Lv on Lv.IdData = Pl.Vencimento' +
      sLineBreak + 'Where (@ReposicaoId = 0 or Rep.ReposicaoId = @ReposicaoId)'
      + sLineBreak + '  And (Rep.ProcessoId <> 31)' + sLineBreak +
      'Group by Rep.ReposicaoId,' + sLineBreak +
      '      Prd.IdProduto, Prd.CodProduto, Prd.Descricao, Prd.EnderecoId, Prd.EnderecoDescricao,'
      + sLineBreak +
      '	     Prd.Mascara, Prd.ZonaId, Prd.ZonaDescricao, Rec.Qtde' + sLineBreak
      + 'Order by Prd.Descricao';

  Const
    SqlGetReposicaoAutomatica = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @DataReposicao DateTime = :pDataReposicao' + sLineBreak +
      'Declare @Status integer = :pStatus' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @EnderecoInicial VarChar(11) = :pEnderecoInicial' + sLineBreak +
      'Declare @EnderecoFinal VarChar(11) = :pEnderecoFinal' + sLineBreak +
      'Select Prd.IdProduto Produtoid, Prd.CodProduto, Prd.Descricao, Prd.EnderecoId PickingId,'
      + sLineBreak +
      '       Prd.EnderecoDescricao Picking, Prd.Mascara MascaraPicking,' +
      sLineBreak +
      '      Prd.ZonaId, Prd.ZonaDescricao Zona, (Case When Prd.FatorConversao = 1 then '
      + #39 + 'Unid' + #39 + sLineBreak +
      '	                       Else Prd.UnidadeSecundariaSigla+' + #39 + ' c/' +
      #39 + '+Cast(FatorConversao As Char) End) Embalagem,' + sLineBreak +
      '	   Sum(Pr.Demanda) Demanda,Sum(Pr.Reposicao) Reposicao' + sLineBreak +
      'from PedidoReposicao PR' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Pr.PedidoId' + sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.LoteId = Pr.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      'Inner Join vEnderecamentos TEnd on TEnd.EnderecoId = Pr.EnderecoId' +
      sLineBreak + 'Inner join Rhema_Data Rd On Rd.IdData = Pl.Vencimento' +
      sLineBreak + 'Inner join Rhema_Data DP On Dp.IdData = Ped.DocumentoData' +
      sLineBreak + 'Left Join (Select EnderecoId, LoteId, Sum(Qtde) Qtde' +
      sLineBreak + '           From vEstoqueProducao' + sLineBreak +
      '           Group by EnderecoId, Loteid) Est On Est.LoteId = Pr.LoteId and Est.EnderecoId = Pr.EnderecoId'
      + sLineBreak + 'Where (@DataReposicao = 0 or @DataReposicao = DP.Data)' +
      sLineBreak + '      And (@ZonaId = 0 or Prd.ZonaId = @ZonaId)' +
      sLineBreak + '      And (@EnderecoInicial = ' + #39 + #39 +
      ' or Prd.EnderecoDescricao >= @EnderecoInicial)' + sLineBreak +
      '      And (@EnderecoFinal = ' + #39 + #39 +
      ' or Prd.EnderecoDescricao <= @EnderecoFinal)' + sLineBreak +
      '      And (Pr.Status = @Status)' + sLineBreak +
      'Group by Prd.IdProduto, Prd.CodProduto, Prd.Descricao, Prd.EnderecoId, Prd.Mascara, Prd.EnderecoDescricao,Prd.ZonaId,'
      + sLineBreak +
      '         Prd.ZonaDescricao, Prd.FatorConversao, UnidadeSecundariaSigla' +
      sLineBreak + 'Order by Picking, Prd.Descricao';

  Const
    SqlGetReposicaoAutomaticaColeta = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @DataReposicao DateTime = :pDataReposicao' + sLineBreak +
      'Declare @Status integer = :pStatus' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @EnderecoInicial VarChar(11) = :pEnderecoInicial' + sLineBreak +
      'Declare @EnderecoFinal VarChar(11) = :pEnderecoFinal' + sLineBreak +
      'select Prd.IdProduto Produtoid, Prd.CodProduto, Prd.Descricao, Prd.EnderecoId PikcingId, Prd.EnderecoDescricao Picking, Prd.Mascara MascaraPicking,'
      + sLineBreak +
      '       Prd.ZonaId, Prd.ZonaDescricao Zona, Pl.LoteId, Pl.DescrLote, Rd.Data Vencimento, (Case When Prd.FatorConversao = 1 then '
      + #39 + 'Unid' + #39 + sLineBreak +
      '	                       Else Prd.UnidadeSecundariaSigla+' + #39 + ' c/' +
      #39 + '+Cast(FatorConversao As Char) End) Embalagem,' + sLineBreak +
      '	   TEnd.EnderecoId, TEnd.Endereco, TEnd.Mascara Mascara, Pr.EstoqueTipoId, Sum(Pr.Demanda) Demanda, Est.Qtde Disponivel'
      + sLineBreak + // Pr.Demanda, Est.Qtde Disponivel'+sLineBreak+
      'from PedidoReposicao PR' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Pr.PedidoId' + sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.LoteId = Pr.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      'Inner Join vEnderecamentos TEnd on TEnd.EnderecoId = Pr.EnderecoId' +
      sLineBreak + 'Inner join Rhema_Data Rd On Rd.IdData = Pl.Vencimento' +
      sLineBreak + 'Inner join Rhema_Data DP On Dp.IdData = Ped.DocumentoData' +
      sLineBreak + 'Left Join (Select EnderecoId, LoteId, Sum(Qtde) Qtde' +
      sLineBreak + '           From vEstoqueProducao' + sLineBreak +
      '           Group by EnderecoId, Loteid) Est On Est.LoteId = Pr.LoteId and Est.EnderecoId = Pr.EnderecoId'
      + sLineBreak + 'Where (@DataReposicao = 0 or @DataReposicao = DP.Data)' +
      sLineBreak + '      And (@ZonaId = 0 or Prd.ZonaId = @ZonaId)' +
      sLineBreak + '      And (@EnderecoInicial = ' + #39 + #39 +
      ' or Prd.EnderecoDescricao >= @EnderecoInicial)' + sLineBreak +
      '      And (@EnderecoFinal = ' + #39 + #39 +
      ' or Prd.EnderecoDescricao <= @EnderecoFinal)' + sLineBreak +
      '      And (Pr.Status = @Status)' + sLineBreak +
      'Group by Prd.IdProduto, Prd.CodProduto, Prd.Descricao, Prd.EnderecoId, Prd.EnderecoDescricao, Prd.Mascara,'
      + sLineBreak +
      '       Prd.ZonaId, Prd.ZonaDescricao, Pl.LoteId, Pl.DescrLote, Rd.Data, Prd.UnidadeSecundariaSigla, FatorConversao,'
      + sLineBreak +
      '	   TEnd.RuaId, TEnd.EnderecoId, TEnd.Endereco, TEnd.Mascara, Pr.EstoqueTipoId, Est.Qtde'
      + sLineBreak + 'Order by TEnd.RuaId, TEnd.Endereco';
    // 'Order by TEnd.RuaId, TEnd.Descricao';

  Const
    SqlGetCargaHeader = 'SET STATISTICS IO OFF' + sLineBreak +
      'SET STATISTICS TIME OFF' + sLineBreak +
      'Declare @CargaId Integer = :pCargaId' + sLineBreak +
      'select C.CargaId, C.DtInclusao, C.hrinclusao, R.RotaId, R.Descricao Rota, T.PessoaId TranspId, T.Razao Transportadora,'
      + sLineBreak +
      '       M.PessoaId MotoristaId, M.Razao Motorista, V.VeiculoId, V.Placa' +
      sLineBreak +
      '	      , CDest.TDestinatario, CPed.TPedido, Cpp.QtdSuprida, De.ProcessoId, Pe.Descricao Processo,'
      + sLineBreak + '		  (Case When De.ProcessoId = 16 and ' + sLineBreak +
      '		          Exists (Select Processo From CargaCarregamento' + sLineBreak
      + '		          where cargaid = C.cargaid And processo = ' + #39 + 'CO' +
      #39 + ') then 1' + sLineBreak +
      '				      When De.ProcessoId in (16, 18) and' + sLineBreak +
      '		          Exists (Select Processo From CargaCarregamento' + sLineBreak
      + '		          where cargaid = C.cargaid And processo = ' + #39 + 'CA' +
      #39 + ') then 2' + sLineBreak + '				      Else 0 End) StatusOper' +
      sLineBreak + 'From Cargas C' + sLineBreak +
      'Inner join Rotas R On R.RotaId = C.RotaId' + sLineBreak +
      'Inner join Pessoa T On T.PessoaId = C.transportadoraid and PessoaTipoId = 3'
      + sLineBreak + 'Inner join Pessoa M On M.PessoaId = C.MotoristaId' +
      sLineBreak + 'Inner join Veiculos V On V.VeiculoId = C.veiculoid' +
      sLineBreak +
      'Left Join (Select  CargaId,Count( Distinct PessoaId) TDestinatario' +
      sLineBreak + '		        	From CargaPedidos CP' + sLineBreak +
      '			        Inner Join Pedido Ped On Ped.PedidoId = Cp.PedidoId  Group by CargaId) CDest On CDest.CargaId = C.CargaId'
      + sLineBreak +
      'Left Join (Select CargaId, Count(PedidoId) TPedido From CargaPedidos Group by CargaId) CPed On CPed.CargaId = C.CargaId'
      + sLineBreak + 'Left Join (select CargaId, Sum(QtdSuprida) QtdSuprida' +
      sLineBreak + '           From CargaPedidos Cp' + sLineBreak +
      '		         Inner Join PedidoVolumes Vlm On Vlm.PedidoId = Cp.Pedidoid' +
      sLineBreak +
      '		         Inner join PedidoVolumeLotes Vl on Vl.PedidoVOlumeId = VLm.PedidoVolumeId'
      + sLineBreak +
      '		         Group by CargaId) CPP On Cpp.CargaId = C.CargaId' +
      sLineBreak + 'Inner Join vDocumentoEtapas De On De.Documento = C.uuid' +
      sLineBreak +
      'Inner Join ProcessoEtapas Pe On Pe.ProcessoId = De.ProcessoId' +
      sLineBreak + 'Where C.CargaId = @CargaId' + sLineBreak +
      '      And C.CargaId = @CargaId' + sLineBreak +
      '      And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = C.uuid and Status = 1)';

  Const
    SqlGetCargaPessoas = 'Declare @CargaId  Integer = :pCargaId' + sLineBreak +
      'select Cp.CargaId, Pes.PessoaId, Pes.CodPessoaERP, Pes.Razao,' +
      sLineBreak + '       Pes.Fantasia, Rp.ordem, Count(*) TotPed,' +
      sLineBreak +
      '	      Sum(TotPed.TCxaFechada) TVolCxaFechada, -- TCxaFechada,' +
      sLineBreak +
      '	      Sum(TotPed.TCxaFracionada) TVolFracionado, --TCxaFracionada,' +
      sLineBreak + '	      Sum(TotPed.Cancelado) Cancelado,' + sLineBreak +
      '	      Sum((Case When Conferido = 1 then 1 Else 0 End)) Conferido' +
      sLineBreak + '	    , Sum(PedCub.Peso) Peso, Sum(PedCub.Volm3) Volm3' +
      sLineBreak + 'From CargaPedidos Cp' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Cp.PedidoId' + sLineBreak +
      'Inner join Pessoa Pes ON Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Inner Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' + sLineBreak +
      'Left Join (Select Pv.PedidoId, Sum((Case When EmbalagemId Is Null and Etapa.ProcessoId <> 15 then 1 Else 0 End)) TCxaFechada,'
      + sLineBreak +
      '                  Sum((Case When EmbalagemId Is not Null and Etapa.ProcessoId <> 15 then 1 Else 0 End)) TCxaFracionada,'
      + sLineBreak +
      '				              Sum((Case When Etapa.ProcessoId = 15 then 1 Else 0 End)) Cancelado'
      + sLineBreak + '			        From Pedido Ped' + sLineBreak +
      '			        Left Join PedidoVolumes PV On Pv.PedidoId = Ped.PedidoId' +
      sLineBreak +
      '			        Left Join vDocumentoEtapas Etapa On Etapa.Documento = Pv.uuid and '
      + sLineBreak +
      '                     Etapa.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '			        Group by Pv.PedidoId) As TotPed On TotPed.PedidoId =Ped.PedidoId'
      + sLineBreak +
      'Left Join (select Pv.PedidoId, Cast(Sum(Pvl.QtdSuprida*Prd.PesoLiquido)/100 as decimal(15,3)) as Peso,'
      + sLineBreak +
      '           Sum(cast(Cast(Pvl.QtdSuprida*(Prd.Altura*Prd.Largura*Prd.Comprimento) as Decimal(15,6))/1000000 as Decimal(15,6))) Volm3'
      + sLineBreak + '           From PedidoVolumes PV' + sLineBreak +
      '           Inner Join PedidoVolumeLotes PVL ON PVL.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak +
      '           Inner Join ProdutoLotes PL On Pl.LoteId = PVL.LoteId' +
      sLineBreak +
      '           Inner Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak + '           Group by PV.PedidoId' + sLineBreak +
      '           ) as PedCub ON PedCub.PedidoId = Ped.PedidoId' + sLineBreak +
      'Where Cp.CargaId = @CargaId' + sLineBreak +
      'Group by Cp.CargaId, Pes.PessoaId, Pes.CodPessoaERP, Pes.Razao, Pes.Fantasia, Rp.ordem'
      + sLineBreak + 'Order by Rp.ordem';

    { 'select Cp.CargaId, Pes.PessoaId, Pes.CodPessoaERP, Pes.Razao, Rp.ordem, '+sLineBreak+
      '       Count(*) TPed, Sum((Case When Conferido = 1 then 1 Else 0 End)) Conferido'+sLineBreak+
      'From CargaPedidos Cp '+sLineBreak+
      'Inner Join Pedido Ped On Ped.PedidoId = Cp.PedidoId'+sLineBreak+
      'Inner join Pessoa Pes ON Pes.PessoaId = Ped.PessoaId'+sLineBreak+
      'Inner Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId'+sLineBreak+
      'Where Cp.CargaId = @CargaId'+sLineBreak+
      'Group by Cp.CargaId, Pes.PessoaId, Pes.CodPessoaERP, Pes.Razao, Rp.ordem, Ped.DocumentoNr,Ped.documentooriginal'+sLineBreak+
      'Order by Rp.ordem';
    }

  Const
    SqlGetCargaPedidos = 'Declare @CargaId Integer  = :pCargaId' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @Processo Char(2) = :pProcesso' + sLineBreak +
      'select Distinct Ped.DocumentoData, Cp.CargaId, Ped.PedidoId, Ped.DocumentoOriginal, '
      + sLineBreak +
      '       Pes.PessoaId, Vlm.QtdVolume, Vlm.Itens, Vlm.Conferido, Ped.NotaFiscalERP'
      + sLineBreak + 'From CargaPedidos Cp' + sLineBreak +
      'Inner Join vPedidos Ped On Ped.PedidoId = Cp.PedidoId' + sLineBreak +
      'Inner Join (Select Vlm.PedidoId, Count(Vlm.PedidoVolumeId) QtdVolume, ' +
      sLineBreak +
      '                   Sum(Vl.Itens) Itens, Sum((Case When CC.Carregamentoid Is Not Null then 1 else 0 End)) Conferido'
      + sLineBreak + '            From PedidoVolumes Vlm' + sLineBreak +
      '            Left Join CargaCarregamento CC On Cc.PedidoVolumeId = Vlm.PedidoVolumeId and CC.Processo = @PRocesso'
      + sLineBreak +
      '            Inner join (Select PedidoVolumeId, Sum(QtdSuprida) Itens From PedidoVolumeLotes Group by PedidoVolumeId) Vl On Vl.PedidoVolumeId = Vlm.PedidoVOlumeId'
      + sLineBreak +
      '            Left Join vDocumentoEtapas DE On De.Documento = Vlm.uuid' +
      sLineBreak +
      '            where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1) And De.ProcessoId <> 15'
      + sLineBreak +
      '			Group By Vlm.PedidoId) as Vlm On Vlm.PedidoId = Ped.PedidoId' +
      sLineBreak + 'Inner join Pessoa Pes on Pes.PessoaId = Ped.PessoaId' +
      sLineBreak +
      'Where (Cp.CargaId = @CargaId) and (@PessoaId=0 or @PessoaId = Pes.PessoaId)';

    // Relat�rio Mapa de Cargas - Exibir volumes de cada pedido para CheckList em Carga
  Const
    SqlGetCargaPedidoVolumes = 'Declare @CargaId Integer  = :pCargaId' +
      sLineBreak + 'Declare @Processo Char(2) = :pProcesso' + sLineBreak +
      'select Cp.CargaId, Ped.PessoaId, Pv.* --PedidoVolumeId, Pv.Conferido' +
      sLineBreak + 'From Cargas C' + sLineBreak +
      'Inner Join CargaPedidos Cp On Cp.CargaId = C.CargaId' + sLineBreak +
      'Inner Join Pedido Ped On Ped.PedidoId = Cp.PedidoId' + sLineBreak +
      'Left Join (select pv.PedidoId, Pv.PedidoVolumeId, CC.UsuarioId, U.Nome Usuario,'
      + sLineBreak + '           Cc.Data, Cc.hora, Cc.Terminal,' + sLineBreak +
      '           (Case When CC.PedidoVolumeId is Null then 0 Else 1 End) Conferido,'
      + sLineBreak + '           Sum(Vl.QtdSuprida) QtdSuprida,' + sLineBreak +
      '           (Case When Pv.EmbalagemId is Null then ' + #39 + 'Cxa.Fechada'
      + #39 + ' Else ' + #39 + 'Fracionado' + #39 +
      ' End) Embalagem, CC.Processo' + sLineBreak +
      '            From PedidoVolumes Pv' + sLineBreak +
      '            Inner Join PedidoVolumeLotes Vl On Vl.PedidoVolumeid = Pv.PedidoVolumeId'
      + sLineBreak +
      '            Left Join vDocumentoEtapas De On De.Documento = Pv.uuid' +
      sLineBreak +
      '            Left join CargaCarregamento CC On CC.pedidovolumeid = Pv.PedidoVolumeId and Cc.Processo = @Processo'
      + sLineBreak +
      '            Left Join Usuarios U On U.Usuarioid = Cc.Usuarioid' +
      sLineBreak +
      '            where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + '            And De.ProcessoId <> 15' + sLineBreak +
      '            Group by pv.PedidoId, Pv.PedidoVolumeId, CC.UsuarioId, U.Nome,'
      + sLineBreak +
      '                     Cc.Data, Cc.hora, Cc.Terminal, Pv.EmbalagemId, CC.PedidoVolumeId, CC.Processo) Pv ON Pv.PedidoId = Cp.PedidoId'
      + sLineBreak + 'Where  Cp.CargaId = @CargaId ' + sLineBreak +
    // and Pv.Processo = @Processo
      'Order by Conferido, PedidoId, PedidoVolumeId';

  Const
    SqlCargaLista = 'Declare @CargaId Integer    = :pCargaId' + sLineBreak +
      'Declare @RotaId Integer     = :pRotaId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @Pendente Integer   = :pPendente' + sLineBreak +
      'select C.cargaid, C.DtInclusao Data, R.RotaId, R.Descricao Rota,' +
      sLineBreak +
      '       C.transportadoraid,T.Razao Transportadora, V.VeiculoId, V.Placa,'
      + sLineBreak +
      '	      V.VeiculoId, V.Placa, De.ProcessoId, De.Descricao Processo,' +
      sLineBreak +
      '	      (Case When De.ProcessoId = 16 and Exists (Select Processo From CargaCarregamento'
      + sLineBreak +
      '		                                               where cargaid = C.cargaid And processo = '
      + #39 + 'CO' + #39 + ') then 1' + sLineBreak +
      '             When (De.ProcessoId in (16, 18) and Exists (Select Processo From CargaCarregamento'
      + sLineBreak +
      '		                                                 where cargaid = C.cargaid And processo = '
      + #39 + 'CA' + #39 + ')) then 2' + sLineBreak +
      '			 Else 0 End) StatusOper' + sLineBreak + 'From cargas C' + sLineBreak
      + 'Inner Join vDocumentoEtapas De On De.Documento = C.uuid' + sLineBreak +
      'Inner Join Rotas R On R.RotaId = C.RotaId' + sLineBreak +
      'Inner Join Pessoa T On T.PessoaId = C.transportadoraid' + sLineBreak +
      'Inner Join Veiculos V On V.VeiculoId = C.veiculoid' + sLineBreak +
      'Inner Join Pessoa M On M.PessoaId = C.motoristaid' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = C.uuid and Status = 1)'
      + sLineBreak + '      And (@CargaId = 0 or @CargaId = C.cargaId)' +
      sLineBreak + '	     And (@RotaId = 0 or @RotaId = C.rotaid)' + sLineBreak
      + '	     And (@ProcessoId = 0 Or ( @ProcessoId = DE.ProcessoId or @Pendente=1))'
      + sLineBreak +
      '      And (@Pendente = 0 or (@Pendente=1 and processoId in (16, 18)))' +
      sLineBreak + 'order by c.cargaid';

  Const
    SqlGetMapaCarga = 'Declare @CargaId Integer = :pCargaId' + sLineBreak +
      'Select Pe.*, CargaPed.PedidoId, CargaPed.DocumentoNr, CargaPed.Documentooriginal, '
      + sLineBreak +
      '       vPed.DocumentoData, vPed.NotaFiscalERP, CargaPed.QtdVolume, CargaPed.Itens'
      + sLineBreak + 'From ( ' + sLineBreak +
      '		select Cp.CargaId, Pes.PessoaId, Pes.CodPessoaERP, ' + sLineBreak +
      '         Pes.Razao, Pes.Fantasia, Rp.ordem' + sLineBreak +
      '		From CargaPedidos Cp' + sLineBreak +
      '		Inner Join Pedido Ped On Ped.PedidoId = Cp.PedidoId' + sLineBreak +
      '		Inner join Pessoa Pes ON Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      '		Inner Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' + sLineBreak
      + '		Group by Cp.CargaId, Pes.PessoaId, Pes.CodPessoaERP, Pes.Razao, Pes.Fantasia, Rp.ordem) Pe'
      + sLineBreak +
      'Inner join (select Distinct Cp.CargaId, Pes.PessoaId, Ped.PedidoId, Ped.DocumentoNr, Ped.DocumentoOriginal, Vlm.QtdVolume, Vlm.Itens'
      + sLineBreak + '			From CargaPedidos Cp' + sLineBreak +
      '			Inner Join Pedido Ped On Ped.PedidoId = Cp.PedidoId' + sLineBreak
      + '			Inner Join (Select  Vlm.PedidoId, Count(Vlm.PedidoVolumeId) QtdVolume, Sum(Vl.Itens) Itens'
      + sLineBreak + '						From PedidoVolumes Vlm' + sLineBreak +
      '						Inner join (Select PedidoVolumeId, Sum(QtdSuprida) Itens From PedidoVolumeLotes Group by PedidoVolumeId) Vl On Vl.PedidoVolumeId = Vlm.PedidoVOlumeId'
      + sLineBreak +
      '						Left Join vDocumentoEtapas DE On De.Documento = Vlm.uuid' +
      sLineBreak +
      '						where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Vlm.uuid and Status = 1) And De.ProcessoId <> 15'
      + sLineBreak +
      '						Group By Vlm.PedidoId) as Vlm On Vlm.PedidoId = Ped.PedidoId '
      + sLineBreak +
      '			Inner join Pessoa Pes on Pes.PessoaId = Ped.PessoaId) CargaPed On CargaPed.CargaId = Pe.CargaId and CargaPed.PessoaId = Pe.PessoaId'
      + sLineBreak +
      'Inner Join vPedidos vPed On vPed.PedidoId = CargaPed.PedidoId' +
      sLineBreak + 'where Pe.CargaId = @CargaId' + sLineBreak +
      'Order by Pe.ordem, CargaPed.PedidoId';

  Const
    SqlGetResumoEntrada = 'Declare @Pedidoid Integer = :pPedidoId' + sLineBreak
      + 'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'select  PedidoId, CodProduto, DescrLote Lote, Fabricacao, Vencimento, ' +
      sLineBreak + '        (Case When FatorConversao=1 then ' + #39 + 'Unid' +
      #39 + ' Else ' + #39 +
      'Cxa c/ Cast(FatorConversao as Varchar) End) Embalagem' + sLineBreak +
      '        , QtdXml, QtdCheckIn, QtdDevolvida, QtdSegregada' + sLineBreak +
      'from vPedidoItens where (QtdCheckIn+QtdDevolvida+QtdSegregada) > 0' +
      sLineBreak +
      'where (@PedidoId = 0 or @PedidoId=Ped.PedidoId) and (@CodProduto = 0 or Prd.CodProduto = @CodProduto )';

  Const
    SqlGetResumoSaida = 'Declare @Pedidoid Integer = :pPedidoId' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'select Ped.PedidoId, Rd.Data As DtDocumento, Ped.DocumentoNr, Prd.IdProduto ProdutoId, Prd.Descricao,'
      + sLineBreak + '       (Case When Pvl.EmbalagemPadrao=1 then ' + #39 +
      'Unid' + #39 + ' Else ' + #39 +
      'Cxa c/ Cast(Pvl.EmbalagemPadrao as Varchar) End) Embalagem,' + sLineBreak
      + '	   Pl.DescrLote, DF.Data Fabricacao, Dv.Data Vencimento, Pvl.QtdSuprida'
      + sLineBreak + 'From PedidoVOlumeLotes Pvl' + sLineBreak +
      'Inner join PedidoVolumes Pv On Pv.PedidoVolumeId = Pvl.PedidoVolumeId' +
      sLineBreak + 'Inner join Pedido Ped ON Ped.PedidoId = Pv.PedidoId' +
      sLineBreak +
      'Inner join Pessoa Pes ON Pes.PessoaId = Ped.PessoaId and Pes.PessoaTipoID = 1'
      + sLineBreak + 'Inner join ProdutoLotes Pl ON Pl.LoteId = Pvl.LoteId' +
      sLineBreak + 'Inner join Produto Prd On Prd.IdProduto = Pl.Produtoid ' +
      sLineBreak + 'Inner join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData '
      + sLineBreak + 'Inner Join Rhema_Data DF On DF.IdData = Pl.Fabricacao' +
      sLineBreak + 'Inner Join Rhema_Data DV On Dv.IdData = Pl.Vencimento ' +
      sLineBreak +
      'where (@PedidoId = 0 or @PedidoId=Ped.PedidoId) and (@CodProduto = 0 or Prd.CodProduto = @CodProduto )';

  Const
    SqlGetPedidoCortes = 'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Select PedProd.PedidoId, Data, PedProd.ProdutoId, CodProduto, Descricao, PedProd.Quantidade Demanda, Embalagem,'
      + sLineBreak +
      '       (Case When Coalesce(Demanda, 0) > 0 then PedProd.Quantidade - Coalesce(Demanda, 0) Else (Case When PedProd.ProcessoId<>15 then PedProd.Quantidade Else 0 End) End) Cubagem,'
      + sLineBreak +
      '       Coalesce((Case When Demanda>0 and Coalesce(Demanda, 0) > (QtdSuprida+QtdCancelado) then Coalesce(Demanda, 0) - QtdSuprida - QtdCancelado else 0 End), 0) Checkout,'
      + sLineBreak +
      '	    (Case When Coalesce(Demanda, 0) = 0 and PedProd.ProcessoId = 15 then PedProd.Quantidade Else 0 End)+Coalesce(Corte.QtdCancelado, 0) Cancelado, Coalesce(QtdSuprida, 0) QtdSuprida'
      + sLineBreak +
      '     , Coalesce(Est.Estoque, 0) Estoque, Coalesce(Est.Vencido, 0) Vencido'
      + sLineBreak +
      'from (Select PP.PedidoId, Rd.Data, Pp.ProdutoId, Prd.CodProduto, Prd.Descricao, Pp.Quantidade,'
      + sLineBreak + '      (Case When EmbalagemPadrao = 1 then ' + #39 + 'Unid'
      + #39 + ' Else ' + #39 + 'Cxa c/' + #39 +
      '+Cast(EmbalagemPadrao as VarChar) End) Embalagem, De.ProcessoId' +
      sLineBreak + '      From pedidoprodutos Pp' + sLineBreak +
      '      inner join Pedido ped on ped.pedidoid = Pp.pedidoid' + sLineBreak +
      '      inner join Rhema_Data Rd on Rd.IdData = ped.DocumentoData' +
      sLineBreak +
      '      Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId' +
      sLineBreak +
      '      Inner Join vDocumentoEtapas De On De.Documento = ped.Uuid' +
      sLineBreak +
      '      where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak +
      '            and (@DataIni = 0 or Rd.Data >= @DataIni) and (@DataFin = 0 or Rd.Data <= @DataFin)'
      + sLineBreak +
      '            and (@Pedidoid = 0 or ped.PedidoId = @Pedidoid) and (@CodProduto =0 or Prd.CodProduto = @CodProduto)'
      + sLineBreak +
      '            and De.ProcessoId > 1 and De.ProcessoId <> 31) PedProd' +
      sLineBreak + '' + sLineBreak +
      'Left Join (select VLote.PedidoId, VLote.ProdutoId, SUM(VLote.Demanda) Demanda, SUM(VLote.QtdSuprida) QtdSuprida, SUM(VLote.QtdCancelado) QtdCancelado'
      + sLineBreak +
      '           From (Select Pv.PedidoId, Pl.ProdutoId, Coalesce(Sum(Vl.Quantidade), 0) Demanda,'
      + sLineBreak +
      '                  Sum((Case When De.ProcessoId<>15 then Vl.QtdSuprida Else 0 End)) QtdSuprida, (Case When De.ProcessoId=15 then Sum(Vl.Quantidade) Else 0 End) QtdCancelado'
      + sLineBreak + '           From PedidoVolumeLotes Vl' + sLineBreak +
      '           Inner Join PedidoVolumes  Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '		   Inner Join ProdutoLotes   Pl on Pl.LoteId         = Vl.LoteId' +
      sLineBreak +
      '		   Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid' +
      sLineBreak +
      '		   Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '           Group by Pv.PedidoId, Pl.ProdutoId, De.ProcessoId) VLote' +
      sLineBreak + '           Group by VLote.PedidoId, VLote.ProdutoId' +
      sLineBreak +
      '		   ) Corte On Corte.PedidoId = PedProd.PedidoId and Corte.ProdutoId = PedProd.ProdutoId'
      + sLineBreak +
      'Left Join (Select CodigoERP, Sum(Qtde) Estoque, Sum(Iif(vencimento<@DataIni, qtde, 0)) Vencido'
      + sLineBreak +
      '           From vEstoqueProducao Group By CodigoERP) Est On Est.CodigoERP = CodProduto'
      + sLineBreak + 'Where PedProd.Quantidade > Coalesce(QtdSuprida, 0)' +
      sLineBreak + 'Order by PedProd.CodProduto';

    { 'Select Pp.PedidoId, Rd.Data, Prd.IdProduto ProdutoId, Prd.CodProduto, Prd.Descricao,'+sLineBreak+
      '       pp.Quantidade Demanda, (Case When EmbalagemPadrao = 1 then '+#39+'Unid'+#39+' Else '+#39+'Cxa c/'+#39+'+Cast(EmbalagemPadrao as VarChar) End) Embalagem'+sLineBreak+
      '	   , (Case When CCub.ProdutoId is Null and De.ProcessoId <> 15 then PP.Quantidade Else 0 End) Cubagem'+sLineBreak+
      '	   , Coalesce(Chc.QtdCorte, 0) CheckOut'+sLineBreak+
      '	   , Coalesce(Canc.Cancelado, 0)+(Case When CCub.ProdutoId is Null and De.ProcessoId = 15 then PP.Quantidade Else 0 End) Cancelado'+sLineBreak+
      '	   , Coalesce(Chc.QtdSuprida, 0) QtdSuprida'+sLineBreak+
      'from pedidoprodutos Pp'+sLineBreak+
      'inner join Pedido ped on ped.pedidoid = Pp.pedidoid'+sLineBreak+
      'inner join Rhema_Data Rd on Rd.IdData = ped.DocumentoData'+sLineBreak+
      'Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId'+sLineBreak+
      'Left Join (Select Pv.PedidoId, Pl.ProdutoId From PedidoVolumeLotes Vl'+sLineBreak+
      '           Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak+
      '		   Inner Join ProdutoLotes Pl on Pl.LoteId = Vl.LoteId) CCub On Ccub.PedidoId = Pp.PedidoId and CCub.Produtoid = Pp.Produtoid'+sLineBreak+
      'Left Join (Select Pv.PedidoId, Pl.ProdutoId, Sum(Quantidade) Cancelado'+sLineBreak+
      '           From PedidoVolumeLotes Vl'+sLineBreak+
      '           Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak+
      '		   Inner Join ProdutoLotes Pl on Pl.LoteId = Vl.LoteId'+sLineBreak+
      '		   Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid'+sLineBreak+
      '		   Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'+sLineBreak+
      '		         And De.ProcessoId = 15'+sLineBreak+
      '		   Group by Pv.PedidoId, Pl.ProdutoId) Canc On Canc.PedidoId = Pp.PedidoId and Canc.Produtoid = Pp.Produtoid'+sLineBreak+
      'Left Join (Select Pv.PedidoId, Pl.ProdutoId,'+sLineBreak+
      '           Sum(Quantidade-QtdSuprida) QtdCorte, Sum(QtdSuprida) QtdSuprida'+sLineBreak+
      '           From PedidoVolumeLotes Vl'+sLineBreak+
      '           Inner Join PedidoVolumes Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak+
      '		   Inner Join ProdutoLotes Pl on Pl.LoteId = Vl.LoteId'+sLineBreak+
      '		   Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid'+sLineBreak+
      '		   Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'+sLineBreak+
      '		         And De.ProcessoId <> 15'+sLineBreak+
      '		   Group by Pv.PedidoId, Pl.ProdutoId) Chc On Chc.PedidoId = Pp.PedidoId and Chc.Produtoid = Pp.Produtoid'+sLineBreak+
      'Inner Join vDocumentoEtapas De on De.Documento = Ped.Uuid'+sLineBreak+
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'+sLineBreak+
      '      and (@DataIni = 0 or Rd.Data >= @DataIni) and (@DataFin = 0 or Rd.Data <= @DataFin)'+sLineBreak+
      '      and (@Pedidoid = 0 or ped.PedidoId = @Pedidoid)'+sLineBreak+
      '      and De.ProcessoId > 1'+sLineBreak+
      '	     and (@CodProduto =0 or Prd.CodProduto = @CodProduto)'+sLineBreak+
      '      and Coalesce(Chc.QtdCorte, 0)+Coalesce(Canc.Cancelado, 0)+(Case When CCub.ProdutoId is Null then PP.Quantidade Else 0 End) <> 0'+sLineBreak+
      'Order by Prd.IdProduto';
    }

Const SqlGetPedidoCortesSintetico = 'Declare @DataIni DateTime = :pDataIni' + sLineBreak+
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Select PedProd.ProdutoId, CodProduto, Descricao, Embalagem, Sum(PedProd.Quantidade) Demanda,'+sLineBreak+
      '       Sum((Case When Coalesce(Demanda, 0) > 0 then PedProd.Quantidade - Coalesce(Demanda, 0) Else '+sLineBreak+
      '           (Case When PedProd.ProcessoId<>15 then PedProd.Quantidade Else 0 End) End)) Cubagem,' + sLineBreak +
      '       Sum(Coalesce((Case When Demanda>0 and Coalesce(Demanda, 0) > (QtdSuprida+QtdCancelado) then Coalesce(Demanda, 0) - QtdSuprida - QtdCancelado else 0 End), 0)) Checkout,' + sLineBreak +
      '	      Sum((Case When Coalesce(Demanda, 0) = 0 and PedProd.ProcessoId = 15 then PedProd.Quantidade Else 0 End)+Coalesce(Corte.QtdCancelado, 0)) Cancelado,' + sLineBreak +
      '	      Sum(Coalesce(QtdSuprida, 0)) QtdSuprida,' + sLineBreak +
      '       Sum(Coalesce(Est.Estoque, 0)) Estoque,' + sLineBreak +
      '	      Sum(Coalesce(Est.Vencido, 0)) Vencido' + sLineBreak +
      'from (Select PP.PedidoId, Rd.Data, Pp.ProdutoId, Prd.CodProduto, Prd.Descricao, Pp.Quantidade,' + sLineBreak +
      '      (Case When EmbalagemPadrao = 1 then '+#39+'Unid'+#39+' Else '+#39+'Cxa c/'+#39+'+Cast(EmbalagemPadrao as VarChar) End) Embalagem, De.ProcessoId' + sLineBreak +
      '      From pedidoprodutos Pp' + sLineBreak +
      '      inner join Pedido ped on ped.pedidoid = Pp.pedidoid' + sLineBreak +
      '      inner join Rhema_Data Rd on Rd.IdData = ped.DocumentoData' + sLineBreak +
      '      Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId' + sLineBreak +
      '      Inner Join vDocumentoEtapas De On De.Documento = ped.Uuid' + sLineBreak +
      '      where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)' + sLineBreak +
      '            and (@DataIni = 0 or Rd.Data >= @DataIni) and (@DataFin = 0 or Rd.Data <= @DataFin)' + sLineBreak +
      '            and (@Pedidoid = 0 or ped.PedidoId = @Pedidoid) and (@CodProduto =0 or Prd.CodProduto = @CodProduto)' + sLineBreak +
      '            and De.ProcessoId > 1 and De.ProcessoId <> 31) PedProd' + sLineBreak +
      '            ' + sLineBreak +
      'Left Join (select VLote.PedidoId, VLote.ProdutoId, SUM(VLote.Demanda) Demanda, SUM(VLote.QtdSuprida) QtdSuprida, SUM(VLote.QtdCancelado) QtdCancelado' + sLineBreak +
      '           From (Select Pv.PedidoId, Pl.ProdutoId, Coalesce(Sum(Vl.Quantidade), 0) Demanda,' + sLineBreak +
      '                  Sum((Case When De.ProcessoId<>15 then Vl.QtdSuprida Else 0 End)) QtdSuprida, (Case When De.ProcessoId=15 then Sum(Vl.Quantidade) Else 0 End) QtdCancelado' + sLineBreak +
      '           From PedidoVolumeLotes Vl' + sLineBreak +
      '           Inner Join PedidoVolumes  Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId' + sLineBreak +
      '		   Inner Join ProdutoLotes   Pl on Pl.LoteId         = Vl.LoteId' + sLineBreak +
      '		   Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid' + sLineBreak +
      '		   Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)' + sLineBreak +
      '           Group by Pv.PedidoId, Pl.ProdutoId, De.ProcessoId) VLote' + sLineBreak +
      '           Group by VLote.PedidoId, VLote.ProdutoId' + sLineBreak +
      '		   ) Corte On Corte.PedidoId = PedProd.PedidoId and Corte.ProdutoId = PedProd.ProdutoId' + sLineBreak +
      'Left Join (Select CodigoERP, Sum(Qtde) Estoque, Sum(Iif(vencimento<@DataIni, qtde, 0)) Vencido' + sLineBreak +
      '           From vEstoqueProducao Group By CodigoERP) Est On Est.CodigoERP = CodProduto' + sLineBreak +
      'Where PedProd.Quantidade > Coalesce(QtdSuprida, 0)' + sLineBreak +
      'Group By PedProd.ProdutoId, CodProduto, Descricao, Embalagem' + sLineBreak +
      'Order by Descricao';

  Const SqlGetPedidoCortesSinteticoOLD = 'Declare @DataIni DateTime = :pDataIni' +
  sLineBreak + 'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Select ProdutoId, CodProduto, Descricao, Embalagem, Demanda, Cubagem, CheckOut, Cancelado, QtdSuprida' + sLineBreak +
      '     , Coalesce(Est.Estoque, 0) Estoque, Coalesce(Est.Vencido, 0) Vencido' + sLineBreak +
      'From (Select PedProd.ProdutoId, CodProduto, Descricao, Embalagem,' + sLineBreak +
      '      Sum(Coalesce(PedProd.Quantidade, 0)) Demanda,' + sLineBreak +
      '	     Sum(PedProd.Quantidade) - sum(Coalesce(Demanda, 0)) Cubagem,' + sLineBreak +
      '      sum(Coalesce(Demanda, 0)) - sum(Coalesce(QtdSuprida, 0)) Checkout,' + sLineBreak +
      '	     sum(Coalesce(QtdCancelado, 0)) Cancelado,' + sLineBreak +
      '	     sum(Coalesce(QtdSuprida, 0)) QtdSuprida' + sLineBreak +
      'from (Select Ped.PedidoId, Pp.ProdutoId, Prd.CodProduto, Prd.Descricao,' + sLineBreak +
      '             (Case When EmbalagemPadrao = 1 then '+#39+'Unid'+#39+' Else '+#39+'Cxa c/' + #39+
                    '+Cast(EmbalagemPadrao as VarChar) End) Embalagem,' + sLineBreak +
      '	            Sum(Pp.Quantidade) Quantidade' + sLineBreak +
      '      From pedidoprodutos Pp' + sLineBreak +
      '      inner join vPedidos ped on ped.pedidoid = Pp.pedidoid' + sLineBreak+
       '      Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId' + sLineBreak +
      '      where (@DataIni = 0 or Ped.DocumentoData >= @DataIni) and (@DataFin = 0 or DocumentoData <= @DataFin)'  + sLineBreak +
      '        and (@Pedidoid = 0 or ped.PedidoId = @Pedidoid)' + sLineBreak +
      '		      and (@CodProduto =0 or Prd.CodProduto = @CodProduto)' + sLineBreak +
      '        and ped.processoid > 1 and ped.ProcessoId <> 31'+sLineBreak+
      '	     Group by Ped.PedidoId, Pp.ProdutoId, Prd.CodProduto, Prd.Descricao, EmbalagemPadrao) PedProd' + sLineBreak +
      'Left Join (Select Pv.PedidoId, Pl.ProdutoId,' + sLineBreak+
      '		        Coalesce(Sum(Vl.Quantidade), 0) Demanda,' + sLineBreak +
      '           Sum((Case When De.ProcessoId<>15 then Vl.QtdSuprida Else 0 End)) QtdSuprida,' + sLineBreak +
      '				    (Case When De.ProcessoId=15 then Sum(Vl.Quantidade) Else 0 End) QtdCancelado' + sLineBreak +
      '           From PedidoVolumeLotes Vl' + sLineBreak +
      '           Inner Join PedidoVolumes  Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId' + sLineBreak +
      '		        Inner Join ProdutoLotes   Pl on Pl.LoteId         = Vl.LoteId'+ sLineBreak +
      '		        Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid' + sLineBreak +
      '		        Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)' + sLineBreak +
      '           Group by Pv.PedidoId, Pl.ProdutoId, De.ProcessoId) Corte On Corte.PedidoId = PedProd.PedidoId and Corte.ProdutoId = PedProd.ProdutoId' + sLineBreak +
      'Group by PedProd.ProdutoId, CodProduto, Descricao, Embalagem) Cortes' + sLineBreak +
      'Left Join (Select CodigoERP, Sum(Qtde) Estoque, Sum(Iif(vencimento<@DataIni, qtde, 0)) Vencido' + sLineBreak +
      '           From vEstoqueProducao Group By CodigoERP) Est On Est.CodigoERP = Cortes.CodProduto' + sLineBreak +
      'Where Cubagem+CheckOut+Cancelado > 0' + sLineBreak +
      'Order by Cortes.CodProduto';

    { 'Select ProdutoId, CodProduto, Descricao, Embalagem, Sum(Demanda) Demanda, '+sLineBreak+
      '       Sum(Cubagem) Cubagem, Sum(CheckOut) CheckOut, Sum(Cancelado) Cancelado, Sum(QtdSuprida) QtdSuprida'+sLineBreak+
      '     , Coalesce(Sum(Est.Estoque), 0) Estoque, Coalesce(sum(Est.Vencido), 0) Vencido'+sLineBreak+
      'From (Select PedProd.PedidoId, Data, PedProd.ProdutoId, CodProduto, Descricao, PedProd.Quantidade Demanda, Embalagem,'+sLineBreak+
      '       (Case When Coalesce(Demanda, 0) > 0 then PedProd.Quantidade - Coalesce(Demanda, 0) Else 0 End) Cubagem,'+sLineBreak+
      '       Coalesce((Case When Demanda>0 and Coalesce(Demanda, 0) > (QtdSuprida+QtdCancelado) then Coalesce(Demanda, 0) - QtdSuprida - QtdCancelado else 0 End), 0) Checkout,'+sLineBreak+
      '	   (Case When Coalesce(Demanda, 0) = 0 then PedProd.Quantidade Else 0 End)+Coalesce(Corte.QtdCancelado, 0) Cancelado, Coalesce(QtdSuprida, 0) QtdSuprida'+sLineBreak+
      'from (Select PP.PedidoId, Rd.Data, Pp.ProdutoId, Prd.CodProduto, Prd.Descricao, Pp.Quantidade,'+sLineBreak+
      '      (Case When EmbalagemPadrao = 1 then '+#39+'Unid'+#39+' Else '+#39+'Cxa c/'+#39+'+Cast(EmbalagemPadrao as VarChar) End) Embalagem'+sLineBreak+
      '      From pedidoprodutos Pp'+sLineBreak+
      '      inner join Pedido ped on ped.pedidoid = Pp.pedidoid'+sLineBreak+
      '      inner join Rhema_Data Rd on Rd.IdData = ped.DocumentoData'+sLineBreak+
      '      Inner Join Produto Prd On Prd.IdProduto = Pp.ProdutoId'+sLineBreak+
      '      Inner Join vDocumentoEtapas De On De.Documento = ped.Uuid'+sLineBreak+
      '      where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'+sLineBreak+
      '        And (@DataIni = 0 or Rd.Data >= @DataIni) and (@DataFin = 0 or Rd.Data <= @DataFin)'+sLineBreak+
      '        And (@Pedidoid = 0 or ped.PedidoId = @Pedidoid) and (@CodProduto =0 or Prd.CodProduto = @CodProduto)'+sLineBreak+
      '        And (De.ProcessoId <> 31) ) PedProd'+sLineBreak+
      ''+sLineBreak+
      'Left Join (select VLote.PedidoId, VLote.ProdutoId, SUM(VLote.Demanda) Demanda, SUM(VLote.QtdSuprida) QtdSuprida, SUM(VLote.QtdCancelado) QtdCancelado'+sLineBreak+
      '           From (Select Pv.PedidoId, Pl.ProdutoId, Coalesce(Sum(Vl.Quantidade), 0) Demanda,'+sLineBreak+
      '                  Sum((Case When De.ProcessoId<>15 then Vl.QtdSuprida Else 0 End)) QtdSuprida, (Case When De.ProcessoId=15 then Sum(Vl.Quantidade) Else 0 End) QtdCancelado'+sLineBreak+
      '           From PedidoVolumeLotes Vl'+sLineBreak+
      '           Inner Join PedidoVolumes  Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'+sLineBreak+
      '		   Inner Join ProdutoLotes   Pl on Pl.LoteId         = Vl.LoteId'+sLineBreak+
      '		   Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid'+sLineBreak+
      '		   Where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'+sLineBreak+
      '           Group by Pv.PedidoId, Pl.ProdutoId, De.ProcessoId) VLote'+sLineBreak+
      '           Group by VLote.PedidoId, VLote.ProdutoId'+sLineBreak+
      '		   ) Corte On Corte.PedidoId = PedProd.PedidoId and Corte.ProdutoId = PedProd.ProdutoId'+sLineBreak+
      'Where PedProd.Quantidade > Coalesce(QtdSuprida, 0)) CAnalitico'+sLineBreak+
      'Left Join (Select CodigoERP, Sum(Qtde) Estoque, Sum(Iif(vencimento<@DataIni, qtde, 0)) Vencido'+sLineBreak+
      '           From vEstoqueProducao Group By CodigoERP) Est On Est.CodigoERP = CodProduto'+sLineBreak+
      ''+sLineBreak+
      'Group by ProdutoId, CodProduto, Descricao, Embalagem'+sLineBreak+
      'Order by ProdutoId';
    }
  Const
    SqlGetPedidoProdutoSemPicking =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @PedidoId Integer     = :pPedidoId' + sLineBreak +
      'Declare @PessoaId Integer = Coalesce((Select PessoaId From Pessoa where CodPessoaERP = :pCodPessoaERP and PessoaTipoId = 2), 0)'
      + sLineBreak + 'Declare @DocumentoNr Varchar(20) = :pDocumentoNr' +
      sLineBreak +
      'select CodProduto, Prd.CodProduto, Prd.Descricao, Prd.UnidadeSecundariaSigla,'
      + sLineBreak +
      '       Prd.UnidadeSecundariaId UnidCxa, Prd.FatorConversao QtdCxa,' +
      sLineBreak +
      '	      Prd.Altura, Prd.Largura, Prd.Comprimento, Prd.Volume,' +
      sLineBreak + '	      Prd.PesoLiquido, Null As Picking' + sLineBreak +
      'From (select Pl.ProdutoId' + sLineBreak + '      From Pedido Ped' +
      sLineBreak +
      '      Inner Join PedidoItens Pi ON PI.PedidoId = Ped.PedidoId' +
      sLineBreak +
      '      inner join Rhema_data rd On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      '      Inner join vDocumentoEtapas De on De.Documento = Ped.Uuid' +
      sLineBreak + '      Inner Join ProdutoLotes Pl On Pl.LoteId = Pi.LoteId' +
      sLineBreak + '	     where Ped.OperacaoTipoId = 3' + sLineBreak +
      '            And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '	           and De.ProcessoId = 1' + sLineBreak +
      '            And (@DataInicial = 0 or rd.Data >= @DataInicial)' +
      sLineBreak + '            And (@DataFinal = 0 or rd.Data <= @DataFinal)' +
      sLineBreak + '            And (@PedidoId = 0 or Ped.PedidoId = @PedidoId)'
      + sLineBreak +
      '	           And (@PessoaId = 0 or Ped.PessoaId = @PessoaId)' + sLineBreak
      + '            And (@DocumentoNr = ' + #39 + #39 +
      ' or Ped.DocumentoNr = @DocumentoNr)' + sLineBreak +
      '	     Group by Pl.ProdutoId) as Ped' + sLineBreak +
      'Inner Join vProduto Prd On Prd.IdProduto = Ped.ProdutoId' + sLineBreak +
      'Where Prd.EnderecoId Is Null' + sLineBreak + 'Order by Prd.Descricao';

  Const
    SqlGetProducaoPendente = ';With' + sLineBreak +
      'Ped as (Select Ped.PedidoId, Ped.PessoaId, Rp.RotaId, De.ProcessoId, Pe.Descricao Processo'
      + sLineBreak + 'From Pedido Ped' + sLineBreak +
      'Inner join RotaPessoas Rp ON Rp.PessoaId = Ped.PessoaId' + sLineBreak +
      'Inner Join vDocumentoEtapas De ON De.Documento = Ped.uuid' + sLineBreak +
      'Inner Join ProcessoEtapas Pe On Pe.ProcessoId = De.Processoid' +
      sLineBreak +
      'Where Ped.OperacaoTipoId=2 and DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '     and (De.ProcessoId < 13 or de.ProcessoId = 22) )' +
      sLineBreak + '' + sLineBreak +
      ',PeRo as (Select Ped.RotaId, Count(*) As TotPed' + sLineBreak +
      '         From Ped' + sLineBreak + '		 Group by Ped.RotaId)' +
      sLineBreak + '' + sLineBreak +
      ',PedProc as (Select Ped.ProcessoId, Ped.Processo, Count(*) As TotPed' +
      sLineBreak + '         From Ped' + sLineBreak +
      '		 Group by Ped.ProcessoId, Ped.Processo)' + sLineBreak + '' +
      sLineBreak + 'Select ProcessoId, Processo, TotPed from PedProc' +
      sLineBreak + 'Order by ProcessoId';

  Const
    SqlGetResumoOperacao = 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal DateTime = :pDataFinal' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @UsuarioId Integer  = :pUsuarioId' + sLineBreak +
      'Declare @DocumentoDataIni DateTime = :pDtPedidoIni' + sLineBreak +
      'Declare @DocumentoDataFin DateTime = :pDtPedidoFin' + sLineBreak +
      'select De.Data, De.ProcessoId, Pe.Descricao Processo, De.UsuarioId, Usu.Nome Usuario, Sum(QtdSuprida) QtdSuprida'
      + sLineBreak + 'from PedidoVolumeLotes Vl' + sLineBreak +
      'Inner join PedidoVolumes Pv on Pv.PedidoVolumeId = Vl.PedidoVolumeId' +
      sLineBreak + 'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak + 'Inner Join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData' +
      sLineBreak + 'Inner Join vDocumentoEtapas De ON De.Documento = Pv.uuid' +
      sLineBreak +
      'Inner Join ProcessoEtapas Pe On Pe.ProcessoId = De.ProcessoId' +
      sLineBreak + 'Left Join Usuarios Usu On Usu.UsuarioId = De.Usuarioid' +
      sLineBreak + 'Where (@ProcessoId =0 or De.ProcessoId = @ProcessoId)' +
      sLineBreak + '      and (@DataInicial = 0 or De.Data >= @DataInicial)' +
      sLineBreak + '      and (@DataFinal = 0   or De.Data <= @DataFinal)' +
      sLineBreak + '      and (@UsuarioId = 0   or De.UsuarioId = @UsuarioId)' +
      sLineBreak +
      '	     and (@DocumentoDataIni = 0 or Rd.Data >= @DocumentoDataIni)' +
      sLineBreak +
      '      and (@DocumentoDataFin = 0 or Rd.Data <= @DocumentoDataFin)' +
      sLineBreak +
    // '      and (De.ProcessoId >= 5 and De.ProcessoId <> 15)'+sLineBreak+
      'Group By De.Data, De.ProcessoId, Pe.Descricao, De.UsuarioId, Usu.Nome' +
      sLineBreak + 'order by De.Data, De.ProcessoId, Usu.Nome';

  Const
    SqlGetMovimentacaoRecebimento = 'Declare @PedidoId Integer     = :pPedidoId'
      + sLineBreak + 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @ProdutoId Integer    = :pProdutoId' + sLineBreak +
      'select * From vPedidoItemProdutos' + sLineBreak +
      'where (@PedidoId = 0 or PedidoId = @PedidoId) and' + sLineBreak +
      '      (@ProdutoId = 0 or IdProduto = @ProdutoId)' + sLineBreak +
      '	     and (@DataInicial = 0 or Data >= @DataInicial)' + sLineBreak +
      '      and (@DataFinal = 0   or Data <= @DataFinal)' + sLineBreak +
      '      and (ProcessoId >= 5 and ProcessoId <> 15)' + sLineBreak +
    // 'Group by Data, Pedidoid, DocumentoNr, IdProduto, CodigoERP, Descricao, '+sLineBreak+
    // '         ProcessoId, Processo, CodPessoaERP, Razao'+sLineBreak+
      'Order By Data, PedidoId';

  Const
    SqlGetMovimentacaoRessuprimento = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
                                      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak+
                                      'Declare @DataFinal DateTime = :pDataFinal' + sLineBreak +
                                      'Declare @ProdutoId Integer =  :pProdutoId' + sLineBreak +
                                      'select Ped.DocumentoData Data, Ped.Pedidoid, Ped.DocumentoNr, Prd.IdProduto, Prd.CodProduto, Prd.Descricao, Ped.ProcessoId, Ped.Processo,' + sLineBreak +
                                      '       Ped.CodPessoaERP CodigoERP, Ped.Razao, Sum(Vl.QtdSuprida) QtdSuprida' + sLineBreak +
                                      'From PedidoVolumeLotes VL' + sLineBreak +
                                      'Inner Join PedidoVolumes Pv on Pv.PedidoVolumeId = Vl.PedidoVolumeId' + sLineBreak +
                                      'Inner Join vPedidos Ped On Ped.PedidoId = Pv.PedidoId' + sLineBreak +
                                      'Inner Join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId' + sLineBreak +
                                      'Inner Join Produto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
                                      'Inner Join vDocumentoEtapas AS DePV ON DePV.Documento = Pv.uuid' + sLineBreak +
                                      'WHERE (DePV.Horario = (SELECT MAX(Horario)' + sLineBreak +
                                      '                          FROM dbo.vDocumentoEtapas' + sLineBreak +
                                      '                          WHERE (Documento = Pv.uuid) AND (Status = 1))) and DePV.ProcessoId = 13' + sLineBreak +
                                      '     And (@PedidoId = 0 or Ped.PedidoId = @PedidoId)' + sLineBreak +
                                      '     And (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId)' + sLineBreak +
                                      '     and (@DataInicial = 0 or Ped.DocumentoData >= @DataInicial)' + sLineBreak +
                                      '     and (@DataFinal = 0   or Ped.DocumentoData <= @DataFinal)' + sLineBreak +
                                      '     and (Ped.ProcessoId > 12 and Ped.ProcessoId <> 15 and Ped.ProcessoId <> 31)' + sLineBreak +
                                      '     and (Vl.QtdSuprida > 0)' + sLineBreak +
                                      'Group by Ped.DocumentoData, Ped.Pedidoid, Ped.DocumentoNr, Prd.IdProduto, Prd.CodProduto, ' + sLineBreak +
                                      'Prd.Descricao, Ped.ProcessoId, Ped.Processo, Ped.CodPessoaERP, Ped.Razao' + sLineBreak +
                                      'Order By Ped.DocumentoData, Ped.PedidoId';

(*      'select Rd.Data, Ped.Pedidoid, Ped.DocumentoNr, Prd.IdProduto, Prd.CodProduto, Prd.Descricao, De.ProcessoId, De.Descricao Processo,'
      + sLineBreak +
      '       Pe.CodPessoaERP CodigoERP, Pe.Razao, Sum(Vl.QtdSuprida) QtdSuprida'
      + sLineBreak + 'From PedidoVolumeLotes VL' + sLineBreak +
      'Inner Join PedidoVolumes Pv on Pv.PedidoVolumeId = Vl.PedidoVolumeId' +
      sLineBreak + 'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak + 'Inner Join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak + 'Inner Join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak + 'Inner Join Pessoa Pe On Pe.PessoaId = Ped.PessoaId' +
      sLineBreak + 'Inner Join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      'Inner Join vDocumentoEtapas AS DE ON DE.Documento = Ped.uuid' +
      sLineBreak +
      'Inner Join vDocumentoEtapas AS DePV ON DePV.Documento = Pv.uuid' +
      sLineBreak + 'WHERE        (DE.Horario =    ' + sLineBreak +
      '                             (SELECT        MAX(Horario)' + sLineBreak +
      '                               FROM            dbo.vDocumentoEtapas' +
      sLineBreak +
      '                               WHERE        (Documento = Ped.uuid) AND (Status = 1))) and De.ProcessoId >= 13 and De.ProcessoId<>15'
      + sLineBreak + '     And (DePV.Horario = (SELECT MAX(Horario)' +
      sLineBreak + '                          FROM dbo.vDocumentoEtapas' +
      sLineBreak +
      '                          WHERE (Documento = Pv.uuid) AND (Status = 1))) and DePV.ProcessoId = 13'
      + sLineBreak + '     And (@PedidoId = 0 or Ped.PedidoId = @PedidoId)' +
      sLineBreak + '     And (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId)' +
      sLineBreak + '     and (@DataInicial = 0 or Rd.Data >= @DataInicial)' +
      sLineBreak + '     and (@DataFinal = 0   or Rd.Data <= @DataFinal)' +
      sLineBreak + '     and (De.ProcessoId > 12 and De.ProcessoId <> 15)' +
      sLineBreak + '     and (Vl.QtdSuprida > 0)' + sLineBreak +
      'Group by Rd.Data, Ped.Pedidoid, Ped.DocumentoNr, Prd.IdProduto, Prd.CodProduto, Prd.Descricao, De.ProcessoId, De.Descricao, Pe.CodPessoaERP, Pe.Razao'
      + sLineBreak + 'Order By Rd.Data, Ped.PedidoId';
*)

  Const
    SqlGetProdutoList = 'Declare @Produtoid Integer = :pProdutoId' + sLineBreak
      + 'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'Declare @EnderecoId Integer = :pEnderecoId' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @Ean VarChar = :pEan' + sLineBreak +
      'select distinct Prd.IdProduto ProdutoID, Prd.CodProduto CodigoERP, Prd.Descricao, Prd.EnderecoId, Prd.EnderecoDescricao Endereco, Prd.Zonaid, Prd.ZonaDescricao Zona, Prd.Mascara, Prd.SNGPC'
      + sLineBreak + 'From vproduto prd' + sLineBreak +
      'Left Join ProdutoCodBarras Pc On Pc.ProdutoId = Prd.IdProduto' +
      sLineBreak + 'Where (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId) and' +
      sLineBreak + '      (@CodigoERP = 0  or PRd.CodProduto = @CodigoERP) and'
      + sLineBreak +
      '	     (@EnderecoId = 0 or Prd.EnderecoId = @EnderecoId) and' + sLineBreak
      + '	     (@ZonaId = 0 or Prd.ZonaID = @ZonaId)';

    // DashBoard
  Const
    SqlGetEvolucaoAtendimentoUnid = 'declare @DtInicio DateTime = :pDtInicio' +
      sLineBreak + 'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak + '' + sLineBreak +
      'Select Data, COALESCE ([7], 0) AS ' + #39 + 'Demanda' + #39 + ', ' +
      sLineBreak + '       COALESCE ([1], 0) AS ' + #39 + 'Recebido' + #39 +
      ', COALESCE ([2], 0) AS ' + #39 + 'Cubagem' + #39 + ', ' +
      '       COALESCE ([8], 0) AS ' + #39 + 'Etq.Impressa' + #39 +
      ', COALESCE ([3], 0) AS ' + #39 + 'Apanhe' + #39 + ', ' + sLineBreak +
      '       COALESCE ([4], 0) AS ' + #39 + 'CheckOut' + #39 +
      ', COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 + ', ' + sLineBreak +
      '       COALESCE ([6], 0) AS ' + #39 + 'Cancelado' + #39 +
      ', Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) /' + sLineBreak +
      '       Cast(Coalesce([7], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) Eficiencia'
      + sLineBreak + 'FROM   (SELECT Data, ProcessoId, Total' + sLineBreak +
      '        FROM (select Ped.Data,' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '            When Ped.Processoid in (333) then 8' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10, 11, 12) then 4' + sLineBreak
      + '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      When Ped.ProcessoId = 150 then 6' + sLineBreak +
    // Cancelados sem volumes
      '			      When Ped.ProcessoId = 99 then 7' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak +
      'From (Select Rd.Data, 99 ProcessoId, Sum(PP.Quantidade) as Total' +
      sLineBreak + '      From Pedido Ped' + sLineBreak +
      '      Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      '      Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' +
      sLineBreak + '      Inner join (Select PedidoId, Quantidade' + sLineBreak
      + '	                 From PedidoProdutos PP' + sLineBreak +
      '				              Inner join vProduto Prd On Prd.IdProduto = PP.ProdutoId'
      + sLineBreak +
      '				              Where @ZonaId = 0 or Prd.ZonaId=@Zonaid) PP on PP.PedidoId = Ped.PedidoId'
      + sLineBreak +
      '      Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' +
      sLineBreak +
      '      Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' +
      sLineBreak +
      '      where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '        And (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak + '        And ProcessoId <> 31' + sLineBreak +
      '      Group By Rd.Data' + sLineBreak + '--Nao Cubado/Recebido' +
      sLineBreak + 'Union' + sLineBreak +
      'Select Rd.Data, 1 as ProcessoId, Sum(PP.Quantidade) QtdSuprida' +
      sLineBreak + 'From Pedido Ped' + sLineBreak +
      'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' + sLineBreak +
      'Inner Join (Select PedidoId, Quantidade' + sLineBreak +
      '	           From PedidoProdutos PP' + sLineBreak +
      '			         Inner join vProduto Prd On Prd.IdProduto = PP.ProdutoId' +
      sLineBreak +
      '			         Where @ZonaId = 0 or Prd.ZonaId=@Zonaid) PP On Pp.PedidoId = Ped.PedidoId'
      + sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid'
      + sLineBreak + 'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData'
      + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas' +
      sLineBreak +
      '                    where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak + '	    And DE.ProcessoId = 1' + sLineBreak +
      'Group By Rd.Data,  De.ProcessoId' + sLineBreak +
      '--Pedidos Cancelados sem Volumes' + sLineBreak + 'Union' + sLineBreak +
      'Select Rd.Data, 150 as ProcessoId, Sum(PP.Quantidade) QtdCancelado' +
      sLineBreak + 'From Pedido Ped' + sLineBreak +
      'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' + sLineBreak +
      'Inner Join (Select PedidoId, Quantidade' + sLineBreak +
      '	        From PedidoProdutos PP' + sLineBreak +
      '			Inner join vProduto Prd On Prd.IdProduto = PP.ProdutoId' +
      sLineBreak +
      '			Where @ZonaId = 0 or Prd.ZonaId=@Zonaid) PP On Pp.PedidoId = Ped.PedidoId'
      + sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid'
      + sLineBreak + 'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData'
      + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas' +
      sLineBreak +
      '                    where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '   And (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak +
      '	  And DE.ProcessoId = 15 and (Not Exists (Select PedidoId From PedidoVolumes Where PedidoId = Ped.PedidoId))'
      + sLineBreak + 'Group By Rd.Data,  De.ProcessoId' + sLineBreak +
      '--Producao' + sLineBreak + 'Union' + sLineBreak +
      'Select Rd.Data, De.ProcessoId, Sum(Pvl.qtdSuprida) QtdSuprida' +
      sLineBreak + 'From PedidoVolumeLotes Pvl' + sLineBreak +
      'Inner join vProdutoLotes Pl On Pl.LoteId = Pvl.LoteId' + sLineBreak +
      'Inner join PedidoVolumes Pv On Pv.PedidoVolumeId = Pvl.PedidoVolumeId' +
      sLineBreak + 'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak + 'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' +
      sLineBreak + 'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' +
      sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid' +
      sLineBreak + 'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' +
      sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas ' +
      sLineBreak +
      '                    where Documento = Pv.uuid and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '      And (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak + '      ANd (@Zonaid = 0 or Pl.ZonaId = @ZonaId)' +
      sLineBreak + '      And (@RotaId = 0 or Rp.rotaid = @RotaId)' + sLineBreak
      + '      And De.ProcessoId <> 31 ' + sLineBreak +
      'Group By Rd.Data,  De.ProcessoId) as Ped) as P) AS Tbl PIVOT (sum(Total)'
      + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6], [7], [8])) AS Pvt' +
      sLineBreak + 'Order by Data';

  Const
    SqlGetEvolucaoAtendimentoUnidEmbalagem =
      'declare @DtInicio DateTime = :pDtInicio' + sLineBreak +
      'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak + '' + sLineBreak +
      'Select EmbalagemId, COALESCE ([2], 0) AS ' + #39 + 'Cubagem' + #39 +
      '     , COALESCE ([3], 0) AS ' + #39 + 'Apanhe' + #39 + ',' + sLineBreak +
      '       COALESCE ([4], 0) AS ' + #39 + 'CheckOut' + #39 +
      ', COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 + ', ' + sLineBreak +
      '       COALESCE ([6], 0) AS ' + #39 + 'Cancelado' + #39 + sLineBreak +
      'FROM   (SELECT EmbalagemId, ProcessoId, Total' + sLineBreak +
      '        FROM (select EmbalagemId,' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10, 11, 12) then 4' + sLineBreak
      + '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      When Ped.ProcessoId = 99 then 7' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak + 'From (' +
      sLineBreak +
      'Select Pv.EmbalagemId, De.ProcessoId, Sum(Pvl.qtdSuprida) Total' +
      sLineBreak + 'From PedidoVolumeLotes Pvl' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.LoteId = Pvl.LoteId' + sLineBreak +
      'Inner join PedidoVolumes Pv On Pv.PedidoVolumeId = Pvl.PedidoVolumeId' +
      sLineBreak + 'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak + 'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' +
      sLineBreak + 'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' +
      sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid' +
      sLineBreak + 'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' +
      sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas' +
      sLineBreak +
      '                    where Documento = Pv.uuid and ProcessoId <= 15 and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak + '      And (@RotaId = 0 or Rp.rotaid = @RotaId)' +
      sLineBreak + '      And (@ZonaId = 0 or Pl.ZonaId = @ZonaId)' + sLineBreak
      + 'Group By Pv.EmbalagemId, De.ProcessoId) as Ped) as P) AS Tbl PIVOT (sum(Total)'
      + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6], [7])) AS Pvt' +
      sLineBreak + 'Order by EmbalagemId';

  Const
    SqlGetEvolucaoAtendimentoPed = 'declare @DtInicio DateTime = :pDtInicio' +
      sLineBreak + 'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak + '' + sLineBreak +
      'Select Data, Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '
      + #39 + 'Demanda' + #39 + ',' + sLineBreak +
      '       COALESCE ([1], 0) AS ' + #39 + 'Recebido' + #39 +
      ', COALESCE ([2], 0) AS ' + #39 + 'Cubagem' + #39 +
      ', COALESCE ([3], 0) AS ' + #39 + 'Apanhe' + #39 + ', ' + sLineBreak +
      '       COALESCE ([4], 0) AS ' + #39 + 'CheckOut' + #39 +
      ', COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 + ', ' + sLineBreak +
      '       COALESCE ([6], 0) AS ' + #39 + 'Cancelado' + #39 +
      ', Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) /' + sLineBreak +
      '       Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+'
      + sLineBreak +
      '       Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) Eficiencia'
      + sLineBreak + 'FROM   (SELECT Data, ProcessoId, Total' + sLineBreak +
      '        FROM (select Ped.Data,' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10, 11, 12) then 4' + sLineBreak
      + '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak +
      'From (Select Rd.Data, De.ProcessoId, Count(*) As Total' + sLineBreak +
      'From Pedido Ped' + sLineBreak +
      'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' + sLineBreak +
      'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' + sLineBreak +
      'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' + sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas ' +
      sLineBreak +
      '                    where Documento = Ped.uuid and Status = 1)' +
      sLineBreak + '      and Ped.OperacaoTipoId = 2' + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) ' + sLineBreak +
      '      and (@DtTermino = 0 or Rd.Data <= @DtTermino)' + sLineBreak +
      '      And (@RotaId = 0 or Rp.rotaid = @RotaId)' + sLineBreak +
      '      And De.ProcessoId <> 31' + sLineBreak +
      'Group By Rd.Data,  De.ProcessoId) as Ped) as P) AS Tbl PIVOT (sum(Total)'
      + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt' + sLineBreak
      + 'Order by Data';

  Const
    SqlGetEvolucaoAtendimentoVol = 'declare @DtInicio DateTime = :pDtInicio' +
      sLineBreak + 'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @RotaId Integer = :pRotaid' + sLineBreak +
      'Select Data, Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+Coalesce([6], 0) As '
      + #39 + 'Demanda' + #39 + ', ' + sLineBreak +
      '       COALESCE ([1], 0) AS ' + #39 + 'Recebido' + #39 +
      ', COALESCE ([2], 0) AS ' + #39 + 'Cubagem' + #39 +
      ', COALESCE ([3], 0) AS ' + #39 + 'Apanhe' + #39 + ', ' + sLineBreak +
      '       COALESCE ([4], 0) AS ' + #39 + 'CheckOut' + #39 +
      ', COALESCE ([5], 0) AS ' + #39 + 'Expedicao' + #39 + ', ' + sLineBreak +
      '       COALESCE ([6], 0) AS ' + #39 + 'Cancelado' + #39 +
      ', Cast(Cast(COALESCE ([5], 0) as Decimal(10,2)) /' + sLineBreak +
      '       Cast(Coalesce([1], 0)+Coalesce([2], 0)+Coalesce([3], 0)+Coalesce([4], 0)+Coalesce([5], 0)+'
      + sLineBreak +
      '       Coalesce([6], 0) as Decimal(10,2)) * 100 as Decimal(15,2)) Eficiencia'
      + sLineBreak + 'FROM   (SELECT Data, ProcessoId, Total' + sLineBreak +
      '        FROM (select Pv.Data,' + sLineBreak +
      '              (Case When Pv.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Pv.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Pv.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Pv.ProcessoId in (9, 10, 11, 12) then 4' +
      sLineBreak + '			      When Pv.ProcessoId = 15 then 6' + sLineBreak
      + '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Pv.Total' + sLineBreak +
      'From (Select Rd.Data, De.ProcessoId, Count(*) As Total' + sLineBreak +
      'From Pedido Ped' + sLineBreak +
      'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' + sLineBreak +
      'inner Join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Inner join (Select Distinct PedidoVolumeId' + sLineBreak +
      '            From PedidoVolumeLotes Vl' + sLineBreak +
      '			         Inner join enderecamentos TEnd ON Tend.EnderecoId = Vl.EnderecoId'
      + sLineBreak +
      '			Where @ZonaId = 0 or @ZonaId = Tend.Zonaid) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid' +
      sLineBreak + 'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' +
      sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas' +
      sLineBreak +
      '                    where Documento = Pv.uuid and Status = 1)' +
      sLineBreak + '      and Ped.OperacaoTipoId = 2' + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio)' + sLineBreak +
      '      and (@DtTermino = 0 or Rd.Data <= @DtTermino)' + sLineBreak +
      '      And (@RotaId = 0 or Rp.rotaid = @RotaId)' + sLineBreak +
      '      And ProcessoId <> 31' + sLineBreak +
      '      Group By Rd.Data,  De.ProcessoId) as Pv) as P) AS Tbl PIVOT (sum(Total)'
      + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6])) AS Pvt' + sLineBreak
      + 'Order by Data';

  Const
    SqlGetEvolucaoAtendimentoVolEmbalagem =
      'declare @DtInicio DateTime = :pDtInicio' + sLineBreak +
      'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak + 'Select EmbalagemId,'
      + sLineBreak + '       COALESCE ([2], 0) AS ' + #39 + 'Cubagem' + #39 +
      ',' + sLineBreak + '       COALESCE ([3], 0) AS ' + #39 + 'Apanhe' + #39 +
      ',' + sLineBreak + '       COALESCE ([4], 0) AS ' + #39 + 'CheckOut' + #39
      + ',' + sLineBreak + '	   COALESCE ([5], 0) AS ' + #39 + 'Expedicao' +
      #39 + ',' + sLineBreak + '	   COALESCE ([6], 0) AS ' + #39 + 'Cancelado'
      + #39 + sLineBreak + 'FROM   (SELECT EmbalagemId, ProcessoId, Total' +
      sLineBreak + '        FROM (select EmbalagemId,' + sLineBreak +
      '              (Case When Ped.ProcessoId = 1 then 1' + sLineBreak +
      '		   	      When Ped.Processoid in (2, 22) then 2' + sLineBreak +
      '		          When Ped.ProcessoId in (3, 7, 8) then 3' + sLineBreak +
      '		          When Ped.ProcessoId in (9, 10, 11, 12) then 4' + sLineBreak
      + '			      When Ped.ProcessoId = 15 then 6' + sLineBreak +
      '			      When Ped.ProcessoId = 99 then 7' + sLineBreak +
      '			      Else 5' + sLineBreak +
      '		       End) as Processoid, Ped.Total' + sLineBreak + 'From (' +
      sLineBreak +
      'Select Pv.EmbalagemId, De.ProcessoId, Count(Pv.PedidoId) Total' +
      sLineBreak + 'From PedidoVolumes Pv' + sLineBreak +
      'Inner join (Select Distinct PedidoVolumeId' + sLineBreak +
      '            From PedidoVolumeLotes Vl' + sLineBreak +
      '			         Inner join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak +
      '			         where @ZonaId = 0 or Pl.ZonaId = @ZonaId) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join Pedido Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak + 'Left Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' +
      sLineBreak + 'Left Join RotaPessoas Rp On Rp.pessoaid = Pes.PessoaId' +
      sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Pv.uuid' +
      sLineBreak + 'Left Join Rhema_data Rd On Rd.IdData = Ped.documentoData' +
      sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas' +
      sLineBreak +
      '                    where Documento = Pv.uuid and ProcessoId <= 15 and Status = 1) and Ped.OperacaoTipoId = 2'
      + sLineBreak +
      '      and (@DtInicio = 0 or Rd.Data >= @DtInicio) and (@DtTermino = 0 or Rd.Data <= @DtTermino)'
      + sLineBreak + '      And (@RotaId = 0 or Rp.rotaid = @RotaId)' +
      sLineBreak +
      'Group By Pv.EmbalagemId, De.ProcessoId) as Ped) as P) AS Tbl PIVOT (sum(Total)'
      + sLineBreak +
      '		FOR ProcessoId IN ([1], [2], [3], [4], [5], [6], [7])) AS Pvt' +
      sLineBreak + 'Order by EmbalagemId';

  Const
    SqlGetPedidoItens = 'Declare @PedidoId Integer      = :pPedidoId' +
      sLineBreak + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' +
      sLineBreak + 'select Pi.PedidoId,' + sLineBreak +
      '	   Pl. CodProduto CodigoERP, Pl.Endereco Picking, Pl.Descricao, Pl.LoteId, Pl.Lote,'
      + sLineBreak + '	   Pl.Data Fabricacao, Pl.Vencimento,' + sLineBreak +
      '	   Pi.QtdXml, Pi.QtdCheckIn, Pi.QtdSegregada, Pi.QtdDevolvida' +
      sLineBreak + 'from PedidoItens PI' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.LoteId = Pi.LoteId' + sLineBreak +
      'Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = PI.PedidoId' +
      sLineBreak + 'where (@AgrupamentoId<>0 or PI.Pedidoid = @PedidoId)' +
      sLineBreak +
      '   And (@AgrupamentoId = 0 or PA.AgrupamentoId = @AgrupamentoId)' +
      sLineBreak + 'Order by Pl.Descricao, Pl.Lote';

  Const
    SqlGetPedidoItensByProd = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' +
      sLineBreak + 'select Pi.PedidoId,' + sLineBreak +
      '   	Pl. CodProduto CodigoERP, Pl.Descricao, Pl.Endereco Picking,' +
      sLineBreak + '	   Sum(Pi.QtdXml) QtdXml, Sum(Pi.QtdCheckIn) QtdCheckIn,'
      + sLineBreak +
      '	   Sum(Pi.QtdSegregada) QtdSegregada, Sum(Pi.QtdDevolvida) QtdDevolvida'
      + sLineBreak + 'from PedidoItens Pi' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.LoteId = Pi.LoteId' + sLineBreak +
      'where Pi.Pedidoid = @PedidoId' + sLineBreak +
      '   And (@AgrupamentoId = 0 or PIt.PedidoId = PA.PedidoId)' + sLineBreak +
      'Group by Pi.PedidoId, Pl. CodProduto, Pl.Descricao, Pl.Endereco' +
      sLineBreak + 'Order by Pl.Descricao';

  Const
    SqlGetEntradaProdutoAgrupamento = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' +
      sLineBreak +
      'Select Pi.AgrupamentoId, PI.ProdutoId, Prd.CodProduto, Prd.Descricao, Prd.EnderecoDescricao Picking,'
      + sLineBreak +
      '       Prd.Mascara, PI.QtdXml, Prd.FatorConversao, Prd.PesoLiquido, Prd.Altura, Prd.Largura,'
      + sLineBreak +
      '	      Prd.Comprimento, Coalesce(Prd.SNGPC, 0) SNGPC, Prd.RastroId, Prd.UnidadeSecundariaId, Prd.UnidadeSecundariaDescricao,'
      + sLineBreak +
      '   	   Prd.EnderecoId, Coalesce(Prd.ProdutoSngpc, 0) ZonaSngpc, Prd.MesEntradaMinima,'
      + sLineBreak +
      '   	   Coalesce(Chk.QtdCheckIn, 0) QtdCheckIn, Coalesce(Chk.QtdDevolvida, 0) QtdDevolvida, Coalesce(Chk.QtdSegregada, 0) QtdSegregada'
      + sLineBreak +
      'From (Select Pa.AgrupamentoId, Pl.ProdutoId, Sum(PI.QtdXml) QtdXml' +
      sLineBreak + '     	From PedidoItens PI' + sLineBreak +
      '     	Inner Join ProdutoLotes Pl On Pl.Loteid = PI.LoteId' + sLineBreak
      + '     	Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = PI.PedidoId'
      + sLineBreak +
      '     	Where (@AgrupamentoId<>0 or Pi.PedidoId = @PedidoId)' + sLineBreak
      + '   		   And (@AgrupamentoId = 0 or PA.AgrupamentoId=@AgrupamentoId)'
      + sLineBreak + '     	Group by Pa.AgrupamentoId, Pl.ProdutoId) PI' +
      sLineBreak + 'Left Join (Select PA.AgrupamentoId, Pl.ProdutoId,' +
      sLineBreak +
      '           SUM(QtdCheckIn) QtdCheckIn, SUM(QtdDevolvida) QtdDevolvida, SUM(QtdSegregada) QtdSegregada'
      + sLineBreak + '           From PedidoItensCheckInAgrupamento PA' +
      sLineBreak +
      '		         Inner join ProdutoLotes Pl On Pl.LoteId = Pa.LoteId' +
      sLineBreak +
      '      		   Group by PA.AgrupamentoId, Pl.ProdutoId) Chk On Chk.AgrupamentoId = Pi.AgrupamentoId and Chk.ProdutoId = PI.ProdutoId'
      + sLineBreak + 'Inner Join vProduto Prd On Prd.IdProduto = PI.Produtoid';

    // Lotes Pre-Existentes
  Const
    SqlGetAgrupamentoFatorarLoteXML =
      'Declare @AgrupamentoId Integer = :pAgrupamentoId' + sLineBreak +
      'Select Pi.PedidoId, Pi.LoteId,' + sLineBreak +
      '       Pi.QtdCheckIn, Pi.QtdDevolvida, Pi.QtdSegregada,' + sLineBreak +
      '       CA.QtdCheckIn CheckIn, CA.QtdDevolvida Devolvida, CA.QtdSegregada Segregadada,'
      + sLineBreak +
      '       Ca.UsuarioId, CA.CheckInDtInicio, Ca.CheckInDtInicio, CA.RespAltLote, CA.Terminal'
      + sLineBreak + 'from PedidoItens Pi' + sLineBreak +
      'Inner join PedidoAgrupamentoNotas PAN  On PAN.pedidoid = Pi.PedidoId' +
      sLineBreak +
      'Inner join PedidoItensCheckInAgrupamento CA On CA.AgrupamentoId = PAN.agrupamentoid and CA.LoTeid =  Pi.LoteId'
      + sLineBreak + 'where PAN.agrupamentoid = @AgrupamentoId' + sLineBreak +
      'order by CA.LoteId, Pi.PedidoId';

  Const
    GetAgrupamentoFatorarPedidoLotes =
      'Declare @AgrupamentoId Integer = :pAgrupamentoId' + sLineBreak +
      'select PI.PedidoItemId, PI.PedidoId, Pl.ProdutoId, PI.LoteId, PI.QtdXml, Pi.QtdCheckIn, PI.QtdDevolvida, PI.QtdSegregada'
      + sLineBreak + 'from PedidoItens PI' + sLineBreak +
      'Inner join PedidoAgrupamentoNotas PN On PN.pedidoid = PI.PedidoId' +
      sLineBreak + 'Inner Join ProdutoLotes Pl On Pl.LoteId = PI.LoteId' +
      sLineBreak + 'where PN.agrupamentoid = @AgrupamentoId';

  Const
    SqlGetEntradaProduto = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak
      + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' + sLineBreak +
      'Select Itens.ProdutoId, Prod.CodProduto, Prod.Descricao, Prod.EnderecoDescricao Picking, Prod.Mascara,'
      + sLineBreak +
      '       Itens.QtdXml, Itens.QtdCheckIn, Itens.QtdDevolvida, Itens.QtdSegregada,'
      + sLineBreak +
      '       Prod.FatorConversao, Prod.PesoLiquido, Prod.Altura,' + sLineBreak
      + '       Prod.Largura, Prod.Comprimento, Coalesce(Prod.SNGPC, 0) SNGPC, Prod.RastroId,'
      + sLineBreak +
      '	      UnidadeSecundariaId, UnidadeSecundariaDescricao, Prod.EnderecoId,'
      + sLineBreak +
      '	      Coalesce(Prod.ProdutoSngpc, 0) ZonaSngpc, MesEntradaMinima' +
      sLineBreak +
      'From (select Pl.ProdutoId, --Prd.CodProduto, Prd.Descricao, Prd.EnderecoDescricao Picking, Prd.Mascara, '
      + sLineBreak +
      '	      Sum(PIt.QtdXml) as QtdXml, Sum(PIt.QtdCheckIn) QtdCheckIn, Sum(PIt.QtdDevolvida) QtdDevolvida, Sum(PIt.QtdSegregada) QtdSegregada'
      + sLineBreak + 'From PedidoItens PIt' + sLineBreak +
      'Inner Join ProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + sLineBreak +
      '--Inner join vProduto Prd On Prd.IdProduto = Pl.ProdutoId' + sLineBreak +
      'Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = PIt.PedidoId' +
      sLineBreak + 'Where (@AgrupamentoId<>0 or PIt.PedidoId = @PedidoId)' +
      sLineBreak +
      '    And (@AgrupamentoId = 0 or PA.AgrupamentoId=@AgrupamentoId)' +
      sLineBreak + 'Group by Pl.ProdutoId) Itens' + sLineBreak +
    // --, Prd.CodProduto, Prd.Descricao, Prd.EnderecoDescricao, Prd.Mascara
      'Inner Join vProduto Prod On Prod.IdProduto = Itens.ProdutoId' +
      sLineBreak + 'Order by Prod.Descricao';

  Const
    SqlGetEntradaLotesAgrupamento = 'Declare @PedidoId  Integer = :pPedidoId' +
      sLineBreak + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' +
      sLineBreak +
      'Declare @ProdutoId Integer = Coalesce((Select IdProduto From Produto Where CodProduto = :pCodproduto), 0)'
      + sLineBreak + 'Declare @LoteId Integer    = :pLoteId' + sLineBreak +
      'select PIt.AgrupamentoId, Pl.LoteId, Pl.IdProduto ProdutoId,' +
      sLineBreak + '       Pl.CodProduto, Pl.Lote DescrLote,' + sLineBreak +
      '       FORMAT(Pl.Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') as Fabricacao,'
      + sLineBreak + '       FORMAT(Pl.Vencimento, ' + #39 + 'dd/MM/yyyy' + #39
      + ') as Vencimento,' + sLineBreak + '       FORMAT(Pl.DtEntrada, ' + #39 +
      'dd/MM/yyyy' + #39 + ') as DtEntrada, Pl.HrEntrada,' + sLineBreak +
      '       0 QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida, PIt.QtdSegregada,' +
      sLineBreak +
      '       Prd.Descricao DescrProduto, Pl.RastroId, Pl.Sngpc, Pl.ZonaRastroId, Pl.ZonaSNGPC, PIt.CausaId'
      + sLineBreak + 'From PedidoItensCheckInAgrupamento PIt' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.IdProduto' + sLineBreak +
      'Where (@ProdutoId = 0 or Pl.IdProduto = @ProdutoId) and' + sLineBreak +
      '      (@LoteId    = 0 or Pl.LoteId     = @LoteId) And' + sLineBreak +
      '      (@AgrupamentoId = 0 or PIt.AgrupamentoId=@AgrupamentoId)' +
      sLineBreak + '' + sLineBreak + 'UNION' + sLineBreak + '' + sLineBreak +
      'select @AgrupamentoId AgrupamentoId, Pl.LoteId, Pl.IdProduto ProdutoId,'
      + sLineBreak + '       Prd.CodProduto, Pl.Lote DescrLote' + sLineBreak +
      '     , FORMAT(Pl.Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') as Fabricacao,'
      + sLineBreak + '       FORMAT(Pl.Vencimento, ' + #39 + 'dd/MM/yyyy' + #39
      + ') as Vencimento,' + sLineBreak + '       FORMAT(Pl.DtEntrada, ' + #39 +
      'dd/MM/yyyy' + #39 + ') as DtEntrada' + sLineBreak +
      '     , Pl.HrEntrada, PIt.QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida,' +
      sLineBreak +
      '       PIt.QtdSegregada, Prd.Descricao DescrProduto, Pl.RastroId, Pl.Sngpc, Pl.ZonaRastroId, Pl.ZonaSNGPC, 0 as CausaId'
      + sLineBreak + 'From PedidoItens PIt' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.IdProduto' + sLineBreak +
      'Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = PIt.PedidoId' +
      sLineBreak +
      'Left Join PedidoItensCheckInAgrupamento PIC on PIC.LoteId = PIt.LoteId' +
      sLineBreak + 'Where (@AgrupamentoId<>0 or PIt.PedidoId   = @PedidoId) and'
      + sLineBreak + '       (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId) and'
      + sLineBreak + '       (@LoteId    = 0 or Pl.LoteId     = @LoteId) And' +
      sLineBreak +
      '       (@AgrupamentoId = 0 or PA.AgrupamentoId=@AgrupamentoId)' +
      sLineBreak + 'and PIC.LoteId Is Null' + sLineBreak + '' + sLineBreak +
      'Order by PIt.AgrupamentoId';

  Const
    SqlGetEntradaLotes = 'Declare @PedidoId  Integer = :pPedidoId' + sLineBreak
      + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' + sLineBreak +
      'Declare @ProdutoId Integer = Coalesce((Select IdProduto From Produto Where CodProduto = :pCodproduto), 0)'
      + sLineBreak + 'Declare @LoteId Integer    = :pLoteId' + sLineBreak +
      'select PIt.PedidoId, PIt.PedidoItemId, Pl.LoteId, Pl.IdProduto ProdutoId, '
      + sLineBreak + '       Prd.CodProduto, Pl.Lote DescrLote' + sLineBreak +
      '     , FORMAT(Pl.Data, ' + #39 + 'dd/MM/yyyy' + #39 + ') as Fabricacao' +
      sLineBreak + '     , FORMAT(Pl.Vencimento, ' + #39 + 'dd/MM/yyyy' + #39 +
      ') as Vencimento' + sLineBreak + '     , FORMAT(Pl.DtEntrada, ' + #39 +
      'dd/MM/yyyy' + #39 + ') as DtEntrada' + sLineBreak +
      '     , Pl.HrEntrada, PIt.QtdXml, PIt.QtdCheckIn, PIt.QtdDevolvida, ' +
      sLineBreak +
      '       PIt.QtdSegregada, Prd.Descricao DescrProduto, Pl.RastroId, Pl.Sngpc, Pl.ZonaRastroId, Pl.ZonaSNGPC'
      + sLineBreak + 'From PedidoItens PIt' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.Loteid = PIt.LoteId' + sLineBreak +
      'Inner join vProduto Prd On Prd.IdProduto = Pl.IdProduto' + sLineBreak +
      'Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = PIt.PedidoId' +
      sLineBreak + 'Where (@AgrupamentoId<>0 or PIt.PedidoId   = @PedidoId) and'
      + sLineBreak + '       (@ProdutoId = 0 or Prd.IdProduto = @ProdutoId) and'
      + sLineBreak + '       (@LoteId    = 0 or Pl.LoteId     = @LoteId) And' +
      sLineBreak +
      '       (@AgrupamentoId = 0 or PA.AgrupamentoId=@AgrupamentoId)' +
      sLineBreak + 'Order by PIt.PedidoId, PIt.PedidoItemId';

  Const
    SqlGetEntradaLoteDevolucao = 'Declare @PedidoId Integer      = :pPedidoId' +
      sLineBreak + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' +
      sLineBreak + 'Declare @CodProduto Integer    = :pCodProduto' + sLineBreak
      + 'select 1 as Ordem, Pl.CodProduto, Pl.Lote DescrLote, Pl.Data Fabricacao, Pl.Vencimento'
      + sLineBreak + 'From PedidoItens Pi' + sLineBreak +
      'inner join vprodutoLotes Pl On Pl.LoteId = Pi.LoteId' + sLineBreak +
      'Left Join PedidoAgrupamentoNotas Ped On Ped.PedidoId = Pi.PedidoId' +
      sLineBreak + 'where (@PedidoId = 0 or pi.pedidoid = @PedidoId )' +
      sLineBreak +
      '  And (@AgrupamentoId = 0 or Ped.agrupamentoid = @AgrupamentoId)' +
      sLineBreak + '  and Pl.CodProduto = @CodProduto' + sLineBreak + 'Union' +
      sLineBreak +
      'Select 2 as Ordem, Pl.CodProduto, Pl.Lote DescrLote, Pl.Data Fabricacao, Pl.Vencimento'
      + sLineBreak + 'From vProdutoLotes Pl' + sLineBreak +
      'Left Join (Select Pi.PedidoId, Pi.LoteId From PedidoItens Pi' +
      sLineBreak +
      '           Left Join PedidoAgrupamentoNotas Ped On Ped.PedidoId = Pi.PedidoId'
      + sLineBreak +
      '		         where (@PedidoId = 0 or pi.pedidoid = @PedidoId )' +
      sLineBreak +
      '             And (@AgrupamentoId = 0 or Ped.agrupamentoid = @AgrupamentoId) ) Pi On Pi.LoteId = Pl.LoteId and Pi.PedidoId = @PedidoId'
      + sLineBreak + 'where Pl.CodProduto = @CodProduto' + sLineBreak +
      '  and Pi.LoteId Is Null' + sLineBreak + 'Order by Ordem, Pl.Lote';

  Const
    SqlGetProdutoSemPicking = 'Declare @PedidoId Integer = :pPedidoId' +
      sLineBreak + 'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @Recebido Integer = :pRecebido' + sLineBreak +
      'Declare @Cubagem Integer = :pCubagem' + sLineBreak +
      'Declare @Etiqueta Integer = :pEtiqueta' + sLineBreak +
      'Select PP.ProdutoId, Prd.CodProduto, Prd.Descricao, Prd.FatorConversao Embalagem, Prd.Altura, Prd.Largura, Prd.Comprimento, Prd.PesoLiquido'
      + sLineBreak + 'From PedidoProdutos PP' + sLineBreak +
      'Inner Join pedido Ped ON Ped.PedidoId = Pp.PedidoId' + sLineBreak +
      'Inner join Produto Prd On Prd.IdProduto = PP.ProdutoId' + sLineBreak +
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId' +
      sLineBreak + 'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId' +
      sLineBreak + 'Left join RotaPessoas RP ON RP.PessoaId = P.PessoaId' +
      sLineBreak + 'Left Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' +
      sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' +
      sLineBreak +
      'Where (@DataIni=0 or Rd.Data >= @DataIni) and (@DataFin=0 or Rd.Data <= @DataFin) And Ped.OperacaoTipoId = 2 and'
      + sLineBreak + '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' +
      sLineBreak + '      (@CodigoERP=0 or @CodigoERP = P.CodPessoaERP) and' +
      sLineBreak + '      (@PessoaId = 0 or P.PessoaId = @PessoaId) and' +
      sLineBreak + '      (@DocumentoNr = ' + #39 + #39 +
      ' or @DocumentoNr=Ped.DocumentoNr) and' + sLineBreak + '	     (@Razao = '
      + #39 + #39 + ' or P.Razao Like @Razao) and' + sLineBreak +
      '	     (@Razao = ' + #39 + #39 + ' or P.Fantasia Like @Razao) and' +
      sLineBreak + '	     (@RegistroERP =' + #39 + #39 +
      ' or Ped.RegistroERP = @RegistroERP) and' + sLineBreak +
      '      (@RotaId = 0 or @RotaId = RP.RotaId) and' + sLineBreak +
      '	     (De.ProcessoId in (1, 2, 3)) and' + sLineBreak +
      '	     DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '      and Prd.EnderecoId is Null' + sLineBreak +
      'Group by PP.ProdutoId, Prd.CodProduto, Prd.Descricao, Prd.FatorConversao, Prd.Altura, Prd.Largura, Prd.Comprimento, Prd.PesoLiquido'
      + sLineBreak + 'Order by Prd.Descricao';

  Const
    SqlGetEntradaProdutoSemPicking =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime = :pDataFinal' + sLineBreak +
      'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @PessoaId Integer = Coalesce((Select PessoaId From Pessoa where CodPessoaERP = :pCodPessoaERP and PessoaTipoId = 2), 0)'
      + sLineBreak + 'Declare @DocumentoNr Varchar(20) = :pDocumentoNr' +
      sLineBreak +
      'Select Prd.CodProduto, Prd.Descricao, Prd.UnidadeSecundariaSigla,' +
      sLineBreak +
      '       Prd.UnidadeSecundariaId UnidCxa, Prd.FatorConversao QtdCxa,' +
      sLineBreak +
      '	      Prd.Altura, Prd.Largura, Prd.Comprimento, Prd.Volume,' +
      sLineBreak + '	      Prd.PesoLiquido, Null As Picking' + sLineBreak +
      'From (select Pl.ProdutoId' + sLineBreak + '      From Pedido Ped' +
      sLineBreak +
      '      Inner Join PedidoItens Pi ON PI.PedidoId = Ped.PedidoId' +
      sLineBreak +
      '      inner join Rhema_data rd On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      '      Inner join vDocumentoEtapas De on De.Documento = Ped.Uuid' +
      sLineBreak + '      Inner Join ProdutoLotes Pl On Pl.LoteId = Pi.LoteId' +
      sLineBreak + '	     where Ped.OperacaoTipoId = 3' + sLineBreak +
      '         And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '	        And De.ProcessoId = 1' + sLineBreak +
      '         And (@DataInicial = 0 or rd.Data >= @DataInicial)' + sLineBreak
      + '         And (@DataFinal = 0 or rd.Data <= @DataFinal)' + sLineBreak +
      '         And (@PedidoId = 0 or Ped.PedidoId = @PedidoId)' + sLineBreak +
      '	        And (@PessoaId = 0 or Ped.PessoaId = @PessoaId)' + sLineBreak +
      '         And (@DocumentoNr = ' + #39 + #39 +
      ' or Ped.DocumentoNr = @DocumentoNr)' + sLineBreak +
      '	     Group by Pl.ProdutoId) as Ped' + sLineBreak +
      'Inner Join vProduto Prd On Prd.IdProduto = Ped.ProdutoId' + sLineBreak +
      'Where Prd.EnderecoId Is Null' + sLineBreak + 'Order by Prd.Descricao';

  Const
    SqlRelRecebimento = 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DataIni DateTime = :pDataIni' + sLineBreak +
      'Declare @DataFin DateTime = :pDataFin' + sLineBreak +
      'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'Declare @PessoaId Integer = :pPessoaId' + sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' + sLineBreak +
      'Declare @Razao VarChar(100) = :pRazao' + sLineBreak +
      'Declare @RegistroERP VarChar(36) = :pRegistroERP' + sLineBreak +
      'Declare @OperacaoTipoId Integer = :pOperacaoTipoId' + sLineBreak +
      'Declare @ProcessoId Integer = :pProcessoId' + sLineBreak +
      'Declare @CodProduto integer = :pCodProduto' + sLineBreak +
      'Declare @PedidoPendente Integer = :pPedidoPendente' + sLineBreak +
      'Select Ped.*, De.ProcessoId, De.Descricao Etapa, De.Data DtProcesso,' +
      sLineBreak +
      '       Pi.Itens, Pi.QtdXml, Pi.QtdCheckIn, Pi.QtdDevolvida, Pi.QtdSegregada,'
      + sLineBreak + '' + sLineBreak + '(Case' + sLineBreak +
      '   When Exists (Select Prd.EnderecoId From PedidoItens Pi' +
      sLineBreak +
      '				            Inner Join ProdutoLotes Pl On Pl.Loteid = Pi.LoteId' +
      sLineBreak +
      '                Inner join Produto Prd On Prd.IdProduto = Pl.Produtoid' +
      sLineBreak +
      '				Where Pi.PedidoId = Ped.PedidoId and Prd.EnderecoId Is Null) then 0 Else 1 End) As Picking'
      + sLineBreak +
      'From (select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid, P.CodPessoaERP, P.Razao,'
      + sLineBreak +
      '      P.Fantasia, ped.DocumentoOriginal, Ped.DocumentoNr, FORMAT(Rd.Data, '
      + #39 + 'dd/MM/yyyy' + #39 + ') as DocumentoData, Ped.RegistroERP,' +
      sLineBreak + '      FORMAT(RE.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
      ') as DtInclusao, cast( Rh.Hora as Time) as HrInclusao,' + sLineBreak +
      '      ArmazemId, Ped.Status, Cast(Ped.uuid as Varchar(36)) as uuid' +
      sLineBreak + 'From pedido Ped' + sLineBreak +
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId' +
      sLineBreak + 'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId' +
      sLineBreak + 'Left Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData' +
      sLineBreak + 'Left Join Rhema_Data RE On Re.IdData = Ped.DtInclusao' +
      sLineBreak + 'Left Join Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao' +
      sLineBreak +
      'Where (@DataIni=0 or Rd.Data >= @DataIni) and (@DataFin=0 or Rd.Data <= @DataFin) And (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId) and'
      + sLineBreak + '      (@PedidoId=0 or @PedidoId = Ped.PedidoId) and' +
      sLineBreak + '      (@CodigoERP=0 or @CodigoERP = P.CodPessoaERP) and' +
      sLineBreak + '      (@PessoaId = 0 or P.PessoaId = @PessoaId) and' +
      sLineBreak + ' 			  (@DocumentoNr = ' + #39 + #39 +
      ' or @DocumentoNr=Ped.DocumentoNr) and' + sLineBreak +
      '				  (@Razao = ' + #39 + #39 + ' or P.Razao Like @Razao) and' +
      sLineBreak + '      (@Razao = ' + #39 + #39 +
      ' or P.Fantasia Like @Razao) and' + sLineBreak +
      '				  (@RegistroERP = ' + #39 + #39 +
      ' or Ped.RegistroERP = @RegistroERP) and' + sLineBreak +
      '      (@OperacaoTipoId=0 or Ped.OperacaoTipoId = @OperacaoTipoId)) Ped' +
      sLineBreak + 'Left Join vDocumentoEtapas DE On De.Documento = Ped.uuid' +
      sLineBreak +
      'Left Join (Select Pi.PedidoId, Count(Pl.Produtoid) as Itens, Sum(Pi.QtdXml) as QtdXml, Sum(Pi.QtdCheckIn) as QtdCheckIn, Sum(Pi.QtdDevolvida) as QtdDevolvida,Sum(Pi.QtdSegregada) as QtdSegregada'
      + sLineBreak + '           From PedidoItens Pi' + sLineBreak +
      '		   Inner Join Produtolotes Pl on Pl.LoteId = Pi.Loteid' + sLineBreak
      + '		   Group by Pi.PedidoId) as Pi On Pi.PedidoId = Ped.PedidoId' +
      sLineBreak +
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1) and Ped.OperacaoTipoId = 3'
      + sLineBreak +
      '      and (@ProcessoId = 0  or De.ProcessoId = @ProcessoId)' + sLineBreak
      + '      and (@CodProduto = 0 or Exists (select Prd.IdProduto ProdutoId from PedidoItens PI'
      + sLineBreak +
      '	                                     Inner Join ProdutoLotes Pl On Pl.LoteId = Pi.LoteId'
      + sLineBreak +
      '                                      Inner Join Produto Prd On Prd.IdProduto = Pl.ProdutoId'
      + sLineBreak +
      '                                      where Pi.PedidoId = Ped.PedidoId and Prd.CodProduto = @CodProduto))'
      + sLineBreak + '      and (@PedidoPendente=0 or De.ProcessoId<6)' +
      sLineBreak + 'Order by Ped.DocumentoData, Ped.PedidoId';

  Const
    SqlGetRelProdutos01 = 'Declare @Estoque Integer = :pEstoque' + sLineBreak +
      'Declare @SemPicking Integer = :pSemPicking' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Declare @ZonaId Integer = :pZonaid' + sLineBreak +
      'Declare @LaboratorioId Integer = :pLaboratorioId' + sLineBreak +
      'Declare @ListaEan integer = :pListaEan' + sLineBreak +
      'Declare @Status Integer = :pStatus' + sLineBreak +
      'Declare @SomenteCxaFechada Integer = :pSomenteCxaFechada' + sLineBreak +
      'Declare @Ativo Integer = :pAtivo' + sLineBreak +
      'select Prd.CodProduto, Descricao, (Case When FatorConversao = 1 then UnidadeSigla '
      + sLineBreak +
      '	                                   Else UnidadeSecundariaSigla+ ' + #39
      + ' c/' + #39 + '+' + sLineBreak +
      '							Cast(FatorConversao as VarChar) End) Embalagem,' +
      sLineBreak +
      '       ZonaDescricao, EnderecoDescricao Endereco, Mascara, RastroDescricao Rastro,'
      + sLineBreak +
      '   	   LaboratorioNome Fabricante, Curva, Cast(PesoLiquido / 1000 as Decimal(15,3)) PesoLiquido'
      + sLineBreak + '       , Altura, Largura, Comprimento,' + sLineBreak +
      '   	   Cast((Altura*Largura*Comprimento)/1000000 as Decimal(15,6)) Volm3, SNGPC,'
      + sLineBreak + '   	   Coalesce(Est.Qtde, 0) Estoque' + sLineBreak +
      '       , EanPvt.EAN01, EanPvt.EAN02, EanPvt.EAN03, EanPvt.EAN04, EanPvt.EAN05'
      + sLineBreak +
      '       , EanPvt.EAN06, EanPvt.EAN07, EanPvt.EAN08, EanPvt.EAN09, EanPvt.EAN10'
      + sLineBreak + '       , Prd.SomenteCxaFechada' + sLineBreak +
      'from vproduto Prd' + sLineBreak + 'Left Join (SELECT' + sLineBreak +
      '	CodProduto,' + sLineBreak + '	[1] AS EAN01,' + sLineBreak +
      '	[2] AS EAN02,' + sLineBreak + '	[3] AS EAN03,' + sLineBreak +
      '	[4] AS EAN04,' + sLineBreak + '	[5] AS EAN05,' + sLineBreak +
      '	[6] AS EAN06,' + sLineBreak + '	[7] AS EAN07,' + sLineBreak +
      '	[8] AS EAN08,' + sLineBreak + '	[9] AS EAN09,' + sLineBreak +
      '	[10] AS EAN10' + sLineBreak + 'FROM' + sLineBreak + '	(SELECT' +
      sLineBreak + '			P.CodProduto,' + sLineBreak + '			A.CodBarras,' +
      sLineBreak + '			COUNT(*) ORDEM' + sLineBreak + '		FROM' + sLineBreak
      + '			vProduto P,' + sLineBreak + '			ProdutoCodBarras A,' +
      sLineBreak + '			ProdutoCodBarras B' + sLineBreak + '		WHERE' +
      sLineBreak + '			 P.IdProduto = A.ProdutoID and' + sLineBreak +
      '		 	A.ProdutoId = B.ProdutoId and' + sLineBreak +
      '		 	A.CodBarrasId <= B.CodBarrasId and ' + sLineBreak +
      '    (@SomenteCxaFechada = 0 or (@SomenteCxaFechada=1 and P.SomenteCxaFechada=1))'
      + sLineBreak + '		GROUP BY' + sLineBreak +
      '			P.CodProduto, A.CodBarras' + sLineBreak +
      '		HAVING      COUNT(*) <= 10) tab PIVOT (MIN(tab.CodBarras)' +
      sLineBreak + '						FOR tab.ORDEM IN ([1], [2], [3], [4], [5],' +
      sLineBreak +
      '											[6], [7], [8], [9], [10])) AS pvt) as EanPvt On EanPvt.CodProduto = Prd.CodProduto'
      + sLineBreak + '' + sLineBreak +
      'Left Join (Select ProdutoId, Sum(Qtde) Qtde From vEstoque' + sLineBreak +
      '           Where EstoqueTipoId In (1,4)' + sLineBreak +
      '		         Group by ProdutoId) Est On Est.ProdutoId = Prd.IdProduto' +
      sLineBreak + 'Where (@SemPicking<>1 or Prd.EnderecoId Is Null)' +
      sLineBreak + '  And (@Estoque<>1 or Coalesce(Est.Qtde, 0) <> 0)' +
      sLineBreak + '	 And (@ZonaId=0 or @ZonaId = Prd.ZonaId)' + sLineBreak +
      '	 And (@LaboratorioId = 0 or @LaboratorioId = Prd.LaboratorioId)' +
      sLineBreak + '	 And (@CodProduto = 0 or @CodProduto = Prd.CodProduto)' +
      sLineBreak + '  And (@ListaEan = 0 or EanPvt.EAN01 Is not Null)' +
      sLineBreak + '  And (@Status > 1 or Status = @Status)' + sLineBreak +
      '  And (@SomenteCxaFechada = 0 or (@SomenteCxaFechada=1 and Prd.SomenteCxaFechada=1))'
      + sLineBreak + '  And (@Ativo = 0 or (@Status<>0 and Status = 1))' +
      sLineBreak + 'Order by Descricao';

  Const
    SqlGetControleArmazenagem =
      'Declare @CodProduto Integer        = :pCodProduto' + sLineBreak +
      'Declare @DataInicial DateTime      = :pDataInicial' + sLineBreak +
      'Declare @DataFInal   DateTime      = :pDataFinal' + sLineBreak +
      'Declare @DocumentoNr Varchar(50)   = :pDocumentoNr' + sLineBreak +
      'Declare @EnderecoDestinoId Integer = :pEnderecoDestinoId' + sLineBreak +
      'Declare @TipoMovimentacao Integer  = :pTipoMovimentacao -- 0-Todas 1-Interna 2-Recebimentos 3-Sa�das 4-Entrada/Sa�da'
      + sLineBreak + 'Declare @UsuarioId Integer         = :pUsuarioId' +
      sLineBreak + 'select Rd.Data, Rh.Hora, --K.*,' + sLineBreak +
      '       Pl.CodProduto, Pl.Descricao Produto, Pl.Lote, vEndD.Endereco EnderecoDestino, Qtde,'
      + sLineBreak +
      '	      K.SaldoInicialOrigem, K.SaldoFinalOrigem, K.SaldoInicialDestino, K.SaldoFinalDestino,'
      + sLineBreak + '	      K.UsuarioId, U.Nome, K.NomeEstacao Terminal' +
      sLineBreak + 'From kardex K' + sLineBreak +
      'inner join vProdutoLotes Pl On Pl.LoteId = K.LoteId' + sLineBreak +
      'inner join vEnderecamentos vEndD On  vEndD.EnderecoId = K.EnderecoIdDestino'
      + sLineBreak +
      'Inner join Enderecamentos vEndO On vEndO.EnderecoId = K.EnderecoId' +
      sLineBreak + 'Inner join Rhema_Data Rd On Rd.IdData = K.data' + sLineBreak
      + 'Inner join Rhema_Hora Rh On Rh.IdHora = K.Hora' + sLineBreak +
      'Inner join Usuarios U On U.UsuarioId = K.UsuarioId' + sLineBreak +
      'where (@CodProduto = 0 or Pl.CodProduto = @CodProduto)' + sLineBreak +
      '  And (@DataInicial = 0 or Rd.Data >= @DataInicial)' + sLineBreak +
      '  And (@DataFinal = 0 or Rd.Data <= @DataFinal)' + sLineBreak +
      '  And (@TipoMovimentacao = 0 or (@TipoMovimentacao=1 and ObservacaoOrigem like '
      + #39 + '%interna%' + #39 + ' and vEndO.ZonaId = 1)' + sLineBreak +
      '                             or (@TipoMovimentacao=2 and ObservacaoOrigem like '
      + #39 + 'Recebimento%' + #39 + ')' + sLineBreak +
      '							                      or (@TipoMovimentacao=3 and ObservacaoOrigem like '
      + #39 + 'Baixa Volume%' + #39 + '))' + sLineBreak +
      '  And (@DocumentoNr ='#39 + #39 + ' or ObservacaoOrigem like ' + #39 +
      '%' + #39 + '+@DocumentoNr+' + #39 + '%' + #39 + ')' + sLineBreak +
      '  And (@EnderecoDestinoId = 0 or K.EnderecoIdDestino = @EnderecoDestinoId)'
      + sLineBreak + '  And (@UsuarioId = 0 or K.UsuarioId = @UsuarioId)' +
      sLineBreak + 'Order by Rd.Data, Pl.Descricao';

  Const
    SqlGetRelMovimentacaointerna = 'Declare @UsuarioId Integer = :pUsuarioId' +
      sLineBreak + 'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime = :pDataFinal' + sLineBreak +
      'Declare @EnderecoOrigem  Varchar(11) = :pEnderecoOrigem' + sLineBreak +
      'Declare @EnderecoDestino Varchar(11) = :pEnderecoDestino' + sLineBreak +
      'Declare @Armazenagem Integer  = :pArmazenagem' + sLineBreak +
      'Declare @MovInterna  Integer  = :pMovInterna' + sLineBreak +
      'select DMov.Data, HMov.Hora, pl.CodProduto, pl.Descricao,' + sLineBreak +
      '       --(Case When FatorConversao = 1 then ' + #39 + 'Unidade' + #39 +
      sLineBreak + '       --      Else ' + #39 + 'Cxa.C/ ' + #39 +
      '+CAST(Prd.FatorConversao as varchar)+' + #39 + ' unid.' + #39 +
      ' End) Embalagem,' + sLineBreak +
      '      Prd.FatorConversao as Embalagem, ' + sLineBreak +
      '	      K.ObservacaoOrigem, Pl.LoteId, Pl.Lote, Pl.Vencimento, K.EnderecoId,'
      + sLineBreak +
      '		     vEndO.Endereco as Origem, K.SaldoInicialOrigem EstDisponivel,' +
      sLineBreak +
      '		     K.Qtde QtdMovimentada, K.SaldoFinalOrigem, vEndD.EnderecoId DestinoId,'
      + sLineBreak +
      '		     vEndD.Endereco Destino, K.SaldoInicialDestino, K.SaldoFinalDestino,'
      + sLineBreak +
      '	      U.usuarioid, U.nome Usuario, K.NomeEstacao Estacao,' + sLineBreak
      + '		     vEndO.Mascara MascaraOrigem, vEndD.Mascara MascaraDestino' +
      sLineBreak + 'From Kardex K' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.LoteId = K.LoteId' + sLineBreak +
      'Inner Join Produto Prd On Prd.IdProduto = Pl.Idproduto' + sLineBreak +
      'Left Join vEnderecamentos vEndO On vEndO.EnderecoId = K.EnderecoId' +
      sLineBreak +
      'Left Join vEnderecamentos vEndD On vEndD.EnderecoId = K.EnderecoIdDestino'
      + sLineBreak + 'Inner Join Rhema_Data DMov On DMov.IdData = K.Data' +
      sLineBreak + 'Inner Join Rhema_Hora HMov On HMov.IdHora = K.Hora' +
      sLineBreak + 'Inner Join Usuarios U on U.usuarioid = K.UsuarioId' +
      sLineBreak +
      'where (@Armazenagem = 0 or (K.EnderecoId = 1 And EnderecoIdDestino Is Not Null))'
      + sLineBreak +
      '      And (@MovInterna = 0 or (@MovInterna = 1 and K.EnderecoId <> 1 and K.EnderecoIdDestino is Not Null))'
      + sLineBreak + '      And (@DataInicial = 0 or Dmov.Data >= @DataInicial)'
      + sLineBreak + '      And (@DataFinal = 0 or Dmov.Data <= @DataFinal)' +
      sLineBreak + '      And (@UsuarioId = 0 or U.UsuarioId = @UsuarioId)' +
      sLineBreak + '      And (@EnderecoOrigem  = ' + #39 + #39 +
      ' Or vEndO.Endereco = @EnderecoOrigem)' + sLineBreak +
      '      And (@EnderecoDestino = ' + #39 + #39 +
      ' or vEndD.Endereco = @EnderecoDestino)' + sLineBreak +
      '	  And (@CodProduto = 0 or PL.CodProduto = @CodProduto)' + sLineBreak +
      'Order by DMov.Data, HMov.Hora';

  Const
    SqlGetAuditoriaSaidaPorProduto = 'Declare @Pedidoid Integer = :pPedidoId' +
      sLineBreak + 'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak
      + 'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @CodProduto Integer   = :pCodProduto' + sLineBreak +
      'Declare @DescrLote Varchar(30) = :pDescrLote' + sLineBreak +
      'Declare @Ressuprimento VarChar(20) = :pRessuprimento' + sLineBreak +
      'select Ped.DocumentoData Data, Ped.CodPessoaERP, Ped.Fantasia, Ped.PedidoId, Ped.DocumentoOriginal Ressuprimento,'
      + sLineBreak +
      '       Pe.Descricao Processo, Vl.CodProduto, Prd.Descricao, ' + #39 + #39
      + ' as DescrLote,' + sLineBreak + '	   Null as Vencimento,' + sLineBreak +
      '       Prd.EnderecoDescricao Endereco, Prd.Mascara, 0 as PedidoVolumeId, VL.QtdSuprida'
      + sLineBreak + 'from PedidoProdutos PP' + sLineBreak +
      'Inner Join vPedidos Ped On Ped.Pedidoid = PP.Pedidoid' + sLineBreak +
      'Left Join (Select PedidoId, Pl.IdProduto ProdutoId, Pl.CodProduto, Sum(QtdSuprida) QtdSuprida'
      + sLineBreak + '           From PedidoVolumeLotes Vl' + sLineBreak +
      '		   Inner join PedidoVolumes PV On Pv.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '		   Inner Join vProdutoLotes Pl on Pl.LoteId = Vl.LoteId' + sLineBreak
      + '           Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid' +
      sLineBreak +
      '		   Where De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + '             And De.ProcessoId <> 15' + sLineBreak +
      '			 And (@DescrLote = ' + #39 + #39 + ' or Pl.Lote = @DescrLote)' +
      sLineBreak +
      '		   Group by PedidoId, Pl.IdProduto, Pl.CodProduto) Vl On Vl.PedidoId = Ped.PedidoId And Vl.ProdutoId = Pp.ProdutoId'
      + sLineBreak +
      'Inner Join ProcessoEtapas Pe On Pe.ProcessoId = Ped.ProcessoId' +
      sLineBreak + 'inner join vProduto Prd on Prd.IdProduto = PP.ProdutoId' +
      sLineBreak +
      'Where (@DataInicial = 0 or Ped.DocumentoData >= @DataInicial)' +
      sLineBreak + '  And (@DataFinal = 0 or Ped.DocumentoData <= @DataFinal)' +
      sLineBreak + '  And (@PedidoId = 0 or @PedidoId = Ped.PedidoId)' +
      sLineBreak + '  And (@CodProduto = Vl.CodProduto)' + sLineBreak +
      '  And (@Ressuprimento = ' + #39 + #39 +
      ' or Ped.DocumentoOriginal = @Ressuprimento)' + sLineBreak +
      '  and Pe.ProcessoId Not In (15,31)' + sLineBreak +
      'Order by Vl.CodProduto, Ped.DocumentoData, Ped.Pedidoid';

    { 'select Rd.Data, Pes.CodPessoaERP, Pes.Fantasia, Ped.PedidoId, Ped.DocumentoOriginal Ressuprimento,'+sLineBreak+
      '       De.Descricao Processo, Prd.CodProduto, Prd.Descricao, Pl.DescrLote, Dv.Data Vencimento,'+sLineBreak+
      '       VEnd.Endereco, VEnd.Mascara, Pv.PedidoVolumeId, VL.QtdSuprida'+sLineBreak+
      //'       Count(Distinct Pv.PedidoVolumeId) QtdVolumes, Sum(VL.QtdSuprida) QtdSuprida'+sLineBreak+
      'from PedidoVolumeLotes Vl'+sLineBreak+
      'Inner Join PedidoVolumes Pv on pv.PedidoVolumeId = vl.PedidoVolumeId'+sLineBreak+
      'Inner Join Pedido Ped On Ped.Pedidoid = Pv.Pedidoid'+sLineBreak+
      'Inner Join Pessoa Pes On Pes.Pessoaid = Ped.Pessoaid'+sLineBreak+
      'Left Join RotaPessoas Rp On Rp.Pessoaid = Pes.pessoaId'+sLineBreak+
      'Inner Join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData'+sLineBreak+
      'Inner Join ProdutoLotes Pl on Pl.LoteId = Vl.LoteId'+sLineBreak+
      'Left Join Rhema_Data Df On Df.IdData = Pl.Fabricacao'+sLineBreak+
      'Left Join Rhema_Data Dv on Dv.IdData = Pl.Vencimento'+sLineBreak+
      'Inner join Produto Prd On Prd.IdProduto = Pl.ProdutoId'+sLineBreak+
      'Inner Join vEnderecamentos VEnd On VEnd.EnderecoId = Vl.EnderecoId'+sLineBreak+
      'Inner Join vDocumentoEtapas De on De.Documento = Pv.Uuid'+sLineBreak+
      'Where (@DataInicial = 0 or Rd.Data >= @DataInicial)'+sLineBreak+
      '  And (@PedidoId = 0 or @PedidoId = Ped.PedidoId)'+sLineBreak+
      '  And (@DataFinal  = 0 or Rd.Data <= @DataFinal)'+sLineBreak+
      '  And (@CodProduto = Prd.CodProduto)'+sLineBreak+
      '  And (@DescrLote = '+#39+#39+' or Pl.DescrLote = @DescrLote)'+sLineBreak+
      '  And (@Ressuprimento = '+#39+#39+' or Ped.DocumentoOriginal = @Ressuprimento)'+sLineBreak+
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'+sLineBreak+
      '  And De.ProcessoId <> 15 --and De.ProcessoId < 13'+sLineBreak+
      //'Group by Rd.Data, Pes.CodPessoaERP, Pes.Fantasia, Ped.PedidoId, Ped.DocumentoOriginal,'+sLineBreak+
      //'         De.Descricao, Prd.CodProduto, Prd.Descricao, Pl.DescrLote, Pl.Vencimento'+sLineBreak+
      'Order by Rd.Data, Prd.CodProduto, Ped.Pedidoid';
    }

  Const
    SqlDshCheckOut =
      'Declare @DataInicialPedido   DateTime = :pDataInicialPedido' + sLineBreak
      + 'Declare @DataFinalPedido     DateTime = :pDataFinalPedido' + sLineBreak
      + 'Declare @DataInicialProducao DateTime = :pDataInicialProducao' +
      sLineBreak + 'Declare @DataFinalProducao   DateTime = :pDataFinalProducao'
      + sLineBreak + 'Declare @UsuarioId   Integer  = :pUsuarioId' + sLineBreak
      + 'Declare @EmbalagemId Integer  = :pEmbalagemId' + sLineBreak +
      'Declare @ProcessoId Integer   = 10' + sLineBreak + 'Select *' +
      sLineBreak +
      'From (Select (Case When @DataInicialPedido <> 0 Then Rd.Data' +
      sLineBreak +
      '              Else De.Data End) Data, Pv.EmbalagemId, (Case When Pv.EmbalagemId = 0 then '
      + #39 + 'Cxa.Fechada' + #39 + ' Else ' + #39 + 'Fracionado' + #39 +
      ' End) Embalagem, U.UsuarioId, U.Nome,' + sLineBreak +
      '             (Case When Pv.EmbalagemId = 1 then CheckoutFracionadoMeta Else CheckoutCxaFechadaMeta End) CheckoutMeta,'
      + sLineBreak +
      '             (Case When Pv.EmbalagemId = 1 then CheckoutFracionadoTolerancia Else CheckoutCxaFechadaTolerancia End) CheckoutTolerancia,'
      + sLineBreak +
      '             Min(De.Horario) Inicio, Max(De.horario) Termino,' +
      sLineBreak + '             Count(Distinct Pv.PedidoId) TPedido,' +
      sLineBreak + '             Count(Distinct Pv.PedidoVolumeId) TVolume,' +
      sLineBreak + '	            Sum(Vl.Quantidade) Demanda,' + sLineBreak +
      '	            Sum(Vl.QtdSuprida) QtdSuprida' + sLineBreak +
      '      From PedidoVolumeLotes Vl' + sLineBreak +
      '      Inner Join (Select Pv.PedidoId, Pv.PedidoVolumeId, (Case When Pv.EmbalagemId Is Null then 0 Else 1 End) EmbalagemId, pv.Uuid'
      + sLineBreak + '                  From PedidoVolumes PV' + sLineBreak +
      '			               Inner Join vDocumentoEtapas Dpv On Dpv.Documento = Pv.Uuid'
      + sLineBreak +
      '			               Where Dpv.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '	                       And Dpv.ProcessoId <> 15) Pv On Pv.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '      Inner join vDocumentoEtapas De on De.Documento = Pv.Uuid And De.ProcessoId = @ProcessoId'
      + sLineBreak +
      '      Left Join vDocumentoEtapas Pe7 On Pe7.Documento = Pv.Uuid and Pe7.ProcessoId = 7 And Pe7.Status = 1'
      + sLineBreak +
      '      Left Join vDocumentoEtapas Pe8 On Pe8.Documento = Pv.Uuid and Pe8.ProcessoId = 8 And Pe8.Status = 1'
      + sLineBreak + '      Inner Join Pedido Ped On Ped.Pedidoid = Pv.Pedidoid'
      + sLineBreak + '      Inner Join Usuarios U On U.Usuarioid = De.UsuarioId'
      + sLineBreak +
      '      Inner Join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      '      Cross Apply (Select CheckoutFracionadoMeta From Configuracao) as CheckoutFracionadoMeta'
      + sLineBreak +
      '      Cross Apply (Select CheckoutCxaFechadaMeta From Configuracao) as CheckoutCxaFechadaMeta'
      + sLineBreak +
      '      Cross Apply (Select CheckoutFracionadoTolerancia From Configuracao) as CheckoutFracionadoTolerancia'
      + sLineBreak +
      '      Cross Apply (Select CheckoutCxaFechadaTolerancia From Configuracao) as CheckoutCxaFechadaTolerancia'
      + sLineBreak + '      where Ped.OperacaoTipoId = 2' + sLineBreak +
      '            And (@EmbalagemId = 99 or Pv.EmbalagemId = @EmbalagemId)' +
      sLineBreak +
      '   	        And (@UsuarioId = 0 or @UsuarioId = De.UsuarioId)' +
      sLineBreak +
      '	           And (@DataInicialPedido = 0 or Rd.Data >= @DataInicialPedido)'
      + sLineBreak +
      '	           And (@DataFinalPedido = 0 or Rd.Data <= @DataFinalPedido)' +
      sLineBreak +
      '	           And (@DataInicialProducao = 0 or De.Data >= @DataInicialProducao)'
      + sLineBreak +
      '	           And (@DataFinalProducao   = 0 or De.Data <= @DataFinalProducao)'
      + sLineBreak +
      '            And ((De.ProcessoId = 10 and ( (Coalesce(Pe7.Status,0)=1 and Coalesce(Pe8.Status,0)=1) or (Coalesce(Pe7.Status,0) = 0)))'
      + sLineBreak +
      '              Or (De.ProcessoId = 12 and (Coalesce(Pe7.Status,0)=1 and Coalesce(Pe8.Status,0)=0)) )'
      + sLineBreak +
      '      Group by (Case When @DataInicialPedido <> 0 Then Rd.Data' +
      sLineBreak +
      '                     Else De.Data End), Pv.EmbalagemId, U.UsuarioId, U.Nome,'
      + sLineBreak +
      '               CheckoutFracionadoMeta, CheckoutCxaFechadaMeta,' +
      sLineBreak +
      '               CheckoutFracionadoTolerancia, CheckoutCxaFechadaTolerancia) as Chk'
      + sLineBreak +
      'Cross Apply (Select CheckoutFracionadoMeta From Configuracao) as CheckoutFracionadoMeta'
      + sLineBreak +
      'Cross Apply (Select CheckoutCxaFechadaMeta From Configuracao) as CheckoutCxaFechadaMeta'
      + sLineBreak +
      'Cross Apply (Select CheckoutFracionadoTolerancia From Configuracao) as CheckoutFracionadoTolerancia'
      + sLineBreak +
      'Cross Apply (Select CheckoutCxaFechadaTolerancia From Configuracao) as CheckoutCxaFechadaTolerancia'
      + sLineBreak + 'Order by Data, Nome, EmbalagemId';

  Const
    SqlRelEtqArmazenagemResumo = 'Declare @Pedidoid Integer = :pPedidoId' +
      sLineBreak + 'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' +
      sLineBreak + 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Declare @DtInicio  DateTime = :pDtInicio' + sLineBreak +
      'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'select Ped.PedidoId, Ped.DocumentoNr, FORMAT(Rd.Data, ' + #39 +
      'dd/MM/yyyy' + #39 + ') Data, Pes.CodPessoaERP, Pes.Razao, Pes.Fantasia,'
      + sLineBreak +
      '       Count(Distinct Itens.CodProduto) QtdItens, SUM(Itens.Quantidade) Quantidade'
      + sLineBreak + 'from Pedido Ped' + sLineBreak +
      'Inner join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Inner join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Inner Join (Select Pi.PedidoId, Prd.CodProduto, Prd.Descricao, ' +
      sLineBreak +
      '                   Prd.FatorConversao, Pl.LoteId, Pl.DescrLote, FORMAT(Df.Data, '
      + #39 + 'dd/MM/yyyy' + #39 + ') Fabricacao,' + sLineBreak +
      '                   FORMAT(Dv.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
      ') Vencimento, (Pi.QtdCheckIn+Pi.QtdDevolvida+Pi.QtdSegregada) Quantidade,'
      + sLineBreak +
      '				               Prd.EnderecoDescricao Endereco, Prd.ZonaId, Prd.ZonaDescricao Zona, Prd.Mascara'
      + sLineBreak + '            From PedidoItens Pi' + sLineBreak +
      '			Inner Join ProdutoLotes Pl On Pl.Loteid = Pi.Loteid' + sLineBreak
      + '			Inner Join vProduto Prd on Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak + '			Inner Join Rhema_Data DF on DF.IdData = Pl.Fabricacao'
      + sLineBreak +
      '			Inner Join Rhema_Data DV on Dv.IdData = Pl.Vencimento' + sLineBreak
      + '			Where QtdCheckIn > 0 and Prd.EnderecoId Is Not Null' + sLineBreak
      + '			      And (@ZonaId = 0 or Prd.ZonaID = @ZonaId) ) Itens On Itens.Pedidoid = Ped.PedidoId'
      + sLineBreak + 'where Ped.OperacaoTipoId = 3' + sLineBreak +
      '      And (@Pedidoid = 0 or Ped.PedidoId = @Pedidoid)' + sLineBreak +
      '   	  And (@CodProduto = 0 or Itens.CodProduto = @CodProduto)' +
      sLineBreak + '	     And (@DocumentoNr = ' + #39 + #39 +
      ' or Ped.DocumentoNr = @DocumentoNr)' + sLineBreak +
      '      And (@DtInicio = 0 or Rd.Data >= @DtInicio)' + sLineBreak +
      '      And (@DtTermino = 0 or Rd.Data <= @DtTermino)' + sLineBreak +
      'Group by Ped.PedidoId, Ped.DocumentoNr,  Rd.Data, Pes.CodPessoaERP, Pes.Razao, Pes.Fantasia'
      + sLineBreak + 'Order By Ped.PedidoId';

  Const
    SqlRelEtiquetaArmazenagem = 'Declare @Pedidoid Integer = :pPedidoId' +
      sLineBreak + 'Declare @DocumentoNr VarChar(20) = :pDocumentoNr' +
      sLineBreak + 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'Declare @DtInicio  DateTime = :pDtInicio' + sLineBreak +
      'Declare @DtTermino DateTime = :pDtTermino' + sLineBreak +
      'select Ped.PedidoId, Ped.DocumentoNr,FORMAT(Rd.Data, ' + #39 +
      'dd/MM/yyyy' + #39 +
      ') Data, Pes.CodPessoaERP, Pes.Razao, Pes.Fantasia, Itens.*' + sLineBreak
      + 'from Pedido Ped' + sLineBreak +
      'Inner join Pessoa Pes On Pes.PessoaId = Ped.PessoaId' + sLineBreak +
      'Inner join Rhema_Data Rd On Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Inner Join (Select Pi.PedidoId, Prd.CodProduto, Prd.Descricao, Prd.FatorConversao, Pl.LoteId, Pl.DescrLote, FORMAT(Df.Data, '
      + #39 + 'dd/MM/yyyy' + #39 + ') Fabricacao,' + sLineBreak +
      '                   FORMAT(Dv.Data, ' + #39 + 'dd/MM/yyyy' + #39 +
      ') Vencimento, (Pi.QtdCheckIn+Pi.QtdDevolvida+Pi.QtdSegregada) Quantidade, '
      + sLineBreak +
      '				               (Case When Prd.FatorConversao > 1 then' +
      sLineBreak +
      '				                       (Pi.QtdCheckIn+Pi.QtdDevolvida+Pi.QtdSegregada)/Prd.FatorConversao'
      + sLineBreak + '						                   Else 0 End) QtdCxaFechada,'
      + sLineBreak +
      '				               (Case When Prd.FatorConversao > 1 then' +
      sLineBreak +
      '				                       (Pi.QtdCheckIn+Pi.QtdDevolvida+Pi.QtdSegregada) % Prd.FatorConversao'
      + sLineBreak +
      '						                   Else (Pi.QtdCheckIn+Pi.QtdDevolvida+Pi.QtdSegregada) End) QtdFracionada,'
      + sLineBreak +
      '				               Prd.EnderecoDescricao Endereco, Prd.ZonaId, Prd.ZonaDescricao Zona, Prd.Mascara'
      + sLineBreak + '            From PedidoItens Pi' + sLineBreak +
      '			Inner Join ProdutoLotes Pl On Pl.Loteid = Pi.Loteid' + sLineBreak
      + '			Inner Join vProduto Prd on Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak + '			Inner Join Rhema_Data DF on DF.IdData = Pl.Fabricacao'
      + sLineBreak +
      '			Inner Join Rhema_Data DV on Dv.IdData = Pl.Vencimento' + sLineBreak
      + '			Where QtdCheckIn > 0 and Prd.EnderecoId Is Not Null' + sLineBreak
      + '         And (@ZonaId = 0 or Prd.ZonaID = @ZonaId) ) Itens On Itens.Pedidoid = Ped.PedidoId'
      + sLineBreak + 'where Ped.OperacaoTipoId = 3' + sLineBreak +
      '      And (@Pedidoid = 0 or Ped.PedidoId = @Pedidoid)' + sLineBreak +
      '	     And (@CodProduto = 0 or Itens.CodProduto = @CodProduto)' +
      sLineBreak + '	     And (@DocumentoNr = ' + #39 + #39 +
      ' or Ped.DocumentoNr = @DocumentoNr)' + sLineBreak +
      '      And (@DtInicio = 0 or Rd.Data >= @DtInicio)' + sLineBreak +
      '      And (@DtTermino = 0 or Rd.Data <= @DtTermino)' + sLineBreak +
      'Order By Ped.PedidoId, Itens.CodProduto, Itens.DescrLote';

  Const
    GetDesempenhoExpedicao =
      'Declare @DataPedidoInicial DateTime   = :pDataPedidoInicial' + sLineBreak
      + 'Declare @DataPedidoFinal DateTime     = :pDataPedidoFinal' + sLineBreak
      + 'Declare @DataProducaoInicial DateTime = :pDataProducaoInicial' +
      sLineBreak + 'Declare @DataProducaoFinal DateTime   = :pDataProducaoFinal'
      + sLineBreak + 'Declare @UsuarioId Integer            = :pUsuarioId' +
      sLineBreak +
      'Declare @Analise Integer              = :pAnalise --  0 - Data Pedido   1 - DataProdu��o'
      + sLineBreak + 'Declare @EmbalagemId Integer          = :pEmbalagemId' +
      sLineBreak + 'Select *' + sLineBreak +
      'From (SELECT(Case When @Analise = 0 then Rd.Data --AS DataPedido,' +
      sLineBreak +
      '             When @Analise = 1 then CAST(De.Horario AS Date) --AS DataProducao,'
      + sLineBreak + '		    End) Data,' + sLineBreak +
      '	   De.UsuarioId, U.nome, COUNT(DISTINCT PV.PedidoVolumeId) AS QtdVolume,'
      + sLineBreak +
      '	   SUM(Vl.Quantidade) AS Demanda, SUM(Vl.QtdSuprida) AS Expedido,' +
      sLineBreak +
      '       MIN(De.Horario) AS Inicio, MAX(De.Horario) AS Termino,' +
      sLineBreak +
      '	   CONVERT(VARCHAR, DATEDIFF(DAY, MIN(De.Horario), MAX(De.Horario)))' +
      sLineBreak + '              + ' + #39 + 'd ' + #39 + ' + RIGHT(' + #39 +
      '00' + #39 + ' + CONVERT(VARCHAR, DATEDIFF(MINUTE,' + sLineBreak +
      '			  CAST(MIN(De.Horario) AS Time), CAST(MAX(De.Horario) AS Time)) / 60), 2) + '
      + #39 + ':' + #39 + ' +' + sLineBreak + '			  RIGHT(' + #39 + '00' + #39
      + ' + CONVERT(VARCHAR, DATEDIFF(MINUTE, CAST(MIN(De.Horario) AS Time),' +
      sLineBreak + '			  CAST(MAX(De.Horario) AS Time)) % 60), 2) + ' + #39 +
      ':' + #39 + ' + RIGHT(' + #39 + '00' + #39 + ' + CONVERT(VARCHAR,' +
      sLineBreak +
      '			  DATEDIFF(SECOND, CAST(MIN(De.Horario) AS Time), CAST(MAX(De.Horario) AS Time)) % 60),'
      + sLineBreak + '			  2) AS HoraTrabalhada' + sLineBreak +
      'FROM dbo.PedidoVolumeLotes AS Vl' + sLineBreak +
      '     INNER JOIN dbo.PedidoVolumes AS PV ON PV.PedidoVolumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '     INNER JOIN dbo.Pedido AS Ped ON Ped.PedidoId = PV.PedidoId' +
      sLineBreak +
      '     INNER JOIN dbo.Rhema_Data AS Rd ON Rd.IdData = Ped.DocumentoData' +
      sLineBreak +
      '     INNER JOIN dbo.vDocumentoEtapas AS De ON De.Documento = PV.uuid' +
      sLineBreak +
      '     INNER JOIN dbo.vEnderecamentos AS vEnd ON vEnd.EnderecoId = Vl.EnderecoId'
      + sLineBreak +
      '     INNER JOIN dbo.usuarios AS U ON U.usuarioid = De.UsuarioId' +
      sLineBreak + 'WHERE (De.Horario = (SELECT MAX(Horario)' + sLineBreak +
      '                     FROM dbo.vDocumentoEtapas' + sLineBreak +
      '                     WHERE (Documento = PV.uuid) AND (Status = 1)))' +
      sLineBreak + '	     AND (De.ProcessoId = 13)' + sLineBreak +
      '      And (@UsuarioId = 0 or U.usuarioid = @UsuarioId)' + sLineBreak +
      '      And (@DataPedidoInicial = 0 or  Rd.Data >= @DataPedidoInicial)' +
      sLineBreak +
      '	     And (@DataPedidoFinal   = 0 or  Rd.Data <= @DataPedidoFinal)' +
      sLineBreak +
      '      And (@DataProducaoInicial = 0 or  CAST(De.Horario AS Date) >= @DataProducaoInicial)'
      + sLineBreak +
      '	     And (@DataProducaoFinal   = 0 or  CAST(De.Horario AS Date) <= @DataProducaoFinal)'
      + sLineBreak +
      '	     And (@EmbalagemId = 99 or (@EmbalagemId=0 and Coalesce(PV.EmbalagemId, 0)=0) or'
      + sLineBreak +
      '                                (@EmbalagemId=1 and Coalesce(PV.EmbalagemId, 0)<>0) )'
      + sLineBreak + 'GROUP BY (Case When @Analise = 0 then Rd.Data' +
      sLineBreak +
      '             When @Analise = 1 then CAST(De.Horario AS Date)' +
      sLineBreak + '		        End),' + sLineBreak +
      '		    De.UsuarioId, U.nome) vDesempenhoExpedicao' + sLineBreak +
      'Cross Apply (select ExpedicaoMeta As Meta From Configuracao) as Meta' +
      sLineBreak +
      'Cross Apply (Select ExpedicaoTolerancia as Tolerancia From Configuracao) as Tolerancia'
      + sLineBreak + 'Order BY Data, nome';

  Const
    SqlDshRecebimentos = 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      ';With' + sLineBreak + 'Ped as (Select Ped.PedidoId, Ped.Status' +
      sLineBreak +
      '        , Sum(Case When De.Processoid < 5 Then 1 Else 0 End) PedPendente'
      + sLineBreak +
      '        , Sum(Case When D.Processoid Is Not Null Then 1 Else 0 End) PedCancelado'
      + sLineBreak + '        From vPedidos Ped' + sLineBreak +
      '        Inner Join vDocumentoEtapas DE On De.Documento = Ped.Uuid' +
      sLineBreak +
      '        Left Join DocumentoEtapas D ON D.Documento = Ped.uuid and D.ProcessoId = 15 and D.Status = 1'
      + sLineBreak + '        Where Ped.OperacaoTipoId = 3' + sLineBreak +
      '	          And Ped.DocumentoData >= @DataInicial and Ped.DocumentoData <= @DataFinal'
      + sLineBreak +
      '              And De.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '		Group by Ped.PedidoId, Ped.Status),' + sLineBreak +
      'TotCheckIn as (Select PI.PedidoId, Sum(Distinct PedCancelado) PedCancelado,'
      + sLineBreak + '               Sum(Distinct PedPendente) PedPendente, ' +
      sLineBreak +
      '               Coalesce(Sum((Case When p2.ProcessoId <> 31 then QtdXML Else 0 End)), 0) QtdXml,'
      + sLineBreak +
      '               Coalesce(Sum((Case When p2.ProcessoId <> 31 then QtdCheckIn Else 0 End)), 0) QtdCheckIn,'
      + sLineBreak +
      '               Coalesce(Sum((Case When p2.ProcessoId <> 31 then QtdDevolvida Else 0 End)), 0) QtdDevolvida,'
      + sLineBreak +
      '               Coalesce(Sum((Case When p2.ProcessoId <> 31 then QtdSegregada Else 0 End)), 0) QtdSegregada'
      + sLineBreak +
      '             , (Case When p2.ProcessoId = 31 then SUM(QtdXml) Else 0 End) QtdCancelado'
      + sLineBreak + 'From PedidoItens PI' + sLineBreak +
      'Inner Join Ped P ON P.PedidoId = PI.PedidoId' + sLineBreak +
      'Inner Join vPedidos P2 On P2.PedidoId = Pi.PedidoId' + sLineBreak +
      'Group by PI.PedidoId, P2.ProcessoId)' + sLineBreak + '' + sLineBreak +
      'Select Count(Distinct Tc.Pedidoid) TotPedido, Sum(Distinct PedCancelado) PedCancelado, '
      + sLineBreak +
      '       SUM(PedPendente) PedPendente, Sum(TC.QtdXml) QtdXml, Sum(QtdCheckIn) QtdCheckIn,'
      + sLineBreak +
      '       Sum(QtdDevolvida) QtdDevolvida, SUM(QtdSegregada) QtdSegregada,' +
      sLineBreak + '	   Sum(QtdCancelado) QtdCancelado' + sLineBreak +
      'From TotCheckIn TC';

  Const
    SqlRelAtendimentoRota = 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal   DateTime = :pDataFinal' + sLineBreak +
      'select Rp.rotaid, R.Descricao Rota,' + sLineBreak +
      '       Sum(case When Pv.EmbalagemId Is Null then 1 Else 0 End) CxaFechada,'
      + sLineBreak +
      '       Sum(case When Pv.EmbalagemId Is Not Null then 1 Else 0 End) Fracionado,'
      + sLineBreak +
      '       Sum(Pp.Quantidade) Demanda, SUM(Vl.QtdSuprida) QtdSuprida' +
      sLineBreak + '     --, Cast(SUM(Cast(Vl.QtdSuprida as Decimal(15,3)) /' +
      sLineBreak +
      '	    --        Cast(Pp.Quantidade as Decimal(15,3)))*100 as Decimal(15,2)) As PercAtendimento'
      + sLineBreak + 'From PedidoProdutos Pp' + sLineBreak +
      'Inner Join Pedido Ped on Ped.PedidoId = PP.PedidoId' + sLineBreak +
      'Inner Join PedidoVolumes Pv ON Pv.PedidoId = PP.PedidoId' + sLineBreak +
      'Inner join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Left Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join RotaPessoas Rp On Rp.pessoaid = Ped.PessoaId' +
      sLineBreak + 'Inner join Rotas R On R.RotaId = Rp.rotaid' + sLineBreak +
      'where Rd.Data Between @DataInicial and @DataFinal' + sLineBreak +
      'Group By Rp.rotaid, R.Descricao' + sLineBreak + 'Order by R.Descricao';

  Const
    SqlRelAtendimentoDestinatario =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal   DateTime = :pDataFinal' + sLineBreak +
      'select P.CodPessoaERP CodPessoa, P.Fantasia,' + sLineBreak +
      '       Sum(case When Pv.EmbalagemId Is Null then 1 Else 0 End) CxaFechada,'
      + sLineBreak +
      '       Sum(case When Pv.EmbalagemId Is Not Null then 1 Else 0 End) Fracionado,'
      + sLineBreak +
      '       Sum(Pp.Quantidade) Demanda, SUM(Vl.QtdSuprida) QtdSuprida' +
      sLineBreak + '       --Cast(SUM(Cast(Vl.QtdSuprida as Decimal(15,3)) /' +
      sLineBreak +
      '	      --      Cast(Pp.Quantidade as Decimal(15,3)))*100 as Decimal(15,2)) As PercAtendimento'
      + sLineBreak + 'From PedidoProdutos Pp' + sLineBreak +
      'Inner Join Pedido Ped on Ped.PedidoId = PP.PedidoId' + sLineBreak +
      'Inner Join Pessoa P ON P.PessoaId = Ped.PessoaId' + sLineBreak +
      'Inner Join PedidoVolumes Pv ON Pv.PedidoId = PP.PedidoId' + sLineBreak +
      'Inner join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Left Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'where Rd.Data Between @DataInicial and @DataFinal' +
      sLineBreak + 'Group By P.CodPessoaERP, P.Fantasia';

  Const
    SqlRelAtendimentoZona = 'Declare @DataInicial DateTime = :pDataInicial' +
      sLineBreak + 'Declare @DataFinal   DateTime = :pDataFinal' + sLineBreak +
      'select Prd.ZonaId, (Case When Prd.ZonaId is Null then ' + #39 +
      'N�o Definida' + #39 + ' Else Prd.ZonaDescricao End) Zona,' + sLineBreak +
      '       Sum(case When Pv.EmbalagemId Is Null then 1 Else 0 End) CxaFechada,'
      + sLineBreak +
      '       Sum(case When Pv.EmbalagemId Is Not Null then 1 Else 0 End) Fracionado,'
      + sLineBreak +
      '       Sum(Pp.Quantidade) Demanda, SUM(Vl.QtdSuprida) QtdSuprida' +
      sLineBreak + '       --Cast(SUM(Cast(Vl.QtdSuprida as Decimal(15,3)) /' +
      sLineBreak +
      '	      --      Cast(Pp.Quantidade as Decimal(15,3)))*100 as Decimal(15,2)) As PercAtendimento'
      + sLineBreak + 'From PedidoProdutos Pp' + sLineBreak +
      'Inner Join Pedido Ped on Ped.PedidoId = PP.PedidoId' + sLineBreak +
      'Inner Join PedidoVolumes Pv ON Pv.PedidoId = PP.PedidoId' + sLineBreak +
      'Inner join Rhema_Data Rd on Rd.IdData = Ped.DocumentoData' + sLineBreak +
      'Left Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId' +
      sLineBreak + 'Left Join vProduto Prd on Prd.IdProduto = Pl.ProdutoId' +
      sLineBreak + 'where Rd.Data Between @DataInicial and @DataFinal' +
      sLineBreak + 'Group By Prd.ZonaId, Prd.ZonaDescricao';

  Const
    SqlGetAgrupamentoLista = 'Declare @AgrupamentoId Integer = :pAgrupamentoId'
      + sLineBreak + 'Declare @CodPessoaERP Integer  = :pCodPessoaERP' +
      sLineBreak + 'Declare @Pessoaid Integer = (Select PessoaId From Pessoa' +
      sLineBreak +
      '                             where CodPessoaERP = @CodPessoaERP And PessoaTipoId = 1)'
      + sLineBreak + 'select Pa.agrupamentoid, Pn.CodPessoaERP, Pn.Fantasia,' +
      sLineBreak +
      '       Pa.UsuarioId, U.nome Usuario, data, CONVERT(VARCHAR, hora ,8) as hora, Terminal'
      + sLineBreak + 'from PedidoAgrupamento Pa' + sLineBreak +
      'Left Join (Select Pn.AgrupamentoId, vp.CodPessoaERP, Vp.Fantasia' +
      sLineBreak + '            From PedidoAgrupamentoNotas Pn' + sLineBreak +
      '            Inner Join vPedidos Vp On Vp.PedidoId = Pn.PedidoId' +
      sLineBreak +
      '			Group by Pn.AgrupamentoId, vp.CodPessoaERP, Vp.Fantasia) Pn  On Pn.AgrupamentoId = Pa.agrupamentoid'
      + sLineBreak + 'Inner Join usuarios U On U.usuarioid = Pa.UsuarioId' +
      sLineBreak + 'where (@AgrupamentoId=0 or Pa.agrupamentoid=@AgrupamentoId)'
      + sLineBreak +
      '  And (@CodPessoaERP=0 or Pn.CodPessoaERP = @CodPessoaERP)';

  Const
    SqlGetAgrupamentoPedidos =
      'Declare @AgrupamentoId Integer = :pAgrupamentoId' + sLineBreak +
      'Declare @CodPessoaERP Integer  = :pCodPessoaERP' + sLineBreak +
      'Declare @Pessoaid Integer = (Select PessoaId From Pessoa' + sLineBreak +
      '                             where CodPessoaERP = @CodPessoaERP And PessoaTipoId = 1)'
      + sLineBreak +
      'select Pa.agrupamentoid, Pn.Pedidoid, Vp.DocumentoNr, Vp.DocumentoOriginal, '
      + sLineBreak + '       Vp.DocumentoData, Vp.CodPessoaERP, Vp.Fantasia' +
      sLineBreak + 'from PedidoAgrupamento Pa' + sLineBreak +
      'Inner Join PedidoAgrupamentoNotas Pn On Pn.AgrupamentoId = Pa.agrupamentoid'
      + sLineBreak + 'Inner Join vPedidos Vp On Vp.PedidoId = Pn.PedidoId' +
      sLineBreak + 'where (@AgrupamentoId=0 or Pa.agrupamentoid=@AgrupamentoId)'
      + sLineBreak +
      '  And (@CodPessoaERP=0 or Vp.CodPessoaERP = @CodPessoaERP)';

  Const
    SqlRelMovimentacaoInterna =
      'Declare @DataMovimentacao DateTime = :pDataMovimentacao' + sLineBreak +
      'Declare @UsuarioId Integer = :pUsuarioId' + sLineBreak +
      'Declare @EnderecoOrigem  Varchar(11) = :pEnderecoOrigem' + sLineBreak +
      'Declare @EnderecoDestino Varchar(11) = :pEnderecoDestino' + sLineBreak +
      'Declare @CodProduto Integer = :pCodProduto' + sLineBreak +
      'select Rd.Data, K.LoteId, Pl.Lote, EO.EnderecoId OrigemId, EO.Descricao EnderecoOrigem,'
      + sLineBreak +
      '       ED.EnderecoId DestinoId, ED.Descricao EnderecoDestino,' +
      sLineBreak +
      '	   K.SaldoInicialOrigem, K.Qtde QtdMovimentada, SaldoFinalOrigem,' +
      sLineBreak +
      '	   SaldoInicialDestino, SaldoFinalDestino, K.UsuarioId, U.nome,' +
      sLineBreak + '	   K.NomeEstacao' + sLineBreak + 'from Kardex K' +
      sLineBreak + 'Inner Join vProdutoLotes Pl On Pl.LoteId = K.LoteId' +
      sLineBreak +
      'Inner Join Enderecamentos EO On EO.EnderecoId = K.EnderecoId' +
      sLineBreak +
      'Inner Join Enderecamentos ED On ED.EnderecoId = K.EnderecoIdDestino' +
      sLineBreak + 'Inner Join Rhema_Data Rd On Rd.IdData = K.Data' + sLineBreak
      + 'Inner join usuarios U On U.usuarioid = K.UsuarioId' + sLineBreak +
      'where (@DataMovimentacao = 0 or Rd.Data = @DataMovimentacao)' +
      sLineBreak + '      And (@EnderecoOrigem  = ' + #39 + #39 +
      ' or Eo.EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = @EnderecoOrigem))'
      + sLineBreak + '      And (@EnderecoDestino = ' + #39 + #39 +
      ' or ED.EnderecoId = (Select EnderecoId From Enderecamentos Where Descricao = @EnderecoDestino))'
      + sLineBreak + '      And (@UsuarioId = 0 or U.usuarioid = @UsuarioId)' +
      sLineBreak +
      '      And (@EnderecoOrigem  = '' Or EO.Descricao = @EnderecoOrigem)' +
      sLineBreak +
      '      And (@EnderecoDestino = '' or ED.Descricao = @EnderecoDestino)' +
      sLineBreak + '      And (@CodProduto = 0 or Pl.CodProduto = @CodProduto)'
      + sLineBreak + '   	  And K.ObservacaoOrigem Like ' + #39 +
      'Movimenta��o interna%' + #39;

  Const
    SqlGetdshvolumeevolucao_quantidade = 'Declare @DataPedido Date = :pData' +
      sLineBreak + 'Declare @ZonaId Integer = :pZonaId' + sLineBreak +
      'Declare @RotaId Integer = :pRotaId' + sLineBreak +
      'Declare @PessoaId Integer = Coalesce((Select PessoaId From Pessoa Where CodPessoaERP = :pCodPessoaERP and PessoaTipoID = 1), 0)'
      + sLineBreak +
      'select Ped.DocumentoData, De.ProcessoId, De.Descricao Processo' +
      sLineBreak + '       , Count(*) totalVolume' + sLineBreak +
      'From (Select Vl.PedidoVolumeId, Pv.PedidoId, Pv.Uuid' + sLineBreak +
      '      From PedidoVolumeLotes Vl' + sLineBreak +
      '      Inner join PedidoVolumes Pv On Pv.PedidoVOlumeId = Vl.PedidoVolumeId'
      + sLineBreak +
      '	  Left Join Enderecamentos Tend ON TEnd.EnderecoId = Vl.EnderecoId' +
      sLineBreak + '	  Where (@ZonaId = 0 or @ZonaId = TEnd.ZonaId)' +
      sLineBreak + '      Group By Vl.PedidoVolumeid, Pv.PedidoId, Pv.Uuid) Pv'
      + sLineBreak + 'Inner Join vPedidos Ped On Ped.PedidoId = Pv.PedidoId' +
      sLineBreak +
      '--Inner Join Pessoa Pes On Pes.PessoaId = Ped.PessoaId and Pes.PessoaTipoID = 1'
      + sLineBreak +
      '--Left join RotaPessoas Rp on Rp.rotapessoaid = Pes.PessoaId' +
      sLineBreak + 'Inner Join vDocumentoEtapas De On De.Documento = Pv.uuid' +
      sLineBreak + 'Where Ped.DocumentoData = @DataPedido And' + sLineBreak +
      '      (@RotaId = 0 or Ped.rotaid = @RotaId) And' + sLineBreak +
      '	  (@PessoaId = 0 or Ped.PessoaId = @PessoaId) And' + sLineBreak +
      '   DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + 'Group by Ped.DocumentoData, De.ProcessoId, De.Descricao' +
      sLineBreak + 'Order by Ped.DocumentoData, De.ProcessoId, De.Descricao';

  Const
    SqlGetProdutoTagByProduto =
      'Declare @TagProdutoSNGPC integer = (Select TagProdutoEntrada From Configuracao)'
      + sLineBreak + 'Declare @PedidoId Integer = :pPedidoId' + sLineBreak +
      'Declare @DocumentoNr VarChar(20) = :pDocumentoNr;' + sLineBreak +
      'Declare @RegistroERP VarChar(26) = :pRegistroERP' + sLineBreak +
      'Declare @DtDocumentoData DateTime= :pDtDocumentoData;' + sLineBreak +
      'Declare @DtCheckInFinalizacao DateTime = :pDtCheckInFinalizacao;' +
      sLineBreak + 'Declare @CodigoERP Integer = :pCodigoERP' + sLineBreak +
      'select 0 as PedidoId, Null as DocumentoData, Pl.IdProduto ProdutoId,' +
      sLineBreak +
      '       Prd.CodProduto CodigoERP, Prd.Descricao DescrProduto,' +
      sLineBreak +
      '       Prd.FatorConversao Embalagem, Prd.EnderecoDescricao Picking, Prd.Mascara,'
      + sLineBreak + '       Pl.LoteId,Pl.Lote DescrLote, Pl.Vencimento,' +
      sLineBreak + '       Est.Qtde QtdCheckIn, 0 As PrintEtqControlado' +
      sLineBreak + 'From vProduto Prd' + sLineBreak +
      'Inner Join vProdutoLotes Pl On Pl.IdProduto = Prd.IdProduto' + sLineBreak
      + 'Inner Join (Select LoteId, Sum(Qtde) Qtde' + sLineBreak +
      '            From Estoque' + sLineBreak +
      '            Where EstoqueTipoId in (1,4)' + sLineBreak +
      '			         Group by LoteId) est on est.LoteId = Pl.Loteid' +
      sLineBreak +
      'WHERE ( (@TagProdutoSNGPC=1) or (@TagProdutoSNGPC=2 and Prd.ProdutoSNGPC=1)'
      + sLineBreak + '   or (@TagProdutoSNGPC=3 and Prd.SNGPC=1) )' + sLineBreak
      + '  And (@CodigoERP = 0 or @CodigoERP = Prd.CodProduto)' + sLineBreak +
      'Order by Prd.Descricao, Pl.Vencimento';

    // SqlGetRelReposicaoResumoSintetico N�o Usado
  Const
    SqlGetRelReposicaoResumoSintetico =
      'Declare @ReposicaoId  Integer  = :pReposicaoId' + sLineBreak +
      'Declare @DataInicial  DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal    DateTime = :pDataFinal' + sLineBreak +
      'Declare @ProcessoId   Integer  = :pProcessoId' + sLineBreak +
      'Declare @Pendente     Integer  = :pPendente' + sLineBreak +
      'select Rep.ReposicaoId, Rep.DtReposicao, Cast(DtRessuprimento as Date) DtRessuprimento,'
      + sLineBreak +
      '       Pe.Descricao Processo, (Case When ReposicaoTipo = 1 Then ' + #39 +
      'Demanda' + #39 + sLineBreak +
      '	                                   When ReposicaoTipo = 2 Then ' + #39 +
      'Capacidade' + #39 + sLineBreak +
      '									                           When ReposicaoTipo = 3 Then '
      + #39 + 'Autom�tica' + #39 + ' End) Tipo,' + sLineBreak +
      '       Z.Descricao Zona, Rep.EnderecoInicial, Rep.EnderecoFinal,' +
      sLineBreak + '	      Rep.UsuarioId, U.Nome, Rep.Terminal' + sLineBreak +
      'From reposicao Rep' + sLineBreak +
      'Inner Join ProcessoEtapas Pe on Pe.ProcessoId = Rep.ProcessoId' +
      sLineBreak + 'Inner Join Usuarios U On U.UsuarioId = Rep.UsuarioId' +
      sLineBreak + 'Left Join EnderecamentoZonas Z On Z.ZonaId = Rep.ZonaId' +
      sLineBreak + 'Where (@ReposicaoId = 0 or Rep.ReposicaoId = @ReposicaoId)'
      + sLineBreak +
      '  And (@DataInicial = 0 or Rep.DtReposicao >= @DataInicial)' + sLineBreak
      + '  And (@DataFinal   = 0 or Rep.DtReposicao <= @DataFinal)' + sLineBreak
      + '  And (@ProcessoId = 0 or Rep.ProcessoId = @ReposicaoId)' + sLineBreak
      + '  And (@Pendente = 0 or Rep.ProcessoId in (27, 28))';

    // SqlGetRelReposicaoResumoAnalitico N�o Usado
  Const
    SqlGetRelReposicaoResumoAnalitico =
      'Declare @ReposicaoId  Integer  = :pReposicaoId' + sLineBreak +
      'Declare @DataInicial  DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal    DateTime = :pDataFinal' + sLineBreak +
      'Declare @ProcessoId   Integer  = :pProcessoId' + sLineBreak +
      'Declare @Pendente     Integer  = :pPendente' + sLineBreak +
      'select Rep.ReposicaoId, Rec.CodProduto, Rec.Descricao, Rec.Endereco Picking,'
      + sLineBreak + '       Rec.Demanda, Rec.QtdReposicao' + sLineBreak +
      'From reposicao Rep' + sLineBreak +
      'Inner Join ProcessoEtapas Pe on Pe.ProcessoId = Rep.ProcessoId' +
      sLineBreak + 'Left Join EnderecamentoZonas Z On Z.ZonaId = Rep.ZonaId' +
      sLineBreak +
      'Inner Join (Select R.ReposicaoId, Pl.CodProduto, Pl.Descricao, Pl.Endereco,'
      + sLineBreak + '            Sum(Qtde) Demanda, Sum(QtdRepo) QtdReposicao'
      + sLineBreak + '            From ReposicaoEnderecoColeta R' +
      sLineBreak + '			Inner join vProdutoLotes Pl On Pl.LoteId = R.LoteId' +
      sLineBreak +
      '			Group By R.ReposicaoId, Pl.CodProduto, Pl.Descricao, Pl.Endereco) Rec On Rec.ReposicaoId = Rep.ReposicaoId'
      + sLineBreak +
      'Where (@ReposicaoId = 0 or Rep.ReposicaoId = @ReposicaoId)' + sLineBreak
      + '  And (@DataInicial = 0 or Rep.DtReposicao >= @DataInicial)' +
      sLineBreak + '  And (@DataFinal   = 0 or Rep.DtReposicao <= @DataFinal)' +
      sLineBreak + '  And (@ProcessoId = 0 or Rep.ProcessoId = @ReposicaoId)' +
      sLineBreak + '  And (@Pendente = 0 or Rep.ProcessoId in (27, 28))';

  Const
    SqlRelReposicaoAnalise = 'Declare @ReposicaoId Integer  = :pReposicaoId' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak+
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @Pendente Integer     = :pPendente' + sLineBreak +
      'Declare @UsuarioId Integer    = :pUsuarioId' + sLineBreak +
      'Declare @Divergencia Integer  = :pDivergencia' + sLineBreak +
      'Declare @NaoColetado Integer  = :pNaoColetado' + sLineBreak +
      'Declare @CodProduto Integer   = :pCodProduto' + sLineBreak +
      'Declare @ZonaId Integer       = :pZonaId' + sLineBreak +
      'Declare @ProcessoId Integer   = :pProcessoId'+sLineBreak+
      'select RC.reposicaoid, Pl.CodProduto, Pl.Descricao, Pl.Endereco Picking,' + sLineBreak +
      '       Rc.EnderecoId, TEnd.Descricao PalletColeta, RC.LoteId, Pl.Lote, ' + sLineBreak +
      '       Pl.Data Fabricacao, Pl.Vencimento, Pl.Lote,  RC.Qtde Demanda, RC.QtdRepo Coleta, '  + sLineBreak +
      '       RC.QtdRepo - Coalesce(RT.Qtde, 0) Transferido, Coalesce(RT.Qtde, 0) QtdePendente,' + sLineBreak +
      '       Rc.UsuarioId, U.Nome' + sLineBreak +
      'from ReposicaoEnderecoColeta RC' + sLineBreak +
      'Inner join Reposicao Rep On Rep.ReposicaoId = Rc.ReposicaoId' + sLineBreak +
      'Left  Join ReposicaoEstoqueTransferencia RT on RT.ReposicaoId = RC.reposicaoid and' + sLineBreak +
      '          RT.LoteId = RC.LoteId and RT.EnderecoOrigemId = RC.EnderecoId'+sLineBreak +
      'Inner join vProdutoLotes Pl on Pl.LoteId = RC.LoteId' + sLineBreak +
      'Inner Join Enderecamentos TEnd On TEnd.EnderecoId = RC.EnderecoId' + sLineBreak +
      'Left Join Usuarios U On U.UsuarioId = Rc.UsuarioId' + sLineBreak +
      'where (@ReposicaoId = 0 or Rc.reposicaoid = @ReposicaoId) and' + sLineBreak +
      '      (@DataInicial = 0 or Rep.DtReposicao >= @DataInicial) and' + sLineBreak +
      '      (@DataFinal = 0 or Rep.DtReposicao <= @DataFinal) and'+ sLineBreak + '	     (@Pendente <> 1 or Rep.ProcessoId in (27,28)) And' + sLineBreak + '      (@UsuarioId = 0 or Rc.UsuarioId = @UsuarioId)' + sLineBreak +
      '  And (@Divergencia<>1 or (@Divergencia = 1 and Rc.UsuarioId Is Not Null and RC.Qtde <> RC.QtdRepo))'+sLineBreak +
      '  And (@NaoColetado<>1 or (Rc.UsuarioId Is Not Null and RC.QtdRepo=0))' +sLineBreak +
      '  And (@CodProduto = 0 or Pl.CodProduto = @CodProduto)' +sLineBreak + '  And (@ZonaId = 0 or @ZonaId = Pl.ZonaId)' + sLineBreak +
      '  And (@ProcessoId = 0 or @ProcessoId = Rep.ProcessoId)'+sLineBreak+
      'Order by Rep.ReposicaoId, Pl.Descricao';

  Const SqlRelReposicaoAnaliseColetaSintetico =
      'Declare @ReposicaoId Integer  = :pReposicaoId' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @Pendente Integer     = :pPendente' + sLineBreak +
      'Declare @UsuarioId Integer    = :pUsuarioId' + sLineBreak +
      'Declare @Divergencia Integer  = :pDivergencia' + sLineBreak +
      'Declare @NaoColetado Integer  = :pNaoColetado' + sLineBreak +
      'Declare @CodProduto Integer   = :pCodProduto' + sLineBreak +
      'Declare @ZonaId Integer       = :pZonaId' + sLineBreak +
      'Declare @ProcessoId Integer   = :pProcessoId'+sLineBreak+
      'select Pl.CodProduto, Pl.Descricao, Pl.Endereco Picking,' + sLineBreak +
      '       Rc.UsuarioId, U.Nome, Sum(RC.Qtde) Demanda, Sum(RC.QtdRepo) Coleta,'+ sLineBreak +
      '       Sum(RC.QtdRepo) - Coalesce(Sum(RT.Qtde), 0) Transferido,' + sLineBreak +
      '	      Coalesce(Sum(RT.Qtde), 0) QtdePendente' + sLineBreak
      + 'from ReposicaoEnderecoColeta RC' + sLineBreak +
      'Inner join Reposicao Rep On Rep.ReposicaoId = Rc.ReposicaoId' + sLineBreak +
      'Left  Join ReposicaoEstoqueTransferencia RT on RT.ReposicaoId = RC.reposicaoid and' + sLineBreak +
      '           RT.LoteId = RC.LoteId and RT.EnderecoOrigemId = RC.EnderecoId' + sLineBreak +
      'Inner join vProdutoLotes Pl on Pl.LoteId = RC.LoteId' + sLineBreak +
      'Inner Join Enderecamentos TEnd On TEnd.EnderecoId = RC.EnderecoId' + sLineBreak +
      'Left Join Usuarios U On U.UsuarioId = Rc.UsuarioId' + sLineBreak +
      'where (@ReposicaoId = 0 or Rc.reposicaoid = @ReposicaoId) and' + sLineBreak +
      '      (@DataInicial = 0 or Rep.DtReposicao >= @DataInicial) and' + sLineBreak +
      '      (@DataFinal = 0 or Rep.DtReposicao <= @DataFinal) and'+ sLineBreak +
      '	     (@Pendente <> 1 or Rep.ProcessoId in (27,28)) And'+ sLineBreak +
      '      (@UsuarioId = 0 or Rc.UsuarioId = @UsuarioId)' +sLineBreak +
      '  And (@Divergencia<>1 or (@Divergencia = 1 and Rc.UsuarioId Is Not Null and RC.Qtde <> RC.QtdRepo))'+sLineBreak +
      '  And (@NaoColetado<>1 or (Rc.UsuarioId Is Not Null and RC.QtdRepo=0))' + sLineBreak +
      '  And (@CodProduto = 0 or Pl.CodProduto = @CodProduto)' + sLineBreak +
      '  And (@ZonaId = 0 or Pl.ZonaId = @ZonaId)' + sLineBreak +
      '  And (@ProcessoId = 0 or @ProcessoId = Rep.ProcessoId)'+sLineBreak+
      'Group by Pl.CodProduto, Pl.Descricao, Pl.Endereco, Rc.UsuarioId, U.Nome' + sLineBreak +
      'Order by Pl.Descricao';

  Const
    SqlRelReposicaoTransfAnalitico =
      'Declare @ReposicaoId Integer  = :pReposicaoId' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @CodProduto Integer   = :pCodProduto' + sLineBreak +
      'Declare @ZonaId Integer       = :pZonaId' + sLineBreak +
      'select Rep.reposicaoid, Pl.CodProduto, Pl.Descricao, TEndPck.Descricao Picking,'
      + sLineBreak +
      '       RT.EnderecoId, TEnd.Descricao PalletColeta, RT.LoteId, Pl.Lote,' +
      sLineBreak +
      '	      Pl.Data Fabricacao, Pl.Vencimento, RC.QtdRepo QtdColeta,' +
      sLineBreak +
      '	      RC.QtdRepo - RT.Qtde QtdTransferida, RT.Qtde QtdePendente,' +
      sLineBreak +
      '       Cast(Cast((RC.QtdRepo - Coalesce(RT.Qtde, 0)) as Numeric(15,2)) / Cast(Rc.QtdRepo as Numeric(15,2))*100 as Numeric(15,2)) As Concluido'
      + sLineBreak + 'from Reposicao Rep' + sLineBreak +
      'Inner Join ReposicaoEnderecoColeta RC On RC.Reposicaoid = Rep.ReposicaoId'
      + sLineBreak +
      'Left Join ReposicaoEstoqueTransferencia RT on RT.ReposicaoId = Rc.reposicaoid and'
      + sLineBreak +
      '          RT.LoteId = RC.LoteId and RT.EnderecoOrigemId = RC.EnderecoId'
      + sLineBreak + 'Inner Join vProdutoLotes Pl On Pl.LoteId = RT.LoteId' +
      sLineBreak +
      'Left Join Enderecamentos TEnd On TEnd.EnderecoId = RC.EnderecoId' +
      sLineBreak +
      'Left Join Enderecamentos TEndPck On TEndPck.EnderecoId = RT.EnderecoId' +
      sLineBreak +
      'where (@ReposicaoId = 0 or Rc.reposicaoid = @ReposicaoId) and' +
      sLineBreak +
      '      (@DataInicial = 0 or Rep.DtReposicao >= @DataInicial) and' +
      sLineBreak + '      (@DataFinal = 0 or Rep.DtReposicao <= @DataFinal) And'
      + sLineBreak +
      '      (@CodProduto = 0 or Pl.CodProduto = @CodProduto) And' + sLineBreak
      + '	  (RT.Qtde > 0)' + sLineBreak +
      '  And (@ZonaId = 0 or @ZonaId = Pl.ZonaId)' + sLineBreak +
      'Order by Rep.ReposicaoId, Pl.Descricao';

  Const
    SqlRelReposicaoTransfSintetico = 'Declare @ZonaId Integer = :pZonaId' +
      sLineBreak +
      'select Pl.CodProduto, Pl.Descricao, TEndPck.Descricao Picking,' +
      sLineBreak + '       Sum(RC.QtdRepo) QtdColeta,' + sLineBreak +
      '	      Sum(RC.QtdRepo) - Sum(Coalesce(RT.Qtde, 0)) QtdTransferida,' +
      sLineBreak + '	      Sum(RT.Qtde) QtdePendente,' + sLineBreak +
      '       Cast(Cast((Sum(RC.QtdRepo) - Sum(Coalesce(RT.Qtde, 0))) as Numeric(15,2)) / Cast(Sum(Rc.QtdRepo) as Numeric(15,2))*100 as Numeric(15,2)) As Concluido'
      + sLineBreak + 'from Reposicao Rep' + sLineBreak +
      'Inner Join ReposicaoEnderecoColeta RC On RC.Reposicaoid = Rep.ReposicaoId'
      + sLineBreak +
      'Left Join ReposicaoEstoqueTransferencia RT on RT.ReposicaoId = Rc.reposicaoid and'
      + sLineBreak +
      '          RT.LoteId = RC.LoteId and RT.EnderecoOrigemId = RC.EnderecoId'
      + sLineBreak + 'Inner Join vProdutoLotes Pl On Pl.LoteId = RT.LoteId' +
      sLineBreak +
      'Left Join Enderecamentos TEnd On TEnd.EnderecoId = RC.EnderecoId' +
      sLineBreak +
      'Left Join Enderecamentos TEndPck On TEndPck.EnderecoId = RT.EnderecoId' +
      sLineBreak + 'Where (@ZonaId = 0 or Pl.ZonaId = @ZonaId)' + sLineBreak +
      'Group by Pl.CodProduto, Pl.Descricao, TEndPck.Descricao' + sLineBreak +
      'Order by Pl.Descricao';

  Const
    SqlRelHistoricoTransferenciaPickingAnalitico =
      'Declare @ReposicaoId Integer  = :pReposicaoId' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @Pendente Integer     = :pPendente' + sLineBreak +
      'Declare @UsuarioId Integer    = :pUsuarioid' + sLineBreak +
      'Declare @CodProduto Integer   = :pCodProduto' + sLineBreak +
      'Declare @ZonaId Integer       = :pZonaId' + sLineBreak + '' + sLineBreak
      + 'select RTH.ReposicaoId, Pl.CodProduto, Pl.Descricao, Tend.Descricao Picking, Pl.Lote, '
      + sLineBreak +
      '       pl.Vencimento, TendP.Descricao PalletColeta, RTH.QtdeTransferida, '
      + sLineBreak +
      '       RTH.Data, RTH.Hora, RTH.Horario, RTH.Usuarioid, U.Nome' +
      sLineBreak + 'from ReposicaoEstoqueTransferenciaHistorico RTH' +
      sLineBreak + 'Inner join vProdutoLotes Pl on Pl.LoteId = RTH.LoteId' +
      sLineBreak +
      'Inner Join Enderecamentos TEnd On TEnd.EnderecoId = RTH.EnderecoId' +
      sLineBreak +
      'Inner Join Enderecamentos TEndP On TEndP.EnderecoId = RTH.EnderecoOrigemId'
      + sLineBreak + 'Inner Join Usuarios U On U.UsuarioId = RTH.UsuarioId' +
      sLineBreak +
      'Inner Join Reposicao Rep On Rep.Reposicaoid = RTH.ReposicaoId' +
      sLineBreak + '' + sLineBreak +
      'where (@ReposicaoId = 0 or RTH.reposicaoid = @ReposicaoId) and' +
      sLineBreak + '      (@DataInicial = 0 or RTH.Data >= @DataInicial) and' +
      sLineBreak + '      (@DataFinal = 0 or RTH.Data <= @DataFinal) and' +
      sLineBreak + '	     (@Pendente <> 1 or Rep.ProcessoId in (27,28)) And' +
      sLineBreak + '      (@UsuarioId = 0 or RTH.UsuarioId = @UsuarioId) And' +
      sLineBreak + '      (@CodProduto=0 or Pl.CodProduto=@CodProduto) And' +
      sLineBreak + '      (@ZonaId = 0 or @ZonaId = Pl.Zonaid)' + sLineBreak +
      '   And QtdeTransferida > 0' + 'Order by Rep.ReposicaoId, Pl.Descricao';

  Const
    SqlRelHistoricoTransferenciaPickingSintetico =
      'Declare @ReposicaoId Integer  = :pReposicaoId' + sLineBreak +
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @Pendente Integer     = :pPendente' + sLineBreak +
      'Declare @UsuarioId Integer    = :pUsuarioid' + sLineBreak +
      'Declare @CodProduto Integer   = :pCodProduto' + sLineBreak +
      'Declare @Zonaid Integer       = :pZonaId' + sLineBreak +
      'select Pl.CodProduto, Pl.Descricao, RTH.Usuarioid, U.Nome, Sum(RTH.QtdeTransferida) QtdeTransferida'
      + sLineBreak + 'from ReposicaoEstoqueTransferenciaHistorico RTH' +
      sLineBreak + 'Inner join vProdutoLotes Pl on Pl.LoteId = RTH.LoteId' +
      sLineBreak +
      'Inner Join Enderecamentos TEnd On TEnd.EnderecoId = RTH.EnderecoId' +
      sLineBreak +
      'Inner Join Enderecamentos TEndP On TEndP.EnderecoId = RTH.EnderecoOrigemId'
      + sLineBreak + 'Inner Join Usuarios U On U.UsuarioId = RTH.UsuarioId' +
      sLineBreak +
      'Inner Join Reposicao Rep On Rep.Reposicaoid = RTH.ReposicaoId' +
      sLineBreak +
      'where (@ReposicaoId = 0 or RTH.reposicaoid = @ReposicaoId) and' +
      sLineBreak + '      (@DataInicial = 0 or RTH.Data >= @DataInicial) and' +
      sLineBreak + '      (@DataFinal = 0 or RTH.Data <= @DataFinal) and' +
      sLineBreak + '	     (@Pendente <> 1 or Rep.ProcessoId in (27,28)) And' +
      sLineBreak + '      (@UsuarioId = 0 or RTH.UsuarioId = @UsuarioId) And' +
      sLineBreak + '      (@CodProduto=0 or Pl.CodProduto=@CodProduto) And' +
      sLineBreak + '      (@ZonaId = 0 or @ZonaId = Pl.Zonaid)' + sLineBreak +
      'Group by Pl.CodProduto, Pl.Descricao, RTH.Usuarioid, U.Nome' + sLineBreak
      + 'Order by Pl.Descricao';

  Const
    SqlGetdshvolumeevolucao_Unidades = '';

  Const
    SqlGetProducaoDiariaPorRuaHeader =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'select Count(Distinct Ped.PedidoId) TotalPedidos,' + sLineBreak +
      '	      Count(Pv.PedidoVOlumeid) TotalVolumes,' + sLineBreak +
      '	      Sum((Case When Pv.EmbalagemId Is Null then 1 Else 0 End)) TotalVolumeCxaFechada,'
      + sLineBreak +
      '	      Sum((Case When Pv.EmbalagemId Is Not Null then 1 Else 0 End)) TotalVolumeFracionado'
      + sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Left join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Left Join vDocumentoEtapas De on De.Documento = Pv.UUid' + sLineBreak +
      'where (@DataInicial=0 or Ped.DocumentoData >= @DataInicial)' + sLineBreak
      + '  And (@DataFinal=0 or Ped.DocumentoData <= @DataFinal)' + sLineBreak +
      '  And Ped.OperacaoTIpoId = 2 and Ped.ProcessoId > 1' + sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak + '  And Ped.Processoid Not In (15, 31)';

  Const
    SqlGetProducaoDiariaPorRuaBody =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime   = :pDataFinal' + sLineBreak +
      'Declare @EstruturaId Integer    = :pEstruturaId' + sLineBreak +
      'select Vl.ZonaId, Vl.Zona, Vl.Rua,' + sLineBreak +
      '       Sum((Case When Pv.EmbalagemId Is Null then 1 Else 0 End)) VolumeCxaFechada,'
      + sLineBreak +
      '	   Sum((Case When Pv.EmbalagemId Is Not Null then 1 Else 0 End)) VolumeFracionado'
      + sLineBreak +
      '       ,Sum((Case When Pv.EmbalagemId Is Null then Vl.QtdSuprida Else 0 End)) UnidadeCxaFechada'
      + sLineBreak +
      '	   ,Sum((Case When Pv.EmbalagemId Is Not Null then Vl.QtdSuprida Else 0 End)) UnidadeFracionado'
      + sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Inner join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Inner Join (Select Vl.PedidoVolumeId, vEnd.ZonaId, vEnd.Zona, SubString(vEnd.Endereco, 1, 2) Rua, Sum(Vl.QtdSuprida) QtdSuprida'
      + sLineBreak + '            From PedidoVolumeLotes Vl' + sLineBreak +
      '            Inner join vEnderecamentos vEnd On vEnd.EnderecoId = Vl.EnderecoId'
      + sLineBreak +
      '			Where (@EstruturaId = 0 or vEnd.Estruturaid = @EstruturaId)' +
      sLineBreak +
      '			Group by Vl.PedidoVolumeId, vEnd.ZonaId, vEnd.Zona, SubString(vEnd.Endereco, 1, 2)) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join vDocumentoEtapas De on De.Documento = Pv.UUid'
      + sLineBreak +
      'where (@DataInicial=0 or Ped.DocumentoData >= @DataInicial)' + sLineBreak
      + '  And (@DataFinal=0 or Ped.DocumentoData <= @DataFinal)' + sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '  And (Ped.Processoid Not In (15, 31)) and De.ProcessoId <> 15' +
      sLineBreak + 'Group by Vl.ZonaId, Vl.Zona, Vl.Rua' + sLineBreak +
      'Order By Zona, Rua';

  Const
    SqlGetProducaoDiariaPorLoja =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime  = :pDataFinal' + sLineBreak +
      'Declare @EstruturaId Integer = :pEstruturaId' + sLineBreak +
      'select Ped.CodPessoaERP, Razao, Fantasia, Count(Distinct Ped.PedidoId) Pedidos,'
      + sLineBreak +
      '       Sum((Case When Pv.EmbalagemId Is Null then 1 Else 0 End)) VolumeCxaFechada,'
      + sLineBreak +
      '   	   Sum((Case When Pv.EmbalagemId Is Not Null then 1 Else 0 End)) VolumeFracionado'
      + sLineBreak +
      '      ,Sum((Case When Pv.EmbalagemId Is Null then Vl.QtdSuprida Else 0 End)) UnidadeCxaFechada'
      + sLineBreak +
      '	     ,Sum((Case When Pv.EmbalagemId Is Not Null then Vl.QtdSuprida Else 0 End)) UnidadeFracionado'
      + sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Inner join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Inner Join (Select Vl.PedidoVolumeId, Sum(Vl.QtdSuprida) QtdSuprida' +
      sLineBreak + '            From PedidoVolumeLotes Vl' + sLineBreak +
      '            Inner join vEnderecamentos vEnd On vEnd.EnderecoId = Vl.EnderecoId'
      + sLineBreak +
      '			Where (@EstruturaId = 0 or vEnd.Estruturaid = @EstruturaId)' +
      sLineBreak +
      '			Group by Vl.PedidoVolumeId) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join vDocumentoEtapas De on De.Documento = Pv.UUid'
      + sLineBreak +
      'where (@DataInicial=0 or Ped.DocumentoData >= @DataInicial)' + sLineBreak
      + '  And (@DataFinal=0 or Ped.DocumentoData <= @DataFinal)' + sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '  And (Ped.Processoid Not In (15, 31)) and De.ProcessoId <> 15' +
      sLineBreak + 'Group by Ped.CodPessoaERP, Razao, Fantasia' + sLineBreak +
      'Order By Fantasia';

  Const
    SqlGetProducaoDiariaPorZona =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime  = :pDataFinal' + sLineBreak +
      'Declare @EstruturaId Integer = :pEstruturaId' + sLineBreak +
      'select Vl.ZonaId, Vl.Zona,' + sLineBreak +
      '       Sum((Case When Pv.EmbalagemId Is Null then 1 Else 0 End)) VolumeCxaFechada,'
      + sLineBreak +
      '   	   Sum((Case When Pv.EmbalagemId Is Not Null then 1 Else 0 End)) VolumeFracionado'
      + sLineBreak +
      '      ,Sum((Case When Pv.EmbalagemId Is Null then Vl.QtdSuprida Else 0 End)) UnidadeCxaFechada'
      + sLineBreak +
      '	     ,Sum((Case When Pv.EmbalagemId Is Not Null then Vl.QtdSuprida Else 0 End)) UnidadeFracionado'
      + sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Inner join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Inner Join (Select Vl.PedidoVolumeId, vEnd.ZonaId, vEnd.Zona, SubString(vEnd.Endereco, 1, 2) Rua, Sum(Vl.QtdSuprida) QtdSuprida'
      + sLineBreak + '            From PedidoVolumeLotes Vl' + sLineBreak +
      '            Inner join vEnderecamentos vEnd On vEnd.EnderecoId = Vl.EnderecoId'
      + sLineBreak +
      '			         Where (@EstruturaId = 0 or vEnd.Estruturaid = @EstruturaId)'
      + sLineBreak +
      '			         Group by Vl.PedidoVolumeId, vEnd.ZonaId, vEnd.Zona, SubString(vEnd.Endereco, 1, 2)) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join vDocumentoEtapas De on De.Documento = Pv.UUid'
      + sLineBreak +
      'where (@DataInicial=0 or Ped.DocumentoData >= @DataInicial)' + sLineBreak
      + '  And (@DataFinal=0 or Ped.DocumentoData <= @DataFinal)' + sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '  And (Ped.Processoid Not In (15, 31)) and De.ProcessoId <> 15' +
      sLineBreak + 'Group by Vl.ZonaId, Vl.Zona' + sLineBreak + 'Order By Zona';

  Const
    SqlGetProducaoDiariaPorRota =
      'Declare @DataInicial DateTime = :pDataInicial' + sLineBreak +
      'Declare @DataFinal DateTime  = :pDataFinal' + sLineBreak +
      'Declare @EstruturaId Integer = :pEstruturaId' + sLineBreak +
      'select Ped.RotaId, Ped.Rota,' + sLineBreak +
      '       Sum((Case When Pv.EmbalagemId Is Null then 1 Else 0 End)) VolumeCxaFechada,'
      + sLineBreak +
      '   	   Sum((Case When Pv.EmbalagemId Is Not Null then 1 Else 0 End)) VolumeFracionado'
      + sLineBreak +
      '      ,Sum((Case When Pv.EmbalagemId Is Null then Vl.QtdSuprida Else 0 End)) UnidadeCxaFechada'
      + sLineBreak +
      '	     ,Sum((Case When Pv.EmbalagemId Is Not Null then Vl.QtdSuprida Else 0 End)) UnidadeFracionado'
      + sLineBreak + 'From vPedidos Ped' + sLineBreak +
      'Inner join PedidoVolumes Pv On Pv.PedidoId = Ped.PedidoId' + sLineBreak +
      'Inner Join (Select Vl.PedidoVolumeId, Sum(Vl.QtdSuprida) QtdSuprida' +
      sLineBreak + '            From PedidoVolumeLotes Vl' + sLineBreak +
      '            Inner join vEnderecamentos vEnd On vEnd.EnderecoId = Vl.EnderecoId'
      + sLineBreak +
      '			       Where (@EstruturaId = 0 or vEnd.Estruturaid = @EstruturaId)'
      + sLineBreak +
      '			       Group by Vl.PedidoVolumeId) Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'
      + sLineBreak + 'Inner Join vDocumentoEtapas De on De.Documento = Pv.UUid'
      + sLineBreak +
      'where (@DataInicial=0 or Ped.DocumentoData >= @DataInicial)' + sLineBreak
      + '  And (@DataFinal=0 or Ped.DocumentoData <= @DataFinal)' + sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'
      + sLineBreak +
      '  And (Ped.Processoid Not In (15, 31)) and De.ProcessoId <> 15' +
      sLineBreak + 'Group by Ped.RotaId, Ped.Rota' + sLineBreak +
      'Order By Rota';

  Const
    SqlDelReservaReposicao = 'Declare @ReposicaoId Integer = :pReposicaoId' +
      sLineBreak + 'Update Est' + sLineBreak +
      '   Set Qtde = Est.Qtde - Rec.Qtde' + sLineBreak + 'from Estoque Est' +
      sLineBreak +
      'Inner Join ReposicaoEnderecoColeta Rec On Rec.LoteId = Est.LoteId and Rec.EnderecoId = Est.EnderecoId'
      + sLineBreak +
      'Where Rec.ReposicaoId = @ReposicaoId And Est.EstoqueTipoId = 6' +
      sLineBreak + '' + sLineBreak + 'Delete Est' + sLineBreak +
      'from Estoque Est' + sLineBreak +
      'Inner Join ReposicaoEnderecoColeta Rec On Rec.LoteId = Est.LoteId and Rec.EnderecoId = Est.EnderecoId'
      + sLineBreak +
      'where Rec.ReposicaoId = @ReposicaoId And Est.EstoqueTipoId = 6 and Est.Qtde <= 0';

  Const
    SqlGetVolumeEAN = 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId' +
      sLineBreak +
      'select Vl.PedidoVolumeId, Pc.ProdutoId, CodBarras, UnidadesEmbalagem' +
      sLineBreak + 'From PedidoVOlumeLotes Vl' + sLineBreak +
      'Inner join ProdutoLotes Pl on Pl.LoteId = Vl.LoteId' + sLineBreak +
      'inner join ProdutocodBarras Pc On Pc.ProdutoId = Pl.ProdutoId' +
      sLineBreak + 'where Vl.PedidoVOlumeId = @PedidoVolumeId' + sLineBreak +
      '  And SubString(Pc.CodBarras,1,3)<>999' + sLineBreak +
      'Order by produtoid, pc.CodBarras';

  Const
    SqlEntradaHeader = 'Declare @PedidoId Integer        = :pPedidoId' +
      sLineBreak + 'Declare @AgrupamentoId Integer   = :pAgrupamentoId' +
      sLineBreak +
      'select Ped.PedidoId, Op.OperacaoTipoId, Op.Descricao as OperacaoTipo, P.Pessoaid,'
      + sLineBreak +
      '       P.CodPessoaERP, P.Razao, Ped.DocumentoNr, Rd.Data as DocumentoData, '
      + sLineBreak + '       Ped.RegistroERP, RE.Data as DtInclusao, ' +
      sLineBreak +
      '       CONVERT(VARCHAR, RH.hora ,8) as HrInclusao, ArmazemId, Ped.Status, De.ProcessoId, De.Descricao as Processo,'
      + sLineBreak +
      '       Coalesce(Pa.AgrupamentoId, 0) AgrupamentoId, Pi.QtdXml, Pi.QtdCheckIN, Pi.QtdDevolvida, Pi.QtdSegregada'
      + sLineBreak +
      '       	   , (Case when Pi.QtdXml<(Pi.QtdCheckIN+Pi.QtdDevolvida+Pi.QtdSegregada) then 3 --CheckIn maior'
      + sLineBreak +
      '	           when Pi.QtdXml=(Pi.QtdCheckIN+Pi.QtdDevolvida+Pi.QtdSegregada) then 2'
      + sLineBreak +
      '	           when (Pi.QtdCheckIN+Pi.QtdDevolvida+Pi.QtdSegregada)>0 then 1'
      + sLineBreak + '	           Else 0 End) ProcessoCheckIn' + sLineBreak +
      'From pedido Ped ' + sLineBreak +
      'Inner Join OperacaoTipo Op ON OP.OperacaoTipoId = Ped.OperacaoTipoId ' +
      sLineBreak + 'Inner Join Pessoa P ON p.PessoaId     = Ped.PessoaId ' +
      sLineBreak + 'Inner Join Rhema_Data RD On Rd.IdData = Ped.DocumentoData '
      + sLineBreak + 'Inner Join Rhema_Data RE On Re.IdData = Ped.DtInclusao ' +
      sLineBreak + 'Inner Join Rhema_Hora RH On Rh.IdHora = Ped.Hrinclusao ' +
      sLineBreak +
      'Inner join (select PedidoId, Sum(QtdXml) QtdXml, Sum(QtdCheckIn) QtdCheckIN, Sum(QtdDevolvida) QtdDevolvida, Sum(QtdSegregada) QtdSegregada'
      + sLineBreak + '            From PedidoItens' + sLineBreak +
      '			         Group by PedidoId) Pi On Pi.PedidoId = PEd.PedidoId' +
      sLineBreak + 'Left join vDocumentoEtapas DE On De.Documento = Ped.Uuid' +
      sLineBreak +
      'Left Join PedidoAgrupamentoNotas PA on Pa.Pedidoid = Ped.PedidoId' +
      sLineBreak +
      'Where (@PedidoId = 0 or Ped.PedidoId = @PedidoId) and Ped.OperacaoTipoId = 3 '
      + sLineBreak +
      '  And (@AgrupamentoId = 0 or Pa.AgrupamentoId = @AgrupamentoId or (@AgrupamentoId=-1 and PA.agrupamentoid Is Null))'
      + sLineBreak +
      '  And DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Ped.uuid and Status = 1)'
      + sLineBreak + '  And De.ProcessoId <> 31';
Const SqlGetEntradaLoteCheckIn = 'Declare @PedidoId   Integer    = :pPedidoId' +
      sLineBreak + 'Declare @CodProduto Integer    = :pCodProduto' + sLineBreak
      + 'Declare @AgrupamentoId Integer = :pAgrupamentoId' + sLineBreak +
      'SELECT PL.Lote, Pl.Data AS Fabricacao, Pl.Vencimento,' + sLineBreak +
      '       Sum(PI.QtdXml) QtdXml, Sum(PI.QtdCheckIn) QtdCheckIn, Sum(PI.QtdDevolvida) QtdDevolvida, Sum(PI.QtdSegregada) QtdSegregada'
      + sLineBreak + 'FROM PedidoItens AS PI' + sLineBreak +
      'INNER JOIN vProdutoLotes AS PL ON PL.LoteId = PI.LoteId' + sLineBreak +
      'Left Join PedidoAgrupamentoNotas Ped On Ped.PedidoId = Pi.PedidoId' +
      sLineBreak + 'Where (@PedidoId=0 or Pi.pedidoid = @PedidoId) ' +
      sLineBreak +
      '  And (@AgrupamentoId = 0 or Ped.AgrupamentoId = @AgrupamentoId)' +
      sLineBreak + '  And Pl.CodProduto = @CodProduto' + sLineBreak +
      'Group by PL.Lote, Pl.Data, Pl.Vencimento';

Const SqlPedidoCxaFechadaCheckOut = 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId'+sLineBreak+
      'select Pv.PedidoVolumeId, De.ProcessoId, De.Descricao Processo, Ped.PedidoId, Ped.Razao, Ped.Fantasia, Ped.DocumentoData, Ped.Rota, Ped.rotaid, Vl.Quantidade'+sLineBreak+
      'from PedidoVolumes Pv'+sLineBreak+
      'Inner join vPedidos Ped On Ped.PedidoId = Pv.PedidoId'+sLineBreak+
      'Inner join vDocumentoEtapas De On De.Documento = Pv.Uuid'+sLineBreak+
      'Inner Join PedidoVolumeLotes Vl On Vl.PedidoVolumeId = Pv.PedidoVolumeId'+sLineBreak+
      'where DE.Horario = (Select Max(Horario) From vDocumentoEtapas where Documento = Pv.uuid and Status = 1)'+sLineBreak+
      '  And Pv.EmbalagemId Is Null and Pv.PedidoVolumeId = @PedidoVolumeId';

Const SqlPedidoCxaFechadaCheckOutProd = 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId'+sLineBreak+
      'Select Vl.PedidoVolumeId, Pl.IdProduto ProdutoId, Pl.CodProduto, Null CodBarras, '+sLineBreak+
      'Pl.Descricao, Prd.UnidadeSecundariaDescricao unidadesecundariasigla,'+sLineBreak+
      '       TEnd.Endereco, TEnd.Mascara, Vl.Quantidade Demanda, Vl.EmbalagemPadrao, Vl.QtdSuprida'+sLineBreak+
      'From PedidoVolumeLotes Vl'+sLineBreak+
      'Inner join vProdutoLotes Pl On Pl.LoteId = Vl.LoteId'+sLineBreak+
      'Inner join vProduto Prd On Prd.IdProduto = Pl.IdProduto'+sLineBreak+
      'Inner join vEnderecamentos TEnd On TEnd.EnderecoId = Vl.EnderecoId'+sLineBreak+
      'Where Vl.PedidoVolumeId = @PedidoVolumeId';

Const SqlPedidoCxaFechadaCheckOutCodBarras = 'Declare @PedidoVolumeId Integer = :pPedidoVolumeId'+sLineBreak+
     'select Vl.PedidoVolumeId, Pc.CodBarras'+sLineBreak+
     'from PedidoVolumeLotes Vl'+sLineBreak+
     'Inner join ProdutoLotes Pl On Pl.LoteId = Vl.LoteId'+sLineBreak+
     'Inner join ProdutoCodBarras Pc On Pc.ProdutoId = Pl.ProdutoId'+sLineBreak+
     'where PedidoVolumeId = @PedidoVolumeId';

    { else if TJSONObject.ParseJSONValue(Req.Body) Is TJsonArray then
      ShowMessage('Recebido Array')
      Else ShowMEssage('Recebido TJSONObject');

      https://www.dirceuresende.com/blog/sql-server-como-criar-um-historico-de-alteracoes-de-dados-para-suas-tabelas-logs-auditoria/

    }

  end;

implementation

end.
