unit uFrmRelColetaPulmao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, DataSet.Serialize,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar, Generics.Collections,
  System.Json, Rest.Types, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask, JvExMask,
  JvSpin, dxSkinsCore, dxSkinsDefaultPainters, JvToolEdit, ACBrBase, ACBrETQ,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxCameraControl;

type
  TFrmRelColetaPulmao = class(TFrmReportBase)
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralDescricao: TStringField;
    FdMemPesqGeralFatorConversao: TIntegerField;
    FdMemPesqGeralEnderecoid: TIntegerField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralDemanda: TIntegerField;
    FdMemPesqGeralMascara: TStringField;
    FdMemPesqGeralEnderecoFormatado: TStringField;
    FdMemPesqGeralProdutoId: TIntegerField;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    LblDestinatario: TLabel;
    EdtDestinatario: TEdit;
    BtnPesqCliente: TBitBtn;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    LblRota: TLabel;
    EdtRotaId: TEdit;
    BtnPesqRota: TBitBtn;
    FdMemPesqGeralEmbalagem: TStringField;
    procedure BtnImprimirStandClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FdMemPesqGeralCalcFields(DataSet: TDataSet);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtInicioChange(Sender: TObject);
    procedure BtnPesqRotaClick(Sender: TObject);
    procedure EdtRotaIdExit(Sender: TObject);
    procedure BtnPesqClienteClick(Sender: TObject);
    procedure EdtDestinatarioExit(Sender: TObject);
    procedure EdtDestinatarioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure MontaListaColeta;
    Procedure Limpar;
  public
    { Public declarations }
  end;

var
  FrmRelColetaPulmao: TFrmRelColetaPulmao;

implementation

{$R *.dfm}

uses PedidoSaidaCtrl, uFuncoes, RotaCtrl, PessoaCtrl, Views.Pequisa.Pessoas, Views.Pequisa.Rotas, Views.Pequisa.Processos;

procedure TFrmRelColetaPulmao.BtnImprimirStandClick(Sender: TObject);
Var ObjPedidoCtrl    : TPedidoSaidaCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
    vFiltro          : String;
begin
  vFiltro := 'Perído: ';
  If EdtInicio.Text <> '  /  /    ' then
     vFiltro := vFiltro+EdtInicio.Text
  Else vFiltro := vFiltro+'... a ';
  If EdtTermino.Text <> '  /  /    ' then
     vFiltro := vFiltro+EdtTermino.Text
  Else vFiltro := vFiltro+'...';
  If EdtDestinatario.Text <> '' then
     vFiltro := vFiltro+'  Destinatário: '+EdtDestinatario.Text+' '+LblDestinatario.Caption;
  If EdtRotaId.Text <> '' then
     vFiltro := vFiltro+'  Rota: '+EdtRotaId.Text+' '+LblRota.Caption;
  frxReport1.Variables['vFiltro'] := QuotedStr(vFiltro);
  inherited;
end;

procedure TFrmRelColetaPulmao.BtnPesqClienteClick(Sender: TObject);
begin
  inherited;
  if EdtDestinatario.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 1;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtDestinatario.Text := FrmPesquisaPessoas.Tag.ToString;
       EdtDestinatarioExit(EdtDestinatario);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;
end;

procedure TFrmRelColetaPulmao.BtnPesqRotaClick(Sender: TObject);
begin
  inherited;
  if EdtRotaId.ReadOnly then Exit;
  inherited;
  FrmPesquisaRotas := TFrmPesquisaRotas.Create(Application);
  try
    if (FrmPesquisaRotas.ShowModal = mrOk) then Begin
       EdtRotaId.Text := FrmPesquisaRotas.Tag.ToString();
       EdtRotaIdExit(EdtRotaId);
    End;
  finally
    FreeAndNil(FrmPesquisaRotas);
  end;
end;

procedure TFrmRelColetaPulmao.BtnPesquisarStandClick(Sender: TObject);
Var ObjPedidoCtrl      : TPedidoSaidaCtrl;
    JsonArrayRetorno   : TJsonArray;
    vErro              : String;
    pDataIni, pDataFin : TDateTime;
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
//  if StrToIntDef(EdtPedidoId.Text, 0) < 0 then
//     raise Exception.Create('Id de Pedido inválido!');
//  if StrToIntDef(EdtCodProduto.Text, 0) < 0 then
//     raise Exception.Create('Código do produto inválido!');
  inherited;
  BtnImprimirStand.Grayed := True;
  ObjPedidoCtrl := TPedidoSaidaCtrl.Create();
  jsonArrayRetorno := ObjPedidoCtrl.GetRelColetaPulmao(pDataIni, pDataFin, StrToIntDef(EdtDestinatario.Text, 0), StrToIntDef(EdtRotaId.Text, 0)); //, StrToIntDef(EdtPedidoId.Text, 0), StrToIntDef(EdtCodProduto.Text, 0));
  if JsonArrayRetorno.Items[0].TryGetValue<string>('Erro', vErro) then Begin
     ShowErro(verro);
     JsonArrayRetorno := Nil;
     ObjPedidoCtrl.Free;
     Exit;
  End;
  If FdMemPesqGeral.Active then
     FdmemPesqGeral.EmptyDataSet;
  FdMemPesqGeral.Close;
  FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
  BtnImprimirStand.Grayed := FdMemPesqGeral.IsEmpty;
  BtnExportarStand.Grayed := FdMemPesqGeral.IsEmpty;
  BtnImprimirStand.Enabled := True;
  BtnExportarStand.Enabled := True;
  If Not FdMemPesqGeral.IsEmpty then
     MontaListaColeta
  Else ShowErro('Não foi encontrado dados na consulta.');
  JsonArrayRetorno := Nil;
  ObjPedidoCtrl.Free;
