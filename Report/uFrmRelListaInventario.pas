unit uFrmRelListaInventario;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, System.JSON, REST.Json, Rest.Types, DataSet.Serialize,
  JvToolEdit, ProdutoCtrl;

type
  TFrmRelListaInventario = class(TFrmReportBase)
    Label3: TLabel;
    EdtDataCriacao: TJvDateEdit;
    RbInventarioTipo: TRadioGroup;
    ChkSomentePendente: TCheckBox;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    LblProcesso: TLabel;
    EdtProcessoId: TEdit;
    BtnPesqProcesso: TBitBtn;
    Label2: TLabel;
    EdtDataCriacaoFinal: TJvDateEdit;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    procedure BtnPesqProcessoClick(Sender: TObject);
    procedure EdtProcessoIdExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtProcessoIdChange(Sender: TObject);
    procedure RbInventarioTipoClick(Sender: TObject);
    procedure EdtDataCriacaoChange(Sender: TObject);
    procedure ChkSomentePendenteClick(Sender: TObject);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoChange(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtProcessoIdKeyPress(Sender: TObject; var Key: Char);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
  private
    { Private declarations }
    vProdutoId : Integer;
    Procedure MontaListaInventario;
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelListaInventario: TFrmRelListaInventario;

implementation

{$R *.dfm}

{ TFrmRelListaInventario }

Uses uFuncoes, uFrmeXactWMS, InventarioCtrl, Views.Pequisa.Processos, Views.Pequisa.Produtos, ProcessoCtrl;

procedure TFrmRelListaInventario.BtnPesqProcessoClick(Sender: TObject);
begin
  inherited;
  if ((Sender=BtnPesqProcesso) and (EdtProcessoId.ReadOnly)) or
     ((Sender=BtnPesqProcesso) and (EdtProcessoId.ReadOnly)) then Exit;
  inherited;
  FrmPesquisaProcessos := TFrmPesquisaProcessos.Create(Application);
  try
    if (FrmPesquisaProcessos.ShowModal = mrOk) then Begin
       EdtProcessoId.Text := FrmPesquisaProcessos.Tag.ToString;
       EdtProcessoIdExit(EdtProcessoId);
    End;
  finally
    FreeAndNil(FrmPesquisaProcessos);
  end;
end;

procedure TFrmRelListaInventario.BtnPesqProdutoClick(Sender: TObject);
begin
  inherited;
  if TEdit(Sender).ReadOnly then Exit;
  inherited;
  FrmPesquisaProduto := TFrmPesquisaProduto.Create(Application);
  try
    if (FrmPesquisaProduto.ShowModal = mrOk) then Begin
       EdtCodProduto.Text := FrmPesquisaProduto.Tag.ToString();
       EdtCodProdutoExit(EdtCodproduto);
    End;
  finally
    FreeAndNil(FrmPesquisaProduto);
  end;
end;

procedure TFrmRelListaInventario.ChkSomentePendenteClick(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelListaInventario.EdtCodProdutoChange(Sender: TObject);
begin
  inherited;
  Limpar;
  vProdutoId := 0;
  LblProduto.Caption := '...';
end;

procedure TFrmRelListaInventario.EdtCodProdutoExit(Sender: TObject);
Var JsonProduto : TJsonObject;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if StrToInt64Def(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Código do produto('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(TEdit(Sender).Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+TEdit(Sender).Text+') não encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  End
  Else
     LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  JsonProduto := Nil;
  ExitFocus(Sender);
end;

procedure TFrmRelListaInventario.EdtDataCriacaoChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelListaInventario.EdtProcessoIdChange(Sender: TObject);
begin
  inherited;
  Limpar;
  LblProcesso.Caption := '...';
end;

procedure TFrmRelListaInventario.EdtProcessoIdExit(Sender: TObject);
Var ObjProcessoCtrl   : TProcessoCtrl;
    JsonArrayRetorno : TJsonArray;
Begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  LblProcesso.Caption := '';
  if StrToIntDef(TEdit(Sender).Text, 0) <= 0 then Begin
     ShowErro( '😢Processo('+TEdit(Sender).Text+') inválido!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjProcessoCtrl  := TProcessoCtrl.Create;
  JsonArrayRetorno := ObjProcessoCtrl.GetProcesso(TEdit(Sender).text, 0);
  if (JsonArrayRetorno.Count <= 0) then Begin
     LblProcesso.Caption := '';
     ShowErro( '😢Processo não('+TEdit(Sender).Text+') encontrado!');
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else
     LblProcesso.Caption := JsonArrayRetorno.Items[0].GetValue<String>('descricao');
  JsonArrayRetorno := Nil;
  ObjProcessoCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelListaInventario.EdtProcessoIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmRelListaInventario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  vProdutoId := 0;
  FrmRelListaInventario := Nil;
end;

procedure TFrmRelListaInventario.FormCreate(Sender: TObject);
begin
  inherited;
  RbInventarioTipo.ItemIndex := 2;
  LstReport.ColWidths[0] :=  80;
  LstReport.ColWidths[1] := 100;
  LstReport.ColWidths[2] := 200;
  LstReport.ColWidths[3] := 120;
  LstReport.ColWidths[4] := 280; //Criado Por
  LstReport.ColWidths[5] := 100;
  LstReport.ColWidths[6] := 170;
  LstReport.ColWidths[7] := 120; //Dt.Processo
  LstReport.ColWidths[8] := 280; //usuario
  LstReport.ColWidths[9] := 180;
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[3, 0] := taCenter;
  LstReport.Alignments[7, 0] := taCenter;
end;

procedure TFrmRelListaInventario.Imprimir;
begin
  inherited;
  With FrxReport1 do Begin
    Variables['vModulo']  := QuotedStr(pChar(Application.Title));
    Variables['vVersao']  := QuotedStr(Versao);
    Variables['vUsuario'] := QuotedStr(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Nome);
  End;
  frxPDFExport1.ShowDialog := False;
  FrxReport1.PrepareReport();
  FrxReport1.ShowReport;
end;

procedure TFrmRelListaInventario.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
     Exit;
  End
end;

procedure TFrmRelListaInventario.MontaListaInventario;
Var xRecno : Integer;
begin
  FdMemPesqGeral.First;
  xRecno := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRecno] := FdMemPesqGeral.FieldByName('inventarioid').AsString;
    LstReport.Cells[1, xRecno] := FdMemPesqGeral.FieldByName('tipo').AsString;
    LstReport.Cells[2, xRecno] := FdMemPesqGeral.FieldByName('Motivo').AsString;
    LstReport.Cells[3, xRecno] := DateEUAtoBr(FdMemPesqGeral.FieldByName('DataCriacao').AsString)+' '+Copy(FdMemPesqGeral.FieldByName('hora').AsString, 1, 8);
    LstReport.Cells[4, xRecno] := FdMemPesqGeral.FieldByName('usuariocreate').AsString;
    LstReport.Cells[5, xRecno] := FdMemPesqGeral.FieldByName('Ajuste').AsString;
    LstReport.Cells[6, xRecno] := FdMemPesqGeral.FieldByName('Processo').AsString;
    LstReport.Cells[7, xRecno] := DateEUAtoBr(FdMemPesqGeral.FieldByName('DataFechamento').AsString)+' '+Copy(FdMemPesqGeral.FieldByName('horafechamento').AsString, 1, 8);
    LstReport.Cells[8, xRecno] := FdMemPesqGeral.FieldByName('usuariofechamento').AsString;
    LstReport.Cells[9, xRecno] := FdMemPesqGeral.FieldByName('Terminal').AsString;
    LstReport.Alignments[0, xRecno] := taRightJustify;
    LstReport.FontStyles[0, xRecno] := [FsBold];
    LstReport.Alignments[3, xRecno] := taCenter;
    LstReport.Alignments[7, xRecno] := taCenter;
    FdMemPesqGeral.Next;
    Inc(xRecno);
  End;
end;

procedure TFrmRelListaInventario.PesquisarDados;
Var JsonArrayInventario : tJsonArray;
    xInventario         : Integer;
    vErro               : String;
    ObjInventarioCtrl   : TInventarioCtrl;
    pDataCriacao        : TDateTime;
    pDataCriacaoFinal   : TDateTime;
    pTipoInventario     : Integer;
    pPendente           : Integer;
begin
  inherited;
  Limpar;
  If FdMemPesqGeral.Active then
     FdMemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  if EdtDataCriacao.Text <>'  /  /    ' then
     pDataCriacao := StrToDate(EdtDataCriacao.Text)
  Else
     pDataCriacao := 0;
  if EdtDataCriacaoFinal.Text <>'  /  /    ' then
     pDataCriacaoFinal := StrToDate(EdtDataCriacaoFinal.Text)
  Else
     pDataCriacaoFinal := 0;
  case RbInventarioTipo.ItemIndex of
    0: pTipoInventario := 1;
    1: pTipoInventario := 2;
    2: pTipoInventario := 0;
  end;
  if ChkSomentePendente.Checked then
     pPendente := 1
  Else
     pPendente := 0;
  ObjInventarioCtrl   := TInventarioCtrl.Create;
  JsonArrayInventario := ObjInventarioCtrl.getInventario(0, pDataCriacao, 0, 0, StrToIntDef(EdtProcessoId.Text, 0),
                         pTipoInventario, pPendente, vProdutoId, 0, pDataCriacaoFinal);
  if JsonArrayInventario.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     JsonArrayInventario := Nil;
     ObjInventarioCtrl.Free;
     Exit;
  End;
  LstCadastro.RowCount := JsonArrayInventario.Count+1;
  FdMemPesqGeral.LoadFromJSON(JsonArrayInventario, False);
  MontaListaInventario;
  JsonArrayInventario := Nil;
  ObjInventarioCtrl.Free;
end;

procedure TFrmRelListaInventario.RbInventarioTipoClick(Sender: TObject);
begin
  inherited;
  Limpar;
end;

end.
