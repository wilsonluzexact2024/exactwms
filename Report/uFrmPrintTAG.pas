unit uFrmPrintTAG;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls, System.Threading,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, Generics.Collections,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.DialogMessage,
  Vcl.Buttons, Vcl.Samples.Spin, Vcl.Mask, JvExMask, JvToolEdit, System.Json, Rest.Types,
  ACBrBase, ACBrETQ, ACBrDevice, PedidoSaidaCtrl, PedidoVolumeCtrl, JvSpin,
  dxSkinsCore, dxSkinsDefaultPainters, Vcl.ComCtrls, Vcl.DBGrids, IniFiles,
  DataSet.Serialize, dxCameraControl, JvBaseEdits;

type
  TFrmPrintTag = class(TFrmBase)
    GroupBox1: TGroupBox;
    BtnTagProduto: TPanel;
    sImage1: TsImage;
    BtnTagLocalizacao: TPanel;
    sImage2: TsImage;
    BtnTagVolume: TPanel;
    sImage3: TsImage;
    BtnTagCaixa: TPanel;
    sImage4: TsImage;
    PgcTabTags: TcxPageControl;
    TbTagProduto: TcxTabSheet;
    AdvGridLookupBar2: TAdvGridLookupBar;
    TbTagLocalizacao: TcxTabSheet;
    TbTagVolume: TcxTabSheet;
    TbTagCaixa: TcxTabSheet;
    Label2: TLabel;
    CbEstrutura: TComboBox;
    Label4: TLabel;
    CbComposicao: TComboBox;
    CbFormato: TComboBox;
    Label5: TLabel;
    Label3: TLabel;
    SpCopias: TSpinEdit;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    EdtEnderecoIni: TJvComboEdit;
    BtnSearchLocalIni: TBitBtn;
    EdtEnderecoFin: TJvComboEdit;
    BtnSearchLocalFin: TBitBtn;
    LblMensInformacao: TLabel;
    Label8: TLabel;
    LblZona: TLabel;
    BtnPesqZona: TBitBtn;
    EdtZona: TJvComboEdit;
    ACBrETQOLD: TACBrETQ;
    LstEnderecoAdv: TAdvStringGrid;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    EdtPedidoId: TEdit;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRota: TEdit;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    GroupBox3: TGroupBox;
    Label10: TLabel;
    EdtPedidoVolumeId: TEdit;
    RgEmbalagemTipo: TRadioGroup;
    Memo1: TMemo;
    ChkEtqBcoEndereco: TCheckBox;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    EdtDtInicial: TJvDateEdit;
    EdtDtFinal: TJvDateEdit;
    Label14: TLabel;
    BtnTagProdControlado: TPanel;
    sImage5: TsImage;
    Label15: TLabel;
    EdtRuaId: TJvComboEdit;
    BtnPesqRua: TBitBtn;
    LblRua: TLabel;
    Label16: TLabel;
    LblTotalEtiq: TLabel;
    Panel1: TPanel;
    LstPedidosAdv: TAdvStringGrid;
    RbProcesso: TRadioGroup;
    LstVolumesFilterAdv: TAdvStringGrid;
    FDMemEtiquetaVolumePorRua: TFDMemTable;
    TbTagArmazenagem: TcxTabSheet;
    LblTotRegCaption: TLabel;
    LblTotRegEtqArmazenagem: TLabel;
    LstTagArmazenagem: TAdvStringGrid;
    BtnTagArmazenagem: TPanel;
    ImgTagArmazenagem: TsImage;
    FDMemTagArmazenagem: TFDMemTable;
    PnlEtqArmazenagemEntrada: TPanel;
    GbPeriodo: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    EdtDtInicio: TJvDateEdit;
    EdtDtTermino: TJvDateEdit;
    GbPedido: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    EdtPedidoIdTag: TEdit;
    EdtDocumentoNr: TEdit;
    GbZona: TGroupBox;
    Label19: TLabel;
    LblZonaTagArmazenagem: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZonaTabArm: TBitBtn;
    GbProduto: TGroupBox;
    Label23: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    PnlSelectionTypeEtq: TPanel;
    RbRecebimento: TRadioButton;
    RbIndividual: TRadioButton;
    PnlEtqArmazenagemIndividual: TPanel;
    GroupBox11: TGroupBox;
    Label30: TLabel;
    LblProdutoEtqIndividual: TLabel;
    EdtCodProdutoEtqIndividual: TEdit;
    BtnPesqProdutoEtqIndividual: TBitBtn;
    Label24: TLabel;
    EdtPickingProdutoEtqIndividual: TEdit;
    RgPrinterEtqIndividual: TRadioGroup;
    DbgLotesEtqIndividual: TDBGrid;
    EdtQtdEtiquetaIndividual: TJvCalcEdit;
    Label25: TLabel;
    EdtQuantidadeEstIndividual: TJvCalcEdit;
    LblEstoqueLote: TLabel;
    FDMemProdutoLotesEtqArmazenagem: TFDMemTable;
    DsProdutoLotesEtqArmazenagem: TDataSource;
    FDMemProdutoLotesEtqArmazenagemImpr: TIntegerField;
    FDMemProdutoLotesEtqArmazenagemDescrLote: TStringField;
    FDMemProdutoLotesEtqArmazenagemSaldo: TIntegerField;
    imgAtivo: TImageList;
    FDMemProdutoLotesEtqArmazenagemVencimento: TStringField;
    BtnEtqIndividualOld: TsImage;
    FDMemProdutoLotesEtqArmazenagemLoteid: TIntegerField;
    FDMemProdutoLotesEtqArmazenagemFabricacao: TStringField;
    FDMemProdutoLotesEtqArmazenagemFatorConversao: TIntegerField;
    DsEtiquetaPorRua: TDataSource;
    Label27: TLabel;
    EdtRotaFinal: TEdit;
    LblRotaFinal: TLabel;
    BtnPesqRotaInicial: TBitBtn;
    BtnPesqRotaFinal: TBitBtn;
    GroupBox8: TGroupBox;
    LblZonaVolume: TLabel;
    Label29: TLabel;
    EdtZonaIdVolume: TEdit;
    BtnPesqSetorVolume: TBitBtn;
    LblEtiquetas: TLabel;
    LblTotEtiquetasVolume: TLabel;
    LblCountPrint: TLabel;
    BtnEtqIndividual: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnTagProdutoClick(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtZonaExit(Sender: TObject);
    procedure EdtZonaChange(Sender: TObject);
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure LstEnderecoAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormShow(Sender: TObject);
    procedure EdtEnderecoIniChange(Sender: TObject);
    procedure EdtDestinatarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDestinatarioChange(Sender: TObject);
    procedure EdtPedidoVolumeIdChange(Sender: TObject);
    procedure LstPedidosAdvClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtRotaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPedidoVolumeIdExit(Sender: TObject);
    procedure EdtPedidoIdExit(Sender: TObject);
    procedure EdtPedidoVolumeIdKeyPress(Sender: TObject; var Key: Char);
    procedure BtnTagProdControladoClick(Sender: TObject);
    procedure EdtRuaIdChange(Sender: TObject);
    procedure EdtRuaIdExit(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure BtnPesqRuaClick(Sender: TObject);
    procedure RbProcessoClick(Sender: TObject);
    procedure LstVolumesFilterAdvClickCell(Sender: TObject; ARow,
      ACol: Integer);
    procedure EdtDtInicioChange(Sender: TObject);
    procedure TbTagArmazenagemShow(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure BtnPesqZonaTabArmClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure LstTagArmazenagemClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure RbRecebimentoClick(Sender: TObject);
    procedure EdtCodProdutoEtqIndividualExit(Sender: TObject);
    procedure EdtCodProdutoEtqIndividualChange(Sender: TObject);
    procedure DbgLotesEtqIndividualDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure DbgLotesEtqIndividualCellClick(Column: TColumn);
    procedure EdtRotaExit(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure BtnPesqRotaInicialClick(Sender: TObject);
    procedure RgPrinterEtqIndividualClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtDtInicialChange(Sender: TObject);
    procedure DbgLotesEtqIndividualTitleClick(Column: TColumn);
    procedure BtnSearchLocalIniClick(Sender: TObject);
    procedure EdtEnderecoIniExit(Sender: TObject);
    procedure EdtQuantidadeEstIndividualKeyPress(Sender: TObject;
      var Key: Char);
    procedure EdtQtdEtiquetaIndividualKeyPress(Sender: TObject; var Key: Char);
    procedure BtnEtqIndividualClick(Sender: TObject);
  private
    { Private declarations }
    ObjPedidoCtrl      : TPedidoSaidaCtrl;
    SelEnd : Boolean;
    JsonPedidoCubagem : tjsonArray;
    vPessoaId : Integer;
    SelPedido, SelPedEtq : Boolean;
    vSelectLoteTag       : Boolean;
    vTimeEtiqueta        : Integer;
    vTemperatura         : Integer;
    Procedure TbTagON(Page : TcxTabSheet);
    Procedure TbTagOFF;
    Procedure GetEstrutura;
    procedure ConfigACBrETQ;
    Procedure PesquisarVolumes;
    Procedure MontaListaPedido(pFiltro : Boolean = False);
    Procedure ImprimirVolumes;
    Procedure GetVolumeParaEtiquetas(pPedidoid : Integer);
    Procedure PrintEtiquetaPorRua(TagVolumeOrdem : Integer);
    Procedure LimparLstAdvReport;
    Procedure PesqDados_EtqArmazenamgem;
    Procedure MontaListaEtqArmazenagem;
    Procedure PrintTagArmazenagem;
    procedure PrintTagArmazenagem8x10etqEpl2(pJsonArray: TJsonArray);
    Procedure ClearLstVolumes;
    Procedure TagEndereco3x10etqEpl2;
    Procedure TagEndereco5x10etqEpl2;
    Procedure TagEndereco8x10etqEpl2;
    Procedure TagEndereco8x10etqEpl2_Localizacao_CodBarras_Lateral;
  public
    { Public declarations }
    Procedure Imprimir; OverRide;
    Procedure TagVolumeFracionado8x10etqEpl2(pPedidoId, pPedidoVolumeId, pSequencia, pCodPessoaERP, pOrdem, vItens, vTotUnid : Integer;
                                             prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal : String;
                                             pProcessoId, pRotaId, pTotalVolumes : Integer);

    Procedure TagVolumeCaixaFechada8x10etqEpl2(pPedidoVolumeId : Integer);  //Etiqueta Individual ????
    Procedure TagVolumeCaixaFechada_Address_8x10etqEpl2(pPedidoVolumeId : Integer);
    Procedure PrintTagVolumeCxaFechada8x10etqEpl2; //Etiquetas Volumes Por Rua
    Procedure TagVolumeCaixaFechada_RotaClienteDestaque_8x10etqEpl2(pPedidoVolumeId : Integer);     //Modelo 02
  end;

var
  FrmPrintTag: TFrmPrintTag;

implementation

{$R *.dfm}

uses EnderecamentoZonaClass, EnderecamentoZonaCtrl, EnderecoEstruturaClass, EnderecamentoEstruturaCtrl,
     EnderecoClass, EnderecoCtrl, uFuncoes, TypInfo, uFrmeXactWMS, PessoaCtrl, ACBrETQClass,
     RotaCtrl, uFrmRelTagProduto, EnderecamentoRuaCtrl, EnderecamentoRuaClass,
     Views.Pequisa.Endereco, Views.Pequisa.EnderecamentoZonas, Views.Pequisa.EnderecamentoRuas, ProdutoCtrl,
     Views.Pequisa.Produtos, EntradaCtrl, EstoqueCtrl, Views.Pequisa.Rotas;

Procedure TFrmPrintTag.PrintTagArmazenagem8x10etqEpl2(pJsonArray : TJsonArray);
Var xJsonEtq, xEtq, EtqCxaFechada : Integer;
    vTipoEtiqueta : String;
  Procedure PrintEtq(JsonEtq : TJsonObject; pQuant : Integer);
  Var Lin, EtqPrint : Integer;
      vEndereco     : String;
  Begin
    Try
      ACBrETQConfig.DPI           := TACBrETQDPI(0);
      ACBrETQConfig.Temperatura   := vTemperatura;
      With ACBrETQConfig do Begin
        Ativar;
        IniciarEtiqueta;
        Lin := 1;
//PedidoId	DocumentoNr	Data	CodPessoaERP	Razao	Fantasia	QtdItens	(Nenhum nome de coluna)
//          ImprimirCaixa(LinIni, ColIni, Largura(col), Altura(Lin), Espessura 1, Espessura 1);
        ImprimirCaixa(Lin,  5, 50, 14, 0, 0);
        ImprimirCaixa(Lin, 55, 45, 14, 0, 0);
        ImprimirTexto(orNormal, 3, 1, 1, Lin+2,  7, JsonEtq.GetValue<String>('zona'), 0, True);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+6,  7, 'Impressão:', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+9, 18, DateToStr(Date()), 0, False);
        ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+2, 60, JsonEtq.GetValue<String>('codproduto'), 8, becSIM);
//Produto
        ImprimirCaixa(Lin+15, 5, 95, 12, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+16, 7, 'Produto', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+19, 7, Copy(JsonEtq.GetValue<String>('descricao'), 1, 60), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+23, 7, COpy(JsonEtq.GetValue<String>('descricao'), 61, 40), 0, False);
//Lote
        ImprimirCaixa(Lin+28, 5, 95, 9, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29,  7, 'Lote', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 37, 'Fabricação', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 57, 'Vencimento', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 80, 'Quantidade', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+32,  7, JsonEtq.GetValue<String>('descrlote'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+32, 37, JsonEtq.GetValue<String>('fabricacao'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+32, 57, JsonEtq.GetValue<String>('vencimento'), 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+32, 74, Repl(' ',6-Length(pQuant.ToString))+pQuant.ToString, 0, False);

//Fornecedor - Pedido
        if RbRecebimento.Checked then Begin
           ImprimirCaixa(Lin+39, 5, 95, 17, 0, 0);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+40,  7, 'Documento', 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+40, 45, 'Data', 0, False);
           ImprimirTexto(orNormal, 2, 1, 2, Lin+43,  7, JsonEtq.GetValue<String>('documentonr'), 0, False);
           ImprimirTexto(orNormal, 2, 1, 2, Lin+43, 45, JsonEtq.GetValue<String>('data'), 0, False);

           ImprimirTexto(orNormal, 2, 1, 1, Lin+48, 7, 'Fornecedor', 0, False);
           ImprimirTexto(orNormal, 2, 1, 2, Lin+51, 7, Copy(JsonEtq.GetValue<String>('fantasia'), 1, 60), 0, False);

           ImprimirTexto(orNormal, 2, 1, 1, Lin+57, 7, 'Picking', 0, False);
           ImprimirTexto(orNormal, 4, 3, 4, Lin+60, 7, EnderecoMask(JsonEtq.GetValue<String>('endereco'), JsonEtq.GetValue<String>('mascara'), True), 0, False);
        End
        ELse
        Begin
           ImprimirTexto(orNormal, 3, 1, 1, Lin+40, 7, 'Picking', 0, False);
           //ImprimirTexto(orNormal, 5, 2, 4, Lin+47, 7, EnderecoMask(JsonEtq.GetValue<String>('endereco'), JsonEtq.GetValue<String>('mascara'), True), 0, False);
           vEndereco := EnderecoMask(JsonEtq.GetValue<String>('endereco'), JsonEtq.GetValue<String>('mascara'), True);
           ImprimirTexto(orNormal, 5, 2, 4, Lin+47,  7, Copy(vEndereco, 1, 2), 0, False);
           ImprimirTexto(orNormal, 4, 3, 2, Lin+47+19, 23, Copy(vEndereco, 3, 1), 0, False);

           ImprimirTexto(orNormal, 5, 2, 4, Lin+47, 29, Copy(vEndereco, 4, 2), 0, False);
           ImprimirTexto(orNormal, 4, 3, 2, Lin+47+19, 46, Copy(vEndereco, 6, 1), 0, False);

           ImprimirTexto(orNormal, 5, 2, 4, Lin+47, 49, Copy(vEndereco, 7, 2), 0, False);
           ImprimirTexto(orNormal, 4, 3, 2, Lin+47+19, 68, Copy(vEndereco, 9, 1), 0, False);

           ImprimirTexto(orNormal, 5, 2, 4, Lin+47, 72, Copy(vEndereco, 10, 3), 0, False);
        End;

        ImprimirTexto(orNormal, 2, 1, 1, 72, 82, 'eXactWMS®', 0, False);
//DESATIVAR PARA BRASIL
        if Pos('BRASIL', UpperCase(FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa)) <= 0 then Begin
           if (vTipoEtiqueta = 'F') Then // JsonEtq.GetValue<Integer>('tipoetiqueta') = 1 then
              ImprimirTexto(orNormal, 2, 2, 2, 73, 10, 'Fracionados', 0, False)
           Else
              ImprimirTexto(orNormal, 2, 2, 2, 73, 10, 'Cxa.Fechada', 0, False);
        End;
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
      End;
    Except On E: Exception do Begin
      ShowErro('Erro: Problema de comunicação com impressora...'+#13+E.Message);
      End;
    End;
  End;
Begin
  for xJsonEtq := 0 to Pred(pJsonArray.Count) do Begin
    //Caixa Fechada
    for EtqCxaFechada := 1 to pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdcxafechada') do Begin
      vTipoEtiqueta := 'C'; //Caixa Fechada
      PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('fatorconversao'));
    End;
    //Fracionados
    if pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada') > 0 then Begin
       vTipoEtiqueta := 'F'; //Caixa Fracionada
       for EtqCxaFechada := 1 to StrToIntDef(EdtQtdEtiquetaIndividual.Text, 1) do
         PrintEtq(pJsonArray.Items[xJsonEtq] as TJsonObject, pJsonArray.Items[xJsonEtq].GetValue<Integer>('qtdfracionada'));
    End;
  End;
End;


procedure TFrmPrintTag.BtnEtqIndividualClick(Sender: TObject);
Var xPed, Lin, EtqPrint : Integer;
    JsonEtqIndividual : TJsonObject;
    JsonArrayEtqIndividual : TJsonArray;
    Start : Boolean;
    vErro : String;
begin
  if RgPrinterEtqIndividual.ItemIndex < 0 then Begin
     ShowErro('Selecione o tipo de Etiqueta para impressão!');
     RgPrinterEtqIndividual.SetFocus;
     Exit;
  End;
  if EdtQtdEtiquetaIndividual.Value < 0 then Begin
     ShowErro('Informe a quantidade de Etiqueta para impressão!');
     EdtQtdEtiquetaIndividual.SetFocus;
     Exit;
  End;
  FDMemProdutoLotesEtqArmazenagem.Filter   := 'Impr = 1';
  FDMemProdutoLotesEtqArmazenagem.Filtered := True;
  if FDMemProdutoLotesEtqArmazenagem.IsEmpty then Begin
     ShowErro('Selecione o(s) lote(s) para impressão!');
     FDMemProdutoLotesEtqArmazenagem.Filter   := '';
     FDMemProdutoLotesEtqArmazenagem.Filtered := False;
     if RbIndividual.Checked then
        EdtCodProdutoEtqIndividual.SetFocus
     Else
        EdtPedidoIdTag.SetFocus;
     Exit;
  End;
  BtnEtqIndividual.Enabled := False;
  Start    := True;
  EtqPrint := 0;
  FDMemProdutoLotesEtqArmazenagem.First;
  While Not FDMemProdutoLotesEtqArmazenagem.Eof do Begin
    if FDMemProdutoLotesEtqArmazenagem.FieldByname('Impr').AsInteger = 1 then Begin
       JsonEtqIndividual      := TJsonObject.Create;
       JsonArrayEtqIndividual := TJsonArray.Create;
       JsonEtqIndividual.AddPair('pedidoid', TJsonNumber.Create(0));
       JsonEtqIndividual.AddPair('documentonr', '');
       JsonEtqIndividual.AddPair('data','');
       JsonEtqIndividual.AddPair('codpessoaerp', TJsonNumber.Create(0));
       JsonEtqIndividual.AddPair('razao', '');
       JsonEtqIndividual.AddPair('fantasia', '');
       JsonEtqIndividual.AddPair('pedidoid', TJsonNumber.Create(0));
       JsonEtqIndividual.AddPair('codproduto', TJsonNumber.Create(EdtCodProdutoEtqIndividual.Tag));
       JsonEtqIndividual.AddPair('descricao', LblProdutoEtqIndividual.Caption);
       JsonEtqIndividual.AddPair('fatorconversao', TJsonNumber.Create( FDMemProdutoLotesEtqArmazenagem.FieldByName('FatorConversao').AsInteger)); //Corrigir
       JsonEtqIndividual.AddPair('loteid', TJsonNumber.Create(0)); //Corrigir
       JsonEtqIndividual.AddPair('descrlote', FDMemProdutoLotesEtqArmazenagem.FieldByName('DescrLote').AsString);
       JsonEtqIndividual.AddPair('fabricacao', FDMemProdutoLotesEtqArmazenagem.FieldByName('Fabricacao').AsString);
       JsonEtqIndividual.AddPair('vencimento', FDMemProdutoLotesEtqArmazenagem.FieldByName('Vencimento').AsString);
       JsonEtqIndividual.AddPair('tipoetiqueta', TJsonNumber.Create(RgPrinterEtqIndividual.ItemIndex));
       if (RgPrinterEtqIndividual.ItemIndex = 1) then Begin
          If (EdtQuantidadeEstIndividual.Value > 0) then Begin
             JsonEtqIndividual.AddPair('quantidade', TJsonNumber.Create(EdtQuantidadeEstIndividual.Value));
             JsonEtqIndividual.AddPair('qtdfracionada', TJsonNumber.Create(EdtQuantidadeEstIndividual.Value)); //Corrigir
          End
          Else Begin
             JsonEtqIndividual.AddPair('quantidade', TJsonNumber.Create(FDMemProdutoLotesEtqArmazenagem.FieldByName('Saldo').AsInteger));
             JsonEtqIndividual.AddPair('qtdfracionada', TJsonNumber.Create(FDMemProdutoLotesEtqArmazenagem.FieldByName('Saldo').AsInteger)); //Corrigir
          End;
          JsonEtqIndividual.AddPair('qtdcxafechada', TJsonNumber.Create(0)); //Corrigir
       End
       Else Begin
          If (EdtQtdEtiquetaIndividual.Value > 0) then Begin
             JsonEtqIndividual.AddPair('quantidade', TJsonNumber.Create(FDMemProdutoLotesEtqArmazenagem.FieldByName('FatorConversao').AsInteger*
                                                                        EdtQtdEtiquetaIndividual.Value));
             JsonEtqIndividual.AddPair('qtdcxafechada', TJsonNumber.Create( EdtQtdEtiquetaIndividual.value)); //Corrigir
          End
          else
          Begin
             JsonEtqIndividual.AddPair('quantidade', TJsonNumber.Create(trunc(FDMemProdutoLotesEtqArmazenagem.FieldByName('Saldo').AsInteger /
                                                                              FDMemProdutoLotesEtqArmazenagem.FieldByName('FatorConversao').AsInteger)*
                                                                              FDMemProdutoLotesEtqArmazenagem.FieldByName('FatorConversao').AsInteger));
             JsonEtqIndividual.AddPair('qtdcxafechada', TJsonNumber.Create( trunc(FDMemProdutoLotesEtqArmazenagem.FieldByName('Saldo').AsInteger / FDMemProdutoLotesEtqArmazenagem.FieldByName('FatorConversao').AsInteger) )); //Corrigir
          End;
          JsonEtqIndividual.AddPair('qtdfracionada', TJsonNumber.Create( 0 ))
       End;
       JsonEtqIndividual.AddPair('endereco', EdtPickingProdutoEtqIndividual.Text);
       JsonEtqIndividual.AddPair('zonaid', TJsonNumber.Create(1)); //Corrigir
       JsonEtqIndividual.AddPair('zona', '');
       JsonEtqIndividual.AddPair('mascara', '99.99.99.999');
       JsonArrayEtqIndividual.AddElement(JsonEtqIndividual);
       PrintTagArmazenagem8x10etqEpl2( JsonArrayEtqIndividual );
       Inc(EtqPrint);
{
        if EdtQuantidadeEstIndividual.Value > 0 then Begin
           for EtqPrint := 1 to StrToIntDef(EdtQtdEtiquetaIndividual.Text, 1) do
              PrintTagArmazenagem8x10etqEpl2( JsonArrayEtqIndividual );
        End
        Else
              PrintTagArmazenagem8x10etqEpl2( JsonArrayEtqIndividual );
}
       JsonArrayEtqIndividual.Free;
    End;
    FDMemProdutoLotesEtqArmazenagem.Next;
  End;
  FDMemProdutoLotesEtqArmazenagem.Filter   := '';
  FDMemProdutoLotesEtqArmazenagem.Filtered := False;
  if EtqPrint > 0 then
     ShowOk('Impressas '+EtqPrint.ToString+' etiquetas!')
  Else
     ShowErro('Não foi possível imprimir etiqueta(s).');
  if PnlEtqArmazenagemIndividual.Visible then Begin
     EdtCodProdutoEtqIndividual.Clear;
     EdtCodProdutoEtqIndividual.SetFocus;
  End
  Else Begin
  End;
  BtnEtqIndividual.Enabled := True;
end;

procedure TFrmPrintTag.BtnImprimirStandClick(Sender: TObject);
begin
//  ConfigACBrETQ;
  if PgcTabTags.ActivePage = TbTagVolume then Begin
     if LstPedidosAdv.RowCount <= 1 then
        ShowErro('Pesquise os pedidos disponível para impressão.')
     Else if RgEmbalagemTipo.ItemIndex < 0 then
        raise Exception.Create('Selectione o tipo de Etiquetas para Impressão.')
     Else If (RbProcesso.ItemIndex > 0) and (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relatórios - Re-Impressão de TAG')) then
        raise Exception.Create('Acesso não autorizado a esta Reimpressão/Todos.!')
     Else if (EdtPedidoVolumeId.Text<>'') and
             (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relatórios - Re-Impressão de TAG')) and
             (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relatórios - TAG Volumes somente individual')) then
        raise Exception.Create('Acesso não autorizado para impressão desta TAG!');
     ImprimirVolumes;
  End
  Else if PgcTabTags.ActivePage = TbTagArmazenagem then Begin
    If (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Relatórios - Impressão Tag Armazenagem')) then
       raise Exception.Create('Acesso não autorizado!')
    Else
      PrintTagArmazenagem;
  End
  Else If PgcTabTags.ActivePage = TbTagLocalizacao then Begin
     if LstEnderecoAdv.RowCount <= 1 then Begin
        ShowErro('Pesquise os endereços para impressão.');
        Exit;
     End;
     if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = '' then Begin
        ShowErro('Selecine uma Impressora de Etiquetas!');
        Exit;
     End;
     if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqEpl2' ) and (CbFormato.ItemIndex = 1) then
        TagEndereco3x10etqEpl2 //Criar demais modelos de Tag
     Else if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqEpl2' ) and (CbFormato.ItemIndex = 2) then
        TagEndereco5x10etqEpl2 //Criar demais modelos de Tag
     Else if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra = 'etqEpl2' ) and (CbFormato.ItemIndex = 3) then
        TagEndereco8x10etqEpl2 //Criar demais modelos de Tag
  End;
end;

procedure TFrmPrintTag.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if EdtCodProduto.ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       if Sender = EdtCodProduto then Begin
          EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
          EdtCodProdutoExit(EdtCodProduto);
       End
       Else Begin
          EdtCodProdutoEtqIndividual.Text := FrmPesquisaProduto.Tag.ToString();
          EdtCodProdutoEtqIndividualExit(EdtCodProdutoEtqIndividual);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmPrintTag.BtnPesqZonaTabArmClick(Sender: TObject);
begin
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

procedure TFrmPrintTag.BtnSearchLocalIniClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then Begin
       if Sender = BtnPesqZona then Begin
          EdtEnderecoIni.Text := FrmPesquisaEndereco.Tag.ToString;
          EdtEnderecoIniExit(EdtEnderecoIni);
       End
       Else Begin
          EdtEnderecoFin.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
          EdtEnderecoIniExit(EdtEnderecoFin);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmPrintTag.BtnPesqRotaInicialClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       if Sender = BtnPesqRotaInicial then Begin
          EdtRota.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaExit(EdtRota);
       End
       Else Begin
          EdtRotaFinal.Text := FrmPesquisaRotas.Tag.ToString();
          EdtRotaExit(EdtRotaFinal);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmPrintTag.BtnPesqRuaClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
begin
  inherited;
  if EdtRuaId.ReadOnly then Exit;
  FrmPesquisaEnderecamentoRuas := TFrmPesquisaEnderecamentoRuas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoRuas.ShowModal = mrOk) then Begin
       EdtRuaId.Text := FrmPesquisaEnderecamentoRuas.Tag.ToString;
       EdtRuaIdExit(EdtRuaId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoRuas);
  end;
end;

procedure TFrmPrintTag.BtnPesquisarStandClick(Sender: TObject);
Var //ArrayJsonEndereco : TJsonArray;
    LstEndereco       : TObjectList<TEndereco>;
    ObjEnderecoCtrl   : TEnderecoCtrl;
    vErro             : String;
    xRetorno          : Integer;
    vEstruturaId      : Integer;
begin
//  inherited;
  if PgcTabTags.ActivePage = TbTagVolume then Begin
     PesquisarVolumes;
     Exit;
  End
  Else if PgcTabTags.ActivePage = TbTagArmazenagem then Begin
     PesqDados_EtqArmazenamgem;
     Exit;
  End
  Else if PgcTabTags.ActivePage = TbTagLocalizacao then Begin
     LblTotalEtiq.Caption := '0';
     BtnImprimirStand.Enabled := False;
     BtnImprimirStand.Grayed  := True;
     if (EdtEnderecoIni.Text='') and (EdtEnderecoFin.Text='') and (CbEstrutura.Text='') and (EdtZona.Text='') and (EdtRuaId.Text='') then Begin
        ShowErro('🙋🏼‍♀ Informe o Tipo e/ou Faixa de Endereço para pesquisar.');
        EdtEnderecoIni.SetFocus;
        Exit;
     End;
     if CbComposicao.Text = '' then Begin
        ShowErro('🙋🏼‍♀ Informe a composição da TAG.');
        CbComposicao.SetFocus;
        Exit;
     End;
     if CbFormato.Text = '' then Begin
        ShowErro('🙋🏼‍♀ Informe o Formato/Tamanho da TAG.');
        CbFormato.SetFocus;
        Exit;
     End;
     If CbEstrutura.ItemIndex <= 0 then
        vEstruturaId := 0
     Else vEstruturaId := CbEstrutura.ItemIndex+1;
     vEstruturaId := CbEstrutura.ItemIndex;
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     LstEndereco     := ObjEnderecoCtrl.GetEndereco(0, vEstruturaId,
                        StrToIntDef(EdtZona.Text, 0), StrToIntDef(EdtRuaId.Text,0), EdtEnderecoIni.Text, EdtEnderecoFin.Text, 'T', 2, 0);
     if LstEndereco.Count <= 0 then // ArrayJsonEndereco.Get(0).tryGetValue<String>('Erro', vErro) then
        ShowErro('Não foram encontrado(s) dados!')
     Else Begin
        LblEtiquetas.Caption := 'Etiquetas: ';
        LblTotalEtiq.Caption := LstEndereco.Count.ToString();
        BtnImprimirStand.Enabled := True;
        BtnImprimirStand.Grayed  := False;
        LstEnderecoAdv.RowCount := LstEndereco.Count+1;
        LstEnderecoAdv.FixedRows := 1;
        For xRetorno := 1 to LstEnderecoAdv.RowCount - 1 do Begin
          LstEnderecoAdv.AddDataImage(7, xRetorno, 0, haCenter,vaTop);
          LstEnderecoAdv.AddDataImage(8, xRetorno, 0, haCenter,vaTop);
        End;
        for XRetorno := 0 to Pred(LstEndereco.Count) do Begin
          LstEnderecoAdv.Cells[0, xRetorno+1] :=  LstEndereco[xRetorno].EnderecoId.ToString;
          LstEnderecoAdv.Cells[1, xRetorno+1] :=  EnderecoMask(LstEndereco[xRetorno].Descricao, LstEndereco[xRetorno].EnderecoEstrutura.Mascara, True);
          LstEnderecoAdv.Cells[2, xRetorno+1] :=  LstEndereco[xRetorno].EnderecoEstrutura.Descricao;
          LstEnderecoAdv.Cells[3, xRetorno+1] :=  LstEndereco[xRetorno].EnderecoRua.Descricao;
          LstEnderecoAdv.Cells[4, xRetorno+1] :=  LstEndereco[xRetorno].EnderecoRua.Lado;
          LstEnderecoAdv.Cells[5, xRetorno+1] :=  LstEndereco[xRetorno].EnderecoEstrutura.PickingFixo.ToString();
          LstEnderecoAdv.Cells[6, xRetorno+1] :=  LstEndereco[xRetorno].EnderecamentoZona.Descricao;
          LstEnderecoAdv.Cells[7, xRetorno+1] :=  LstEndereco[xRetorno].Status.ToString();
          LstEnderecoAdv.Cells[8, xRetorno+1] :=  '1';
          LstEnderecoAdv.Cells[9, xRetorno+1] :=  LstEndereco[xRetorno].EnderecoEstrutura.Mascara;
          LstEnderecoAdv.Cells[10, xRetorno+1] :=  LstEndereco[xRetorno].CodProduto.ToString();
        End;
        SelEnd := True;
     End;
     ObjEnderecoCtrl.Free;
  End;
end;

procedure TFrmPrintTag.BtnPesqZonaClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    ObjPessoaCtrl   : TPessoaCtrl;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then Begin
       if Sender = BtnPesqZona then Begin
          EdtZona.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
          EdtZonaExit(EdtZona);
       End
       Else Begin
          EdtZonaIdVolume.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString;
          EdtZonaExit(EdtZonaIdVolume);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmPrintTag.BtnTagProdControladoClick(Sender: TObject);
begin
  inherited;
  if (Assigned(FrmRelTagProduto) = False) then
     FrmRelTagProduto := TFrmRelTagProduto.Create(Application);
   try
     FrmRelTagProduto.Module     := 'Relatórios';
     FrmRelTagProduto.ModuleMenu := 'Produtos - TAG de Controlados';//+#39+'s';
     FrmRelTagProduto.Show;
     FrmRelTagProduto.EdtPedidoId.SetFocus;
   except on e: Exception do
     begin
       FreeAndNil(FrmRelTagProduto);
       raise Exception.Create(e.Message);
     end;
   end;
end;

procedure TFrmPrintTag.BtnTagProdutoClick(Sender: TObject);
begin
  inherited;
  If (Sender = BtnTagProduto) then Begin
    TbTagON(TbTagProduto);
  End
  Else If Sender = BtnTagLocalizacao then Begin
    TbTagON(TbTagLocalizacao);
    GetEstrutura;
    CbEstrutura.SetFocus;
  End
  Else If Sender = BtnTagVolume then Begin
    TbTagON(TbTagVolume);
    EdtPedidoId.SetFocus;
  End
  Else If Sender = BtnTagCaixa then
    TbTagON(TbTagCaixa)
  Else If (Sender = BtnTagArmazenagem) or (Sender = ImgTagArmazenagem) then Begin
    TbTagON(TbTagArmazenagem);
    RbIndividual.Checked             := True;
    RgPrinterEtqIndividual.ItemIndex := 0;
  End;
end;

procedure TFrmPrintTag.EdtCodProdutoEtqIndividualChange(Sender: TObject);
begin
  inherited;
  LblProdutoEtqIndividual.Caption  := '';
  EdtPickingProdutoEtqIndividual.Text := '';
  EdtQtdEtiquetaIndividual.Value      := 0;
  EdtQuantidadeEstIndividual.Value    := 0;
  If FDMemProdutoLotesEtqArmazenagem.Active then
     FDMemProdutoLotesEtqArmazenagem.EmptyDataSet;
  FDMemProdutoLotesEtqArmazenagem.Close;
  //BtnEtqIndividual.Grayed  := True;
  BtnEtqIndividual.Enabled := False;
  LblCountPrint.Caption := '';
end;

procedure TFrmPrintTag.EdtCodProdutoEtqIndividualExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
    ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayEstoque : TJsonArray;
    vErro : String;
begin
  inherited;
  if EdtCodProdutoEtqIndividual.Text = '' then Begin
     LblProdutoEtqIndividual.Caption := '';
     Exit;
  End;
  if StrToInt64Def(EdtCodProdutoEtqIndividual.Text, 0) <= 0 then Begin
     LblProdutoEtqIndividual.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProdutoEtqIndividual.Text+') inválido!' );
     EdtCodProduto.Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProdutoEtqIndividual.Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+EdtCodProdutoEtqIndividual.Text+') não encontrado!');
     EdtCodProdutoEtqIndividual.Clear;
     JsonProduto := Nil;
     Exit;
  End;
  EdtCodProdutoEtqIndividual.Tag      := JsonProduto.GetValue<Integer>('codproduto');
  LblProdutoEtqIndividual.Caption     := JsonProduto.GetValue<String>('descricao');
  EdtPickingProdutoEtqIndividual.Text := JsonProduto.GetValue<String>('endereco');
  EdtPickingProdutoEtqIndividual.Tag  := JsonProduto.GetValue<Integer>('produtoid');
  ExitFocus(Sender);
  JsonProduto := Nil;
  ObjEstoqueCtrl   := TEstoqueCtrl.Create;
  JsonArrayEstoque := ObjEstoqueCtrl.GetEstoqueLotePorTipo(EdtPickingProdutoEtqIndividual.Tag, 0, 0 ,0, 2, 2, 'N', 'N');
  if Not JsonArrayEstoque.Items[0].TryGetValue('Erro', vErro) then  Begin
     if FDMemProdutoLotesEtqArmazenagem.Active then
        FDMemProdutoLotesEtqArmazenagem.EmptyDataSet;
     FDMemProdutoLotesEtqArmazenagem.Close;
     FDMemProdutoLotesEtqArmazenagem.LoadFromJSON(JsonArrayEstoque, False);
     FDMemProdutoLotesEtqArmazenagem.Open;
     FDMemProdutoLotesEtqArmazenagem.First;
     FDMemProdutoLotesEtqArmazenagem.Edit;
     FDMemProdutoLotesEtqArmazenagem.FieldByName('Impr').AsInteger := 1;
     FDMemProdutoLotesEtqArmazenagem.Post;
  End
  else Begin
     ShowErro('Não foi encontrado lotes/estoque desse produto.');
     EdtCodProdutoEtqIndividual.Clear;
     EdtCodProdutoEtqIndividual.SetFocus;
  End;
  if Not RgPrinterEtqIndividual.ItemIndex < 0 then
     RgPrinterEtqIndividual.SetFocus;
  JsonArrayEstoque := Nil;
  ObjEstoqueCtrl.Free;
  //BtnEtqIndividual.Grayed  := False;
  BtnEtqIndividual.Enabled := True;
end;

procedure TFrmPrintTag.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     JsonProduto := Nil;
     Exit;
  End;
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmPrintTag.EdtDestinatarioChange(Sender: TObject);
begin
  inherited;
  LblDestinatario.Caption := '...';
  vPessoaId := 0;
  LstPedidosAdv.RowCount := 1;
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  LblTotEtiquetasVolume.caption  := '0';
end;

procedure TFrmPrintTag.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro, VCodDig  : String;
begin
  inherited;
  if (EdtDestinatario.Text<>'') then Begin
     vPessoaId := 0;
     vCodDig := EdtDestinatario.Text;
     if StrToIntDef(EdtDestinatario.Text, 0) <= 0 then Begin
        EdtDestinatario.Clear;
        ShowErro('😢Destinatário('+vCodDig+') inválido!');
        Exit;
     end;
     ObjPessoaCtrl := TPessoaCtrl.Create;
     ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
     if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Items[0].tryGetValue<String>('Erro', vErro)) then Begin
        EdtDestinatario.Clear;
        EdtDestinatario.Clear;
        ShowErro('😢Destinatário('+vCodDig+') não encontrado!');
     end
     Else Begin
        //jsonPessoa := ReturnjsonArray.Items[0] as TJSONObject;
        LblDestinatario.Caption := ReturnjsonArray.Items[0].GetValue<TJsonObject>.GetValue<String>('razao');
        vPessoaId       := ReturnjsonArray.Items[0].GetValue<TJsonObject>.GetValue<Integer>('pessoaId');
     end;
     ReturnJsonArray := Nil;
     ObjPessoaCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmPrintTag.EdtDestinatarioKeyPress(Sender: TObject; var Key: Char);
Begin
  SoNumeros(Key);
end;

procedure TFrmPrintTag.EdtDtInicialChange(Sender: TObject);
begin
  inherited;
  LstPedidosAdv.RowCount := 1;
  LblTotEtiquetasVolume.caption  := '0';
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
end;

procedure TFrmPrintTag.EdtDtInicioChange(Sender: TObject);
begin
  inherited;
  LimparLstAdvReport;
end;

procedure TFrmPrintTag.EdtEnderecoIniChange(Sender: TObject);
begin
  inherited;
  LstEnderecoAdv.RowCount := 1;
  LblEtiquetas.Caption := 'Etiquetas: ';
  LblTotalEtiq.Caption := '0';
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
end;

procedure TFrmPrintTag.EdtEnderecoIniExit(Sender: TObject);
begin
  inherited;
//
end;

procedure TFrmPrintTag.EdtPedidoIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmPrintTag.EdtPedidoVolumeIdChange(Sender: TObject);
begin
  inherited;
  LstPedidosAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
  LstVolumesFilterAdv.ClearRect(0, 1, LstVolumesFilterAdv.ColCount-1, LstVolumesFilterAdv.RowCount-1);
  LstPedidosAdv.RowCount       := 1;
  LstVolumesFilterAdv.RowCount := 1;
  if (Sender = EdtRota) then
     LblRota.Caption := '';
  if (Sender = EdtRotaFinal) then
     LblRotaFinal.Caption := '';
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  LblTotEtiquetasVolume.caption  := '0';
end;

procedure TFrmPrintTag.EdtPedidoVolumeIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmPrintTag.EdtPedidoVolumeIdKeyPress(Sender: TObject;
  var Key: Char);
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayRetorno :TJsonArray;
    vErro : String;
begin
  inherited;
  if (Key=#13) and (EdtPedidoVolumeId.Text <> '') then Begin
     If StrToIntDef(EdtPedidoVolumeId.Text, 0) = 0 then Begin
        ShowErro('código de Volume inválido!');
        exit;
     End;
     EdtPedidoId.Clear;
     JsonArrayRetorno := ObjpedidoVolumeCtrl.GetVolume(0, StrToIntDef(EdtPedidoVolumeId.Text, 0), 0, 0);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
        ShowErro('Volume: '+EdtPedidoVolumeId.Text+' '+vErro);
        EdtPedidoVolumeId.Clear
     End
     Else begin
        EdtPedidoId.Text := JsonArrayRetorno.Items[0].GetValue<String>('pedidoid');
        if  JsonArrayRetorno.Items[0].GetValue<String>('embalagem') = 'Caixa Fechada' then
            RgEmbalagemTipo.ItemIndex := 0
        Else RgEmbalagemTipo.ItemIndex := 1;
        //RbProcesso.ItemIndex := 2;
        BtnPesquisarStandClick(Sender);
        BtnImprimirStandClick(Sender);
        EdtPedidoVolumeId.Clear;
        EdtPedidoId.Clear;
        EdtPedidoVolumeId.SetFocus;
        if Assigned(JsonArrayRetorno) then JsonArrayRetorno := Nil;
     End;
  End;
  JsonArrayRetorno := Nil;
end;

procedure TFrmPrintTag.EdtQtdEtiquetaIndividualKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (Not EdtQuantidadeEstIndividual.Visible) then Begin
     If (StrToIntDef(EdtQtdEtiquetaIndividual.Text, 0)) < 0 then Begin
        Key := #0;
        ShowErro('Quantidade de Etiqueta inválida para impressão!');
        EdtQtdEtiquetaIndividual.Clear;
        EdtQtdEtiquetaIndividual.SetFocus;
     End
     Else Begin
       BtnEtqIndividualClick(BtnEtqIndividual);
     End;
  End;
end;

procedure TFrmPrintTag.EdtQuantidadeEstIndividualKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) then Begin
     If (StrToIntDef(EdtQuantidadeEstIndividual.Text, 0)) < 0 then Begin
        Key := #0;
        ShowErro('Quantidade inválida para impressão!');
        EdtQuantidadeEstIndividual.Clear;
        EdtQuantidadeEstIndividual.SetFocus;
     End
     Else Begin
       BtnEtqIndividualClick(BtnEtqIndividual);
     End;
  End;
end;

procedure TFrmPrintTag.EdtRotaExit(Sender: TObject);
Var ObjRotaCtrl    : TRotaCtrl;
    ReturnLstRota  : TObjectList<TRotaCtrl>;
    xRetorno       : Integer;
    vErro          : String;
begin
  if (Sender=EdtRotaFinal) and (StrToIntDef(EdtRotaFinal.Text, 0) > 0) and (StrToIntDef(EdtRotaFinal.Text, 0) < StrToIntDef(EdtRota.Text, 0)) then Begin
     EdtRotaFinal.SetFocus;
     ShowErro('Rota Final inválida!!!');
     Exit;
  End;
  inherited;
  if (TEdit(Sender).Text<>'') and (Not TEdit(Sender).ReadOnly) then Begin
     if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
        Player('toast4');
        ShowErro( '😢Rota('+TEdit(Sender).Text+') inválida!');
        Exit;
     end;
     ObjRotaCtrl   := TRotaCtrl.Create;
     ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(TEdit(Sender).text, 0), '', 0);
     if (ReturnLstRota.Count <= 0) then Begin
        EdtDestinatario.Clear;
        Player('toast4');
        ShowErro( '😢Rota não('+TEdit(Sender).Text+') encontrado!');
     end
     Else Begin
        if Sender = EdtRota then
           LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao
        Else LblRotaFinal.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
     End;
     ReturnLstRota := Nil;
     ObjRotaCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmPrintTag.EdtRotaKeyPress(Sender: TObject; var Key: Char);
begin
  SoNumeros(Key);
end;

procedure TFrmPrintTag.EdtRuaIdChange(Sender: TObject);
begin
  inherited;
  LblRua.Caption := '';
  LstEnderecoAdv.RowCount  := 1;
  LblTotalEtiq.Caption     := '0';
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
end;

procedure TFrmPrintTag.EdtRuaIdExit(Sender: TObject);
Var ObjEnderecoRuaCtrl : TEnderecoRuaCtrl;
    ReturnLstRua       : TObjectList<TEnderecoRua>;
begin
  inherited;
  LblRua.Caption := '';
  if StrToIntDef(EdtRuaId.Text, 0) = 0 then Exit;
  ObjEnderecoRuaCtrl := TEnderecoRuaCtrl.Create;
  ReturnLstRua       := ObjEnderecoRuaCtrl.GetEnderecoRua(StrtoIntDef(EdtRuaId.Text, 0), '', '', 0);
  if ReturnLstRua.Count <= 0 then Begin
     EdtRuaId.Clear;
     ShowErro('Rua('+EdtRuaId.Text+') não encontrada!');
  End
  else
    LblRua.Caption  := ReturnLstRua.Items[0].Descricao;
  ReturnLstRua := Nil;
  ObjEnderecoRuaCtrl.Free;
end;

procedure TFrmPrintTag.EdtZonaChange(Sender: TObject);
begin
  inherited;
  LblZona.Caption := '';
  LstEnderecoAdv.RowCount  := 1;
  LblEtiquetas.Caption := 'Etiquetas: ';
  LblTotalEtiq.Caption     := '0';
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
end;

procedure TFrmPrintTag.EdtZonaExit(Sender: TObject);
Var ObjEnderecoZonaCtrl : TEnderecamentoZonaCtrl;
    ReturnLstZona       : TObjectList<TEnderecamentoZona>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
  if Sender = EdtZona then
     LblZona.Caption := ''
  Else LblZonaVolume.Caption := '';
  if StrToIntDef(TEdit(Sender).Text, 0) = 0 then Exit;
  ObjEnderecoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  ReturnLstZona       := ObjEnderecoZonaCtrl.GetEnderecamentoZona(StrtoIntDef(TEdit(Sender).Text, 0), '', 0);
  if ReturnLstZona.Count <= 0 then Begin
     TEdit(Sender).Clear;
     ShowErro('Zona('+TEdit(Sender).Text+') não encontrada!');
  End
  else Begin
    if Sender = EdtZona then
       LblZona.Caption   := ReturnLstZona.Items[0].Descricao
    Else LblZonaVolume.Caption   := ReturnLstZona.Items[0].Descricao;
  End;
  ReturnLstZona       := Nil;
  ObjEnderecoZonaCtrl.Free;
end;

procedure TFrmPrintTag.EdtZonaIdExit(Sender: TObject);
Var JsonArrayZona : TJsonArray;
    vErro : String;
    ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
begin
  inherited;
  if TEdit(Sender).Text = '' then Begin
     if Sender = EdtZona then
        LblZona.Caption := ''
     Else If Sender = EdtZonaIdVolume then
        LblZonaVolume.Caption := ''
     Else if Sender = EdtZonaId then
        LblZonaTagArmazenagem.Caption := '';
     ExitFocus(Sender);
     Exit;
  End;
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     if Sender = EdtZona then
        LblZona.Caption := ''
     Else If Sender = EdtZonaIdVolume then
        LblZonaVolume.Caption := ''
     Else if Sender = EdtZonaId then
        LblZonaTagArmazenagem.Caption := '';
     ShowErro( '😢Código de Zona('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  JsonArrayZona := ObjEnderecamentoZonaCtrl.FindEnderecamentoZona(StrToIntDef(TEdit(Sender).Text, 0), '', 0);
  if JsonArrayZona.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('😢Código de Zona('+EdtZonaId.Text+') não encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else Begin
     if Sender = EdtZonaId then
        LblZonaTagArmazenagem.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao')
     Else if Sender = EdtZona then
        LblZona.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao')
     Else if Sender = EdtZonaIdVolume then
        LblZonaVolume.Caption := JsonArrayZona.Items[0].GetValue<String>('descricao');
  End;
  ExitFocus(Sender);
  JsonArrayZona := Nil;
  ObjEnderecamentoZonaCtrl.Free;
end;

procedure TFrmPrintTag.FormClick(Sender: TObject);
begin
  inherited;
  TbTagOFF;
end;

procedure TFrmPrintTag.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPrintTag := Nil;
end;

procedure TFrmPrintTag.FormCreate(Sender: TObject);
Var vlIni : TIniFile;
begin
  inherited;
  vlIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.ini');
  try
    vTimeEtiqueta := vlIni.ReadInteger('PRINTER',  'TimeEtq' , 500);
    vTemperatura  := vlIni.ReadInteger('PRINTER',  'Temperatura' , 15);
  finally
    vlIni.Free;
  end;

  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  SelPedido := True;
  TabListagem.TabVisible := False;
  TbTagOFF;
  SetReadOnly;
  CbComposicao.ItemIndex  := 1;
  CbFormato.ItemIndex     := 2;
  LstEnderecoAdv.RowCount := 1;
  LblEtiquetas.Caption := 'Etiquetas: ';
  LblTotalEtiq.Caption    := '0';
  With LstEnderecoAdv do Begin
    ColWidths[0]  :=  40;
    ColWidths[1]  := 120;
    ColWidths[2]  :=  150;
    ColWidths[3]  :=  70;
    ColWidths[4]  :=  80;
    ColWidths[5]  :=  90;
    ColWidths[6]  :=  120;
    ColWidths[7]  :=  60;
    ColWidths[8]  :=  65;
    ColWidths[10] :=  70;
    LstEnderecoAdv.HideColumn(9);
    Alignments[2, 0] := taCenter;
    Alignments[7, 0] := taCenter;
    Alignments[8, 0] := taCenter;
    FontStyles[0, 0] := [FsBold];
    FontStyles[1, 0] := [FsBold];
  End;
  JsonPedidoCubagem := tjsonArray.Create;
  LstPedidosAdv.ColWidths[0] :=  90;
  LstPedidosAdv.ColWidths[1] := 120;
  LstPedidosAdv.ColWidths[2] :=  70;
  LstPedidosAdv.ColWidths[3] := 200;
  LstPedidosAdv.ColWidths[4] := 120;
  LstPedidosAdv.ColWidths[5] :=  60;
  LstPedidosAdv.ColWidths[6] := 120;
  LstPedidosAdv.ColWidths[7] :=  40;
  LstPedidosAdv.Alignments[0, 0] := taRightJustify;
  LstPedidosAdv.FontStyles[0, 0] := [fsBold];
  LstPedidosAdv.Alignments[2, 0] := taRightJustify;
  LstPedidosAdv.Alignments[5, 0] := taRightJustify;
  LstPedidosAdv.Alignments[6, 0] := taLeftJustify;
  LstPedidosAdv.Alignments[7, 0] := taCenter;

  LstVolumesFilterAdv.ColWidths[0] := 100;
  LstVolumesFilterAdv.ColWidths[1] :=  60;
  LstVolumesFilterAdv.ColWidths[2] := 120;
  LstVolumesFilterAdv.ColWidths[3] :=  60;
  LstVolumesFilterAdv.ColWidths[4] := 120;
  LstVolumesFilterAdv.ColWidths[5] :=  50;
  LstVolumesFilterAdv.ColWidths[6] :=  70;
  LstVolumesFilterAdv.ColWidths[7] := 120;
  LstVolumesFilterAdv.ColWidths[8] :=  40;
  LstVolumesFilterAdv.Alignments[0, 0] := taRightJustify;
  LstVolumesFilterAdv.FontStyles[0, 0] := [FsBold];
  LstVolumesFilterAdv.Alignments[1, 0] := taRightJustify;
  vSelectLoteTag := False;
  ConfigACBrETQ;
end;

procedure TFrmPrintTag.FormDestroy(Sender: TObject);
begin
  JsonPedidoCubagem := Nil;
  ObjPedidoCtrl.Free;
  inherited;
end;

procedure TFrmPrintTag.FormShow(Sender: TObject);
begin
  inherited;
  RbProcesso.ItemIndex := 0;
  exit;
  Try
    ACBrETQConfig.Ativar;
    If Not ACBrETQConfig.EtqInicializada Then
       ShowErro('Não foi possível Ativar a Impressora!');
    ACBrETQConfig.Desativar;
  Except
    ShowErro('Impressora de Código de Barras sem comunicação!');
  End;
end;

procedure TFrmPrintTag.GetEstrutura;
Var ObjEnderecoEstruturaCtrl : TEnderecoEstruturaCtrl;
    ReturnLstEstrutura       : TObjectList<TEnderecoEstrutura>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
  ObjEnderecoEstruturaCtrl := TEnderecoEstruturaCtrl.Create;
  ReturnLstEstrutura       := ObjEnderecoEstruturaCtrl.GetEnderecoEstrutura(0, '', 0);
  CbEstrutura.Items.Clear;
  CbEstrutura.Items.Add('');
  For xRetorno := 0 to Pred(ReturnLstEstrutura.Count) do Begin
    CbEstrutura.Items.Add( ReturnLstEstrutura.Items[xRetorno].Descricao );
  End;
  ReturnLstEstrutura     := Nil;
  ObjEnderecoEstruturaCtrl.Free;
  CbEstrutura.ItemIndex    := 0;
end;

procedure TFrmPrintTag.GetVolumeParaEtiquetas(pPedidoid: Integer);
Var JsonArrayVolumes :  TJsonArray;
    ObjpedidoVolumeCtrl : TPedidoVolumeCtrl;
    xVol  : Integer;
    vErro : String;
    xRow  : Integer;
    vPrintTag, vEmbalagem : Integer;
begin
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  LstVolumesFilterAdv.RowCount := 1;
  vPrintTag  := RbProcesso.ItemIndex;
  vEmbalagem := rgEmbalagemTipo.ItemIndex;
//  jsonArrayVolumes := ObjPedidoVolumeCtrl.GetVolume(pPedidoId, 0, 0, 0, 'T', StrToIntDef(EdtZonaIdVolume.Text, 0));
  jsonArrayVolumes := ObjPedidoVolumeCtrl.GetVolumePrintTag(pPedidoId, 0, 0, 0, StrToIntDef(EdtZonaIdVolume.Text, 0), vPrintTag, vEmbalagem);
  if JsonArrayVolumes.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Não há volume(s) disponível para esse pedido!');
     Exit;
  End;
//  for xVol := 1 to JsonArrayVolumes.Count do
//    LstVolumesFilterAdv.AddDataImage(8, xVol, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);
  xRow := 0;
  for xVol := 0 to Pred(JsonArrayVolumes.Count) do Begin
//    if ((RgEmbalagemTipo.ItemIndex = 2) or
//        (RgEmbalagemTipo.ItemIndex = JsonArrayVolumes.Items[xVol].GetValue<Integer>('volumetipo'))) then Begin
       Inc(xRow);
       LstVolumesFilterAdv.RowCount := xRow+1;
       LstVolumesFilterAdv.AddDataImage(8, xRow, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);
       If LstVolumesFilterAdv.RowCount > 1 Then LstVolumesFilterAdv.FixedRows := 1;
       LstVolumesFilterAdv.Cells[0, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('pedidovolumeid');
       LstVolumesFilterAdv.Cells[1, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('sequencia');
       LstVolumesFilterAdv.Cells[2, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('embalagem');
       LstVolumesFilterAdv.Cells[3, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('identificacao');
       LstVolumesFilterAdv.Cells[4, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('processo');
       LstVolumesFilterAdv.Cells[5, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('rua');
       LstVolumesFilterAdv.Cells[6, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('predioinicial');
       LstVolumesFilterAdv.Cells[7, xRow]    := JsonArrayVolumes.Items[xVol].GetValue<String>('zona');
       if ((JsonArrayVolumes.Items[xVol].GetValue<String>('processo') = 'Cubagem Realizada') and (RbProcesso.ItemIndex = 0)) or
          ((JsonArrayVolumes.Items[xVol].GetValue<String>('processo') <> 'Cubagem Realizada') and (RbProcesso.ItemIndex = 1)) or
          (RbProcesso.ItemIndex = 2) then
          LstVolumesFilterAdv.Cells[8, xRow]    := '5'
       Else LstVolumesFilterAdv.Cells[8, xRow]    := '6';
       if JsonArrayVolumes.Items[xVol].GetValue<Integer>('processoid') = 13 then
          LstVolumesFilterAdv.Colors[7, xRow] := ClRed
       Else LstVolumesFilterAdv.Colors[7, xRow] := LstVolumesFilterAdv.Colors[6, xVol+1];
       if JsonArrayVolumes.Items[xVol].GetValue<Integer>('processoid') = 8 then
          LstVolumesFilterAdv.Colors[7, xRow] := $00B0FFFF
       Else if JsonArrayVolumes.Items[xVol].GetValue<Integer>('processoid') in [10, 12] then
          LstVolumesFilterAdv.Colors[7, xRow] := $006FB7FF
       Else If JsonArrayVolumes.Items[xVol].GetValue<Integer>('processoid') in [13, 14] then
          LstVolumesFilterAdv.Colors[7, xRow] := $00006C00
       Else If JsonArrayVolumes.Items[xVol].GetValue<Integer>('processoid') = 15 then
          LstVolumesFilterAdv.Colors[7, xRow] := ClRed
       Else
          LstVolumesFilterAdv.Colors[7, xRow] := LstVolumesFilterAdv.Colors[6, xVol+1];
       LstVolumesFilterAdv.Alignments[0, xRow] := taRightJustify;
       LstVolumesFilterAdv.FontStyles[0, xRow] := [FsBold];
       LstVolumesFilterAdv.Alignments[1, xRow] := taRightJustify;
//    End;
  End;
 // LstVolumesFilterAdv := Nil;     //Retirado em 15/09/2022
  JsonArrayVolumes    := Nil;
  ObjPedidoVolumeCtrl.Free;
end;

procedure TFrmPrintTag.Imprimir;
Begin
  if PgcTabTags.ActivePage = TbTagLocalizacao then begin

  End;
end;

procedure TFrmPrintTag.ImprimirVolumes;
Var xPedido, xVolumes, xEtiquetas, xEtiquetaPrint: Integer;
    jsonVolumesParaEtiqueta : tjsonArray;
    jsonEtiquetasPorVolume  : tjsonArray;
    ObjPedidoVolumeCtrl : TPedidoVOlumeCtrl;
    verro : String;
    vPedidoVolumeId, vCaixaEmbalagemId : Integer;
    pPedidoId, pPedidoVolumeId, pSequencia, pCodPessoaERP, vItens, vTotUnid, vTotalVolumes, pProcessoId, pRotaId : Integer;
    prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal : String;
    vPedidoErro : String;
    JsonArrayRetorno : TJsonArray;
    pMascara    : String;
    vPrintTag   : Integer;
    vEmbalagem  : Integer;
Begin
  If (EdtPedidoVolumeId.Text = '') and ((FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagVolumeOrdem = 1) or
                                        (FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagVolumeOrdem = 2))then Begin
     PrintEtiquetaPorRua(FrmeXactWMS.ConfigWMS.ObjConfiguracao.TagVolumeOrdem);
     Exit
  End;
  if EdtPedidoVolumeId.Text <> '' then
     vPrintTag := 2
  Else Begin
     vPrintTag  := RbProcesso.ItemIndex;
  End;
  vEmbalagem := rgEmbalagemTipo.ItemIndex;
  xEtiquetas     := StrToInt(LblTotEtiquetasVolume.Caption);
  xEtiquetaPrint := 0;
  for xPedido := 1 to Pred(LstPedidosAdv.RowCount) do  Begin
    LstPedidosAdv.Row := xPedido;
    if LstPedidosAdv.Cells[7, xPedido] = '1' then Begin
       ObjPedidoVolumeCtrl := TPedidoVOlumeCtrl.Create;
       jsonVolumesParaEtiqueta := ObjPedidoVolumeCtrl.VolumeParaEtiquetas(LstPedidosAdv.Cells[0, xPedido].tointeger,
                                                                          StrToIntDef(EdtPedidoVolumeId.Text, 0),
                                                                          StrToIntDef(EdtZonaIdVolume.Text, 0),
                                                                          vPrintTag, vEmbalagem );
       Memo1.Clear;
       Memo1.Text := JsonVolumesParaEtiqueta.ToString;
       if JsonVolumesParaEtiqueta.Count > 0 then Begin
          if jsonVolumesParaEtiqueta.Items[0].tryGetValue<String>('Erro', vErro) then Begin
             ShowMessage('Erro no Pedido: '+LstPedidosAdv.Cells[0, xPedido]+#13+'Erro: '+vErro);
             //raise Exception.Create('Erro: '+vErro);
          End
          Else if (jsonVolumesParaEtiqueta.Count > 0) then Begin
             JsonArrayRetorno := TJsonArray.Create;
             JsonArrayRetorno := TJSONObject.ParseJSONValue(Memo1.Text) as TJSONArray;
             For xVolumes := 0 to Pred(JsonArrayRetorno.Count) do begin
               vPedidoVolumeId := JsonArrayRetorno.Items[xVolumes].GetValue<Integer>('pedidovolumeid');
               if (StrToIntDef(EdtPedidoVolumeId.Text, 0) = 0) or (StrToIntDef(EdtPedidoVolumeId.Text, 0) = vPedidoVolumeId) then Begin
                  vCaixaEmbalagemId := JsonArrayRetorno.Items[xVolumes].GetValue<Integer>('embalagemid');
                  if (vCaixaEmbalagemId <> 0) and ((StrtoIntDef(EdtPedidoVolumeId.Text,0)>0) or (RgEmbalagemTipo.ItemIndex in [1, 2])) then Begin
                     jsonEtiquetasPorVolume := ObjPedidoVolumeCtrl.EtiquetasPorVolume( vPedidoVolumeId);
                     If (((jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid') < 3) and (RbProcesso.ItemIndex = 0)) or
                        ((jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid') > 2) and (jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid') < 13) and (RbProcesso.ItemIndex > 0))) or (EdtPedidoVolumeId.Text<>'') then Begin
                        pPedidoId          := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('pedidoid');
                        pDocumentoOriginal := jsonEtiquetasPorVolume.Items[0].GetValue<String>('documentooriginal');
                        pDtPedido          := DateToStr(StrToDate(jsonEtiquetasPorVolume.Items[0].GetValue<String>('dtpedido')));
                        pPedidoVolumeId    := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('pedidovolumeid');
                        pSequencia         := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('sequencia');
                        pCodPessoaERP      := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('codpesssoaerp');
                        prazao             := jsonEtiquetasPorVolume.Items[0].GetValue<String>('fantasia');
                        pRotaId            := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('rotaid');
                        protas             := jsonEtiquetasPorVolume.Items[0].GetValue<String>('rotas');
                        pProcessoId        := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('processoid');
                        pMascara           := jsonEtiquetasPorVolume.Items[0].GetValue<String>('mascara');
                        vPredini           := jsonEtiquetasPorVolume.Items[0].GetValue<String>('inicio');
                        vPredIni           := copy(EnderecoMask(vPredIni, pMascara, True), 1, 5);
                        vPredFin           := jsonEtiquetasPorVolume.items[0].GetValue<String>('termino');
                        vPredFin           := copy(EnderecoMask(vPredFin, pMascara, True), 1, 5);
                        vItens             := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('itens');
                        vTotUnid           := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('qtdsuprida');
                        vTotalVolumes      := jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('totalvolumes');
                        if (pProcessoId < 13) or (StrToIntDef(EdtPedidoVolumeId.Text, 0) <> 0) then
                           TagVolumeFracionado8x10etqEpl2(pPedidoid, pPedidoVolumeId, pSequencia, pCodPessoaERP,
                                                          jsonEtiquetasPorVolume.Items[0].GetValue<Integer>('ordem'), vItens,
                                                          vTotUnid, prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal, pProcessoId, pRotaId, vTotalVolumes);
                     End;
                  End
                  Else If (vCaixaEmbalagemId = 0) and ((StrtoIntDef(EdtPedidoVolumeId.Text,0)>0) or (RgEmbalagemTipo.ItemIndex in [0, 2])) then Begin
                    //Buscar os dados para o VOlume
                    if FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 0 then //Padrão eXactWMS
                       TagVolumeCaixaFechada8x10etqEpl2(vPedidoVolumeId)
                    Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 1 then //Padrão eXactWMS com Endereço
                       TagVolumeCaixaFechada_Address_8x10etqEpl2(vPedidoVolumeId)
                    Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 2 then //Destaque para Cliente e Rota
                       TagVolumeCaixaFechada_RotaClienteDestaque_8x10etqEpl2(vPedidoVolumeId);
                  End;
                  Inc(xEtiquetaPrint);
                  Application.ProcessMessages;
                  LblEtiquetas.Caption := 'Imprimindo: '+xEtiquetaPrint.ToString()+' de '+xEtiquetas.ToString;
                  LblTotEtiquetasVolume.Caption := '';

               End;
             end;
             jsonEtiquetasPorVolume := Nil;
             JsonArrayRetorno.Free; //GSS em 15082022
          End;
       End;
       //JsonArrayRetorno := Nil;
       //jsonVolumesParaEtiqueta := Nil;
       ObjPedidoVolumeCtrl.Free;
    End;
  End;
  LblEtiquetas.Caption          := 'Etiquetas: ';
  LblTotEtiquetasVolume.Caption := '0';
  Application.MessageBox('Processo finalizado...', 'Impressão de TAG.', MB_OK);
end;

procedure TFrmPrintTag.LimparLstAdvReport;
begin
  if FdMemTagArmazenagem.Active then
     FdMemTagArmazenagem.EmptyDataSet;
  FdMemTagArmazenagem.Close;
  If LstTagArmazenagem.RowCount > 1 then Begin
     LstTagArmazenagem.ClearRect(0, 1, LstTagArmazenagem.ColCount-1, LstTagArmazenagem.RowCount-1);
     LstTagArmazenagem.RowCount       := 1;
  End;
  LblEtiquetas.Caption := 'Etiquetas: ';
  LblTotalEtiq.Caption := '0';
end;

procedure TFrmPrintTag.LstEnderecoAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xEnd : Integer;
begin
  inherited;
  if LstEnderecoAdv.RowCount <= 1 then Exit;
  if (aCol = 8) then Begin
     if aRow = 0 then Begin
        For xEnd := 1 to Pred(LstEnderecoAdv.RowCount) do
          if SelEnd then
             LstEnderecoAdv.Cells[8, xEnd] := '0'
          Else LstEnderecoAdv.Cells[8, xEnd] := '1';
        SelEnd := Not SelEnd;
     End
     Else Begin
       if LstEnderecoAdv.Cells[8, aRow] = '0' then
             LstEnderecoAdv.Cells[8, aRow] := '1'
       Else LstEnderecoAdv.Cells[8, aRow] := '0';
     End;
  End;
end;

procedure TFrmPrintTag.LstPedidosAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xPedido : Integer;
begin
  inherited;
  if LstPedidosAdv.RowCount <= 1 then Exit;
  if (Arow=0) and (acol < 7) then Begin
     LstPedidosAdv.SortSettings.Column := aCol;
     LstPedidosAdv.QSort;
  End;
  if (aRow>0) and (aCol<7) and (LstPedidosAdv.Cells[7, aRow] = '1') then Begin  //(aCol = 0) and
     GetVolumeParaEtiquetas(LstPedidosAdv.Cells[0, aRow].ToInteger);
     LstPedidosAdv.Row := aRow;
  End
  Else if (aCol = 7) then Begin
     if (aRow = 0) and (LstPedidosAdv.RowCount>1) then Begin
        For xPedido := 1 to Pred(LstPedidosAdv.RowCount) do Begin
          if SelPedido then Begin
             if LstPedidosAdv.Cells[7, xPedido] = '1' then Begin
                LstPedidosAdv.Cells[7, xPedido] := '0';
                LblTotEtiquetasVolume.Caption := (StrTointDef(LblTotEtiquetasVolume.Caption, 0) - StrToIntDef(LstPedidosAdv.Cells[5, xPedido], 0)).Tostring();
             End;
          End
          Else Begin
             if LstPedidosAdv.Cells[7, xPedido] = '0' then Begin
                LstPedidosAdv.Cells[7, xPedido] := '1';
                LblTotEtiquetasVolume.Caption := (StrTointDef(LblTotEtiquetasVolume.Caption, 0) + StrToIntDef(LstPedidosAdv.Cells[5, xPedido], 0)).Tostring();
             End;
          End;
        End;
        SelPedido := Not SelPedido;
     End
     Else Begin
       if (StrToIntDef(LstPedidosAdv.Cells[7, aRow], 0) = 0) then Begin
          LstPedidosAdv.Cells[7, aRow] := '1';
          LblTotEtiquetasVolume.Caption := (StrTointDef(LblTotEtiquetasVolume.Caption, 0) + StrToIntDef(LstPedidosAdv.Cells[5, aRow], 0)).Tostring();
       End
       Else begin
          LstPedidosAdv.Cells[7, aRow] := '0';
          LblTotEtiquetasVolume.Caption := (StrTointDef(LblTotEtiquetasVolume.Caption, 0) - StrToIntDef(LstPedidosAdv.Cells[5, aRow], 0)).Tostring()
       End;
     End;
  End;
end;

procedure TFrmPrintTag.LstTagArmazenagemClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var xRota : Integer;
begin
  inherited;
  if LstTagArmazenagem.RowCount <= 1 then Exit;
  if (aCol = 8) then Begin
     if (aRow = 0) then Begin
        For xRota := 1 to Pred(LstTagArmazenagem.RowCount) do
          if SelPedEtq then
             LstTagArmazenagem.Cells[8, xRota] := '0'
          Else
             LstTagArmazenagem.Cells[8, xRota] := '1';
        SelPedEtq := Not SelPedEtq;
     End
     Else Begin
       if StrToIntDef(LstTagArmazenagem.Cells[8, aRow], 0) = 0 then
          LstTagArmazenagem.Cells[8, aRow] := '1'
       Else Begin
         LstTagArmazenagem.Cells[8, aRow] := '0';
       End;
     End;
  End;
end;

procedure TFrmPrintTag.LstVolumesFilterAdvClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var ObjPedidoVolumeCtrl    : TPedidoVolumeCtrl;
    JsonVolumeParaEtiqueta : TJsonArray;
    vPedidoVolumeId, vCaixaEmbalagemId : Integer;
    pPedidoId, pPedidoVolumeId, pSequencia, pCodPessoaERP, vItens, vTotUnid, pProcessoId, pRotaId, vTotalVolumes : Integer;
    prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal : String;
    pMascara, vErro : String;
begin
  inherited;
  if LstVolumesFilterAdv.RowCount <= 1 then Exit;
  if (aCol = 8) and (LstVolumesFilterAdv.Cells[8, aRow].ToInteger() = 5) then begin
     if LstVolumesFilterAdv.Cells[2, aRow] = 'Caixa Fechada' then Begin
        if FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 0 then
           TagVolumeCaixaFechada8x10etqEpl2(LstVolumesFilterAdv.Cells[0, aRow].ToInteger())
        Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 1 then
           TagVolumeCaixaFechada_Address_8x10etqEpl2(LstVolumesFilterAdv.Cells[0, aRow].ToInteger())
        Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 2 then
           TagVolumeCaixaFechada_RotaClienteDestaque_8x10etqEpl2(LstVolumesFilterAdv.Cells[0, aRow].ToInteger());
        End
     Else Begin
        jsonVolumeParaEtiqueta := ObjPedidoVolumeCtrl.EtiquetasPorVolume( LstVolumesFilterAdv.Cells[0, aRow].ToInteger() );
        if jsonVolumeParaEtiqueta.Get(0).tryGetValue<String>('Erro', vErro) then
           raise Exception.Create('Erro: '+vErro);
        pPedidoId       := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('pedidoid');
        pDocumentoOriginal := jsonVolumeParaEtiqueta.Items[0].GetValue<String>('documentooriginal');
        pDtPedido       := DateToStr(StrToDate(jsonVolumeParaEtiqueta.Items[0].GetValue<String>('dtpedido')));
        pPedidoVolumeId := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('pedidovolumeid');
        pSequencia      := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('sequencia');
        pCodPessoaERP   := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('codpesssoaerp');
        prazao          := jsonVolumeParaEtiqueta.Items[0].GetValue<String>('razao');
        pRotaId         := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('rotaid');
        protas          := jsonVolumeParaEtiqueta.Items[0].GetValue<String>('rotas');
        pProcessoId     := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('processoid');
        pMascara        := jsonVolumeParaEtiqueta.Items[0].GetValue<String>('mascara');
        vPredini        := jsonVolumeParaEtiqueta.Items[0].GetValue<String>('inicio');
        vPredIni        := copy(EnderecoMask(vPredIni, pMascara, True), 1, 5);
        vPredFin        := jsonVolumeParaEtiqueta.Items[0].GetValue<String>('termino');
        vPredFin        := copy(EnderecoMask(vPredFin, pMascara, True), 1, 5);
        vItens          := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('itens');
        vTotUnid        := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('qtdsuprida');
        vTotalVolumes   := jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('totalvolumes');
        TagVolumeFracionado8x10etqEpl2(pPedidoid, pPedidoVolumeId, pSequencia, pCodPessoaERP,
                                       jsonVolumeParaEtiqueta.Items[0].GetValue<Integer>('ordem'), vItens,
                                       vTotUnid, prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal,
                                       pProcessoId, pRotaId, vTotalVolumes);
        jsonVolumeParaEtiqueta := Nil;
     End;
  end;
end;

procedure TFrmPrintTag.MontaListaEtqArmazenagem;
Var xPed, xRetorno : Integer;
begin
  inherited;
  LstTagArmazenagem.RowCount  := FDMemTagArmazenagem.RecordCount+1;
  LstTagArmazenagem.FixedRows := 1;
  LblTotRegEtqArmazenagem.Caption        := FormatFloat('####0', FDMemTagArmazenagem.RecordCount);
  xRetorno := 1;
//  for xPed := 1 to Pred(pJsonArray.Count) do
//    LstTagArmazenagem.AddDataImage( 8, xPed, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  While Not FDMemTagArmazenagem.Eof do Begin
    LstTagArmazenagem.Cells[0, xRetorno] := FDMemTagArmazenagem.FieldByName('PedidoId').AsString;
    LstTagArmazenagem.Cells[1, xRetorno] := FDMemTagArmazenagem.FieldByName('DocumentoNr').AsString;
    LstTagArmazenagem.Cells[2, xRetorno] := FDMemTagArmazenagem.FieldByName('Data').AsString;
    LstTagArmazenagem.Cells[3, xRetorno] := FDMemTagArmazenagem.FieldByName('CodPessoaERP').AsString;
    LstTagArmazenagem.Cells[4, xRetorno] := FDMemTagArmazenagem.FieldByName('Razao').AsString;
    LstTagArmazenagem.Cells[5, xRetorno] := FDMemTagArmazenagem.FieldByName('Fantasia').AsString;
    LstTagArmazenagem.Cells[6, xRetorno] := FDMemTagArmazenagem.FieldByName('QtdItens').AsString;
    LstTagArmazenagem.Cells[7, xRetorno] := FDMemTagArmazenagem.FieldByName('Quantidade').AsString;
    LstTagArmazenagem.AddDataImage( 8, xRetorno, 1, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstTagArmazenagem.Alignments[0, xRetorno] := taRightJustify;
    LstTagArmazenagem.FontStyles[0, xRetorno] := [FsBold];
    LstTagArmazenagem.Alignments[3, xRetorno] := taRightJustify;
    LstTagArmazenagem.Alignments[6, xRetorno] := taRightJustify;
    LstTagArmazenagem.Alignments[7, xRetorno] := taRightJustify;
    LstTagArmazenagem.Alignments[8, xRetorno] := taCenter;
    FDMemTagArmazenagem.Next;
    Inc(xRetorno);
  End;
  ImprimirExportar(True);
end;

procedure TFrmPrintTag.MontaListaPedido(pFiltro: Boolean);
Var xRetorno, xPedido, xTotVolume : Integer;
Begin
  if RgEmbalagemTipo.ItemIndex < 0 then
     raise Exception.Create('Selectione o tipo de Etiquetas para Impressão.');
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  LstPedidosAdv.RowCount   := 1;
  if JsonPedidoCubagem.Count > 0 then Begin
     LstPedidosAdv.RowCount  := JsonPedidoCubagem.Count + 1;
     LstPedidosAdv.FixedRows := 1;
  End;
  if JsonPedidoCubagem.Count >= 1 then Begin
    xRetorno   := 0;
    xTotVolume := 0;
    For xPedido := 0 to Pred(JsonPedidoCubagem.Count) do Begin
      LstPedidosAdv.FixedRows := 1;
      LstPedidosAdv.Cells[0, xRetorno+1] := JsonPedidoCubagem.Items[xPedido].GetValue<String>('pedidoid');
      LstPedidosAdv.Cells[4, xRetorno+1] := JsonPedidoCubagem.Items[xPedido].GetValue<String>('processoetapa');
      LstPedidosAdv.AddDataImage(8, xRetorno+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
      LstPedidosAdv.Cells[1, xRetorno+1] := 'Ressuprimento'; //JsonPedidoCubagem.Items[xPedido].GetValue<String>('operacaotipo');
      LstPedidosAdv.Cells[2, xRetorno+1] := JsonPedidoCubagem.Items[xPedido].GetValue<String>('codpessoaerp');
      LstPedidosAdv.Cells[3, xRetorno+1] := JsonPedidoCubagem.Items[xPedido].GetValue<String>('fantasia');
      LstPedidosAdv.Cells[5, xRetorno+1] := JsonPedidoCubagem.Items[xPedido].GetValue<Integer>('qtdvolume').ToString();
      LstPedidosAdv.Cells[6, xRetorno+1] := JsonPedidoCubagem.Items[xPedido].GetValue<String>('rotaid')+' '+
                                               Copy(JsonPedidoCubagem.Items[xPedido].GetValue<String>('rota'), 1, 20); //.ToString();
      LstPedidosAdv.Cells[7, xRetorno+1] := '1';
      xTotVolume := xTotVolume + JsonPedidoCubagem.Items[xPedido].GetValue<Integer>('qtdvolume');
      LstPedidosAdv.AddDataImage(7, xRetorno+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);

      LstPedidosAdv.FontStyles[0, xRetorno+1] := [FsBold];
      LstPedidosAdv.Alignments[0, xRetorno+1] := taRightJustify;
      LstPedidosAdv.Alignments[2, xRetorno+1] := taRightJustify;
      LstPedidosAdv.Alignments[5, xRetorno+1] := taRightJustify;
      LstPedidosAdv.Alignments[7, xRetorno+1] := taCenter;
      LstPedidosAdv.Alignments[0, 0] := taRightJustify;
      LstPedidosAdv.FontStyles[0, 0] := [fsBold];
      LstPedidosAdv.Alignments[2, 0] := taRightJustify;
      LstPedidosAdv.Alignments[5, 0] := taRightJustify;
      LstPedidosAdv.Alignments[6, 0] := taLeftJustify;
      LstPedidosAdv.Alignments[7, 0] := taCenter;
      Inc(xRetorno);
    End;
    LblTotEtiquetasVolume.Caption := xTotVolume.ToString();
    if EdtPedidoVOlumeId.Text = '' then
       LstPedidosAdvClickCell(LstPedidosAdv, 1, 0);
    BtnImprimirStand.Grayed  := False;
    BtnImprimirStand.Enabled := True;
  End;
end;

{procedure TFrmPrintTag.MontaListaPedido(pFiltro: Boolean);
Var //ReturnArrayJson : TJsonArray;
    xRetorno, xPedido : Integer;
    jsonArrayPedidos  : tjsonArray;
    jsonPedido, jsonOperacao, jsonPessoa : TjsonObject;
begin
  if RgEmbalagemTipo.ItemIndex < 0 then
     raise Exception.Create('Selectione o tipo de Etiquetas para Impressão.');
  BtnImprimirStand.Enabled := False;
  BtnImprimirStand.Grayed  := True;
  LstPedidosAdv.RowCount   := 1;
  JsonArrayPedidos         := JsonPedidoCubagem.Get(0).GetValue<TJsonArray>('pedido'); //ReturnArrayJson.GetValue<tJsonArray>('Pedido');
  if jsonArrayPedidos.Count >= 1 then Begin
  //for xRetorno := 1 to LstPedidosAdv.RowCount - 1 do
  //  LstPedidosAdv.AddDataImage(8, xRetorno, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    xRetorno := 0;
    For xPedido := 0 to Pred(jsonArrayPedidos.Count) do Begin
      jsonPedido   := jsonArrayPedidos.Items[xPedido] as TJSONObject;
      if (1=1) then Begin //((jsonPedido.GetValue<integer>('processoid') < 3) and (RbProcesso.ItemIndex = 0)) or
         //((jsonPedido.GetValue<integer>('processoid') > 2) and (RbProcesso.ItemIndex > 0)) then Begin
         LstPedidosAdv.RowCount := LstPedidosAdv.RowCount+1;
         LstPedidosAdv.FixedRows := 1;
         LstPedidosAdv.Cells[0, xRetorno+1]    := jsonPedido.GetValue<String>('pedidoid');
         LstPedidosAdv.Cells[4, xRetorno+1]    := jsonPedido.GetValue<String>('processoetapa');

         jsonOperacao := jsonPedido.GetValue<tJsonObject>('operacaotipo');
         LstPedidosAdv.AddDataImage(8, xRetorno+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
         LstPedidosAdv.Cells[1, xRetorno+1]    := jsonOperacao.GetValue<String>('descricao');

         jsonPessoa   := jsonPedido.GetValue<tJsonObject>('pessoa');
         LstPedidosAdv.Cells[2, xRetorno+1]    := jsonPessoa.GetValue<String>('codpessoaerp');
         LstPedidosAdv.Cells[3, xRetorno+1]    := jsonPessoa.GetValue<String>('fantasia');
         LstPedidosAdv.Cells[5, xRetorno+1]    := jsonPedido.GetValue<Integer>('qtdproduto').ToString();
         LstPedidosAdv.Cells[6, xRetorno+1]    := jsonPessoa.GetValue<String>('rotaid')+' '+
                                                  Copy(JsonPessoa.GetValue<String>('rota'), 1, 20); //.ToString();
         LstPedidosAdv.Cells[7, xRetorno+1]    := '1';
         LstPedidosAdv.AddDataImage(7, xRetorno+1, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);

         LstPedidosAdv.FontStyles[0, xRetorno+1] := [FsBold];
         LstPedidosAdv.Alignments[0, xRetorno+1] := taRightJustify;
         LstPedidosAdv.Alignments[5, xRetorno+1] := taRightJustify;
         LstPedidosAdv.Alignments[6, xRetorno+1] := taRightJustify;
         LstPedidosAdv.Alignments[7, xRetorno+1] := taCenter;
         LstPedidosAdv.Alignments[0, 0] := taRightJustify;
         LstPedidosAdv.FontStyles[0, 0] := [fsBold];
         LstPedidosAdv.Alignments[2, 0] := taRightJustify;
         LstPedidosAdv.Alignments[5, 0] := taRightJustify;
         LstPedidosAdv.Alignments[6, 0] := taLeftJustify;
         LstPedidosAdv.Alignments[7, 0] := taCenter;
         Inc(xRetorno);
         jsonPedido   := Nil;
         jsonOperacao := Nil;
         jsonPessoa   := Nil;
      End;
    End;
    BtnImprimirStand.Grayed  := False;
    BtnImprimirStand.Enabled := True;
  End;
//End;
  jsonArrayPedidos := Nil;
end;
}
procedure TFrmPrintTag.PesqDados_EtqArmazenamgem;
Var ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    pDtInicio, pDtTermino : TDateTime;
    vErro : String;
begin
  inherited;
  if (EdtDtInicio.Text='') and (EdtDtTermino.Text='') and (EdtPedidoId.Text='') and
     (EdtDocumentoNr.Text='') and (EdtZonaId.Text='') and (EdtCodProduto.Text='') then Begin
     ShowErro('Aplique um filtro para pesquisa!');
     Exit;
  End;
  if EdtDtInicio.Text <> '  /  /    ' then
     pDtInicio := StrToDate(EdtDtInicio.Text)
  Else pDtInicio := 0;
  if EdtDtTermino.Text <> '  /  /    ' then
     pDtTermino := StrToDate(EdtDtTermino.Text)
  Else pDtTermino := 0;
  ImprimirExportar(False);
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno  : Integer;
    begin
      ObjEntradaCtrl := TEntradaCtrl.Create;
      JsonArrayRetorno := ObjEntradaCtrl.GetEtiquetaArmazenagem(pDtInicio, pDtTermino, StrToIntDef(EdtPedidoIdTag.Text, 0),
                          EdtDocumentoNr.Text, StrToIntDef(EdtZonaId.Text, 0), StrToIntDef(EdtCodProduto.Text, 0), 1);
      if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
         ShowErro('Erro: '+vErro);
         JsonArrayRetorno := Nil;
         ObjEntradaCtrl   := Nil;
         Exit;
      End
      Else Begin
        If FDMemTagArmazenagem.Active then
           FDMemTagArmazenagem.EmptyDataSet;
        FDMemTagArmazenagem.Close;
        FDMemTagArmazenagem.LoadFromJSON(JsonArrayRetorno, False);
        FDMemTagArmazenagem.Open;
        MontaListaEtqArmazenagem;
      End;
      JsonArrayRetorno := Nil;
      ObjEntradaCtrl := Nil;
    End);
end;

procedure TFrmPrintTag.PesquisarVolumes;
Var vDtInicio, vDtFinal : TDateTime;
    //jsonPedidoCubagem   : tjsonArray;
    vErro : String;
    vRecebido, vCubagem, vEtiqueta, vPrintTag, vEmbalagem : Integer;
begin
  if RgEmbalagemTipo.ItemIndex < 0 then
     raise Exception.Create('Selectione o tipo de Etiquetas para Impressão.');
  If (EdtPedidoId.Text<>'') and (StrToIntDef(EdtPedidoId.Text, 0) = 0) then Begin
     ShowErro('código de Pedido inválido!');
     exit;
  End;
  If (EdtPedidoVolumeId.Text<>'') and (StrToIntDef(EdtPedidoVolumeId.Text, 0) = 0) then Begin
     ShowErro('código de Volume inválido!');
     exit;
  End;
  If (EdtDestinatario.Text<>'') and (StrToIntDef(EdtDestinatario.Text, 0) = 0) then Begin
     ShowErro('código de Volume inválido!');
     exit;
  End;
  if EdtDtInicial.Text = '  /  /    ' then vDtInicio := 0
  Else vDtInicio := StrToDate(EdtDtInicial.Text);
  If EdtDtFinal.Text = '  /  /    ' then Begin
     vdtFinal := 0;
     if EdtDtInicial.Text <> '  /  /    ' then
        vDtFinal := vDtInicio;
  End
  Else vDtFinal  := StrToDate(EdtDtFinal.text);
  if (StrToIntDef(EdtRota.Text, 0) > 0) and (StrToIntDef(EdtRotaFinal.Text, 0) = 0) then
     EdtRotaFinal.Text := EdtRota.Text;
  if (StrToIntDef(EdtRotaFinal.Text, 0) < StrToIntDef(EdtRota.Text, 0)) then Begin
     EdtRotaFinal.SetFocus;
     ShowErro('Rota Final inválida!!!');
     Exit;
  End;
  if EdtPedidoVolumeId.Text <> '' then Begin
     vPrintTag := 2;
     //vEmbalagem := 2;
  End
  Else Begin
     vPrintTag  := RbProcesso.ItemIndex;
  End;
  vEmbalagem := rgEmbalagemTipo.ItemIndex;
  LstPedidosAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
  LstVolumesFilterAdv.ClearRect(0, 1, LstVolumesFilterAdv.ColCount-1, LstVolumesFilterAdv.RowCount-1);
  LstPedidosAdv.RowCount       := 1;
  LstVolumesFilterAdv.RowCount := 1;
  //Sleep(vTimeEtiqueta);
  vRecebido := 1;
  if EdtPedidoVolumeId.Text <> '' then Begin
     vCubagem := 0;
    vEtiqueta := 0;
  End
  Else Begin
    vCubagem := 1;
    vEtiqueta := 1;
  End;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    begin
//      JsonPedidoCubagem := ObjPedidoCtrl.PedidoProcessar(StrToIntDef(EdtPedidoId.Text, 0),
//                           StrToIntDef(edtDestinatario.Text, 0), vPessoaId, vDtInicio, vDtFInal,
//                           '', '', '', StrToIntDef(EdtRota.Text, 0), StrToIntDef(EdtRotaFinal.Text, 0),
//                           StrToIntDef(EdtZonaIdVolume.Text, 0), 0, 0, vCubagem, vEtiqueta, True, 2, 0, 0, 0, '', vPrintTag, vEmbalagem);
      JsonPedidoCubagem := ObjPedidoCtrl.PedidoPrintTag(StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtPedidoVolumeId.Text, 0),
                           StrToIntDef(edtDestinatario.Text, 0), vPessoaId, vDtInicio, vDtFInal,
                           '', StrToIntDef(EdtRota.Text, 0), StrToIntDef(EdtRotaFinal.Text, 0),
                           StrToIntDef(EdtZonaIdVolume.Text, 0), vPrintTag, vEmbalagem);
      if JsonPedidoCubagem.Items[0].tryGetValue<String>('Erro', vErro) then Begin
         ShowErro(vErro);
         JsonPedidoCubagem := Nil;
         raise Exception.Create('Erro: '+vErro);
      End
      Else Begin
        FdMemPesqGeral.LoadFromJSON(JsonPedidoCubagem, False);
        MontaListaPedido;
      end;
      JsonPedidoCubagem := Nil;
  End);
end;

procedure TFrmPrintTag.PrintEtiquetaPorRua(TagVolumeOrdem : Integer);
Var xPedido, xEtiquetas, xEtiquetaPrint : Integer;
    vProcessoId, vEmbalagemId : Integer;
    pJsonEtiqueta, pJsonPedido : TJsonObject;
    pJsonArrayPedido, ReturnEtiquetaArray : TJsonArray;
    ObjPedidoVolumeCtrl : TPedidoVOlumeCtrl;
    vErro : String;
    vPedidoVolumeId, vCaixaEmbalagemId : Integer;
    pPedidoId, pPedidoVolumeId, pSequencia, pCodPessoaERP, vItens, vTotUnid, pProcessoId, pRotaId, vTotalVolumes : Integer;
    prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal, pMascara : String;
begin
  if RbProcesso.ItemIndex = 0 then
     vProcessoid := 2
  Else if RbProcesso.ItemIndex = 1 then
     vProcessoid := 3
  Else if RbProcesso.ItemIndex = 2 then
     vProcessoid := 0;
  if RgEmbalagemTipo.ItemIndex = 0 then
     vEmbalagemid := 1
  Else if RgEmbalagemTipo.ItemIndex = 1 then
     vEmbalagemid := 2
  Else if RgEmbalagemTipo.ItemIndex = 2 then
     vEmbalagemid := 0;
  pJsonEtiqueta    := TJsonObject.Create;
  pJsonArrayPedido := TJsonArray.Create;
  pJsonEtiqueta.AddPair('processoid', TJsonNumber.Create(vProcessoId));
  pJsonEtiqueta.AddPair('embalagemid', TJsonNumber.Create(vEmbalagemId));
  pJsonEtiqueta.AddPair('zonaid', TJsonNumber.Create(StrToIntDef(EdtZonaIdVolume.Text, 0)));
  pJsonEtiqueta.AddPair('tagvolumeordem', TJsonNumber.Create(TagVolumeOrdem));
  For xPedido := 1 to Pred(LstPedidosAdv.RowCount) do  Begin
    if LstPedidosAdv.Cells[7, xPedido] = '1' then Begin
       pJsonPedido := TJsonObject.Create;
       pJsonPedido.AddPair('pedidoid', TJsonNumber.Create(LstPedidosAdv.Cells[0, xPedido].tointeger));
       pJsonArrayPedido.AddElement(pJsonPedido);
    End;
  end;
  if pJsonArrayPedido.Count < 1 then
     ShowErro('Nenhum pedido selecionado para impressão!')
  Else begin
    TDialogMessage.ShowWaitMessage('Impressão Etiquetas Por Rua. Conectado com servidor...',
      procedure
      begin
        pJsonEtiqueta.AddPair('pedido', pJsonArrayPedido);
        ObjPedidoVolumeCtrl := TPedidoVOlumeCtrl.Create;
        ReturnEtiquetaArray := ObjPedidoVolumeCtrl.PrintEtiquetaPorRua(pJsonEtiqueta);
        if ReturnEtiquetaArray.Items[0].TryGetValue('Erro', vErro) then
           ShowErro('Erro: '+vErro)
        Else Begin
          If FDMemEtiquetaVolumePorRua.Active then
             FDMemEtiquetaVolumePorRua.EmptyDataSet;
          FDMemEtiquetaVolumePorRua.Close;
          FDMemEtiquetaVolumePorRua.LoadFromJSON(ReturnEtiquetaArray, False);
          if Not FDMemEtiquetaVolumePorRua.Active then
             FDMemEtiquetaVolumePorRua.Open;
          xEtiquetas     := StrToInt(LblTotEtiquetasVolume.Caption);
          xEtiquetaPrint := 0;
          while Not FDMemEtiquetaVolumePorRua.Eof do Begin
            Try
              if (FDMemEtiquetaVolumePorRua.FieldByName('EmbalagemId').AsInteger <> 0) then Begin
                 pPedidoId          := FDMemEtiquetaVolumePorRua.FieldByName('pedidoid').AsInteger;
                 pDocumentoOriginal := FDMemEtiquetaVolumePorRua.FieldByName('documentooriginal').AsString;
                 pDtPedido          := FDMemEtiquetaVolumePorRua.FieldByName('dtpedido').AsString;
                 pPedidoVolumeId    := FDMemEtiquetaVolumePorRua.FieldByName('pedidovolumeid').AsInteger;
                 pSequencia         := FDMemEtiquetaVolumePorRua.FieldByName('sequencia').AsInteger;
                 pCodPessoaERP      := FDMemEtiquetaVolumePorRua.FieldByName('codpessoaerp').AsInteger;
                 prazao             := FDMemEtiquetaVolumePorRua.FieldByName('fantasia').AsString;
                 pRotaId            := FDMemEtiquetaVolumePorRua.FieldByName('rotaid').AsInteger;
                 protas             := FDMemEtiquetaVolumePorRua.FieldByName('rotas').AsString;
                 pProcessoId        := FDMemEtiquetaVolumePorRua.FieldByName('processoid').AsInteger;
                 pMascara           := FDMemEtiquetaVolumePorRua.FieldByName('mascara').AsString;
                 vPredIni           := copy(EnderecoMask(FDMemEtiquetaVolumePorRua.FieldByName('Inicio').AsString,
                                                         FDMemEtiquetaVolumePorRua.FieldByName('mascara').AsString, True), 1, 5);
                 vPredFin           := copy(EnderecoMask(FDMemEtiquetaVolumePorRua.FieldByName('Termino').AsString,
                                                         FDMemEtiquetaVolumePorRua.FieldByName('mascara').AsString, True), 1, 5);
                 vItens             := FDMemEtiquetaVolumePorRua.FieldByName('itens').AsInteger;
                 vTotUnid           := FDMemEtiquetaVolumePorRua.FieldByName('qtdsuprida').AsInteger;
                 vTotalVolumes      := FDMemEtiquetaVolumePorRua.FieldByName('totalvolumes').AsInteger;
                 TagVolumeFracionado8x10etqEpl2(pPedidoid, pPedidoVolumeId, pSequencia, pCodPessoaERP,
                                                FDMemEtiquetaVolumePorRua.FieldByName('ordem').AsInteger, vItens,
                                                vTotUnid, prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal,
                                                pProcessoId, pRotaId, vTotalVolumes);
              End
              Else Begin
                if FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 0 then //Padrão eXactWMS
                   TagVolumeCaixaFechada8x10etqEpl2(FDMemEtiquetaVolumePorRua.FieldByName('pedidovolumeid').AsInteger)
                Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 1 then //Padrão eXactWMS com Endereço
                   TagVolumeCaixaFechada_Address_8x10etqEpl2(FDMemEtiquetaVolumePorRua.FieldByName('pedidovolumeid').AsInteger)
                Else If FrmeXactWMs.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 2 then //Destaque para Cliente e Rota
                   TagVolumeCaixaFechada_RotaClienteDestaque_8x10etqEpl2(FDMemEtiquetaVolumePorRua.FieldByName('pedidovolumeid').AsInteger);
                //PrintTagVolumeCxaFechada8x10etqEpl2;
              End;
              Inc(xEtiquetaPrint);
              LblEtiquetas.Caption := 'Imprimindo: '+xEtiquetaPrint.ToString()+' de '+xEtiquetas.ToString;
              LblTotEtiquetasVolume.Caption := '';
              Application.ProcessMessages;
              ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := FDMemEtiquetaVolumePorRua.FieldByName('PedidoVolumeId').AsInteger;
              if FDMemEtiquetaVolumePorRua.FieldByName('ProcessoId').AsInteger < 3 then Begin
                 Try
                   If not ObjPedidoVolumeCtrl.RegistrarDocumentoEtapa(3) then
                      showErro('Volume: '+pPedidoVolumeId.ToString+' s/registro de impressão!');;
                 Except On E: Exception do
                   showErro('Erro: Volume: '+pPedidoVolumeId.ToString+' s/registro de impressão!');
                 End;
              End;
              FDMemEtiquetaVolumePorRua.Next;
            Except ON E: Exception do Begin
              showErro(E.Message+'  Etiqueta: '+pPedidoVolumeId.ToString());
              Sleep(vTimeEtiqueta);
              End
            End;
          End;
          Application.MessageBox('Processo finalizado... ', 'Impressão de TAG.', MB_OK);
          LblEtiquetas.Caption := 'Etiquetas: ';
          LblTotEtiquetasVolume.Caption := '0';
          ClearLstVolumes;
        End;
        ReturnEtiquetaArray := Nil;
        ObjPedidoVolumeCtrl.Free;
      End);
  end;
  pJsonEtiqueta.Free;
end;

procedure TFrmPrintTag.PrintTagArmazenagem;
Var xPed, Lin, EtqPrint : Integer;
    JsonArrayRetorno : TJsonArray;
    Start : Boolean;
    ObjEntradaEtqCtrl : TEntradaCtrl;
    vErro : String;

{
      Procedure PrintTagArmazenagem8x10etqEpl2(pJsonArray : TJsonArray);
      Var xJsonEtq, xEtq, EtqCxaFechada : Integer;
        Procedure PrintEtq(JsonEtq : TJsonObject; pQuant : Integer);
        Begin
          ACBrETQConfig.DPI             := TACBrETQDPI(0);
          Try
            ConfigACBrETQ;
            ACBrETQConfig.DPI           := TACBrETQDPI(0);
            With ACBrETQConfig do Begin
              Ativar;
              Lin := 5;
    //PedidoId	DocumentoNr	Data	CodPessoaERP	Razao	Fantasia	QtdItens	(Nenhum nome de coluna)
    //          ImprimirCaixa(LinIni, ColIni, Largura(col), Altura(Lin), Espessura 1, Espessura 1);
              ImprimirCaixa(Lin,  5, 50, 14, 0, 0);
              ImprimirCaixa(Lin, 55, 45, 14, 0, 0);
              ImprimirTexto(orNormal, 3, 1, 1, Lin+2,  7, JsonEtq.GetValue<String>('zona'), 0, True);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+6,  7, 'Impressão:', 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+9, 18, DateToStr(Date()), 0, False);
              ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+2, 60, JsonEtq.GetValue<String>('codproduto'), 8, becSIM);
    //Produto
              ImprimirCaixa(Lin+15, 5, 95, 12, 0, 0);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+16, 7, 'Produto', 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+19, 7, Copy(JsonEtq.GetValue<String>('descricao'), 1, 30), 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+23, 7, COpy(JsonEtq.GetValue<String>('descricao'), 31, 30)+'TESTE', 0, False);
    //Lote
              ImprimirCaixa(Lin+28, 5, 95, 9, 0, 0);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+29,  7, 'Lote', 0, False);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 37, 'Fabricação', 0, False);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 57, 'Vencimento', 0, False);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+29, 80, 'Quantidade', 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+32,  7, JsonEtq.GetValue<String>('descrlote'), 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+32, 37, JsonEtq.GetValue<String>('fabricacao'), 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+32, 57, JsonEtq.GetValue<String>('vencimento'), 0, False);
              ImprimirTexto(orNormal, 2, 2, 2, Lin+32, 74, Repl(' ',6-Length(pQuant.ToString))+pQuant.ToString, 0, False);

    //Fornecedor - Pedido
              ImprimirCaixa(Lin+39, 5, 95, 17, 0, 0);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+40,  7, 'Documento', 0, False);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+40, 45, 'Data', 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+43,  7, JsonEtq.GetValue<String>('documentonr'), 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+43, 45, JsonEtq.GetValue<String>('data'), 0, False);

              ImprimirTexto(orNormal, 2, 1, 1, Lin+48, 7, 'Fornecedor', 0, False);
              ImprimirTexto(orNormal, 2, 1, 2, Lin+51, 7, Copy(JsonEtq.GetValue<String>('fantasia'), 1, 60), 0, False);

              ImprimirTexto(orNormal, 2, 1, 1, Lin+57, 7, 'Picking', 0, False);
              ImprimirTexto(orNormal, 4, 3, 4, Lin+60, 7, EnderecoMask(JsonEtq.GetValue<String>('endereco'), JsonEtq.GetValue<String>('mascara'), True), 0, False);

              ImprimirTexto(orNormal, 2, 1, 1, 72, 82, 'eXactWMS®', 0, False);
              FinalizarEtiqueta;
              Imprimir(SpCopias.Value, 0);
              Sleep(150);
              Desativar;
            End;
          Except On E: Exception do Begin
            ShowErro('Erro: Problema de comunicação com impressora...'+#13+E.Message);
            End;
          End;
        End;
      Begin
        for xJsonEtq := 0 to Pred(pJsonArray.Count) do Begin
          //Caixa Fechada
          for EtqCxaFechada := 1 to pJsonArray.Items[0].GetValue<Integer>('qtdcxafechada') do
            PrintEtq(pJsonArray.Items[0] as TJsonObject, pJsonArray.Items[0].GetValue<Integer>('fatorconversao'));
          //Fracionados
          if pJsonArray.Items[0].GetValue<Integer>('qtdfracionada') > 0 then
             PrintEtq(pJsonArray.Items[0] as TJsonObject, pJsonArray.Items[0].GetValue<Integer>('qtdfracionada'));
        End;

      End
}
begin
  Start    := True;
  EtqPrint := 0;
  for xPed := 1 to Pred(LstTagArmazenagem.RowCount) do Begin
    ObjEntradaEtqCtrl := TEntradaCtrl.Create;
    if LstTagArmazenagem.Cells[8, xPed] = '1' then Begin
       JsonArrayRetorno  := ObjEntradaEtqCtrl.GetEtiquetaArmazenagem(0, 0, StrToIntDef(LstTagArmazenagem.Cells[0, xPed], 0),
                            EdtDocumentoNr.Text, StrToIntDef(EdtZonaId.Text, 0), StrToIntDef(EdtCodProduto.Text, 0), 0);
       if not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
          PrintTagArmazenagem8x10etqEpl2( JsonArrayRetorno );
          Inc(EtqPrint);
       End;
       JsonArrayRetorno := Nil;
       //ObjEntradaEtqCtrl.Free;
    End;
  End;
  if EtqPrint = 0 then
     ShowErro('Não foram impressas etiquetas.')
  Else ShowOk('Impressas '+EtqPrint.ToString+' etiquetas!');
end;

procedure TFrmPrintTag.PrintTagVolumeCxaFechada8x10etqEpl2; //Modelo 0 (Zero)
Var Lin : INteger;
    vEndereco, vVolumeCodBarra : String;
    vErro : Boolean;
begin
  Repeat
    Try
//      ConfigACBrETQ;
      ACBrETQConfig.Temperatura := 15;
      With ACBrETQConfig do Begin
        Ativar;
        IniciarEtiqueta;
        If FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 1 then Begin
           ACBrETQConfig.DPI         := TACBrETQDPI(0);
           Lin := 5;
           ImprimirTexto(orNormal, 2, 2, 2, Lin,  5, 'CAIXA FECHADA', 0, True);
           if (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString <> 'PULMAO') and
              (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString <> 'ARMAZENAGEM') then
              ImprimirTexto(orNormal, 3, 1, 1, Lin, 54, FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString, 0, True);
           ImprimirTexto(orNormal, 3, 1, 1, Lin+6, 5,  'Pedido/Vol:', 0, False);

           ImprimirTexto(orNormal, 2, 2, 2, Lin+6, 27,  FDMemEtiquetaVolumePorRua.FieldByName('pedidoid').Asstring+'/'+
                                                        FDMemEtiquetaVolumePorRua.FieldByName('sequencia').AsString, 0, False);
           ImprimirTexto(orNormal, 2, 2, 2, Lin+6, 67,  FDMemEtiquetaVolumePorRua.FieldByName('dtpedido').AsString, 0, False);

           ImprimirCaixa(Lin+11, 5, 93, 12, 1, 1);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+13,  7, 'Destino:', 0, False);
           ImprimirTexto(orNormal, 1, 2, 2, Lin+13, 20, FDMemEtiquetaVolumePorRua.FieldByName('codpessoaerp').AsString+' '+
                                                        FDMemEtiquetaVolumePorRua.FieldByName('fantasia').AsString, 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+17,  7, '   Rota:', 0, False);
           ImprimirTexto(orNormal, 3, 2, 2, Lin+17, 20, FDMemEtiquetaVolumePorRua.FieldByName('rotaid').AsString, 0, False);
           ImprimirTexto(orNormal, 1, 2, 2, Lin+18, 28, FDMemEtiquetaVolumePorRua.FieldByName('rotas').AsString, 0, False);
           //ImprimirTexto(orNormal, 2, 1, 1, Lin+19, 60, 'Cidade', 0, False);
           Lin := 28;
           ImprimirCaixa(27, 5, 95, 10, 0, 0);
           ImprimirTexto(orNormal, 2, 1, 1, Lin  , 7, 'Produto', 0, False);
           ImprimirTexto(orNormal, 1, 2, 2, Lin+3, 7, FDMemEtiquetaVolumePorRua.FieldByName('codproduto').AsString+' '+
                                                      Copy(FDMemEtiquetaVolumePorRua.FieldByName('descricao').AsString, 1, 30), 0, False);
           ImprimirTexto(orNormal, 1, 2, 2, Lin+6, 7, '       '+COpy(FDMemEtiquetaVolumePorRua.FieldByName('descricao').AsString, 31, 30), 0, False);
           ImprimirCaixa(Lin+10,  5, 32, 9, 0, 0);
           ImprimirCaixa(Lin+10, 40, 27, 9, 0, 0);
           ImprimirCaixa(Lin+10, 64, 29, 9, 0, 0);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+11,  7, 'Lote', 0, False);
           if Length(FDMemEtiquetaVolumePorRua.FieldByName('lote').AsString) <= 10 then
              ImprimirTexto(orNormal, 2, 2, 2, Lin+14,  7, FDMemEtiquetaVolumePorRua.FieldByName('lote').AsString, 0, False)
           Else ImprimirTexto(orNormal, 1, 2, 2, Lin+14,  7, FDMemEtiquetaVolumePorRua.FieldByName('lote').AsString, 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+11, 42, ' Vencto', 0, False);
           ImprimirTexto(orNormal, 2, 2, 2, Lin+14, 42, Copy(FDMemEtiquetaVolumePorRua.FieldByName('vencimento').AsString, 4, 7), 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+11, 68, 'Qtd', 0, False);
           ImprimirTexto(orNormal, 4, 2, 2, Lin+12, 78, FormatFloat('###0', FDMemEtiquetaVolumePorRua.FieldByName('qtdsuprida').AsInteger), 0, False);

           ImprimirTexto(orNormal, 2, 1, 1, Lin+20,  7, 'Rua  Prédio   Nível  Apto', 0, False);
           vEndereco := FDMemEtiquetaVolumePorRua.FieldByName('Inicio').AsString;
           if (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString = 'Stage - Docas') then
              ImprimirTexto(orNormal, 3, 2, 2, Lin+23,  7, 'STAGE', 0, False)
           Else If (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString = 'AREA DE ESPERA') then    //Passar o Codigo da Zona
              ImprimirTexto(orNormal, 3, 2, 2, Lin+23,  7, 'AREA DE ESPERA', 0, False)
           Else
              ImprimirTexto(orNormal, 3, 2, 2, Lin+23,  7, copy(vEndereco,1,2)+' '+Copy(vEndereco, 3, 2)+' '+
                                                           Copy(vEndereco,5,2)+' '+Copy(vEndereco,7,3), 0, False);
           ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+20, 64, FDMemEtiquetaVolumePorRua.FieldByName('pedidovolumeid').AsString, 8, becSIM);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+28,  7, 'Picking: '+FDMemEtiquetaVolumePorRua.FieldByName('picking').AsString, 0, False);
           Lin := 62;
           ImprimirCaixa(60, 5, 93, 15, 1, 1);
           ImprimirTexto(orNormal, 2, 1, 1, Lin,  7, 'Obs: ', 0, False);
           if FDMemEtiquetaVolumePorRua.FieldByName('processoid').AsInteger < 3 then
              ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  7, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                   DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
           Else ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  7, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                   DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+6,  7, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+9,  7, 'Ressuprimento: '+FDMemEtiquetaVolumePorRua.FieldByName('documentooriginal').AsString, 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+9, 80, 'eXactWMS(r)', 0, False);
        End
        Else If FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 2 then Begin
           ACBrETQConfig.DPI := TACBrETQDPI(1);
           Lin := 2;
           ImprimirTexto(orNormal, 2, 2, 2, Lin,  2, 'CAIXA FECHADA', 0, True);
           if (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString <> 'PULMAO') and
              (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString <> 'ARMAZENAGEM') then
           ImprimirTexto(orNormal, 3, 1, 1, Lin, 30, FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString, 0, True);
           ImprimirTexto(orNormal, 3, 1, 1, Lin+4, 2,  'Pedido', 0, False);
           ImprimirTexto(orNormal, 3, 1, 1, Lin+4, 20, 'Volume', 0, False);
           ImprimirTexto(orNormal, 3, 1, 1, Lin+4, 40, 'Data', 0, False);
           ImprimirTexto(orNormal, 2, 2, 2, Lin+4, 28, FDMemEtiquetaVolumePorRua.FieldByName('sequencia').AsString, 0, False);
           ImprimirTexto(orNormal, 2, 2, 2, Lin+4, 48, FDMemEtiquetaVolumePorRua.FieldByName('dtpedido').AsString, 0, False);
           ImprimirTexto(orNormal, 2, 2, 2, Lin+7,  2, FDMemEtiquetaVolumePorRua.FieldByName('pedidoid').Asstring, 0, False);

           ImprimirCaixa(Lin+10,  2, 25,  9, 0, 0);
           ImprimirCaixa(Lin+8,  30, 37, 10, 0, 0);
           ImprimirTexto(orNormal, 2,  1, 1, Lin+11,  4, 'Rota', 0, False);
           ImprimirTexto(orNormal, 2,  1, 1, Lin+9, 30, 'Destino', 0, False);
           ImprimirTexto(orNormal, 4,  3, 4, Lin+11, 10, FDMemEtiquetaVolumePorRua.FieldByName('rotaid').AsString, 0, False);
           ImprimirTexto(orNormal, 4,  5, 5, Lin+9, 37, FDMemEtiquetaVolumePorRua.FieldByName('codpessoaerp').AsString, 0, False);
           ImprimirTexto(orNormal, 2,  1, 1, Lin+20, 4, Copy(FDMemEtiquetaVolumePorRua.FieldByName('fantasia').AsString, 1, 60)+' - '+
                                                     FDMemEtiquetaVolumePorRua.FieldByName('rotas').AsString, 0, False);
           Lin := 24;
           ImprimirCaixa(Lin, 2, 65, 5, 0, 0);
           ImprimirTexto(orNormal, 2, 1, 1, Lin,   4, ' Produto ', 0, False);
           ImprimirTexto(orNormal, 2, 1, 2, Lin+2, 4, FDMemEtiquetaVolumePorRua.FieldByName('codproduto').AsString+' '+
                                                      Copy(FDMemEtiquetaVolumePorRua.FieldByName('descricao').AsString, 1, 60), 0, False);

           ImprimirCaixa(Lin+6,  2, 27, 6, 0, 0);
           ImprimirCaixa(Lin+6, 32, 15, 6, 0, 0);
           ImprimirCaixa(Lin+6, 50, 17, 6, 0, 0);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+7,  4, 'Lote', 0, False);
           if Length(FDMemEtiquetaVolumePorRua.FieldByName('lote').AsString) <= 12 then
              ImprimirTexto(orNormal, 2, 2, 2, Lin+9,  4, FDMemEtiquetaVolumePorRua.FieldByName('lote').AsString, 0, False)
           Else ImprimirTexto(orNormal, 1, 2, 2, Lin+9,  4, Copy(FDMemEtiquetaVolumePorRua.FieldByName('lote').AsString, 1, 12), 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+7, 32, ' Vencto', 0, False);
           ImprimirTexto(orNormal, 2, 2, 2, Lin+9, 32, Copy(FDMemEtiquetaVolumePorRua.FieldByName('vencimento').AsString, 4, 7), 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+7, 52, 'Qtd', 0, False);
           ImprimirTexto(orNormal, 4, 2, 2, Lin+8, 55, FormatFloat('###0', FDMemEtiquetaVolumePorRua.FieldByName('qtdsuprida').AsInteger), 0, False);

           ImprimirTexto(orNormal, 2, 1, 1, Lin+13,  4, 'Rua  Prédio   Nível    Apto', 0, False);
           vEndereco := FDMemEtiquetaVolumePorRua.FieldByName('Inicio').AsString;
           if (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString = 'Stage - Docas') then
              ImprimirTexto(orNormal, 3, 2, 2, Lin+15,  4, 'STAGE', 0, False)
           Else If (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString = 'AREA DE ESPERA') then    //Passar o Codigo da Zona
              ImprimirTexto(orNormal, 3, 2, 2, Lin+15,  4, 'AREA DE ESPERA', 0, False)
           Else
              ImprimirTexto(orNormal, 3, 2, 2, Lin+15,  4, copy(vEndereco,1,2)+' '+Copy(vEndereco, 3, 2)+' '+
                                                           Copy(vEndereco,5,2)+' '+Copy(vEndereco,7,3), 0, False);
           vVolumeCodBarra := FDMemEtiquetaVolumePorRua.FieldByName('pedidovolumeid').AsString;
           ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+13, 45, vVolumeCodBarra, 5, becNAO);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+18, (45 + Trunc((20-Length(vVolumeCodBarra))/2)), vVolumeCodBarra, 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+18,  4, 'Picking: '+FDMemEtiquetaVolumePorRua.FieldByName('picking').AsString, 0, False);
           Lin := 42;

           ImprimirCaixa(Lin+2, 2, 65, 8, 0, 0);
           if FDMemEtiquetaVolumePorRua.FieldByName('processoid').AsInteger < 3 then
              ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  4, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                   DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
           Else ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  4, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                   DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+5,  4, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
           ImprimirTexto(orNormal, 2, 1, 1, Lin+7,  4, 'Ressuprimento: '+FDMemEtiquetaVolumePorRua.FieldByName('documentooriginal').AsString, 0, False);

           ImprimirTexto(orNormal, 2, 1, 1, Lin+7, 55, 'eXactWMS(r)', 0, False);

        End;
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
      End;
      vErro := False;
    Except On E: Exception do Begin
      vErro := True;
      if (Confirmacao('Erro Impressora!', 'Reimprime Volume: '+FDMemEtiquetaVolumePorRua.FieldByName('pedidovolumeid').AsString+'?')) then
         vErro := True //ShowErro('Erro: Problema de comunicação com impressora...');
      Else vErro := False;

      End;
    End;
  Until vErro = False;
