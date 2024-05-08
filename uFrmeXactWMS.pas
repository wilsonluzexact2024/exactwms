unit uFrmeXactWMS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.CategoryButtons, Vcl.WinXCtrls, System.Notification,
  acPNG, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, System.Actions, Vcl.ActnList,  Rest.Types,
  uLoggerSingleton, IniFiles, System.JSON, REST.Json, System.JSON.Types
  , ConfiguracaoCtrl
  , UsuarioCtrl
  , uFrmPessoa, Vcl.AppEvnts, View.WebCharts, Vcl.OleCtrls, SHDocVw, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, JvComputerInfoEx, JclSysInfo,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client
  , Services.Base.Cadastro, uFrmDshRecebimentos, uFrmRelMovimentacao,
  uFrmSegregadoBaixa, uFrmSegregadoCausa, uFrmRelAuditoriaVolumes,
  uFrmRelAuditoriaCortes, uFrmProdutoLinha, uFrmDshVolumesEvolucao,
  uFrmDshInventarios, uFrmRelListaInventario, uFrmAuditoriaAcompanhamentoCheckIn,
  uFrmRelControleArmazenagem, uFrmRelUsuarios;

type

  TSysInfo = Record
    PercBattery : Integer;
    KeyBoard    : tJvKeyInfo;
    OS          : tJvOsVersionInfo;
    Screen      : tJvScreenInfo;
  End;

  TFuncao = Class
    class procedure CreateForm<xForm: TForm>;
  End;

  TTpPessoa = (NotDefined, Cliente, Fornecedor, Transportadora, Motorista);

  TFrmeXactWMS = class(TForm)
    ActMenuSplit: TActionList;
    ActClientes: TAction;
    ActFornecedor: TAction;
    ActLaboratorio: TAction;
    ActRecebimento: TAction;
    ActProduto: TAction;
    ActDevolucao: TAction;
    ActMovimentacao: TAction;
    ActPedidoCubagem: TAction;
    ActSeparacao: TAction;
    ActCheckOut: TAction;
    ActExpedicao: TAction;
    ActReposicaoPicking: TAction;
    ActEnderecamento: TAction;
    ActRotas: TAction;
    ActSubRotas: TAction;
    ActTransportadora: TAction;
    ActMotorista: TAction;
    ActVeiculos: TAction;
    ActContrAcessoUsuario: TAction;
    ActTipoEntrada: TAction;
    ActMotivoDevolucao: TAction;
    ActTipoCaixa: TAction;
    ActMotivoInutCaixa: TAction;
    ActRelTAG: TAction;
    ActRelEnderecamento: TAction;
    ActDashEficienciaEntrada: TAction;
    ActDashSeparacao: TAction;
    ActConfiguracao: TAction;
    imlIcons: TImageList;
    TmHoraAtual: TTimer;
    PnlTopRhemaSys: TPanel;
    imgMenu: TImage;
    LblVersao: TLabel;
    LblUsuarioTop: TLabel;
    LblDateTime: TLabel;
    lblTitle: TLabel;
    ImgClose: TImage;
    MenuSplit: TSplitView;
    catMenuItems: TCategoryButtons;
    ActVolumeEmbalagem: TAction;
    ActRelPedidos: TAction;
    ActContrAcessoTopicos: TAction;
    ActContrAcessoFuncionalidades: TAction;
    ActContrAcessoPerfil: TAction;
    ApplicationEvents1: TApplicationEvents;
    ImgLogoProduct: TImage;
    ActPatioAgendamento: TAction;
    ActRelPlanilhaCega: TAction;
    ActExpedicaoCargaMontar: TAction;
    ActExpedicaoCargaCarregar: TAction;
    ActRelReposicaoDemanda: TAction;
    ActRelRupturaAbastecimento: TAction;
    ActRelColetaPulmao: TAction;
    ActRelApanhePicking: TAction;
    ActRelAnaliseRessuprimento: TAction;
    WebBrowser1: TWebBrowser;
    WebCharts1: TWebCharts;
    FdMemDashBoard01: TFDMemTable;
    FdMemDashBoard01Label: TStringField;
    FdMemDashBoard01Value: TIntegerField;
    FdMemDashBoard01RGB: TStringField;
    FdMemDashBoard02: TFDMemTable;
    StringField1: TStringField;
    IntegerField1: TIntegerField;
    StringField2: TStringField;
    FdMemDashBoard03: TFDMemTable;
    StringField3: TStringField;
    IntegerField2: TIntegerField;
    StringField4: TStringField;
    FdMemDashBoard04: TFDMemTable;
    StringField5: TStringField;
    IntegerField3: TIntegerField;
    StringField6: TStringField;
    FdMemDashBoard05: TFDMemTable;
    StringField7: TStringField;
    IntegerField4: TIntegerField;
    StringField8: TStringField;
    FdMemDashBoard06: TFDMemTable;
    StringField9: TStringField;
    IntegerField5: TIntegerField;
    StringField10: TStringField;
    FdMemDashBoard07: TFDMemTable;
    StringField11: TStringField;
    IntegerField6: TIntegerField;
    StringField12: TStringField;
    FdMemDashBoard08: TFDMemTable;
    StringField13: TStringField;
    IntegerField7: TIntegerField;
    StringField14: TStringField;
    ActInventario: TAction;
    ActRelEstoque: TAction;
    Label1: TLabel;
    ActReposicao: TAction;
    ActMessage: TAction;
    LblServereXactWMS: TLabel;
    ActRelMapaCarga: TAction;
    ActCortes: TAction;
    ActRelCheckOut_Sobras: TAction;
    ActRelMapaSeparacao: TAction;
    ActRelResumoProducao: TAction;
    ActEvolucaoRessuprimento: TAction;
    ActCorrecaoLotes: TAction;
    ActRelRecebimentos: TAction;
    ActRelProdutos: TAction;
    ActDashExpedicao: TAction;
    ActAuditSaidaPorProduto: TAction;
    ActDashCheckOut: TAction;
    PnlIconesExtras: TPanel;
    ImgRhemasys: TImage;
    Image1: TImage;
    ImgNovidades: TImage;
    ActDshRecebimentos: TAction;
    ActRelReposicao: TAction;
    ActRelMovimentacao: TAction;
    ActSegregadoBaixa: TAction;
    ActMotivoSegregado: TAction;
    ActAuditoriaVolumes: TAction;
    ActAuditoriaCortes: TAction;
    ActCadCategoria: TAction;
    ActProdutoLinha: TAction;
    ActDshVolumesEvolucao: TAction;
    NotificationCenter1: TNotificationCenter;
    ActAuditoriaMonitorLog: TAction;
    ActDshInventarios: TAction;
    ActRelInventario: TAction;
    ActDshAcompanhamentoCheckIn: TAction;
    ActRelUsuarios: TAction;
    procedure ImgCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure ActRecebimentoExecute(Sender: TObject);
    procedure ActFornecedorExecute(Sender: TObject);
    procedure ActProdutoExecute(Sender: TObject);
    procedure ActMovimentacaoExecute(Sender: TObject);
    procedure ActClientesExecute(Sender: TObject);
    procedure ActRelTAGExecute(Sender: TObject);
    procedure ActLaboratorioExecute(Sender: TObject);
    procedure ActConfiguracaoExecute(Sender: TObject);
    Procedure TrimAppMemorySize;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmHoraAtualTimer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgMenuClick(Sender: TObject);
    procedure ActContrAcessoUsuarioExecute(Sender: TObject);
    procedure ActPedidoCubagemExecute(Sender: TObject);
    procedure ActRotasExecute(Sender: TObject);
    procedure ActVolumeEmbalagemExecute(Sender: TObject);
    procedure ActRelEnderecamentoExecute(Sender: TObject);
    procedure ActRelPedidosExecute(Sender: TObject);
    procedure ActContrAcessoTopicosExecute(Sender: TObject);
    procedure ActContrAcessoFuncionalidadesExecute(Sender: TObject);
    procedure ActContrAcessoPerfilExecute(Sender: TObject);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure FormResize(Sender: TObject);
    procedure ActTransportadoraExecute(Sender: TObject);
    procedure ActVeiculosExecute(Sender: TObject);
    procedure ActMotoristaExecute(Sender: TObject);
    procedure ActSeparacaoExecute(Sender: TObject);
    procedure ActCheckOutExecute(Sender: TObject);
    procedure ActExpedicaoExecute(Sender: TObject);
    procedure ActRelPlanilhaCegaExecute(Sender: TObject);
    procedure ActExpedicaoCargaMontarExecute(Sender: TObject);
    procedure ActExpedicaoCargaCarregarExecute(Sender: TObject);
    procedure ActRelReposicaoDemandaExecute(Sender: TObject);
    procedure ActRelRupturaAbastecimentoExecute(Sender: TObject);
    procedure ActRelColetaPulmaoExecute(Sender: TObject);
    procedure ActRelApanhePickingExecute(Sender: TObject);
    procedure ActRelAnaliseRessuprimentoExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActInventarioExecute(Sender: TObject);
    procedure ActRelEstoqueExecute(Sender: TObject);
    procedure ActReposicaoExecute(Sender: TObject);
    procedure ActEnderecamentoExecute(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure ActDevolucaoExecute(Sender: TObject);
    procedure ActRelMapaCargaExecute(Sender: TObject);
    procedure ActCortesExecute(Sender: TObject);
    procedure ActRelCheckOut_SobrasExecute(Sender: TObject);
    procedure ActRelMapaSeparacaoExecute(Sender: TObject);
    procedure ActRelResumoProducaoExecute(Sender: TObject);
    procedure ActEvolucaoRessuprimentoExecute(Sender: TObject);
    procedure ActCorrecaoLotesExecute(Sender: TObject);
    procedure ActRelRecebimentosExecute(Sender: TObject);
    procedure ActRelProdutosExecute(Sender: TObject);
    procedure ActDashSeparacaoExecute(Sender: TObject);
    procedure ActDashExpedicaoExecute(Sender: TObject);
    procedure ActAuditSaidaPorProdutoExecute(Sender: TObject);
    procedure ActDashCheckOutExecute(Sender: TObject);
    procedure ImgNovidadesClick(Sender: TObject);
    procedure ActDshRecebimentosExecute(Sender: TObject);
    procedure ActRelMovimentacaoExecute(Sender: TObject);
    procedure ActSegregadoBaixaExecute(Sender: TObject);
    procedure ActMotivoSegregadoExecute(Sender: TObject);
    procedure ActAuditoriaVolumesExecute(Sender: TObject);
    procedure ActAuditoriaCortesExecute(Sender: TObject);
    procedure ActCadCategoriaExecute(Sender: TObject);
    procedure ActProdutoLinhaExecute(Sender: TObject);
    procedure ActDshVolumesEvolucaoExecute(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject;
      ANotification: TNotification);
    procedure ActAuditoriaMonitorLogExecute(Sender: TObject);
    procedure ActDshInventariosExecute(Sender: TObject);
    procedure ActRelInventarioExecute(Sender: TObject);
    procedure ActDshAcompanhamentoCheckInExecute(Sender: TObject);
    procedure ActRelUsuariosExecute(Sender: TObject);
  private
    { Private declarations }
    NovaVersao : Boolean;
    AtzApp     : String;
    Atual      : String;
    vSysInfo : tSysInfo;
    Procedure AtualizarVersao;
    Procedure LogOn(pManterAcesso : Boolean = False);
    Procedure LogEndApp;
    procedure Grafico01;
    procedure GetDashBoardAsynch;
    procedure ProcessarGetErro(Sender : TObject);
    procedure GetDadosGrafico01;
    procedure GetProducaoPendente;
    procedure GetDadosGrafico060708;
    procedure ThreadTerminate(Sender: TObject);
    Procedure ShowNovidades(pJsonArrayNovidades : TJsonArray);
    Procedure Backup;
    procedure ThreadTerminateBackup(Sender: TObject);
    Procedure ThreadManutencaoLogsTerminate(Sender: TObject);
    Procedure Notificacaostandand(pTitle, pMensagem : String);
    function NeweXactWMS: Boolean;
    procedure ShowNotificationNews;
    Procedure GetDelLog;
    procedure ManutencaoLogs;
  public
    { Public declarations }
    TpPessoa : TTpPessoa;
    cancelado : Boolean;
    Tempo : Integer;
    ModuleOpcao, ModuleItem, PathApp : AnsiString;
    CodMenu    : String;
    ConfigWMS  : TConfiguracaoCtrl;
    //TpPessoa   : TTpPessoa;
    ObjUsuarioCtrl : TUsuarioCtrl;
    BASEURL, BASEURLREPORT : String;
    AcessoBloqueado : boolean;
    Usuario_AutorizadorOperacao : Integer;
    Function ConfirmaManutencao(vAcao : String) : Boolean;
    Procedure TrataErro(Sender :TObject; E:Exception);
    Function VerAcesso(CodMenu : String) : Boolean;
    function NewLogIn: Boolean;
  end;

var
  FrmeXactWMS: TFrmeXactWMS;
//  FrmForn    : TFrmPessoa;

implementation

uses
  uFrmProduto, uFrmLogin,
  UFrmConfirmacao, uFrmLaboratorio, uFrmSair, uFrmControleArmazenagem,
  uFrmEntrada, uFrmConfiguracao, uFuncoes, uFrmUsuario, uFrmPedidoCubagem,
  uFrmRotas, uFrmVolumeEmbalagem, uFrmPrintTAG, uFrmSeparacaoDesktop,
  uFrmFREnderecamentos, uFrmRelPedidos, uFrmTopicos, FuncionalidadeClass,
  uFrmFuncionalidades, uFrmPerfil, uFrmFornecedor, uFrmTransportadora,
  uFrmVeiculo, uFrmMotorista, uFrmCheckOut, uFrmExpedicao, uFrmRelPlanilhaCega,
  uFrmCargaMontar, uDmeXactWMS, uFrmCargaCarregar, uFrmRelReposicaoDemanda,
  uFrmRelRupturaAbastecimento, uFrmRelColetaPulmao, uFrmRelApanhePicking,
  uFrmRelAnaliseRessuprimento, Charts.Types, TypInfo
  , PedidoSaidaCtrl, uFrmRelestoque, uLibThreadCustom, uFrmReposicao,
  uFrmEnderecamento, uFrmInventario, uFrmEnderecamentoMenu, uFrmDevolucao,
  eXactWMSDAO, uFrmRelMapaCarga, uFrmRelCortes, uFrmChekOut_Sobra,
  uFrmRelMapaSeparacao, uFrmRelResumoProducao, uFrmRelEvolucaoRessuprimentos,
  uFrmCorrecaoLotes, uFrmRelRecebimentos, uFrmRelProdutos,
  uFrmRelReposicaoColeta, uFrmRelResumoSeparacao, uFrmRelDesempenhoExpedicao,
  uFrmAuditoriaSaidaPorProduto, uFrmRelDshCheckOut, NovidadesCtrl,
  uFrmNovidades, Service.Novidades, uFrmCadCategoria, uFrmMonitorLog;

{$R *.dfm}

function FileTimeToDTime(FTime: TFileTime): TDateTime;
var
  LocalFTime: TFileTime;
  STime: TSystemTime;
begin
  FileTimeToLocalFileTime(FTime, LocalFTime);
  FileTimeToSystemTime(LocalFTime, STime);
  Result := SystemTimeToDateTime(STime);
end;

Function VersaoExe(Const FileName : String) : String;
Type
  TVersionInfo = Packed Record
    Dummy : Array[0..7] Of Byte;
    v2, v1, v3, v4 : Word;
  End;
Var Zero, Size : Cardinal;
    Data : Pointer;
    VersionInfo : ^TVersionInfo;
Begin
  Size := GetFileVersionInfoSize(Pointer(FileName), Zero);
  if Size = 0 then
     Result := ''
  Else Begin
     GetMem(Data, Size);
     Try
       GetFileVersionInfo(Pointer(FileName), 0, Size, Data);
       VerQueryValue(Data, '\', Pointer(VersionInfo), Size);
       Result := Format('%d.%d.%d.%d.', [VersionInfo.V1, VersionInfo.v2, VersionInfo.V4, VersionInfo.V3]);
     Finally
       FreeMem(Data);
     End;
  End;
End;

//Executa um Aplicativo
Function CreateProcessSimple(Cmd : String) : Boolean;
Var SUinfo : TStartUpInfo;
    ProcInfo : TProcessInformation;
begin
  FillChar(SUInfo, SizeOf(SUInfo), #0);
  SUInfo.Cb      := SizeOf(SUInfo);
  SUInfo.dwFlags := STARTF_USESHOWWINDOW;
  SUInfo.wShowWIndow := SW_SHOWNORMAL;
  Result := CreateProcess(Nil,
                          pChar(Cmd),
                          Nil, Nil, False,
                          CREATE_NEW_CONSOLE or
                          NORMAL_PRIORITY_CLASS,
                          Nil, Nil, SUInfo,
                          ProcInfo);
  if Result then Begin
     CloseHandle(ProcInfo.hProcess);
     CloseHandle(ProcInfo.hThread);
  End;
End;

procedure TFrmeXactWMS.ActRelResumoProducaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Resumo Produ��o') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelResumoProducao) = False) then
     begin
       FrmRelResumoProducao := TFrmRelResumoProducao.Create(Application);
     end;
   try
     FrmRelResumoProducao.Module     := 'Relat�rios';
     FrmRelResumoProducao.ModuleMenu := 'Resumo da Produ��o';//+#39+'s';
     FrmRelResumoProducao.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelResumoProducao);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActAuditoriaCortesExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Auditoria - Cortes') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelAuditoriaCortes) = False) then
    begin
      FrmRelAuditoriaCortes := TFrmRelAuditoriaCortes.Create(Application);
    end;
  try
    FrmRelAuditoriaCortes.Module     := 'Auditoria';
    FrmRelAuditoriaCortes.ModuleMenu := 'Cortes';
    FrmRelAuditoriaCortes.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelAuditoriaCortes);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActAuditoriaMonitorLogExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Fun��es Extra - Monitor de Log') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmMonitorLog) = False) then
    begin
      FrmMonitorLog := TFrmMonitorLog.Create(Application);
    end;
  try
    FrmMonitorLog.Module     := 'Auditoria';
    FrmMonitorLog.ModuleMenu := 'Monitor de Log'+#39+'s';
    FrmMonitorLog.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmMonitorLog);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActAuditoriaVolumesExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Auditoria - Volumes') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelAuditoriaVolumes) = False) then
    begin
      FrmRelAuditoriaVolumes := TFrmRelAuditoriaVolumes.Create(Application);
    end;
  try
    FrmRelAuditoriaVolumes.Module     := 'Auditoria';
    FrmRelAuditoriaVolumes.ModuleMenu := 'Volumes';
    FrmRelAuditoriaVolumes.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelAuditoriaVolumes);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActAuditSaidaPorProdutoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Auditoria - Saida por Produto') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmAuditoriaSaidaPorProduto) = False) then
    begin
      FrmAuditoriaSaidaPorProduto := TFrmAuditoriaSaidaPorProduto.Create(Application);
    end;
  try
    FrmAuditoriaSaidaPorProduto.Module     := 'Auditoria';
    FrmAuditoriaSaidaPorProduto.ModuleMenu := 'Sa�da por Produto';
    FrmAuditoriaSaidaPorProduto.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmAuditoriaSaidaPorProduto);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActCadCategoriaExecute(Sender: TObject);
