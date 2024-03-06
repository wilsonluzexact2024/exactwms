program eXactWmsMobile;

uses
  System.StartUpCopy,
  Midas,
  FMX.Forms,
  FMX.Types,
  FMX.Consts,
  uFrmeXactWMS in 'views\uFrmeXactWMS.pas' {FrmeXactWMS},
  uFrmLogin in 'Views\uFrmLogin.pas' {FrmLogin},
  uFuncoes in '..\uFuncoes.pas',
  uFrmProduto in 'Views\uFrmProduto.pas' {FrmProduto},
  uTCaixa in '..\Class\uTCaixa.pas',
  uFrmCaixa in 'Views\uFrmCaixa.pas' {FrmCaixa},
  uRetorno in '..\Class\uRetorno.pas',
  uMyTabOrderClassHelper in '..\Class\uMyTabOrderClassHelper.pas',
  uFrmSplash in 'Views\uFrmSplash.pas' {FrmSplash},
  uFrmBase in 'Views\uFrmBase.pas' {FrmBase},
  uTEnderecoColetor in '..\class\uTEnderecoColetor.pas',
  uTHistorico in '..\Class\uTHistorico.pas',
  uTProdutoColetor in '..\class\uTProdutoColetor.pas',
  uTProdutoControle in '..\Class\uTProdutoControle.pas',
  uTSaida in '..\Class\uTSaida.pas',
  uTSeparacaoVolumeCaixa in '..\Class\uTSeparacaoVolumeCaixa.pas',
  U_MsgD in '..\Class\U_MsgD.pas',
  uFrmEstoque in 'Views\uFrmEstoque.pas' {FrmEstoque},
  uFrmSaidaConsulta in 'Views\uFrmSaidaConsulta.pas' {FrmSaidaConsulta},
  DataSetConverter4D.Helper in '..\Lib\DataSetConverter4D.Helper.pas',
  DataSetConverter4D.Impl in '..\Lib\DataSetConverter4D.Impl.pas',
  DataSetConverter4D in '..\Lib\DataSetConverter4D.pas',
  DataSetConverter4D.Util in '..\Lib\DataSetConverter4D.Util.pas',
  uFrmAtualizadorApp in 'Views\uFrmAtualizadorApp.pas' {FrmAtualizadorApp},
  Notificacao in '..\Class\Notificacao.pas',
  uFrmExpedicao in 'views\uFrmExpedicao.pas' {FrmExpedicao},
  ConfiguracaoClass in '..\..\Model\ConfiguracaoClass.pas',
  Providers.Session in '..\..\src\providers\Providers.Session.pas',
  Providers.Models.Token in '..\..\src\providers\models\Providers.Models.Token.pas',
  Providers.Request.Intf in '..\..\src\providers\request\Providers.Request.Intf.pas',
  Providers.Request in '..\..\src\providers\request\Providers.Request.pas',
  Services.Base in '..\..\src\Services\Services.Base.pas' {ServiceBase: TDataModule},
  Services.Base.Cadastro in '..\..\src\Services\Services.Base.Cadastro.pas' {ServiceBaseCadastro: TDataModule},
  Services.Laboratorios in '..\..\src\Services\Services.Laboratorios.pas' {ServiceLaboratorios: TDataModule},
  Services.Pessoas in '..\..\src\Services\Services.Pessoas.pas' {ServicePessoas: TDataModule},
  Services.Rotas in '..\..\src\Services\Services.Rotas.pas' {ServiceRotas: TDataModule},
  Services.Veiculos in '..\..\src\Services\Services.Veiculos.pas' {ServicesVeiculos: TDataModule},
  Providers.Frames.Base in 'Providers\frames\Providers.Frames.Base.pas' {FrameBase: TFrame},
  Providers.Frames.VolumeParaExpedicao in 'Providers\frames\Providers.Frames.VolumeParaExpedicao.pas' {FrameVolumeParaExpedicao: TFrame},
  uLibThread in '..\class\uLibThread.pas',
  Loading in '..\class\Loading.pas',
  uFrmSeparacaoColetor in 'views\uFrmSeparacaoColetor.pas' {FrmSeparacaoColetor},
  uFrmControleArmazenagem in 'views\uFrmControleArmazenagem.pas' {FrmControleArmazenagem},
  uDmClient in 'datamodule\uDmClient.pas' {dmClient: TDataModule},
  uDmeXactWMS in 'datamodule\uDmeXactWMS.pas' {DmeXactWMS: TDataModule},
  EnderecoClass in '..\..\Model\EnderecoClass.pas',
  EnderecamentoRuaClass in '..\..\Model\EnderecamentoRuaClass.pas',
  EnderecamentoZonaClass in '..\..\Model\EnderecamentoZonaClass.pas',
  EnderecoEstruturaClass in '..\..\Model\EnderecoEstruturaClass.pas',
  DesenhoArmazemClass in '..\..\Model\DesenhoArmazemClass.pas',
  LaboratoriosClass in '..\..\Model\LaboratoriosClass.Pas',
  LotesClass in '..\..\Model\LotesClass.pas',
  MedicamentoTipoClass in '..\..\Model\MedicamentoTipoClass.pas',
  ProdutoTipoClass in '..\..\Model\ProdutoTipoClass.pas',
  RastroClass in '..\..\Model\RastroClass.pas',
  UnidadeClass in '..\..\Model\UnidadeClass.pas',
  uLaboratorioDAO in '..\..\DAORESTFULL\uLaboratorioDAO.pas',
  EnderecoCtrl in '..\..\Controller\EnderecoCtrl.pas',
  ProdutoCtrl in '..\..\Controller\ProdutoCtrl.pas',
  uEnderecoDAO in '..\..\DAORESTFULL\uEnderecoDAO.pas',
  UsuarioClass in '..\..\Model\UsuarioClass.pas',
  EstoqueClass in '..\..\Model\EstoqueClass.pas',
  EstoqueCtrl in '..\..\Controller\EstoqueCtrl.pas',
  EstoqueDAO in '..\..\DAORESTFULL\EstoqueDAO.pas',
  RastroCtrl in '..\..\Controller\RastroCtrl.pas',
  ProdutoClass in '..\..\Model\ProdutoClass.pas',
  PedidoSaidaCtrl in '..\..\Controller\PedidoSaidaCtrl.pas',
  PedidoVolumeCtrl in '..\..\Controller\PedidoVolumeCtrl.pas',
  PedidoSaidaClass in '..\..\Model\PedidoSaidaClass.pas',
  PedidoVolumeClass in '..\..\Model\PedidoVolumeClass.pas',
  uPedidoSaidaDAO in '..\..\DAORESTFULL\uPedidoSaidaDAO.pas',
  PedidoVolumeDAO in '..\..\DAORESTFULL\PedidoVolumeDAO.pas',
  PedidoClass in '..\..\Model\PedidoClass.pas',
  OperacaoNaturezaClass in '..\..\Model\OperacaoNaturezaClass.Pas',
  OperacaoTipoClass in '..\..\Model\OperacaoTipoClass.Pas',
  PessoaClass in '..\..\Model\PessoaClass.Pas',
  PessoaTipoClass in '..\..\Model\PessoaTipoClass.pas',
  PedidoProdutoClass in '..\..\Model\PedidoProdutoClass.pas',
  PedidoProdutoCtrl in '..\..\Controller\PedidoProdutoCtrl.pas',
  EmbalagemCaixaClass in '..\..\Model\EmbalagemCaixaClass.pas',
  VolumeEmbalagemClass in '..\..\Model\VolumeEmbalagemClass.pas',
  uFrmProdutoEnderecar in 'views\uFrmProdutoEnderecar.pas' {FrmProdutoEnderecar},
  uListview in '..\..\Model\uListview.pas',
  EnderecamentoZonaCtrl in '..\..\Controller\EnderecamentoZonaCtrl.pas',
  uFrmReposicaoReabastecer in 'views\uFrmReposicaoReabastecer.pas' {FrmReposicaoReabastecer},
  PerfilClass in '..\..\Model\PerfilClass.pas',
  uFrmInventario in 'views\uFrmInventario.pas' {FrmInventario},
  InventarioClass in '..\..\Model\InventarioClass.pas',
  InventarioCtrl in '..\..\Controller\InventarioCtrl.pas',
  InventarioDAO in '..\..\DAORESTFULL\InventarioDAO.pas',
  VolumeEmbalagemCtrl in '..\..\Controller\VolumeEmbalagemCtrl.pas',
  uVolumeEmbalagemDAO in '..\..\DAORESTFULL\uVolumeEmbalagemDAO.pas',
  EmbalagemCaixaCtrl in '..\..\Controller\EmbalagemCaixaCtrl.pas',
  CaixaEmbalagemDAO in '..\..\DAORESTFULL\CaixaEmbalagemDAO.pas',
  uFrmEmbalagem in 'views\uFrmEmbalagem.pas' {FrmEmbalagem},
  ProcessoCtrl in '..\..\Controller\ProcessoCtrl.pas',
  ProcessoClass in '..\..\Model\ProcessoClass.pas',
  ProcessoDAO in '..\..\DAORESTFULL\ProcessoDAO.pas',
  uFrmCheckOut in 'views\uFrmCheckOut.pas' {FrmCheckOut},
  uFrmCargaCarregar in 'views\uFrmCargaCarregar.pas' {FrmCargaCarregar},
  CargasCtrl in '..\..\Controller\CargasCtrl.pas',
  CargasClass in '..\..\Model\CargasClass.pas',
  VeiculoClass in '..\..\Model\VeiculoClass.pas',
  CargasDAO in '..\..\DAORESTFULL\CargasDAO.pas',
  uFrmCargaConferencia in 'views\uFrmCargaConferencia.pas' {FrmCargaConferencia},
  uFrmEntrada in 'views\uFrmEntrada.pas' {FrmEntrada},
  EntradaCtrl in '..\..\Controller\EntradaCtrl.pas',
  EntradaClass in '..\..\Model\EntradaClass.pas',
  uEntradaDAO in '..\..\DAORESTFULL\uEntradaDAO.pas',
  EntradaItensCtrl in '..\..\Controller\EntradaItensCtrl.pas',
  EntradaItensClass in '..\..\Model\EntradaItensClass.pas',
  uEntradaItensDAO in '..\..\DAORESTFULL\uEntradaItensDAO.pas',
  ProdutoCodBarrasCtrl in '..\..\Controller\ProdutoCodBarrasCtrl.pas',
  ProdutoCodBarrasClass in '..\..\Model\ProdutoCodBarrasClass.pas',
  ProdutoCodBarrasDAO in '..\..\DAORESTFULL\ProdutoCodBarrasDAO.pas',
  LoteCtrl in '..\..\Controller\LoteCtrl.pas',
  UsuarioCtrl in '..\..\Controller\UsuarioCtrl.pas',
  uFrmReposicaoTransferenciaPicking in 'views\uFrmReposicaoTransferenciaPicking.pas' {FrmReposicaoTransferenciaPicking},
  PedidoVolumeSeparacaoCtrl in '..\..\Controller\PedidoVolumeSeparacaoCtrl.pas',
  PedidoVolumeSeparacaoClass in '..\..\Model\PedidoVolumeSeparacaoClass.pas',
  PedidoVolumeSeparacaoDAO in '..\..\DAORESTFULL\PedidoVolumeSeparacaoDAO.pas',
  uOpenViewUrl in '..\..\Model\uOpenViewUrl.pas',
  uFrmCorrecaoLotes in 'views\uFrmCorrecaoLotes.pas' {FrmCorrecaoLotes},
  uFrmCheckListEstoque in 'views\uFrmCheckListEstoque.pas' {FrmCheckListEstoque};

{$R *.res}

begin
  Application.Initialize;
 // VKAutoShowMode := TVKAutoShowMode.Always;
  Application.CreateForm(TFrmSplash, FrmSplash);
  Application.CreateForm(TdmClient, dmClient);
  Application.CreateForm(TDmeXactWMS, DmeXactWMS);
  Application.Run;
end.