end;

procedure TFrmPrintTag.RbProcessoClick(Sender: TObject);
begin
  inherited;
  LstPedidosAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
  LstVolumesFilterAdv.ClearRect(0, 1, LstVolumesFilterAdv.ColCount-1, LstVolumesFilterAdv.RowCount-1);
  LstPedidosAdv.RowCount        := 1;
  LstVolumesFilterAdv.RowCount  := 1;
  LblTotEtiquetasVolume.caption := '0';
end;

procedure TFrmPrintTag.RbRecebimentoClick(Sender: TObject);
begin
  inherited;
  PnlEtqArmazenagemEntrada.Visible    := RbRecebimento.Checked;
  PnlEtqArmazenagemIndividual.Visible := RbIndividual.Checked;
  if Sender = RbRecebimento then
     EdtDtInicio.SetFocus
  Else If Sender = RbIndividual then
     EdtCodProdutoEtqIndividual.SetFocus;
  If FDMemProdutoLotesEtqArmazenagem.Active then
     FDMemProdutoLotesEtqArmazenagem.EmptyDataSet;
  FDMemProdutoLotesEtqArmazenagem.Close;
  EdtDtInicioChange(Sender);
end;

procedure TFrmPrintTag.RgPrinterEtqIndividualClick(Sender: TObject);
begin
  inherited;
  EdtQuantidadeEstIndividual.Value   := 0;
  EdtQuantidadeEstIndividual.Visible := RgPrinterEtqIndividual.ItemIndex = 1;
  LblEstoqueLote.Visible             := EdtQuantidadeEstIndividual.Visible;
