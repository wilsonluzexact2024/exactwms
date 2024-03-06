﻿unit uFrmRelRecebimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, DataSet.Serialize,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, acPNG, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage, AdvLookupBar,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, JvToolEdit, Generics.Collections, System.Json, Rest.Types, Vcl.DialogMessage,
  dxCameraControl, FuncionalidadeClass, uFuncoes;

type
  TFrmRelRecebimentos = class(TFrmReportBase)
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    ChkPedidoPendente: TCheckBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblFornecedor: TLabel;
    EdtFornecedor: TEdit;
    BtnPesqFornecedor: TBitBtn;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Label10: TLabel;
    EdtPedidoId: TEdit;
    EdtDocumentoNr: TEdit;
    PgcPedidos: TcxPageControl;
    TabPedidos: TcxTabSheet;
    LstPedidosAdv: TAdvStringGrid;
    TabResumo: TcxTabSheet;
    LstPedidoResumoAdv: TAdvStringGrid;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    LblRegistro: TLabel;
    LblItens: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    LblDemanda: TLabel;
    LblPerda: TLabel;
    LblPercPerda: TLabel;
    TabEspelho: TcxTabSheet;
    LstEspelho: TAdvStringGrid;
    FDMemEspelho: TFDMemTable;
    FDMemResumoCheckIn: TFDMemTable;
    TabOcorrencias: TcxTabSheet;
    GroupBox5: TGroupBox;
    EdtEntradaId: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    EdtRegistroERP: TLabeledEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    EdtDtDoctoIni: TJvDateEdit;
    EdtDtDoctoFin: TJvDateEdit;
    GroupBox9: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    EdtDtCheckInIni: TJvDateEdit;
    EdtDtCheckInFin: TJvDateEdit;
    LstOcorrencias: TAdvStringGrid;
    FDMemOcorrencias: TFDMemTable;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqFornecedorClick(Sender: TObject);
    procedure EdtFornecedorExit(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChkPedidoPendenteClick(Sender: TObject);
    procedure LstPedidosAdvDblClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtInicioChange(Sender: TObject);
    procedure TabOcorrenciasShow(Sender: TObject);
    procedure EdtEntradaIdChange(Sender: TObject);
    procedure BtnExportarStandClick(Sender: TObject);
  private
    { Private declarations }
    vCodproduto : Integer;
    Procedure MontaListaPedido;
    Procedure MontaListaResumoCheckIn;
    procedure GetEspelho(pEntradaId : integer);
    Procedure GetResumoCheckIn(pEntradaId : integer);
    Procedure PesquisarOcorrencias;
    Procedure MontaOcorrencias;
  Protected
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelRecebimentos: TFrmRelRecebimentos;

implementation

{$R *.dfm}

uses uFrmeXactWMS, PessoaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Processos, ProcessoCtrl, uFrmRelResumoPedidos, Views.Pequisa.Produtos,
  ProdutoCtrl, EntradaCtrl;

procedure TFrmRelRecebimentos.BtnExportarStandClick(Sender: TObject);
begin
  if PgcBase.ActivePage = TabOcorrencias then Begin
     if (Not FDMemOcorrencias.Active) or (FDMemOcorrencias.IsEmpty) then
        raise Exception.Create('Não há dados para exportar!');
     if (BtnExportarStand.Grayed) then Exit;
     Try
       ExportarExcel(FDMemOcorrencias);
     Except
       raise Exception.Create('Não foi possível exportar para Excel... Verifique o Sistema Operacional.');
     End;
  End
  Else
     inherited;
end;

procedure TFrmRelRecebimentos.BtnPesqFornecedorClick(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtFornecedor.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtFornecedor.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtFornecedorExit(EdtFornecedor);
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmRelRecebimentos.BtnPesqProcessoClick(Sender: TObject);
Var ReturnJsonArray : TJsonArray;
    ObjPessoaCtrl   : TPessoaCtrl;
    vErro           : String;
begin
  inherited;
  if EdtProcessoId.ReadOnly then Exit;
  inherited;
  FrmPesquisaProcessos := TFrmPesquisaProcessos.Create(Application);
  try
    if (FrmPesquisaProcessos.ShowModal = mrOk) then Begin
       EdtProcessoId.Text := FrmPesquisaProcessos.Tag.ToString;
       EdtProcessoIdExit(EdtProcessoId);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmRelRecebimentos.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if EdtCodProduto.ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodProduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelRecebimentos.BtnPesquisarStandClick(Sender: TObject);
Var vDtInicio, vDtFinal : TDateTime;
    vErro : String;
    vRecebido, vCubagem, vEtiqueta, vPedidoPendente : Integer;
    JsonArrayRetorno : TJsonArray;
    ObjEntradaCtrl   : TEntradaCtrl;
begin
  if PgcBase.ActivePage = TabOcorrencias then Begin
     PesquisarOcorrencias;
     Exit;
  End;

  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  PgcPedidos.ActivePage := TabPedidos;
  Try
    If EdtInicio.Text = '  /  /    ' then
       vDtInicio := 0
    Else vDtInicio :=StrToDate(EdtInicio.Text);
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
  PgcPedidos.ActivePage := TabPedidos;
  TDialogMessage.ShowWaitMessage('Buscando Dados...',
    procedure
    begin
      if ChkpedidoPendente.Checked then
         vPedidoPendente := 1
      else vPedidoPendente := 0;
      ObjEntradaCtrl   := TEntradaCtrl.Create;
      JsonArrayRetorno := ObjEntradaCtrl.GetRelRecebimento(StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtFornecedor.Text, 0), 0, vDtInicio, vDtFInal,
                                                        EdtDocumentoNr.Text, '', '', StrToIntDef(EdtProcessoId.Text, 0),
                                                        vCodProduto, vPedidoPendente);
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         ShowErro('😢Erro: '+vErro);
         LstPedidosAdv.ClearRect(0, 1, LstPedidosAdv.ColCount-1, LstPedidosAdv.RowCount-1);
         LstPedidosAdv.RowCount := 1;
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdMemPesqGeral.LoadFromJson(JsonArrayRetorno, False);
        MontaListaPedido;
        BtnImprimirStand.Grayed := False;
      End;
      ObjEntradaCtrl.Free;
    End);
end;

procedure TFrmRelRecebimentos.ChkPedidoPendenteClick(Sender: TObject);
begin
  inherited;
  if ChkPedidoPendente.Checked then
     EdtPedidoId.Clear;
end;

procedure TFrmRelRecebimentos.TabOcorrenciasShow(Sender: TObject);
begin
  inherited;
  LstOcorrencias.UnHideColumnsAll;
  LstOcorrencias.ColCount := 11;
  LStOcorrencias.ColWidths[0] :=  80;
  LStOcorrencias.ColWidths[1] :=  90;
  LstOcorrencias.ColWidths[2] :=  90;
  LstOcorrencias.ColWidths[3] :=  230;
  LstOcorrencias.ColWidths[4] :=  100;
  LstOcorrencias.ColWidths[5] :=  90;
  LstOcorrencias.ColWidths[6] :=  70;
  LstOcorrencias.ColWidths[7] :=  70;
  LstOcorrencias.ColWidths[8] :=  70;
  LstOcorrencias.ColWidths[9] :=  70;
  LstOcorrencias.ColWidths[10] :=  280;
  LstOcorrencias.Alignments[0, 0] := taRightJustify;
  LstOcorrencias.FontStyles[0, 0] := [FsBold];
  LstOcorrencias.Alignments[1, 0] := taCenter;
  LstOcorrencias.Alignments[2, 0] := taRightJustify;
  LstOcorrencias.Alignments[5, 0] := taCenter;
  LstOcorrencias.Alignments[6, 0] := taRightJustify;
  LstOcorrencias.Alignments[7, 0] := taRightJustify;
  LstOcorrencias.Alignments[8, 0] := taRightJustify;
  LstOcorrencias.Alignments[9, 0] := taRightJustify;
  LstOcorrencias.HideColumn(6);
  LstOcorrencias.HideColumn(7);
  LstOcorrencias.RowCount := 1;
end;

procedure TFrmRelRecebimentos.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vCodProduto := JsonProduto.GetValue<Integer>('codproduto');
  if vCodProduto <= 0 then Begin
     ShowErro('Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     Exit;
  End;
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
end;

procedure TFrmRelRecebimentos.EdtEntradaIdChange(Sender: TObject);
begin
  inherited;
  LstOcorrencias.RowCount     := 1;
  If FDMemOcorrencias.Active then
     FDMemOcorrencias.EmptyDataSet;
  FDMemOcorrencias.Close;
  ImprimirExportar(False);
end;

procedure TFrmRelRecebimentos.EdtFornecedorExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtFornecedor.Text = '' then Begin
     LblFornecedor.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtFornecedor.Text, 0) <= 0 then Begin
     LblFornecedor.Caption := '';
     ShowErro( '😢Fornecedor('+EdtFornecedor.Text+') não encontrado!' );
     EdtFornecedor.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtFornecedor.text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblFornecedor.Caption := '';
     ShowErro( '😢Fornecedor('+EdtFornecedor.Text+') não encontrado!' );
     EdtFornecedor.Clear;
  end
  Else
     LblFornecedor.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelRecebimentos.EdtInicioChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelRecebimentos.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
  if EdtProcessoId.Text = '' then Begin
     LblProcesso.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtProcessoId.Text, 0) <= 0 then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo('+EdtProcessoId.Text+') inválido!' );
     EdtProcessoId.Clear;
     Exit;
  end;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(EdtProcessoId.text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo não('+EdtProcessoId.Text+') encontrado!');
     EdtProcessoId.Clear;
  end
  Else
     LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
//  JsonArrayRetorno.Free;
//  ObjProcessoCtrl.Free;
  ExitFocus(Sender);

end;

procedure TFrmRelRecebimentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelRecebimentos := Nil;
end;

procedure TFrmRelRecebimentos.FormCreate(Sender: TObject);
begin
  inherited;
  TabListagem.TabVisible := False;
  LstPedidosAdv.ColWidths[0]  := 100;
  LstPedidosAdv.ColWidths[1]  :=  75;
  LstPedidosAdv.ColWidths[2]  := 100;
  LstPedidosAdv.ColWidths[3]  :=  75;
  LstPedidosAdv.ColWidths[4]  := 280;
  LstPedidosAdv.ColWidths[5]  := 100;
  LstPedidosAdv.ColWidths[6]  := 120;
  LstPedidosAdv.ColWidths[7]  :=  75;
  LstPedidosAdv.ColWidths[8]  :=  40;
  LstPedidosAdv.ColWidths[9]  :=  80;
  LstPedidosAdv.ColWidths[10] :=  80;
  LstPedidosAdv.ColWidths[11] :=  80;
  LstPedidosAdv.ColWidths[12] :=  80;
  LstPedidosAdv.ColWidths[13] :=  80;
  LstPedidosAdv.ColWidths[14] :=  280;
  LstPedidosAdv.Alignments[0, 0]  := taRightJustify;
  LstPedidosAdv.FontStyles[0, 0]  := [FsBold];
  LstPedidosAdv.Alignments[1, 0]  := taCenter;
  LstPedidosAdv.Alignments[7, 0]  := taCenter;
  LstPedidosAdv.Alignments[8, 0]  := taRightJustify;
  LstPedidosAdv.Alignments[9, 0] := taRightJustify;
  LstPedidosAdv.Alignments[10, 0] := taRightJustify;
  LstPedidosAdv.Alignments[11, 0] := taRightJustify;
  LstPedidosAdv.Alignments[12, 0] := taRightJustify;
  LstPedidosAdv.Alignments[13, 0] := taCenter;

  LstPedidoResumoAdv.ColWidths[0]  :=  90;
  LstPedidoResumoAdv.ColWidths[1]  :=  80;
  LstPedidoResumoAdv.ColWidths[2]  := 300;
  LstPedidoResumoAdv.ColWidths[3]  :=  85;
  LstPedidoResumoAdv.ColWidths[4]  := 150;
  LstPedidoResumoAdv.ColWidths[5]  := 130;
  LstPedidoResumoAdv.ColWidths[6]  :=  80;
  LstPedidoResumoAdv.ColWidths[7]  :=  60;
  LstPedidoResumoAdv.ColWidths[8]  :=  80;
  LstPedidoResumoAdv.ColWidths[9]  :=  70;
  LstPedidoResumoAdv.ColWidths[10] :=  70;
  LstPedidoResumoAdv.ColWidths[11] := 150;
  LstPedidoResumoAdv.ColWidths[12] :=  80;
  LstPedidoResumoAdv.ColWidths[13] :=  80;
  LstPedidoResumoAdv.ColWidths[14] := 170;
  LstPedidoResumoAdv.ColWidths[15] := 120;
  LstPedidoResumoAdv.ColWidths[16] := 250;
  LstPedidoResumoAdv.Alignments[0, 0]  := taRightJustify;
  LstPedidoResumoAdv.FontStyles[0, 0]  := [FsBold];
  LstPedidoResumoAdv.Alignments[1, 0]  := taRightJustify;
  LstPedidoResumoAdv.Alignments[6, 0]  := taCenter;
  LstPedidoResumoAdv.Alignments[7, 0]  := taRightJustify;
  LstPedidoResumoAdv.Alignments[8, 0]  := taRightJustify;
  LstPedidoResumoAdv.Alignments[9, 0]  := taRightJustify;
  LstPedidoResumoAdv.Alignments[10, 0] := taRightJustify;
  LstPedidoResumoAdv.Alignments[12, 0] := taCenter;
  LstPedidoResumoAdv.Alignments[13, 0] := taCenter;

  LstEspelho.ColWidths[0] :=  100;
  LstEspelho.ColWidths[1] :=  90;
  LstEspelho.ColWidths[2] :=  400;
  LstEspelho.ColWidths[3] :=  130;
  LstEspelho.ColWidths[4] :=  90;
  LstEspelho.ColWidths[5] :=  70;
  LstEspelho.ColWidths[6] :=  70;
  LstEspelho.ColWidths[7] :=  70;
  LstEspelho.ColWidths[8] :=  70;
  LstEspelho.Alignments[0, 0] := taRightJustify;
  LstEspelho.FontStyles[0, 0] := [FsBold];
  LstEspelho.Alignments[1, 0] := taRightJustify;
  LstEspelho.Alignments[4, 0] := taCenter;
  LstEspelho.Alignments[5, 0] := taRightJustify;
  LstEspelho.Alignments[6, 0] := taRightJustify;
  LstEspelho.Alignments[7, 0] := taRightJustify;
  LstEspelho.Alignments[8, 0] := taRightJustify;
  LstEspelho.RowCount := 1;
End;

procedure TFrmRelRecebimentos.MontaListaPedido;
Var xPed, xItens, xQtdXml, xQtdCheckIn, xQtdDevolvida, xQtdSegregada, xRecno : Integer;
begin
  LstPedidosAdv.RowCount := FdMemPesqGeral.RecordCount+1;
  If LstPedidosAdv.RowCount > 1 Then LstPedidosAdv.FixedRows := 1;
  for xPed := 1 to FdMemPesqGeral.RecordCount do
    LstPedidosAdv.AddDataImage(13, xPed, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
  LblRegistro.Caption    := FormatFloat('#0', FdMemPesqGeral.RecordCount);
  LblTotRegistro.Caption := FormatFloat('#0', FdMemPesqGeral.RecordCount);
  xQtdXml       := 0;
  xQtdCheckIn   := 0;
  xQtdDevolvida := 0;
  xQtdSegregada := 0;
  xRecno        := 1;
//  for xPed := 1 to pJsonArray.Count do
//    LstPedidosAdv.AddDataImage(22, xPed, 2, TCellHAlign.haCenter, TCellVAlign.vaTop);
  While Not FdMemPesqGeral.Eof do Begin
    LstPedidosAdv.Cells[0, xRecno] := FdMemPesqGeral.FieldByName('pedidoid').AsString;
    LstPedidosAdv.Cells[1, xRecno] := FdMemPesqGeral.FieldByName('documentodata').AsString;
    LstPedidosAdv.Cells[2, xRecno] := FdMemPesqGeral.FieldByName('operacaoTipo').AsString;
    LstPedidosAdv.Cells[3, xRecno] := FdMemPesqGeral.FieldByName('codpessoaerp').AsString;
    LstPedidosAdv.Cells[4, xRecno] := FdMemPesqGeral.FieldByName('razao').AsString;
    LstPedidosAdv.Cells[5, xRecno] := FdMemPesqGeral.FieldByName('DocumentoNr').AsString;
    LstPedidosAdv.Cells[6, xRecno] := FdMemPesqGeral.FieldByName('etapa').AsString;
    if FdMemPesqGeral.FieldByName('processoid').AsInteger = 4 then
       LstPedidosAdv.Colors[6, xRecno] := $00B0FFFF
    Else if FdMemPesqGeral.FieldByName('processoid').AsInteger = 5 then
       LstPedidosAdv.Colors[6, xRecno] := $0000B700
    Else if FdMemPesqGeral.FieldByName('processoid').AsInteger = 6 then
       LstPedidosAdv.Colors[6, xRecno] := $00005900
    Else If FdMemPesqGeral.FieldByName('processoid').AsInteger = 15 then
       LstPedidosAdv.Colors[6, xRecno] := ClRed
    Else
       LstPedidosAdv.Colors[6, xRecno] := LstPedidosAdv.Colors[2, xRecno];
    LstPedidosAdv.Cells[7, xRecno]    := FdMemPesqGeral.FieldByName('dtprocesso').AsString;
    LstPedidosAdv.Cells[8, xRecno]    := FdMemPesqGeral.FieldByName('Itens').AsString;
    LstPedidosAdv.Cells[9, xRecno]    := FdMemPesqGeral.FieldByName('QtdXml').AsString;
    LstPedidosAdv.Cells[10, xRecno]   := FdMemPesqGeral.FieldByName('QtdCheckIn').AsString;
    LstPedidosAdv.Cells[11, xRecno]   := FdMemPesqGeral.FieldByName('QtdDevolvida').AsString;
    LstPedidosAdv.Cells[12, xRecno]   := FdMemPesqGeral.FieldByName('QtdSegregada').AsString;
    xItens        := xItens  + FdMemPesqGeral.FieldByName('itens').AsInteger;
    xQtdXml       := xQtdXml + FdMemPesqGeral.FieldByName('QtdXml').AsInteger;
    xQtdCheckIn   := xQtdCheckIn   + FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger;
    xQtdDevolvida := xQtdDevolvida + FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger;
    xQtdSegregada := xQtdSegregada + FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger;
    if FdMemPesqGeral.FieldByName('processoid').AsInteger > 1 then Begin
       if (FdMemPesqGeral.FieldByName('QtdCheckin').AsInteger+FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger+FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger) > FdMemPesqGeral.FieldByName('QtdXml').AsInteger then
          LstPedidosAdv.Colors[9, xRecno] := ClRed
       else if (FdMemPesqGeral.FieldByName('QtdCheckin').AsInteger+FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger+FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger) < FdMemPesqGeral.FieldByName('QtdXml').AsInteger then
          LstPedidosAdv.Colors[9, xRecno] := ClYellow
       Else If (FdMemPesqGeral.FieldByName('QtdCheckin').AsInteger+FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger+FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger) = FdMemPesqGeral.FieldByName('QtdXml').AsInteger then
          LstPedidosAdv.Colors[9, xRecno] := ClGreen
       Else LstPedidosAdv.Colors[9, xRecno] := LstPedidosAdv.Colors[8, xRecno];
    End
    Else LstPedidosAdv.Colors[9, xRecno] := LstPedidosAdv.Colors[8, xRecno];
    LstPedidosAdv.Cells[13, xRecno]   := FdMemPesqGeral.FieldByName('Picking').AsString;
    LstPedidosAdv.Cells[14, xRecno]   := FdMemPesqGeral.FieldByName('RegistroERP').AsString;
    LstPedidosAdv.Alignments[0, xRecno]  := taRightJustify;
    LstPedidosAdv.FontStyles[0, xRecno]  := [FsBold];
    LstPedidosAdv.Alignments[1, xRecno]  := taCenter;
    LstPedidosAdv.Alignments[7, xRecno]  := taCenter;
    LstPedidosAdv.Alignments[8, xRecno]  := taRightJustify;
    LstPedidosAdv.Alignments[9, xRecno] := taRightJustify;
    LstPedidosAdv.Alignments[10, xRecno] := taRightJustify;
    LstPedidosAdv.Alignments[11, xRecno] := taRightJustify;
    LstPedidosAdv.Alignments[12, xRecno] := taRightJustify;
    LstPedidosAdv.Alignments[13, xRecno] := taCenter;
    inc(xRecno);
    FdMemPesqGeral.Next;
  End;
end;

procedure TFrmRelRecebimentos.MontaListaResumoCheckIn;
Var xItens     : Integer;
    vColorFont : TColor;
begin
  xItens := 0;
  While Not FdMemResumoCheckIn.Eof do Begin
    if (FdMemResumoCheckIn.FieldByName('QtdXml').AsInteger = 0) then
       vColorFont := ClRed
    Else vColorFont := clBlack;
    LstPedidoResumoAdv.FontColors[0, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[1, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[2, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[3, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[4, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[5, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[6, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[7, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[8, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[9, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[10, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[11, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[12, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[13, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[14, xItens+1] := vColorFont;
    LstPedidoResumoAdv.FontColors[15, xItens+1] := vColorFont;
    LstPedidoResumoAdv.Cells[0, xItens+1]  := FdMemResumoCheckIn.FieldByName('Pedidoid').AsString;;
    LstPedidoResumoAdv.Cells[1, xItens+1]  := FdMemResumoCheckIn.FieldByName('codproduto').AsString;
    LstPedidoResumoAdv.Cells[2, xItens+1]  := FdMemResumoCheckIn.FieldByName('descricao').AsString;
    LstPedidoResumoAdv.Cells[3, xItens+1]  := FdMemResumoCheckIn.FieldByName('Endereco').AsString;
    LstPedidoResumoAdv.Cells[4, xItens+1]  := FdMemResumoCheckIn.FieldByName('Zona').AsString;
    LstPedidoResumoAdv.Cells[5, xItens+1]  := FdMemResumoCheckIn.FieldByName('Lote').AsString;
    LstPedidoResumoAdv.Cells[6, xItens+1]  := FdMemResumoCheckIn.FieldByName('Vencimento').AsString;
    LstPedidoResumoAdv.Cells[7, xItens+1]  := FdMemResumoCheckIn.FieldByName('QtdXml').AsString;
    LstPedidoResumoAdv.Cells[8, xItens+1]  := FdMemResumoCheckIn.FieldByName('QtdCheckIn').AsString;
    LstPedidoResumoAdv.Cells[9, xItens+1]  := FdMemResumoCheckIn.FieldByName('QtdDevolvida').AsString;
    LstPedidoResumoAdv.Cells[10, xItens+1] := FdMemResumoCheckIn.FieldByName('QtdSegregada').AsString;
    LstPedidoResumoAdv.Cells[11, xItens+1] := FdMemResumoCheckIn.FieldByName('Nome').AsString;
    LstPedidoResumoAdv.Cells[12, xItens+1] := FdMemResumoCheckIn.FieldByName('DtConferencia').AsString;
    LstPedidoResumoAdv.Cells[13, xItens+1] := FdMemResumoCheckIn.FieldByName('HrConferencia').AsString;
    LstPedidoResumoAdv.Cells[14, xItens+1] := FdMemResumoCheckIn.FieldByName('ResponsavelLote').AsString;
    LstPedidoResumoAdv.Cells[15, xItens+1] := FdMemResumoCheckIn.FieldByName('Terminal').AsString;
    LstPedidoResumoAdv.Cells[16, xItens+1] := FdMemResumoCheckIn.FieldByName('Causa').AsString;
    LstPedidoResumoAdv.Alignments[0, xItens+1]  := taRightJustify;
    LstPedidoResumoAdv.FontStyles[0, xItens+1]  := [FsBold];
    LstPedidoResumoAdv.Alignments[1, xItens+1]  := taRightJustify;
    LstPedidoResumoAdv.Alignments[6, xItens+1]  := taCenter;
    LstPedidoResumoAdv.Alignments[7, xItens+1]  := taRightJustify;
    LstPedidoResumoAdv.Alignments[8, xItens+1]  := taRightJustify;
    LstPedidoResumoAdv.Alignments[9, xItens+1]  := taRightJustify;
    LstPedidoResumoAdv.Alignments[10, xItens+1] := taRightJustify;
    LstPedidoResumoAdv.Alignments[12, xItens+1] := taCenter;
    LstPedidoResumoAdv.Alignments[13, xItens+1] := taCenter;
    Inc(xItens);
    FdMemResumoCheckIn.Next;
  End;
end;


procedure TFrmRelRecebimentos.MontaOcorrencias;
Var xItens     : Integer;
    vColorFont : TColor;
begin
  xItens := 0;
  LstOcorrencias.RowCount  := FDMemOcorrencias.RecordCount+1;
  LstOcorrencias.FixedRows := 1;
  While Not FdMemOcorrencias.Eof do Begin
//    if (FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger+FdMemPesqGeral.FieldByName('QtdDevolvida').Asinteger+
//        FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger) = 0 then
//       vColorFont := ClRed
//    Else
         vColorFont := clBlack;
    LstOcorrencias.FontColors[ 0, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 1, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 2, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 3, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 4, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 5, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 6, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 7, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 8, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[ 9, xItens+1] := vColorFont;
    LstOcorrencias.FontColors[10, xItens+1] := vColorFont;
    LstOcorrencias.Cells[0, xItens+1] := FdMemOcorrencias.FieldByName('Idproduto').AsString;;
    LstOcorrencias.Cells[1, xItens+1] := DateEUAtoBr(FdMemOcorrencias.FieldByName('documentodata').AsString);
    LstOcorrencias.Cells[2, xItens+1] := FdMemOcorrencias.FieldByName('codproduto').AsString;
    LstOcorrencias.Cells[3, xItens+1] := FdMemOcorrencias.FieldByName('descricao').AsString;
    LstOcorrencias.Cells[4, xItens+1] := FdMemOcorrencias.FieldByName('lote').AsString;
    LstOcorrencias.Cells[5, xItens+1] := FdMemOcorrencias.FieldByName('vencimento').AsString;
//    LstOcorrencias.Cells[6, xItens+1] := FdMemOcorrencias.FieldByName('QtdXml').AsString;
//    LstOcorrencias.Cells[7, xItens+1] := FdMemOcorrencias.FieldByName('QtdCheckIn').AsString;
    LstOcorrencias.Cells[8, xItens+1] := FdMemOcorrencias.FieldByName('qtddevolvida').AsString;
    LstOcorrencias.Cells[9, xItens+1] := FdMemOcorrencias.FieldByName('qtdsegregada').AsString;
    LstOcorrencias.Cells[10, xItens+1] := FdMemOcorrencias.FieldByName('motivo').AsString;
    LstOcorrencias.Alignments[0, xItens+1] := taRightJustify;
    LstOcorrencias.FontStyles[0, xItens+1] := [FsBold];
    LstOcorrencias.Alignments[1, xItens+1] := taCenter;
    LstOcorrencias.Alignments[2, xItens+1] := taRightJustify;
    LstOcorrencias.Alignments[5, xItens+1] := taCenter;
    LstOcorrencias.Alignments[6, xItens+1] := taRightJustify;
    LstOcorrencias.Alignments[7, xItens+1] := taRightJustify;
    LstOcorrencias.Alignments[8, xItens+1] := taRightJustify;
    LstOcorrencias.Alignments[9, xItens+1] := taRightJustify;
    Inc(xItens);
    FdMemOcorrencias.Next;
  End;
end;

procedure TFrmRelRecebimentos.PesquisarOcorrencias;
Var ObjEntradaCtrl : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro  : String;
    xItens : Integer;
    pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckInDtFin: TDateTime;
    vColorFont : TColor;
begin
  inherited;
  LstReport.RowCount := 1;
  //FdMemPesqGeral.Close;
  ImprimirExportar(False);
  Try
    If EdtDtDoctoIni.Text = '  /  /    ' then
       pDoctoDataIni := 0
    Else pDoctoDataIni := StrToDate(EdtDtDoctoIni.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial do Documeto inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtDoctoFin.Text = '  /  /    ' then
       pDoctoDataFin := 0
    Else pDoctoDataFin := StrToDate(EdtDtDoctoFin.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final do Documeto inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtCheckInIni.Text = '  /  /    ' then
       pCheckInDtIni := 0
    Else pCheckInDtIni := StrToDate(EdtDtCheckInIni.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Inicial do CheckIn inválida!'+#13+#10+E.Message);
  End;
  Try
    If EdtDtCheckInFin.Text = '  /  /    ' then
       pCheckInDtFin := 0
    Else pCheckInDtFin := StrToDate(EdtDtCheckInFin.Text);
  Except On E: Exception do
    raise Exception.Create('Erro: Data Final do CheckIn inválida!'+#13+#10+E.Message);
  End;
  ObjEntradaCtrl   := TEntradaCtrl.Create();
  JsonArrayRetorno := ObjEntradaCtrl.GetEntradaOcorrencia(StrToIntDef(EdtEntradaId.Text, 0), EdtDocumentoNr.Text,
                      EdtRegistroERP.Text, pDoctoDataIni, pDoctoDataFin, pCheckInDtIni, pCheckInDtFin);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtEntradaId.SetFocus;
     ShowErro('Erro: '+vErro);
  End
  Else Begin
     If FdMemOcorrencias.Active then
        FdMemOcorrencias.EmptyDataSet;
     FdMemOcorrencias.Close;
     FdMemOcorrencias.LoadFromJSON(JsonArrayRetorno, False);
     MontaOcorrencias;
     ImprimirExportar(True);
  End;
  JsonArrayRetorno := Nil;
  ObjEntradaCtrl.Free;
end;

procedure TFrmRelRecebimentos.GetEspelho(pEntradaId : integer);
Var ObjEntradaCtrl : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro  : String;
    xItens : Integer;
    vColorFont : TColor;
begin
  inherited;
  LstEspelho.RowCount := 1;
  If FdMemEspelho.Active then
     FdMemEspelho.EmptyDataSet;
  FdMemEspelho.Close;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  JsonArrayRetorno   := ObjEntradaCtrl.GetEspelho(pEntradaId, '', '', 0, 0, 0, 0, 0, 0);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     EdtInicio.SetFocus;
  End
  Else Begin
    FdMemEspelho.LoadFromJSON(JsonArrayRetorno, False);
    if Not FdMemPesqGeral.IsEmpty then Begin
       LstEspelho.RowCount  := FdMemEspelho.RecordCount+1;
       LstEspelho.FixedRows := 1;
    End;
    xItens := 0;
    While Not FdMemEspelho.Eof do Begin
      if (FdMemEspelho.FieldByName('QtdCheckIn').AsInteger+FdMemEspelho.FieldByName('QtdDevolvida').Asinteger+
          FdMemEspelho.FieldByName('QtdSegregada').AsInteger) = 0 then
         vColorFont := ClRed
      Else vColorFont := clBlack;
      LstEspelho.FontColors[0, xItens+1] := vColorFont;
      LstEspelho.FontColors[1, xItens+1] := vColorFont;
      LstEspelho.FontColors[2, xItens+1] := vColorFont;
      LstEspelho.FontColors[3, xItens+1] := vColorFont;
      LstEspelho.FontColors[4, xItens+1] := vColorFont;
      LstEspelho.FontColors[5, xItens+1] := vColorFont;
      LstEspelho.FontColors[6, xItens+1] := vColorFont;
      LstEspelho.FontColors[7, xItens+1] := vColorFont;
      LstEspelho.FontColors[8, xItens+1] := vColorFont;
      LstEspelho.Cells[0, xItens+1] := FdMemEspelho.FieldByName('produtoid').AsString;;
      LstEspelho.Cells[1, xItens+1] := FdMemEspelho.FieldByName('codproduto').AsString;
      LstEspelho.Cells[2, xItens+1] := FdMemEspelho.FieldByName('descricao').AsString;
      LstEspelho.Cells[3, xItens+1] := FdMemEspelho.FieldByName('descrlote').AsString;
      LstEspelho.Cells[4, xItens+1] := FdMemEspelho.FieldByName('vencimento').AsString;
      LstEspelho.Cells[5, xItens+1] := FdMemEspelho.FieldByName('QtdXml').AsString;
      LstEspelho.Cells[6, xItens+1] := FdMemEspelho.FieldByName('QtdCheckIn').AsString;
      LstEspelho.Cells[7, xItens+1] := FdMemEspelho.FieldByName('QtdDevolvida').AsString;
      LstEspelho.Cells[8, xItens+1] := FdMemEspelho.FieldByName('QtdSegregada').AsString;
      LstEspelho.Alignments[0, xItens+1] := taRightJustify;
      LstEspelho.FontStyles[0, xItens+1] := [FsBold];
      LstEspelho.Alignments[1, xItens+1] := taRightJustify;
      LstEspelho.Alignments[4, xItens+1] := taCenter;
      LstEspelho.Alignments[5, xItens+1] := taRightJustify;
      LstEspelho.Alignments[6, xItens+1] := taRightJustify;
      LstEspelho.Alignments[7, xItens+1] := taRightJustify;
      LstEspelho.Alignments[8, xItens+1] := taRightJustify;
      Inc(xItens);
      FdMemEspelho.Next;
    End;
  End;
  JsonArrayRetorno := Nil;
  ObjEntradaCtrl   := Nil;
end;

procedure TFrmRelRecebimentos.GetResumoCheckIn(pEntradaId: integer);
Var ObjEntradaCtrl : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro  : String;
    xItens : Integer;
    vColorFont : TColor;
begin
  inherited;
  LstPedidoResumoAdv.RowCount := 1;
  If FdMemResumoCheckIn.Active then
     FdMemResumoCheckIn.EmptyDataSet;
  FdMemResumoCheckIn.Close;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  JsonArrayRetorno   := ObjEntradaCtrl.GetResumoCheckIn(pEntradaId);
  if JsonArrayRetorno.Items[0].TryGetValue<String>('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     EdtInicio.SetFocus;
  End
  Else Begin
    FdMemResumoCheckIn.LoadFromJSON(JsonArrayRetorno, False);
    if Not FdMemResumoCheckIn.IsEmpty then Begin
       LstPedidoResumoAdv.RowCount  := FdMemResumoCheckIn.RecordCount+1;
       LstPedidoResumoAdv.FixedRows := 1;
       MontaListaResumoCheckIn();
    End;
  End;
  JsonArrayRetorno := Nil;
  ObjEntradaCtrl   := Nil;
end;

procedure TFrmRelRecebimentos.Limpar;
begin
  inherited;
  LstPedidosAdv.RowCount      := 1;
  LstPedidoResumoAdv.RowCount := 1;
  LstEspelho.RowCount         := 1;
  If FdMemEspelho.Active then
     FdMemEspelho.EmptyDataSet;
  FdMemEspelho.Close;
  vCodproduto := 0;
end;

procedure TFrmRelRecebimentos.LstPedidosAdvDblClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (ACol = 0) and (ARow>0) then Begin
     GetResumoCheckIn(StrToIntDef(LstPedidosAdv.Cells[Acol, ARow], 0));
     GetEspelho(StrToIntDef(LstPedidosAdv.Cells[Acol, ARow], 0));
     PgcPedidos.ActivePage := TabResumo;
  End;
end;

end.