begin
//  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Categorias') then
//     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmCadCategoria) = False) then
    begin
      FrmCadCategoria := TFrmCadCategoria.Create(Application);
    end;
  try
    FrmCadCategoria.Module     := 'Cadastro';
    FrmCadCategoria.ModuleMenu := 'Categorias de Produtos';
    FrmCadCategoria.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCadCategoria);
      raise Exception.Create(e.Message);
    end;
  end;

end;

procedure TFrmeXactWMS.ActCheckOutExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Check-Out') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmCheckOut) = False) then
    begin
      FrmCheckOut := TFrmCheckOut.Create(Application);
    end;
  try
    FrmCheckOut.Module     := 'Produ��o';
    FrmCheckOut.ModuleMenu := 'CheckOut';
    FrmCheckOut.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCheckOut);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActClientesExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Pessoas - Lojas/Destinat�rio') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  TpPessoa   := Cliente;
  if (Assigned(FrmPessoa) = False) then
    begin
      FrmPessoa := TFrmPessoa.Create(Application);
    end;
  try
    FrmPessoa.Module     := 'Cadastro';
    FrmPessoa.ModuleMenu := 'Clientes - Lojas';
    FrmPessoa.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmPessoa);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActConfiguracaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Par�metriza��o do WMS') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmConfiguracao) = False) then
    begin
      FrmConfiguracao := TFrmConfiguracao.Create(Application);
    end;
  try
    FrmConfiguracao.Module     := 'Configura��o';
    FrmConfiguracao.ModuleMenu := 'Par�metros do WMS';
    FrmConfiguracao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmConfiguracao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActFornecedorExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Pessoas - Fornecedor') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  TpPessoa   := Fornecedor;
  if (Assigned(FrmFornecedor) = False) then Begin
     FrmFornecedor := TFrmFornecedor.Create(Application);
     End;
  try
    //FrmForn.ValidarAcesso;
    FrmFornecedor.Module     := 'Cadastro';
    FrmFornecedor.ModuleMenu := 'Fornecedor';
    FrmFornecedor.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmFornecedor);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActInventarioExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Invent�rio') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmInventario) = False) then
    begin
      FrmInventario := TFrmInventario.Create(Application);
    end;
  try
    FrmInventario.Module := 'Operacional';
    FrmInventario.ModuleMenu := 'Invent�rio';
    FrmInventario.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmInventario);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActLaboratorioExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Fabricantes') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmLaboratorio) = False) then
    begin
      FrmLaboratorio := TFrmLaboratorio.Create(Application);
    end;
  try
    //FrmLaboratorios.ValidarAcesso;
    FrmLaboratorio.Module := 'Cadastro';
    FrmLaboratorio.ModuleMenu := 'Fabricantes';
    FrmLaboratorio.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmLaboratorio);
      raise Exception.Create(e.Message);
    end;
  end;
