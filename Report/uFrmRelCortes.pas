﻿unit uFrmRelCortes;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ComCtrls, Vcl.DBGrids, acPNG, acImage, AdvLookupBar, AdvGridLookupBar,
  Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, Vcl.DialogMessage,
  DataSet.Serialize, Generics.Collections, System.Json, Rest.Types, JvToolEdit,
  dxCameraControl;

type
  TFrmRelCortes = class(TFrmReportBase)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox6: TGroupBox;
    Label11: TLabel;
    Label10: TLabel;
    EdtPedidoId: TEdit;
    EdtDocumentoNr: TEdit;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    FdMemPesqGeralPedidoId: TIntegerField;
    FdMemPesqGeralProdutoId: TIntegerField;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralDemanda: TIntegerField;
    FdMemPesqGeralEmbalagem: TStringField;
    FdMemPesqGeralCubagem: TIntegerField;
    FdMemPesqGeralCheckOut: TIntegerField;
    FdMemPesqGeralQtdSuprida: TIntegerField;
    ChkCubagem: TCheckBox;
    ChkCheckOut: TCheckBox;
    ChkSintetico: TCheckBox;
    ChkCancelados: TCheckBox;
    GbTotal: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    LblTotCubagem: TLabel;
    LblTotCheckout: TLabel;
    FdMemPesqGeralCancelado: TIntegerField;
    Label6: TLabel;
    LblTotCancelado: TLabel;
    Label7: TLabel;
    LblTotal: TLabel;
    FdMemPesqGeralEstoque: TIntegerField;
    FdMemPesqGeralVencido: TIntegerField;
    GroupBox2: TGroupBox;
    LblZona: TLabel;
    Label16: TLabel;
    EdtZonaId: TEdit;
    BtnPesqZona: TBitBtn;
    procedure FormDestroy(Sender: TObject);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure EdtZonaIdChange(Sender: TObject);
    procedure EdtZonaIdExit(Sender: TObject);
    procedure EdtInicioEnter(Sender: TObject);
    procedure EdtInicioExit(Sender: TObject);
  private
    { Private declarations }
    vCodProduto : Integer;
    Procedure MontaListaCorte;
    Procedure Limpar;
  public
    { Public declarations }
  end;

var
  FrmRelCortes: TFrmRelCortes;

implementation

{$R *.dfm}

uses PedidoSaidaCtrl, uFuncoes, Views.Pequisa.Produtos, ProdutoCtrl,
  EnderecamentoZonaCtrl, Views.Pequisa.EnderecamentoZonas;

procedure TFrmRelCortes.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then  Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodProduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelCortes.BtnPesquisarStandClick(Sender: TObject);
Var ObjPedidoCtrl      : TPedidoSaidaCtrl;
    JsonArrayRetorno   : TJsonArray;
    vErro              : String;
    pDataIni, pDataFin : TDateTime;
    vSintetico         : Integer;
begin
  pDataIni := 0;
  pDataFin := 0;
  Try
    If EdtInicio.Text <> '  /  /    ' then
       pDataIni := StrToDate(EdtInicio.Text);
  Except
    raise Exception.Create('Data Inicial inválida!');
  End;
  Try
    If EdtTermino.Text <> '  /  /    ' then
       pDataFin := StrToDate(EdtTermino.Text);
  Except
    raise Exception.Create('Data Final inválida!');
  End;
  if StrToIntDef(EdtPedidoId.Text, 0) < 0 then
     raise Exception.Create('Id de Pedido inválido!');
  if StrToIntDef(EdtCodProduto.Text, 0) < 0 then
     raise Exception.Create('Código do produto inválido!');
  if ChkSintetico.Checked then
     vSintetico := 1
  Else vSintetico := 0;
  inherited;
  BtnImprimirStand.Grayed := True;
  TDialogMessage.ShowWaitMessage('Buscando Dados, conectado com servidor...',
    procedure
    Var xItens : Integer;
    begin
      ObjPedidoCtrl := TPedidoSaidaCtrl.Create();
      jsonArrayRetorno := ObjPedidoCtrl.GetCortes(pDataIni, pDataFin, StrToIntDef(EdtPedidoId.Text, 0),
                          vCodProduto, vSintetico, StrToIntDef(EdtZonaId.Text, 0));
      if JsonArrayRetorno.Items[0].TryGetValue<string>('Erro', vErro) then
         ShowErro(verro)
      Else Begin
         If FdMemPesqGeral.Active then
            FdmemPesqGeral.EmptyDataSet;
         FdMemPesqGeral.Close;
         FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
         BtnImprimirStand.Grayed  := FdMemPesqGeral.IsEmpty;
         BtnExportarStand.Grayed  := FdMemPesqGeral.IsEmpty;
         BtnImprimirStand.Enabled := True;
         BtnExportarStand.Enabled := True;
         If Not FdMemPesqGeral.IsEmpty then
            MontaListaCorte
         Else ShowErro('Não foi encontrado dados na consulta.');
      End;
      JsonArrayRetorno := Nil;
      ObjPedidoCtrl.Free;
    end);
