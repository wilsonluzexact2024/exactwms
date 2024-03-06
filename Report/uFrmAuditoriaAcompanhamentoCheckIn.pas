unit uFrmAuditoriaAcompanhamentoCheckIn;

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
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls, DataSet.Serialize,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, EntradaCtrl,System.JSON, REST.Json, Rest.Types;

type
  TFrmAuditoriaAcompanhamentoCheckIn = class(TFrmReportBase)
    GroupBox5: TGroupBox;
    EdtPedidoId: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    EdtRegistroERP: TLabeledEdit;
    GroupBox8: TGroupBox;
    Label13: TLabel;
    Label14: TLabel;
    EdtDataInicial: TJvDateEdit;
    EdtDataFinal: TJvDateEdit;
    GroupBox1: TGroupBox;
    EdtCodPessoaERP: TLabeledEdit;
    BtnPesqPessoa: TBitBtn;
    LblFornecedor: TLabel;
    procedure EdtPedidoIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqPessoaClick(Sender: TObject);
    procedure EdtCodPessoaERPExit(Sender: TObject);
  private
    { Private declarations }
    Procedure MontaListaCheckIn;
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmAuditoriaAcompanhamentoCheckIn: TFrmAuditoriaAcompanhamentoCheckIn;

implementation

{$R *.dfm}

Uses uFuncoes, PessoaCtrl, Views.Pequisa.Pessoas;