end;
{ TFuncao }

class procedure TFuncao.CreateForm<xForm>;
var
  Form: xForm;
begin
  Application.CreateForm(xForm,Form);
  try
    form.ShowModal;
  finally
    form.Release;
  end;
end;

procedure TFrmeXactWMS.ActMotivoSegregadoExecute(Sender: TObject);
begin
 if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Configura��o - Causas dos Segregado') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmSegregadoCausa) = False) then
     FrmSegregadoCausa := TFrmSegregadoCausa.Create(Application);
  try
    FrmSegregadoCausa.Module     := 'Configura��o';
    FrmSegregadoCausa.ModuleMenu := 'Causas do Segregado';
    FrmSegregadoCausa.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmSegregadoCausa);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActMotoristaExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Motorista') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  TpPessoa   := Motorista;
  if (Assigned(FrmMotorista) = False) then
     FrmMotorista := TFrmMotorista.Create(Application);
  try
    FrmMotorista.Module     := 'Log�stica';
    FrmMotorista.ModuleMenu := 'Motorista';
    FrmMotorista.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmMotorista);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActMovimentacaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Armazenagem') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmControleArmazenagem) = False) then
     FrmControleArmazenagem := TFrmControleArmazenagem.Create(Application);
  try
    FrmControleArmazenagem.Module     := 'P.C.P - Ch�o de F�brica';
    FrmControleArmazenagem.ModuleMenu := 'Controle de Armazenamento';
    FrmControleArmazenagem.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmControleArmazenagem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActPedidoCubagemExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Processar Pedidos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmPedidoCubagem) = False) then
    begin
      FrmPedidoCubagem := TFrmPedidoCubagem.Create(Application);
    end;
  try
    //frmProdutoCadastrar.ValidarAcesso;
    FrmPedidoCubagem.Module := 'Ch�o de F�brica';
    FrmPedidoCubagem.ModuleMenu := 'Processar Pedidos';
    FrmPedidoCubagem.Show;
    //FrmProduto.EdtCodProduto.SetFocus;
  except on e: Exception do
    begin
      FreeAndNil(FrmPedidoCubagem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActProdutoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produtos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmProduto) = False) then
    begin
      FrmProduto := TFrmProduto.Create(Application);
    end;
  try
    //frmProdutoCadastrar.ValidarAcesso;
    FrmProduto.Module := 'Cadastro';
    FrmProduto.ModuleMenu := 'Produtos';
    FrmProduto.Show;
    //FrmProduto.EdtCodProduto.SetFocus;
  except on e: Exception do
    begin
      FreeAndNil(FrmProduto);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActProdutoLinhaExecute(Sender: TObject);
begin
//  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Categorias') then
//     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmProdutoLinha) = False) then
    begin
      FrmProdutoLinha := TFrmProdutoLinha.Create(Application);
    end;
  try
    FrmProdutoLinha.Module     := 'Cadastro';
    FrmProdutoLinha.ModuleMenu := 'Linha de Produtos';
    FrmProdutoLinha.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmProdutoLinha);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRecebimentoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Recebimentos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmEntrada) = False) then
    begin
      FrmEntrada := TFrmEntrada.Create(Application);
    end;
  try
    FrmEntrada.Module     := 'Cadastro';
    FrmEntrada.ModuleMenu := 'Recebimentos';
    FrmEntrada.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEntrada);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRelAnaliseRessuprimentoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - An�lise Ressuprimentos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelAnaliseRessuprimento) = False) then
     begin
       FrmRelAnaliseRessuprimento := TFrmRelAnaliseRessuprimento.Create(Application);
     end;
   try
     FrmRelAnaliseRessuprimento.Module     := 'Relat�rios';
     FrmRelAnaliseRessuprimento.ModuleMenu := 'An�lise de Ressuprimentos';//+#39+'s';
     FrmRelAnaliseRessuprimento.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelAnaliseRessuprimento);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelApanhePickingExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Resumo Separa��o Picking') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelApanhePicking) = False) then
     FrmRelApanhePicking := TFrmRelApanhePicking.Create(Application);
  try
    FrmRelApanhePicking.Module     := 'Relat�rios';
    FrmRelApanhePicking.ModuleMenu := 'Resumo Separa��o Picking';
    FrmRelApanhePicking.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelApanhePicking);
      raise Exception.Create(e.Message);
    end;
  end;


EXIT;



  With TFrmRelApanhePicking.Create(Self) do Try
     BtnImprimirStandClick(BtnImprimirStand);
  Finally
    Free;
  end;
end;

procedure TFrmeXactWMS.ActRelCheckOut_SobrasExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - CheckOut Sobras') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmCheckOut_Sobras) = False) then
     FrmCheckOut_Sobras := TFrmCheckOut_Sobras.Create(Application);
  try
    FrmCheckOut_Sobras.Module     := 'Relat�rios';
    FrmCheckOut_Sobras.ModuleMenu := 'CheckOut - Sobras';
    FrmCheckOut_Sobras.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCheckOut_Sobras);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRelColetaPulmaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Resumo Coleta Pulm�o') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelColetaPulmao) = False) then
     FrmRelColetaPulmao := TFrmRelColetaPulmao.Create(Application);
  try
    FrmRelColetaPulmao.Module     := 'Relat�rios';
    FrmRelColetaPulmao.ModuleMenu := 'Resumo Coleta Pulm�o';
    FrmRelColetaPulmao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelColetaPulmao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRelEnderecamentoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Endere�amentos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmFREnderecamentos) = False) then
     begin
       FrmFREnderecamentos := TFrmFREnderecamentos.Create(Application);
     end;
   try
     FrmFREnderecamentos.Module     := 'Relat�rios';
     FrmFREnderecamentos.ModuleMenu := 'Endere�amento';//+#39+'s';
     FrmFREnderecamentos.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmFREnderecamentos);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelEstoqueExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Estoque') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelEstoque) = False) then
     begin
       FrmRelEstoque := TFrmRelEstoque.Create(Application);
     end;
   try
     FrmRelEstoque.Module     := 'Relat�rios';
     FrmRelEstoque.ModuleMenu := 'Estoque';//+#39+'s';
     FrmRelEstoque.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelEstoque);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelInventarioExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Invent�rios') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelListaInventario) = False) then
     begin
       FrmRelListaInventario := TFrmRelListaInventario.Create(Application);
     end;
   try
     FrmRelListaInventario.Module     := 'Relat�rios';
     FrmRelListaInventario.ModuleMenu := 'Invent�rios';//+#39+'s';
     FrmRelListaInventario.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelListaInventario);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelMapaCargaExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Mapa de Carga') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelMapaCarga) = False) then
     begin
       FrmRelMapaCarga := TFrmRelMapaCarga.Create(Application);
     end;
   try
     FrmRelMapaCarga.Module     := 'Relat�rios';
     FrmRelMapaCarga.ModuleMenu := 'Cargas';//+#39+'s';
     FrmRelMapaCarga.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelMapaCarga);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelMapaSeparacaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Mapa Separa��o') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelMapaSeparacao) = False) then
     begin
       FrmRelMapaSeparacao := TFrmRelMapaSeparacao.Create(Application);
     end;
   try
     FrmRelMapaSeparacao.Module     := 'Relat�rios';
     FrmRelMapaSeparacao.ModuleMenu := 'Mapa de Separa��o(Fracionados)';//+#39+'s';
     FrmRelMapaSeparacao.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelMapaSeparacao);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelMovimentacaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Armazenamento') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelControleArmazenagem) = False) then
     begin
       FrmRelControleArmazenagem := TFrmRelControleArmazenagem.Create(Application);
     end;
   try
     FrmRelControleArmazenagem.Module     := 'Relat�rios';
     FrmRelControleArmazenagem.ModuleMenu := 'Controle de Armazenagem';//+#39+'s';
     FrmRelControleArmazenagem.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelControleArmazenagem);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelPedidosExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Pedidos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelPedidos) = False) then
     begin
       FrmRelPedidos := TFrmRelPedidos.Create(Application);
     end;
   try
     FrmRelPedidos.Module     := 'Relat�rios';
     FrmRelPedidos.ModuleMenu := 'Pedidos';//+#39+'s';
     FrmRelPedidos.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelPedidos);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelPlanilhaCegaExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Planilha Cega') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   if (Assigned(FrmRelPlanilhaCega) = False) then
     begin
       FrmRelPlanilhaCega := TFrmRelPlanilhaCega.Create(Application);
     end;
   try
     FrmRelPlanilhaCega.Module     := 'Relat�rios';
     FrmRelPlanilhaCega.ModuleMenu := 'Planilha Cega';
     FrmRelPlanilhaCega.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelPlanilhaCega);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelProdutosExecute(Sender: TObject);
