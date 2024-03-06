unit uFrmProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, Data.DB, Vcl.ExtDlgs,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, cxPC, acPNG, acImage, dxGDIPlusClasses, Vcl.Buttons,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.JSOn,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DataSet.Serialize, JvFullColorSpaces, JvFullColorCtrls,
  Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits, AdvUtil, Vcl.Samples.Spin, JvSpin,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, AdvDropDown,
  AdvCustomGridDropDown, AdvGridDropDown, AdvLookupBar, AdvGridLookupBar,
  AdvObj, BaseGrid, ImagePicker, Generics.Collections, System.Threading
  , ProdutoCtrl
  , RastroCtrl, RastroClass
  , ProdutoTipoCtrl, ProdutoTipoClass
  , MedicamentoTipoCtrl, MedicamentoTipoClass
  , EnderecoClass, EnderecoCtrl
  , LaboratorioCtrl
  , UnidadeClass, UnidadeCtrl
  , EnderecamentoZonaClass, EnderecamentoZonaCtrl
  , ProdutoCodBarrasCtrl
  , EntradaCtrl
  , PedidoSaidaCtrl
  , LoteCtrl, Vcl.ComCtrls, dxSkinsCore, dxSkinsDefaultPainters, ACBrBase,
  ACBrBAL, ACBrETQ, dxCameraControl, Views.Pequisa.Unidades;

type
  TFrmProduto = class(TFrmBase)
    btnPesquisar: TBitBtn;
    chkLiquido: TCheckBox;
    GroupBox1: TGroupBox;
    EdtCdProdutoERP: TLabeledEdit;
    EdtVariacaoERP: TLabeledEdit;
    EdtTamanhoERP: TLabeledEdit;
    edtCodProduto: TLabeledEdit;
    grpEstoqueReposicao: TGroupBox;
    grpValidadeMinima: TGroupBox;
    GroupBox2: TGroupBox;
    edtDescricao: TLabeledEdit;
    EdtDescricaoRed: TLabeledEdit;
    EdtCodigoMS: TLabeledEdit;
    Label2: TLabel;
    CbProdutoTipo: TComboBox;
    CbMedicamentoTipo: TComboBox;
    Label3: TLabel;
    ChkSNGPC: TCheckBox;
    ChkImportado: TCheckBox;
    ChkInflamavel: TCheckBox;
    ChkPerigoso: TCheckBox;
    EdtLaboratorioId: TLabeledEdit;
    BitBtn4: TBitBtn;
    LblLaboratorio: TLabel;
    EdtPeso: TJvCalcEdit;
    Label4: TLabel;
    Label9: TLabel;
    EdtAltura: TJvCalcEdit;
    Label10: TLabel;
    EdtLargura: TJvCalcEdit;
    EdtComprimento: TJvCalcEdit;
    Label11: TLabel;
    Label12: TLabel;
    EdtVolume: TJvCalcEdit;
    Label13: TLabel;
    EdtMaxPicking: TJvCalcEdit;
    Label14: TLabel;
    EdtMinPicking: TJvCalcEdit;
    Label15: TLabel;
    EdtPercReposicao: TJvCalcEdit;
    EdtMesEntradaMinima: TJvCalcEdit;
    Label17: TLabel;
    EdtMesSaidaMinima: TJvCalcEdit;
    Label16: TLabel;
    TabLotes: TcxTabSheet;
    EdtCodProdutoLote: TLabeledEdit;
    EdtDescrProdutoLote: TLabeledEdit;
    EdtDescricaoLote: TEdit;
    Label18: TLabel;
    EdtDtFabricacaoLote: TJvDateEdit;
    Label19: TLabel;
    Label20: TLabel;
    EdtDtVencimentoLote: TJvDateEdit;
    PnlLstLotes: TPanel;
    AdvGdLookupLote: TAdvGridLookupBar;
    LstLotes: TAdvStringGrid;
    TabCodBarras: TcxTabSheet;
    EdtCodProdutoERPEan: TLabeledEdit;
    EdtDescricaoEan: TLabeledEdit;
    Label21: TLabel;
    EdtCodBarras: TEdit;
    EdtUnidEmbalagem: TJvCalcEdit;
    Label22: TLabel;
    PnlLstCodBarras: TPanel;
    AdvGridLookupBar2: TAdvGridLookupBar;
    AdvSGCodBarras: TAdvStringGrid;
    ChkCodBarrasStatus: TCheckBox;
    TmAtualizarLstCodBarras: TTimer;
    Label23: TLabel;
    CbRastroTipo: TComboBox;
    ChkMedicamento: TCheckBox;
    GroupBox3: TGroupBox;
    EdtUnidadeId: TLabeledEdit;
    BtnPesqUnidadePrimaria: TBitBtn;
    LblUnidade: TLabel;
    EdtQtdUnid: TLabeledEdit;
    GroupBox4: TGroupBox;
    EdtUnidadeSecundariaId: TLabeledEdit;
    BtnPesqUnidadeSecundaria: TBitBtn;
    EdtFatorConversao: TLabeledEdit;
    LblUnidadeSecundaria: TLabel;
    GbEnderecoPicking: TGroupBox;
    lblEndereco: TLabel;
    EdtZonaArmazenagemId: TLabeledEdit;
    BitBtn3: TBitBtn;
    LblZonaArmazenagem: TLabel;
    EdtPicking: TEdit;
    LblPicking: TLabel;
    BtnSalvarCodBarras: TPanel;
    sImage3: TsImage;
    BtnCancelarCodBarras: TPanel;
    sImage4: TsImage;
    BtnNovoCodBarras: TPanel;
    sImage5: TsImage;
    BtnCancelarLote: TPanel;
    sImage2: TsImage;
    BtnSalvarLote: TPanel;
    sImage1: TsImage;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ShCodBarras: TShape;
    ChkCodBarrasPrincipal: TCheckBox;
    TabEstoqueEndereco: TcxTabSheet;
    Panel1: TPanel;
    AdvGridLookupBar3: TAdvGridLookupBar;
    LstAdvEstoqueEndereco: TAdvStringGrid;
    EdtCodProdutoEstEnd: TLabeledEdit;
    EdtDescricaoEstEnd: TLabeledEdit;
    Bevel3: TBevel;
    TabImportacao: TcxTabSheet;
    BtnCapturarPeso: TBitBtn;
    PnlCapturarPeso: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    EdtCodigoERPCapPeso: TLabeledEdit;
    EdtDescricaoCapPeso: TLabeledEdit;
    Label5: TLabel;
    EdtPesoAtualCapPeso: TJvCalcEdit;
    Label6: TLabel;
    EdtPesoCapPeso: TJvCalcEdit;
    ACBrBAL1: TACBrBAL;
    Panel4: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    cmbBalanca: TComboBox;
    cmbPortaSerial: TComboBox;
    cmbHandShaking: TComboBox;
    cmbStopBits: TComboBox;
    Panel5: TPanel;
    sImage6: TsImage;
    TabMovimentacao: TcxTabSheet;
    grpEntradas: TGroupBox;
    DbgRecebimentos: TDBGrid;
    GroupBox6: TGroupBox;
    DbgRessuprimentos: TDBGrid;
    FDMemMovRecebimentos: TFDMemTable;
    DsMovRecebimentos: TDataSource;
    FDMemMovRessuprimentos: TFDMemTable;
    DsMovRessuprimentos: TDataSource;
    FDMemMovRecebimentosPedidoId: TIntegerField;
    FDMemMovRecebimentosProcessoId: TIntegerField;
    FDMemMovRecebimentosProcesso: TStringField;
    FDMemMovRecebimentosData: TDateField;
    FDMemMovRecebimentosIdProduto: TIntegerField;
    FDMemMovRecebimentosCodigoERP: TIntegerField;
    FDMemMovRecebimentosDescricao: TStringField;
    FDMemMovRecebimentosFabricanteId: TIntegerField;
    FDMemMovRecebimentosFabricanteNome: TStringField;
    FDMemMovRecebimentosQtdXml: TIntegerField;
    FDMemMovRecebimentosQtdCheckIn: TIntegerField;
    FDMemMovRecebimentosQtdDevolvida: TIntegerField;
    FDMemMovRecebimentosQtdSegregada: TIntegerField;
    FDMemMovRecebimentosDocumentoNr: TStringField;
    FDMemMovRessuprimentosPedidoId: TIntegerField;
    FDMemMovRessuprimentosData: TDateField;
    FDMemMovRessuprimentosDocumentoNr: TStringField;
    FDMemMovRessuprimentosIdProduto: TIntegerField;
    FDMemMovRessuprimentosCodProduto: TIntegerField;
    FDMemMovRessuprimentosDescricao: TStringField;
    FDMemMovRessuprimentosProcessoId: TIntegerField;
    FDMemMovRessuprimentosProcesso: TStringField;
    FDMemMovRessuprimentosQtdSuprida: TIntegerField;
    FDMemMovRessuprimentosCodigoERP: TIntegerField;
    FDMemMovRessuprimentosRazao: TStringField;
    FDMemMovRecebimentosCodPessoaERP: TIntegerField;
    FDMemMovRecebimentosRazao: TStringField;
    Label24: TLabel;
    Label25: TLabel;
    LblTotRessuprimentos: TLabel;
    LblTotRecebimentos: TLabel;
    LblTotRegCaption: TLabel;
    LblTotRegistro: TLabel;
    Label26: TLabel;
    LblTotRegEstoque: TLabel;
    ChkAtenderCxaFechada: TCheckBox;
    EdtCurva: TLabeledEdit;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure edtCodProdutoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
    procedure TabLotesShow(Sender: TObject);
    procedure LstLotesDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure AdvSGCodBarrasDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure AdvSGCodBarrasGetEditorProp(Sender: TObject; ACol, ARow: Integer;
      AEditLink: TEditLink);
    procedure AdvSGCodBarrasGetEditorType(Sender: TObject; ACol, ARow: Integer;
      var AEditor: TEditorType);
    procedure TabCodBarrasShow(Sender: TObject);
    procedure AdvSGCodBarrasClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure TmAtualizarLstCodBarrasTimer(Sender: TObject);
    procedure PgcBaseChange(Sender: TObject);
    procedure EdtCodBarrasExit(Sender: TObject);
    procedure ChkMedicamentoClick(Sender: TObject);
    procedure EdtPickingExit(Sender: TObject);
    procedure EdtPickingEnter(Sender: TObject);
    procedure edtDescricaoEnter(Sender: TObject);
    procedure edtDescricaoExit(Sender: TObject);
    procedure EdtZonaArmazenagemIdEnter(Sender: TObject);
    procedure EdtZonaArmazenagemIdExit(Sender: TObject);
    procedure EdtLaboratorioIdExit(Sender: TObject);
    procedure EdtUnidadeIdExit(Sender: TObject);
    procedure EdtUnidadeSecundariaIdExit(Sender: TObject);
    procedure EdtLaboratorioIdChange(Sender: TObject);
    procedure EdtUnidadeIdChange(Sender: TObject);
    procedure EdtUnidadeSecundariaIdChange(Sender: TObject);
    procedure EdtPickingChange(Sender: TObject);
    procedure EdtZonaArmazenagemIdChange(Sender: TObject);
    procedure EdtLaboratorioIdKeyPress(Sender: TObject; var Key: Char);
    procedure BtnCancelarLoteClick(Sender: TObject);
    procedure BtnSalvarLoteClick(Sender: TObject);
    procedure ChkCodBarrasStatusClick(Sender: TObject);
    procedure BtnCancelarCodBarrasClick(Sender: TObject);
    procedure BtnNovoCodBarrasClick(Sender: TObject);
    procedure BtnSalvarCodBarrasClick(Sender: TObject);
    procedure PgcBasePageChanging(Sender: TObject; NewPage: TcxTabSheet;
      var AllowChange: Boolean);
    procedure SpPaginacaoBottomClick(Sender: TObject);
    procedure TabEstoqueEnderecoShow(Sender: TObject);
    procedure EdtAlturaChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtCodProdutoChange(Sender: TObject);
    //procedure BtnOpeFileClick(Sender: TObject);
    procedure BtnImportarStandClick(Sender: TObject);
    procedure BtnImportClick(Sender: TObject);
    procedure BtnPesqFabricante(Sender: TObject);
    procedure BtnCapturarPesoClick(Sender: TObject);
    procedure Panel5Click(Sender: TObject);
    procedure sImage6Click(Sender: TObject);
    procedure TabMovimentacaoShow(Sender: TObject);
    procedure DbgRecebimentosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure EdtDescricaoLoteExit(Sender: TObject);
    procedure EdtDescricaoLoteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPesqUnidadePrimariaClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    ObjProdutoCtrl         : TProdutoCtrl;
    ObjRastroCtrl          : TRastroCtrl;
    ObjProdutoTipoCtrl     : TProdutoTipoCtrl;
    ObjMedicamentoTipoCtrl : TMedicamentoTipoCtrl;
    ObjCodBarrasCtrl       : TProdutoCodBarrasCtrl;
    ObjLoteCtrl            : TLoteCtrl;
    LstRastro              : TObjectList<TRastro>;
    LstProdutoTipo         : TObjectList<TProdutoTipo>;
    LstMedicamentoTipo     : TObjectList<TMedicamentoTipo>;
    pNewCodBarras          : Boolean;
    GetMov : Boolean;
    Procedure AtualizarLstCodBarras;
    Function GetListaProduto(pId, pCodigoERP : String; pDescricao : String; pRecsSkip : Integer; pPicking : String) : Boolean;
    Procedure GetListaProdutoLotes;
    Procedure GetListaProdutoCodBarras(pProdutoCodBarrasId : Integer = 0; pProdutoId : Integer = 0; pCodBarras : String = '*');
    Procedure GetListaEstoqueEndereco;
    Function DeleteCodBarras(pCodBarrasId : Integer) : Boolean;
    Procedure BtnCrudLote(pAtivar : Boolean);
    Procedure BtnCrudEan(pAtivar : Boolean);
    Procedure DefineField;
    Procedure GetMovimentacao;
    Procedure UpdatePicking;
  Protected
    Procedure ShowDados; override;
  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Function SalvarReg : Boolean; OverRide;
    procedure OpenFileImport; OverRide;
  public
    { Public declarations }
  end;

var
  FrmProduto: TFrmProduto;

implementation

{$R *.dfm}

uses uFrmeXactWMS, uFuncoes, EstoqueCtrl, EstoqueClass,
  Views.Pequisa.Laboratorio, PessoaEnderecoCtrl, typinfo,
  ACBrUtil, ACBrDeviceSerial, Views.Pequisa.EnderecamentoZonas;

{ TFrmProduto }

procedure TFrmProduto.AdvSGCodBarrasClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aCol = 6) and (aRow >= 1) and (StrToIntDef(AdvSGCodBarras.Cells[0, aRow], 0) > 0) and
     (MessageDlg('Deseja Excluir esse Código de Barras('+AdvSGCodBarras.Cells[1, ARow]+')?', mtConfirmation, [MbYes, MbNo] ,0) = MrYes) then begin
     DeleteCodBarras(AdvSGCodBarras.Cells[0, ARow].ToInteger());
     GetListaProdutoCodBarras(0, ObjProdutoCtrl.ObjProduto.IdProduto);
  End;
end;

procedure TFrmProduto.AdvSGCodBarrasDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (Acol = 0) and (aRow > 0) then Begin
     EdtCodBarras.Text     := AdvSGCodBarras.Cells[1, aRow];
     EdtUnidEmbalagem.Text := AdvSGCodBarras.Cells[2, aRow];
     ChkCodBarrasPrincipal.Checked := AdvSGCodBarras.Cells[4, aRow] = '1';
     ChkCodBarrasStatus.Checked    := AdvSGCodBarras.Cells[5, aRow] = '1';
     ObjCodBarrasCtrl.ObjProdutoCodBarras.CodBarrasId := AdvSGCodBarras.Cells[0, aRow].ToInteger;
     ObjCodBarrasCtrl.ObjProdutoCodBarras.ProdutoID   := ObjProdutoCtrl.ObjProduto.IdProduto;
     ObjCodBarrasCtrl.ObjProdutoCodBarras.CodBarras   := AdvSGCodBarras.Cells[1, aRow];
     ObjCodBarrasCtrl.ObjProdutoCodBarras.UnidadesEmbalagem := AdvSGCodBarras.Cells[2, aRow].ToInteger;
     ObjCodBarrasCtrl.ObjProdutoCodBarras.Principal         := AdvSGCodBarras.Cells[4, aRow].ToInteger;
     ObjCodBarrasCtrl.ObjProdutoCodBarras.Status            := AdvSGCodBarras.Cells[5, aRow].ToInteger;
     BtnCrudEan(True);
     pNewCodBarras := False;
  End;