end;

procedure TFrmRelColetaPulmao.EdtDestinatarioChange(Sender: TObject);
begin
  inherited;
  if Sender = EdtDestinatario then LblDestinatario.Caption := ''
  else LblRota.Caption := '';
  Limpar;
end;

procedure TFrmRelColetaPulmao.EdtDestinatarioExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtDestinatario.Text = '' then Begin
     LblDestinatario.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtDestinatario.Text, 0) <= 0 then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtDestinatario.text, 0), '', '', 1, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblDestinatario.Caption := '';
     ShowErro( '😢Destinatário('+EdtDestinatario.Text+') não encontrado!' );
     EdtDestinatario.Clear;
  end
  Else
     LblDestinatario.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnjsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelColetaPulmao.EdtInicioChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelColetaPulmao.EdtRotaIdExit(Sender: TObject);
Var ObjRotaCtrl   : TRotaCtrl;
    ReturnLstRota : TObjectList<TRotaCtrl>;
begin
  inherited;
  if EdtRotaId.Text = '' then Begin
     LblRota.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtRotaId.Text, 0) <= 0 then Begin
     LblRota.Caption := '';
     Player('toast4');
     ShowErro( '😢Rota('+EdtRotaId.Text+') inválida!' );
     EdtRotaId.Clear;
     Exit;
  end;
  ObjRotaCtrl   := TRotaCtrl.Create;
  ReturnLstRota := ObjRotaCtrl.GetRota(StrToIntDef(EdtRotaId.text, 0), '', 0);
  if (ReturnLstRota.Count <= 0) then Begin
     LblRota.Caption := '';
     Player('toast4');
     ShowErro( '😢Rota não('+EdtRotaId.Text+') encontrado!');
     EdtRotaId.Clear;
  end
  Else
     LblRota.Caption := ReturnLstRota.Items[0].ObjRota.Descricao;
  ReturnLstRota := Nil;
  ObjRotaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmRelColetaPulmao.FdMemPesqGeralCalcFields(DataSet: TDataSet);
begin
  inherited;
  FdMemPesqGeral.FieldByName('EnderecoFormatado').asString :=
      EnderecoMask(FdMemPesqGeral.FieldByName('Endereco').asString,
                   FdMemPesqGeral.FieldByName('mascara').asString, True);
end;

procedure TFrmRelColetaPulmao.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[0]  := 100;
  LstReport.ColWidths[1]  := 250;
  LstReport.ColWidths[2]  := 120;
  LstReport.ColWidths[3]  := 70;
  LstReport.ColWidths[4]  := 120;
  LstReport.RowCount      := 1;
  LstReport.Alignments[0, 0]  := taRightJustify;
  LstReport.FontStyles[0, 0]  := [FsBold];
  LstReport.Alignments[2, 0]  := taCenter;
  LstReport.Alignments[3, 0]  := taRightJustify;
end;

procedure TFrmRelColetaPulmao.FormDestroy(Sender: TObject);
begin
  inherited;
  FrmRelColetaPulmao := Nil;
end;

procedure TFrmRelColetaPulmao.Limpar;
begin
  BtnExportarStand.Grayed := True;
  BtnImprimirStand.Grayed := True;
  FdMemPesqGeral.Close;
  LstReport.RowCount      := 1;
  FdMemPesqGeral.Filter   := '';
  FdmemPesqGeral.Filtered := False;
end;

procedure TFrmRelColetaPulmao.MontaListaColeta;
Var xCorte, xItens, xDemanda, xPerda : Integer;
begin
  LstReport.RowCount := FdMempesqGeral.RecordCount+1;
  If LstReport.RowCount > 1 Then LstReport.FixedRows := 1;
//  LblRegistro.Caption := FormatFloat('#0', FdMemPesqGeral.RecordCount);
  xCorte := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[0, xCorte] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[1, xCorte] := FdMemPesqGeral.FieldByName('Descricao').AsString;
    LstReport.Cells[2, xCorte] := FdMemPesqGeral.FieldByName('EnderecoFormatado').AsString;
    LstReport.Cells[3, xCorte] := FdMemPesqGeral.FieldByName('Demanda').AsString;
    LstReport.Cells[4, xCorte] := FdMemPesqGeral.FieldByName('Embalagem').AsString;
    LstReport.Alignments[0, xCorte] := taRightJustify;
    LstReport.FontStyles[0, xCorte] := [FsBold];
    LstReport.Alignments[2, xCorte]  := taCenter;
    LstReport.Alignments[3, xCorte] := taRightJustify;
    Inc(xCorte);
    FdMemPesqGeral.Next;
  End;
end;

end.