begin
//  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Produtos') then
//     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelProdutos) = False) then
     FrmRelProdutos := TFrmRelProdutos.Create(Application);
  try
    FrmRelProdutos.Module     := 'Relat�rios';
    FrmRelProdutos.ModuleMenu := 'Produtos';
    FrmRelProdutos.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelProdutos);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRelRecebimentosExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Recebimentos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelRecebimentos) = False) then
     FrmRelRecebimentos := TFrmRelRecebimentos.Create(Application);
  try
    FrmRelRecebimentos.Module     := 'Relat�rios';
    FrmRelRecebimentos.ModuleMenu := 'Recebimentos';
    FrmRelRecebimentos.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelRecebimentos);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRelReposicaoDemandaExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Reposi��o Demanda') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelReposicaoColeta) = False) then
    begin
      FrmRelReposicaoColeta := TFrmRelReposicaoColeta.Create(Application);
    end;
  try
    FrmRelReposicaoColeta.Module     := 'Relat�rios';
    FrmRelReposicaoColeta.ModuleMenu := 'Reposi��o Demanda';//+#39+'s';
    FrmRelReposicaoColeta.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelReposicaoColeta);
      raise Exception.Create(e.Message);
    end;
  end;
{
   if (Assigned(FrmRelReposicaoDemanda) = False) then
     begin
       FrmRelReposicaoDemanda := TFrmRelReposicaoDemanda.Create(Application);
     end;
   try
     FrmRelReposicaoDemanda.Module     := 'Relat�rios';
     FrmRelReposicaoDemanda.ModuleMenu := 'Reposi��o Demanda';//+#39+'s';
     FrmRelReposicaoDemanda.Show;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelReposicaoDemanda);
       raise Exception.Create(e.Message);
     end;
   end;
}
end;

procedure TFrmeXactWMS.ActRelRupturaAbastecimentoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Ruptura no Abastecimento') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelRupturaAbastecimento) = False) then
    begin
      FrmRelRupturaAbastecimento := TFrmRelRupturaAbastecimento.Create(Application);
    end;
  try
    FrmRelRupturaAbastecimento.Module     := 'Relat�rios';
    FrmRelRupturaAbastecimento.ModuleMenu := 'Ruptura no Abastecimento';//+#39+'s';
    FrmRelRupturaAbastecimento.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelRupturaAbastecimento);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRelTAGExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Impress�o de TAG') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
   inherited;
   if (Assigned(frmPrintTAG) = False) then
     begin
       frmPrintTAG := TfrmPrintTAG.Create(Application);
     end;
   try
     FrmPrintTAG.Module     := 'Relat�rios';
     FrmPrintTAG.ModuleMenu := 'Impress�o Tag';//+#39+'s';
     FrmPrintTAG.Show;
   except on e: Exception do
     begin
       FreeAndNil(frmPrintTAG);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmeXactWMS.ActRelUsuariosExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rio - Usuarios') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelUsuarios) = False) then
    begin
      FrmRelUsuarios := TFrmRelUsuarios.Create(Application);
    end;
  try
    FrmRelUsuarios.Module     := 'Relat�rio';
    FrmRelUsuarios.ModuleMenu := 'Usu�rios';
    FrmRelUsuarios.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelUsuarios);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActReposicaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Reposi��o de picking') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmReposicao) = False) then
    begin
      FrmReposicao := TFrmReposicao.Create(Application);
    end;
  try
    FrmReposicao.Module     := 'Ch�o de F�brica';
    FrmReposicao.ModuleMenu := 'Reposi��o por Demanda/Capacidade';
    FrmReposicao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmReposicao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActRotasExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Rotas') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRotas) = False) then
    begin
      FrmRotas := TFrmRotas.Create(Application);
    end;
  try
    FrmRotas.Module     := 'Log�stica';
    FrmRotas.ModuleMenu := 'Rotas';
    FrmRotas.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRotas);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActSegregadoBaixaExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Segregado - Baixa') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmSegregadoBaixa) = False) then
    begin
      FrmSegregadoBaixa := TFrmSegregadoBaixa.Create(Application);
    end;
  try
    FrmSegregadoBaixa.Module     := 'Operacional';
    FrmSegregadoBaixa.ModuleMenu := 'Segregado - Baixa';
    FrmSegregadoBaixa.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmSegregadoBaixa);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActSeparacaoExecute(Sender: TObject);
begin
  raise Exception.Create('Funcionalidade Desativada!');
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Apanhe - Separa��o') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmSeparacaoDesktop) = False) then
    begin
      FrmSeparacaoDesktop := TFrmSeparacaoDesktop.Create(Application);
    end;
  try
    FrmSeparacaoDesktop.Module     := 'Produ��o';
    FrmSeparacaoDesktop.ModuleMenu := 'Apanhe - Separa��o';
    FrmSeparacaoDesktop.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmSeparacaoDesktop);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActTransportadoraExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Transportadora') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  TpPessoa   := Transportadora;
  if (Assigned(FrmTransportadora) = False) then
    begin
      FrmTransportadora := TFrmTransportadora.Create(Application);
    end;
  try
    FrmTransportadora.Module     := 'Log�stica';
    FrmTransportadora.ModuleMenu := 'Transportadoras';
    FrmTransportadora.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmTransportadora);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActContrAcessoFuncionalidadesExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Funcionalidades') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmFuncionalidades) = False) then
    begin
      FrmFuncionalidades := TFrmFuncionalidades.Create(Application);
    end;
  try
    FrmFuncionalidades.Module     := 'Controle de Acesso';
    FrmFuncionalidades.ModuleMenu := 'Funcionalidades';
    FrmFuncionalidades.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmFuncionalidades);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActContrAcessoPerfilExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Perfil do Usu�rio') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(Frmperfil) = False) then
    begin
      Frmperfil := TFrmperfil.Create(Application);
    end;
  try
    Frmperfil.Module     := 'Controle de Acesso';
    Frmperfil.ModuleMenu := 'Perfil de Usu�rio';
    Frmperfil.Show;
  except on e: Exception do
    begin
      FreeAndNil(Frmperfil);
      raise Exception.Create(e.Message);
    end;
  end;end;

procedure TFrmeXactWMS.ActContrAcessoTopicosExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('T�picos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmTopicos) = False) then
    begin
      FrmTopicos := TFrmTopicos.Create(Application);
    end;
  try
    FrmTopicos.Module     := 'Controle de Acesso';
    FrmTopicos.ModuleMenu := 'T�picos';
    FrmTopicos.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmTopicos);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActContrAcessoUsuarioExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Usu�rios') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmUsuario) = False) then
    begin
      FrmUsuario := TFrmUsuario.Create(Application);
    end;
  try
    FrmUsuario.Module     := 'Configura��o';
    FrmUsuario.ModuleMenu := 'Usu�rio';
    FrmUsuario.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmUsuario);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActCorrecaoLotesExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Cadastro - Corre��o de Lotes') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmCorrecaoLotes) = False) then
     FrmCorrecaoLotes := TFrmCorrecaoLotes.Create(Application);
  try
    FrmCorrecaoLotes.Module     := 'Cadastro';
    FrmCorrecaoLotes.ModuleMenu := 'Corre��o de Lotes';
    FrmCorrecaoLotes.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCorrecaoLotes);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActCortesExecute(Sender: TObject);
begin
//  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relat�rios - Cortes') then
//     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelCortes) = False) then
     FrmRelCortes := TFrmRelCortes.Create(Application);
  try
    FrmRelCortes.Module     := 'Relat�rios';
    FrmRelCortes.ModuleMenu := 'Cortes';
    FrmRelCortes.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelCortes);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActDashExpedicaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Dashboard-Expedi��o') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelDesempenhoExpedicao) = False) then
     FrmRelDesempenhoExpedicao := TFrmRelDesempenhoExpedicao.Create(Application);
  try
    FrmRelDesempenhoExpedicao.Module     := 'DashBoard';
    FrmRelDesempenhoExpedicao.ModuleMenu := 'Expedi��o';
    FrmRelDesempenhoExpedicao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelDesempenhoExpedicao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActDashSeparacaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Dashboard-Separa��o') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelResumoSeparacao) = False) then
     FrmRelResumoSeparacao := TFrmRelResumoSeparacao.Create(Application);
  try
    FrmRelResumoSeparacao.Module     := 'DashBoard';
    FrmRelResumoSeparacao.ModuleMenu := 'Separa��o';
    FrmRelResumoSeparacao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelResumoSeparacao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActDevolucaoExecute(Sender: TObject);
begin
  //if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Devolucao') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmDevolucao) = False) then
     FrmDevolucao := TFrmDevolucao.Create(Application);
  try
    FrmDevolucao.Module      := 'Operacional';
    FrmDevolucao.ModuleMenu := 'Devolu��o';
    FrmDevolucao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmDevolucao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActDshAcompanhamentoCheckInExecute(Sender: TObject);