end;

procedure TFrmProduto.AdvSGCodBarrasGetEditorProp(Sender: TObject; ACol,
  ARow: Integer; AEditLink: TEditLink);
Var I : Integer;
begin
//  inherited;
{
   if not Assigned(AEditLink) then
     Exit;
   If aCol In [4,5] then begin
      with (aEditLink.GetEditControl as TImagePicker) do begin
        BeginUpdate;
        Items.Clear;
        //if aCol = 4 then Begin
           for i := 0 to 1 do
             Items.Add.ImageIndex := i;
        //End
        //Else Items.Add.ImageIndex := 2;
        EndUpdate;
      end;
  end;
}
end;

procedure TFrmProduto.AdvSGCodBarrasGetEditorType(Sender: TObject; ACol,
  ARow: Integer; var AEditor: TEditorType);
begin
  inherited;
{
   if (Not aCol In [1, 2, 3]) then
      AdvSGCodBarras.EditLink:=el1
   Else
      AdvSGCodBarras.EditLink:=el6;
   if acol in [1..5] then aEditor:=edCustom;
}
end;

procedure TFrmProduto.AtualizarLstCodBarras;
//Var pProdutoId : Integer;
begin
//  TmAtualizarLstCodBarras.Enabled := False;
//   pProdutoId := Self.ObjProdutoCtrl.ObjProduto.IdProduto;
   TThread.CreateAnonymousThread(procedure begin
     TThread.Synchronize(nil, procedure
     Var ObjThCodBarrasCtrl : TProdutoCodBarrasCtrl;
         LstCodBarras            : TObjectList<TProdutoCodBarrasCtrl>;
         xImg, xLista            : Integer;
     begin
       TmAtualizarLstCodBarras.Enabled := False;
       ObjThCodBarrasCtrl := TProdutoCodBarrasCtrl.Create;
       ObjThCodBarrasCtrl.ObjProdutoCodBarras.ProdutoID := Self.ObjProdutoCtrl.ObjProduto.IdProduto;//pProdutoId;
       LstCodBarras := ObjThCodBarrasCtrl.GetProdutoCodBarras(0, ObjThCodBarrasCtrl.ObjProdutoCodBarras.ProdutoID , '', 0);
       If LstCodBarras.Count >= 1 then
          AdvSGCodBarras.RowCount := LstCodBarras.Count+1;
       for xImg := 1 to AdvSGCodBarras.RowCount - 1 do Begin
         AdvSGCodBarras.AddDataImage(4, xImg, 0, haCenter, vaTop);
         AdvSGCodBarras.AddDataImage(5, xImg, 0, haCenter, vaTop);
         AdvSGCodBarras.AddDataImage(6, xImg, 2, haCenter, vaTop);
       End;
       For xLista := 0 To LstCodBarras.Count-1 do begin
         TThread.Synchronize(nil, procedure
          begin
            With LstCodBarras[xLista].ObjProdutoCodBarras do Begin
              AdvSGCodBarras.Cells[0, xLista+1] := CodBarrasId.ToString();
              AdvSGCodBarras.Cells[1, xLista+1] := Codbarras;
              AdvSGCodBarras.Cells[2, xLista+1] := UnidadesEmbalagem.ToString();
              AdvSGCodBarras.Cells[4, xLista+1] := Principal.ToString();
              AdvSGCodBarras.Cells[5, xLista+1] := Status.ToString();
            End;
            AdvSGCodBarras.Alignments[0, xLista+1] := taRightJustify;
            AdvSGCodBarras.FontStyles[0, xLista+1] := [FsBold];
            AdvSGCodBarras.Alignments[2, xLista+1] := taRightJustify;
            AdvSGCodBarras.Alignments[3, xLista+1] := taCenter;
            AdvSGCodBarras.Alignments[4, xLista+1] := taCenter;
            AdvSGCodBarras.Alignments[5, xLista+1] := taCenter;
            AdvSGCodBarras.Alignments[6, xLista+1] := taCenter;
          End);
       end;
       TmAtualizarLstCodBarras.Enabled := True;
       ObjThCodBarrasCtrl.Free;
     End);
   end).Start;
end;

procedure TFrmProduto.TmAtualizarLstCodBarrasTimer(Sender: TObject);
begin
  inherited;
  AtualizarLstCodBarras;
end;

procedure TFrmProduto.UpdatePicking;
Var JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  if ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId <> 0 then Begin
     GbEnderecoPicking.Enabled := False;
     JsonArrayRetorno := ObjProdutoCtrl.UpdatePicking(ObjProdutoCtrl.ObjProduto.CodProduto);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
        ShowErro(vErro)
     Else
        GbEnderecoPicking.Enabled := JsonArrayRetorno.Items[0].GetValue<Integer>('estoque', 0) = 0;
  End
  Else
     GbEnderecoPicking.Enabled := True;
  if GbEnderecoPicking.Enabled  then Begin
     EdtPicking.Font.Color := ClBlack;
     EdtPicking.Font.Style := [];
  End
  Else Begin
     EdtPicking.Font.Color := ClRed;
     EdtPicking.Font.Style := [fsBold];
  End;
end;

procedure TFrmProduto.BtnPesqFabricante(Sender: TObject);
var LForm: TFrmPesquisaLaboratorio;
begin
  if EdtLaboratorioId.ReadOnly then Exit;
  inherited;
  //ShowForm(TFrmPesquisaLaboratorio, LForm);
  FrmPesquisaLaboratorio := TFrmPesquisaLaboratorio.Create(Application);
  try
    if (FrmPesquisaLaboratorio.ShowModal = mrOk) then  Begin
       EdtLaboratorioId.Text := FrmPesquisaLaboratorio.Tag.ToString();
       EdtLaboratorioIdExit(EdtLaboratorioId);
    End;
  finally
    FreeAndNil(FrmPesquisaLaboratorio);
  end;
end;

procedure TFrmProduto.BitBtn3Click(Sender: TObject);
begin
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
       EdtZonaArmazenagemId.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
       EdtZonaArmazenagemIdExit(EdtZonaArmazenagemId);
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmProduto.BtnCancelarClick(Sender: TObject);
begin
  EdtDescricao.ReadOnly  := False;
  inherited;
end;

procedure TFrmProduto.BtnCancelarCodBarrasClick(Sender: TObject);
begin
  inherited;
  BtnCrudEan(False);
  ShowMessage('Alteração cancelada!');
end;

procedure TFrmProduto.BtnCancelarLoteClick(Sender: TObject);
begin
  inherited;
  BtnCrudLote(False);
end;

procedure TFrmProduto.BtnCapturarPesoClick(Sender: TObject);
var
  I : TACBrBALModelo ;
begin
  inherited;
  if not BtnSalvar.Enabled then begin
     ShowErro('Edite o cadastro para poder Capturar o Peso');
     exit;
  end;
  EdtCodigoERPCapPeso.Text := EdtCodProduto.Text;
  EdtCodigoERPCapPeso.ReadOnly := True;
  EdtDescricaoCapPeso.Text := edtDescricao.Text;
  EdtDescricaoCapPeso.ReadOnly := True;
  EdtPesoAtualCapPeso.Value := EdtPeso.Value;
  EdtPesoAtualCapPeso.ReadOnly := True;
  PnlCapturarPeso.Visible := True;

  cmbBalanca.Items.Clear ;
  For I := Low(TACBrBALModelo) to High(TACBrBALModelo) do
     cmbBalanca.Items.Add( GetEnumName(TypeInfo(TACBrBALModelo), integer(I) ) ) ;
  cmbBalanca.ItemIndex := 0;
end;

procedure TFrmProduto.BtnCrudEan(pAtivar: Boolean);
begin
  BtnSalvarCodBarras.Visible    := pAtivar;
  BtnCancelarCodBarras.Visible  := pAtivar;
  BtnNovoCodBarras.Visible      := Not pAtivar;
  EdtCodBarras.ReadOnly         := Not pAtivar;
  EdtUnidEmbalagem.ReadOnly     := Not pAtivar;
  ChkCodBarrasPrincipal.Enabled := pAtivar;
  ChkCodBarrasStatus.Enabled    := pAtivar;
  PnlLstCodBarras.Enabled       := Not pAtivar;
  PnlLstLotes.Enabled           := Not pAtivar;
  if Not pAtivar then Begin
     EdtCodBarras.Clear;
     EdtUnidEmbalagem.Clear;
     ChkCodBarrasPrincipal.Checked := False;
     ChkCodBarrasStatus.Checked    := False;
  End;
  EdtCodProdutoERPEan.ReadOnly := True;
  EdtDescricaoEan.ReadOnly := True;
end;

procedure TFrmProduto.BtnCrudLote(pAtivar: Boolean);
begin
  BtnSalvarLote.Visible        := pAtivar;
  BtnCancelarLote.Visible      := pAtivar;
  EdtDescricaoLote.ReadOnly    := Not pAtivar;
  EdtDtFabricacaoLote.ReadOnly := Not pAtivar;
  EdtDtVencimentoLote.ReadOnly := Not pAtivar;
  if Not pAtivar then Begin
     EdtDescricaoLote.Clear;
     EdtDtFabricacaoLote.Clear;
     EdtDtVencimentoLote.Clear;
  End;
  EdtCodProdutolote.ReadOnly   := True;
  EdtDescrProdutoLote.ReadOnly := True;
end;

procedure TFrmProduto.BtnEditarClick(Sender: TObject);
begin
  //if (Not FrmRhemaWMS.ConfigWMS.CadProdutoIncluir) then
  //   raise Exception.Create('Operação não permitida!');
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produto - Editar') then
     raise Exception.Create('Acesso não autorizado a esta funcionalidade!');
  if ((PgcBase.ActivePage = TabLotes) or (PgcBase.ActivePage = TabCodBarras)) and
     ((BtnSalvarLote.Visible) or (BtnSalvarCodBarras.Visible))then
     raise Exception.Create('Conclua a operação em andamento!');
  if (ObjProdutoCtrl.ObjProduto.IdProduto = 0) or (StrToIntDef(EdtCodProduto.Text, 0) <= 0) then
     raise Exception.Create('Selecione o Id para alteração');
  inherited;
  CbProdutoTipo.SetFocus;
  EdtDescricao.ReadOnly         := True;
  TabLotes.TabVisible           := False;
  TabMovimentacao.TabVisible    := False;
  TabCodBarras.TabVisible       := False;
  TabEstoqueEndereco.TabVisible := False;
  EdtCodProduto.Enabled         := False;
  UpdatePicking;
end;

procedure TFrmProduto.BtnExcluirClick(Sender: TObject);
begin
  if ((PgcBase.ActivePage = TabLotes) or (PgcBase.ActivePage = TabCodBarras)) and ((BtnSalvarLote.Enabled) or (BtnSalvarCodBarras.Enabled))then
     raise Exception.Create('Conclua a operação em andamento!');
  raise Exception.Create('Operação não permitida!');
  inherited;
  If ObjProdutoCtrl.DelProduto(StrToIntDef(EdtCodProduto.Text, 0)) then
     Limpar;
end;

procedure TFrmProduto.BtnImportarStandClick(Sender: TObject);
begin
  if EdtCodProduto.ReadOnly = True then Exit;
  inherited;
end;

procedure TFrmProduto.BtnImportClick(Sender: TObject);
Var RetJsonArray : TJsonArray;
    vErro :String;
    vProblema : Boolean;
    xImport   : Integer;
begin
  if (Not FdMemPesqGeral.Active) or (FdMemPesqGeral.RecordCount<1) then
     raise Exception.Create('Não há dados para Importação!');
  if RgTipoImportacao.ItemIndex < 0 then
     raise Exception.Create('Informe o tipo de arquivo para importação.');
  inherited;
  mmImporta.Lines.Clear;
  PbImportaFile.Max      := FdMemPesqGeral.RecordCount;
  PbImportaFile.Position := 0;
  vProblema := False;
//  FdMemPesqGeral.First;
  xImport := 0;
  While Not FdMemPesqGeral.Eof Do Begin
    if RgTipoImportacao.ItemIndex = 0 then Begin
       if (Not ObjProdutoCtrl.ImportDados(FdMemPesqGeral.FieldByName('CodProduto').AsInteger,
                                  StringReplace(FdMemPesqGeral.FieldByName('Descricao').AsString, '%', '', [rfReplaceAll] ),
                                  FdMemPesqGeral.FieldByName('Unidade').AsString,
                                  FdMemPesqGeral.FieldByName('Embalagem').AsInteger,
                                  FdMemPesqGeral.FieldByName('LaboratorioId').AsInteger,
                                  FdMemPesqGeral.FieldByName('Fabricante').AsString,
                                  FdMemPesqGeral.FieldByName('Sngpc').AsInteger,
                                  FdMemPesqGeral.FieldByName('Curva').AsString) ) then Begin
          MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString+' - '+
                               FdMemPesqGeral.FieldByName('Descricao').AsString);
          vProblema := True;
       End;
    End
    Else If RgTipoImportacao.ItemIndex = 1 then Begin
       if (Not ObjProdutoCtrl.ImportCubagemDC(FdMemPesqGeral.FieldByName('CodProduto').AsInteger,
                                  FdMemPesqGeral.FieldByName('FatorConversao').AsFloat,
                                  FdMemPesqGeral.FieldByName('Altura').AsFloat,
                                  FdMemPesqGeral.FieldByName('Largura').AsFloat,
                                  FdMemPesqGeral.FieldByName('Comprimento').AsFloat,
                                  FdMemPesqGeral.FieldByName('Peso').AsFloat,
                                  FdMemPesqGeral.FieldByName('Ean01').AsString,
                                  FdMemPesqGeral.FieldByName('Ean02').AsString,
                                  FdMemPesqGeral.FieldByName('Ean03').AsString,
                                  FdMemPesqGeral.FieldByName('Ean04').AsString,
                                  FdMemPesqGeral.FieldByName('Ean05').AsString,
                                  FdMemPesqGeral.FieldByName('Ean06').AsString,
                                  FdMemPesqGeral.FieldByName('Ean07').AsString,
                                  FdMemPesqGeral.FieldByName('Ean08').AsString,
                                  FdMemPesqGeral.FieldByName('Ean09').AsString,
                                  FdMemPesqGeral.FieldByName('Ean10').AsString ) ) then Begin
          MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString);
          vProblema := True;
       End;
{       if (Not ObjProdutoCtrl.ImportCubagem(FdMemPesqGeral.FieldByName('CodProduto').AsInteger,
                                  FdMemPesqGeral.FieldByName('Altura').AsFloat,
                                  FdMemPesqGeral.FieldByName('Largura').AsFloat,
                                  FdMemPesqGeral.FieldByName('Comprimento').AsFloat) ) then Begin
          MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString);
          vProblema := True;
       End;
}    End
    Else If RgTipoImportacao.ItemIndex = 2 then Begin
       if (Not ObjProdutoCtrl.ImportEstoque(FdMemPesqGeral.FieldByName('CodProduto').AsInteger,
                                            FdMemPesqGeral.FieldByName('Endereco').AsString,
                                            FdMemPesqGeral.FieldByName('Quantidade').AsInteger) ) then Begin
          MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString+' - '+
                               FdMemPesqGeral.FieldByName('Endereco').AsString);
          vProblema := True;
       End;
    End
    Else If RgTipoImportacao.ItemIndex = 3 then Begin //Endereçamento
       RetJsonArray := ObjProdutoCtrl.ImportEnderecamento(FdMemPesqGeral.FieldByName('CodProduto').AsInteger,
                                            FdMemPesqGeral.FieldByName('Endereco').AsString);
       if (RetJsonArray.Items[0].TryGetValue<String>('Erro', vErro)) then
          MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString+' - '+
                               FdMemPesqGeral.FieldByName('Endereco').AsString)
       Else if RetJsonArray.Items[0].GetValue<Integer>('idproduto') <= 0 then
          MmImporta.Lines.Add('Endereco invalido:  - '+
                               FdMemPesqGeral.FieldByName('Endereco').AsString);
       vProblema := True;
    End
    Else If RgTipoImportacao.ItemIndex = 4 then Begin //Ean
       RetJsonArray := ObjProdutoCtrl.ImportEan(FdMemPesqGeral.FieldByName('CodProduto').AsInteger,
                                            FdMemPesqGeral.FieldByName('Ean').AsString,
                                            FdmemPesqGeral.FieldByName('QtdEmbalagem').Asinteger);
       if (RetJsonArray.Items[0].TryGetValue<String>('Erro', vErro)) then
          MmImporta.Lines.Add(FdMemPesqGeral.FieldByName('CodProduto').AsString+' - '+
                               FdMemPesqGeral.FieldByName('Ean').AsString);
       vProblema := True;
       Inc(xImport);
{       Try
         RetJsonArray := Nil;
       Except
         ShowMessage('Erro aqui')
       End;
 }   End;
    PbImportaFile.Position := PbImportaFile.Position + 1;
    Application.ProcessMessages;
    FdMemPesqGeral.Next;
  End;
  RetJsonArray := Nil;
  if Not vProblema then
     ShowMessage('Importação concluída...')
  Else ShowMessage('Importação concluída com erros...');
