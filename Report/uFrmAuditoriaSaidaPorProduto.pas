unit uFrmAuditoriaSaidaPorProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
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
  JvSpin, JvToolEdit, DataSet.Serialize, Generics.Collections, System.Json, Rest.Types,
  dxCameraControl, PedidoVolumeCtrl;

type
  TFrmAuditoriaSaidaPorProduto = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Label10: TLabel;
    EdtPedidoId: TEdit;
    EdtRessuprimento: TEdit;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    GbLote: TGroupBox;
    LblLote: TLabel;
    EdtDescrLote: TEdit;
    FdMemPesqGeralData: TDateField;
    FdMemPesqGeralCodPessoaERP: TIntegerField;
    FdMemPesqGeralFantasia: TStringField;
    FdMemPesqGeralPedidoId: TIntegerField;
    FdMemPesqGeralRessuprimento: TStringField;
    FdMemPesqGeralProcesso: TStringField;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralDescrLote: TStringField;
    FdMemPesqGeralVencimento: TDateField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralEnderecoFormatado: TStringField;
    FdMemPesqGeralPedidoVolumeId: TIntegerField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    FdMemPesqGeralMascara: TStringField;
    Label4: TLabel;
    LblQtdSuprida: TLabel;
    LstLotesAuditoria: TAdvStringGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtInicioChange(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtPedidoIdKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FdMemPesqGeralCalcFields(DataSet: TDataSet);
    procedure BtnExportarStandClick(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    vCodProduto : Integer;
  Protected
    Procedure Imprimir; OverRide;
    Procedure MontarLstAdvReport(pJsonArray : TJsonArray); OverRide;
    Procedure MontalistaLote(pCodproduto : integer);
    Procedure PesquisarDados; OverRide;
    Procedure Limpar; OverRide;
  public
    { Public declarations }
    Procedure LimparLstAdvReport;
    procedure ImprimirRelatorios;
  end;

var
  FrmAuditoriaSaidaPorProduto: TFrmAuditoriaSaidaPorProduto;

implementation

{$R *.dfm}

Uses uFuncoes, Views.Pequisa.Produtos, ProdutoCtrl, PedidoSaidaCtrl, Vcl.DialogMessage;

procedure TFrmAuditoriaSaidaPorProduto.BtnExportarStandClick(Sender: TObject);
begin
  FdMemPesqGeral.FieldByName('DescrLote').Visible := False;
  FdMemPesqGeral.FieldByName('Vencimento').Visible := False;
  FdMemPesqGeral.FieldByName('PedidoVolumeId').Visible := False;
  inherited;

end;

procedure TFrmAuditoriaSaidaPorProduto.BtnPesqProdutoClick(Sender: TObject);
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

procedure TFrmAuditoriaSaidaPorProduto.EdtCodProdutoExit(Sender: TObject);
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
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     JsonProduto := Nil;
     Exit;
  End;
  vCodProduto  := JsonProduto.GetValue<Integer>('codproduto');
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmAuditoriaSaidaPorProduto.EdtInicioChange(Sender: TObject);
begin
  inherited;
  if sender = EdtCodProduto then Begin
     LblProduto.Caption := '';
     vCodProduto := 0;
  End;
  LimparLstAdvReport;
  Limpar;
end;

procedure TFrmAuditoriaSaidaPorProduto.EdtPedidoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmAuditoriaSaidaPorProduto.FdMemPesqGeralCalcFields(
  DataSet: TDataSet);
begin
  inherited;
  FdMemPesqGeral.FieldByname('EnderecoFormatado').AsString := EnderecoMask(FdMemPesqGeral.FieldByName('endereco').AsString,
                                                  FdMemPesqGeral.FieldByName('mascara').AsString, True);
end;

procedure TFrmAuditoriaSaidaPorProduto.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmAuditoriaSaidaPorProduto := Nil;
end;

procedure TFrmAuditoriaSaidaPorProduto.FormCreate(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LstReport.ColWidths[0]  := 100;
  LstReport.ColWidths[1]  :=  70;
  LstReport.ColWidths[2]  := 200;
  LstReport.ColWidths[3]  :=  70;
  LstReport.ColWidths[4]  :=  90;
  LstReport.ColWidths[5]  := 100;
  LstReport.ColWidths[6]  := 70;
  LstReport.ColWidths[7]  := 250;
  LstReport.ColWidths[8]  := 90;
  LstReport.ColWidths[9]  := 90;
  LstReport.Alignments[0, 0]  := taCenter;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[1, 0]  := taRightJustify;
  LstReport.Alignments[3, 0]  := taRightJustify;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[6, 0]  := taRightJustify;
  LstReport.Alignments[8, 0]  := taCenter;
  LstReport.Alignments[9, 0]  := taRightJustify;
  LstReport.FontStyles[9, 0] := [FsBold];

  LstLotesAuditoria.ColWidths[0] := 100;
  LstLotesAuditoria.ColWidths[1] := 120;
  LstLotesAuditoria.ColWidths[2] := 120;
  LstLotesAuditoria.ColWidths[3] := 100;
  LstLotesAuditoria.ColWidths[4] :=  90;
  LstLotesAuditoria.ColWidths[5] := 100;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[3, 0]  := taCenter;
  LstReport.Alignments[4, 0]  := taRightJustify;
  LstReport.Alignments[5, 0]  := taCenter;
  LstLotesAuditoria.FontStyles[4, 0] := [FsBold];
  LstLotesAuditoria.RowCount := 1;
  LstLotesAuditoria.Width := (100+120+12+100+90+100)+20;
end;

procedure TFrmAuditoriaSaidaPorProduto.Imprimir;
begin
  inherited;

end;

procedure TFrmAuditoriaSaidaPorProduto.ImprimirRelatorios;
begin

end;

procedure TFrmAuditoriaSaidaPorProduto.Limpar;
begin
  inherited;
  LblQtdSuprida.Caption := '0';
  LstLotesAuditoria.clearRect(0, 1, LstLotesAuditoria.ColCount-1, LstLotesAuditoria.RowCount-1);
end;

procedure TFrmAuditoriaSaidaPorProduto.LimparLstAdvReport;
begin

end;

procedure TFrmAuditoriaSaidaPorProduto.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
Var ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    JsonArrayRetorno    : TjsonArray;
    vErro : String;
    xLote : Integer;
begin
  inherited;
  if aRow < 1 then Exit;
  LstLotesAuditoria.RowCount := 1;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  JsonArrayRetorno    := ObjPedidoVolumeCtrl.GetPedidoVolumeProduto(LstReport.Cells[3, aRow].ToInteger(),
                                                                    LstReport.Cells[6, aRow].ToInteger() );
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
     ShowErro('Erro: '+vErro)
  Else Begin
     LstLotesAuditoria.RowCount  := JsonArrayRetorno.Count+1;
     LstLotesAuditoria.FixedRows := 1;
     for xLote := 0 to Pred(JsonArrayRetorno.Count) do Begin
       LstLotesAuditoria.Cells[0, xLote+1]  := JsonArrayRetorno.Items[xLote].GetValue<String>('pedidovolumeid');
       LstLotesAuditoria.Cells[1, xLote+1]  := JsonArrayRetorno.Items[xLote].GetValue<String>('embalagem');
       LstLotesAuditoria.Cells[2, xLote+1]  := JsonArrayRetorno.Items[xLote].GetValue<String>('lote');
       LstLotesAuditoria.Cells[3, xLote+1]  := JsonArrayRetorno.Items[xLote].GetValue<String>('vencimento');
       LstLotesAuditoria.Cells[4, xLote+1]  := JsonArrayRetorno.Items[xLote].GetValue<String>('qtdsuprida');
       LstLotesAuditoria.Cells[5, xLote+1]  := EnderecoMask(JsonArrayRetorno.Items[xLote].GetValue<String>('endereco'),
                                                            JsonArrayRetorno.Items[xLote].GetValue<String>('mascara'), True);
       LstReport.Alignments[0, xLote+1] := taRightJustify;
       LstReport.FontStyles[0, xLote+1] := [FsBold];
       LstReport.Alignments[3, xLote+1] := taCenter;
       LstReport.Alignments[4, xLote+1] := taRightJustify;
       LstReport.Alignments[5, xLote+1] := taCenter;
       LstLotesAuditoria.FontStyles[4, xLote+1] := [FsBold];
     End;
  End;
  JsonArrayRetorno := Nil;
  ObjPedidoVolumeCtrl.Free;
end;

procedure TFrmAuditoriaSaidaPorProduto.MontalistaLote(pCodproduto: integer);
begin

end;

procedure TFrmAuditoriaSaidaPorProduto.MontarLstAdvReport(
  pJsonArray: TJsonArray);
Var xRetorno : Integer;
    vTotQtdSuprida : integer;
begin
  inherited;
  LstReport.RowCount       := FdMemPesqGeral.RecordCount+1;
  LstReport.FixedRows := 1;
  xRetorno := 1;
  LblQtdSuprida.Caption := '0';
  vTotQtdSuprida := 0;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRetorno]  := FdMemPesqGeral.FieldByName('data').AsString;
    LstReport.Cells[1, xRetorno]  := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString;
    LstReport.Cells[2, xRetorno]  := FdMemPesqGeral.FieldByName('Fantasia').AsString;
    LstReport.Cells[3, xRetorno]  := FdMemPesqGeral.FieldByName('PedidoId').AsString;
    LstReport.Cells[4, xRetorno]  := FdMemPesqGeral.FieldByName('Ressuprimento').AsString;
    LstReport.Cells[5, xRetorno]  := FdMemPesqGeral.FieldByName('Processo').AsString;
    LstReport.Cells[6, xRetorno]  :=  FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[7, xRetorno]  := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[8, xRetorno] := EnderecoMask(FdMemPesqGeral.FieldByName('endereco').AsString,
                                                 FdMemPesqGeral.FieldByName('mascara').AsString, True);
    LstReport.Cells[9, xRetorno] := FdMemPesqGeral.FieldByName('QtdSuprida').AsString;
    vTotQtdSuprida := vTotQtdSuprida + FdMemPesqGeral.FieldByName('QtdSuprida').AsInteger;
    LstReport.Alignments[0, xRetorno] := taRightJustify;
    LstReport.FontStyles[0, xRetorno] := [FsBold];
    LstReport.Alignments[1, xRetorno] := taRightJustify;
    LstReport.Alignments[3, xRetorno] := taRightJustify;
    LstReport.Alignments[4, xRetorno] := taRightJustify;
    LstReport.Alignments[6, xRetorno] := taRightJustify;
    LstReport.Alignments[8, xRetorno] := taCenter;
    LstReport.Alignments[9, xRetorno] := taRightJustify;
    LstReport.FontStyles[9, xRetorno] := [FsBold];
    FdMemPesqGeral.Next;
    Inc(xRetorno);
  End;
  LblQtdSuprida.Caption := vTotQtdSuprida.ToString;
end;

procedure TFrmAuditoriaSaidaPorProduto.PesquisarDados;
Var vDtInicio, vDtFinal : TDateTime;
    vErro   : String;
    JsonArrayRetorno : TJsonArray;
    vDataInicial, vDataFinal : TDateTime;
    ObjPedidoSaidaCtrl       : TPedidoSaidaCtrl;
begin
  if Not (PgcBase.ActivePage = TabPrincipal) then Exit;
  if vCodProduto = 0 then Begin
     ShowErro('Informe o produto desejado!');
     Exit;
  End;
  if EdtInicio.Text = '  /  /    ' then
     vDataInicial := 0
  Else vDataInicial := StrToDate(EdtInicio.Text);
  if EdtTermino.Text = '  /  /    ' then
     vDataFinal := 0
  Else vDataFinal := StrToDate(EdtTermino.Text);
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xRetorno  : Integer;
    begin
      ObjPedidoSaidaCtrl := TPedidoSaidaCtrl.Create;
      JsonArrayRetorno := ObjPedidoSaidaCtrl.GetAuditoriaSaidaPorProduto(vDataInicial, vDataFinal,
                          StrToIntDef(EdtPedidoId.Text, 0), EdtRessuprimento.Text, vCodProduto, EdtDescrLote.Text);
      if JsonArrayRetorno.Get(0).tryGetValue<String>('Erro', vErro) then Begin
         JsonArrayRetorno := Nil;
         ShowErro('😢Erro: '+vErro);
         LimparLstAdvReport
      End
      Else Begin
        If FdMemPesqGeral.Active then
           FdmemPesqGeral.EmptyDataSet;
        FdMemPesqGeral.Close;
        FdmemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
        FdmemPesqGeral.Open;
        //LblTotRegistro.Caption := FormatFloat('######0', FdMemPesqGeral.RecordCount);
      End;
      JsonArrayRetorno := Nil;
      ObjPedidoSaidaCtrl.Free;
    End);
end;

end.