begin
//  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Dashboard - Acompanhamenhto CheckIn') then
//     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmAuditoriaAcompanhamentoCheckIn) = False) then
     FrmAuditoriaAcompanhamentoCheckIn := TFrmAuditoriaAcompanhamentoCheckIn.Create(Application);
  try
    FrmAuditoriaAcompanhamentoCheckIn.Module     := 'DashBoard';
    FrmAuditoriaAcompanhamentoCheckIn.ModuleMenu := 'Acompanhamento CheckIn';
    FrmAuditoriaAcompanhamentoCheckIn.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmAuditoriaAcompanhamentoCheckIn);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActDshInventariosExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Dashboard - Invent�rios') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmDshInventarios) = False) then
     FrmDshInventarios := TFrmDshInventarios.Create(Application);
  try
    FrmDshInventarios.Module     := 'DashBoard';
    FrmDshInventarios.ModuleMenu := 'Invent�rios';
    FrmDshInventarios.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmDshInventarios);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActDshRecebimentosExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('DashBoard - Recebimentos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmDshRecebimentos) = False) then
     FrmDshRecebimentos := TFrmDshRecebimentos.Create(Application);
  try
    FrmDshRecebimentos.Module     := 'DashBoard';
    FrmDshRecebimentos.ModuleMenu := 'Recebimentos';
    FrmDshRecebimentos.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmDshRecebimentos);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActDashCheckOutExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('DashBoard - Checkout') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelDshCheckOut) = False) then
     FrmRelDshCheckOut := TFrmRelDshCheckOut.Create(Application);
  try
    FrmRelDshCheckOut.Module     := 'DashBoard';
    FrmRelDshCheckOut.ModuleMenu := 'CheckOut';
    FrmRelDshCheckOut.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmRelDshCheckOut);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActExpedicaoCargaMontarExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Carga - Montar') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmCargaMontar) = False) then
     FrmCargaMontar := TFrmCargaMontar.Create(Application);
  try
    FrmCargaMontar.Module     := 'Expedi��o';
    FrmCargaMontar.ModuleMenu := 'Montar Carga';
    FrmCargaMontar.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCargaMontar);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActEnderecamentoExecute(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endere�amento CD')) and
     (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endere�amentos - Manuten��o')) then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');

  if (Assigned(FrmEnderecamentoMenu) = False) then
     FrmEnderecamentoMenu := TFrmEnderecamentoMenu.Create(Application);
  try
    FrmEnderecamentoMenu.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEnderecamentoMenu);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActEvolucaoRessuprimentoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Dashboard - Evolu��o dos Ressuprimentos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmRelEvolucaoRessuprimentos) = False) then
     FrmRelEvolucaoRessuprimentos := TFrmRelEvolucaoRessuprimentos.Create(Application);
  try
    FrmRelEvolucaoRessuprimentos.Module     := 'Relat�rios';
    FrmRelEvolucaoRessuprimentos.ModuleMenu := 'Evolu��o dos Ressuprimentos';
    FrmRelEvolucaoRessuprimentos.Show;
  except on e: Exception do Begin
    FreeAndNil(FrmRelEvolucaoRessuprimentos);
    raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActExpedicaoCargaCarregarExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Carga - Carregar') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmCargaCarregar) = False) then
     FrmCargaCarregar := TFrmCargaCarregar.Create(Application);
  try
    FrmCargaCarregar.Module     := 'Expedi��o';
    FrmCargaCarregar.ModuleMenu := 'Carregar Carga';
    FrmCargaCarregar.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmCargaCarregar);
      raise Exception.Create(e.Message);
    end;
  end;

end;

procedure TFrmeXactWMS.ActExpedicaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Expedi��o - Registrar Volume') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmExpedicao) = False) then
     FrmExpedicao := TFrmExpedicao.Create(Application);
  try
    FrmExpedicao.Module     := 'Expedi��o';
    FrmExpedicao.ModuleMenu := 'Registrar Volume';
    FrmExpedicao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmExpedicao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActVeiculosExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Ve�culos') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmVeiculo) = False) then
    begin
      FrmVeiculo := TFrmVeiculo.Create(Application);
    end;
  try
    FrmVeiculo.Module     := 'Log�stica';
    FrmVeiculo.ModuleMenu := 'Ve�culos';
    FrmVeiculo.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmVeiculo);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ActVolumeEmbalagemExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Embalagem para Volumes(Caixas)') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmVolumeEmbalagem) = False) then
    begin
      FrmVolumeEmbalagem := TFrmVolumeEmbalagem.Create(Application);
    end;
  try
    FrmVolumeEmbalagem.Module     := 'Log�stica';
    FrmVolumeEmbalagem.ModuleMenu := 'Embalagem - Volumes';
    FrmVolumeEmbalagem.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmVolumeEmbalagem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.ApplicationEvents1Exception(Sender: TObject;
  E: Exception);
Var oLogger: TLoggerSingleton;
begin
   oLogger := TLoggerSingleton.ObterInstancia;
   oLogger.RegistrarLog('    Erro: '+E.Message +' �s '+ Copy(TimeToStr(Time()),1,5)+'h.');
end;

procedure TFrmeXactWMS.AtualizarVersao;
Var Update : String;
    Str : TStrings;
    VersaoAtual, VersaoNova : String;
begin
  if DebugHook <> 0 Then Begin
// N�o atualizar automaticamente
     NovaVersao := False;
     Exit;
  End;
  NovaVersao := False;
  Str := TStringList.Create;
  Str.LoadFromFile(ExtractFilePath(ParamStr(0))+'\ConfigAtualizador.dat');

  Atual  := ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0));
  Update := Str[0];
  AtzApp := ExtractFilePath(ParamStr(0))+'Atualizador.Exe';
  if FileExists(Atual) then Begin
     if FileExists(Update) then Begin
        VersaoAtual := StringReplace(VersaoExe(Atual), '.', '0', [rfReplaceAll]);
        VersaoNova  := StringReplace(VersaoExe(Update), '.', '0', [rfReplaceAll]);
        if StringReplace(VersaoExe(Atual), '.', '0', [rfReplaceAll]) < StringReplace(VersaoExe(Update), '.', '0', [rfReplaceAll]) then Begin
//           ShowMessage('Existem uma nova atualiza��o do Software(Atual: '+VersaoExe(Atual)+'  Nova: '+VersaoExe(Update)+'). Vamos atualizar agora!!!');

           With TFrmConfirmacao.Create(Self) do Try
             Mensag1.Caption := 'Atualiza��o de Vers�o';
             Mensag2.Caption := 'Deseja atualizar agora?';
             ImgOk.Visible         := False;
             BtnOk.Visible         := False;
             PctSim.Visible        := True;
             LblConfirmSim.Visible := True;
             PctNao.Visible        := True;
             LblConfirmNao.Visible := True;
             If ShowModal = MrOk Then Begin
                NovaVersao := True;
                Close;
                End
             Else Begin
                NovaVersao := False;
                //abort;
                //Exit;
             End;
           Finally
             Free;
           end;
           if novaVersao then
              Close;
//           if Not FileExists(AtzApp) then MessageDlg('Existe uma vers�o atualizada.'+#13+#10+
//              'Arquivo Atualizador n�o existe.'+#13+'O Software n�o pode ser atualizado automaticamente.', MtWarning, [MbOk], 0);
//           NovaVersao := True;
//           Close;
        End;
     End
     Else Begin
//       ShowMessage('Sem Atualiza��o.');//;'Erro: Vers�o de Atualiza��o '+Update+' n�o foi encontrada.');
       exit;
     End;
     Caption := 'eXactWMS '+VersaoExe(Atual);
     Str.Free;
  End;
end;

procedure TFrmeXactWMS.Backup;
Var Th: TThread;
begin
   Notificacaostandand('Backup de Dados!', 'Backup sendo realizado!');
   Th := TThread.CreateAnonymousThread(procedure
      Var JsonRetorno : TJsonObject;
          vErro : String;
   begin
     JsonRetorno := TJsonObject.Create;
     JsonRetorno := ConfigWMS.DoBackup;
     if JsonRetorno.TryGetValue('Erro', vErro) then Begin
        raise Exception.Create('Erro: '+vErro);
        //JsonRetorno.Free;
     End;
     //JsonRetorno.Free;
   End);
   Th.OnTerminate := ThreadTerminateBackup;
   Th.Start;
end;

procedure TFrmeXactWMS.ManutencaoLogs;
Var Th: TThread;
    JsonObjectRetorno : TJsonObject;
    vErro : String;