end;

procedure TFrmProduto.BtnIncluirClick(Sender: TObject);
begin
  if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.CadProdutoIncluir = 0) then
     raise Exception.Create('Operação não permitida!');
  inherited;
  CbRastroTipo.SetFocus;
  EdtCodProduto.Enabled := False;
end;

procedure TFrmProduto.BtnNovoCodBarrasClick(Sender: TObject);
begin
  inherited;
  pNewCodBarras := True;
  BtnCrudEan(True);
  ObjCodBarrasCtrl.ObjProdutoCodBarras.CodBarrasId       := 0;
  ObjCodBarrasCtrl.ObjProdutoCodBarras.ProdutoID         := ObjProdutoCtrl.ObjProduto.IdProduto;
  ObjCodBarrasCtrl.ObjProdutoCodBarras.CodBarras         := '';
  ObjCodBarrasCtrl.ObjProdutoCodBarras.UnidadesEmbalagem := 1;
  ObjCodBarrasCtrl.ObjProdutoCodBarras.Principal         := 0;
  ObjCodBarrasCtrl.ObjProdutoCodBarras.Status            := 0;
  ChkCodBarrasStatus.Checked := True;
  EdtCodBarras.SetFocus;
end;

procedure TFrmProduto.BtnPesquisarStandClick(Sender: TObject);
var JsonRetorno : tJsonArray;
    jSonProduto, JSonProdutoTipo, JsonMedicamentoTipo, JSonLaboratorio,
    JSonUnidade, JSonUnidadeSecundaria, JSonEnderecamentoZona, JSonEndereco,
    JSonDesenhoArmazem : tJsonObject;
    xReg : Integer;
begin
  inherited;
  //
end;

procedure TFrmProduto.BtnPesqUnidadePrimariaClick(Sender: TObject);
begin
  inherited;
  if TLabeledEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaUnidades := TFrmPesquisaUnidades.Create(Application);
  try
    if (FrmPesquisaUnidades.ShowModal = mrOk) Then Begin
       if Sender = BtnPesqUnidadePrimaria then Begin
          EdtunidadeId.Text := FrmPesquisaUnidades.Tag.ToString;
          EdtUnidadeIdExit(EdtUnidadeId);
       End
       Else if Sender = BtnPesqUnidadeSecundaria then Begin
          EdtUnidadeSecundariaId.Text := FrmPesquisaUnidades.Tag.ToString;
          EdtUnidadeSecundariaIdExit(EdtUnidadeSecundariaId);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaUnidades);
  end;
end;

procedure TFrmProduto.BtnSalvarClick(Sender: TObject);
begin
  EdtDescricao.ReadOnly  := False;
  inherited;
end;

procedure TFrmProduto.BtnSalvarCodBarrasClick(Sender: TObject);
begin
  inherited;
  if EdtUnidEmbalagem.Value <= 0 then
     raise Exception.Create('Unidades por embalagem inválida!');
  EdtCodBarrasExit(EdtCodBarras);
  Try
    ObjCodBarrasCtrl.ObjProdutoCodBarras.CodBarras := EdtCodBarras.Text;
    ObjCodBarrasCtrl.ObjProdutoCodBarras.UnidadesEmbalagem := StrToIntDef(EdtUnidEmbalagem.Text, 1);
    ObjCodBarrasCtrl.ObjProdutoCodBarras.Principal := Ord(ChkCodBarrasPrincipal.Checked);
    ObjCodBarrasCtrl.ObjProdutoCodBarras.Status    := Ord(ChkCodBarrasStatus.Checked);
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
  if ObjCodBarrasCtrl.Salvar then Begin
     BtnCrudEan(False);
     ShowMessage('Código de Barras Salvo com sucesso!');
     GetListaProdutoCodBarras(0, ObjProdutoCtrl.ObjProduto.IdProduto);
  End;
end;