end;

procedure TFrmPrintTag.TagEndereco3x10etqEpl2;
Var xEtq     : Integer;
    vErro    : Boolean;
    vProduto : String;
    JsonProduto : TjsonObject;
    vLinha   : Integer;
begin
  inherited;
  vErro := True; //Forçar inicialização da impressão
  Try
//    ConfigACBrETQ;
    With ACBrETQConfig do Begin
      Temperatura   := vTemperatura;
      Ativar;
      For xEtq := 1 to Pred(LstEnderecoAdv.RowCount) do begin
        if LstEnderecoAdv.Cells[8, xEtq] = '1' then Begin
           Repeat
             Try
               if CbComposicao.ItemIndex = 0 then Begin
                  ImprimirTexto(orNormal, 2,           1, 1, 3,  6, ' Rua      Prédio      Nível        Apto', 0, False);
                  ImprimirTexto(orNormal, 3,           3, 3, 4,  6, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirTexto(orNormal, 2,           1, 1, 6, 22, 'eXactWMS®', 0, False);
               End
               Else if CbComposicao.ItemIndex = 3 then Begin
                  ImprimirTexto(orNormal, 4, 2, 6,  1, 2, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirBarras(orNormal, barCODE128, 3, 3, 1, 55, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 5, becNAO);
                  ImprimirTexto(orNormal, 2, 1, 1,  6, 55, 'eXactWMS®', 0, False);
               End
               Else Begin
                  //                                         L   C
                  if CbComposicao.ItemIndex = 1 then vLinha := 1
                  Else vLinha := 0;
                  if CbComposicao.ItemIndex <> 4 then Begin
                     ImprimirTexto(orNormal, 2,           1, 1, vLinha  ,  6, 'Rua   Prédio  Nível  Apto', 0, False);
                     ImprimirTexto(orNormal, 3,           2, 2, vLinha+1,  6, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  End;
                  if CbComposicao.ItemIndex = 1 then Begin
                     ImprimirBarras(orNormal, barCODE128, 4, 4, vLinha+3,  6, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 4, becNAO);
                     ImprimirTexto(orNormal, 2,           1, 1, vLinha+7, 18, 'eXactWMS®', 0, False);
                  End
                  Else if CbComposicao.ItemIndex = 4 then Begin
                     ImprimirTexto(orNormal, 2,           1, 1, vLinha  ,  3, 'Rua            Prédio          Nível             Apto', 0, False);
                     ImprimirTexto(orNormal, 4,           4, 4, vLinha+1,  1, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                     ImprimirBarras(orNormal, barCODE128, 3, 3, vLinha+5,  10, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 4, becNAO);
                     ImprimirTexto(orNormal, 2,           1, 1, vLinha+8, 18, 'eXactWMS®', 0, False);
                  End
                  Else Begin
                     ImprimirBarras(orNormal, barCODE128, 4, 4, vLinha+3,  6, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 3, becNAO);
                     ImprimirTexto(orNormal, 2,           1, 1, vLinha+5, 24, 'eXactWMS®', 0, False);
                  End;
                  if (CbComposicao.ItemIndex = 2) and (LstEnderecoAdv.Cells[10, xEtq].ToInteger()>0) then Begin
                     JsonProduto := TProdutoCtrl.GetEan(LstEnderecoAdv.Cells[10, xEtq]);
                     vProduto := LstEnderecoAdv.Cells[10, xEtq]+' '+JsonProduto.GetValue<String>('descricao');
                     ImprimirTexto(orNormal, 2,           2, 1,  7, 1, Copy(vProduto,  1, 32), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  8, 1, Copy(vProduto, 33, 32), 0, False); //Colocar o nome do produto
                  End;
               End;
               FinalizarEtiqueta;
               Imprimir(SpCopias.Value, 0);
               Sleep(vTimeEtiqueta);
               vErro := False;
             Except On E: Exception do Begin
               vErro := True;
               ShowErro('Erro: Problema de comunicação com impressora...');
               End;
             End;
           Until vErro = False;
        End;
      End;
      if ChkEtqBcoEndereco.Checked then
         Imprimir(SpCopias.Value, 0);
      Desativar;
    end;
  Except On E: Exception do
    ShowErro('Erro: Ocorreu um erro na impressão das etiquetas  Volume Caixa Fechada!'+sLineBreak+E.Message);
  End;
end;

procedure TFrmPrintTag.TagEndereco5x10etqEpl2;
Var xEtq     : Integer;
    vErro    : Boolean;
    vProduto : String;
    JsonProduto : TjsonObject;
begin
  inherited;
  vErro := True; //Forçar inicialização da impressão
  Try
//    ConfigACBrETQ;
    With ACBrETQConfig do Begin
      Ativar;
      For xEtq := 1 to Pred(LstEnderecoAdv.RowCount) do begin
        if LstEnderecoAdv.Cells[8, xEtq] = '1' then Begin
           Repeat
             Try
               if CbComposicao.ItemIndex = 0 then Begin
                  ImprimirTexto(orNormal, 2,           1, 1,  6, 6, ' Rua      Prédio     Nível      Apto', 0, False);
                  ImprimirTexto(orNormal, 3,           3, 3,  7, 6, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirTexto(orNormal, 2,           1, 1, 10, 6, 'eXactWMS®', 0, False);
               End
               Else if CbComposicao.ItemIndex = 3 then Begin
                  ImprimirTexto(orNormal, 4, 2, 6,  2, 2, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirBarras(orNormal, barCODE128, 3, 3, 2, 55, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 5, becNAO);
                  ImprimirTexto(orNormal, 2, 1, 1,  7, 55, 'eXactWMS®', 0, False);
               End               Else Begin
                  ImprimirTexto(orNormal, 2,           1, 1,  3, 6, ' Rua      Prédio     Nível      Apto', 0, False);
                  ImprimirTexto(orNormal, 3,           3, 3,  4, 6, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirBarras(orNormal, barCODE128, 4, 4,  7, 6, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 6, becNAO);
                  ImprimirTexto(orNormal, 2,           1, 1, 13, 6, 'eXactWMS®', 0, False);
                  if (CbComposicao.ItemIndex = 2) and (LstEnderecoAdv.Cells[10, xEtq].ToInteger()>0) then Begin
                     JsonProduto := TProdutoCtrl.GetEan(LstEnderecoAdv.Cells[10, xEtq]);
                     vProduto := LstEnderecoAdv.Cells[10, xEtq]+' '+JsonProduto.GetValue<String>('descricao');
                     ImprimirTexto(orNormal, 2,           2, 1,  15, 2, Copy(vProduto,  1, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  16, 2, Copy(vProduto, 31, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  17, 2, Copy(vProduto, 61, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  18, 2, Copy(vProduto, 91, 30), 0, False); //Colocar o nome do produto
                  End;
               End;
               FinalizarEtiqueta;
               Imprimir(SpCopias.Value, 0);
               Sleep(vTimeEtiqueta);
               vErro := False;
             Except On E: Exception do Begin
               vErro := True;
               ShowErro('Erro: Problema de comunicação com impressora...');
               End;
             End;
           Until vErro = False;
        End;
      End;
      if ChkEtqBcoEndereco.Checked then
         Imprimir(SpCopias.Value, 0);
      Desativar;
    end;
  Except On E: Exception do
    ShowErro('Erro: Ocorreu um erro na impressão das etiquetas  Volume Caixa Fechada!'+sLineBreak+E.Message);
  End;
end;

procedure TFrmPrintTag.TagEndereco8x10etqEpl2;
Var xEtq  : Integer;
    vErro : Boolean;
    JsonProduto : TJsonObject;
    vProduto : String;
begin
  inherited;
  vErro := True; //Forçar inicialização da impressão
  Try
//    ConfigACBrETQ;
    With ACBrETQConfig do Begin
      Temperatura := 12;
      Ativar;
      For xEtq := 1 to Pred(LstEnderecoAdv.RowCount) do begin
        if LstEnderecoAdv.Cells[8, xEtq] = '1' then Begin
           Repeat
             Try
               if CbComposicao.ItemIndex = 0 then Begin
                  ImprimirTexto(orNormal, 3,           2, 1,  9, 2, ' Rua  Prédio Nível    Apto', 0, False);
                  ImprimirTexto(orNormal, 4,           4, 3,  11, 2, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirTexto(orNormal, 2,           1, 1,  14, 6, 'eXactWMS®', 0, False);
               End
               Else if CbComposicao.ItemIndex = 3 then Begin
                  ImprimirTexto(orNormal, 4, 2, 6,  3, 2, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirBarras(orNormal, barCODE128, 3, 3, 3, 55, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 5, becNAO);
                  ImprimirTexto(orNormal, 2, 1, 1,  8, 55, 'eXactWMS®', 0, False);
               End
               Else Begin
                  ImprimirTexto(orNormal, 3,           2, 1,  3, 2, ' Rua  Prédio Nível    Apto', 0, False);
                  ImprimirTexto(orNormal, 4,           4, 3,  5, 2, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirBarras(orNormal, barCODE128, 5, 5, 10, 6, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 6, becNAO);
                  if (CbComposicao.ItemIndex = 2) and (LstEnderecoAdv.Cells[10, xEtq].ToInteger()>0) then Begin
                     JsonProduto := TProdutoCtrl.GetEan(LstEnderecoAdv.Cells[10, xEtq]);
                     vProduto := LstEnderecoAdv.Cells[10, xEtq]+' '+JsonProduto.GetValue<String>('descricao');
                     ImprimirTexto(orNormal, 2,           2, 1,  19, 2, Copy(vProduto,  1, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  20, 2, Copy(vProduto, 31, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  21, 2, Copy(vProduto, 61, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  22, 2, Copy(vProduto, 91, 30), 0, False); //Colocar o nome do produto
                     JsonProduto := Nil;
                  End;
                  ImprimirTexto(orNormal, 2,           1, 1, 16, 6, 'eXactWMS®', 0, False);
               End;
               FinalizarEtiqueta;
               Imprimir(SpCopias.Value, 0);
               Sleep(vTimeEtiqueta);
               vErro := False;
             Except On E: Exception do Begin
               vErro := True;
               ShowErro('Erro: Problema de comunicação com impressora...');
               End;
             End;
           Until vErro = False;
        End;
      End;
      if ChkEtqBcoEndereco.Checked then
         Imprimir(SpCopias.Value, 0);
      Desativar;
    end;
  Except On E: Exception do
    ShowErro('Erro: Impressão das etiquetas. Volume Caixa Fechada!'+sLineBreak+E.Message);
  End;
end;

procedure TFrmPrintTag.TagEndereco8x10etqEpl2_Localizacao_CodBarras_Lateral;
Var xEtq  : Integer;
    vErro : Boolean;
    JsonProduto : TJsonObject;
    vProduto : String;
begin
  inherited;
  vErro := True; //Forçar inicialização da impressão
  Try
//    ConfigACBrETQ;
    With ACBrETQConfig do Begin
      Ativar;
      For xEtq := 1 to Pred(LstEnderecoAdv.RowCount) do begin
        if LstEnderecoAdv.Cells[8, xEtq] = '1' then Begin
           Repeat
             Try
               if CbComposicao.ItemIndex = 0 then Begin
                  ImprimirTexto(orNormal, 3,           2, 1,  9, 2, ' Rua  Prédio Nível    Apto', 0, False);
                  ImprimirTexto(orNormal, 4,           4, 3,  11, 2, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirTexto(orNormal, 2,           1, 1,  14, 6, 'eXactWMS®', 0, False);
               End
               Else Begin
                  ImprimirTexto(orNormal, 3,           2, 1,  3, 2, ' Rua  Prédio Nível    Apto', 0, False);
                  ImprimirTexto(orNormal, 4,           4, 3,  5, 2, LstEnderecoAdv.Cells[1, xEtq], 0, False);
                  ImprimirBarras(orNormal, barCODE128, 5, 5, 10, 6, StringReplace(LstEnderecoAdv.Cells[1, xEtq], '.', '', [rfReplaceAll]), 6, becNAO);
                  if (CbComposicao.ItemIndex = 2) and (LstEnderecoAdv.Cells[10, xEtq].ToInteger()>0) then Begin
                     JsonProduto := TProdutoCtrl.GetEan(LstEnderecoAdv.Cells[10, xEtq]);
                     vProduto := LstEnderecoAdv.Cells[10, xEtq]+' '+JsonProduto.GetValue<String>('descricao');
                     ImprimirTexto(orNormal, 2,           2, 1,  19, 2, Copy(vProduto,  1, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  20, 2, Copy(vProduto, 31, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  21, 2, Copy(vProduto, 61, 30), 0, False); //Colocar o nome do produto
                     ImprimirTexto(orNormal, 2,           2, 1,  22, 2, Copy(vProduto, 91, 30), 0, False); //Colocar o nome do produto
                     JsonProduto := Nil;
                  End;
                  ImprimirTexto(orNormal, 2,           1, 1, 16, 6, 'eXactWMS®', 0, False);
               End;
               FinalizarEtiqueta;
               Imprimir(SpCopias.Value, 0);
               Sleep(vTimeEtiqueta);
               vErro := False;
             Except On E: Exception do Begin
               vErro := True;
               ShowErro('Erro: Problema de comunicação com impressora...');
               End;
             End;
           Until vErro = False;
        End;
      End;
      if ChkEtqBcoEndereco.Checked then
         Imprimir(SpCopias.Value, 0);
      Desativar;
    end;
  Except On E: Exception do
    ShowErro('Erro: Impressão das etiquetas. Volume Caixa Fechada!'+sLineBreak+E.Message);
  End;
end;

procedure TFrmPrintTag.TagVolumeCaixaFechada8x10etqEpl2(pPedidoVolumeId : Integer);
Var JsonArrayIdentVolume    : TJsonArray;
    ObjVolumeCxaFechadaCtrl : TPedidoVOlumeCtrl;
    vErro : Boolean;
    vErroStr : String;
    Lin : INteger;
    vEndereco : String;
begin
  ACBrETQConfig.DPI             := TACBrETQDPI(0);
  AcbrEtqConfig.Temperatura     := vTemperatura; //15;
  ObjVolumeCxaFechadaCtrl := TPedidoVOlumeCtrl.Create;
  JsonArrayIdentVolume := ObjVolumeCxaFechadaCtrl.IdentificaVolumeCxaFechada( pPedidoVolumeId );
  if JsonArrayIdentVolume.Items[0].TryGetValue('Erro', vErroStr) then Begin
     ShowErro(vErroStr);
  End
  Else If ((JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') <  3) and (RbProcesso.ItemIndex = 0)) or
          ((JsonArrayIdentVolume.Items[0].GetValue<Integer>('processoid') > 2) and (JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 13) and (RbProcesso.ItemIndex > 0)) or (EdtPedidoVolumeId.Text<>'') then Begin
    Try
//      ConfigACBrETQ;
      ACBrETQConfig.DPI           := TACBrETQDPI(0);
      AcbrEtqConfig.Temperatura   := 15;
      With ACBrETQConfig do Begin
        Ativar;
        Lin := 5;
        ImprimirTexto(orNormal, 2, 2, 2, Lin,  5, 'CAIXA FECHADA', 0, True);
//        if (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString <> 'PULMAO') and
//           (FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString <> 'ARMAZENAGEM') then
//           ImprimirTexto(orNormal, 3, 1, 1, Lin, 54, FDMemEtiquetaVolumePorRua.FieldByName('zona').AsString, 0, True);
        ImprimirTexto(orNormal, 3, 1, 1, Lin+6, 5,  'Pedido Vol:', 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+6, 27,  JsonArrayIdentVolume.Items[0].GetValue<String>('pedidoid')+' '+
                                                     JsonArrayIdentVolume.Items[0].GetValue<String>('sequencia')+'/'+
                                                     JsonArrayIdentVolume.Items[0].GetValue<String>('totalvolumes'), 0, False);
        ImprimirTexto(orNormal, 3, 1, 1, Lin, 55,  'Data: ', 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin, 67,  JsonArrayIdentVolume.Items[0].GetValue<String>('dtpedido'), 0, False);

        ImprimirCaixa(Lin+11, 5, 93, 12, 1, 1);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+13,  7, 'Destino:', 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+13, 20, JsonArrayIdentVolume.Items[0].GetValue<String>('codpessoaerp')+' '+JsonArrayIdentVolume.Items[0].GetValue<String>('fantasia'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+17,  7, '   Rota:', 0, False);
        ImprimirTexto(orNormal, 3, 2, 2, Lin+17, 20, JsonArrayIdentVolume.Items[0].GetValue<String>('rotaid'), 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+18, 28, JsonArrayIdentVolume.Items[0].GetValue<String>('rotas'), 0, False);
        //ImprimirTexto(orNormal, 2, 1, 1, Lin+19, 60, 'Cidade', 0, False);
        Lin := 28;
        ImprimirCaixa(27, 5, 95, 10, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin  , 7, 'Produto', 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+3, 7, JsonArrayIdentVolume.Items[0].GetValue<String>('codproduto')+' '+COpy(JsonArrayIdentVolume.Items[0].GetValue<String>('descricao'), 1, 30), 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+6, 7, '       '+COpy(JsonArrayIdentVolume.Items[0].GetValue<String>('descricao'), 31, 30), 0, False);
        ImprimirCaixa(Lin+10,  5, 32, 9, 0, 0);
        ImprimirCaixa(Lin+10, 40, 27, 9, 0, 0);
        ImprimirCaixa(Lin+10, 70, 29, 9, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+11,  7, 'Lote', 0, False);
        if Length(JsonArrayIdentVolume.Items[0].GetValue<String>('lote')) <= 10 then
           ImprimirTexto(orNormal, 2, 2, 2, Lin+14,  7, JsonArrayIdentVolume.Items[0].GetValue<String>('lote'), 0, False)
        Else ImprimirTexto(orNormal, 1, 2, 2, Lin+14,  7, JsonArrayIdentVolume.Items[0].GetValue<String>('lote'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+11, 42, ' Vencto', 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+14, 42, Copy(JsonArrayIdentVolume.Items[0].GetValue<String>('vencimento'), 4, 7), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+11, 72, 'Qtd', 0, False);
        ImprimirTexto(orNormal, 4, 2, 2, Lin+12, 82, FormatFloat('###0', JsonArrayIdentVolume.Items[0].GetValue<integer>('qtdsuprida')), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+20,  7, 'Rua  Prédio   Nível  Apto', 0, False);
        vEndereco := JsonArrayIdentVolume.Items[0].GetValue<String>('endereco');
        if (vEndereco = '00000000') or (vEndereco = 'DOCA GERAL') then
           ImprimirTexto(orNormal, 3, 2, 2, Lin+23,  7, 'STAGE', 0, False)
        Else
           ImprimirTexto(orNormal, 3, 2, 2, Lin+23,  7, copy(vEndereco,1,2)+' '+Copy(vEndereco, 3, 2)+' '+
                                                        Copy(vEndereco,5,2)+' '+Copy(vEndereco,7,3), 0, False);
        ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+20, 64, JsonArrayIdentVolume.Items[0].GetValue<String>('pedidovolumeid'), 8, becSIM);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+28,  7, 'Picking: '+JsonArrayIdentVolume.Items[0].GetValue<String>('picking'), 0, False);
        Lin := 62;
        ImprimirCaixa(60, 5, 93, 15, 1, 1);
        ImprimirTexto(orNormal, 2, 1, 1, Lin,  7, 'Obs: ', 0, False);
        if JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 3 then
           ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  7, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
        Else ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  7, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+6,  7, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+9,  7, 'Ressuprimento: '+JsonArrayIdentVolume.Items[0].GetValue<String>('documentooriginal'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+9, 75, 'eXactWMS(r)', 0, False);
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
        ObjVolumeCxaFechadaCtrl.ObjPedidoVolume.PedidoVolumeId := pPedidoVolumeId;
        if JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 3 then Begin
           Try
             ObjVolumeCxaFechadaCtrl.RegistrarDocumentoEtapa(3);
           Except On E: Exception do
             showErro('Volume: '+pPedidoVolumeId.ToString+' s/registro de impressão!');
           End;
        End;
//        FreeAndNil(ObjVolumeCxaFechadaCtrl);
      End;
    Except On E: Exception do Begin
      vErro := True;
      ShowErro('Erro: Problema de comunicação com impressora... '+E.Message);
      End;
    End;
  end;
  JsonArrayIdentVolume := Nil;
  ObjVolumeCxaFechadaCtrl.Free;
end;

procedure TFrmPrintTag.TagVolumeCaixaFechada_Address_8x10etqEpl2(
  pPedidoVolumeId: Integer);
Var JsonArrayIdentVolume    : TJsonArray;
    ObjVolumeCxaFechadaCtrl : TPedidoVOlumeCtrl;
    vErro : Boolean;
    vErroStr : String;
    Lin : INteger;
    vEndereco : String;
    ObjPessoaCtrl   : TPessoaCtrl;
    JsonArrayPessoa : TJsonArray;
    vCodPessoaERP   : Integer;
    xVolume_ProcessoId : Integer;
begin
  ACBrETQConfig.DPI             := TACBrETQDPI(0);
  AcbrEtqConfig.Temperatura     := 15;
  ObjVolumeCxaFechadaCtrl := TPedidoVOlumeCtrl.Create;
  JsonArrayIdentVolume := ObjVolumeCxaFechadaCtrl.IdentificaVolumeCxaFechada( pPedidoVolumeId );
  if JsonArrayIdentVolume.Items[0].TryGetValue('Erro', vErroStr) then Begin
     ShowErro(vErroStr);
  End
  Else If ((JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') <  3) and (RbProcesso.ItemIndex = 0)) or
          ((JsonArrayIdentVolume.Items[0].GetValue<Integer>('processoid') > 2) and (JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 13) and (RbProcesso.ItemIndex > 0)) or (EdtPedidoVolumeId.Text<>'') then Begin
    Try
//      ConfigACBrETQ;
      ACBrETQConfig.DPI           := TACBrETQDPI(0);
      AcbrEtqConfig.Temperatura   := 15;
      With ACBrETQConfig do Begin
        Ativar;
        Lin := 1;
        ImprimirTexto(orNormal, 2, 2, 2, Lin,  5, 'CAIXA FECHADA', 0, True);
        ImprimirTexto(orNormal, 3, 1, 1, Lin, 54, JsonArrayIdentVolume.Items[0].GetValue<String>('zona'), 0, True);
        ImprimirTexto(orNormal, 3, 1, 1, Lin+6, 5,  'Pedido Vol:', 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+6, 27,  JsonArrayIdentVolume.Items[0].GetValue<String>('pedidoid')+' '+
                                                     JsonArrayIdentVolume.Items[0].GetValue<String>('sequencia')+'/'+
                                                     JsonArrayIdentVolume.Items[0].GetValue<String>('totalvolumes'), 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+6, 67,  JsonArrayIdentVolume.Items[0].GetValue<String>('dtpedido'), 0, False);

        ImprimirCaixa(Lin+11, 5, 93, 12, 1, 1);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+13,  7, 'Destino:', 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+13, 20, JsonArrayIdentVolume.Items[0].GetValue<String>('codpessoaerp')+' '+JsonArrayIdentVolume.Items[0].GetValue<String>('fantasia'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+17,  7, '   Rota:', 0, False);
        ImprimirTexto(orNormal, 3, 2, 2, Lin+17, 20, JsonArrayIdentVolume.Items[0].GetValue<String>('rotaid'), 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+18, 28, JsonArrayIdentVolume.Items[0].GetValue<String>('rotas'), 0, False);
        //ImprimirTexto(orNormal, 2, 1, 1, Lin+19, 60, 'Cidade', 0, False);
        Lin := 28;
        ImprimirCaixa(27, 5, 95, 10, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin  , 7, 'Produto', 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+3, 7, JsonArrayIdentVolume.Items[0].GetValue<String>('codproduto')+' '+COpy(JsonArrayIdentVolume.Items[0].GetValue<String>('descricao'), 1, 30), 0, False);
        ImprimirTexto(orNormal, 1, 2, 2, Lin+6, 7, '       '+COpy(JsonArrayIdentVolume.Items[0].GetValue<String>('descricao'), 31, 30), 0, False);
        ImprimirCaixa(Lin+10,  5, 32, 9, 0, 0);
        ImprimirCaixa(Lin+10, 40, 27, 9, 0, 0);
        ImprimirCaixa(Lin+10, 64, 29, 9, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+11,  7, 'Lote', 0, False);
        if Length(JsonArrayIdentVolume.Items[0].GetValue<String>('lote')) <= 10 then
           ImprimirTexto(orNormal, 2, 2, 2, Lin+14,  7, JsonArrayIdentVolume.Items[0].GetValue<String>('lote'), 0, False)
        Else ImprimirTexto(orNormal, 1, 2, 2, Lin+14,  7, JsonArrayIdentVolume.Items[0].GetValue<String>('lote'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+11, 42, ' Vencto', 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+14, 42, Copy(JsonArrayIdentVolume.Items[0].GetValue<String>('vencimento'), 4, 7), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+11, 68, 'Qtd', 0, False);
        ImprimirTexto(orNormal, 4, 2, 2, Lin+12, 78, FormatFloat('###0', JsonArrayIdentVolume.Items[0].GetValue<integer>('qtdsuprida')), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+20,  7, 'Rua  Prédio   Nível  Apto', 0, False);
        vEndereco := JsonArrayIdentVolume.Items[0].GetValue<String>('endereco');
        if (vEndereco = '00000000') or (vEndereco = 'DOCA GERAL') then
           ImprimirTexto(orNormal, 3, 2, 2, Lin+23,  7, 'STAGE', 0, False)
        Else
           ImprimirTexto(orNormal, 3, 2, 2, Lin+23,  7, copy(vEndereco,1,2)+' '+Copy(vEndereco, 3, 2)+' '+
                                                        Copy(vEndereco,5,2)+' '+Copy(vEndereco,7,3), 0, False);
        ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+20, 64, JsonArrayIdentVolume.Items[0].GetValue<String>('pedidovolumeid'), 8, becSIM);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+28,  7, 'Picking: '+JsonArrayIdentVolume.Items[0].GetValue<String>('picking'), 0, False);
        Lin := 62;
        ImprimirCaixa(60, 5, 93, 17, 0, 0);
//        ImprimirTexto(orNormal, 2, 1, 1, Lin,  7, 'Obs: ', 0, False);
        if JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 3 then
           ImprimirTexto(orNormal, 2, 1, 1, Lin,  7, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
        Else ImprimirTexto(orNormal, 2, 1, 1, Lin,  7, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  7, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  7, 'Ressuprimento: '+JsonArrayIdentVolume.Items[0].GetValue<String>('documentooriginal'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+3, 75, 'eXactWMS(r)', 0, False);
        vCodPessoaERP := JsonArrayIdentVolume.Items[0].GetValue<Integer>('codpessoaerp');
        xVolume_ProcessoId := JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid');
        ObjPessoaCtrl := TPessoaCtrl.Create;
        JsonArrayPessoa := ObjPessoaCtrl.GetAddressToVolume( vCodPessoaERP );
        if Not JsonArrayPessoa.Items[0].TryGetValue('Erro', vErroStr) then Begin
           ImprimirTexto(orNormal, 2, 1, 1, Lin+ 6,  7, Copy(JsonArrayPessoa.Items[0].GetValue<String>('endereco'), 1, 60), 0, False);
           if Length(JsonArrayPessoa.Items[0].GetValue<String>('endereco')) > 60 then Begin
              ImprimirTexto(orNormal, 2, 1, 1, Lin+ 8,  7, Trim(Copy(JsonArrayPessoa.Items[0].GetValue<String>('endereco'), 61, 20)+'    '+Copy(JsonArrayPessoa.Items[0].GetValue<String>('complemento'),1, 50)), 0, False);
              ImprimirTexto(orNormal, 2, 1, 1, Lin+11,  7, 'Cep: '+Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 1, 2)+'.'+
                            Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 3, 3)+'-'+
                            Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 6, 3)+'   '+
                            Copy(JsonArrayPessoa.Items[0].GetValue<String>('bairro'), 1, 20)+' '+
                            JsonArrayPessoa.Items[0].GetValue<String>('municipio')+'-'+
                            JsonArrayPessoa.Items[0].GetValue<String>('uf') , 0, False);
           End
           Else Begin
              ImprimirTexto(orNormal, 2, 1, 1, Lin+9,  7, 'Cep: '+Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 1, 2)+'.'+
                            Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 3, 3)+'-'+
                            Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 6, 3)+'   '+
                            Copy(JsonArrayPessoa.Items[0].GetValue<String>('bairro'), 1, 20)+
                            JsonArrayPessoa.Items[0].GetValue<String>('municipio')+'-'+
                            JsonArrayPessoa.Items[0].GetValue<String>('uf') , 0, False);
           End;
        End;
        JsonArrayPessoa := Nil;
        ObjPessoaCtrl.Free;
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
        ObjVolumeCxaFechadaCtrl.ObjPedidoVolume.PedidoVolumeId := pPedidoVolumeId;
        if xVolume_ProcessoId < 3 then Begin
           Try
             ObjVolumeCxaFechadaCtrl.RegistrarDocumentoEtapa(3);
           Except On E: Exception do
             showErro('Volume: '+pPedidoVolumeId.ToString+' s/registro de impressão!');
           End;
        End;
      End;
    Except On E: Exception do Begin
      vErro := True;
      ShowErro('Erro: Problema de comunicação com impressora... '+E.Message);
      End;
    End;
  end;
  JsonArrayIdentVolume := Nil;
  ObjVolumeCxaFechadaCtrl.Free;
end;

procedure TFrmPrintTag.TagVolumeCaixaFechada_RotaClienteDestaque_8x10etqEpl2(
  pPedidoVolumeId: Integer);
Var JsonArrayIdentVolume    : TJsonArray;
    ObjVolumeCxaFechadaCtrl : TPedidoVOlumeCtrl;
    vErro : Boolean;
    vErroStr : String;
    Lin : INteger;
    vEndereco : String;
    vVolumeCodBarra : String;
    vRota, vDestino, vQuant : String;
    Port : String;
begin
  Port := (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra);
  ACBrETQConfig.DPI             := TACBrETQDPI(0);
  AcbrEtqConfig.Temperatura     := 10;
  Port := (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra);
  ObjVolumeCxaFechadaCtrl := TPedidoVOlumeCtrl.Create;
  JsonArrayIdentVolume := ObjVolumeCxaFechadaCtrl.IdentificaVolumeCxaFechada( pPedidoVolumeId );
  if JsonArrayIdentVolume.Items[0].TryGetValue('Erro', vErroStr) then Begin
     ShowErro(vErroStr);
  End
  Else If ((JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') <  3) and (RbProcesso.ItemIndex = 0)) or
          ((JsonArrayIdentVolume.Items[0].GetValue<Integer>('processoid') > 2) and (JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 13) and (RbProcesso.ItemIndex > 0)) or (EdtPedidoVolumeId.Text<>'') then Begin
    Try
//      ConfigACBrETQ;
      ACBrETQConfig.DPI           := TACBrETQDPI(1);
      AcbrEtqConfig.Temperatura   := 10;
      With ACBrETQConfig do Begin
        Ativar;
        Lin := 2;
        ImprimirTexto(orNormal, 2, 2, 2, Lin,  2, 'CAIXA FECHADA', 0, True);
        if (JsonArrayIdentVolume.Items[0].GetValue<String>('zona') <> 'PULMAO') and
           (JsonArrayIdentVolume.Items[0].GetValue<String>('zona') <> 'ARMAZENAGEM') then
           ImprimirTexto(orNormal, 3, 1, 1, Lin, 30, JsonArrayIdentVolume.Items[0].GetValue<String>('zona'), 0, True);

        ImprimirTexto(orNormal, 3, 1, 1, Lin,   30, 'Pedido', 0, False);
        ImprimirTexto(orNormal, 3, 1, 1, Lin,   60, 'Volume', 0, False);
        ImprimirTexto(orNormal, 3, 2, 2, Lin+2, 30, JsonArrayIdentVolume.Items[0].GetValue<String>('pedidoid'), 0, False);
        ImprimirTexto(orNormal, 3, 2, 2, Lin+2, 52, Repl(' ', 4 - Length(JsonArrayIdentVolume.Items[0].GetValue<String>('sequencia')))+
                                                         JsonArrayIdentVolume.Items[0].GetValue<String>('sequencia')+'/'+
                                                         JsonArrayIdentVolume.Items[0].GetValue<String>('totalvolumes'), 0, False);


        ImprimirTexto(orNormal, 3, 1, 1, Lin+4, 2,  'Data', 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+4, 8,  JsonArrayIdentVolume.Items[0].GetValue<String>('dtpedido'), 0, False);

        ImprimirCaixa(Lin+8,  2, 25, 10, 0, 0); //Rota
        ImprimirCaixa(Lin+8, 30, 37, 10, 0, 0);
        ImprimirTexto(orNormal, 2,  1, 1, Lin+9,  4, 'Rota', 0, False);
        ImprimirTexto(orNormal, 2,  1, 1, Lin+9, 30, 'Destino', 0, False);
        vRota := JsonArrayIdentVolume.Items[0].GetValue<String>('rotaid');
        vRota := Repl(' ', 4-Length(vRota))+vRota;
        ImprimirTexto(orNormal, 4,  3, 4, Lin+10, 8, vRota, 0, False);
        vDestino := JsonArrayIdentVolume.Items[0].GetValue<String>('codpessoaerp');
        if Length(vDestino) <= 4 then Begin
           vDestino := Repl(' ', 4-Length(vDestino))+vDestino;
           ImprimirTexto(orNormal, 4,  5, 5, Lin+9, 39, vDestino, 0, False);
        End
        Else Begin
           vDestino := Repl(' ', 8-Length(vDestino))+vDestino;
           ImprimirTexto(orNormal, 4,  3, 4, Lin+9, 36, vDestino, 0, False);
        End;
        ImprimirTexto(orNormal, 3,  1, 1, Lin+19, 4, Copy(JsonArrayIdentVolume.Items[0].GetValue<String>('fantasia'), 1, 60)+' - '+
                                                     JsonArrayIdentVolume.Items[0].GetValue<String>('rotas'), 0, False);
        Lin := 24;
        ImprimirCaixa(Lin, 2, 65, 5, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin,   4, ' Produto ', 0, False);
        ImprimirTexto(orNormal, 2, 1, 2, Lin+2, 4, JsonArrayIdentVolume.Items[0].GetValue<String>('codproduto')+' '+COpy(JsonArrayIdentVolume.Items[0].GetValue<String>('descricao'), 1, 60), 0, False);

        ImprimirCaixa(Lin+6,  2, 27, 6, 0, 0);
        ImprimirCaixa(Lin+6, 32, 15, 6, 0, 0);
        ImprimirCaixa(Lin+6, 50, 17, 6, 0, 0);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+7,  4, 'Lote', 0, False);
        if Length(JsonArrayIdentVolume.Items[0].GetValue<String>('lote')) <= 10 then
           ImprimirTexto(orNormal, 2, 2, 2, Lin+9,  4, JsonArrayIdentVolume.Items[0].GetValue<String>('lote'), 0, False)
        Else ImprimirTexto(orNormal, 1, 2, 2, Lin+9,  4, JsonArrayIdentVolume.Items[0].GetValue<String>('lote'), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+7, 32, ' Vencto', 0, False);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+9, 32, Copy(JsonArrayIdentVolume.Items[0].GetValue<String>('vencimento'), 4, 7), 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+7, 52, 'Qtd', 0, False);
        vQuant := FormatFloat('####0', JsonArrayIdentVolume.Items[0].GetValue<integer>('qtdsuprida'));
        ImprimirTexto(orNormal, 4, 2, 2, Lin+8, 52, Repl(' ', 5-Length(vQuant))+ vQuant, 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+13,  4, 'Rua  Prédio   Nível    Apto', 0, False);
        vEndereco := JsonArrayIdentVolume.Items[0].GetValue<String>('endereco');
        if (JsonArrayIdentVolume.Items[0].GetValue<String>('zona') = 'Stage - Docas') then
           ImprimirTexto(orNormal, 3, 2, 2, Lin+15,  4,  'STAGE', 0, False)
        Else If (JsonArrayIdentVolume.Items[0].GetValue<String>('zona') = 'AREA DE ESPERA') then    //Passar o Codigo da Zona
           ImprimirTexto(orNormal, 3, 2, 2, Lin+15,  4,  'AREA DE ESPERA', 0, False)
        Else
           ImprimirTexto(orNormal, 3, 2, 2, Lin+15,  4, copy(vEndereco,1,2)+' '+Copy(vEndereco, 3, 2)+' '+
                                                        Copy(vEndereco,5,2)+' '+Copy(vEndereco,7,3), 0, False);
        vVolumeCodBarra := JsonArrayIdentVolume.Items[0].GetValue<String>('pedidovolumeid');
        ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+12, 45, vVolumeCodBarra, 5, becNAO);
        ImprimirTexto(orNormal, 2, 2, 2, Lin+18, (42 + Trunc((20-Length(vVolumeCodBarra))/2)), vVolumeCodBarra, 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+18,  4, 'Picking: '+JsonArrayIdentVolume.Items[0].GetValue<String>('picking'), 0, False);
        Lin := 42;

        ImprimirCaixa(Lin+2, 2, 65, 8, 0, 0);
        if JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 3 then
           ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  4, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
        Else ImprimirTexto(orNormal, 2, 1, 1, Lin+3,  4, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+5,  4, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
        ImprimirTexto(orNormal, 2, 1, 1, Lin+7,  4, 'Ressuprimento: '+JsonArrayIdentVolume.Items[0].GetValue<String>('documentooriginal'), 0, False);

        ImprimirTexto(orNormal, 2, 1, 1, Lin+7, 55, 'eXactWMS(r)', 0, False);
        FinalizarEtiqueta;
        Imprimir(1, 0);
        Sleep(vTimeEtiqueta);
        Desativar;
        ObjVolumeCxaFechadaCtrl.ObjPedidoVolume.PedidoVolumeId := pPedidoVolumeId;
        if JsonArrayIdentVolume.Items[0].GetValue<integer>('processoid') < 3 then Begin
           Try
             ObjVolumeCxaFechadaCtrl.RegistrarDocumentoEtapa(3);
           Except On E: Exception do
             showErro('Volume: '+pPedidoVolumeId.ToString+' s/registro de impressão!');
           End;
        End;
//        FreeAndNil(ObjVolumeCxaFechadaCtrl);
      End;
    Except On E: Exception do Begin
      vErro := True;
      ShowErro('Erro: Problema de comunicação com impressora... '+E.Message);
      End;
    End;
  end;
  JsonArrayIdentVolume := Nil;
  ObjVolumeCxaFechadaCtrl.Free;
end;

procedure TFrmPrintTag.TagVolumeFracionado8x10etqEpl2(pPedidoId, pPedidoVolumeId, pSequencia, pCodPessoaERP, pOrdem, vItens, vTotUnid : Integer;
    prazao, protas, vPredini, vPredFin, pDtPedido, pDocumentoOriginal : String; pProcessoId, pRotaId, pTotalVolumes : Integer);
Var xEtq, Lin  : Integer;
    vErro : Boolean;
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    ObjPessoaCtrl   : TPessoaCtrl;
    JsonArrayPessoa : TJsonArray;
    vErroStr : String;
    ColIni   : Integer;
begin
  inherited;
  ColIni := 3;
  vErro := True; //Forçar inicialização da impressão
  Try
//    ConfigACBrETQ;
    ACBrETQConfig.DPI         := TACBrETQDPI(0);
    ACBrETQConfig.Temperatura := 10;
    With ACBrETQConfig do Begin
      Ativar;
      IniciarEtiqueta;
      //Selecionar os volumes
      For xEtq := 1 to 1 do Begin //Pred(LstEnderecoAdv.RowCount) do begin
        //if LstEnderecoAdv.Cells[8, xEtq] = '1' then Begin
//           if Not device.EmLinha() then
//              raise Exception.Create('ocorreu um erro na impressora.');
           Repeat
           Try
             if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume in [0, 1] then Begin;
                Lin := 1;                                //
                ImprimirTexto(orNormal, 2, 2, 2, Lin,  ColIni+5, 'FRACIONADOS', 0, True);
                ImprimirCaixa(Lin+5, 5, 95, 20, 0, 0);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+7,  ColIni+7, 'Filial', 0, False);
                ImprimirTexto(orNormal, 2, 2, 3, Lin+10, ColIni+7, Repl(' ',6-Length(pCodPessoaERP.ToString))+  pCodPessoaERP.ToString, 0, False);
                ImprimirTexto(orNormal, 2, 1, 2, Lin+10, ColIni+26, Copy(pRazao, 1, 40), 0, False);

                ImprimirTexto(orNormal, 3, 1, 1, Lin+16, ColIni+7, 'Rota', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+16, ColIni+80, 'Ordem', 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+20, ColIni+7, pRotas, 0, False);
                ImprimirTexto(orNormal, 2, 1, 2, Lin+20, ColIni+85, FormatFloat('###0', pOrdem), 0, False);

                ImprimirTexto(orNormal, 3, 1, 1, Lin+27,  ColIni+5, 'Endereço:', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+31,  ColIni+7, 'Inicio', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+31,  ColIni+29, 'Término', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+31,  ColIni+53, 'Itens', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+31,  ColIni+76, 'Unid', 0, False);
                ImprimirCaixa(Lin+30, ColIni+5, 20, 8, 0, 0);
                ImprimirCaixa(Lin+30, ColIni+27, 22, 8, 0, 0);
                ImprimirCaixa(Lin+30, ColIni+52, 20, 8, 0, 0);
                ImprimirCaixa(Lin+30, ColIni+74, 17, 8, 0, 0);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+34,  ColIni+3,  ' '+vPredIni+' ', 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+34,  ColIni+27, ' '+vPredFin+' ', 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+34,  ColIni+60, FormatFloat('###0', vItens),   0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+34,  ColIni+82, FormatFloat('###0', vTotUnid), 0, False);

                //ImprimirBarras(orNormal, barEAN13, 2, 2, Lin+40,  1, '7896003701685', 10, becSIM);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+41, ColIni+7,  '  Pedido Vol.', 0, False);
                ImprimirTexto(orNormal, 3, 2, 2, Lin+45,  ColIni+2,  '   '+pPedidoId.ToString+' '+pSequencia.ToString()+'/'+
                                                                           pTotalVolumes.ToString(), 0, False);

                //ImprimirTexto(orNormal, 3, 2, 2, Lin+45,  28,  '/01', 0, False);

                ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+40, ColIni+60, pPedidoVolumeId.toString, 12, becSIM);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+52,  ColIni+14, '    '+pDtPedido, 0, False);
                if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 0 then Begin
                   ImprimirCaixa(Lin+56, ColIni+5, 88, 17, 1, 1);
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+58,  ColIni+7, 'Obs: ', 0, False);
                   if pProcessoId = 2 then
                      ImprimirTexto(orNormal, 2, 1, 1, Lin+61,  ColIni+7, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                      DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
                   Else ImprimirTexto(orNormal, 2, 1, 1, Lin+61,  ColIni+7, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+
                        ' '+DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+65,  ColIni+7, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+68,  ColIni+7, 'Ressuprimento: '+pdocumentooriginal, 0, False);
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+68, ColIni+75, 'eXactWMS(r)', 0, False);
                End
                Else If FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 1 then Begin
                   ImprimirCaixa(Lin+56, ColIni+5, 95, 19, 0, 0);
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+58,  ColIni+7, 'Obs: ', 0, False);
                   if pProcessoId = 2 then
                      ImprimirTexto(orNormal, 2, 1, 1, Lin+61,  ColIni+7, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                      DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
                   Else ImprimirTexto(orNormal, 2, 1, 1, Lin+61,  ColIni+7, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+
                        ' '+DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+64,  ColIni+7, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+64, ColIni+60, 'Ressuprimento: '+pdocumentooriginal, 0, False);

                   ObjPessoaCtrl := TPessoaCtrl.Create;
                   JsonArrayPessoa := ObjPessoaCtrl.GetAddressToVolume( pCodPessoaERP );
                   if Not JsonArrayPessoa.Items[0].TryGetValue('Erro', vErroStr) then Begin
                      ImprimirTexto(orNormal, 2, 1, 1, Lin+67,  ColIni+7, Copy(JsonArrayPessoa.Items[0].GetValue<String>('endereco'), 1, 60), 0, False);
                      if Length(JsonArrayPessoa.Items[0].GetValue<String>('endereco')) > 60 then Begin
                         ImprimirTexto(orNormal, 2, 1, 1, Lin+ 69,  ColIni+7, Trim(Copy(JsonArrayPessoa.Items[0].GetValue<String>('endereco'), 61, 20)+'    '+Copy(JsonArrayPessoa.Items[0].GetValue<String>('complemento'),1, 50)), 0, False);
                         ImprimirTexto(orNormal, 2, 1, 1, Lin+72,  ColIni+7, 'Cep: '+Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 1, 2)+'.'+
                                       Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 3, 3)+'-'+
                                       Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 6, 3)+'   '+
                                       Copy(JsonArrayPessoa.Items[0].GetValue<String>('bairro'), 1, 20)+
                                       JsonArrayPessoa.Items[0].GetValue<String>('municipio')+'-'+
                                       JsonArrayPessoa.Items[0].GetValue<String>('uf') , 0, False);
                      End
                      Else Begin
                         ImprimirTexto(orNormal, 2, 1, 1, Lin+70,  ColIni+7, 'Cep: '+Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 1, 2)+'.'+
                                       Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 3, 3)+'-'+
                                       Copy(JsonArrayPessoa.Items[0].GetValue<String>('cep'), 6, 3)+'   '+
                                       Copy(JsonArrayPessoa.Items[0].GetValue<String>('bairro'), 1, 20)+' '+
                                       JsonArrayPessoa.Items[0].GetValue<String>('municipio')+'-'+
                                       JsonArrayPessoa.Items[0].GetValue<String>('uf') , 0, False);
                      End;
                   End;
                   JsonArrayPessoa := Nil;
                   ObjPessoaCtrl.Free;


                   ImprimirTexto(orNormal, 2, 1, 1, Lin+72, ColIni+80, 'eXactWMS(r)', 0, False);
                End;
             End
             Else if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloEtqVolume = 2 then Begin
                Lin := 1;
                ImprimirTexto(orNormal, 2, 2, 2, Lin,  ColIni+2, 'FRACIONADOS', 0, True);

                ImprimirTexto(orNormal, 3, 1, 1, Lin,   50, 'Pedido', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin,   88, 'Volume', 0, False);
                ImprimirTexto(orNormal, 3, 2, 2, Lin+3, 50, pPedidoId.ToString, 0, False);
                ImprimirTexto(orNormal, 3, 2, 2, Lin+3, 75, Repl(' ', 4 - Length(psequencia.ToString()))+
                                                            pSequencia.ToString()+'/'+pTotalVolumes.ToString, 0, False);


                ImprimirTexto(orNormal, 3, 1, 1, Lin+6,  5,  'Data', 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+5, 13,  pDtPedido, 0, False);

{                ImprimirTexto(orNormal, 3, 1, 1, Lin+5, ColIni+2,  'Pedido', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+5, ColIni+32, 'Volume', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+5, ColIni+60, 'Data', 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+5, ColIni+43, pSequencia.ToString(), 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+5, ColIni+68, pDtPedido, 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+8,  ColIni+2, pPedidoId.ToString, 0, False);
}
                Lin := Lin + 2;
                ImprimirCaixa(Lin+10,  ColIni+2, 30, 11, 0, 0);
                ImprimirCaixa(Lin+8,  ColIni+35, 50, 13, 0, 0);
                ImprimirTexto(orNormal, 2,  1, 1, Lin+11,  ColIni+4, 'Rota', 0, False);
                ImprimirTexto(orNormal, 2,  1, 1, Lin+9 , ColIni+37, 'Destino', 0, False);
                ImprimirTexto(orNormal, 2,  1, 1, Lin+9 , ColIni+87, 'Ordem', 0, False);
                ImprimirTexto(orNormal, 4,  3, 4, Lin+11, ColIni+12, pRotaId.ToString(), 0, False);
                ImprimirTexto(orNormal, 4,  5, 5, Lin+9 , ColIni+49, pCodPessoaERP.ToString, 0, False);
                ImprimirTexto(orNormal, 3,  3, 3, Lin+13, ColIni+93, FormatFloat('###0', pOrdem), 0, False);
                ImprimirTexto(orNormal, 2,  1, 1, Lin+23,  ColIni+4, Copy(pRazao, 1, 60)+' - '+pRotas, 0, False);
        //        if Zona then
        //           ImprimirTexto(orNormal, 3, 1, 1, Lin, 30, JsonArrayIdentVolume.Items[0].GetValue<String>('zona'), 0, True);
                Lin := 30;

                ImprimirTexto(orNormal, 3, 1, 1, Lin,  ColIni+5, 'Endereço:', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+5,  ColIni+7, 'Inicio', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+5,  ColIni+29, 'Término', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+5,  ColIni+53, 'Itens', 0, False);
                ImprimirTexto(orNormal, 3, 1, 1, Lin+5,  ColIni+76, 'Unid', 0, False);

                ImprimirCaixa(Lin+4,  ColIni+5, 20, 10, 0, 0);
                ImprimirCaixa(Lin+4, ColIni+27, 22, 10, 0, 0);
                ImprimirCaixa(Lin+4, ColIni+52, 20, 10, 0, 0);
                ImprimirCaixa(Lin+4, ColIni+74, 17, 10, 0, 0);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+9,  ColIni+4,  ' '+vPredIni+' ', 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+9,  ColIni+27, ' '+vPredFin+' ', 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+9,  ColIni+60, FormatFloat('###0', vItens),   0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+9,  ColIni+87, FormatFloat('###0', vTotUnid), 0, False);

                ImprimirBarras(orNormal, barCODE128, 3, 3, Lin+15, ColIni+40, pPedidoVolumeId.toString, 12, becNAO);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+9,  ColIni+87, FormatFloat('###0', vTotUnid), 0, False);
                ImprimirTexto(orNormal, 2, 2, 2, Lin+28, ColIni+45, pPedidoVolumeId.toString , 0, False);

                Lin := Lin - 24;
                ImprimirCaixa(Lin+56, ColIni+5, 93, 12, 0, 0);
                if pProcessoId = 2 then
                   ImprimirTexto(orNormal, 2, 1, 1, Lin+58,  ColIni+7, 'impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+' '+
                   DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False)
                Else ImprimirTexto(orNormal, 2, 1, 1, Lin+58,  ColIni+7, 'Re-impressão: '+Copy(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome,1,20)+
                     ' '+DateToStr(date())+' às '+Copy(TimeToStr(Time()),1,5)+'h', 0, False);
                ImprimirTexto(orNormal, 2, 1, 1, Lin+61,  ColIni+7, FrmeXactWMS.ConfigWMS.ObjConfiguracao.Empresa, 0, False);
                ImprimirTexto(orNormal, 2, 1, 1, Lin+64,  ColIni+7, 'Ressuprimento: '+pdocumentooriginal, 0, False);
                ImprimirTexto(orNormal, 2, 1, 1, Lin+64, ColIni+75, 'eXactWMS(r)', 0, False);


             End;
             FinalizarEtiqueta;
             Imprimir(1, 0);
             ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
             ObjPedidoVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := pPedidoVolumeId;
             if pProcessoId = 2 then Begin
                Try
                  ObjPedidoVolumeCtrl.RegistrarDocumentoEtapa(3);
                Except On E: Exception do
                  showErro('Volume: '+pPedidoVolumeId.ToString+' s/registro de impressão!');
                End;
             End;
             ObjPedidoVolumeCtrl.Free;
             Sleep(vTimeEtiqueta);
             vErro := False;
           Except On E: Exception do Begin
             vErro := True;
             if (Confirmacao('Erro Impressora!', 'Reimprimir Volume: '+pPedidoVolumeId.ToString+'?')) then
                vErro := True //ShowErro('Erro: Problema de comunicação com impressora...');
             Else vErro := False;
             if Assigned(ObjPedidoVolumeCtrl) then
                ObjPedidoVolumeCtrl.Free;
             End;
           End;
           Until vErro = False;
        //End;
      End;
      //Imprimir(SpCopias.Value, 0);
      Desativar;
    end;
  Except On E: Exception do
    raise Exception.Create('Erro: Comunicação com impressora. '+sLineBreak+E.Message);
  End;
end;

procedure TFrmPrintTag.TbTagArmazenagemShow(Sender: TObject);
begin
  inherited;
  EdtPedidoId.Clear;
  LstTagArmazenagem.ColWidths[0] := 100;
  LstTagArmazenagem.ColWidths[1] := 100;
  LstTagArmazenagem.ColWidths[2] := 100;
  LstTagArmazenagem.ColWidths[3] :=  70;
  LstTagArmazenagem.ColWidths[4] := 250;
  LstTagArmazenagem.ColWidths[5] := 250;
  LstTagArmazenagem.ColWidths[6] :=  50;
  LstTagArmazenagem.ColWidths[7] :=  50;
  LstTagArmazenagem.ColWidths[8] :=  65;
  EdtDtInicio.Clear;
  EdtDtTermino.Clear;
  EdtPedidoIdTag.Clear;
  EdtDocumentoNr.Clear;
  EdtCodProduto.Clear;
  LblTotRegEtqArmazenagem.Caption := '0';
  LstTagArmazenagem.Alignments[0, 0] := taRightJustify;
  LstTagArmazenagem.FontStyles[0, 0] := [FsBold];
  LstTagArmazenagem.Alignments[3, 0] := taRightJustify;
  LstTagArmazenagem.Alignments[6, 0] := taRightJustify;
  LstTagArmazenagem.Alignments[7, 0] := taRightJustify;
  LstTagArmazenagem.Alignments[8, 0] := taCenter;
  SelPedEtq := False;
  ImprimirExportar(False);
end;

procedure TFrmPrintTag.TbTagOFF;
begin
  TbTagProduto.TabVisible     := False;
  TbTagVolume.TabVisible      := False;
  TbTagCaixa.TabVisible       := False;
  TbTagLocalizacao.TabVisible := False;
  PgcTabTags.Visible          := False;
end;

procedure TFrmPrintTag.TbTagON(Page: TcxTabSheet);
begin
  TbTagOFF;
  PgcTabTags.Visible    := True;
  Page.TabVisible       := True;
  PgcTabTags.ActivePage := Page;
end;

procedure TFrmPrintTag.ClearLstVolumes;
begin
  LstPedidosAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
  LstPedidosAdv.RowCount       := 1;
  LstVolumesFilterAdv.ClearRect(0, 1, LstVolumesFilterAdv.ColCount-1, LstVolumesFilterAdv.RowCount-1);
  LstVolumesFilterAdv.RowCount := 1;
  If FDMemEtiquetaVolumePorRua.Active then
     FDMemEtiquetaVolumePorRua.EmptyDataSet;
  FDMemEtiquetaVolumePorRua.Close;
end;

procedure TFrmPrintTag.ConfigACBrETQ;
var vlIni: TIniFile;
begin
  vlIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.ini');
  try
    CbModeloConfigPrinter.ItemIndex := CbModeloConfigPrinter.Items.IndexOf(vlIni.ReadString('PRINTER', 'EtqCodBarra_Modelo', FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra));
    CbPortaConfigPrinter.ItemIndex  := CbPortaConfigPrinter.Items.IndexOf(vlIni.ReadString('PRINTER',  'EtqCodBarra_Porta' , FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra));
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.ModeloPrinterCodBarra := CbModeloConfigPrinter.Text;
    FrmeXactWMS.ConfigWMS.ObjConfiguracao.PortaPrinterCodBarra  := CbPortaConfigPrinter.Text;
  finally
    vlIni.Free;
  end;

  with ACBrETQConfig do
  begin
     Desativar;
     DPI           := TACBrETQDPI(2);
     LimparMemoria := True;
     Temperatura   := 10;
     Velocidade    := -1;
     BackFeed      := TACBrETQBackFeed(-1);
     Unidade       := etqMilimetros; //etqDecimoDeMilimetros;
     MargemEsquerda:= 0;
     Origem        := TACBrETQOrigem(1); //cbOrigem.ItemIndex);
     PaginaDeCodigo:= TACBrETQPaginaCodigo(2);
     Porta         := CbPortaConfigPrinter.Text;
     Modelo        := TACBrETQModelo(CbModeloConfigPrinter.ItemIndex);
  end;
end;

procedure TFrmPrintTag.DbgLotesEtqIndividualCellClick(Column: TColumn);
begin
  inherited;
  if Column.FieldName = 'Impr' then Begin
     if FDMemProdutoLotesEtqArmazenagem.FieldByName('Impr').AsInteger = 0 then
        SelecionarRegistroFdMem(FDMemProdutoLotesEtqArmazenagem, 'impr')
     Else if FDMemProdutoLotesEtqArmazenagem.FieldByName('Impr').AsInteger = 1 then
        SelecionarRegistroFdMem(FDMemProdutoLotesEtqArmazenagem, 'impr');
     vSelectLoteTag := Not FDMemProdutoLotesEtqArmazenagem.FieldByName('Impr').AsInteger = 1;
  End;
end;

procedure TFrmPrintTag.DbgLotesEtqIndividualDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  if (Column.FieldName = 'Impr') then
      ExibirCheckBox(Column, DbgLotesEtqIndividual, ImgAtivo, Rect);
//  if (Column.FieldName = 'PrintEan') then ExibirCheckBox(Column, DbgLotesEtqIndividual, ImgPrint, Rect);
end;

procedure TFrmPrintTag.DbgLotesEtqIndividualTitleClick(Column: TColumn);
begin
  inherited;
  if Column.Field.Name = 'FDMemProdutoLotesEtqArmazenagemImpr' then Begin
     DsProdutoLotesEtqArmazenagem.DataSet := nil;
     FDMemProdutoLotesEtqArmazenagem.First;
     while Not FDMemProdutoLotesEtqArmazenagem.Eof do Begin
       FDMemProdutoLotesEtqArmazenagem.Edit;
       if (vSelectLoteTag) Then
          FDMemProdutoLotesEtqArmazenagem.FieldByName('Impr').AsInteger  := 0
       Else
          FDMemProdutoLotesEtqArmazenagem.FieldByName('Impr').AsInteger  := 1;
       FDMemProdutoLotesEtqArmazenagem.Post;
       FDMemProdutoLotesEtqArmazenagem.Next;
     End;
     FDMemProdutoLotesEtqArmazenagem.First;
     vSelectLoteTag := Not vSelectLoteTag;
     DsProdutoLotesEtqArmazenagem.DataSet := FDMemProdutoLotesEtqArmazenagem;
  End;
end;

end.