begin
   Notificacaostandand('Manuten��o de Log(s)!', 'Apagar Log+'#39+'s antigos!');
   Th := TThread.CreateAnonymousThread(procedure
   begin
      JsonObjectRetorno := ConfigWMS.ManutencaoLog;
      if JsonObjectRetorno.TryGetValue('Erro', vErro) then Begin
         JsonObjectRetorno := Nil;//GetDelLog;
         raise Exception.Create(vErro);
      End;
     JsonObjectRetorno := Nil;//GetDelLog;
   End);
   Th.OnTerminate := ThreadManutencaoLogsTerminate;
   Th.Start;
end;

function TFrmeXactWMS.ConfirmaManutencao(vAcao: String): Boolean;
begin
  Result := False;
  With TFrmConfirmacao.Create(Self) do Try
    If vAcao = 'Upd' Then
    Begin
      Mensag1.Caption := 'Salvar Dados';
      Mensag2.Caption := 'Todos os Dados ser�o salvos';
      ImgOk.Visible   := True;
    End
    Else if vAcao = 'Del' Then
    Begin
      Mensag1.Caption := 'Excluir Dados';
      Mensag2.Caption := 'Todos os dados ser�o apagados';
      ImgOk.Visible   := True;
    End
    Else if vAcao = 'Canc' then
    Begin
      Mensag1.Caption := 'Cancelar Digita��o.';
      Mensag2.Caption := 'Os dados digitados ser�o perdidos...';
      ImgCancel.Visible   := True;
    End
    Else if vAcao = 'Backup' then
    Begin
      Mensag1.Caption := 'Backup Banco de Dados.';
      Mensag2.Caption := 'Garanta a seguran�a das informa��es...';
      ImgCancel.Visible   := True;
    End
    Else
      Exit;

    If ShowModal = MrOk Then Begin
       Self.Cancelado := False;
       Result := True;
       End
    Else Begin
       abort;
       Self.Cancelado := True;
       Result := False;
       Exit;
    End;
  Finally
    Free;
  end;
end;

procedure TFrmeXactWMS.ActDshVolumesEvolucaoExecute(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Dashboard-Volumes Evolu��o') then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  if (Assigned(FrmDshVolumesEvolucao) = False) then
     FrmDshVolumesEvolucao := TFrmDshVolumesEvolucao.Create(Application);
  try
    FrmDshVolumesEvolucao.Module     := 'DashBoard';
    FrmDshVolumesEvolucao.ModuleMenu := 'Volumes Evolu��o';
    FrmDshVolumesEvolucao.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmDshVolumesEvolucao);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmeXactWMS.FormActivate(Sender: TObject);
begin
//  If DebugHook = 0  then
//   If Not AcessoBloqueado then
//      GetDashBoardaSynch;
end;

procedure TFrmeXactWMS.FormClose(Sender: TObject; var Action: TCloseAction);
var oLogger: TLoggerSingleton;
begin
  // obt�m a inst�ncia do Singleton para registrar um log
//  if (Not NovaVersao) and (MessageBox(Handle, 'Deseja SAIR do WMS?', 'Sair', MB_ICONQUESTION + MB_YESNO) = mrNo) then
//      Abort;
  oLogger := TLoggerSingleton.ObterInstancia;
  oLogger.RegistrarLog(ObjUsuarioCtrl.ObjUsuario.Nome+', encerrou a aplica��o �s '+Copy(TimeToStr(Time()),1,5)+'h.'+#13+#13);
  oLogger := Nil;
  action := caFree;
  Try
    ObjUsuarioCtrl.LogOff;
  Except
  End;
  if NovaVersao then
     CreateProcessSimple(AtzApp);
end;

procedure TFrmeXactWMS.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if NovaVersao then
     CanClose := True
  Else Begin
    CanClose := NewLogIn;
    //CanClose := False;
  End;
end;

Function TFrmeXactWMS.NewLogIn : Boolean;
Var vModalResult : TModalResult;
Begin
  With TFrmSair.Create(self) do
    Try
      vmodalResult := ShowModal;
      if vModalResult = MrOk then Begin
         LogEndApp;
         Result := True;
         Application.Terminate;
      End
      else if vModalResult = mrIgnore then Begin // [mrRetry, mrNone] then
         Result := False;
      End
      Else if vModalResult = mrAbort then Begin //Trocar Usu�rio
         Result := False;
         Try
           ObjUsuarioCtrl.LogOff;
         Except
         End;
         LogOn(False);
      End
      Else if vModalResult = mrRetry then Begin //Bloquear Acesso - Mesmo Usu�rio
         Result := False;
         LogOn(True);
      End;
      LblusuarioTop.Caption := ObjUsuarioCtrl.ObjUsuario.Nome;
    Finally
      Free;
    End;
End;

procedure TFrmeXactWMS.FormCreate(Sender: TObject);
Var ArqIni : TIniFile;
begin
 // FormatSettings.LongDateFormat := 'yyyy-mm-dd hh:mm:ss.zzz';
 // StrToDateTime('26/10/2022 21:56:55.617');
  BASEURL       := DmeXactWMS.BASEURL;
  BASEURLREPORT := DmeXactWMS.BASEURLREPORT;
  FormatSettings.ShortDateFormat := 'DD/MM/YYYY';
  FormatSettings.LongDateFormat  := 'yyyy-mm-dd hh:mm:ss.zzz'; //'DD/MM/YYYY';
  FormatSettings.ShortTimeFormat := 'hh:mm';
  FormatSettings.LongTimeFormat 	:= 'hh:mm:ss';
  Application.HelpFile := 'eXactWMS.chm';
  KeyPreview:= True;
  Application.OnException := TrataErro;
  PathApp := ExtractFilePath( Application.ExeName );
  Self.Menu := Nil;
   ConfigWMS    := TConfiguracaoCtrl.Create;
(*
   Try
     ConfigWMS.ObjConfiguracao   := ConfigWMS.GetConfiguracao[0];    //ConfigWMS.GetConfigWMS; //
 {
      if MD5Texto('189.112.121.58') <> ConfigWMS.ObjConfiguracao.Sqlclientnetaddress then Begin
         ShowMessage('Conex�o com servidor foi recusada. Entre em contato com a Rhemasys Solu��es.');
         Application.Terminate;
         Exit;
      End;
 }
     if fileexists(ExtractFilePath( Application.ExeName )+'eXactWMS.ini') then Begin
        ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.Ini');
        if ArqIni.ReadString('PRINTER', 'EtqCodBarra_Modelo', '') <> '' then
           ConfigWms.ObjConfiguracao.ModeloPrinterCodBarra := ArqIni.ReadString('PRINTER', 'EtqCodBarra_Modelo', ConfigWms.ObjConfiguracao.ModeloPrinterCodBarra);
        if ArqIni.ReadString('PRINTER', 'EtqCodBarra_Porta', '') <> '' then
           ConfigWms.ObjConfiguracao.PortaPrinterCodBarra  := ArqIni.ReadString('PRINTER', 'EtqCodBarra_Porta', ConfigWms.ObjConfiguracao.PortaPrinterCodBarra);
        FreeAndNil(ArqIni);
     End;
   Except
     Application.MessageBox(pWideChar('N�o foi poss�vel acessar o servidor.('+BASEURL+')' +
                                      #13+#13+'O eXactWMS ser� finalizado.'), 'Erro: Server eXactWMS!', MB_ICONERROR);
     Application.Terminate;
   End;

*)  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  NullStrictConvert           := False;
//  if (FileExists(PathApp + '\eXactWMS.rav') = True) then
//      rvpPrincipal.ProjectFile := PathApp + '\eXactWMS.rav';
//  else
//      Application.MessageBox('Arquivo eXactWMS.rav n�o localizado!', 'Erro', MB_ICONERROR + MB_OK);
  ObjUsuarioCtrl := TUsuarioCtrl.Create;
end;

procedure TFrmeXactWMS.FormDestroy(Sender: TObject);
begin
  ObjUsuarioCtrl.Free;
  ConfigWMS.Free;
  if NovaVersao then
     WinExec(pAnsiChar(AtzApp), SW_NORMAL);
end;

procedure TFrmeXactWMS.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F1 then
     Application.HelpContext(50);
end;

procedure TFrmeXactWMS.FormResize(Sender: TObject);
begin                                   // 728                 //50
  ImgLogoProduct.Top  := ((Height-PnlTopRhemaSys.Height) Div 2) - (ImgLogoProduct.Height Div 2) + PnlTopRhemaSys.Height;
  ImgLogoProduct.Left := ((Width-MenuSplit.Width) Div 2) - (ImgLogoProduct.Width Div 2) + MenuSplit.Width;
//  ImgRhemasys.Top     := ImgLogoProduct.Top - (ImgRhemasys.Height Div 2);
//  ImgRhemasys.Left    := ImgLogoProduct.Left - (ImgRhemasys.Width Div 2);
  LblUsuarioTop.Caption := 'Usu�rio: '+ObjUsuarioCtrl.ObjUsuario.Nome;
  PnlIconesExtras.Left  := Trunc((Width - PnlIconesExtras.Width) / 2)
end;

procedure TFrmeXactWMS.FormShow(Sender: TObject);
begin
  frmLogin := TfrmLogin.Create(Application);
  frmLogin.LblVersao.Caption := 'Vers�o: ' + Versao;//(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
    if (frmLogin.ShowModal = mrOk) then begin
       FrmeXactWMS.LblVersao.Caption := 'Vers�o: ' + Versao;//(ExtractFilePath(ParamStr(0))+ExtractFileName(ParamStr(0)));
       AtualizarVersao;
       LblUsuarioTop.Caption := ObjUsuarioCtrl.ObjUsuario.Nome;
    End
    Else Begin
       ShowMessage('Acesso n�o autorizado!');
       Application.terminate;
    End;
  FrmLogin := Nil;
  LblServereXactWMS.Caption := TeXactWSMDAO.ServerBD;
//  ObjNovidadesCtrl.Free;
  Try
    //LblServereXactWMS.Caption := LblServereXactWMS.Caption + ' ' +getIPs.Strings[0];
  Except
  End;
  if (ObjUsuarioCtrl.ObjUsuario.Perfil.PerfilId = 1) and
     (ConfigWMS.ObjConfiguracao.AtivarBackup = 1) and
     (ConfigWMS.ObjConfiguracao.BackupBd < Date()) then
     if ConfirmaManutencao('Backup') then
//     if MessageDlg('Deseja fazer o Backup do Banco de Dados?',mtConfirmation, [Mbyes, MbNo], 0) = MrYes then
        Backup;
   ManutencaoLogs;
   if (vSysInfo.OS.OSVersion = wvwin10) and (NeweXactWMS) then
      ShowNotificationNews;
end;

Function TFrmeXactWMS.NeweXactWMS : Boolean;
Var JsonArrayNovidades : TJsonArray;
    ObjNovidadesCtrl   : TNovidadesCtrl;
    vErro : String;
    FService : TServiceBaseCadastro;
begin
  Result := False;
  FService := TServiceNovidades.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURL)
     .Resource('v1/novidades/news')
     .ClearParams
     .AddParam('status', '1');
  JsonArrayNovidades := FService.ListaNews;
  if Not JsonArrayNovidades.Items[0].TryGetValue('Erro', vErro) then
     Result := True;
  JsonArrayNovidades := Nil;
  FService.Free;
End;

Procedure TFrmeXactWMS.ShowNotificationNews;
Var MyNotification : TNotification;
Begin
  MyNotification   := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name  := 'newVersion';
    MyNotification.Title := 'Novidades no eXactWMS'; //'Controle de Acesso';
    MyNotification.AlertBody   := 'Click aqui para ver as novidades do seu eXactWMS.';
    MyNotification.EnableSound := True;
    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
End;

procedure TFrmeXactWMS.Image1Click(Sender: TObject);
begin
  ShowMessage('eXact Message n�o habilitado'+#13+'Solicite ao Gerente do CD.');
end;

procedure TFrmeXactWMS.ImgCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmeXactWMS.imgMenuClick(Sender: TObject);
begin
//  MenuSplit.Opened := Not MenuSplit.Opened;
end;

procedure TFrmeXactWMS.ImgNovidadesClick(Sender: TObject);
Var JsonArrayNovidades : TJsonArray;
    ObjNovidadesCtrl   : TNovidadesCtrl;
    vErro : String;
    FService : TServiceBaseCadastro;
begin
  FService := TServiceNovidades.Create(Self);
  FService
     .Request
     .BaseURL(FrmeXactWMS.BASEURLREPORT)
     .Resource('v1/novidades')
     .ClearParams
     .AddParam('status', '1');
  JsonArrayNovidades := FService.ListarRegistroJson;
  if Not JsonArrayNovidades.Items[0].TryGetValue('Erro', vErro) then
     ShowNovidades(JsonArrayNovidades);
  JsonArrayNovidades := Nil;
end;

procedure TFrmeXactWMS.LogEndApp;
var oLogger: TLoggerSingleton;
begin
  oLogger := TLoggerSingleton.ObterInstancia;
  oLogger.RegistrarLog(ObjUsuarioCtrl.ObjUsuario.Nome+', encerrou a aplica��o �s '+Copy(TimeToStr(Time()),1,5)+'h.'+#13+#13);
  //FreeAndNil(oLogger);
  oLogger.FreeInstance;
end;

procedure TFrmeXactWMS.LogOn(pManterAcesso : Boolean);
begin
   frmLogin := TfrmLogin.Create(Application);
   FrmLogin.edtSenha.Text := '';
   if pManterAcesso then
      FrmLogin.edtCodigo.Text := FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId.ToString;
   if (frmLogin.ShowModal = mrOk) then Begin

   End
   Else Begin
      ShowMessage('Acesso n�o autorizado!');
      Application.terminate;
   End;
end;

procedure TFrmeXactWMS.Notificacaostandand(pTitle, pMensagem: String);
Var MyNotification: TNotification;
    MyNotificationCenter : TNotificationCenter;
begin
  if vSysInfo.OS.OSVersion = wvwin10 then Begin
     MyNotification       := TNotification.Create();//
     MyNotificationCenter := TNotificationCenter.Create(self);
     MyNotification       := MyNotificationCenter.CreateNotification;
     try
       MyNotification.Name  := 'eXactWMS';
       MyNotification.Title := pTitle; //'Controle de Acesso';
       MyNotification.AlertBody   := pMensagem;
       MyNotification.EnableSound := True;
       MyNotificationCenter.PresentNotification(MyNotification);
     finally
       FreeAndNil(MyNotification);
       FreeAndNil(MyNotificationCenter);
       MyNotification.Free;
       MyNotificationCenter.Free;
     end;
  End;
end;

procedure TFrmeXactWMS.NotificationCenter1ReceiveLocalNotification(
  Sender: TObject; ANotification: TNotification);
begin
  if ANotification.Name = 'newVersion' then
     ImgNovidadesClick(ImgNovidades);
end;

procedure TFrmeXactWMS.ThreadManutencaoLogsTerminate(Sender: TObject);
begin
if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      Notificacaostandand('Log'+#39+'s', ' n�o foi poss�vel deletar os arquivos.!');
      exit;
    end
    Else Begin
      Notificacaostandand('Log'+#39+'s', 'Arquivos Deletados com sucesso!');
    End;
  end;
end;

procedure TFrmeXactWMS.ThreadTerminate(Sender: TObject);
begin
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowMessage('Erro: Gerando Gr�fico. '+Exception(TThread(sender).FatalException).Message);
      exit;
    end;
  end;
end;

procedure TFrmeXactWMS.ThreadTerminateBackup(Sender: TObject);
begin
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      Notificacaostandand('Backup', 'N�o foi poss�vel realizar o Backup!');
      exit;
    end
    Else Begin
      Notificacaostandand('Backup', 'Backup realizado com sucesso!');
    End;
  end;
end;

procedure TFrmeXactWMS.TmHoraAtualTimer(Sender: TObject);
begin
  LblDateTime.Caption := FormatDateTime('dd/mm/yyyy hh:mm', now())+'h';
end;

procedure TFrmeXactWMS.TrataErro(Sender: TObject; E: Exception);
begin
  MessageDlg(E.Message+#13+#13,MtError, [MbOk] ,0);
end;

procedure TFrmeXactWMS.TrimAppMemorySize;
Var MainHandle : THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, false,
    GetCurrentProcessID) ;
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF) ;
    CloseHandle(MainHandle) ;
  except
  end;
  Application.ProcessMessages;
end;

function TFrmeXactWMS.VerAcesso(CodMenu: String): Boolean;
begin
  Result := True;
end;

procedure TFrmeXactWMS.GetDashBoardAsynch;
var Th: TThread;
begin
  Try
    Th := TThread.CreateAnonymousThread(procedure
       Var teste : Integer;
    begin
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        WebBrowser1.Visible := False;
      End);
      GetDadosGrafico01;
      GetProducaoPendente;
      GetDadosGrafico060708;
      Grafico01;
      TThread.Synchronize(TThread.CurrentThread, procedure
      begin
        WebBrowser1.Visible := True;
      End);
    End);
    Th.OnTerminate := ThreadTerminate;
    Th.Start;
//    JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', 0, '', '', 1);
//    SelecionarClientePedidos(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('pedidos'));
//    CalculaPesoVolume;

  //Montar Lista de Endere�os
  Except On E: Exception do
    //ShowErro('Erro: '+E.Message);
  End;



EXIT;

  TLibrary.CustomThread(
    procedure ()
    begin
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          Self.Label1.Visible := True;
          WebBrowser1.Visible := False;
        end
      );    end,
    procedure ()
    begin

  //Grafico01
      //DmeXactWMS.ResetRest;
      DmeXactWMS.ReqGraphics.ResetToDefaults;
      DmeXactWMS.ReqGraphics.Resource := 'v1/pedido/dashboard0102?dtinicio='+DateToStr(Date())+'&dttermino='+DateToStr(Date());
      DmeXactWMS.ReqGraphics.Method   := RmGet;
      DmeXactWMS.ReqGraphics.Execute; //Async(GetDadosGrafico01, true, true, ProcessarGETErro);//Execute;
      GetDadosGrafico01;

      //DmeXactWMS.ResetRest;
      DmeXactWMS.ReqGraphics.ResetToDefaults;
//      DmeXactWMS.ReqGraphics.Resource := 'v1/pedido/dashboard030405?dtinicio='+DateToStr(Date())+'&dttermino='+DateToStr(Date());
      DmeXactWMS.ReqGraphics.Resource := 'v1/pedido/producaopendente';
      DmeXactWMS.ReqGraphics.Method   := RmGet;
      DmeXactWMS.ReqGraphics.Execute; //Async(GetDadosGrafico030405, true, true, ProcessarGETErro);//Execute;
      GetProducaoPendente;

      //DmeXactWMS.ResetRest;
      DmeXactWMS.ReqGraphics.ResetToDefaults;
      DmeXactWMS.ReqGraphics.Resource := 'v1/pedido/dashboard06?dtinicio='+DateToStr(Date())+'&dttermino='+DateToStr(Date());
      DmeXactWMS.ReqGraphics.Method   := RmGet;
      DmeXactWMS.ReqGraphics.Execute;//Async(GetDadosGrafico060708, true, true, ProcessarGETErro);//Execute;
      GetDadosGrafico060708;

    end,
    procedure ()
    begin
      //Complete
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          //Geracao do Grafico
          Grafico01;
          Self.Label1.Visible := False;
          WebBrowser1.Visible := True;
        end
      );
    end,
    procedure (const AException : string)
    begin
      TThread.Synchronize(
        TThread.CurrentThread,
        procedure ()
        begin
          //Self.ShowErro(aException);
        end
      );
    end,
    True
  );
end;

procedure TFrmeXactWMS.GetDelLog;
var
  I, j: Integer;
  SearchRec: TSearchRec;
  Lista : TStringList;
  PathFile : String;
  nameFile : string;
  vDataFile : TDateTime;
begin
  PathFile := 'C:\App\eXactWMS\Service\Log\';
  Lista := TStringList.Create;
  try
    Lista.Sorted := true;
    I := FindFirst(PathFile+'*.Log', 0, SearchRec);
    while I = 0 do
    begin
      nameFile := SearchRec.Name;
      Lista.Add('Arquivo: '+nameFile+'  Data: '+DateTostr(FileTimeToDTime(SearchRec.FindData.ftLastWriteTime)));
      vDataFile := FileTimeToDTime(SearchRec.FindData.ftLastWriteTime);
      if FileTimeToDTime(SearchRec.FindData.ftLastWriteTime) < Date()-2 then
         DeleteFile(PathFile + SearchRec.Name);
      I := FindNext(SearchRec);
    end;
  except
    Lista.Free;
    raise;
  end;
end;

Procedure TFrmeXactWMS.ProcessarGetErro(Sender : TObject);
Begin
  if Assigned(Sender) and (Sender is Exception) then
     showmessage('Erro: '+Exception(Sender).Message);
End;

procedure TFrmeXactWMS.ShowNovidades;
begin
  if (Assigned(FrmNovidades) = False) then
    begin
      FrmNovidades := TFrmNovidades.Create(Application);
      FrmNovidades.showNovidades(pJsonArrayNovidades);
    end;
  try
    FrmNovidades.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmNovidades);
      raise Exception.Create(e.Message);
    end;
  end;
end;

Procedure TFrmeXactWMS.GetDadosGrafico01;
Var JsonDashBoard0102  : TJsonObject;
Begin
  DmeXactWMS.ReqGraphics.ResetToDefaults;
  DmeXactWMS.ReqGraphics.Resource := 'v1/pedido/dashboard0102?dtinicio='+DateToStr(Date())+'&dttermino='+DateToStr(Date());
  DmeXactWMS.ReqGraphics.Method   := RmGet;
  DmeXactWMS.ReqGraphics.Execute; //Async(GetDadosGrafico01, true, true, ProcessarGETErro);//Execute;


  JsonDashBoard0102 := DmeXactWMS.RespGraphics.JSONValue as TJSONObject;
  if not (FdMemDashBoard01.Active) then
     FdMemDashBoard01.Open;
  FdMemDashBoard01.EmptyDataSet;
  if not (FdMemDashBoard02.Active) then
     FdMemDashBoard02.Open;
  FdMemDashBoard02.EmptyDataSet;
  if JsonDashBoard0102.Count > 0  then Begin
     If JsonDashBoard0102.GetValue<TJsonArray>('diario').Count>0 then Begin
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Demanda';
        FdMemDashBoard01.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('diario').Items[0].GetValue<Integer>('demanda');
        FdMemDashBoard01.FieldByName('RGB').AsString    := '80, 90, 145';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Expedicao';
        FdMemDashBoard01.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('diario').Items[0].GetValue<Integer>('expedicao');
        FdMemDashBoard01.FieldByName('RGB').AsString    := '12, 104, 9';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Cancelado';
        FdMemDashBoard01.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('diario').Items[0].GetValue<Integer>('cancelado');
        FdMemDashBoard01.FieldByName('RGB').AsString    := '251, 6, 6';
     End
     Else Begin
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Demanda';
        FdMemDashBoard01.FieldByName('Value').AsInteger := 0;
        FdMemDashBoard01.FieldByName('RGB').AsString    := '80, 90, 145';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Expedicao';
        FdMemDashBoard01.FieldByName('Value').AsInteger := 0;
        FdMemDashBoard01.FieldByName('RGB').AsString    := '12, 104, 9';
        FdMemDashBoard01.Append;
        FdMemDashBoard01.FieldByName('Label').AsString  := 'Cancelado';
        FdMemDashBoard01.FieldByName('Value').AsInteger := 0;
        FdMemDashBoard01.FieldByName('RGB').AsString    := '251, 6, 6';
     End;
     If JsonDashBoard0102.GetValue<TJsonArray>('mensal').Count>0 then Begin
        FdMemDashBoard02.Append;
        FdMemDashBoard02.FieldByName('Label').AsString  := 'Demanda';
        FdMemDashBoard02.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('mensal').Items[0].GetValue<Integer>('demanda');
        FdMemDashBoard02.FieldByName('RGB').AsString    := '80, 90, 145';
        FdMemDashBoard02.Append;
        FdMemDashBoard02.FieldByName('Label').AsString  := 'Expedicao';
        FdMemDashBoard02.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('mensal').Items[0].GetValue<Integer>('expedicao');
        FdMemDashBoard02.FieldByName('RGB').AsString  := '12, 104, 9';
        FdMemDashBoard02.Append;
        FdMemDashBoard02.FieldByName('Label').AsString  := 'Cancelado';
        FdMemDashBoard02.FieldByName('Value').AsInteger := JsonDashBoard0102.GetValue<TJsonArray>('mensal').Items[0].GetValue<Integer>('cancelado');
        FdMemDashBoard02.FieldByName('RGB').AsString  := '251, 6, 6';
     End;
//     JsonDashBoard0102.Free;
  End;
End;

Procedure TFrmeXactWMS.GetProducaoPendente;
Const Cor : array  [0..11] of string = ('80, 95, 145', '74,  48, 99', '80, 95, 145', '120, 112,  14', '180, 37, 80', ' 94, 114, 50',
                                        '35, 120, 77', '68, 112, 10', '91, 95,  59', ' 66, 127, 169', ' 62, 17, 70', '110, 120, 88');
Var JsonDashBoard030405 : TJsonArray;
    xRetorno : Integer;
Begin

  DmeXactWMS.ReqGraphics.ResetToDefaults;
  DmeXactWMS.ReqGraphics.Resource := 'v1/pedido/producaopendente';
  DmeXactWMS.ReqGraphics.Method   := RmGet;
  DmeXactWMS.ReqGraphics.Execute; //Async(GetDadosGrafico030405, true, true, ProcessarGETErro);//Execute;

  JsonDashBoard030405 := DmeXactWMS.RespGraphics.JSONValue as TJSONArray;
  if not (FdMemDashBoard03.Active) then
     FdMemDashBoard03.Open;
  FdMemDashBoard03.EmptyDataSet;
  if not (FdMemDashBoard04.Active) then
     FdMemDashBoard04.Open;
  FdMemDashBoard04.EmptyDataSet;
  if not (FdMemDashBoard05.Active) then
     FdMemDashBoard05.Open;
  FdMemDashBoard05.EmptyDataSet;
  if JsonDashBoard030405.Count > 0  then Begin
     for xRetorno := 0 to Pred(JsonDashBoard030405.Count) do  Begin
        FdMemDashBoard03.Append;
        FdMemDashBoard03.FieldByName('Label').AsString  := JsonDashBoard030405.Items[xRetorno].GetValue<String>('processoid')+' '+
                                                           JsonDashBoard030405.Items[xRetorno].GetValue<String>('processo');
        FdMemDashBoard03.FieldByName('Value').AsInteger := JsonDashBoard030405.Items[xRetorno].GetValue<Integer>('totped');
        FdMemDashBoard03.FieldByName('RGB').AsString    := Cor[JsonDashBoard030405.Items[xRetorno].GetValue<Integer>('processoid')];// '80, '+Cor.ToString()+', 145';
     End;
  End
  Else
  Begin
    FdMemDashBoard03.Append;
    FdMemDashBoard03.FieldByName('Label').AsString  := 'Sem Pend�ncis';
    FdMemDashBoard03.FieldByName('Value').AsInteger := 0;
    FdMemDashBoard03.FieldByName('RGB').AsString  := '25 ,70, 85';
  End;
//  JsonDashBoard030405.Free;
End;

Procedure TFrmeXactWMS.GetDadosGrafico060708;
Var JsonDashBoard06 : TJsonArray;
    xRetorno : Integer;
Begin

  DmeXactWMS.ReqGraphics.ResetToDefaults;
  DmeXactWMS.ReqGraphics.Resource := 'v1/pedido/dashboard06?dtinicio='+DateToStr(Date())+'&dttermino='+DateToStr(Date());
  DmeXactWMS.ReqGraphics.Method   := RmGet;
  DmeXactWMS.ReqGraphics.Execute;//Async(GetDadosGrafico060708, true, true, ProcessarGETErro);//Execute;

  JsonDashBoard06 := DmeXactWMS.RespGraphics.JSONValue as TJSONArray;
  if not (FdMemDashBoard06.Active) then
     FdMemDashBoard06.Open;
  FdMemDashBoard06.EmptyDataSet;
  if not (FdMemDashBoard07.Active) then
     FdMemDashBoard07.Open;
  FdMemDashBoard07.EmptyDataSet;
  if not (FdMemDashBoard08.Active) then
     FdMemDashBoard08.Open;
  FdMemDashBoard08.EmptyDataSet;
  if JsonDashBoard06.Count > 0  then Begin
     for xRetorno := 0 to Pred(JsonDashBoard06.Count) do Begin
        FdMemDashBoard06.Append;
        FdMemDashBoard06.FieldByName('Label').AsString  := JsonDashBoard06.Items[xRetorno].GetValue<String>('rotaid')+' '+
                                                           JsonDashBoard06.Items[xRetorno].GetValue<String>('rota');
        FdMemDashBoard06.FieldByName('Value').AsInteger := JsonDashBoard06.Items[xRetorno].GetValue<Integer>('demanda');
        FdMemDashBoard06.FieldByName('RGB').AsString    := '80, 90, 145';
        FdMemDashBoard07.Append;
        FdMemDashBoard07.FieldByName('Label').AsString  := JsonDashBoard06.Items[xRetorno].GetValue<String>('rotaid')+' '+
                                                           JsonDashBoard06.Items[xRetorno].GetValue<String>('rota');
        FdMemDashBoard07.FieldByName('Value').AsInteger := JsonDashBoard06.Items[xRetorno].GetValue<Integer>('expedicao');
        FdMemDashBoard07.FieldByName('RGB').AsString    := '12, 104, 9';
        FdMemDashBoard08.Append;
        FdMemDashBoard08.FieldByName('Label').AsString  := JsonDashBoard06.Items[xRetorno].GetValue<String>('rotaid')+' '+
                                                           JsonDashBoard06.Items[xRetorno].GetValue<String>('rota');
        FdMemDashBoard08.FieldByName('Value').AsInteger := JsonDashBoard06.Items[xRetorno].GetValue<Integer>('cancelado');
        FdMemDashBoard08.FieldByName('RGB').AsString    := '251, 6, 6';
     End;
  End
  Else
  Begin
    FdMemDashBoard06.Append;
    FdMemDashBoard06.FieldByName('Label').AsString  := 'Nenhuma Rota';
    FdMemDashBoard06.FieldByName('Value').AsInteger := 0;
    FdMemDashBoard06.FieldByName('RGB').AsString  := '25 ,70, 85';
  End;
//  JsonDashBoard06.Free;
End;

Procedure TFrmeXactWMS.Grafico01;
Var ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    JsonDashBoard0102  : TJsonObject;
    JsonDashBoard030405, JsonDashBoard06 : TJsonArray;
    xRetorno : Integer;
Begin
TThread.Synchronize(TThread.CurrentThread, procedure
begin
  WebCharts1
  .NewProject
  .Rows
  .tag
  .add(
    WebCharts1
    .ContinuosProject
       .Charts
         ._ChartType(doughnut)
           .Attributes
             .Name('Diariox')
             .ColSpan(6)
             .Options
               .SemiCircule(True)
             .&End
             .Heigth(120)
             .Options
                .Title
                  .Text('Produ��o Di�ria')
                .&End
             .&End
             .DataSet
               .textLabel('Diarioy')
               //.BackgroundColor('30,182,100')
               .DataSet(FdMemDashBoard01)
               .Fill(False)
               .BorderWidth(2)
               .BorderColor('25,78,125')
             .&End
           .&End
         .&End
         .HTML
    )
  .&End
//Grafico 02
  .tag
    .add(
      WebCharts1
      .ContinuosProject
         .Charts
           ._ChartType(doughnut)
             .Attributes
               .Name('Mensal')
               .ColSpan(6)
               .Options
                 .SemiCircule(True)
               .&End
               .Options
                  .Title
                    .Text('Produ��o Mensal')
                  .&End
               .&End
               .Heigth(120)
               .DataSet
                 .textLabel('Mensal01')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard02)
               .&End
             .&End
           .&End
           .HTML
      )
    .&End
//Grafico 03
  .tag
    .add(
      WebCharts1
      .ContinuosProject
         .Charts
           ._ChartType(Bar)//  bar)
             .Attributes
               .Name('ProducaoPendente')
               .ColSpan(6)
               .Options
                 .SemiCircule(True)
               .&End
               .Options
                  .Title
                    .Text('Produ��o Pendente')
                  .&End
               .&End
               .Heigth(220)
               .DataSet
                 //.textLabel('Processo')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard03)
               .&End
               {
               .DataSet
                 .textLabel('Expedi��o')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard04)
               .&End
               .DataSet
                 .textLabel('Cancelado')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard05)
               .&End
               }
             .&End
           .&End
           .HTML
      )
    .&End
//Grafico 04
  .tag
    .add(
      WebCharts1
      .ContinuosProject
         .Charts
           ._ChartType(horizontalBar)//  bar)
             .Attributes
               .Name('An�lise por Rota')
               .ColSpan(6)
               .Options
                 .SemiCircule(True)
               .&End
               .Options
                  .Title
                    .Text('Produ��o Di�ria por Rota')
                  .&End
               .&End
               .Heigth(220)
               .DataSet
                 .textLabel('Demanda')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard06)
               .&End
               .DataSet
                 .textLabel('Expedi��o')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard07)
               .&End
               .DataSet
                 .textLabel('Cancelado')
                 //.BackgroundColor('70,5,120')
                 .DataSet(FdMemDashBoard08)
               .&End
             .&End
           .&End
           .HTML
      )
    .&End

  .&End


  .WebBrowser(WebBrowser1)
  .Generated;
End);
  JsonDashBoard0102   := Nil;
  JsonDashBoard030405 := Nil;
  JsonDashBoard06     := Nil;
  ObjPedidoSaidaCtrl  := Nil;
End;

end.