procedure TFrmProduto.BtnSalvarLoteClick(Sender: TObject);
begin
  inherited;
  Try
    ObjLoteCtrl.ObjLote.DescrLote  := EdtDescricaoLote.Text;
    ObjLoteCtrl.ObjLote.Fabricacao := StrToDate(EdtDtFabricacaoLote.Text);
    ObjLoteCtrl.ObjLote.Vencimento := StrToDate(EdtDtVencimentoLote.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
  if ObjLoteCtrl.Salvar then Begin
     BtnCrudLote(False);
     ShowMessage('Lote alterado com sucesso');
     GetListaProdutoLotes;
  End;
end;

procedure TFrmProduto.OpenFileImport; //BtnOpeFileClick(Sender: TObject);
var ArquivoCSV: TextFile;
    Linha : String;
    I : Integer;
    vEmbalagem, vAltura, vLargura, vComprimento, vPeso, vCodProduto, pEndereco, vPicking, vSngpc, vErro : String;
    ObjEnderecoCtrl   : TEnderecoCtrl;
    ObjProdutoCtrl    : TProdutoCtrl;
    JsonArrayProduto, JsonArrayEndereco : TJsonArray;
    vLaboratorioId    : Integer;
    vEan01, vEan02, vEan03, vEan04, vEan05 : String;
    vEan06, vEan07, vEan08, vEan09, vEan10 : String;
  Function MontaValor: String;
  var
    ValorMontado: String;
  begin
    ValorMontado := '';
    inc(I);
    While Linha[I] >= ' ' do
    begin
      If Linha[I] = ';' then // vc pode usar qualquer delimitador ... eu
        // estou usando o ";"
        break;
      ValorMontado := ValorMontado + Linha[I];
      inc(I);
    end;
    result := ValorMontado;
  end;
begin
  inherited;
  DefineField;
  if EdtFileIimport.Text = '' then
     raise Exception.Create('Informe o arquivo a ser importado!');
  if Not FileExists(EdtFileIimport.Text) then Begin
     ShowMessage('Arquivo para Importacao não encontrado.');
     Exit;
  End;
  AssignFile(ArquivoCSV, EdtFileIimport.Text);
  try
    TmImportacaoCSV.Enabled := True;
    Reset(ArquivoCSV);
    Readln(ArquivoCSV, Linha);    //Pular Cabecalho
    while not Eoln(ArquivoCSV) do begin
      Readln(ArquivoCSV, Linha);
      I := 0;
      //vCdProduto := MontaValor;
      FdMemPesqGeral.Append;
      if RgTipoImportacao.ItemIndex = 0 then Begin
         FdMemPesqGeral.FieldByName('CodProduto').AsInteger := StrToInt64(MontaValor);
         FdMemPesqGeral.FieldByName('Descricao').AsString   := MontaValor;
         FdMemPesqGeral.FieldByName('Unidade').AsString     := 'UN';
         FdMemPesqGeral.FieldByName('Embalagem').AsInteger  := StrTointDef(MontaValor, 1);
         vSngpc := MontaValor;
         FdMemPesqGeral.FieldByName('Sngpc').AsInteger  := StrToIntDef(vSngpc, 0);
         FdMemPesqGeral.FieldByName('Curva').AsString  := MontaValor;
         vLaboratorioId := StrToIntDef(MontaValor, 0);
         FdMemPesqGeral.FieldByname('LaboratorioId').AsInteger := StrToIntDef(MontaValor, 0);
         FdMemPesqGeral.FieldByName('Fabricante').AsString     := MontaValor;
         if (vSngpc='1') or (UpperCase(vSngpc)='SIM') or (upperCase(vSngpc)='S') then
            vSngpc := '1'
         Else vSngpc := '0';
         FdMemPesqGeral.FieldByName('Sngpc').AsInteger      := StrTointDef(vSngpc, 0);
//         FdMemPesqGeral.FieldByName('Curva').AsString       := MontaValor
      End
      Else if RgTipoImportacao.ItemIndex = 1 Then Begin
        // MontaValor;
         FdMemPesqGeral.FieldByName('CodProduto').AsInteger := StrToInt64(MontaValor);
         MontaValor;
         vEmbalagem   := MontaValor;
         if (StrToInt(vEmbalagem) = 0) or (StrToInt(vEmbalagem) = 1000) then
            vEmbalagem := '1';
         vComprimento := MontaValor;
         if vComprimento = '' then vComprimento := '0';
         //vComprimento := StringReplace(vComprimento, ',', '.', [rfReplaceAll]); //
         vLargura     := MontaValor;
         if vLargura = '' then vLargura := '0';
         //vLargura := StringReplace(vLargura, ',', '.', [rfReplaceAll]); //
         vAltura      := MontaValor;
         if vAltura  = '' then vAltura := '0';
         //vAltura := StringReplace(vAltura, ',', '.', [rfReplaceAll]); //
         montaValor;
         vPeso := MontaValor;
         if StrToInt(vPeso) = 0 then
            vPeso := '1';
         MontaValor;
         vEan01 := MontaValor;
         vEan02 := MontaValor;
         vEan03 := MontaValor;
         vEan04 := MontaValor;
         vEan05 := MontaValor;
         vEan06 := MontaValor;
         vEan07 := MontaValor;
         vEan08 := MontaValor;
         vEan09 := MontaValor;
         vEan10 := MontaValor;
         if vEan01 = 'NULL' then vEan01 := '';
         if vEan02 = 'NULL' then vEan02 := '';
         if vEan03 = 'NULL' then vEan03 := '';
         if vEan04 = 'NULL' then vEan04 := '';
         if vEan05 = 'NULL' then vEan05 := '';
         if vEan06 = 'NULL' then vEan06 := '';
         if vEan07 = 'NULL' then vEan07 := '';
         if vEan08 = 'NULL' then vEan08 := '';
         if vEan09 = 'NULL' then vEan09 := '';
         if vEan10 = 'NULL' then vEan10 := '';
         FdMemPesqGeral.FieldByName('FatorConversao').AsFloat    := StrToFloat(vEmbalagem);
         FdMemPesqGeral.FieldByName('Comprimento').AsFloat  := StrToFloat(vComprimento);
         FdMemPesqGeral.FieldByName('Largura').AsFloat      := StrToFloat(vLargura);
         FdMemPesqGeral.FieldByName('Altura').AsFloat       := StrToFloat(vAltura);
         FdMemPesqGeral.FieldByName('Peso').AsFloat         := StrToFloat(vPeso);
         FdMemPesqGeral.FieldByName('Ean01').AsString       := vEan01;
         FdMemPesqGeral.FieldByName('Ean02').AsString       := vEan02;
         FdMemPesqGeral.FieldByName('Ean03').AsString       := vEan03;
         FdMemPesqGeral.FieldByName('Ean04').AsString       := vEan04;
         FdMemPesqGeral.FieldByName('Ean05').AsString       := vEan05;
         FdMemPesqGeral.FieldByName('Ean06').AsString       := vEan06;
         FdMemPesqGeral.FieldByName('Ean07').AsString       := vEan07;
         FdMemPesqGeral.FieldByName('Ean08').AsString       := vEan08;
         FdMemPesqGeral.FieldByName('Ean09').AsString       := vEan09;
         FdMemPesqGeral.FieldByName('Ean10').AsString       := vEan10;
      End
      Else If RgTipoImportacao.ItemIndex = 2 then Begin
         vCodProduto := MontaValor;
         if vcodProduto = '166823' then
            ShowMessage('Erro agora');
         FdMemPesqGeral.FieldByName('CodProduto').AsInteger := StrToInt64(vCodProduto);
         ObjProdutoCtrl := TProdutoCtrl.Create;
         JsonArrayProduto := ObjProdutoCtrl.FindProduto('0', vCodProduto, '', 0, 0);
         If (JsonArrayProduto.Count<1) or (JsonArrayProduto.Items[0].TryGetValue<String>('Erro', vErro)) then
            FdMemPesqGeral.FieldByName('Observacao').AsString  := 'Produto não Encontrado'
         Else Begin
            vPicking := JsonArrayProduto.Items[0].GetValue<TJsonObject>('endereco').GetValue<String>('descricao');
            pEndereco := MontaValor;
            FdMemPesqGeral.FieldByName('Endereco').AsString    := pEndereco;
            FdMemPesqGeral.FieldByName('Quantidade').AsInteger := StrTointDef(MontaValor, 0);

            ObjEnderecoCtrl := TEnderecoCtrl.Create;
            JsonArrayEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, pEndereco, pEndereco, 'T', 2, 0);
            If JsonArrayEndereco.Items[0].TryGetValue<String>('Erro', vErro) then
               FdMemPesqGeral.FieldByName('Observacao').AsString  := Copy(vErro, 1, 50)
            Else begin
               FdmemPesqGeral.FieldByName('Tipo').AsString        := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
               FdMemPesqGeral.FieldByName('Picking').AsString     := vPicking;
               If (JsonArrayEndereco.Items[0].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao') = 'Picking') and
                  (vPicking<>pEndereco) then
               FdMemPesqGeral.FieldByName('Observacao').AsString  := 'Picking errado';
            End;
            FreeAndNil(ObjEnderecoCtrl);
         End;
         FreeAndNil(ObjProdutoCtrl);
      End
      Else If RgTipoImportacao.ItemIndex = 3 then Begin  //Enderecamento
         FdMemPesqGeral.FieldByName('CodProduto').AsInteger := StrToInt64(MontaValor);
         FdMemPesqGeral.FieldByName('Endereco').AsString    := MontaValor;
      End
      Else If RgTipoImportacao.ItemIndex = 4 then Begin  //Ean/Código de Barras
         FdMemPesqGeral.FieldByName('CodProduto').AsInteger   := StrToInt64(MontaValor);
         FdMemPesqGeral.FieldByName('Ean').AsString           := MontaValor;
         Try
           FdMemPesqGeral.FieldByName('QtdEmbalagem').AsInteger := StrToInt(MontaValor);
         Except
           FdMemPesqGeral.FieldByName('QtdEmbalagem').AsInteger := 1;
         End;
      End;
      LblImportaCSV.Caption := 'Lendo Arquivo: '+FdMemPesqGeral.FieldByName('CodProduto').AsString;
      Application.ProcessMessages;
    end;
  finally
    CloseFile(ArquivoCSV);
  end;
  FdMemPesqGeral.First;
  LblImportaCSV.Caption := 'Geral: '+FormatFloat('########0',FdMemPesqGeral.RecordCount);
  TmImportacaoCSV.Enabled := False;
  LblAguardeImportacaoCSV.Visible := False;
end;

procedure TFrmProduto.ChkCodBarrasStatusClick(Sender: TObject);
begin
  inherited;
  if ChkCodBarrasStatus.Checked then begin
     ShCodBarras.Pen.Color   := ClGreen;
     ShCodBarras.Brush.Color := ClGreen;
  end
  Else begin
     ShCodBarras.Pen.Color   := ClRed;
     ShCodBarras.Brush.Color := ClRed;
  end;
end;

procedure TFrmProduto.ChkMedicamentoClick(Sender: TObject);
begin
  inherited;
  EdtCodigoMS.Visible := ChkMedicamento.Checked;
  ChkSNGPC.Visible    := ChkMedicamento.Checked;
end;

procedure TFrmProduto.DbgRecebimentosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  With TDbGrid(Sender) do Begin //DbgItens
    Canvas.Font.Color := clBlack; // Fonte na cor preta
    if (gdSelected in State) then
       TDbGrid(Sender).Canvas.Font.Style := [fsBold] // Fonte em destaque quando for a linha selecionada
    else TDbGrid(Sender).Canvas.Font.Style := [];
    if ((Sender=DbgRecebimentos) and ((FDMemMovRecebimentos.RecNo Mod 2) = 0)) or
       ((Sender=DbgRessuprimentos) and ((FDMemMovRessuprimentos.RecNo Mod 2) = 0)) then
       Canvas.Brush.Color := $00FBF9F7
    Else
       Canvas.Brush.Color := ClWhite;
    Canvas.FillRect(Rect);
    DefaultDrawColumnCell(Rect, DataCol, Column, State);
  End;
end;

procedure TFrmProduto.DefineField;
begin
  If FdMemPesqGeral.Active then Begin
     FdMemPesqGeral.FieldDefs.Clear;
     FdMemPesqGeral.Close;
  End;
  if (RgTipoImportacao.ItemIndex = 0) Then with FdMemPesqGeral.FieldDefs do begin
     Add('Codproduto',ftInteger,0,False);
     Add('Descricao',ftString, 80,False);
     Add('Unidade', ftString, 30, False);
     Add('Embalagem', FtInteger, 0, False);
     Add('Sngpc', FtInteger, 0, False);
     Add('Curva', ftString, 2, False);
     Add('LaboratorioId', ftInteger, 0, False);
     Add('Fabricante', ftString, 50, False);
     //Add('CodBarra',ftString, 25,False);
//     Add('FatorConversao',ftInteger, 0,False);
  End
  Else If (RgTipoImportacao.ItemIndex = 1) Then With FdMemPesqGeral.FieldDefs do begin
     Add('Codproduto',ftInteger,0,False);
     Add('FatorConversao', ftInteger, 0, False);
     Add('Altura',ftFloat, 0,False);
     Add('Largura',ftFloat, 0,False);
     Add('Comprimento',ftFloat, 0,False);
     Add('Peso',ftFloat, 0,False);
     Add('Ean01',ftString, 25, False);
     Add('Ean02',ftString, 25, False);
     Add('Ean03',ftString, 25, False);
     Add('Ean04',ftString, 25, False);
     Add('Ean05',ftString, 25, False);
     Add('Ean06',ftString, 25, False);
     Add('Ean07',ftString, 25, False);
     Add('Ean08',ftString, 25, False);
     Add('Ean09',ftString, 25, False);
     Add('Ean10',ftString, 25, False);
  End
  Else If (RgTipoImportacao.ItemIndex = 2) Then With FdMemPesqGeral.FieldDefs do begin
     Add('Codproduto',ftInteger, 0,False);
     Add('Endereco',ftString,    11,False);
     Add('Quantidade',ftInteger, 0,False);
     Add('Tipo', ftString, 20, False);
     Add('Picking', ftString, 11, False);
     Add('Observacao', ftString, 50, False);
  End
  Else If (RgTipoImportacao.ItemIndex = 3) Then With FdMemPesqGeral.FieldDefs do begin //Enderecamento
     Add('Codproduto',ftInteger, 0,False);
     Add('Endereco',ftString,    11,False);
  End
  Else If (RgTipoImportacao.ItemIndex = 4) Then With FdMemPesqGeral.FieldDefs do begin //Enderecamento
     Add('Codproduto',   ftInteger, 0, False);
     Add('Ean',          ftString, 25, False);
     Add('qtdembalagem', ftInteger, 0, False);
  End;
  FdMemPesqGeral.CreateDataSet;
  FdMemPesqGeral.Open;
end;

function TFrmProduto.DeleteCodBarras(pCodBarrasId : Integer) : Boolean;
Var ObjProdutoCodBarras : TProdutoCodBarrasCtrl;
begin
  ObjProdutoCodBarras := TProdutoCodBarrasCtrl.Create;
  ObjProdutoCodBarras.ObjProdutoCodBarras.CodBarrasID := pCodBarrasId;
  If ObjProdutoCodBarras.DelProdutoCodBarras then
     GetListaProdutoCodBarras(0, ObjProdutoCtrl.ObjProduto.IdProduto, '');
  ObjProdutoCodBarras.Free;
end;

procedure TFrmProduto.EdtAlturaChange(Sender: TObject);
begin
  inherited;
  EdtVolume.Value := EdtAltura.Value * EdtLargura.Value * EdtComprimento.Value;
end;

procedure TFrmProduto.EdtCodBarrasExit(Sender: TObject);
Var ObjProdCodBarras : TProdutoCodBarrasCtrl;
    LstCodBarras     :  TObjectList<TProdutoCodBarrasCtrl>;
    xItem : Integer;
begin
  inherited;
  if BtnSalvarCodBarras.Visible then Begin
     ObjProdCodBarras := TProdutoCodBarrasCtrl.Create;
     LstCodBarras := ObjProdCodBarras.GetProdutoCodBarras(0, 0, EdtCodBarras.Text, 0);
     if (LstCodBarras.Count>0) and (LstCodBarras[0].ObjProdutoCodBarras.CodBarrasID <> ObjCodBarrasCtrl.ObjProdutoCodBarras.CodBarrasID) then Begin
        raise Exception.Create('Ean(Código de Barras) já cadastrado!');
        //ObjProdCodBarras.Free;
        //LstCodBarras.DisposeOf;
     End;
     ObjProdCodBarras.Free;
     FreeAndNil(LstCodBarras);
  End;
end;

procedure TFrmProduto.edtCodProdutoChange(Sender: TObject);
begin
  inherited;
  if (Not EdtCodProduto.ReadOnly) and (StrToInt64Def(EdtCodProduto.Text,0)<>ObjProdutoCtrl.ObjProduto.CodProduto) then Begin
     Limpar;
     TabLotes.TabVisible     := False; //EdtCodProduto.Text <> '';
     TabCodBarras.TabVisible := False; //EdtCodProduto.Text <> '';
     TabEstoqueEndereco.TabVisible := False; //EdtCodProduto.Text <> '';
     TabMovimentacao.TabVisible    := False; //EdtCodProduto.Text <> '';
  End
end;

procedure TFrmProduto.edtCodProdutoExit(Sender: TObject);
begin
  inherited;
  if (Not EdtCodProduto.ReadOnly) and (EdtCodProduto.Text<>'') and (StrToInt64Def(EdtCodProduto.Text,0)<>ObjProdutoCtrl.ObjProduto.CodProduto) then Begin
     Limpar;
     if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then
        raise Exception.Create('Id inválido para pesquisa!');
     //ObjProdutoCtrl.GetCodigoERP(EdtCodProduto.Text);
     ObjProdutoCtrl.FindProduto('0', EdtCodProduto.Text, '', 0, 0);
     if ObjProdutoCtrl.ObjProduto.IdProduto > 0 then
        ShowDados
     Else begin
        ShowErro('Produto não encontrado!');
        EdtCodProduto.SetFocus;
     end;
  End;
  ExitFocus(Sender);
end;

procedure TFrmProduto.edtCodProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmProduto.EdtConteudoPesqKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if CbCampoPesq.ItemIndex in [0, 1] then
     SoNumeros(Key);
end;

procedure TFrmProduto.edtDescricaoEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmProduto.edtDescricaoExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmProduto.EdtZonaArmazenagemIdChange(Sender: TObject);
begin
  inherited;
  if EdtZonaArmazenagemId.Text = '' then
    LblZonaArmazenagem.Caption := '';
end;

procedure TFrmProduto.EdtZonaArmazenagemIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmProduto.EdtZonaArmazenagemIdExit(Sender: TObject);
Var ObjEnderecamentoZonaCtrl : TEnderecamentoZonaCtrl;
    LstEnderecamentoZona     : TObjectList<TEnderecamentoZona>;
begin
  inherited;
  if (Not EdtZonaArmazenagemId.ReadOnly) and (EdtZonaArmazenagemId.Text<>'') then Begin
     if StrToIntDef(EdtZonaArmazenagemId.Text, 0) <= 0 then
        raise Exception.Create('Id da Zona de Armazenagem do produto é inválido!');
     Try
     ObjEnderecamentoZonaCtrl := TEnderecamentoZonaCtrl.Create;
     LstEnderecamentoZona := ObjEnderecamentoZonaCtrl.GetEnderecamentoZona(StrToIntDef(EdtZonaArmazenagemId.Text ,0), '', 0);
     If LstEnderecamentoZona.Items[0].ZonaId = 0 then
        raise Exception.Create('Zona('+EdtZonaArmazenagemId.Text+') de Endereçamento inexistente!')
     Else
        ObjProdutoCtrl.ObjProduto.EnderecamentoZona := LstEnderecamentoZona.Items[0];
     LblZonaArmazenagem.Caption := LstEnderecamentoZona.Items[0].Descricao;
     Except On E: Exception do
       raise Exception.Create('Zona: '+EdtZonaArmazenagemId.Text+sLineBreak+E.Message);
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmProduto.EdtDescricaoLoteExit(Sender: TObject);
Var ObjLoteAlteracaoCtrl : TLoteCtrl;
    JsonArrayRetorno     : TJsonArray;
    vErro : String;
begin
  if (EdtDescricaoLote.Text='') Or (EdtDescricaoLote.ReadOnly) then Exit;
  inherited;
  ObjLoteAlteracaoCtrl := TLoteCtrl.Create;
  JsonArrayRetorno := ObjLoteAlteracaoCtrl.GetProdutoLoteJson(ObjProdutoCtrl.ObjProduto.IdProduto, EdtDescricaoLote.Text, 0);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Lote('+EdtDescricaoLote.Text+') já existe. Se necessário use: Correção de Lotes');
     EdtDescricaoLote.SetFocus;
     Exit;
  End;
  EdtDtFabricacaoLote.SetFocus;
  JsonArrayRetorno := Nil;
  ObjLoteAlteracaoCtrl.Free;
end;

procedure TFrmProduto.EdtDescricaoLoteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Not EdtDescricaoLote.ReadOnly then Begin
     EdtDtFabricacaoLote.Clear;
     EdtDtVencimentoLote.Clear;
  End;
end;

procedure TFrmProduto.EdtLaboratorioIdChange(Sender: TObject);
begin
  inherited;
  if EdtLaboratorioId.Text = '' then
     LblLaboratorio.Caption := '';
end;

procedure TFrmProduto.EdtLaboratorioIdExit(Sender: TObject);
Var ObjLaboratorioCtrl : TLaboratorioCtrl;
    LstLaboratorioCtrl : TObjectList<TLaboratorioCtrl>;
begin
  inherited;
  if (Not EdtLaboratorioId.ReadOnly) and (EdtLaboratorioId.Text<>'') then Begin
     if StrToIntDef(EdtLaboratorioId.Text, 0) <= 0 then
        raise Exception.Create('Id de Fabricante inválido!');
     Try
       ObjLaboratorioCtrl := TLaboratorioCtrl.Create;
       LstLaboratorioCtrl := ObjLaboratorioCtrl.GetLaboratorio(StrToIntDef(EdtLaboratorioId.Text, 0), '', 0);
       ObjProdutoCtrl.ObjProduto.Laboratorio := LstLaboratorioCtrl.Items[0].ObjLaboratorio;
       If LstLaboratorioCtrl.Items[0].ObjLaboratorio.IdLaboratorio = 0 then
          raise Exception.Create('Fabricante('+EdtLaboratorioId.Text+') não entrado!');
       LblLaboratorio.Caption := LstLaboratorioCtrl.Items[0].ObjLaboratorio.NOme;
     Except On E: Exception do
       raise Exception.Create('Fabricante: '+EdtLaboratorioId.Text+sLineBreak+E.Message);
     End;
//     ObjEnderecoCtrl.DisposeOf;
     //LstEndereco.DisposeOf;
  End;
  ExitFocus(Sender);
end;

procedure TFrmProduto.EdtLaboratorioIdKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmProduto.EdtPickingChange(Sender: TObject);
begin
  inherited;
  if EdtPicking.Text = '' then
     LblPicking.Caption := '';
end;

procedure TFrmProduto.EdtPickingEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
  if (Not EdtPicking.ReadOnly) and (EdtPicking.Text<>'') then Begin
     EdtPicking.Text := StringReplace(StringReplace(EdtPicking.Text, '.', '', [rfreplaceAll]), '.', '', [rfreplaceAll]);  //EnderecoMask(EdtPicking.Text, ObjProdutoCtrl.ObjProduto.Endereco.EnderecoEstrutura.Mascara, False); //Endereco.Descricao;
  End;
end;

procedure TFrmProduto.EdtPickingExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayEstoque, RetornoJsonArray : TJsonArray;
    vEndereco, vErro : String;
begin
  inherited;
  if (Not EdtPicking.ReadOnly) then Begin
     //ObjProdutoCtrl.ObjProduto.Endereco := TEndereco.Create;
     EdtPicking.Text := StringReplace(StringReplace(EdtPicking.Text, '.', '', [rfreplaceAll]), '.', '', [rfreplaceAll]);
{     if (OperacaoCrud = poEdit) and (EdtPicking.Text <> ObjProdutoCtrl.ObjProduto.Endereco.Descricao) and (ObjProdutoCtrl.ObjProduto.Endereco.Descricao<>'') then Begin
        JsonArrayEstoque := ObjEstoqueCtrl.GetEstoqueJson(ObjProdutoCtrl.ObjProduto.IdProduto, 0, ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId, 0, 2, 2, 'S', 'S', 0);
        if Not JsonArrayEstoque.Items[0].TryGetValue('Erro', vErro) then Begin
           EdtPicking.Text := ObjProdutoCtrl.ObjProduto.Endereco.Descricao;
           EdtPicking.SetFocus;
           raise Exception.Create('Picking não pode ser modificado. Existe estoque no Picking anterior!');
           Exit;
        End;
     End;
}     if (EdtPicking.Text<>'') then Begin
        Try
          vEndereco := EdtPicking.Text;
          ObjEnderecoCtrl  := TEnderecoCtrl.Create;
          RetornoJsonArray := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EnderecoMask(EdtPicking.Text, '', False), EnderecoMask(EdtPicking.Text, '', False), 'T', 3);
          if (RetornoJsonArray.Items[0].TryGetValue('Erro', vErro)) or (RetornoJsonArray.Count < 1) then Begin
             EdtPicking.Text := '';
             EdtPicking.SetFocus;
             raise Exception.Create('Endereço ('+vEndereco+') não encontrado!');
          End;
          ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId := 0;
          If RetornoJsonArray.Items[0].GetValue<Integer>('enderecoid') = 0 then Begin
             EdtPicking.Text := '';
             EdtPicking.SetFocus;
             raise Exception.Create('Endereco('+EnderecoMask(EdtPicking.Text, '', False)+') inexistente');
          End
          Else If (RetornoJsonArray.Items[0].GetValue<TJsonObject>('enderecoestrutura')).GetValue<Integer>('pickingfixo') <> 1 then Begin
             EdtPicking.Text := '';
             EdtPicking.SetFocus;
             raise Exception.Create('Tipo de Estrutura inválida! Endereço não é picking!');
          End
          Else If (RetornoJsonArray.Items[0].GetValue<Integer>('status') = 0) then Begin
             EdtPicking.Text := '';
             EdtPicking.SetFocus;
             raise Exception.Create('Endereço('+EnderecoMask(vEndereco, '', True)+') inativo não pode ser usado!');
          End
          Else if ((RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> 0) and
                  ((RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> ObjProdutoCtrl.ObjProduto.IdProduto) then Begin
             EdtPicking.Text := '';
             EdtPicking.SetFocus;
             raise Exception.Create('Picking inválido, já utilizado pelo Produto: '+
                                    (RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<String>('codproduto')+' '+
                                    (RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<String>('descricao') );
          End
          Else Begin
//            ObjEnderecoCtrl.ObjEndereco := RetornoJsonArray.Items[0] as TJSONObject;
            ObjEnderecoCtrl.ObjEndereco := ObjEnderecoCtrl.ObjEndereco.JsonToClass((RetornoJsonArray.Items[0] as TJSONObject).ToString());
            ObjProdutoCtrl.ObjProduto.Endereco := ObjEnderecoCtrl.ObjEndereco;
          End;
          EdtPicking.Text := EnderecoMask(EdtPicking.Text, ObjProdutoCtrl.ObjProduto.Endereco.EnderecoEstrutura.Mascara, True);
        Except On E: Exception do Begin
          EdtPicking.Text := '';
          EdtPicking.SetFocus;
          raise Exception.Create('Endereço: '+EnderecoMask(EdtPicking.Text, '', False)+sLineBreak+E.Message);
          End;
        End;
     End
     Else Begin
        ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId := 0;
        ObjProdutoCtrl.ObjProduto.Endereco.Descricao  := '';
     End;
//     ObjEnderecoCtrl.DisposeOf;
//     LstEndereco.DisposeOf;
  End;
  ExitFocus(Sender);
end;

procedure TFrmProduto.EdtUnidadeIdChange(Sender: TObject);
begin
  inherited;
  if EdtUnidadeId.Text = '' then
     LblUnidade.Caption := '';
end;

procedure TFrmProduto.EdtUnidadeIdExit(Sender: TObject);
Var ObjUnidadeCtrl : TUnidadeCtrl;
    LstUnidade     : TObjectList<TUnidade>;
begin
  inherited;
  if (Not EdtUnidadeId.ReadOnly) and (EdtUnidadeId.Text<>'') then Begin
     if StrToIntDef(EdtUnidadeId.Text, 0) <= 0 then
        raise Exception.Create('Id da Unidade inválido!');
     Try
     ObjUnidadeCtrl := TUnidadeCtrl.Create;
     LstUnidade := ObjUnidadeCtrl.GetUnidade(StrToIntDef(EdtUnidadeId.Text ,0), '', 0);
     If LstUnidade.Items[0].Id = 0 then
        raise Exception.Create('Unidade('+EdtUnidadeId.Text+') de Medida inexistente!')
     Else
        ObjProdutoCtrl.ObjProduto.Unid := LstUnidade.Items[0];
     LblUnidade.Caption := LstUnidade.Items[0].Descricao;
     Except On E: Exception do
       raise Exception.Create('Unidade: '+EdtUnidadeId.Text+sLineBreak+E.Message);
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmProduto.EdtUnidadeSecundariaIdChange(Sender: TObject);
begin
  inherited;
  if EdtUnidadeSecundariaId.Text = '' then
     LblUnidadeSecundaria.Caption := '';
end;

procedure TFrmProduto.EdtUnidadeSecundariaIdExit(Sender: TObject);
Var ObjUnidadeCtrl : TUnidadeCtrl;
    LstUnidade     : TObjectList<TUnidade>;
begin
  inherited;
  if (Not EdtUnidadeSecundariaId.ReadOnly) and (EdtUnidadeSecundariaId.Text<>'') then Begin
     if StrToIntDef(EdtUnidadeSecundariaId.Text, 0) <= 0 then
        raise Exception.Create('Id da Unidade Secundária é inválido!');
     Try
     ObjUnidadeCtrl := TUnidadeCtrl.Create;
     LstUnidade := ObjUnidadeCtrl.GetUnidade(StrToIntDef(EdtUnidadeSecundariaId.Text ,0), '', 0);
     If LstUnidade.Items[0].Id = 0 then
        raise Exception.Create('Unidade('+EdtUnidadeSecundariaId.Text+') de Medida inexistente!')
     Else
        ObjProdutoCtrl.ObjProduto.Unid := LstUnidade.Items[0];
     LblUnidadeSecundaria.Caption := LstUnidade.Items[0].Descricao;
     Except On E: Exception do
       raise Exception.Create('Unidade: '+EdtUnidadeSecundariaId.Text+sLineBreak+E.Message);
     End;
  End;
  ExitFocus(Sender);
end;

procedure TFrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmProduto     := Nil;
//  LstProdutoTipo := Nil;
end;

procedure TFrmProduto.FormCreate(Sender: TObject);
Var xItens : Integer;
begin
  inherited;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  ObjLoteCtrl    := TLoteCtrl.Create;
  ObjCodBarrasCtrl := TProdutoCodBarrasCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0]  := 	70	;
    ColWidths[1]  := 	60	;
    ColWidths[2]  := 	300	;
    ColWidths[3]  := 	200	;
    ColWidths[4]  := 	100	;
    ColWidths[5]  := 	120	;
    ColWidths[6]  := 	150	;
    ColWidths[7]  := 	120	;
    ColWidths[8]  := 	80	;
    ColWidths[9]  := 	80	;
    ColWidths[10] := 	80	;
    ColWidths[11] := 	50	;
    ColWidths[12] := 	80	;
    ColWidths[13] := 	50	;
    ColWidths[14] := 	90	;
    ColWidths[15] := 	100	;
    ColWidths[16] := 	170	;
    ColWidths[17] := 	50	;
    ColWidths[18] := 	50	;
    ColWidths[19] := 	70	;
    ColWidths[20] := 	60	;
    ColWidths[21] := 	50	;
    ColWidths[22] := 	60	;
    ColWidths[23] := 	65	;
    ColWidths[24] := 	80	;
    ColWidths[25] := 	75	;
    ColWidths[26] := 	75	;
    ColWidths[27] := 	65	;
    ColWidths[28] := 	65	;
    ColWidths[29] := 	65	;
    ColWidths[30] := 	65	;
    ColWidths[31] := 	70	;
    ColWidths[32] := 	50	;
    ColWidths[33] := 	50	;
  End;
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[1, 0] := taRightJustify;
  LstCadastro.Alignments[11, 0] := taRightJustify;
  LstCadastro.Alignments[13, 0] := taRightJustify;
  LstCadastro.Alignments[17, 0] := taRightJustify;
  LstCadastro.Alignments[18, 0] := taRightJustify;
  LstCadastro.Alignments[19, 0] := taRightJustify;
  LstCadastro.Alignments[20, 0] := taRightJustify;
  LstCadastro.Alignments[21, 0] := taRightJustify;
  LstCadastro.Alignments[22, 0] := taRightJustify;
  LstCadastro.Alignments[23, 0] := taRightJustify;
  LstCadastro.Alignments[24, 0] := taRightJustify;
  LstCadastro.Alignments[25, 0] := taRightJustify;
  LstCadastro.Alignments[26, 0] := taRightJustify;
  LstCadastro.Alignments[27, 0] := taCenter;
  LstCadastro.Alignments[28, 0] := taCenter;
  LstCadastro.Alignments[29, 0] := taCenter;
  LstCadastro.Alignments[30, 0] := taCenter;
  LstCadastro.Alignments[31, 0] := taCenter;
  LstCadastro.Alignments[32, 0] := taCenter;
  LstCadastro.Alignments[33, 0] := taCenter;
  //LstCadastro.RowCount := 1;
//  GetListaProduto('-1', '0', '', 0);   //Lentidão na busca

  With LstLotes do Begin
    ColWidths[0]  := 40;
    ColWidths[1]  := 150;
    ColWidths[2]  := 80;
    ColWidths[3]  := 80;
    ColWidths[4]  := 60;
    ColWidths[5]  := 60;
    ColWidths[6]  := 60;
    ColWidths[7]  := 70;
    ColWidths[8]  := 60;
    ColWidths[9]  := 60;
    ColWidths[10] := 60;
    ColWidths[11] := 80;
    LstLotes.Alignments[0,  0] := taRightJustify;
    LstLotes.FontStyles[0,  0] := [FsBold];
    LstLotes.Alignments[2,  0] := taCenter;
    LstLotes.Alignments[3,  0] := taCenter;
    LstLotes.Alignments[4,  0] := taRightJustify;
    LstLotes.Alignments[5,  0] := taRightJustify;
    LstLotes.Alignments[6,  0] := taRightJustify;
    LstLotes.Alignments[7,  0] := taRightJustify;
    LstLotes.Alignments[8,  0] := taRightJustify;
    LstLotes.Alignments[9,  0] := taRightJustify;
    LstLotes.FontStyles[9,  0] := [FsBold];
    LstLotes.Alignments[10, 0] := taRightJustify;
    LstLotes.Alignments[11, 0] := taCenter;
  End;
  LstLotes.SortSettings.Column := 1;
  LstLotes.QSort;
  AdvGdLookupLote.Column  := 1;
  TabLotes.TabVisible     := False;
  TabCodBarras.TabVisible := False;
  TabEstoqueEndereco.TabVisible := EdtCodProduto.Text <> '';
  TabMovimentacao.TabVisible    := EdtCodProduto.Text <> '';
  //Buscar Dados Complementares
  ObjRastroCtrl := TRastroCtrl.Create;
  LstRastro     := ObjRastroCtrl.GetRastro;
  CbRastroTipo.Items.Clear;
  for XItens := 0 to LstRastro.Count-1 do
    CbRastroTipo.Items.Add(LstRastro.Items[xItens].Descricao);
  ObjRastroCtrl.Free;

  ObjProdutoTipoCtrl := TProdutoTipoCtrl.Create;
  LstProdutoTipo     := ObjProdutoTipoCtrl.GetProdutoTipo;
  CbProdutoTipo.Items.Clear;
  for XItens := 0 to LstProdutoTipo.Count-1 do
    CbProdutoTipo.Items.Add(LstProdutoTipo.Items[xItens].Descricao);
  ObjProdutoTipoCtrl.Free;

  ObjMedicamentoTipoCtrl := TMedicamentoTipoCtrl.Create;
  LstMedicamentoTipo     := ObjMedicamentoTipoCtrl.GetMedicamentoTipo;
  CbMedicamentoTipo.Items.Clear;
  for XItens := 0 to LstMedicamentoTipo.Count-1 do
    CbMedicamentoTipo.Items.Add(LstMedicamentoTipo.Items[xItens].Descricao);
  ObjMedicamentoTipoCtrl.Free;

  //Código de Barras
  With AdvSGCodBarras do Begin
    ColWidths[0]  := 	40	;
    ColWidths[1]  := 	120	;
    ColWidths[2]  := 	60	;
    ColWidths[3]  := 	80	;
    ColWidths[4]  := 	60	;
    ColWidths[5]  := 	60	;
    ColWidths[6]  := 	40	;
    Alignments[0, 0] := taRightJustify;
    FontStyles[0, 0] := [FsBold];
    Alignments[2, 0] := taRightJustify;
    Alignments[3, 0] := taCenter;
    Alignments[4, 0] := taCenter;
    Alignments[5, 0] := taCenter;
    Alignments[6, 0] := taCenter;
  End;
//Mostrar Estoque do Produto
  LstAdvEstoqueEndereco.ColWidths[0]  := 	40;
  LstAdvEstoqueEndereco.ColWidths[1]  := 	65;
  LstAdvEstoqueEndereco.ColWidths[2]  := 150;
  LstAdvEstoqueEndereco.ColWidths[3]  :=  70;
  LstAdvEstoqueEndereco.ColWidths[4]  := 	50;
  LstAdvEstoqueEndereco.ColWidths[5]  :=  70;
  LstAdvEstoqueEndereco.ColWidths[6]  :=  60;
  LstAdvEstoqueEndereco.ColWidths[7]  := 	70;
  LstAdvEstoqueEndereco.ColWidths[8]  := 120;
  LstAdvEstoqueEndereco.ColWidths[9]  := 	70;
  LstAdvEstoqueEndereco.ColWidths[10] := 	70;
  LstAdvEstoqueEndereco.ColWidths[11] :=  90;
  LstAdvEstoqueEndereco.ColWidths[12] :=  90;
  LstAdvEstoqueEndereco.ColWidths[13] :=  50;
  LstAdvEstoqueEndereco.ColWidths[14] := 140;
  LstAdvEstoqueEndereco.ColWidths[15] :=  60;
  LstAdvEstoqueEndereco.ColWidths[16] :=  60;
  LstAdvEstoqueEndereco.ColWidths[17] :=  60;
  LstAdvEstoqueEndereco.ColWidths[18] :=  60; //Segregado
  LstAdvEstoqueEndereco.ColWidths[19] := 120;
  LstAdvEstoqueEndereco.ColWidths[20] :=  80;
  LstAdvEstoqueEndereco.ColWidths[21] :=  40;
  LstAdvEstoqueEndereco.ColWidths[22] :=  60;
  LstAdvEstoqueEndereco.ColWidths[23] :=  60;
  LstAdvEstoqueEndereco.Alignments[0,  0] := taRightJustify;
  LstAdvEstoqueEndereco.FontStyles[0,  0] := [FsBold];
  LstAdvEstoqueEndereco.Alignments[4,  0] := taRightJustify;
  LstAdvEstoqueEndereco.Alignments[6,  0] := taRightJustify;
  LstAdvEstoqueEndereco.Alignments[7,  0] := taRightJustify;
  LstAdvEstoqueEndereco.Alignments[13, 0] := taCenter;
  LstAdvEstoqueEndereco.Alignments[15, 0] := taRightJustify;
  LstAdvEstoqueEndereco.Alignments[16, 0] := taRightJustify;
  LstAdvEstoqueEndereco.Alignments[17, 0] := taRightJustify;
  LstAdvEstoqueEndereco.Alignments[18, 0] := taRightJustify;
  LstAdvEstoqueEndereco.Alignments[21, 0] := taCenter;
  LstAdvEstoqueEndereco.Alignments[22, 0] := taCenter;
  LstAdvEstoqueEndereco.Alignments[23, 0] := taCenter;
  LstAdvEstoqueEndereco.HideColumn(1);
  LstAdvEstoqueEndereco.HideColumn(2);
  LstAdvEstoqueEndereco.HideColumn(3);
  LstAdvEstoqueEndereco.HideColumn(4);
  LstAdvEstoqueEndereco.HideColumn(5);
  LstAdvEstoqueEndereco.HideColumn(6);
  LstAdvEstoqueEndereco.HideColumn(7);
  LstAdvEstoqueEndereco.HideColumn(9);
  LstAdvEstoqueEndereco.HideColumn(22);
  LstAdvEstoqueEndereco.HideColumn(23);
//http://delphiparainiciantes.com.br/como-utilizar-mascaras-maskedit-no-delphi/
//  EdtPicking.Text := ObjProdutoCtrl.GetPickingMask+';0;_';
end;

procedure TFrmProduto.FormDestroy(Sender: TObject);
begin
  ObjProdutoCtrl.Free;
  ObjLoteCtrl.Free;
  ObjCodBarrasCtrl.Free;

//  LstRastro.Free;
//  LstProdutoTipo.Free;
//  LstMedicamentoTipo.Free;

//  ObjRastroCtrl.Free;
//  ObjProdutoTipoCtrl.Free;
//  ObjMedicamentoTipoCtrl.Free;
  inherited;
end;

procedure TFrmProduto.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F2 then Begin BtnIncluirClick(BtnIncluir); Exit; End;
  if Key = Vk_F4 then Begin BtnExcluirClick(BtnExcluir); Exit; End;
  inherited;
end;

procedure TFrmProduto.FormShow(Sender: TObject);
begin
  inherited;
  PgcBase.ActivePage := TabPrincipal;
end;

procedure TFrmProduto.GetListaEstoqueEndereco;
 Var ObjEstoqueCtrl : TEstoqueCtrl;
    xReturn         : Integer;
    LstEstoque      : TObjectList<TEstoque>;
    vEstProducao    : Integer;
    vEstReserva     : Integer;
    vSaldoEstoque   : Integer;
    vSaldoSegregado : Integer;
begin
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  Try
    LstEstoque     := ObjEstoqueCtrl.GetEstoque(ObjProdutoCtrl.ObjProduto.IdProduto, 0, 0, 0, 2, 2, 'S', 'S', 0);
    LstAdvEstoqueEndereco.RowCount := LstEstoque.Count+1;
    if (LstEstoque.Count <= 0) then
       //ShowErro('Não há estoque Disponível deste produto.')
    Else Begin
      LstAdvEstoqueEndereco.FixedRows := 1;
      LblTotRegEstoque.Caption := LstEstoque.Count.ToString();
      for xReturn := 1 to LstAdvEstoqueEndereco.RowCount-1 do Begin
        LstAdvEstoqueEndereco.AddDataImage(13, xReturn, 0, haCenter, vaTop);
        LstAdvEstoqueEndereco.AddDataImage(21, xReturn, 0, haCenter, vaTop);
        LstAdvEstoqueEndereco.AddDataImage(22, xReturn, 0, haCenter, vaTop);
      End;
      vEstProducao    := 0;
      vEstReserva     := 0;
      vSaldoEstoque   := 0;
      vSaldoSegregado := 0;
      for xReturn := 0 to Pred(LstEstoque.Count) do Begin
        LstAdvEstoqueEndereco.Cells[ 0, xReturn+1] := xReturn.ToString; //LstEstoque[xReturn].produtoid.ToString;
        LstAdvEstoqueEndereco.Cells[ 1, xReturn+1] := LstEstoque[xReturn].codigoerp.ToString;
        LstAdvEstoqueEndereco.Cells[ 2, xReturn+1] := LstEstoque[xReturn].produto;
        LstAdvEstoqueEndereco.Cells[ 3, xReturn+1] := LstEstoque[xReturn].Embprim;
        LstAdvEstoqueEndereco.Cells[ 4, xReturn+1] := LstEstoque[xReturn].qtdunid.ToString;
        LstAdvEstoqueEndereco.Cells[ 5, xReturn+1] := LstEstoque[xReturn].embsec;
        LstAdvEstoqueEndereco.Cells[ 6, xReturn+1] := LstEstoque[xReturn].fatorconversao.ToString();
        LstAdvEstoqueEndereco.Cells[ 7, xReturn+1] := LstEstoque[xReturn].messaidaminima.ToString;
        LstAdvEstoqueEndereco.Cells[ 8, xReturn+1] := LstEstoque[xReturn].Descrlote;
        LstAdvEstoqueEndereco.Cells[ 9, xReturn+1] := DateToStr(LstEstoque[xReturn].fabricacao);
        LstAdvEstoqueEndereco.Cells[10, xReturn+1] := DateToStr(LstEstoque[xReturn].vencimento);
        if LstEstoque[xReturn].vencimento <= Date() then
           LstAdvEstoqueEndereco.Colors[10, xReturn+1] := ClRed
        else If LstEstoque[xReturn].vencimento <= (Date()+120) then
           LstAdvEstoqueEndereco.Colors[10, xReturn+1] := clYellow
        else LstAdvEstoqueEndereco.Colors[10, xReturn+1] := LstAdvEstoqueEndereco.Colors[9, xReturn+1];
        LstAdvEstoqueEndereco.Cells[11, xReturn+1] := EnderecoMask(LstEstoque[xReturn].endereco, LstEstoque[xReturn].Mascara, True);
        LstAdvEstoqueEndereco.Cells[12, xReturn+1] := LstEstoque[xReturn].estrutura;
        LstAdvEstoqueEndereco.Cells[13, xReturn+1] := LstEstoque[xReturn].pickingfixo.ToString();
        LstAdvEstoqueEndereco.Cells[14, xReturn+1] := LstEstoque[xReturn].zona;
        if LstEstoque[xReturn].EstoqueTipoId <> 3 then Begin
           LstAdvEstoqueEndereco.Cells[15, xReturn+1] := LstEstoque[xReturn].QtdeProducao.ToString;
           LstAdvEstoqueEndereco.Cells[17, xReturn+1] := LstEstoque[xReturn].qtde.ToString;
           LstAdvEstoqueEndereco.Cells[16, xReturn+1] := LstEstoque[xReturn].QtdeReserva.ToString;
           vEstProducao  := vEstProducao  + LstEstoque[xReturn].QtdeProducao;
           vEstReserva   := vEstReserva   + LstEstoque[xReturn].QtdeReserva;
           LstAdvEstoqueEndereco.Colors[18, xReturn+1] := LstAdvEstoqueEndereco.Colors[17, xReturn+1];
           LstAdvEstoqueEndereco.Cells[18, xReturn+1] := '';
           vSaldoEstoque := vSaldoEstoque + (LstEstoque[xReturn].QtdeProducao - LstEstoque[xReturn].QtdeReserva);
        End
        else Begin
           LstAdvEstoqueEndereco.Cells[15, xReturn+1] := '';
           LstAdvEstoqueEndereco.Cells[17, xReturn+1] := '';
           LstAdvEstoqueEndereco.Cells[16, xReturn+1] := '';
        End;
        if LstEstoque[xReturn].EstoqueTipoId = 3 then Begin
           LstAdvEstoqueEndereco.Colors[18, xReturn+1] := clRed;
           LstAdvEstoqueEndereco.Cells[18, xReturn+1] := LstEstoque[xReturn].qtdeProducao.ToString;
           vSaldoSegregado := vSaldoSegregado + LstEstoque[xReturn].qtdeProducao;
        End
        else
           LstAdvEstoqueEndereco.Cells[18, xReturn+1] := '';
        LstAdvEstoqueEndereco.Cells[19, xReturn+1] := LstEstoque[xReturn].EstoqueTipo;
        LstAdvEstoqueEndereco.Cells[20, xReturn+1] := DateToStr(LstEstoque[xReturn].DtEntrada); //DateTimeToStr(LstEstoque[xReturn].DtEntrada)+' '+TimeToStr(LstEstoque[xReturn].HrEntrada);
                                                      //DateTimeToStr(LstEstoque[xReturn].Horario);
        LstAdvEstoqueEndereco.Cells[21, xReturn+1] := LstEstoque[xReturn].producao.ToString;
        LstAdvEstoqueEndereco.Cells[22, xReturn+1] := LstEstoque[xReturn].distribuicao.ToString();
        LstAdvEstoqueEndereco.Cells[23, xReturn+1] := LstEstoque[xReturn].Ordem.ToString;
        LstAdvEstoqueEndereco.Alignments[0,  xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.FontStyles[0,  xReturn+1] := [FsBold];
        LstAdvEstoqueEndereco.Alignments[1,  xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[4,  xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[6,  xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[7,  xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[13, xReturn+1] := taCenter;
        LstAdvEstoqueEndereco.Alignments[15, xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[16, xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[17, xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[18, xReturn+1] := taRightJustify;
        LstAdvEstoqueEndereco.Alignments[21, xReturn+1] := taCenter;
        LstAdvEstoqueEndereco.Alignments[22, xReturn+1] := taCenter;
        LstAdvEstoqueEndereco.Alignments[23, xReturn+1] := taCenter;
      End;
      LstAdvEstoqueEndereco.RowCount := LstAdvEstoqueEndereco.RowCount + 1;
      LstAdvEstoqueEndereco.Cells[14, LstAdvEstoqueEndereco.RowCount-1] := 'TOTAL-->';
      LstAdvEstoqueEndereco.Cells[15, LstAdvEstoqueEndereco.RowCount-1] := vEstProducao.ToString;
      If vEstProducao >= 0 then
         LstAdvEstoqueEndereco.FontColors[15, LstAdvEstoqueEndereco.RowCount-1] := clNavy
      Else LstAdvEstoqueEndereco.FontColors[15, LstAdvEstoqueEndereco.RowCount-1] := ClRed;
      LstAdvEstoqueEndereco.Cells[16, LstAdvEstoqueEndereco.RowCount-1] := vEstReserva.ToString;
      If vEstReserva >= 0 then
         LstAdvEstoqueEndereco.FontColors[16, LstAdvEstoqueEndereco.RowCount-1] := clNavy
      Else LstAdvEstoqueEndereco.FontColors[16, LstAdvEstoqueEndereco.RowCount-1] := ClRed;
      LstAdvEstoqueEndereco.Cells[17, LstAdvEstoqueEndereco.RowCount-1] := vSaldoEstoque.ToString;
      If vSaldoEstoque >= 0 then
         LstAdvEstoqueEndereco.FontColors[17, LstAdvEstoqueEndereco.RowCount-1] := clNavy
      Else LstAdvEstoqueEndereco.FontColors[17, LstAdvEstoqueEndereco.RowCount-1] := ClRed;
      LstAdvEstoqueEndereco.Cells[18, LstAdvEstoqueEndereco.RowCount-1] := vSaldoSegregado.ToString;
      LstAdvEstoqueEndereco.Colors[18, LstAdvEstoqueEndereco.RowCount-1] := clRed;
      LstAdvEstoqueEndereco.Alignments[14, LstAdvEstoqueEndereco.RowCount-1] := taRightJustify;
      LstAdvEstoqueEndereco.Alignments[15, LstAdvEstoqueEndereco.RowCount-1] := taRightJustify;
      LstAdvEstoqueEndereco.Alignments[16, LstAdvEstoqueEndereco.RowCount-1] := taRightJustify;
      LstAdvEstoqueEndereco.Alignments[17, LstAdvEstoqueEndereco.RowCount-1] := taRightJustify;
      LstAdvEstoqueEndereco.Alignments[18, LstAdvEstoqueEndereco.RowCount-1] := taRightJustify;
      LstAdvEstoqueEndereco.FontStyles[14, LstAdvEstoqueEndereco.RowCount-1] := [FsBold];
      LstAdvEstoqueEndereco.FontStyles[15, LstAdvEstoqueEndereco.RowCount-1] := [FsBold];
      LstAdvEstoqueEndereco.FontStyles[16, LstAdvEstoqueEndereco.RowCount-1] := [FsBold];
      LstAdvEstoqueEndereco.FontStyles[17, LstAdvEstoqueEndereco.RowCount-1] := [FsBold];
      LstAdvEstoqueEndereco.FontStyles[18, LstAdvEstoqueEndereco.RowCount-1] := [FsBold];
    End;
    LstEstoque := Nil;
    ObjEstoqueCtrl.Free;
  Except On E: Exception do Begin
    ObjEstoqueCtrl.Free;
    ShowErro(E.Message);
    End;
  End;
end;

procedure TFrmProduto.GetListaLstCadastro;
begin
  inherited;
  GetListaProduto('-1', '0', '', 0, '');
end;

Function TFrmProduto.GetListaProduto(pId, pCodigoERP : String; pDescricao : String; pRecsSkip : Integer; pPicking : String) : Boolean;
Var ArrayListProduto : tJsonArray;
    jSonProduto, JSonProdutoTipo, JsonRastro, JsonMedicamentoTipo, JSonLaboratorio,
    JSonUnidade, JSonUnidadeSecundaria, JSonEnderecamentoZona, JSonEndereco,
    JSonDesenhoArmazem : tJsonObject;
    I, xLista          : Integer;
    vErro : String;
begin
  if pId = '-1' then Exit;
  if pDescricao = '%' then pDescricao := '*';
  ArrayListProduto := ObjProdutoCtrl.FindProduto(pId, pCodigoERP, pDescricao, pRecsSkip, 0, pPicking);
  if ArrayListProduto.items[0].TryGetValue('Erro', vErro) then Begin
     ArrayListProduto.Free;// := Nil;
     Exit;
  End;
  Result := ArrayListProduto.Count >= 1;
  LblTotReg.Caption := ArrayListProduto.Count.ToString();
  If ArrayListProduto.Count >= 1 then Begin
     LstCadastro.RowCount := ArrayListProduto.Count+1;
     LstCadastro.FixedRows := 1;
     for i := 1 to LstCadastro.RowCount - 1 do begin
       LstCadastro.AddDataImage(27, I, 0, haCenter,vaTop);
       LstCadastro.AddDataImage(28, I, 0, haCenter,vaTop);
       LstCadastro.AddDataImage(29, I, 0, haCenter,vaTop);
       LstCadastro.AddDataImage(30, I, 0, haCenter,vaTop);
       LstCadastro.AddDataImage(31, I, 0, haCenter,vaTop);
       LstCadastro.AddDataImage(32, I, 0, haCenter,vaTop);
       LstCadastro.AddDataImage(33, I, 0, haCenter,vaTop);
     end;

     For xLista := 0 To ArrayListProduto.Count-1 do begin
       jSonProduto := tJsonObject.Create;
       jSonProduto := ArrayListProduto.Items[xLista] as TJSONObject;
       LstCadastro.Cells[0, xLista+1] := GetValueInjSon(jSonProduto, 'idProduto');
       LstCadastro.Cells[1, xLista+1] := GetValueInjSon(jSonProduto, 'Codproduto');
       LstCadastro.Cells[2, xLista+1] := GetValueInjSon(jSonProduto, 'Descricao');
       LstCadastro.Cells[3, xLista+1] := GetValueInjSon(jSonProduto, 'DescricaoRed');
       JSonEndereco := jSonProduto.GetValue('endereco') as TJSONObject;
       LstCadastro.Cells[4, xLista+1] := EnderecoMask(jsonEndereco.GetValue<String>('descricao'),
                                         ((jSonProduto.GetValue('endereco') as TJSONObject).GetValue('enderecoEstrutura') as TJsonObject).GetValue<String>('mascara'), True);
   //    LstCadastro.Cells[4, xLista+1] := jsonEndereco.GetValue<String>('descricao');

       JSonEndereco := jSonEndereco.GetValue('enderecamentoZona') as TJSONObject;
       LstCadastro.Cells[5, xLista+1] := jsonEndereco.GetValue<String>('descricao');
       JSonEnderecamentoZona := TJsonObject.Create;
       JSonEnderecamentoZona := jSonProduto.GetValue('enderecamentoZona') as TJSONObject;
       LstCadastro.Cells[6, xLista+1] := GetValueInjSon(JSonEnderecamentoZona, 'Descricao');
       JSonProdutoTipo := TJsonObject.Create;
       JSonProdutoTipo := jSonProduto.GetValue('produtoTipo') as TJSONObject;
       LstCadastro.Cells[7, xLista+1] := GetValueInjSon(JSonProdutoTipo, 'Descricao'); //Categoria
       JsonMedicamentoTipo := TJsonObject.Create;
       JSonMedicamentoTipo := jSonProduto.GetValue('medicamentoTipo') as TJSONObject;
       LstCadastro.Cells[8, xLista+1] := GetValueInjSon(JSonMedicamentoTipo, 'Descricao'); //Tipo Produto
       LstCadastro.Cells[9, xLista+1] := GetValueInjSon(jSonProduto, 'codigoMS');
       JSonUnidade := TJsonObject.Create;
       JSonUnidade := jSonProduto.GetValue('unid') as TJSONObject;
       LstCadastro.Cells[10, xLista+1] := GetValueInjSon(JSonUnidade, 'Descricao');
       LstCadastro.Cells[11, xLista+1] := GetValueInjSon(JsonProduto, 'qtdUnid');
       JSonUnidadeSecundaria := TJsonObject.Create;
       JSonUnidadeSecundaria := jSonProduto.GetValue('unidSecundaria') as TJSONObject;
       LstCadastro.Cells[12, xLista+1]  := GetValueInjSon(JSonUnidadeSecundaria, 'Descricao');
       LstCadastro.Cells[13, xLista+1] := GetValueInjSon(JSonProduto, 'FatorConversao');
       //LstCadastro.Cells[  , xLista+1] := GetValueInjSon(JSonProduto, 'SomenteCxaFechada');
       JSonRastro := TJsonObject.Create;
       JSonRastro := jSonProduto.GetValue('rastro') as TJSONObject;
       LstCadastro.Cells[14, xLista+1] := GetValueInjSon(JSonRastro, 'descricao');    //Trocar por controle
       LstCadastro.Cells[15, xLista+1] := GetValueInjSon(JsonProduto, 'EanPrincipal');
       JSonLaboratorio := TJsonObject.Create;
       JSonlaboratorio := jSonProduto.GetValue('laboratorio') as TJSONObject;
       LstCadastro.Cells[16, xLista+1] := GetValueInjSon(JSonLaboratorio, 'nome');
       LstCadastro.Cells[17, xLista+1] := GetValueInjSon(JSonProduto, 'Altura');
       LstCadastro.Cells[18, xLista+1] := GetValueInjSon(JSonProduto, 'largura');
       LstCadastro.Cells[19, xLista+1] := GetValueInjSon(JSonProduto, 'Comprimento');;
       LstCadastro.Cells[20, xLista+1] := GetValueInjSon(JSonProduto, 'Volume');
       LstCadastro.Cells[21, xLista+1] := GetValueInjSon(JSonProduto, 'Peso');
       LstCadastro.Cells[22, xLista+1] := GetValueInjSon(JSonProduto, 'maxPicking');
       LstCadastro.Cells[23, xLista+1] := GetValueInjSon(JSonProduto, 'PercReposicao');
       LstCadastro.Cells[24, xLista+1] := GetValueInjSon(JSonProduto, 'QtdReposicao');
       LstCadastro.Cells[25, xLista+1] := GetValueInjSon(JSonProduto, 'MesEntradaMinima');
       LstCadastro.Cells[26, xLista+1] := GetValueInjSon(JSonProduto, 'MesSaidaMinima');
       if GetValueInjSon(JSonProduto, 'Liquido') = 'false' then
          LstCadastro.Cells[27, xLista+1] := '0'
       Else LstCadastro.Cells[27, xLista+1] := '1';
       if GetValueInjSon(JSonProduto, 'Importado') = 'false' then
          LstCadastro.Cells[28, xLista+1] := '0'
       Else LstCadastro.Cells[28, xLista+1] := '1';
       if GetValueInjSon(JSonProduto, 'Inflamavel') = 'false' then
          LstCadastro.Cells[29, xLista+1] := '0'
       Else LstCadastro.Cells[29, xLista+1] := '1';
       if GetValueInjSon(JSonProduto, 'Perigoso') = 'false' then
       LstCadastro.Cells[30, xLista+1] := '0'
       Else LstCadastro.Cells[30, xLista+1] := '1';
       if GetValueInjSon(JSonProduto, 'Medicamento') = 'false' then
       LstCadastro.Cells[31, xLista+1] := '0'
       Else LstCadastro.Cells[31, xLista+1] := '1';
       if GetValueInjSon(JSonProduto, 'SNGPC') = 'false' then
       LstCadastro.Cells[32, xLista+1] := '0'
       Else LstCadastro.Cells[32, xLista+1] := '1';
       LstCadastro.Cells[33, xLista+1] := JSonProduto.GetValue<String>('status');
       jSonProduto := Nil;
       JSonProdutoTipo := Nil;
       jsonRastro := Nil;
       JsonMedicamentoTipo := Nil;
       JSonLaboratorio := Nil;
       JSonUnidade := Nil;
       JSonUnidadeSecundaria := Nil;
       JSonEnderecamentoZona := Nil;
       JSonEndereco := Nil;
       JSonDesenhoArmazem := Nil;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[1, xLista+1] := taRightJustify;
       LstCadastro.Alignments[11, xLista+1] := taRightJustify;
       LstCadastro.Alignments[13, xLista+1] := taRightJustify;
       LstCadastro.Alignments[17, xLista+1] := taRightJustify;
       LstCadastro.Alignments[18, xLista+1] := taRightJustify;
       LstCadastro.Alignments[19, xLista+1] := taRightJustify;
       LstCadastro.Alignments[20, xLista+1] := taRightJustify;
       LstCadastro.Alignments[21, xLista+1] := taRightJustify;
       LstCadastro.Alignments[22, xLista+1] := taRightJustify;
       LstCadastro.Alignments[23, xLista+1] := taRightJustify;
       LstCadastro.Alignments[24, xLista+1] := taRightJustify;
       LstCadastro.Alignments[25, xLista+1] := taRightJustify;
       LstCadastro.Alignments[26, xLista+1] := taRightJustify;
       LstCadastro.Alignments[27, xLista+1] := taCenter;
       LstCadastro.Alignments[28, xLista+1] := taCenter;
       LstCadastro.Alignments[29, xLista+1] := taCenter;
       LstCadastro.Alignments[30, xLista+1] := taCenter;
       LstCadastro.Alignments[31, xLista+1] := taCenter;
       LstCadastro.Alignments[32, xLista+1] := taCenter;
       LstCadastro.Alignments[33, xLista+1] := taCenter;
     end;
     LstCadastro.SortSettings.Column := 2;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 2;
  End;
  ArrayListProduto := Nil;
  //MontarPaginacao(ObjProdutoCtrl.MontarPaginacao);
end;

procedure TFrmProduto.GetListaProdutoCodBarras(pProdutoCodBarrasId,
  pProdutoId: Integer; pCodBarras: String);
Var xImg, xLista               : Integer;
    LstCodBarras               : TObjectList<TProdutoCodBarrasCtrl>;
    TmpObjProdutoCodBarrasCtrl : TProdutoCodBarrasCtrl;
begin
  TmpObjProdutoCodBarrasCtrl := TProdutoCodBarrasCtrl.Create;
  LstCodBarras := TmpObjProdutoCodBarrasCtrl.GetProdutoCodBarras(pProdutoCodBarrasId, pProdutoId , pCodBarras, 0);
  AdvSGCodBarras.ClearRect(0, 1, AdvSGCodBarras.ColCount-1, AdvSGCodBarras.RowCount-1);
  AdvSGCodBarras.RowCount := 2;
  If LstCodBarras.Count > 0 then
     AdvSGCodBarras.RowCount := LstCodBarras.Count+1
  Else AdvSGCodBarras.RowCount := 2;
  for xImg := 1 to AdvSGCodBarras.RowCount - 1 do Begin
    AdvSGCodBarras.AddDataImage(4, xImg, 0, haCenter, vaTop);
    AdvSGCodBarras.AddDataImage(5, xImg, 0, haCenter, vaTop);
    AdvSGCodBarras.AddDataImage(6, xImg, 2, haCenter, vaTop);
  End;
  For xLista := 0 To LstCodBarras.Count-1 do begin
    With LstCodBarras[xLista].ObjProdutoCodBarras do Begin
      AdvSGCodBarras.Cells[0, xLista+1] := CodBarrasId.ToString();
      AdvSGCodBarras.Cells[1, xLista+1] := Codbarras;
      AdvSGCodBarras.Cells[2, xLista+1] := UnidadesEmbalagem.ToString();
      AdvSGCodBarras.Cells[4, xLista+1] := Principal.ToString();
      AdvSGCodBarras.Cells[5, xLista+1] := Status.ToString();
    End;
    AdvSGCodBarras.Alignments[0, xLista+1] := taRightJustify;
    AdvSGCodBarras.FontStyles[0, xLista+1] := [FsBold];
    AdvSGCodBarras.Alignments[2, xLista+1] := taRightJustify;
    AdvSGCodBarras.Alignments[3, xLista+1] := taCenter;
    AdvSGCodBarras.Alignments[4, xLista+1] := taCenter;
  end;
  TmpObjProdutoCodBarrasCtrl.Free;
//  LstCodBarras := Nil;
///  LstCodBarras.DisposeOf;
  LstCodBarras.Free;
  AdvSGCodBarras.FixedRows := 1;
end;

procedure TFrmProduto.GetListaProdutoLotes;
Var ObjEstoqueCtrl    : TEstoqueCtrl;
    ArrayEstoqueLotes : tJsonArray;
    xLista            : Integer;
    vErro             : String;
begin
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  ArrayEstoqueLotes := ObjEstoqueCtrl.GetEstoqueLotePorTipo(ObjProdutoCtrl.ObjProduto.IdProduto, 0, 0, 0, 2, 2, 'S', 'S', 0);
  if (ArrayEstoqueLotes.Items[0].TryGetValue('Erro', vErro)) then Begin
     LstLotes.RowCount  := 1;
     LstLotes.FixedRows := 0;
     ArrayEstoqueLotes  := Nil;
     ObjEstoqueCtrl.Free;
     Exit;
  End;
  LstLotes.FixedRows := 0;
  LstLotes.RowCount  := ArrayEstoqueLotes.Count+1;
  LblTotRegistro.Caption := ArrayEstoqueLotes.Count.ToString;
  if ArrayEstoqueLotes.Get(xLista).TryGetValue<String>('Erro', vErro) then Exit;
  If ArrayEstoqueLotes.Count >= 1 then Begin
     LstLotes.FixedRows := 1;
     For xLista := 0 To ArrayEstoqueLotes.Count-1 do begin
       LstLotes.Cells[0, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('loteid').ToString;
       LstLotes.Cells[1, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<String>('descrlote');
       if (ArrayEstoqueLotes.Get(xLista).GetValue<String>('descrlote') <> 'SL') or (ObjProdutoCtrl.ObjProduto.Rastro.RastroId <> 1) then Begin
          LstLotes.Cells[2, xLista+1] := (ArrayEstoqueLotes.Get(xLista).GetValue<String>('fabricacao'));
          LstLotes.Cells[3, xLista+1] := (ArrayEstoqueLotes.Get(xLista).GetValue<String>('vencimento'));
          if StrToDate(ArrayEstoqueLotes.Get(xLista).GetValue<String>('vencimento')) <= Date() then
             LstLotes.Colors[3, xLista+1] := ClRed
          Else if StrToDate(ArrayEstoqueLotes.Get(xLista).GetValue<String>('vencimento')) <= Date()+120 then
             LstLotes.Colors[3, xLista+1] := $00B3FFFF
          Else LstLotes.Colors[3, xLista+1] := LstLotes.Colors[2, xLista+1];
       End
       Else Begin
          LstLotes.Cells[2, xLista+1] := '';
          LstLotes.Cells[3, xLista+1] := '';
       End;
       if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produto - Estoque') then Begin
          LstLotes.Cells[4, xLista+1]  := '****';
          LstLotes.Cells[5, xLista+1]  := '****';
          LstLotes.Cells[6, xLista+1]  := '****';
          LstLotes.Cells[7, xLista+1]  := '****';
          LstLotes.Cells[8, xLista+1]  := '****';
          LstLotes.Cells[9, xLista+1]  := '****';
          LstLotes.Cells[10, xLista+1] := '****';
          LstLotes.Cells[11, xLista+1] := '****';
       End
       Else Begin
          LstLotes.Cells[4, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('stage').ToString();
          LstLotes.Cells[5, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('producao').ToString();
          LstLotes.Cells[6, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('reserva').ToString();
          LstLotes.Cells[7, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('crossdocking').ToString();
          LstLotes.Cells[8, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('segregado').ToString();
          LstLotes.Cells[9, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('saldo').ToString();
          LstLotes.Cells[10, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<Integer>('expedicao').ToString();
          LstLotes.Cells[11, xLista+1] := ArrayEstoqueLotes.Get(xLista).GetValue<String>('dtultimamovimentacao');
       End;
       LstLotes.Alignments[0,  xLista+1] := taRightJustify;
       LstLotes.FontStyles[0,  xLista+1] := [FsBold];
       LstLotes.Alignments[2,  xLista+1] := taCenter;
       LstLotes.Alignments[3,  xLista+1] := taCenter;
       LstLotes.Alignments[4,  xLista+1] := taRightJustify;
       LstLotes.Alignments[5,  xLista+1] := taRightJustify;
       LstLotes.Alignments[6,  xLista+1] := taRightJustify;
       LstLotes.Alignments[7,  xLista+1] := taRightJustify;
       LstLotes.Alignments[8,  xLista+1] := taRightJustify;
       LstLotes.Alignments[9,  xLista+1] := taRightJustify;
       LstLotes.FontStyles[9,  xLista+1] := [FsBold];
       LstLotes.Alignments[10, xLista+1] := taRightJustify;
       LstLotes.Alignments[11, xLista+1] := taCenter;
     end;
     LstLotes.FixedRows := 1;
  End;
  ArrayEstoqueLotes := Nil;
  ObjEstoqueCtrl.Free;
End;

procedure TFrmProduto.GetMovimentacao;
Var ObjEntradaCtrl     : TEntradaCtrl;
    ObjPedidoSaidaCtrl : TPedidoSaidaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
    xTotRecebimentos, xTotRessuprimentos : Integer;
begin
  if EdtCodProduto.Text = '' then
     Exit;
  if FDMemMovRecebimentos.Active then
     FDMemMovRecebimentos.EmptyDataSet;
  FDMemMovRecebimentos.Close;
  if FDMemMovRessuprimentos.Active then
     FDMemMovRessuprimentos.EmptyDataSet;
  FDMemMovRessuprimentos.Close;
  //If Not Assigned(ObjEntradaCtrl) then
     ObjEntradaCtrl := TEntradaCtrl.Create;
  //if Not Assigned(ObjPedidoSaidaCtrl) then
     ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
  JsonArrayRetorno := ObjEntradaCtrl.GetMovimentacao(0, 0, 0, ObjProdutoCtrl.ObjProduto.IdProduto);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     //ShowErro('Erro: '+vErro);
     JsonArrayRetorno := Nil;
     ObjEntradaCtrl := Nil;
  End
  Else Begin
     FDMemMovRecebimentos.LoadFromJson(JsonArrayRetorno, True);
  End;
//  JsonArrayRetorno := Nil;
//  ObjEntradaCtrl := Nil;

//  JsonArrayRetorno.Free;
  ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
  JsonArrayRetorno := ObjPedidoSaidaCtrl.GetMovimentacao(0, 0, 0, ObjProdutoCtrl.ObjProduto.IdProduto);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
//     ShowErro('Erro: '+vErro);
     JsonArrayRetorno := Nil;
     ObjPedidoSaidaCtrl := Nil;
  End
  Else Begin
     FDMemMovRessuprimentos.LoadFromJson(JsonArrayRetorno, False);
  End;
  JsonArrayRetorno   := Nil;
  ObjPedidoSaidaCtrl := Nil; //.Free;
  GetMov := True;
  FDMemMovRecebimentos.Open();
  FDMemMovRecebimentos.First;
  xTotRecebimentos   := 0;
  xTotRessuprimentos := 0;
  while Not FDMemMovRecebimentos.Eof do Begin
    xTotRecebimentos := xTotRecebimentos + FDMemMovRecebimentos.FieldByName('QtdCheckIn').Value;
    FDMemMovRecebimentos.Next;
  End;
  FDMemMovRessuprimentos.Open();
  FDMemMovRessuprimentos.First;
  while Not FDMemMovRessuprimentos.Eof do Begin
    xTotRessuprimentos := xTotRessuprimentos + FDMemMovRessuprimentos.FieldByName('QtdSuprida').Value;
    FDMemMovRessuprimentos.Next;
  End;
  LblTotRecebimentos.Caption := xTotRecebimentos.ToString();
  LblTotRessuprimentos.Caption := xTotRessuprimentos.ToString();
  FDMemMovRecebimentos.First;
  FDMemMovRessuprimentos.First;
end;

procedure TFrmProduto.Limpar;
begin
  EnabledButtons        := False;
  EdtCodProduto.Enabled := True;
  if Not (edtCodProduto.Enabled) then
     edtCodProduto.Clear;
  If Assigned(ObjProdutoCtrl) Then ObjProdutoCtrl.ObjProduto.Limpar;
  CbProdutoTipo.ItemIndex     := -1;
  CbMedicamentoTipo.ItemIndex := -1;
  CbRastroTipo.ItemIndex      := -1;
  EdtDescricao.Clear;
  EdtDescricaoRed.Clear;
  EdtLaboratorioId.Clear;
  EdtUnidadeId.Clear;
  LblUnidade.Caption := '';
  EdtUnidadeSecundariaId.Clear;
  LblUnidadeSecundaria.Caption := '';
  EdtFatorConversao.Clear;
  ChkAtenderCxaFechada.Checked := False;
  chkLiquido.Checked     := False;
  ChkImportado.Checked   := False;
  ChkInflamavel.Checked  := False;
  ChkPerigoso.Checked    := False;
  ChkMedicamento.Checked := False;
  EdtCodigoMs.Clear;
  ChkSNGPC.Checked       := False;
  EdtPicking.Clear;
  LblPicking.Caption     := '';
  EdtZonaArmazenagemId.Clear;
  EdtPeso.Clear;
  EdtAltura.Clear;
  EdtLargura.Clear;
  EdtComprimento.Clear;
  EdtVolume.Clear;
  EdtMinPicking.Clear;
  EdtMaxPicking.Clear;
  //EdtQtdReposicao.Clear;
  EdtPercReposicao.Clear;
  EdtMesEntradaMinima.Clear;
  EdtMesSaidaMinima.Clear;
  EdtCdProdutoERP.Clear;
  EdtVariacaoERP.Clear;
  EdtTamanhoERP.Clear;
  TabImportacaoCSV.TabVisible := False;
  PnlCapturarPeso.Visible := False;
  FDMemMovRecebimentos.Close;
  FDMemMovRessuprimentos.Close;
  LblTotRecebimentos.Caption   := '0';
  LblTotRessuprimentos.Caption := '0';
  GetMov := False;
  LblTotRegistro.Caption := '';
  LstLotes.ClearRect(0, 1, LstLotes.ColCount-1, LstLotes.RowCount-1);
  LstAdvEstoqueEndereco.ClearRect(0, 1, LstAdvEstoqueEndereco.ColCount-1, LstAdvEstoqueEndereco.RowCount-1);
  EdtPicking.Font.Color := ClBlack;
  EdtPicking.Font.Style := [];
end;

procedure TFrmProduto.LstLotesDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (Acol = 0) and (aRow > 0) then Begin
//     if LstLotes.Cells[1, ARow] = 'SL' then
//        raise Exception.Create('Não é permitido esse tipo de alteração.');
     ObjLoteCtrl.ObjLote.ProdutoId  := ObjProdutoCtrl.ObjProduto.IdProduto;
     ObjLoteCtrl.ObjLote.CodigoERP  := ObjProdutoCtrl.ObjProduto.CodProduto;
     ObjLoteCtrl.ObjLote.LoteId     := LstLotes.Cells[Acol, ARow].ToInteger();
     ObjLoteCtrl.ObjLote.DescrLote  := LstLotes.Cells[1, ARow];
     ObjLoteCtrl.ObjLote.Fabricacao := StrToDate(LstLotes.Cells[2, ARow]);
     ObjLoteCtrl.ObjLote.Vencimento := StrToDate(LstLotes.Cells[3, ARow]);
     EdtDescricaoLote.Text    := LstLotes.Cells[1, aRow];
     EdtDtFabricacaoLote.Text := LstLotes.Cells[2, aRow];
     EdtDtVencimentoLote.Text := LstLotes.Cells[3, aRow];
     BtnCrudLote(True);
  End;
end;

procedure TFrmProduto.Panel5Click(Sender: TObject);
Var TimeOut : Integer ;
begin
   try
      TimeOut := StrToInt( '2000' ) ;
   except
      TimeOut := 2000 ;
   end ;
   ACBrBAL1.LePeso( TimeOut );
end;

procedure TFrmProduto.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  Limpar;
  edtCodProduto.Text := LstCadastro.Cells[aCol+1, aRow];
  edtCodProdutoExit(edtCodProduto);
end;

function TFrmProduto.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if pConteudo = '0' then raise Exception.Create('conteúdo inválido para pesquisar!');
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaProduto(EdtConteudoPesq.Text, '0', '', 0, '')
     Else if CbCampoPesq.ItemIndex = 1 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaProduto('0', EdtConteudoPesq.Text, '', 0, '')
     Else if CbCampoPesq.ItemIndex = 2 then Begin//Descricao
        if Length(EdtConteudoPesq.Text) < 3 then
          raise Exception.Create('você deve digitar pelo menos 3 character!');
        Result := GetListaProduto('0', '0', EdtConteudoPesq.Text, 0, '');
     End
     Else if CbCampoPesq.ItemIndex = 3 then
        Result := GetListaProduto('0', '0', '', 0, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
  if Result = False then
     raise Exception.Create('Não econtrei dados da pesquisa!');
end;

procedure TFrmProduto.PgcBaseChange(Sender: TObject);
begin
//  inherited;
  Exit;
  if (PgcBase.ActivePage <> TabPrincipal) and (BtnSalvar.Enabled) then
     PgcBase.ActivePage := TabPrincipal
  Else if (PgcBase.ActivePage <> TabLotes) and (BtnSalvarLote.Visible) then
     PgcBase.ActivePage := TabLotes
  Else if (PgcBase.ActivePage <> TabCodBarras) and (BtnSalvarCodBarras.Visible) then
     PgcBase.ActivePage:= TabCodBarras;
end;

procedure TFrmProduto.PgcBasePageChanging(Sender: TObject; NewPage: TcxTabSheet;
  var AllowChange: Boolean);
begin
  inherited;
  if (PgcBase.ActivePage = TabListagem) then Exit
  Else if ((PgcBase.ActivePage = TabPrincipal) or (PgcBase.ActivePage = TabLotes) or (PgcBase.ActivePage = TabCodBarras)) and ((BtnSalvar.Enabled) or
           (BtnSalvarLote.Visible) or (BtnSalvarCodBarras.Visible)) then
     AllowChange := False; //PgcBase.ActivePageIndex := 3;
end;

Function TFrmProduto.SalvarReg: Boolean;
Var vAtualizarCubagem : Boolean;
    JsonArrayCubagem  : TJsonArray;
    vErro             : String;
begin
  EdtPickingExit(EdtPicking);
  vAtualizarCubagem := False;
  EdtDescricaoRed.SetFocus; //POG para forcar sair de campo que exigir validação no evento OnExit
  With ObjProdutoCtrl.ObjProduto do Begin
    DescricaoRed       := EdtDescricaoRed.Text;
    ProdutoTipo.Id     := CbProdutoTipo.Items.IndexOf(CbProdutoTipo.Text)+1;
    ProdutoTipo.Descricao := CbProdutoTipo.Text;
    CodigoMS           := EdtCodigoMS.Text;
    MedicamentoTipo.Id := CbMedicamentoTipo.Items.IndexOf(CbMedicamentoTipo.Text)+1;
    MedicamentoTipo.Descricao := CbMedicamentoTipo.Text;
    Laboratorio.IdLaboratorio := StrToIntDef(EdtLaboratorioId.Text, 0);
    Curva              := EdtCurva.Text;
    SNGPC              := ChkSNGPC.Checked;
    //Endereco           := TEndereco;
    Unid.Id            := StrToIntDef(EdtUnidadeId.Text, 0);
    QtdUnid            := StrToIntDef(EdtQtdUnid.Text, 0);
    UnidSecundaria.Id  := StrToIntDef(EdtUnidadeSecundariaId.Text, 0);
    FatorConversao     := StrToIntDef(EdtFatorConversao.Text, 0);
    if ChkAtenderCxaFechada.Checked  then
       SomenteCxaFechada := 1
    Else SomenteCxaFechada := 0;
    Rastro.RastroId    := CbRastroTipo.Items.IndexOf(CbRastroTipo.Text)+1;
    Rastro.Descricao   := CbRastroTipo.Text;
    EnderecamentoZona.ZonaId := StrToIntDef(EdtZonaArmazenagemId.Text, 0);
    Liquido            := chkLiquido.Checked;
    Importado          := ChkImportado.Checked;
    Inflamavel         := ChkInflamavel.Checked;
    Perigoso           := ChkPerigoso.Checked;
    Medicamento        := ChkMedicamento.Checked;
    SNGPC              := ChkSNGPC.Checked;
    if (Peso<>EdtPeso.Value) or (Altura<>EdtAltura.Value) or (Largura<>EdtLargura.Value) or (Comprimento<>EdtComprimento.Value) then
       vAtualizarCubagem := True;
    Peso               := EdtPeso.Value;
    Altura             := EdtAltura.Value;
    Largura            := EdtLargura.Value;
    Comprimento        := EdtComprimento.Value;
    Volume             := EdtVolume.Value;
    MinPicking         := StrtoIntDef(EdtMinPicking.text, 0);
    MaxPicking         := StrToIntDef(EdtMaxPicking.Text, 0); //Capacidade Máxima do Picking
    //QtdReposicao       := StrToIntDef(EdtQtdReposicao.Text, 0);
    PercReposicao      := StrToIntDef(EdtPercReposicao.Text, 0);
    MesEntradaMinima   := StrToIntDef(EdtMesEntradaMinima.Text, 0);
    MesSaidaMinima     := StrToIntDef(EdtMesSaidaMinima.Text, 0);
    Status             := Ord(ChkCadastro.Checked);
  End;
  Result := ObjProdutoCtrl.Salvar;
  if Result then Begin
     ObjProdutoCtrl.ObjProduto.IdProduto := 0;
     if vAtualizarCubagem then Begin
        JsonArrayCubagem := ObjProdutoCtrl.AtualizarCubagemIntegracao(ObjProdutoCtrl.ObjProduto.CodProduto,
                                                  ObjProdutoCtrl.ObjProduto.Peso,
                                                  ObjProdutoCtrl.ObjProduto.Altura,
                                                  ObjProdutoCtrl.ObjProduto.Largura,
                                                  ObjProdutoCtrl.ObjProduto.Comprimento,
                                                  FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId,
                                                  NomeDoComputador);
        if JsonArrayCubagem.Items[0].tryGetValue('Erro', vErro) then
           ShowErro(vErro);
        JsonArrayCubagem := Nil;
     End;
  End;
end;

procedure TFrmProduto.ShowDados;
begin
  inherited;
  With ObjProdutoCtrl.ObjProduto do Begin
    If CodProduto <> 0 Then Begin
       PgcBase.ActivePage     := TabPrincipal;
       EnabledButtons         := True;
    End;
    TabLotes.TabVisible           := CodProduto <> 0;
    TabCodBarras.TabVisible       := CodProduto <> 0;
    TabEstoqueEndereco.TabVisible := CodProduto <> 0;
    TabMovimentacao.TabVisible    := CodProduto <> 0;
    //EdtCodPRoduto.Text         := IdProduto.ToString();
    EdtCodProduto.Text            := CodProduto.ToString();
    CbRastroTipo.ItemIndex        := CbRastroTipo.Items.IndexOf(Rastro.Descricao);
    CbProdutoTipo.ItemIndex       := CbProdutoTipo.Items.IndexOf(ProdutoTipo.Descricao);
    EdtCodigoMs.text              := CodigoMs;
    CbMedicamentoTipo.ItemIndex   := CbMedicamentoTipo.Items.IndexOf(MedicamentoTipo.Descricao);  //MedicamentoTipo.Id;
    edtDescricao.Text             := Descricao;
    EdtDescricaoRed.Text          := DescricaoRed;
    EdtLaboratorioId.Text         := IfThen(Laboratorio.IdLaboratorio=0,'', Laboratorio.IdLaboratorio.ToString);
    EdtCurva.Text                 := Curva;
    LblLaboratorio.caption        := Laboratorio.Nome;
    ChkSNGPC.Checked              := SNGPC;
    //EdtPicking.EditMask          := Endereco.EnderecoEstrutura.Mascara+';0;_';
    EdtPicking.Text               := EnderecoMask(Endereco.Descricao, Endereco.EnderecoEstrutura.Mascara, True);
    LblPicking.Caption            := 'Rua: '+Endereco.EnderecoRua.Descricao+'  Zona: '+Endereco.EnderecamentoZona.Descricao;
    EdtUnidadeId.Text             := IfThen(Unid.Id=0, '', Unid.Id.ToString());
    LblUnidade.Caption            := Unid.Sigla+' '+Unid.Descricao;
    EdtQtdUnid.Text               := QtdUnid.ToString;
    EdtZonaArmazenagemId.Text     := IfThen(EnderecamentoZona.ZonaId=0, '' , EnderecamentoZona.ZonaId.ToString);
    LblZonaArmazenagem.Caption    := EnderecamentoZona.Descricao;
    EdtUnidadeSecundariaId.Text   := IfThen(UnidSecundaria.id=0, '', UnidSecundaria.id.ToString());
    LblUnidadeSecundaria.Caption  := UnidSecundaria.Sigla+' '+UnidSecundaria.Descricao;
    EdtFatorConversao.Text        := FatorConversao.ToString();
    ChkAtenderCxaFechada.Checked  := SomenteCxaFechada = 1;
    ChkLiquido.Checked            := Liquido;
    ChkImportado.Checked          := Importado;
    ChkInflamavel.Checked         := Inflamavel;
    ChkPerigoso.Checked           := Perigoso;
    ChkMedicamento.Checked        := Medicamento;
    EdtPeso.Value                 := Peso;
    EdtAltura.Value               := Altura;
    EdtLargura.Value              := Largura;
    EdtComprimento.value          := Comprimento;
    EdtVolume.Value               := Volume;
    EdtMinPicking.Value           := MinPicking;
    EdtMaxPicking.Value           := MaxPicking;
    //EdtQtdReposicao.Value         := QtdReposicao;
    EdtPercReposicao.value        := PercReposicao;
    EdtMesEntradaMinima.Value     := MesEntradaMinima;
    EdtMesSaidaMinima.Value       := MesSaidaMinima;
    ChkCadastro.Checked           := Status = 1;
  End;
end;

procedure TFrmProduto.sImage6Click(Sender: TObject);
begin
  inherited;
  PnlCapturarPeso.Visible := False;
end;

procedure TFrmProduto.SpPaginacaoBottomClick(Sender: TObject);
begin
  inherited;
  GetListaProduto('0', '0', '', StrToIntDef(SpPaginacao.Text, 0)-1, '');
end;

procedure TFrmProduto.TabCodBarrasShow(Sender: TObject);
begin
  inherited;
  AdvSGCodBarras.RowCount  := 2;
  AdvSGCodBarras.ClearRows(1, AdvSGCodBarras.RowCount-2);
  EdtCodProdutoERPEan.Text := EdtCodProduto.Text;
  EdtDescricaoEan.Text     := edtDescricao.Text;
  GetListaProdutoCodBarras(0, ObjProdutoCtrl.ObjProduto.IdProduto, '');
  BtnCrudEan(False);
  TmAtualizarLstCodBarras.Enabled := True;
end;

procedure TFrmProduto.TabEstoqueEnderecoShow(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produto - Estoque') then Begin
     ShowErro('Acesso não autorizado a esta funcionalidade!');
     PgcBase.ActivePage := tabPrincipal;
     Exit;
  End;
  inherited;
  LstAdvEstoqueEndereco.ClearRect(0, 1, LstAdvEstoqueEndereco.ColCount-1, LstAdvEstoqueEndereco.RowCount-1);
  LstAdvEstoqueEndereco.RowCount := 1;
  EdtCodProdutoEstEnd.Text := EdtCodProduto.Text;
  EdtDescricaoEstEnd.Text  := edtDescricao.Text;
  GetListaEstoqueEndereco;
  EdtCodProdutoEstEnd.ReadOnly := True;
  EdtDescricaoEstEnd.ReadOnly  := True;
end;

procedure TFrmProduto.TabLotesShow(Sender: TObject);
begin
  inherited;
  LstLotes.RowCount := 1;
  EdtCodProdutoLote.Text   := EdtCodProduto.Text;
  EdtDescrProdutoLote.Text := edtDescricao.Text;
  GetListaProdutoLotes;
  EdtCodProdutoLote.ReadOnly   := True;
  EdtDescrProdutoLote.ReadOnly := True;
end;

procedure TFrmProduto.TabMovimentacaoShow(Sender: TObject);
begin
  if Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Produto - Movimentações') then Begin
     ShowErro('Acesso não autorizado a esta funcionalidade!');
     PgcBase.ActivePage := tabPrincipal;
     Exit;
  End;
  inherited;
  //GetMovimentacao;
  Try
  if GetMov then Exit;
//  TThread.CreateAnonymousThread(procedure
//    Var xLeft, xPosLeft, xTime : Integer;
//  begin
//    TThread.Synchronize(nil, procedure
//    begin
      GetMovimentacao;
//    End);
//  end).Start;
 Except On E: Exception do
   Showerro('Erro: '+E.Message);
 End;
end;

end.