end;

procedure TFrmRelCortes.BtnPesqZonaClick(Sender: TObject);
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

procedure TFrmRelCortes.EdtCodProdutoExit(Sender: TObject);
Var JsonArrayRetorno : TJsonArray;
    ObjProdutoCtrl   : TProdutoCtrl;
    vErro, vCodDig   : String;
    vProdutoDigitado : Integer;
begin
  inherited;
  LblProduto.Caption  := '';
  if EdtCodProduto.Text = '' then Exit;
  vProdutoDigitado := tProdutoCtrl.GetCodProdEan(EdtCodProduto.Text);
  if vProdutoDigitado = 0 then Begin
     vCodDig := EdtCodProduto.Text;
     EdtCodProduto.Clear;
     raise Exception.Create('Produto não encontrado! Verifique o Código/Ean('+vCodDig+')');
  End;
  ObjProdutoCtrl := TProdutoCtrl.Create;
  JsonArrayRetorno := ObjProdutoCtrl.FindProduto(vProdutoDigitado.ToString, '', '', 0, 0);
  if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
     EdtCodProduto.Text := '';
     EdtCodProduto.SetFocus;
     JsonArrayRetorno := Nil;
     ObjProdutoCtrl.Free;
     //JsonArrayRetorno.DisposeOf;
     raise Exception.Create('Produto não encontrado!');
  End;
  LblProduto.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  vCodProduto := JsonArrayRetorno.Items[0].GetValue<Integer>('codProduto');
  JsonArrayRetorno := Nil;
  ObjProdutoCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelCortes.EdtInicioChange(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  Limpar;
end;

procedure TFrmRelCortes.EdtInicioEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmRelCortes.EdtInicioExit(Sender: TObject);
begin
  inherited;
  ExitFocus(Sender);
end;

procedure TFrmRelCortes.EdtZonaIdChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtZonaId then
     LblZona.Caption := '';
  EdtInicioChange(EdtInicio);
end;

procedure TFrmRelCortes.EdtZonaIdExit(Sender: TObject);
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
     LblZona.Caption := '';
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

procedure TFrmRelCortes.FormCreate(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LstReport.ColWidths[0]  := 100;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.ColWidths[1]  := 100;
  LstReport.ColWidths[2]  := 450;
  LstReport.ColWidths[3]  := 80;
  LstReport.ColWidths[4]  := 100;
  LstReport.ColWidths[5]  := 100;
  LstReport.ColWidths[6]  := 80;
  LstReport.ColWidths[7]  := 80;
  LstReport.ColWidths[8]  := 95;
  LstReport.ColWidths[9]  := 90;
  LstReport.ColWidths[10]  := 80;
  LstReport.ColWidths[11]  := 80;
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[1, 0] := taRightJustify;
  LstReport.Alignments[3, 0] := taRightJustify;
  LstReport.Alignments[4, 0] := taRightJustify;
  LstReport.Alignments[5, 0] := taRightJustify;
  LstReport.Alignments[6, 0] := taRightJustify;
  LstReport.Alignments[7, 0] := taRightJustify;
  LstReport.Alignments[8, 0] := taRightJustify;
  LstReport.Alignments[9, 0] := taRightJustify;
  LstReport.Alignments[10, 0] := taCenter;
  LstReport.Alignments[11, 0] := taCenter;
  ChkCubagem.Enabled   := True;
  ChkCheckOut.Enabled  := True;
  ChkSintetico.Enabled := True;
end;

procedure TFrmRelCortes.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmRelCortes := Nil;
end;

procedure TFrmRelCortes.Limpar;
begin
  BtnExportarStand.Grayed := True;
  BtnImprimirStand.Grayed := True;
  FdMemPesqGeral.Close;
  LstReport.RowCount      := 1;
  FdMemPesqGeral.Filter   := '';
  FdmemPesqGeral.Filtered := False;
  LblTotCubagem.Caption   := '0';
  LblTotCheckout.Caption  := '0';
  LblTotCancelado.Caption := '0';
  LblTotal.Caption        := '0';
end;

procedure TFrmRelCortes.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  LstReport.Row := aRow;
  if (aRow = 0) and (aCol <= 7) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
  End
end;

procedure TFrmRelCortes.MontaListaCorte;
Var xCorte, xItens, xDemanda, xPerda : Integer;
    vCubagem, vCheckout, vCancelado : Integer;
begin
//  LblRegistro.Caption := FormatFloat('#0', pJsonArray.Count);
  xCorte := 1;
  vCubagem   := 0;
  vCheckout  := 0;
  vCancelado := 0;
  FdMemPesqGeral.Filter := '';
  FdMemPesqGeral.Filtered := False;
  LstReport.unHideColumn(5);
  LstReport.unHideColumn(6);
  if (ChkCubagem.Checked) and (Not ChkCheckOut.Checked) then Begin
     FdMemPesqGeral.Filter := 'Cubagem > 0';
     FdMemPesqGeral.Filtered := True;
     LstReport.HideColumn(6);
  End
  Else if (Not ChkCubagem.Checked) and (ChkCheckOut.Checked) then Begin
     FdMemPesqGeral.Filter := 'Checkout > 0';
     FdMemPesqGeral.Filtered := True;
     LstReport.HideColumn(5);
  End;
  LstReport.RowCount := FdMempesqGeral.RecordCount+1;
  If LstReport.RowCount > 1 Then LstReport.FixedRows := 1;
  xCorte := 1;
  While Not FdMemPesqGeral.Eof do Begin
    if ChkSintetico.Checked then
       LstReport.Cells[0, xCorte] := '   -   '
    else LstReport.Cells[0, xCorte] := FdMemPesqGeral.FieldByName('pedidoid').AsString;
    LstReport.Cells[ 1, xCorte] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[ 2, xCorte] := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[ 3, xCorte] := FdMemPesqGeral.FieldByName('Demanda').AsString;
    LstReport.Cells[ 4, xCorte] := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    LstReport.Cells[ 5, xCorte] := FdMemPesqGeral.FieldByName('Cubagem').AsString;
    LstReport.Cells[ 6, xCorte] := FdMemPesqGeral.FieldByName('CheckOut').AsString;
    LstReport.Cells[ 7, xCorte] := FdMemPesqGeral.FieldByName('Cancelado').AsString;
    LstReport.Cells[ 8, xCorte] := FdMemPesqGeral.FieldByName('QtdSuprida').AsString;
    LstReport.Cells[ 9, xCorte] := FdMemPesqGeral.FieldByName('Estoque').AsString;
    if FdMemPesqGeral.FieldByName('Vencido').AsInteger>0 then
       LstReport.AddDataImage(10, xCorte, 1, TCellHAlign.haCenter, TCellVAlign.vaTop)
    Else
       LstReport.AddDataImage(10, xCorte, 0, TCellHAlign.haCenter, TCellVAlign.vaTop);
    LstReport.AddDataImage(11, xCorte, 5, TCellHAlign.haCenter, TCellVAlign.vaTop);

    //LstReport.Cells[10, xCorte] := FdMemPesqGeral.FieldByName('Vencido').AsString;
    //LstReport.Cells[11, xCorte] := '1';
    if Chkcubagem.Checked then
       vCubagem  := vCubagem  + FdMemPesqGeral.FieldByName('Cubagem').AsInteger;
    if Chkcheckout.checked then
       vCheckOut := vCheckOut + FdMemPesqGeral.FieldByName('CheckOut').AsInteger;
    vCancelado := vCancelado + FdMemPesqGeral.FieldByName('Cancelado').AsInteger;
    LstReport.Alignments[0, xCorte] := taRightJustify;
    LstReport.FontStyles[0, xCorte] := [FsBold];
    LstReport.Alignments[1, xCorte] := taRightJustify;
    LstReport.Alignments[3, xCorte] := taRightJustify;
    LstReport.Alignments[4, xCorte] := taRightJustify;
    LstReport.Alignments[5, xCorte] := taRightJustify;
    LstReport.Alignments[6, xCorte] := taRightJustify;
    LstReport.Alignments[7, xCorte] := taRightJustify;
    LstReport.Alignments[8, xCorte] := taRightJustify;
    LstReport.Alignments[9, xCorte] := taRightJustify;
    LstReport.Alignments[10, xCorte] := taCenter;
    LstReport.Alignments[11, xCorte] := taCenter;
    Inc(xCorte);
    FdMemPesqGeral.Next;
  End;
  LblTotCubagem.Caption   := vCubagem.ToString;
  LblTotCheckOut.Caption  := vCheckOut.toString;
  LblTotCancelado.Caption := vCancelado.toString;
  LblTotal.Caption        := (vCubagem+vCheckOut+vCancelado).ToString;
//  LblItens.Caption     := FormatFloat('#0', xItens);
//  LblDemanda.Caption   := FormatFloat('#0', xDemanda);
//  LblPerda.Caption     := FormatFloat('#0', xPerda);
//  LblPercPerda.Caption := FormatFloat(',0.00',(xPerda / xDemanda * 100))+'%'
end;

end.
