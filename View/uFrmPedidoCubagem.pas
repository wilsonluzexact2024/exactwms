unit uFrmPedidoCubagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, DataSet.Serialize,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.Threading,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, Math,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, ClipBrd,
  Generics.Collections, System.Json, Rest.Types, Vcl.Mask, JvExMask, JvToolEdit
  , PedidoSaidaCtrl
  , PessoaCtrl
  , PedidoVolumeCtrl
  , RotaCtrl
  , Vcl.DBGrids, frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet
  , JvSpin, dxSkinsCore, dxSkinsDefaultPainters, Vcl.Buttons, Vcl.ComCtrls, ACBrBase, ACBrETQ
  , frxRich, frxCross, frxOLE, frxBarcode, frxChBox, frxGradient, Vcl.DialogMessage,
  Vcl.Samples.Gauges, dxCameraControl, EnderecamentoZonaCtrl,
  Views.Pequisa.EnderecamentoZonas;

type

  TProcesso = (moRecebido, moCubagem, moImpresso, moCheckIn, moCheckInEnd, moDevolvido, moApanhe,
               moApanheEnd, moCheckOut, moCheckOutEnd, moExpedição, moExpedido, moCancelado,
               moCargaMontagem, moCargaCompletado, moCargaTrânsito, moCargaLoja, moCargaFinalizada,
               moCargaCancelada, moReProcessado);

  TFrmPedidoCubagem = class(TFrmBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    ChkProcRecebido: TCheckBox;
    ChkProcCubagem: TCheckBox;
    ChkProcEtiqueta: TCheckBox;
    GroupBox3: TGroupBox;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Label7: TLabel;
    LblTotRotas: TLabel;
    Label8: TLabel;
    LblTotPessoas: TLabel;
    Label10: TLabel;
    LblTotPedidos: TLabel;
    TmProcessando: TTimer;
    PnlProcessando: TPanel;
    Label12: TLabel;
    PnlDetalhe: TPanel;
    LstRotasAdv: TAdvStringGrid;
    LstPessoasAdv: TAdvStringGrid;
    LstPedidosAdv: TAdvStringGrid;
    Label4: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    PnlLstPedidos: TPanel;
    GroupBox4: TGroupBox;
    EdtDestinatario: TEdit;
    LblDestinatario: TLabel;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRota: TEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    EdtPedidoId: TEdit;
    LblProcCubagem: TLabel;
    BtnProcessar: TPanel;
    sImage1: TsImage;
    BntCancelar: TPanel;
    sImage2: TsImage;
    QryEstoqueDisponivel_CaixaFechada: TFDMemTable;
    QryEstoqueDisponivel_CaixaFechadaProdutoid: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaEmbPrim: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaEmbSec: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaMesSaidaMinima: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaLoteid: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaEnderecoId: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaQtde: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaDtEntrada: TDateField;
    QryEstoqueDisponivel_CaixaFechadaHrEntrada: TTimeField;
    QryEstoqueDisponivel_CaixaFechadaEstoqueTipoId: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaVencimento: TDateTimeField;
    QryEstoqueDisponivel_CaixaFechadaQtdPedido: TIntegerField;
    QryEstoqueDisponivel_CaixaFechadaReprocessado: TBooleanField;
    QryEstoqueDisponivel_CaixaFracionada: TFDMemTable;
    QryEstoqueDisponivel_CaixaFracionadaProdutoId: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaEmbalagemPadrao: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaEnderecoId: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaQtdSolicitada: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaLoteId: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaQtde: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaVencimento: TDateField;
    QryEstoqueDisponivel_CaixaFracionadaOrdem: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaDistribuicao: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaPesoLiquidoKg: TFloatField;
    QryEstoqueDisponivel_CaixaFracionadaDtHrEntrada: TDateTimeField;
    DataSource1: TDataSource;
    QryEstoqueDisponivel_CaixaFracionadaRuaId: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaReprocessado: TBooleanField;
    BtnPrintMapa: TPanel;
    sImage3: TsImage;
    frxReport1: TfrxReport;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    QryMapaSeparacao: TFDMemTable;
    QryMapaSeparacaoPedidoId: TIntegerField;
    QryMapaSeparacaoPedidoVolumeId: TIntegerField;
    QryMapaSeparacaoData: TDateField;
    QryMapaSeparacaoSequencia: TIntegerField;
    QryMapaSeparacaoPessoaId: TIntegerField;
    QryMapaSeparacaoRazao: TStringField;
    QryMapaSeparacaoRotaId: TIntegerField;
    QryMapaSeparacaoRua: TStringField;
    QryMapaSeparacaoZona: TStringField;
    QryMapaSeparacaoDescrLote: TStringField;
    QryMapaSeparacaoVencimento: TDateField;
    QryMapaSeparacaoProdutoId: TIntegerField;
    QryMapaSeparacaoProdutoDescricao: TStringField;
    QryMapaSeparacaoRotaDescricao: TStringField;
    QryMapaSeparacaoQuantidade: TIntegerField;
    QryMapaSeparacaoEmbalagemPadrao: TIntegerField;
    QryMapaSeparacaoEan: TStringField;
    QryMapaSeparacaoUnidade: TStringField;
    QryMapaSeparacaoEndereco: TStringField;
    QryMapaSeparacaoVolumeTipo: TStringField;
    QryEstoqueDisponivel_CaixaFechadaEmbalagemPadrao: TIntegerField;
    BtnProdutoSemPicking: TPanel;
    sImage4: TsImage;
    QryMapaSeparacaoCodProduto: TIntegerField;
    LblPedidoProc: TLabel;
    QryMapaSeparacaoDocumentoNr: TStringField;
    QryMapaSeparacaoCodPessoaERP: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaZonaId: TIntegerField;
    QryEstoqueDisponivel_CaixaFracionadaFatorConversao: TIntegerField;
    Label14: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    QryEstoqueDisponivel_CaixaFracionadaEnderecoOrigem: TIntegerField;
    PgrProcessar: TGauge;
    QryEstoqueDisponivel_CaixaFracionadaEstoqueTipoId: TIntegerField;
    GroupBox7: TGroupBox;
    EdtZonaId: TEdit;
    LblZona: TLabel;
    Label16: TLabel;
    BtnPesqRota: TBitBtn;
    BtnPesqZona: TBitBtn;
    Label9: TLabel;
    EdtRotaIdFinal: TEdit;
    BtnPesqRotaFinal: TBitBtn;
    LblRotaIdFinal: TLabel;
    ChkImprimirPDF: TCheckBox;
    TabExcuirPedido: TcxTabSheet;
    GroupBox8: TGroupBox;
    Label15: TLabel;
    Label17: TLabel;
    EdtDtInicioExcluir: TJvDateEdit;
    EdtDtTerminoExcluir: TJvDateEdit;
    GroupBox9: TGroupBox;
    Label18: TLabel;
    EdtPedidoIdExcluir: TEdit;
    GroupBox10: TGroupBox;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    EdtRotaInicialExcluir: TEdit;
    BtnPestRotaInicialExcluir: TBitBtn;
    EdtRotaFinalExcluir: TEdit;
    BtnPesqRotaFinalExcluir: TBitBtn;
    GroupBox11: TGroupBox;
    LblZonaExcluir: TLabel;
    Label24: TLabel;
    EdtZonaIdExcluir: TEdit;
    BtnPesqZonaExcluir: TBitBtn;
    GroupBox12: TGroupBox;
    LblDestinatarioExcluir: TLabel;
    EdtDestinatarioExcluir: TEdit;
    PnlDetalheExcluir: TPanel;
    LblProcExcluir: TLabel;
    PnlLstPedidosExcluir: TPanel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    LstPedidosExcluir: TAdvStringGrid;
    LstPessoasExcluir: TAdvStringGrid;
    LstRotasExcluir: TAdvStringGrid;
    Panel6: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    CheckBox1: TCheckBox;
    GroupBox13: TGroupBox;
    Shape1: TShape;
    Shape2: TShape;
    Shape6: TShape;
    Label29: TLabel;
    LblTotRotaExcluir: TLabel;
    Label31: TLabel;
    LblTotPessoaExcluir: TLabel;
    Label33: TLabel;
    LblTotPEdidoExcluir: TLabel;
    GroupBox14: TGroupBox;
    ChkProcRecebidoExcluir: TCheckBox;
    ChkProcCubagemExcluir: TCheckBox;
    ChkProcEtiquetaExcluir: TCheckBox;
    BtnExcluirPedido: TPanel;
    ShpBtnExcluirPedido: TShape;
    SpbBtnExcluirPedido: TSpeedButton;
    PnlBtnExcluirPedido: TPanel;
    ImgBtnExcluirPedido: TImage;
    PgrExcluir: TGauge;
    QryEstoqueDisponivel_CaixaFracionadaVolumeCm3: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure TabPrincipalShow(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TmProcessandoTimer(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
    procedure LstPedidosAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstRotasAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure LstPessoasAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtDestinatarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDestinatarioChange(Sender: TObject);
    procedure EdtRotaChange(Sender: TObject);
    procedure EdtRotaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPedidoIdChange(Sender: TObject);
    procedure ChkProcRecebidoClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnProcessarClick(Sender: TObject);
    procedure BntCancelarClick(Sender: TObject);
    procedure BtnPrintMapaClick(Sender: TObject);
    procedure EdtPedidoIdKeyPress(Sender: TObject; var Key: Char);
    procedure BtnProdutoSemPickingClick(Sender: TObject);
    procedure PgcBaseDrawTab(AControl: TcxCustomTabControl; ATab: TcxTab;
      var DefaultDraw: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure SpbBtnExcluirPedidoClick(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtZonaIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtRotaExit(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure TabExcuirPedidoShow(Sender: TObject);
    procedure EdtZonaIdEnter(Sender: TObject);
  private
    { Private declarations }
    SelRota, SelPessoa, SelPedido : Boolean;
    //ObjPedidoCtrl      : TPedidoSaidaCtrl;
    ProcessoPedido     : TProcesso;
    JsonPedidoCubagem : tjsonArray;
    vCaixaCapacidade, vCaixaVolume : Double;
    Function GetListaPedido(pPedidoId : Integer = 0; pCodigoERP : Integer = 0; pPessoaId : Integer = 0; pDocumentoNr : String = '';
                            pRazao : String = ''; pRegistroERP : String = ''; pRotaId : Integer = 0; pRotaIdFinal : Integer = 0; pDocumentoData : TDateTime = 0; pShowErro : Integer = 0) : Boolean;
    Procedure MontaLstCadastro;
    Procedure MontaListaRota(LstAdv : TAdvStringGrid);
    Procedure MontaListaDestinatario(LstAdv : TAdvStringGrid);
    Procedure MontaListaPedido(LstAdv : TAdvStringGrid);
    Procedure FiltraRota(pOnOff : Boolean; pRotaId : Integer);
    Procedure FiltraPessoa(pOnOff : Boolean; pPessoaId : Integer);
    Function PedidoCubagemVolume_CaixaFechada(pPedidoId : Integer) : Boolean;
    Function PedidoCubagemVolume_CaixaFracionada(pPedidoId : Integer; Reprocessado : Boolean) : Boolean;
    Function Pedido_CancelarCubagem(pPedidoId : Integer; pShowErro : Integer) : Boolean;
    Procedure PrintMapaSeparacao;
    Procedure ColorPedido(pColorProcesso : TColor; aRow : Integer);
    Function GetEstoqueParaCaixaFechada(pIndiceLstPedido : Integer) : Boolean;
    Function ExcluirPedidos : Boolean;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure LimpaField; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Function SalvarReg : Boolean; OverRide;
  public
    { Public declarations }
  end;

var
  FrmPedidoCubagem: TFrmPedidoCubagem;

implementation

{$R *.dfm}

uses uFrmeXactWMS, uFuncoes, UFrmConfirmacao, uFrmRelProdutoSemPicking,
     VolumeEmbalagemCtrl, Views.Pequisa.Rotas;

{ TFrmPedidoCubagem }

procedure TFrmPedidoCubagem.BntCancelarClick(Sender: TObject);
Var xPedSel, xPedido : Integer;
    vCancelado       : Boolean;
begin
  If not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Pedidos - Cancelar') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  inherited;
  xPedSel := 0;
  for xPedido := 1 to LstPedidosAdv.RowCount-1 do Begin
    if (LstPedidosAdv.Cells[9, xPedido] = '1') and
       ((Pos('PROCESSADO', UpperCase(LstPedidosAdv.Cells[5, xPedido])) > 0) or
       (Pos('ETIQUETA', UpperCase(LstPedidosAdv.Cells[5, xPedido])) > 0) or
       (Pos('RE-PROCESSADO', UpperCase(LstPedidosAdv.Cells[5, xPedido])) > 0)) then Begin
       xPedSel := 1;
       Break;
    End;
  End;
  if xPedSel = 0 then Begin
     Player('erro');
     Confirmacao('Cancelar Processamento', 'Nenhum Pedido para cancelar.', False);
     Exit;
  End;
  //Montando a Query com os dados para Cubagem
  vCancelado := False;
  xPedSel    := 0;
  for xPedido := 1 to LstPedidosAdv.RowCount-1 do Begin
    if (LstPedidosAdv.Cells[9, xPedido] = '1') and
       ((Pos('PROCESSADO', UpperCase(LstPedidosAdv.Cells[5, xPedido])) > 0) or
       (Pos('ETIQUETA', UpperCase(LstPedidosAdv.Cells[5, xPedido])) > 0) or
       (Pos('RE-PROCESSADO', UpperCase(LstPedidosAdv.Cells[5, xPedido])) > 0)) then Begin
       If Pedido_CancelarCubagem(LstPedidosAdv.Cells[0, xPedido].ToInteger(), 0) Then Begin
          Inc(xPedSel);
          vCancelado := True;
       End;
    End;
    LstPedidosAdv.Row := xPedido;
  End;
  if vCancelado then Begin
     Player('concluido');
     ShowMessage('Cancelamento de Processamento('+xPedSel.toString+') Pedido(s).) realizado com sucesso!');
  End;
  BtnPesquisarStandClick(Sender);
end;

procedure TFrmPedidoCubagem.BtnEditarClick(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmPedidoCubagem.BtnExcluirClick(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmPedidoCubagem.BtnIncluirClick(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmPedidoCubagem.BtnPesqRotaClick(Sender: TObject);
begin
  if TEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       if Sender = BtnPesqRota then Begin
          EdtRota.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaExit(EdtRota);
       End
       Else Begin
          EdtRotaIdFinal.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaExit(EdtRotaIdFinal);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmPedidoCubagem.BtnPesquisarStandClick(Sender: TObject);
Var ObjPedidoCtrl       : TPedidoSaidaCtrl;
    vDtInicio, vDtFinal : TDateTime;
    vErro : String;
    vRecebido, vCubagem, vEtiqueta : Integer;
begin
  if (Not (PgcBase.ActivePage = TabPrincipal)) and (Not (PgcBase.ActivePage = TabExcuirPedido)) then Exit;
  if PgcBase.ActivePage = TabExcuirPedido then Begin
     Try
       If EdtDtInicioExcluir.Text = '  /  /    ' then
          vDtInicio := 0
       Else vDtInicio := StrToDate(EdtDtInicioExcluir.Text);
     Except On E: Exception do
       raise Exception.Create('Erro: Data Inicial para Excluir é inválida!'+#13+#10+E.Message);
     End;
     Try
       If EdtDtTerminoExcluir.Text = '  /  /    ' then
          vDtFinal := 0
       Else vDtFinal := StrToDate(EdtDtTerminoExcluir.Text);
     Except On E: Exception do
       raise Exception.Create('Erro: Data Final para Excluir é inválida!'+#13+#10+E.Message);
     End;
     if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
        Try
          if StrToDate(EdtDtInicioExcluir.Text) > StrToDate(EdtDtTerminoExcluir.Text) then
             raise Exception.Create('Período para exclusão é Inválido!');
        Except ON E: Exception do
           raise Exception.Create('Erro: '+E.Message);
        End;
     End;
     if (StrToIntDef(EdtRotaInicialExcluir.Text, 0) > 0) and (StrToIntDef(EdtRotaFinalExcluir.Text, 0) = 0) then
        EdtRotaFinalExcluir.Text := EdtRotaInicialExcluir.Text;
     if (StrToIntDef(EdtRotaFinalExcluir.Text, 0) < StrToIntDef(EdtRotaInicialExcluir.Text, 0)) then Begin
        EdtRotaFinalExcluir.SetFocus;
        ShowErro('Rota Final inválida!!!');
        Exit;
     End;
     LstPedidosAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
     LstPedidosAdv.RowCount       := 1;

     TDialogMessage.ShowWaitMessage('Buscando Pedidos para processar. Conectado com servidor...',
       procedure
       begin
         TmProcessando.Enabled := True;
         vRecebido := 1;
         vCubagem  := 0;
         vEtiqueta := 0;
         ObjPedidoCtrl     := TPedidoSaidaCtrl.Create;
         JsonPedidoCubagem := ObjPedidoCtrl.PedidoParaProcessamento(StrToIntDef(EdtPedidoIdExcluir.Text, 0),
                              StrToIntDef(EdtDestinatarioExcluir.Text, 0), vDtInicio, vDtFInal, 0,
                              StrToIntDef(EdtRotaInicialExcluir.Text, 0),  StrToIntDef(EdtRotaFinalExcluir.Text, 0),
                              StrToIntDef(EdtZonaIdExcluir.Text, 0), vRecebido, vCubagem, vEtiqueta);
         LstRotasExcluir.RowCount   := 1;
         LstPessoasExcluir.RowCount := 1;
         LstPedidosExcluir.RowCount := 1;
         if JsonPedidoCubagem.Get(0).tryGetValue<String>('Erro', vErro) then Begin
            TmProcessando.Enabled  := False;
            PnlDetalheExcluir.Caption := '😢Erro: '+vErro;
            Player('toast4');
            ObjPedidoCtrl.Free;
            JsonPedidoCubagem := Nil;
         End
         Else Begin
           if EdtPedidoIdExcluir.text <> '' then Begin
              if (JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<Integer>('processoid') > 1 then Begin
                 ShowErro('Processo do Pedido: '+(JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<String>('processoetapa'));
                 Exit;
              End;
              if (JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<Integer>('statusmax') >= 3 then Begin
                 ObjPedidoCtrl.Free;
                 JsonPedidoCubagem := Nil;
                 raise Exception.Create('Não é permitido Excluir este pedido.');
              End;
           End;
           PnlLstPedidosExcluir.Visible := True;
           MontaListaRota(LstRotasExcluir);
           MontaListaDestinatario(LstPessoasExcluir);
           MontaListaPedido(LstPedidosExcluir);
           TmProcessando.Enabled  := False;
           JsonPedidoCubagem := Nil;
           ObjPedidoCtrl.Free;
         end;
       End);
   End
   Else Begin
     Try
       If EdtInicio.Text = '  /  /    ' then
          vDtInicio := 0
       Else vDtInicio := StrToDate(EdtInicio.Text);
     Except On E: Exception do
       raise Exception.Create('Erro: Data Inicial inválida!'+#13+#10+E.Message);
     End;
     Try
       If EdtTermino.Text = '  /  /    ' then
          vDtFinal := 0
       Else vDtFinal := StrToDate(EdtTermino.Text);
     Except On E: Exception do
       raise Exception.Create('Erro: Data Final inválida!'+#13+#10+E.Message);
     End;
     if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
        Try
          if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
             raise Exception.Create('Período de Data Inválido!');
        Except ON E: Exception do
           raise Exception.Create('Erro: '+E.Message);
        End;
     End;
     if (StrToIntDef(EdtRota.Text, 0) > 0) and (StrToIntDef(EdtRotaIdFinal.Text, 0) = 0) then
        EdtRotaIdFinal.Text := EdtRota.Text;
     if (StrToIntDef(EdtRotaIdFinal.Text, 0) < StrToIntDef(EdtRota.Text, 0)) then Begin
        EdtRotaIdFinal.SetFocus;
        ShowErro('Rota Final inválida!!!');
        Exit;
     End;
     TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
       procedure
       begin
         TmProcessando.Enabled := True;
         if (ChkProcRecebido.Checked) and (EdtPedidoid.Text='') then
            vRecebido := 1 Else vRecebido := 0;
         if (ChkProcCubagem.Checked) and (EdtPedidoid.Text='') then
            vCubagem := 1 Else vCubagem := 0;
         if (ChkProcEtiqueta.Checked) and (EdtPedidoid.Text='') then
            vEtiqueta := 1 Else vEtiqueta := 0;
         ObjPedidoCtrl     := TPedidoSaidaCtrl.Create;
   //      JsonPedidoCubagem := ObjPedidoCtrl.PedidoProcessar(StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtDestinatario.Text, 0), 0, vDtInicio, vDtFInal,
   //                                                         '', '', '', StrToIntDef(EdtRota.Text, 0), 0, vRecebido, vCubagem, vEtiqueta, True, 2, 0, 0, 0, '');
         JsonPedidoCubagem := ObjPedidoCtrl.PedidoParaProcessamento(StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtDestinatario.Text, 0), vDtInicio, vDtFInal, 0,
                              StrToIntDef(EdtRota.Text, 0),  StrToIntDef(EdtRotaIdFinal.Text, 0), StrToIntDef(EdtZonaId.Text, 0), vRecebido, vCubagem, vEtiqueta);
         LstRotasAdv.RowCount   := 1;
         LstPessoasAdv.RowCount := 1;
         LstPedidosAdv.RowCount := 1;
         if JsonPedidoCubagem.Get(0).tryGetValue<String>('Erro', vErro) then Begin
            PnlProcessando.Visible := False;
            TmProcessando.Enabled  := False;
            PnlDetalhe.Caption := '😢Erro: '+vErro;
            Player('toast4');
            ObjPedidoCtrl.Free;
            JsonPedidoCubagem := Nil;
         End
         Else Begin
           if EdtPedidoId.text <> '' then Begin
              if (JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<Integer>('processoid') > 3 then Begin
                 ShowErro('Processo do Pedido: '+(JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<String>('processoetapa'));
                 Exit;
              End;
              ChkProcRecebido.Checked := (JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<Integer>('processoid') = 1;
              ChkProcCubagem.Checked  := (JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<Integer>('processoid') = 2;
              ChkProcEtiqueta.Checked := (JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<Integer>('processoid') = 3;
              if (JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido')).Items[0].GetValue<TJsonObject>.getValue<Integer>('statusmax') >= 3 then Begin
                 ObjPedidoCtrl.Free;
                 JsonPedidoCubagem := Nil;
                 raise Exception.Create('Não é permitido Processamento deste pedido.');
              End;
           End;
           PnlLstPedidos.Visible := True;
           MontaListaRota(LstRotasAdv);
           MontaListaDestinatario(LstPessoasAdv);
           MontaListaPedido(LstPedidosAdv);
           TmProcessando.Enabled  := False;
           PnlProcessando.Visible := false;
           JsonPedidoCubagem := Nil;
           ObjPedidoCtrl.Free;
         end;
       End);
   End;
end;

procedure TFrmPedidoCubagem.BtnPesqZonaClick(Sender: TObject);
begin
  inherited;
  if EdtZonaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       EdtZonaId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
       EdtZonaIdExit(EdtZonaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;

end;

procedure TFrmPedidoCubagem.BtnProcessarClick(Sender: TObject);
Var ObjPedidoCtrl        : TPedidoSaidaCtrl;
    xPedido, xPedSel     : Integer;
    xProdPed             : Integer;
    vData, vErro         : String;
    TesteLote, vLote, vBloqueado  : Integer;
    ObjVolumeEmbalagemCtrl : TVolumeEmbalagemCtrl;
    LstVolumeEmbalagem   : TObjectList<TVolumeEmbalagemCtrl>;
    pPrintMapaSeparacao  : Boolean;
    vRepeteProcessamento : Boolean;
    vErroProcessamento   : Boolean;
    JsonArrayRetorno     : TJsonArray;
    vProcessoId          : integer;
begin
  If Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Processar Pedidos') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  If ChkProcEtiqueta.Checked then Begin
     ChkProcEtiqueta.Checked := False;
     raise Exception.Create('Não é permitido processamento de pedidos impressos! Cancele o Processamento.');
  End;
  inherited;
  Try
    ObjVolumeEmbalagemCtrl := TVolumeEmbalagemCtrl.Create;
    LstVolumeEmbalagem     := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagem(1,'', 0);
    vCaixaCapacidade       := LstVolumeEmbalagem[0].ObjVolumeEmbalagem.Capacidade;//*1000;
    vCaixaVolume           := LstVolumeEmbalagem[0].ObjVolumeEmbalagem.Volume *
                              LstVolumeEmbalagem[0].ObjVolumeEmbalagem.Aproveitamento / 100;//63648;
    ObjVolumeEmbalagemCtrl.Free;
  Except On E: Exception do Begin
    ObjVolumeEmbalagemCtrl.Free;
    ShowErro('Erro: Não foi possível pegar a cubagem das Caixas Fracionada(Baget).');
    Exit;
    End;
  End;
  xPedSel := 0;
  PnlDetalhe.Caption := '';
  for xPedido := 1 to LstPedidosAdv.RowCount-1 do Begin
    if LstPedidosAdv.Cells[8, xPedido] = '1' then Begin
       xPedSel := 1;
       Break;
    End;
  End;
  if xPedSel = 0 then Begin
     Player('toast4');
     PnlDetalhe.Caption := '😢 Nenhum pedido selecionado para Processamento!';
     Exit;
  end;
  //Montando a Query com os dados para Cubagem
  for xPedido := 1 to LstPedidosAdv.RowCount-1 do Begin
    PgrProcessar.Progress := Trunc(xPedido / (LstPedidosAdv.RowCount-1) * 100);
    LstPedidosAdv.Row := xPedido;
    if (LstPedidosAdv.Cells[9, xPedido] = '1') and (LstPedidosAdv.Ints[11, xPedido] < 3) then Begin
       LblPedidoProc.Caption := 'Pedido: '+LstPedidosAdv.Cells[0, xPedido];
       Application.ProcessMessages;
       If Pedido_CancelarCubagem(LstPedidosAdv.Cells[0, xPedido].ToInteger(), 0) Then Begin
       //Buscar Estoque para Caixa Fechada
          Try
            vRepeteProcessamento := False;
            If GetEstoqueParaCaixaFechada(xPedido) then Begin
               if Not QryEstoqueDisponivel_CaixaFechada.IsEmpty then Begin
                  Repeat
                    vErroProcessamento   := PedidoCubagemVolume_CaixaFechada(LstPedidosAdv.Cells[0, xPedido].ToInteger());
                    If (vErroProcessamento) and (Not vRepeteProcessamento) then Begin//Calculos Caixa Fechada
                       vRepeteProcessamento := True;
                       Pedido_CancelarCubagem(LstPedidosAdv.Ints[0, xPedido], 0);
                    End
                    Else
                       vRepeteProcessamento := False;
                  Until Not vRepeteProcessamento;
               End;
               //Transformar procedure em Function para verificar Retorno se processo(Cubagem Fracionado) foi realizado com sucesso.
               if Not vErroProcessamento then Begin
                  vErroProcessamento := PedidoCubagemVolume_CaixaFracionada(LstPedidosAdv.Cells[0, xPedido].ToInteger(),
                                                      ((Pos('PROCESSADO', UpperCase(LstPedidosAdv.Cells[4, xPedido])) > 0) or
                                                      (Pos('ETIQUETA', UpperCase(LstPedidosAdv.Cells[4, xPedido])) > 0) or
                                                      (Pos('RE-PROCESSADO', UpperCase(LstPedidosAdv.Cells[4, xPedido])) > 0)) );
                  if Not vErroProcessamento then  Begin
                     ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
                     JsonArrayRetorno := ObjPedidoCtrl.PutRegistrarProcesso(LstPedidosAdv.Ints[0, xPedido], 2);
                     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
                        Pedido_CancelarCubagem(LstPedidosAdv.Ints[0, xPedido], 0);
                        ShowErro('Erro: Pedido('+LstPedidosAdv.Cells[0, xPedido]+'), '+vErro+';]. Não registrou o processo.', 'alarme');
                     End;
                     JsonArrayRetorno := Nil;
                     ObjPedidoCtrl.Free;
                  End
                  Else Begin
                     Pedido_CancelarCubagem(LstPedidosAdv.Ints[0, xPedido], 0);
                     ShowErro('Erro: Pedido('+LstPedidosAdv.Cells[0, xPedido]+'), '+vErro+';]. Processando Caixas Fracionadas!', 'alarme');
                  End;
               End
               Else Begin
                  Pedido_CancelarCubagem(LstPedidosAdv.Ints[0, xPedido], 0);
                  ShowErro('Erro: Pedido('+LstPedidosAdv.Cells[0, xPedido]+'), '+vErro+';]. Processando Caixas Fechadas!', 'alarme');
               End;
            End;
          Except On E: Exception do Begin
            Pedido_CancelarCubagem(LstPedidosAdv.Ints[0, xPedido], 0);
            ShowErro('Erro: Pedido('+LstPedidosAdv.Cells[0, xPedido]+'), '+vErro+';].', 'alarme');
            End
          End;
       End;
    End;
    if (LstPedidosAdv.Cells[11, xPedido].ToInteger = 3) then
       LstPedidosAdv.Cells[9, xPedido] := '0';
  End;
  LblPedidoProc.Caption := '';
  pPrintMapaSeparacao   := False;
  //if FrmeXactWMS.ConfigWMS.ObjConfiguracao.a then

  With TFrmConfirmacao.Create(Self) do Try
    Mensag1.Caption := 'Mapa de Separação(Fracionados)';
    Mensag2.Caption := 'Deseja Imprimir agora?';
    ImgOk.Visible         := False;
    BtnOk.Visible         := False;
    PctSim.Visible        := True;
    LblConfirmSim.Visible := True;
    PctNao.Visible        := True;
    LblConfirmNao.Visible := True;
    If ShowModal = MrOk Then Begin
       pPrintMapaSeparacao := True;
       Close;
       End
    Else Begin
       pPrintMapaSeparacao := False;
    End;
  Finally
    Free;
  end;
  if pPrintMapaSeparacao then
     PrintMapaSeparacao;

  if Pos('Erro', PnlDetalhe.Caption) <= 0 then Begin
     Player('concluido');
     ShowMessage('Processamento de Pedido(s) concluído')
  End
  Else Begin
     Player('alerta');
     ShowMessage('Finalizado com erros...');
  End;
  PgrProcessar.Progress := 0;
  BtnPesquisarStandClick(Sender);
end;

procedure TFrmPedidoCubagem.ChkProcRecebidoClick(Sender: TObject);
begin
  inherited;
  EdtInicioChange(EdtInicio);
end;

procedure TFrmPedidoCubagem.ColorPedido(pColorProcesso: TColor; aRow : Integer);
Var xCol : Integer;
begin
  for xCol := 1 to Pred(LstPedidosAdv.ColCount) do
    LstPedidosAdv.Colors[xCol, aRow] := pColorProcesso;
end;

procedure TFrmPedidoCubagem.EdtDestinatarioChange(Sender: TObject);
begin
  inherited;
  LblDestinatario.Caption := '...';
  EdtInicioChange(EdtInicio);
end;

procedure TFrmPedidoCubagem.EdtDestinatarioKeyPress(Sender: TObject;
  var Key: Char);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    jsonPessoa      : TJsonObject;
    xRetorno        : Integer;
    vErro           : String;
begin
  inherited;
  if Key = #13 then Begin
     if StrToIntDef(EdtDestinatario.Text, 0) <= 0 then Begin
        if PgcBase.ActivePage = TabPrincipal then
           PnlDetalhe.Caption := '😢Destinatário('+EdtDestinatario.Text+') não encontrado!'
        Else PnlDetalheExcluir.Caption := '😢Destinatário('+EdtDestinatario.Text+') não encontrado!';
        Exit;
     end;
     ObjPessoaCtrl := TPessoaCtrl.Create;
     ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
     if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
        EdtDestinatario.Clear;
        if PgcBase.ActivePage = TabPrincipal then
           PnlDetalhe.Caption := '😢Destinatário('+EdtDestinatario.Text+') não encontrado!'
        Else PnlDetalheExcluir.Caption := '😢Destinatário('+EdtDestinatario.Text+') não encontrado!';;
     end
     Else Begin
        jsonPessoa := ReturnjsonArray.Items[0] as TJSONObject;
        LblDestinatario.Caption := jsonPessoa.GetValue<String>('razao');
        jsonPessoa := Nil;
     end;
     ReturnjsonArray := Nil;
     ObjPessoaCtrl.Free;
  End;
  SoNumeros(Key);
end;

Procedure TFrmPedidoCubagem.EdtInicioChange(Sender: TObject);
begin
  inherited;
  if PgcBase.ActivePage = TabPrincipal then Begin
     PnlDetalhe.Caption      := '👆🏻Informe os dados para pesquisar os pedidos!';
     LblProcCubagem.Caption  := '';
     if ChkProcCubagem.Checked then
        LblProcCubagem.Caption := 'Reprocessamento de pedidos ativado.' + sLIneBreak;
     if ChkProcEtiqueta.Checked then
        LblProcCubagem.Caption := LblProcCubagem.Caption + 'Reprocessamento de Pedidos com etiquetas impressas ativado.' + sLIneBreak;
     if LblProcCubagem.Caption <> '' then
        LblProcCubagem.Caption := '👨🏼‍💼'+LblProcCubagem.Caption;
     PnlLstPedidos.Visible := False;
     LblTotRotas.Caption   := '0';
     LblTotPessoas.Caption := '0';
     LblTotPedidos.Caption := '0';
     BtnProdutoSemPicking.Visible := False;
     PgrProcessar.Progress := 0;
  End
  Else Begin
     PnlDetalheExcluir.Caption   := '👆🏻Informe os dados para pesquisar os pedidos para Excluir!';
     LblProcExcluir.Caption      := '';
     PnlLstPedidosExcluir.Visible       := False;
     LblTotRotaExcluir.Caption   := '0';
     LblTotPessoaExcluir.Caption := '0';
     LblTotPEdidoExcluir.Caption := '0';
     PgrExcluir.Progress := 0;
  End;
end;

procedure TFrmPedidoCubagem.EdtPedidoIdChange(Sender: TObject);
begin
  inherited;
  EdtInicioChange(EdtInicio);
end;

procedure TFrmPedidoCubagem.EdtPedidoIdKeyPress(Sender: TObject; var Key: Char);
begin
  if (key = #13) and (EdtPedidoId.text<>'') then Begin
     BtnPesquisarStandClick(EdtPedidoId);
     Exit;
  End;
  inherited;
  SoNumeros(Key);
end;

procedure TFrmPedidoCubagem.EdtRotaChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtRota then
     LblRota.Caption := '...'
  Else
     LblRotaIdFinal.Caption := '...';
  EdtInicioChange(EdtInicio);
end;

procedure TFrmPedidoCubagem.EdtRotaExit(Sender: TObject);
Var ObjRotaCtrl    : TRotaCtrl;
    ReturnLstRota  : TObjectList<TRotaCtrl>;
    xRetorno       : Integer;
    vErro          : String;
begin
  if (Sender=EdtRotaIdFinal) and (StrToIntDef(EdtRotaIdFinal.Text, 0) > 0) and (StrToIntDef(EdtRotaIdFinal.Text, 0) < StrToIntDef(EdtRota.Text, 0)) then Begin
     EdtRotaIdFinal.SetFocus;
     ShowErro('Rota Final inválida!!!');
     Exit;
  End;
  inherited;
  if (TEdit(Sender).Text<>'') and (Not TEdit(Sender).ReadOnly) then Begin
     if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
        Player('toast4');
        if PgcBase.ActivePage = TabPrincipal then
           PnlDetalhe.Caption := '😢Rota('+TEdit(Sender).Text+') inválida!'
        Else PnlDetalheExcluir.Caption := '😢Rota('+TEdit(Sender).Text+') inválida!';
        Exit;
     end;
     ObjRotaCtrl   := TRotaCtrl.Create;
     ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).text, 0), '', 0);
     if (ReturnLstRota.Count <= 0) then Begin
        TEdit(Sender).Clear;
        Player('toast4');
        PnlDetalhe.Caption := '😢Rota não('+TEdit(Sender).Text+') encontrada!';
     end
     Else Begin
        if Sender = EdtRota then
           LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao
        Else LblRotaIdFinal.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
     End;
     ReturnLstRota := Nil;
     ObjRotaCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmPedidoCubagem.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtZonaId then
     LblZona.Caption := ''
  Else LblZonaExcluir.Caption := '';
  EdtInicioChange(EdtInicio);
end;

procedure TFrmPedidoCubagem.EdtZonaIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmPedidoCubagem.EdtZonaIdExit(Sender: TObject);
Var ObjEnderecamentoZonaCtrl   : TEnderecamentoZonaCtrl;
    ZonaJsonArray : TJSONArray;
    vErro         : String;
begin
  inherited;
  if EdtZonaId.Text = '' then Begin
     LblZona.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtZonaId.Text, 0) <= 0 then Begin
     LblRota.Caption := '';
     ShowErro( '😢Zona/Setor('+EdtZonaId.Text+') inválida!' );
     EdtZonaId.Clear;
     Exit;
  end;
  ObjEnderecamentoZonaCtrl   := TEnderecamentoZonaCtrl.Create;
  ZonaJsonArray := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(EdtZonaId.text, 0), '', 0);
  if ZonaJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin // (ReturnLstRota.Count <= 0) then Begin
     LblZona.Caption := '';
     ShowErro(vErro, 'toast4');
     EdtZonaId.Clear;
  end
  Else
     LblZona.Caption := ZonaJsonArray.Items[0].GetValue<String>('descricao');
  ZonaJsonArray := Nil;
  ObjEnderecamentoZonaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmPedidoCubagem.EdtZonaIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  soNumeros(Key);
end;

procedure TFrmPedidoCubagem.EdtRotaKeyPress(Sender: TObject; var Key: Char);
Var ObjRotaCtrl    : TRotaCtrl;
    ReturnLstRota  : TObjectList<TRotaCtrl>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
{  if Key = #13 then Begin
     if StrToIntDef(EdtRota.Text, 0) <= 0 then Begin
        Player('toast4');
        PnlDetalhe.Caption := '😢Rota('+EdtRota.Text+') não encontrado!';
        Exit;
     end;
     ObjRotaCtrl   := TRotaCtrl.Create;
     ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(EdtRota.text, 0), '', 0);
     if (ReturnLstRota.Count <= 0) then Begin
        EdtDestinatario.Clear;
        Player('toast4');
        PnlDetalhe.Caption := '😢Rota não('+EdtRota.Text+') encontrado!';
     end
     Else
        LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
     ReturnLstRota := Nil;
     ObjRotaCtrl.Free;
  End;
}  SoNumeros(Key);
end;

function TFrmPedidoCubagem.ExcluirPedidos: Boolean;
Var xPedido, xPedSelecionado : Integer;
    JsonArrayPedido    : TJsonArray;
    JsonArrayRetorno   : TJsonArray;
    JsonObjectPedido   : TJsonObject;
    ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    vErro : String;
begin
  if LstPedidosExcluir.RowCount <= 1 then
     ShowErro('Aplique o filtro para pesquisar os pedidos para excluir.')
  Else Begin
    xPedSelecionado := 0;
    for xPedido := 1 to Pred(LstPedidosExcluir.RowCount) do Begin
      if LstPedidosExcluir.Cells[9, xPedido] = '1' then Begin
         xPedSelecionado := 1;
         Break;
      End;
    End;
    if xPedSelecionado = 0 then begin
       ShowErro('Não há pedidos selecionados para Excluir.');
       Exit;
    End;
  End;
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produção - Excluir Pedidos') then
     Exit;
  JsonArrayPedido  := TJsonArray.Create;
  For xPedido := 1 to Pred(LstPedidosExcluir.RowCount) do Begin
    if LstPedidosExcluir.Cells[9, xPedido] = '1' then Begin
       JsonObjectPedido := TJsonObject.Create;
       JsonObjectPedido.AddPair('pedidoid', TJsonNumber.Create(LstPedidosExcluir.Cells[0, xPedido].ToInteger()));
       JsonObjectPedido.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
       JsonObjectPedido.AddPair('terminal', NomeDoComputador);
       JsonArrayPedido.AddElement(JsonObjectPedido);
    End;
  End;
  JsonArrayRetorno := ObjPedidoSaidaCtrl.DelPedidoSaida(JsonArrayPedido);
  If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else ShowOk('Exclusão realizada com sucesso!');
  JsonArrayPedido.Free;
  PgrExcluir.Progress := 0;
  BtnPesquisarStandClick(BtnExcluirPedido);
end;

procedure TFrmPedidoCubagem.FiltraPessoa(pOnOff: Boolean; pPessoaId: Integer);
Var xPedido, xTotPedidos : Integer;
begin
  xTotPedidos := StrToIntDef(LblTotPedidos.Caption, 0);
  if PgcBase.ActivePage = TabPrincipal then Begin
     for xPedido := 1 to Pred(LstPedidosAdv.RowCount) do Begin
       if (pPessoaId = 0) or (pPessoaId = StrToIntDef(LstPedidosAdv.Cells[3, xPedido], 0)) then Begin
          if (pOnOff) and (LstPedidosAdv.Cells[10, xPedido].ToInteger()>0) and (LstPedidosAdv.Cells[7, xPedido].ToInteger()=1) then Begin
             LstPedidosAdv.Cells[9, xPedido] := '1';
          End
          Else Begin
             LstPedidosAdv.Cells[9, xPedido] := '0';
          End;
       End;
     End;
     xTotPedidos := 0;
     For xPedido := 1 to Pred(LstPedidosAdv.RowCount) do Begin
       if LstPedidosAdv.Cells[9, xPedido] = '1' then
          Inc(xTotPedidos);
     End;
     LblTotPedidos.Caption := xTotPedidos.ToString();
  End
  Else Begin
     for xPedido := 1 to Pred(LstPedidosExcluir.RowCount) do Begin
       if (pPessoaId = 0) or (pPessoaId = StrToIntDef(LstPedidosExcluir.Cells[3, xPedido], 0)) then Begin
          if (pOnOff) and (LstPedidosExcluir.Cells[10, xPedido].ToInteger()>0) and (LstPedidosExcluir.Cells[7, xPedido].ToInteger()=1) then Begin
             LstPedidosExcluir.Cells[9, xPedido]   := '1';
          End
          Else Begin
             LstPedidosExcluir.Cells[9, xPedido]   := '0';
          End;
       End;
     End;
     xTotPedidos := 0;
     For xPedido := 1 to Pred(LstPedidosExcluir.RowCount) do Begin
       if LstPedidosExcluir.Cells[9, xPedido] = '1' then
          Inc(xTotPedidos);
     End;
     LblTotPEdidoExcluir.Caption := xTotPedidos.ToString();
  End;
end;

procedure TFrmPedidoCubagem.FiltraRota(pOnOff : Boolean; pRotaId : Integer);
Var xDestinatario, xTotDestinatario : Integer;
begin
  xTotDestinatario := StrToIntDef(LblTotPessoas.Caption, 0);
  if PgcBase.ActivePage = TabPrincipal then Begin
     for xDestinatario := 1 to Pred(LstPessoasAdv.RowCount) do Begin
       if (pRotaId = 0) or (pRotaId = StrToIntDef(LstPessoasAdv.Cells[4, xDestinatario], 0))then Begin
          if (pOnOff) and (LstPessoasAdv.Cells[4, xDestinatario].ToInteger > 0) then Begin
             LstPessoasAdv.Cells[3, xDestinatario] := '1';
             FiltraPessoa(True, StrToIntDef(LstPessoasAdv.Cells[1, xDestinatario], 0));
          End
          Else Begin
             LstPessoasAdv.Cells[3, xDestinatario] := '0';
             FiltraPessoa(False, StrToIntDef(LstPessoasAdv.Cells[1, xDestinatario], 0));
          End;
       End;
     End;
     xTotDestinatario := 0;
     for xDestinatario := 1 to Pred(LstPessoasAdv.RowCount) do Begin
         if LstPessoasAdv.Cells[3, xDestinatario] = '1' then
            Inc(xTotDestinatario);
     End;
     LblTotPessoas.Caption := xTotDestinatario.ToString;
  End
  Else Begin
     for xDestinatario := 1 to Pred(LstPessoasExcluir.RowCount) do Begin
       if (pRotaId = 0) or (pRotaId = StrToIntDef(LstPessoasExcluir.Cells[4, xDestinatario], 0))then Begin
          if (pOnOff) and (LstPessoasExcluir.Cells[4, xDestinatario].ToInteger > 0) then Begin
             LstPessoasExcluir.Cells[3, xDestinatario] := '1';
             FiltraPessoa(True, StrToIntDef(LstPessoasAdv.Cells[1, xDestinatario], 0));
          End
          Else Begin
             LstPessoasExcluir.Cells[3, xDestinatario] := '0';
             FiltraPessoa(False, StrToIntDef(LstPessoasExcluir.Cells[1, xDestinatario], 0));
          End;
       End;
     End;
     xTotDestinatario := 0;
     for xDestinatario := 1 to Pred(LstPessoasExcluir.RowCount) do Begin
         if LstPessoasExcluir.Cells[3, xDestinatario] = '1' then
            Inc(xTotDestinatario);
     End;
     LblTotPessoaExcluir.Caption := xTotDestinatario.ToString;
  End;
end;

procedure TFrmPedidoCubagem.FormClick(Sender: TObject);
begin
  inherited;
//  FrmPedidoCubagem := Nil;
end;

procedure TFrmPedidoCubagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(JsonPedidoCubagem) then
     JsonPedidoCubagem := Nil;
  FrmPedidoCubagem := Nil;
end;

procedure TFrmPedidoCubagem.FormCreate(Sender: TObject);
begin
  inherited;
  LstCadastro.RowCount   := 1;
  LstRotasAdv.RowCount   := 2;
  LstPessoasAdv.RowCount := 2;
  LstPedidosAdv.RowCount := 2;
//  ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0]  := 80	;
    ColWidths[1]  := 75	;
    ColWidths[2]  := 130	;
    ColWidths[3]  := 60	;
    ColWidths[4]  := 280	;
    ColWidths[5]  := 80	;
    ColWidths[6]  := 125	;
    ColWidths[7]  := 50	;
    ColWidths[8]  := 90	;
    ColWidths[9]  := 60	;
    ColWidths[10] := 250	;
    Alignments[1, 0] := taRightJustify;
    Alignments[1, 0] := taCenter;
    Alignments[7, 0] := taRightJustify;
    Alignments[8, 0] := taRightJustify;
    Alignments[9, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
  End;
  With LstRotasAdv do Begin
    ColWidths[0] :=  40;
    ColWidths[1] := 270;
    ColWidths[2] :=  65;
    Alignments[2, 0] := taCenter;
    FontStyles[0, 0] := [FsBold];
    FontStyles[2, 0] := [FsBold];
  End;
  With LstPessoasAdv do Begin
    ColWidths[0] :=  60;
    ColWidths[1] :=  70;
    ColWidths[2] := 180;
    ColWidths[3] :=  65;
    Alignments[0, 0] := taCenter;
    FontStyles[0, 0] := [FsBold];
    Alignments[1, 0] := taCenter;
    Alignments[3, 0] := taCenter;
    FontStyles[3, 0] := [FsBold];
  End;
  LstPessoasAdv.HideColumn(4);
  With LstPedidosAdv do Begin
    ColWidths[0] := 55	;
    ColWidths[1] := 80	;
    ColWidths[2] := 80	;
    ColWidths[3] := 65	;
    ColWidths[4] := 220	;
    ColWidths[5] := 110	;
    ColWidths[6] := 45	;
    ColWidths[7] := 40	;
    ColWidths[8] := 30	;
    ColWidths[9] := 65;
    Alignments[ 0, 0] := taRightJustify;
    FontStyles[ 0, 0] := [FsBold];
    Alignments[ 3, 0] := taRightJustify;
    Alignments[ 6, 0] := taRightJustify;
    Alignments[ 7, 0] := taCenter;
    Alignments[ 8, 0] := taCenter;
    Alignments[ 9, 0] := taCenter;
    FontStyles[10, 0] := [FsBold];
    FontStyles[ 9, 0] := [FsBold];
  End;
//
  With LstRotasExcluir do Begin
    ColWidths[0] :=  40;
    ColWidths[1] := 270;
    ColWidths[2] :=  65;
    Alignments[2, 0] := taCenter;
    FontStyles[0, 0] := [FsBold];
    FontStyles[2, 0] := [FsBold];
  End;
  With LstPessoasExcluir do Begin
    ColWidths[0] :=  60;
    ColWidths[1] :=  70;
    ColWidths[2] := 180;
    ColWidths[3] :=  65;
    Alignments[0, 0] := taCenter;
    FontStyles[0, 0] := [FsBold];
    Alignments[1, 0] := taCenter;
    Alignments[3, 0] := taCenter;
    FontStyles[3, 0] := [FsBold];
  End;
  LstPessoasExcluir.HideColumn(4);
  With LstPedidosExcluir do Begin
    ColWidths[0]  := 55	;
    ColWidths[1]  := 80	;
    ColWidths[2]  := 80	;
    ColWidths[3]  := 65	;
    ColWidths[4]  := 220	;
    ColWidths[5]  := 110	;
    ColWidths[6]  := 45	;
    ColWidths[7]  := 40	;
    ColWidths[8]  := 30	;
    ColWidths[9]  := 65;
    Alignments[0, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[3, 0] := taRightJustify;
    Alignments[6, 0] := taRightJustify;
    Alignments[7, 0] := taCenter;
    Alignments[8, 0] := taCenter;
    Alignments[9, 0] := taCenter;
    FontStyles[10, 0] := [FsBold];
    FontStyles[9, 0] := [FsBold];
  End;
  LstPedidosAdv.HideColumn(10);
  LstPedidosExcluir.HideColumn(10);
  EdtInicioChange(EdtInicio);
  SelRota   := True;
  SelPessoa := True;
  SelPedido := True;
  PnlDetalhe.Caption         := '👆🏻Informe os dados para pesquisar os pedidos!';
  PnlDetalheExcluir.Caption  := '👆🏻Informe os dados para Excluir os pedidos!';
  TabExcuirPedido.TabVisible := FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produção - Excluir Pedidos');
end;

procedure TFrmPedidoCubagem.FormDestroy(Sender: TObject);
begin
//  ObjPedidoCtrl.Free;
  inherited;
end;

Function TFrmPedidoCubagem.GetEstoqueParaCaixaFechada(pIndiceLstPedido : Integer) : Boolean;
Var ObjPedidoCtrl      : TPedidoSaidaCtrl;
    ReturnJsonArray    : TJsonArray;
    vLote, vBloqueado  : Integer;
    xProdPed : Integer;
    JsonEstoqueCubagem : TJsonObject;
    vData, vErro : String;
begin
  Result := True;
  QryEstoqueDisponivel_CaixaFechada.Close;
  QryEstoqueDisponivel_CaixaFechada.CreateDataSet;
  QryEstoqueDisponivel_CaixaFechada.Open;
  ObjPedidoCtrl := TPedidoSaidaCtrl.Create;
  Try
    ReturnJsonArray := ObjPedidoCtrl.PedidoCubagem(LstPedidosAdv.Cells[0, pIndiceLstPedido].ToInteger());
    if Not ReturnJsonArray.Items[0].TryGetValue('Erro', vErro) then Begin
//       ShowErro('Erro no processamento de Caixa Fechada: Pedido: '+LstPedidosAdv.Cells[0, pIndiceLstPedido]+' -  '+vErro)
//    Else Begin
       vLote      := 0;
       vBloqueado := 0;
       for xProdPed := 0 to ReturnJsonArray.count-1 do Begin
         jsonEstoqueCubagem := ReturnJsonArray.Items[xProdPed] as tjsonObject;
         if (Not jsonEstoqueCubagem.TryGetValue('Obs', vErro))  then With QryEstoqueDisponivel_CaixaFechada do Begin
            if (jsonEstoqueCubagem.GetValue<Integer>('qtde') >= jsonEstoqueCubagem.GetValue<integer>('embsec'))
               //and (jsonEstoqueCubagem.GetValue<integer>('embsec')>1)
               then Begin
               if vLote <> jsonEstoqueCubagem.GetValue<integer>('loteid') then Begin
                  vLote      := jsonEstoqueCubagem.GetValue<integer>('loteid');
                  vBloqueado := jsonEstoqueCubagem.GetValue<integer>('bloqueado');
               End;
               Append;
               FieldByName('ProdutoId').AsInteger       := jsonEstoqueCubagem.GetValue<integer>('produtoid');
               FieldByName('EmbPrim').AsInteger         := jsonEstoqueCubagem.GetValue<integer>('embprim');
               FieldByName('embsec').AsInteger          := jsonEstoqueCubagem.GetValue<integer>('embsec');
               FieldByName('MesSaidaMinima').AsInteger  := jsonEstoqueCubagem.GetValue<integer>('messaidaminima');
               FieldByName('loteid').AsInteger          := jsonEstoqueCubagem.GetValue<integer>('loteid');
               vData := jsonEstoqueCubagem.GetValue<String>('vencimento');
               vData := Copy(vData, 9, 2)+'/'+Copy(vData, 6, 2)+'/'+Copy(vData, 1, 4);
               FieldByName('Vencimento').AsDateTime     := StrToDate(vData);
               FieldByName('EnderecoId').AsInteger      := jsonEstoqueCubagem.GetValue<Integer>('enderecoid');
               FieldByName('QtdPedido').AsInteger       := jsonEstoqueCubagem.GetValue<Integer>('qtdpedido');
               FieldByName('EmbalagemPadrao').AsInteger := jsonEstoqueCubagem.GetValue<Integer>('embalagempadrao');
               if (vBloqueado <> 0) and (jsonEstoqueCubagem.GetValue<integer>('qtde')>=vBloqueado) then Begin
                  FieldByName('Qtde').AsInteger := jsonEstoqueCubagem.GetValue<integer>('qtde')-vBloqueado;
                  vBloqueado := 0;
               End
               Else if (vBloqueado <> 0) then Begin
                  vBloqueado := vBloqueado - jsonEstoqueCubagem.GetValue<integer>('qtde');
                  FieldByName('Qtde').AsInteger := 0;
               End
               Else
                  FieldByName('Qtde').AsInteger            := jsonEstoqueCubagem.GetValue<integer>('qtde');
               FieldByName('EstoqueTipoId').AsInteger   := jsonEstoqueCubagem.GetValue<Integer>('estoquetipoid');
               if (Pos('PROCESSADO', UpperCase(LstPedidosAdv.Cells[4, pIndiceLstPedido])) > 0) or
                  (Pos('ETIQUETA', UpperCase(LstPedidosAdv.Cells[4, pIndiceLstPedido])) > 0) or
                  (Pos('RE-PROCESSADO', UpperCase(LstPedidosAdv.Cells[4, pIndiceLstPedido])) > 0) then
                  FieldByName('Reprocessado').AsBoolean   := True
               else
                  FieldByName('Reprocessado').AsBoolean   := False;
               //PedidoCubagemVolume_CaixaFechada(LstPedidosAdv.Cells[0, xPedido].ToInteger());
            End;
         End;
         JsonEstoqueCubagem := Nil;
         Result := True;
       End;
    End;
    ObjPedidoCtrl.Free;
    ReturnJsonArray := Nil;
  Except On E: Exception do Begin
    ShowErro('Erro(701). Pedido: '+LstPedidosAdv.Cells[0, pIndiceLstPedido]+'.   '+E.Message);
    ObjPedidoCtrl.Free;
    If Assigned(ReturnJsonArray) then ReturnJsonArray    := Nil;
    If Assigned(JsonEstoqueCubagem) then JsonEstoqueCubagem := Nil;
    End;
  End;
end;

procedure TFrmPedidoCubagem.GetListaLstCadastro;
begin
  inherited;
  GetListaPedido(0)
//  PgcBase.ActivePage := TabPrincipal;
//  PgcBase.ActivePageIndex := 1;
end;

function TFrmPedidoCubagem.GetListaPedido(pPedidoId: Integer; pCodigoERP : Integer; pPessoaId : Integer; pDocumentoNr : String; pRazao : String;
                                          pRegistroERP : String; pRotaId : Integer; pRotaIdFinal : Integer; pDocumentoData : TDateTime; pShowErro : Integer): Boolean;
Var ObjPedidoCtrl : TPedidoSaidaCtrl;
    vErro : String;
    vRecebido, vCubagem, vEtiqueta : Integer;
    vResultado : Boolean;
begin
  Result := False;
  TmProcessando.Enabled := True;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    begin
      ObjPedidoCtrl     := TPedidoSaidaCtrl.Create;
//      JsonPedidoCubagem := ObjPedidoCtrl.PedidoProcessar(pPedidoId, pCodigoERP, pPessoaId, pDocumentoData, pDocumentoData,
//                                                         pDocumentoNr, pRazao, pRegistroERP, pRotaId, 1, 1, 1, 1, True, 2, 0, 0, 0, '');
      JsonPedidoCubagem := ObjPedidoCtrl.PedidoParaProcessamento(pPedidoId, pCodigoERP, pDocumentoData, pDocumentoData, 0,
                                                         pRotaId, pRotaIdFinal, 0, 1, 0, 0);
      if JsonPedidoCubagem.Get(0).tryGetValue<String>('Erro', vErro) then Begin
           PnlProcessando.Visible := False;
           TmProcessando.Enabled  := False;
           PnlDetalhe.Caption := '😢Erro: '+vErro;
      End
      Else Begin
        MontaLstCadastro;
        TmProcessando.Enabled  := False;
        vResultado := True;
      end;
      JsonPedidoCubagem := Nil;
      ObjPedidoCtrl.Free;
    End);
    Result := vResultado;
end;

procedure TFrmPedidoCubagem.LimpaField;
begin
  inherited;

end;

procedure TFrmPedidoCubagem.LstPedidosAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xPedido, xTotPedidos : Integer;
begin
  inherited;
  if TAdvStringGrid(Sender).RowCount <= 1 then Exit;
  if PgcBase.ActivePage = TabPrincipal then
     xTotPedidos := StrToIntDef(LblTotPedidos.Caption, 0);
  if (aCol = 9) then Begin
     if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin
        For xPedido := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          if SelPedido then Begin
             TAdvStringGrid(Sender).Cells[9, xPedido]   := '0';
          End
          Else if ((Sender=TAdvStringGrid(Sender)) and (StrToIntDef(TAdvStringGrid(Sender).Cells[10, xPedido], 0) > 0) and
             (StrToIntDef(TAdvStringGrid(Sender).Cells[7, xPedido], 0) > 0) and
             (StrToIntDef(TAdvStringGrid(Sender).Cells[8, xPedido], 0) > 0)) or
             (Sender=LstPedidosExcluir) then Begin
             TAdvStringGrid(Sender).Cells[9, xPedido] := '1';
          End;
        End;
        xTotPedidos := 0;
        For xPedido := 1 to Pred(TAdvStringGrid(Sender).RowCount) do
          if TAdvStringGrid(Sender).Cells[9, xPedido] = '1' then
             Inc(xTotPedidos);
        SelPedido := Not SelPedido;
     End
     Else Begin
       if (StrToIntDef(TAdvStringGrid(Sender).Cells[9, aRow], 0) = 0) and
          (((Sender=LstPedidosAdv) and ((StrToIntDef(TAdvStringGrid(Sender).Cells[10, aRow], 0) > 0)) and
          (StrToIntDef(TAdvStringGrid(Sender).Cells[7, aRow], 0) > 0) and (StrToIntDef(TAdvStringGrid(Sender).Cells[8, aRow], 0) > 0)) or
          ((Sender=LstPedidosExcluir) and ((StrToIntDef(TAdvStringGrid(Sender).Cells[10, aRow], 0) > 0)))) then Begin
          TAdvStringGrid(Sender).Cells[9, aRow] := '1';
          Inc(xTotPedidos);
       End
       Else Begin
          TAdvStringGrid(Sender).Cells[9, aRow] := '0';
          Dec(xTotPedidos);
       End;
     End;
     LblTotPedidos.Caption := xTotPedidos.ToString();
  End;
end;

procedure TFrmPedidoCubagem.LstPessoasAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xPessoa, xTotPessoas : Integer;
begin
  inherited;
  if PgcBase.ActivePage = TabPrincipal then
     xTotPessoas := StrToIntDef(LblTotPessoas.Caption, 0);
  if TAdvStringGrid(Sender).RowCount <= 1 then Exit;  if (aCol = 3) then Begin
     if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin
        For xPessoa := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          if SelPessoa then Begin
             TAdvStringGrid(Sender).Cells[3, xPessoa]   := '0';
          End
          Else Begin
             If TAdvStringGrid(Sender).Cells[4, xPessoa].ToInteger > 0 then begin
                TAdvStringGrid(Sender).Cells[3, xPessoa] := '1';
             End;
          End;
        End;
        xTotPessoas := 0;
        For xPessoa := 1 to Pred(TAdvStringGrid(Sender).RowCount) do
          if TAdvStringGrid(Sender).Cells[3, xPessoa] = '1' then
             Inc(xTotPessoas);
        SelPessoa := Not SelPessoa;
        FiltraPessoa(SelPessoa, 0);
     End
     Else Begin
       if StrToIntDef(TAdvStringGrid(Sender).Cells[3, aRow], 0) = 0 then Begin
          If TAdvStringGrid(Sender).Cells[4, aRow].ToInteger > 0 then Begin
             TAdvStringGrid(Sender).Cells[3, aRow] := '1';
             Inc(xTotPessoas);
          End;
          FiltraPessoa(True, StrToIntDef(TAdvStringGrid(Sender).Cells[1, aRow], 0));
       End
       Else Begin Begin
         TAdvStringGrid(Sender).Cells[3, aRow] := '0';
         Dec(xTotPessoas);
         FiltraPessoa(False, StrToIntDef(TAdvStringGrid(Sender).Cells[1, aRow], 0));
         End;
       End;
     End;
     LblTotPessoas.Caption := xTotPessoas.ToString()
  End;
end;

procedure TFrmPedidoCubagem.LstRotasAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xRota, xTotRotas : Integer;
begin
  inherited;
  if TAdvStringGrid(Sender).RowCount <= 1 then Exit;
  if PgcBase.ActivePage = TabPrincipal then
     xTotRotas := StrToIntDef(LblTotRotas.Caption, 0)
  Else xTotRotas := StrToIntDef(LblTotRotaExcluir.Caption, 0);
  if (aCol = 2) then Begin
     if (aRow = 0) and (TAdvStringGrid(Sender).RowCount>1) then Begin
        xTotRotas := 0;
        For xRota := 1 to Pred(TAdvStringGrid(Sender).RowCount) do Begin
          if SelRota then Begin
             TAdvStringGrid(Sender).Cells[2, xRota] := '0';
          End
          Else Begin
             TAdvStringGrid(Sender).Cells[2, xRota] := '1';
          End;
        End;
        For xRota := 1 to Pred(TAdvStringGrid(Sender).RowCount) do
          if TAdvStringGrid(Sender).Cells[2, xRota] = '1' then
             Inc(xTotRotas);
        SelRota := Not SelRota;
        FiltraRota(SelRota, 0);
     End
     Else Begin
       if StrToIntDef(TAdvStringGrid(Sender).Cells[2, aRow], 0) = 0 then Begin
          TAdvStringGrid(Sender).Cells[2, aRow] := '1';
          FiltraRota(True, StrToIntDef(TAdvStringGrid(Sender).Cells[0, aRow], 0));
          Inc(xTotRotas);
       End
       Else Begin
         TAdvStringGrid(Sender).Cells[2, aRow] := '0';
         FiltraRota(False, StrToIntDef(TAdvStringGrid(Sender).Cells[0, aRow], 0));
         Dec(xTotRotas);
       End;
     End;
  End;
  if PgcBase.ActivePage = TabPrincipal then
     LblTotRotas.Caption := xTotRotas.ToString()
  Else LblTotRotaExcluir.Caption := xTotRotas.ToString();
end;

procedure TFrmPedidoCubagem.MontaListaDestinatario(LstAdv : TAdvStringGrid);
Var jsonArrayPessoas : tjsonArray;
    jsonPessoa       : tjsonObject;
    xRetorno         : Integer;
begin
  jsonArrayPessoas := JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pessoa'); //ReturnArrayJson.GetValue<tJsonArray>('Pedido');
  LstAdv.RowCount := jsonArrayPessoas.Count+1;
  LblTotPessoas.Caption  := jsonArrayPessoas.Count.ToString;
  if LstAdv.RowCount > 1 then
     LstAdv.FixedRows := 1;
  for xRetorno := 1 to LstAdv.RowCount - 1 do
    LstAdv.AddDataImage(3, xRetorno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  For xRetorno := 0 to Pred(jsonArrayPessoas.Count) do Begin
    jsonPessoa   := jsonArrayPessoas.Items[xRetorno] as TJSONObject;
    LstAdv.Cells[0, xRetorno+1] := jsonPessoa.GetValue<Integer>('pessoaid').ToString;
    LstAdv.Cells[1, xRetorno+1] := jsonPessoa.GetValue<Integer>('codpessoaerp').ToString;
    LstAdv.Cells[2, xRetorno+1] := jsonPessoa.GetValue<String>('razao');
    if jsonPessoa.GetValue<Integer>('rotaid', 0) > 0 then
       LstAdv.Cells[3, xRetorno+1] := '1'
    Else LstAdv.Cells[3, xRetorno+1] := '0';
    LstAdv.Cells[4, xRetorno+1] := jsonPessoa.GetValue<Integer>('rotaid', 0).ToString();
    LstAdv.FontStyles[0, xRetorno+1] := [FsBold];
    LstAdv.Alignments[0, xRetorno+1] := taRightJustify;
    LstAdv.Alignments[1, xRetorno+1] := taRightJustify;
  End;
  jsonArrayPessoas := Nil;
  LstAdv.HideColumn(4);
end;

procedure TFrmPedidoCubagem.MontaListaPedido(LstAdv : TAdvStringGrid);
Var //ReturnArrayJson : TJsonArray;
    xRetorno : Integer;
    jsonArrayPedidos : tjsonArray;
    jsonPedido, jsonOperacao, jsonPessoa : TjsonObject;
    vTotPedido : Integer;
    vColorProcesso : TColor;
begin
  BtnProdutoSemPicking.Visible := False;
  jsonArrayPedidos := JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido'); //ReturnArrayJson.GetValue<tJsonArray>('Pedido');
  LstAdv.RowCount := jsonArrayPedidos.Count+1;
  LblTotPEdidos.Caption  := jsonArrayPedidos.Count.ToString;
  vTotPedido := 0;
  if LstAdv.RowCount > 1 then Begin
     LstAdv.FixedRows := 1;
     for xRetorno := 1 to LstAdv.RowCount - 1 do Begin
       LstAdv.AddDataImage(7, xRetorno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstAdv.AddDataImage(8, xRetorno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
       LstAdv.AddDataImage(9, xRetorno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
     End;
     For xRetorno := 0 to Pred(jsonArrayPedidos.Count) do Begin
       if (jsonArrayPedidos.Items[xRetorno].GetValue<TJsonObject>.getValue<Integer>('statusmax') <= 3) then Begin
          jsonPedido   := jsonArrayPedidos.Items[xRetorno] as TJSONObject;
          LstAdv.Cells[0, vTotPedido+1]    := jsonPedido.GetValue<String>('pedidoid');
          LstAdv.Cells[5, vTotPedido+1]    := jsonPedido.GetValue<String>('processoetapa');
          if jsonPedido.GetValue<Integer>('processoid') = 1 then
             vColorProcesso := ClWhite
          Else if (jsonPedido.GetValue<Integer>('processoid') = 3) or (jsonPedido.GetValue<Integer>('statusmax') = 3) then
             vColorProcesso := $00CCCCFF
          Else if jsonPedido.GetValue<Integer>('processoid') = 2 then
             vColorProcesso := $009AF0F8;
          jsonOperacao := jsonPedido.GetValue<tJsonObject>('operacaotipo');
          LstAdv.Cells[1, vTotPedido+1] := jsonPedido.GetValue<String>('documentodatar');
          LstAdv.Cells[2, vTotPedido+1]    := jsonOperacao.GetValue<String>('descricao');
          jsonPessoa   := jsonPedido.GetValue<tJsonObject>('pessoa');
          LstAdv.Cells[3, vTotPedido+1]    := jsonPessoa.GetValue<String>('codpessoaerp');
          LstAdv.Cells[4, vTotPedido+1]    := jsonPessoa.GetValue<String>('fantasia');
          LstAdv.Cells[6, vTotPedido+1]    := jsonPedido.GetValue<Integer>('qtdproduto').ToString();
          LstAdv.Cells[7, vTotPedido+1]    := jsonPedido.GetValue<Integer>('picking').ToString(); //Indica se todos os produtos estão endereçados
          if (Not BtnProdutoSemPicking.Visible) and (jsonPedido.GetValue<Integer>('picking')=0) then
             BtnProdutoSemPicking.Visible := True;
          if jsonPessoa.GetValue<Integer>('rotaid') > 0 then
             LstAdv.Cells[8, vTotPedido+1]    := '1'
          Else LstAdv.Cells[8, vTotPedido+1]    := '0';
          if (jsonPessoa.GetValue<Integer>('rotaid') > 0) and (jsonPedido.GetValue<Integer>('picking')=1) then
             LstAdv.Cells[9, vTotPedido+1]    := '1'
          Else LstAdv.Cells[9, vTotPedido+1]    := '0';
          LstAdv.Cells[10, xRetorno+1]    := jsonPessoa.GetValue<Integer>('rotaid', 0).ToString;
          LstAdv.Cells[11, xRetorno+1]    := jsonPedido.GetValue<Integer>('statusmax', 0).ToString;
          LstAdv.FontStyles[0, vTotPedido+1] := [FsBold];
          LstAdv.Alignments[0, vTotPedido+1] := taRightJustify;
          LstAdv.Alignments[3, vTotPedido+1] := taRightJustify;
          LstAdv.Alignments[6, vTotPedido+1] := taRightJustify;
          LstAdv.Alignments[7, vTotPedido+1] := taCenter;
          LstAdv.Alignments[8, vTotPedido+1] := taCenter;
          LstAdv.Alignments[9, vTotPedido+1] := taCenter;
          ColorPedido(vColorProcesso, vTotPedido+1);
          Inc(vTotPedido);
       End;
     End;
     LstAdv.RowCount := vTotPedido+1;
     jsonPedido   := Nil;
     jsonOperacao := Nil;
     jsonPessoa   := Nil;
  end;
  jsonArrayPedidos := Nil;
end;

procedure TFrmPedidoCubagem.MontaListaRota(LstAdv : TAdvStringGrid);
Var jsonArrayRotas : TJsonArray;
    jsonRota       : tjsonObject;
    xRetorno       : Integer;
begin
  jsonArrayRotas := JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('rota'); //ReturnArrayJson.GetValue<tJsonArray>('Pedido');
  LstAdv.RowCount := jsonArrayRotas.Count+1;
  LblTotRotas.Caption  := jsonArrayRotas.Count.ToString;
  if LstAdv.RowCount > 1 then
     LstAdv.FixedRows := 1;
  for xRetorno := 0 to Pred(LstAdv.RowCount) do
    LstAdv.AddDataImage(2, xRetorno+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  For xRetorno := 0 to Pred(jsonArrayRotas.Count) do Begin
    jsonRota   := jsonArrayRotas.Items[xRetorno] as TJSONObject;
    LstAdv.Cells[0, xRetorno+1] := jsonRota.GetValue<String>('rotaid');
    LstAdv.Cells[1, xRetorno+1] := jsonRota.GetValue<String>('descricao');
    LstAdv.Cells[2, xRetorno+1] := '1';
    LstAdv.FontStyles[0, xRetorno+1] := [FsBold];
    LstAdv.Alignments[0, xRetorno+1] := taRightJustify;
  End;
  jsonArrayRotas := Nil;
end;

procedure TFrmPedidoCubagem.MontaLstCadastro;
Var jsonArrayPedidos : TJsonArray;
    jsonPedido, jsonOperacao, jsonPessoa : tjsonObject;
    xRetorno         : Integer;
begin
  jsonArrayPedidos := JsonPedidoCubagem.Items[0].GetValue<TJsonArray>('pedido'); //ReturnArrayJson.GetValue<tJsonArray>('Pedido');
  LstCadastro.RowCount := jsonArrayPedidos.Count+1;
  if LstCadastro.RowCount > 1 then
     LstCadastro.FixedRows := 1;
  For xRetorno := 0 to Pred(jsonArrayPedidos.Count) do Begin
    jsonPedido   := jsonArrayPedidos.Items[xRetorno] as TJSONObject;
    LstCadastro.Cells[0, xRetorno+1] := jsonPedido.GetValue<String>('pedidoid');
    LstCadastro.Cells[1, xRetorno+1] := jsonPedido.GetValue<String>('documentodatar');
    jsonOperacao := jsonPedido.GetValue<tJsonObject>('operacaotipo');
    LstCadastro.Cells[2, xRetorno+1] := jsonOperacao.GetValue<String>('descricao');
    jsonPessoa   := jsonPedido.GetValue<tJsonObject>('pessoa');
    LstCadastro.Cells[ 3, xRetorno+1] := jsonPessoa.GetValue<String>('codpessoaerp');
    LstCadastro.Cells[ 4, xRetorno+1] := jsonPessoa.GetValue<String>('fantasia');
    LstCadastro.Cells[ 5, xRetorno+1] := jsonPedido.GetValue<String>('documentonr');
    LstCadastro.Cells[ 6, xRetorno+1] := jsonPedido.GetValue<String>('processoetapa');
    LstCadastro.Cells[ 7, xRetorno+1] := jsonPedido.GetValue<Integer>('qtdproduto').ToString();
    LstCadastro.Cells[ 8, xRetorno+1] := FormatFloat('0.000000', jsonPedido.GetValue<Double>('volume'));
    LstCadastro.Cells[ 9, xRetorno+1] := jsonPedido.GetValue<Integer>('peso').ToString();;
    LstCadastro.Cells[10, xRetorno+1] := FormatFloat('###0', jsonPessoa.GetValue<Integer>('rotaid'))+' '+jsonPessoa.GetValue<String>('rota'); //jsonPedido.GetValue<String>('registroerp');
    LstCadastro.Alignments[0, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[3, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[7, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[8, xRetorno+1] := taRightJustify;
    LstCadastro.Alignments[9, xRetorno+1] := taRightJustify;
    LstCadastro.FontStyles[0, xRetorno+1] := [FsBold];
  End;
  jsonArrayPedidos := Nil;
end;

procedure TFrmPedidoCubagem.BtnPrintMapaClick(Sender: TObject);
begin
  inherited;
  PrintMapaSeparacao;
end;

Function TFrmPedidoCubagem.PedidoCubagemVolume_CaixaFechada(pPedidoId : Integer) : Boolean;
Var ObjPedidoCtrl    : TPedidoSaidaCtrl;
    ArrayJsonVolume, ArrayJsonRetorno : tjsonArray;
    jsonVolume       : tjsonObject;
    vProduto, vSaldo : Integer;
    vQtVolume        : Integer;
    vErro, vResultado : String;
begin
  Result := True; //Retorno com Erro
  Try
    vProduto := 0;
    QryEstoqueDisponivel_CaixaFechada.First;
    ArrayJsonVolume := tjsonArray.Create;
    With QryEstoqueDisponivel_CaixaFechada do While Not Eof do Begin
      LblPedidoProc.Caption := 'Pedido: '+pPedidoId.ToString()+' Cxa.Fec.';
      Application.ProcessMessages;
      if (vProduto <> FieldByName('ProdutoId').AsInteger) Then Begin
         vProduto := FieldByName('ProdutoId').AsInteger;
         vSaldo   := (FieldByName('QtdPedido').AsInteger);// Div FieldByName('EmbSec').AsInteger) * FieldByName('EmbSec').AsInteger;
      End;
      While (vSaldo >=FieldByName('embsec').AsInteger) and
            (FieldByName('Qtde').AsInteger >= FieldByName('embsec').AsInteger) do Begin
         if FieldByName('Qtde').AsInteger >= FieldByName('embsec').AsInteger then Begin
            jsonVolume := tjsonObject.Create();
            jsonVolume.AddPair('pedidoid', pPedidoId.ToString());
            jsonVolume.AddPair('loteid', TJSONNumber.Create(FieldByName('LoteId').AsInteger));
            jsonVolume.AddPair('enderecoid', TJSONNumber.Create(FieldByName('EnderecoId').AsInteger));
            jsonVolume.AddPair('estoquetipoid', TJSONNumber.Create(FieldByName('EstoqueTipoId').AsInteger));
            if vSaldo >= FieldByName('Qtde').AsInteger  then
               vQtVolume := FieldByName('Qtde').AsInteger Div FieldByName('EmbSec').AsInteger
            Else vQtVolume := vSaldo Div FieldByName('EmbSec').AsInteger;
            jsonVolume.AddPair('qtvolume', TJSONNumber.Create(vQtVolume));
            jsonVOlume.AddPair('quantidade', TJSONNumber.Create(FieldByName('embsec').AsInteger));   //Qtde Solicitada, Emb.Cxa.Fechada
            jsonVOlume.AddPair('embalagempadrao', TJSONNumber.Create(FieldByName('EmbalagemPadrao').AsInteger));   //Qtde Solicitada, Emb.Cxa.Fechada
            jsonVOlume.AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));   //Qtde Solicitada, Emb.Cxa.Fechada
            jsonVOlume.AddPair('terminal', NomeDoComputador);   //Qtde Solicitada, Emb.Cxa.Fechada
            If FieldByName('Reprocessado').AsBoolean then
               jsonVolume.AddPair('reprocessado', tjsonNumber.Create(1))
            Else jsonVolume.AddPair('reprocessado', tjsonNumber.Create(0));
            Edit;
            FieldByName('Qtde').AsInteger := FieldByName('Qtde').AsInteger - (vQtVolume*FieldByName('EmbalagemPadrao').AsInteger);
            ArrayJsonVolume.AddElement(jsonVOlume);
            vSaldo := vSaldo - (vQtVolume * FieldByName('embsec').AsInteger); //Quantidades de Volumes Caixa Fechada
         End
         Else Begin
            vSaldo := 0;
         End;
      End;
      Next;
    End;
    if ArrayJsonVolume.Count > 0 then Begin
       ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
       ArrayJsonRetorno := ObjPedidoCtrl.GerarVolume(ArrayjsonVolume, 'FC');
       if ArrayJsonRetorno.Count > 0 then Begin
          if ArrayJsonRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
             Player('toast4');
             PnlDetalhe.Caption := '😢Erro: '+vErro;
          end;
       End;
      ArrayJsonRetorno := nil;
      ObjPedidoCtrl.Free;
    End;
    ArrayJsonVolume.Free; // := Nil;
    Result := False;
  Except On E: Exception do Begin
     ShowErro('Erro(702): '+E.Message);
     End;
  End;
end;

Function TFrmPedidoCubagem.PedidoCubagemVolume_CaixaFracionada(
  pPedidoId: Integer; Reprocessado : Boolean) : Boolean;
Var ObjPedidoFracCtrl         : TPedidoSaidaCtrl;
    ReturnJsonArrayFrac   : TJsonArray;
    jsonProdCxaFracionada : TJsonObject;
    vErro, vData          : String;
    xRetorno              : Integer;
    vProdutoId            : Integer;
    vZonaId, vRuaId       : Integer;
    vPesoProduto   : Double;
    vVolumeProduto : Double;
    vQtdProdKgToCaixa, vQtdProdVlmToCaixa : Integer;
    vSaldoQtdSolicitada, vQtdProd, vQtLoteVolume : Integer;
    vSaldoCaixaVolume, vSaldoCaixaPeso : Double;
    vVolumeOpen      : Boolean;
    jsonVolume       : tjsonObject;
    jsonVolumeLote   : tjsonObject;
    ArrayJsonVolumeLotes, ArrayJsonVolumes, ArrayJsonRetorno : tJsonArray;
    vNumVolume, vLote, vBloqueado : Integer;
    Teste : String;
begin
  Result := True; //Retorno com Erro
  Try
    ObjPedidoFracCtrl       := TPedidoSaidaCtrl.Create;
    ReturnJsonArrayFrac := ObjPedidoFracCtrl.PedidoCubagemVolume_CaixaFracionada(pPedidoId);
    if ReturnJsonArrayFrac.Items[0].GetValue<TJsonObject>.TryGetValue('Erro', vErro) then Begin
       ShowErro('😢Erro: '+vErro);
       //Result := False;
    end
    Else if ReturnJsonArrayFrac.Items[0].GetValue<TJsonObject>.TryGetValue('MSG', vErro) then Begin
       ShowOk('Atenção: '+vErro);
       Result := False;
    end
    Else begin
       QryEstoqueDisponivel_CaixaFracionada.Close;
       QryEstoqueDisponivel_CaixaFracionada.CreateDataSet;
       QryEstoqueDisponivel_CaixaFracionada.Open;
       //Cubagem do Pedido Produto x Caixa
       LblPedidoProc.Caption := 'Pedido: '+pPedidoId.ToString+' Frac.';
       Application.ProcessMessages;
       vLote      := 0;
       vBloqueado := 0;
       for xRetorno := 0 to Pred(ReturnJsonArrayFrac.Count) do Begin
         jsonProdCxaFracionada := ReturnJsonArrayFrac.Items[xRetorno] as tjsonObject;

         if Not jsonProdCxaFracionada.TryGetValue('Erro', vErro) then With QryEstoqueDisponivel_CaixaFracionada do Begin
            Append;
            if vLote <> jsonProdCxaFracionada.GetValue<integer>('loteid') then Begin
               vLote      := jsonProdCxaFracionada.GetValue<integer>('loteid');
               vBloqueado := jsonProdCxaFracionada.GetValue<integer>('bloqueado');
            End;
            //if (DebugHook<>0) and (jsonProdCxaFracionada.GetValue<integer>('produtoid') = 9298) then
            //   ShowMessage('Demanda: '+jsonProdCxaFracionada.GetValue<String>('qtdsolicitada')+'    Estoque = '+jsonProdCxaFracionada.GetValue<String>('qtde'));
            FieldByName('ProdutoId').AsInteger       := jsonProdCxaFracionada.GetValue<integer>('produtoid');
            FieldByName('EnderecoId').AsInteger      := jsonProdCxaFracionada.GetValue<integer>('enderecoid');
            FieldByName('EnderecoOrigem').AsInteger  := jsonProdCxaFracionada.GetValue<integer>('enderecoorigem');
            FieldByName('FatorConversao').AsInteger  := jsonProdCxaFracionada.GetValue<integer>('fatorconversao');
            FieldByName('EmbalagemPadrao').AsInteger := jsonProdCxaFracionada.GetValue<integer>('embalagempadrao');
            FieldByName('VolumeCm3').AsFloat         := jsonProdCxaFracionada.GetValue<Double>('volumecm3');
            FieldByName('PesoLiquidoKg').AsFloat     := jsonProdCxaFracionada.GetValue<Double>('pesoliquidokg');
            FieldByName('QtdSolicitada').AsInteger   := jsonProdCxaFracionada.GetValue<integer>('qtdsolicitada');
            FieldByName('LoteId').AsInteger          := jsonProdCxaFracionada.GetValue<integer>('loteid');
            FieldByName('EstoqueTipoId').AsInteger   := jsonProdCxaFracionada.GetValue<integer>('estoquetipoid');
            if (vBloqueado <> 0) and (jsonProdCxaFracionada.GetValue<integer>('qtde')>=vBloqueado) then Begin
               FieldByName('Qtde').AsInteger := jsonProdCxaFracionada.GetValue<integer>('qtde')-vBloqueado;
               vBloqueado := 0;
            End
            Else if (vBloqueado <> 0) then Begin
               vBloqueado := vBloqueado - FieldByName('Qtde').AsInteger;
               FieldByName('Qtde').AsInteger := 0;
            End
            Else
               FieldByName('Qtde').AsInteger            := jsonProdCxaFracionada.GetValue<integer>('qtde');
            vData := jsonProdCxaFracionada.GetValue<String>('vencimento');
            vData := Copy(vData, 9, 2)+'/'+Copy(vData, 6, 2)+'/'+Copy(vData, 1, 4);
            FieldByName('Vencimento').AsDateTime     := StrToDate(vData);
            FieldByName('DtHrEntrada').AsDateTime    := StrToDateTime(jsonProdCxaFracionada.GetValue<string>('horario'));
            FieldByName('Ordem').AsInteger           := jsonProdCxaFracionada.GetValue<Integer>('ordem');
            FieldByName('Distribuicao').AsInteger    := jsonProdCxaFracionada.GetValue<Integer>('distribuicao');
            FieldByName('RuaId').AsInteger           := jsonProdCxaFracionada.GetValue<Integer>('ruaid');
            FieldByName('ZonaId').AsInteger          := jsonProdCxaFracionada.GetValue<Integer>('zonaid');
         End;
       End;
       if (Not QryEstoqueDisponivel_CaixaFracionada.IsEmpty) then Begin
          vProdutoId       := 0;
          vRuaId           := 0;
          vZonaId          := 0;
          vVolumeOpen      := True;
          vVolumeOpen      := False;
          vNumVolume       := 0;
          vSaldoCaixaVolume := vCaixaVolume; //44064
          vSaldoCaixapeso   := vCaixaCapacidade;  //25000
          QryEstoqueDisponivel_CaixaFracionada.First;
          //Gerara Volume Individual para produtos com Cubagem Maior que Caixa
          ArrayJsonVolumes := tJsonArray.Create;
          With QryEstoqueDisponivel_CaixaFracionada do While Not Eof do Begin
      //1 - Cubagem por Produto
//            if (DebugHook<>0) and (FieldByName('ProdutoId').AsInteger = 2676) then
//               showMessage('Acompanhar');
            if vProdutoId <> QryEstoqueDisponivel_CaixaFracionada.FieldByName('ProdutoId').AsInteger then Begin
               vProdutoId             := FieldByName('ProdutoId').AsInteger;
               vPesoProduto           := FieldByName('PesoLiquidoKg').AsFloat;
               if vPesoProduto <= 0 then vPesoProduto := 1;
               vVolumeProduto         := FieldByName('VolumeCm3').AsFloat;
               If vVolumeProduto <= 0 then vVolumeProduto := 512;
               vSaldoQtdSolicitada    := QryEstoqueDisponivel_CaixaFracionada.FieldByName('QtdSolicitada').AsInteger;//*FieldByName('EmbalagemPadrao').AsInteger;
            End;
            //Verificar se Cabe na Caixa
            if (vPesoProduto>vSaldoCaixaPeso) or (vVolumeProduto>vSaldoCaixaVolume) or
               (vZonaId <> FieldByName('ZonaId').Asinteger) or
               (vRuaid <> FieldByName('RuaId').Asinteger) or
               (Not vVolumeOpen) then Begin
               If vVolumeOpen then Begin//Finalizar Volume(json), adicionando ao ArrayVolumes
                  ArrayJsonVolumes.AddElement(jsonVolume);
                  vVolumeOpen := False;
               End;
               //NewVolume
               Inc(vNumVolume);
               JsonVolume := TJsonObject.Create;
               jsonVolume.AddPair('pedidoid', TJSONNumber.Create(pPedidoId));
               jsonVolume.AddPair('numvolume', TJSONNumber.Create(vnumvolume));
               jsonVolume.AddPair('embalagemid', TJSONNumber.Create(1));   //Pegar Dados da Caixa
               JsonVolume.AddPair('terminal', NomeDoComputador);
               JsonVolume.AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
               If FieldByName('Reprocessado').AsBoolean then
                  jsonVolume.AddPair('reprocessado', tjsonNumber.Create(1))
               Else jsonVolume.AddPair('reprocessado', tjsonNumber.Create(0));
               ArrayJsonVolumeLotes := tJsonArray.Create;
               vVolumeOpen          := True;
               vRuaId               := FieldByName('RuaId').Asinteger;
               vZonaId              := FieldByName('ZonaId').Asinteger;
               vSaldoCaixaVolume    := vCaixaVolume;
               vSaldocaixaPeso      := vCaixaCapacidade;
            End;
            vQtdProdKgToCaixa   := Trunc(vSaldoCaixaPeso   / vPesoProduto   ) * FieldByName('EmbalagemPadrao').AsInteger;
//            vQtdProdKgToCaixa   := Trunc(vSaldoCaixaPeso/(vPesoProduto/FieldByName('EmbalagemPadrao').AsInteger))
//                                         *FieldByName('EmbalagemPadrao').AsInteger;
            if vQtdProdKgToCaixa < 1 then
               vQtdProdKgToCaixa := FieldByName('EmbalagemPadrao').AsInteger;//Trunc(vPesoProduto);//*FieldByName('EmbalagemPadrao').AsInteger);
            //Qtde de Produtos que Cabem na Caixa
//            vQtdProdVlmToCaixa  := Trunc(vSaldoCaixaVolume / (vVolumeProduto / FieldByName('EmbalagemPadrao').AsInteger))*FieldByName('EmbalagemPadrao').AsInteger;
            vQtdProdVlmToCaixa  := Trunc(vSaldoCaixaVolume / vVolumeProduto) * FieldByName('EmbalagemPadrao').AsInteger;
            if vQtdProdVlmToCaixa < 1 then
               vQtdProdVlmToCaixa := FieldByName('EmbalagemPadrao').AsInteger;
            if (vQtdProdVlmToCaixa>FieldByName('EmbalagemPadrao').AsInteger) then
               vQtdProdVlmToCaixa := Trunc(vQtdProdVlmToCaixa / QryEstoqueDisponivel_CaixaFracionada.FieldByName('EmbalagemPadrao').AsInteger) *
                                     FieldByName('EmbalagemPadrao').AsInteger;

            //Desnecessário após implementar Procedimento para Produtos maior caixa
            if ((vPesoProduto)>vSaldoCaixaPeso) or  //((vPesoProduto*FieldByName('EmbalagemPadrao').AsInteger)>vSaldoCaixaPeso)
               ((vVolumeProduto) > vSaldoCaixaVolume) then Begin  //((vVolumeProduto*FieldByName('EmbalagemPadrao').AsInteger) > vSaldoCaixaVolume)
               vQtdProdKgToCaixa  := FieldByName('EmbalagemPadrao').AsInteger;
               vQtdProdVlmToCaixa := FieldByName('EmbalagemPadrao').AsInteger;
               vVolumeProduto := vSaldoCaixaVolume;
               vPesoProduto   := vSaldoCaixaPeso;
            End;

            if vQtdProdKgToCaixa < vQtdProdVlmToCaixa then Begin //Peso prevalece sobre volume
               if vQtdProdKgToCaixa > vSaldoQtdSolicitada then
                  vQtdProd := vSaldoQtdSolicitada
               Else
                  vQtdProd := vQtdProdKgToCaixa;
            End
            Else Begin
               if vQtdProdVlmToCaixa > vSaldoQtdSolicitada then
                  vQtdProd := vSaldoQtdSolicitada
               Else
                  vQtdProd := vQtdProdVlmToCaixa;
            End;
            while (QryEstoqueDisponivel_CaixaFracionada.FieldByName('ProdutoId').AsInteger = vProdutoId) and
                  (vQtdProd>0) and (Not QryEstoqueDisponivel_CaixaFracionada.Eof) do Begin
              if (vQtdProd >= QryEstoqueDisponivel_CaixaFracionada.FieldByName('EmbalagemPadrao').AsInteger) then Begin
                 if (QryEstoqueDisponivel_CaixaFracionada.FieldByName('Qtde').AsInteger < vQtdProd) then
  //                  vQtLoteVolume := ((QryEstoqueDisponivel_CaixaFracionada.FieldByName('Qtde').AsInteger Div
  //                                  QryEstoqueDisponivel_CaixaFracionada.FieldByName('EmbalagemPadrao').AsInteger)*
  //                                  QryEstoqueDisponivel_CaixaFracionada.FieldByName('EmbalagemPadrao').AsInteger)
                    vQtLoteVolume := ((QryEstoqueDisponivel_CaixaFracionada.FieldByName('Qtde').AsInteger Div
                                    QryEstoqueDisponivel_CaixaFracionada.FieldByName('EmbalagemPadrao').AsInteger)*
                                    QryEstoqueDisponivel_CaixaFracionada.FieldByName('EmbalagemPadrao').AsInteger)

                 Else vQtLoteVolume := vQtdProd;
                 if vQtLoteVolume > 0 then Begin
                    vQtdProd      := vQtdProd - vQtLoteVolume;
                    jsonVolumeLote := tJsonObject.Create;
                    JsonVolumeLote.AddPair('loteid', TJSONNumber.Create(FieldByName('LoteId').AsInteger));
                    JsonVolumeLote.AddPair('enderecoid', TJSONNumber.Create(FieldByName('EnderecoId').AsInteger));
                    JsonVolumeLote.AddPair('estoquetipoid', TJSONNumber.Create(FieldByName('EstoqueTipoId').AsInteger));
                    JsonVolumeLote.AddPair('enderecoorigem', TJSONNumber.Create(FieldByName('EnderecoOrigem').AsInteger));
                    JsonVolumeLote.AddPair('quantidade', TJSONNumber.Create(vQtLoteVolume));
                    JsonVolumeLote.AddPair('embalagempadrao', TJSONNumber.Create(FieldByName('EmbalagemPadrao').AsInteger));
                    JsonVolumeLote.AddPair('qtdsuprida', TJSONNumber.Create(vQtLoteVolume));
                    ArrayJsonVolumeLotes.AddElement(jsonVolumeLote);
                    //EnderecoId	EstoqueTipoId	Quantidade	EmbalagemPadrao	QtdSuprida	DtInclusao	HrInclusao	Terminal	UsuarioId

                    vSaldoQtdSolicitada := vSaldoQtdSolicitada - vQtLoteVolume;
                 End;
                 Edit;
                 if vQtLoteVolume = 0 then
                    FieldByName('Qtde').AsInteger := 0
                 Else FieldByName('Qtde').AsInteger := FieldByName('Qtde').AsInteger - vQtLoteVolume;
                 vSaldoCaixaPeso   := vSaldoCaixaPeso   - (vQtLoteVolume * (vPesoProduto/FieldByName('EmbalagemPadrao').AsInteger));
                 vSaldoCaixaVolume := vSaldoCaixaVolume - (vQtLoteVolume * (vVolumeProduto/FieldByName('EmbalagemPadrao').AsInteger));
              End;
              jsonVolume.AddPair('lotes', ArrayJsonVolumeLotes);
              //Na Linha Abaixo vQtdProd está errado      //vQtdProd
              if (FieldByName('Qtde').AsInteger = 0) or ((vSaldoQtdSolicitada < FieldByName('EmbalagemPadrao').AsInteger)) then
                 Next; //Próximo Lote para Atender
            End;
            While (FieldByName('ProdutoId').AsInteger = vProdutoId) and (vSaldoQtdSolicitada = 0) and (Not Eof) do  //Solicação Atendida, pulara para proximo Produto
              Next;
          End;
          If vVolumeOpen then Begin//Finalizar Volume(json), adicionando ao ArrayVolumes
             ArrayJsonVolumes.AddElement(jsonVolume);
             vVolumeOpen := False;
          End;

          if ArrayJsonVolumes.Count >= 1 then Begin
             //Clipboard.AsText := ArrayJsonVolumes.ToString();
             ArrayJsonRetorno := ObjPedidoFracCtrl.GerarVolume(ArrayJsonVolumes, 'FR');
             if ArrayJsonRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
                Player('toast4');
                PnlDetalhe.Caption := '😢Erro: '+vErro;
                ShowErro(vErro);
             end
             Else
                Result := False;
             ArrayJsonRetorno := Nil;
             Try
               ArrayJsonVolumes := Nil;
             Except
             End;
          End;
       End;
    end;
    //ReturnJsonArrayFrac := Nil;
    //ObjPedidoFracCtrl.Free;
  Except On E:Exception do Begin
    ObjPedidoFracCtrl.Free;
    ReturnJsonArrayFrac := Nil;
    Pedido_CancelarCubagem(pPedidoId, 0);
    Confirmacao('Processamento', 'Erro no pedido('+pPedidoId.ToString+').', False);
    End;
  End;
end;

Function TFrmPedidoCubagem.Pedido_CancelarCubagem(pPedidoId: Integer; pShowErro : Integer) : Boolean;
Var ObjPedidoCtrl   : TPedidoSaidaCtrl;
    ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  Result := False;
  Try
    ObjPedidoCtrl   := TPedidoSaidaCtrl.Create;
    ReturnJsonArray := ObjPedidoCtrl.Pedido_CancelarCubagem(pPedidoId);
    if ReturnJsonArray.Items[0].GetValue<TJsonObject>.TryGetValue('Erro', vErro) then Begin
       Player('toast4');
       ShowErro('😢Erro: '+vErro);
       Result := False;
    end
    Else Begin
      If pShowErro = 1 then Begin
         Player('concluido');
         ShowOk('Cancelamento de processamento de pedido(s) concluído com sucesso!');
      End;
      Result := True;
    end;
    ObjPedidoCtrl.Free;
    ReturnJsonArray := Nil;
  Except On E: Exception do Begin
    Player('concluido');
    ShowErro('Cancelamento de procesamento de pedido(s) concluído com sucesso!');
    Result := False;
    ObjPedidoCtrl.Free;
    ReturnJsonArray := Nil;
    End;
  End;
end;

procedure TFrmPedidoCubagem.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;

end;

function TFrmPedidoCubagem.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then Result := GetListaPedido(StrToIntDef(EdtConteudoPesq.Text, 0))
     Else if CbCampoPesq.ItemIndex = 1 then Result := GetListaPedido(0, 0, 0, EdtConteudoPesq.Text)
     Else if CbCampoPesq.ItemIndex = 2 then Result := GetListaPedido(0, 0, 0, '', EdtConteudoPesq.Text)
     Else if CbCampoPesq.ItemIndex = 3 then Result := GetListaPedido(0, 0, 0, '', '',EdtConteudoPesq.Text)
     Else if CbCampoPesq.ItemIndex = 4 then Begin
       Try StrToDate(EdtConteudoPesq.Text) Except raise Exception.Create('Data inválida para pesquisa.'); End;
       Result := GetListaPedido(0, 0, 0, '', '', '', 0, 0, StrToDate(EdtConteudoPesq.Text))
     end
     Else if CbCampoPesq.ItemIndex = 5 then Result := GetListaPedido(0, 0, StrToIntDef(EdtConteudoPesq.Text, 0));
     if Result = False then
        raise Exception.Create('Não econtrei dados da pesquisa!');
     EdtConteudoPesq.Clear;
  End;
{ID
Documento Nr
Razão
Registro ERP
Data Pedido
Cliente/Loja
}
end;

procedure TFrmPedidoCubagem.PgcBaseDrawTab(AControl: TcxCustomTabControl;
  ATab: TcxTab; var DefaultDraw: Boolean);
begin
  inherited;
  //https://www.devmedia.com.br/mudar-a-cor-apenas-das-abas-dos-tabsheets/20386
end;

procedure TFrmPedidoCubagem.BtnProdutoSemPickingClick(Sender: TObject);
Var JsonArrayProduto    : TJsonArray;
    ObjPedidoCtrl       : TPedidoSaidaCtrl;
    vDtInicio, vDtFinal : TDateTime;
    vErro : String;
begin
  inherited;
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  Try
    If EdtInicio.Text = '  /  /    ' then
       vDtInicio := 0
    Else vDtInicio := StrToDate(EdtInicio.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtTermino.Text = '  /  /    ' then
       vDtFinal := 0
    Else vDtFinal := StrToDate(EdtTermino.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final inválida!'+#13+#10+E.Message);
  End;
  if (vDtInicio <> 0) and (vDtFinal<>0) then Begin
     Try
       if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then
          raise Exception.Create('Período de Data Inválido!');
     Except ON E: Exception do
        raise Exception.Create('Erro: '+E.Message);
     End;
  End;
  ObjPedidoCtrl    := TPedidoSaidaCtrl.Create;
  JsonArrayProduto := ObjPedidoCtrl.PedidoProdutoSemPicking(StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtDestinatario.Text, 0), 0, vDtInicio, vDtFInal,
                                                   '', '', '', StrToIntDef(EdtRota.Text, 0), 0, 1, 1, 1, True, True);
  if JsonArrayProduto.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro( '😢Erro: '+vErro);
  End;
  With TFrmRelProdutoSemPicking.Create(Self) do
    Try
       If FdMemPesqGeral.Active then
          FdmemPesqGeral.EmptyDataSet;
       FdMemPesqGeral.Close;
       FdMemPesqGeral.LoadFromJSON(JsonArrayProduto, False);
       BtnImprimirStand.Grayed := False;
       BtnImprimirStandClick(BtnImprimirStand);
    Finally
      Free;
    end;
  ObjPedidoCtrl.Free;
  JsonArrayProduto := Nil;
end;

procedure TFrmPedidoCubagem.PrintMapaSeparacao;
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    xVol : Integer;
    ReturnJsonArray : tjsonArray;
    xPedido         : Integer;
    pNotificationPrint : Boolean;
    vcodPessoa : Integer;
    vErro      : String;
begin
  pNotificationPrint := True;
  for xPedido := 1 to Pred(LstPedidosAdv.RowCount) do Begin
    LstPedidosAdv.Row := xPedido;
    if LstPedidosAdv.Cells[9, xPedido] = '1' then Begin
       ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
       ReturnJsonArray     := ObjPedidoVolumeCtrl.MapaSeparacao(LstPedidosAdv.Cells[0, xPedido].ToInteger(), 0);
       //Testar retorno de erro
       QryMapaSeparacao.Close;
       QryMapaSeparacao.CreateDataSet;
       QryMapaSeparacao.Open;
       if (ReturnJsonArray.Count > 0) and (Not ReturnJsonArray.Items[0].TryGetValue<String>('Erro', vErro)) then Begin
          For xVol := 0 to Pred(ReturnJsonArray.Count) do Begin
            If pNotificationPrint then Begin
               Confirmacao('Mapa Separação', 'Prepare a impressora.', False);
               pNotificationPrint := False;
            End;
            With QryMapaSeparacao do Begin
              Append;
              FieldByName('PedidoId').AsInteger        := ReturnJsonArray.Items[xVol].GetValue<Integer>('pedidoid');
              FieldByName('Data').AsDateTime           := StrToDate(ReturnJsonArray.Items[xVol].GetValue<String>('data'));
              FieldByName('PedidoVolumeId').AsInteger  := ReturnJsonArray.Items[xVol].GetValue<Integer>('pedidovolumeid');
              FieldByName('Sequencia').AsInteger       := ReturnJsonArray.Items[xVol].GetValue<Integer>('sequencia');
              FieldByName('PessoaId').AsInteger        := ReturnJsonArray.Items[xVol].GetValue<Integer>('pessoaid');
              FieldByName('CodPessoaERP').AsInteger    := ReturnJsonArray.Items[xVol].GetValue<Integer>('codpessoaerp');
              FieldByName('Razao').AsString            := ReturnJsonArray.Items[xVol].GetValue<String>('razao');
              FieldByName('RotaId').AsInteger          := ReturnJsonArray.Items[xVol].GetValue<Integer>('rotaid');
              FieldByName('RotaDescricao').AsString    := ReturnJsonArray.Items[xVol].GetValue<String>('rotadescricao');
              FieldByName('Endereco').AsString         := EnderecoMask(ReturnJsonArray.Items[xVol].GetValue<String>('endereco'), ReturnJsonArray.Items[xVol].GetValue<String>('mascara'), True);
              //FieldByName('Endereco').AsString         := ReturnJsonArray.Items[xVol](xVol).GetValue<String>('endereco');
              FieldByName('Rua').AsString              := ReturnJsonArray.Items[xVol].GetValue<String>('rua');
              FieldByName('Zona').AsString             := ReturnJsonArray.Items[xVol].GetValue<String>('zona');
              FieldByName('DescrLote').AsString        := ReturnJsonArray.Items[xVol].GetValue<String>('descrlote');
              FieldByName('Vencimento').AsDatetime     := StrToDate(ReturnJsonArray.Items[xVol].GetValue<String>('vencimento'));
              FieldByName('Produtoid').AsInteger       := ReturnJsonArray.Items[xVol].GetValue<Integer>('produtoid');
              FieldByName('CodProduto').AsInteger       := ReturnJsonArray.Items[xVol].GetValue<Integer>('codproduto');
              FieldByName('ProdutoDescricao').AsString := ReturnJsonArray.Items[xVol].GetValue<String>('produtodescricao');
              FieldByName('Ean').AsString              := ReturnJsonArray.Items[xVol].GetValue<String>('ean');
              FieldByName('Quantidade').AsInteger      := ReturnJsonArray.Items[xVol].GetValue<Integer>('quantidade');
              if ReturnJsonArray.Items[xVol].GetValue<String>('unidade') = 'Un' then
                 FieldByName('Unidade').AsString       := ReturnJsonArray.Items[xVol].GetValue<String>('unidade')
              Else FieldByName('Unidade').AsString     := 'Cx('+trim(FormatFloat('####', ReturnJsonArray.Items[xVol].GetValue<Integer>('quantidade') /
                                                                                    ReturnJsonArray.Items[xVol].GetValue<Integer>('embalagempadrao') ))  +')';
              FieldByName('embalagempadrao').AsInteger := ReturnJsonArray.Items[xVol].GetValue<Integer>('embalagempadrao');
              FieldByName('VolumeTipo').AsString       := ReturnJsonArray.Items[xVol].GetValue<String>('volumetipo');
              vcodPessoa := QryMapaSeparacao.FieldByName('CodPessoaERP').AsInteger;
              Next;
            End;
          End;
          QryMapaSeparacao.First;
          With FrxReport1 do Begin
            Variables['vModulo']  := QuotedStr(pChar(Application.Title));
            Variables['vVersao']  := QuotedStr(Versao);
            Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
          End;
    //Apenas Exportar
          if ChkImprimirPDF.Checked then Begin
             frxPDFExport1.DefaultPath  := ExtractFilePath(Application.ExeName)+'\Relatorio\';
             frxPDFExport1.FileName := 'MapaSeparacao_Pedido_'+LstPedidosAdv.Cells[0, xPedido]+'.pdf';
             frxPDFExport1.ShowDialog := False;
             frxPDFExport1.ShowProgress := False;
             frxPDFExport1.OverwritePrompt := False;
             frxReport1.Export(frxPDFExport1);
             frxPDFExport1.ShowDialog := False;
          End
          Else Begin
             frxReport1.PrepareReport();
             frxReport1.PrintOptions.ShowDialog := False;
             FrxReport1.Print;
          End;
          //ReturnJsonArray := Nil;
          //ObjPedidoVolumeCtrl := Nil;
       End;
       ReturnJsonArray := Nil;
       ObjPedidoVolumeCtrl.Free;
    End;
  End;
  //Substituído pelas linhas Acima
//  ReturnJsonArray.Free;
//  ObjPedidoVolumeCtrl.Free;
end;

function TFrmPedidoCubagem.SalvarReg: Boolean;
begin
{
   With ObjPedidoSaidaCtrl.Entrada do begin
     PedidoId        := StrToInt(EdtPedidoId.Text);
     OperacaoTipo.OperacaoTipoId  := CbOperacaoTipo.ItemIndex;
     DocumentoNr     := EdtDocumentoNr.Text;
     DocumentoData   := StrToDate(EdtDocumentoData.Text);
     Pessoa.PessoaId := StrToIntDef(EdtPessoaId.Text, 0);
   end;
   Result := ObjEntradaCtrl.Salvar;
   if Result then ObjEntradaCtrl.Entrada.EntradaId := 0;
}
end;

procedure TFrmPedidoCubagem.ShowDados;
begin
  inherited;
{
   With ObjPedidoSaidaCtrl.Entrada do Begin
     EdtEntradaId.Text        := EntradaId.ToString();
     CbOperacaoTipo.ItemIndex := CbOperacaoTipo.Items.IndexOf(OperacaoTipo.Descricao);
     EdtDocumentoNr.Text      := DocumentoNr;
     EdtDocumentoData.Text    := DateToStr(DocumentoData);
     EdtPessoaId.Text         := Pessoa.PessoaId.ToString();
     LblFornecedor.Caption    := Pessoa.Razao;
     LblResRecebido.Caption   := DateToStr(DtInclusao);
   End;
   //Buscar Itens da Entrada para o Grid de Lotes
   GetListaPedidoProdutos;
}
end;

procedure TFrmPedidoCubagem.SpbBtnExcluirPedidoClick(Sender: TObject);
begin
  inherited;
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produção - Excluir Pedidos') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  ExcluirPedidos;
end;

procedure TFrmPedidoCubagem.TabExcuirPedidoShow(Sender: TObject);
begin
  inherited;
  EdtPedidoIdExcluir.ReadOnly     := False;
  EdtDtInicioExcluir.ReadOnly     := False;
  EdtDtTerminoExcluir.ReadOnly    := False;
  EdtRotaInicialExcluir.ReadOnly  := False;
  EdtRotaFinalExcluir.ReadOnly    := False;
  EdtDestinatarioExcluir.ReadOnly := False;
  ChkProcRecebidoExcluir.Enabled  := True;
  ChkProcCubagemExcluir.Enabled   := True;
  ChkProcEtiquetaExcluir.Enabled  := True;
  ChkProcRecebidoExcluir.Checked  := True;
  ChkProcCubagemExcluir.Checked   := False;
  ChkProcEtiquetaExcluir.Checked  := False;
  EdtDtInicioExcluir.SetFocus;
end;

procedure TFrmPedidoCubagem.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  EdtPedidoId.ReadOnly     := False;
  EdtInicio.ReadOnly       := False;
  EdtTermino.ReadOnly      := False;
  EdtRota.ReadOnly         := False;
  EdtRotaIdFinal.ReadOnly  := False;
  EdtDestinatario.ReadOnly := False;
  ChkProcRecebido.Enabled  := True;
  ChkProcCubagem.Enabled   := True;
  ChkProcEtiqueta.Enabled  := True;
  ChkProcRecebido.Checked  := True;
  ChkProcCubagem.Checked   := False;
  ChkProcEtiqueta.Checked  := False;
  EdtInicio.SetFocus;
end;

procedure TFrmPedidoCubagem.TmProcessandoTimer(Sender: TObject);
begin
  inherited;
  //PnlProcessando.Visible := Not PnlProcessando.Visible;
  PnlDetalhe.Caption := '🕒Aguarde, Processamento dos Pedidos';
  PnlDetalhe.Caption := '';
end;

end.