procedure TFrmAuditoriaAcompanhamentoCheckIn.BtnPesqPessoaClick(Sender: TObject);
begin
  inherited;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtCodPessoaERP.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtCodPessoaERPExit(EdtCodPessoaERP);
    End;
  finally
    FrmPesquisaPessoas.Free;
  end;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.EdtCodPessoaERPExit(
  Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if TEdit(Sender).Text = '' then Exit;
  if (StrToIntDef(TEdit(Sender).Text, 0) <= 0) then Begin
     ShowErro( '😢Fornecedor('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(TEdit(Sender).text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
   ShowErro( '😢Fornecedor('+TEdit(Sender).Text+') não encontrado!' );
     TEdit(Sender).Clear;
     TEdit(Sender).SetFocus;
  end
  Else Begin
     LblFornecedor.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('fantasia')
  End;
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.EdtPedidoIdChange(Sender: TObject);
begin
  inherited;
  Limpar;
  if Sender = EdtCodPessoaERP then
     LblFornecedor.Caption := ''
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmAuditoriaAcompanhamentoCheckIn := Nil;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0] :=  90;
  LstReport.ColWidths[1] := 380;
  LstReport.ColWidths[2] := 100;
  LstReport.ColWidths[3] := 120;
  LstReport.ColWidths[4] := 100;
  LstReport.ColWidths[5] := 100;
  LstReport.ColWidths[6] := 100; //Dt.Processo
  LstReport.ColWidths[7] := 120;
  LstReport.ColWidths[8] := 120;
  LstReport.Alignments[0, 0] := taRightJustify;
  LstReport.FontStyles[0, 0] := [FsBold];
  LstReport.Alignments[2, 0] := taRightJustify;
  LstReport.Alignments[3, 0] := taRightJustify;
  LstReport.Alignments[4, 0] := taRightJustify;
  LstReport.Alignments[5, 0] := taRightJustify;
  LstReport.Alignments[6, 0] := taRightJustify;
  LstReport.Alignments[7, 0] := taRightJustify;
  LstReport.Alignments[8, 0] := taRightJustify;
  LstReport.FontSizes[0, 0] := 12;
  LstReport.FontSizes[1, 0] := 12;
  LstReport.FontSizes[2, 0] := 12;
  LstReport.FontSizes[3, 0] := 12;
  LstReport.FontSizes[4, 0] := 12;
  LstReport.FontSizes[5, 0] := 12;
  LstReport.FontSizes[6, 0] := 12;
  LstReport.FontSizes[7, 0] := 12;
  LstReport.FontSizes[8, 0] := 12;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.Imprimir;
begin
  inherited;

end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.LstReportClickCell(Sender: TObject;
  ARow, ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
     Exit;
  End
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.MontaListaCheckIn;
Var xRecno : Integer;
begin
  FdMemPesqGeral.First;
  xRecno := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xRecno] := FdMemPesqGeral.FieldByName('CodPessoaERP').AsString;
    LstReport.Cells[1, xRecno] := FdMemPesqGeral.FieldByName('Fantasia').AsString;
    LstReport.Cells[2, xRecno] := FdMemPesqGeral.FieldByName('TotalPedido').AsString;
    LstReport.Cells[3, xRecno] := FdMemPesqGeral.FieldByName('PedidoConferido').AsString;
    LstReport.Cells[4, xRecno] := FdMemPesqGeral.FieldByName('TItens').AsString;
    LstReport.Cells[5, xRecno] := FdMemPesqGeral.FieldByName('TItensConferido').AsString;
    LstReport.Cells[6, xRecno] := FdMemPesqGeral.FieldByName('UnidQtdXML').AsString;
    LstReport.Cells[7, xRecno] := FdMemPesqGeral.FieldByName('UnidTotalCheckIn').AsString;
    LstReport.Cells[8, xRecno] := FormatFloat('0.00', FdMemPesqGeral.FieldByName('UnidTotalCheckIn').AsInteger / FdMemPesqGeral.FieldByName('UnidQtdXML').AsInteger * 100);
    LstReport.Alignments[0, xRecno] := taRightJustify;
    LstReport.FontStyles[0, xRecno] := [FsBold];
    LstReport.Alignments[2, xRecno] := taRightJustify;
    LstReport.Alignments[3, xRecno] := taRightJustify;
    LstReport.Alignments[4, xRecno] := taRightJustify;
    LstReport.Alignments[5, xRecno] := taRightJustify;
    LstReport.Alignments[6, xRecno] := taRightJustify;
    LstReport.Alignments[7, xRecno] := taRightJustify;
    LstReport.Alignments[8, xRecno] := taRightJustify;
    LstReport.FontSizes[0, xRecno] := 12;
    LstReport.FontSizes[1, xRecno] := 12;
    LstReport.FontSizes[2, xRecno] := 12;
    LstReport.FontSizes[3, xRecno] := 12;
    LstReport.FontSizes[4, xRecno] := 12;
    LstReport.FontSizes[5, xRecno] := 12;
    LstReport.FontSizes[6, xRecno] := 12;
    LstReport.FontSizes[7, xRecno] := 12;
    LstReport.FontSizes[8, xRecno] := 12;
    LstReport.FontStyles[1, xRecno] := [FsBold];
    LstReport.FontStyles[2, xRecno] := [FsBold];
    LstReport.FontStyles[3, xRecno] := [FsBold];
    LstReport.FontStyles[4, xRecno] := [FsBold];
    LstReport.FontStyles[5, xRecno] := [FsBold];
    LstReport.FontStyles[6, xRecno] := [FsBold];
    LstReport.FontStyles[7, xRecno] := [FsBold];
    LstReport.FontStyles[8, xRecno] := [FsBold];
    FdMemPesqGeral.Next;
    Inc(xRecno);
  End;
end;

procedure TFrmAuditoriaAcompanhamentoCheckIn.PesquisarDados;
Var ObjEntradaCtrl   : TEntradaCtrl;
    JsonArrayRetorno : TJsonArray;
    pDataInicial     : TDateTime;
    pDataFinal       : TDateTime;
    vErro : String;
begin
  inherited;
  if (StrToIntDef(EdtPedidoId.Text, 0)=0) and (StrToIntDef(EdtCodPessoaERP.Text, 0)=0) and
     (EdtDataInicial.Text='  /  /    ') and (EdtDataFinal.Text='  /  /    ') Then Begin
     ShowErro('Informe os parâmetro para pesquisa.');
     EdtPedidoId.SetFocus;
     Exit;
  End;
  if EdtDataInicial.Text <>'  /  /    ' then
     pDataInicial := StrToDate(EdtDataInicial.Text)
  Else
     pDataInicial := 0;
  if EdtDataFinal.Text <>'  /  /    ' then
     pDataFinal := StrToDate(EdtDataFinal.Text)
  Else
     pDataFinal := 0;
  ObjEntradaCtrl   := TEntradaCtrl.Create;
  JsonArrayRetorno := ObjEntradaCtrl.GetAcompanhamentoCheckIn(StrToIntDef(EdtPedidoId.Text, 0),
                                                              StrToIntDef(EdtCodPessoaERP.Text, 0),
                                                              pDataInicial, pDataFinal);
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     JsonArrayRetorno := Nil;
     ObjEntradaCtrl.Free;
     Exit;
  End;
  LstCadastro.RowCount := JsonArrayRetorno.Count+1;
  FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
  MontaListaCheckIn;
  JsonArrayRetorno := Nil;
  ObjEntradaCtrl.Free;
end;

end.
