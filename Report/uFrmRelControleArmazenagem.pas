unit uFrmRelControleArmazenagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, Generics.Collections,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  System.JSON, REST.Json, Rest.Types, DataSet.Serialize,
  JvExMask, JvSpin, JvToolEdit;

type
  TFrmRelControleArmazenagem = class(TFrmReportBase)
    GroupBox6: TGroupBox;
    LblProduto: TLabel;
    BtnSearchProdMovInterna: TBitBtn;
    EdtCodProduto: TEdit;
    GroupBox7: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    EdtDataInicial: TJvDateEdit;
    EdtDataFinal: TJvDateEdit;
    GroupBox11: TGroupBox;
    LblEndereco: TLabel;
    EdtEndereco: TEdit;
    BtnPesqEndereco: TBitBtn;
    GroupBox8: TGroupBox;
    Lblusuario: TLabel;
    EdtUsuarioId: TEdit;
    BitBtn2: TBitBtn;
    GroupBox9: TGroupBox;
    ChkArmazenamento: TCheckBox;
    ChkMovInterna: TCheckBox;
    GroupBox10: TGroupBox;
    EdtDocumentoNr: TEdit;
    procedure BtnSearchProdMovInternaClick(Sender: TObject);
    procedure EdtCodProdutoChange(Sender: TObject);
    procedure EdtEnderecoChange(Sender: TObject);
    procedure EdtUsuarioIdChange(Sender: TObject);
    procedure EdtDocumentoNrChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure BtnPesqEnderecoClick(Sender: TObject);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstReportClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure EdtUsuarioIdExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
    vCodProduto, vEnderecoId : Integer;
    Procedure MontaListaCA;
  Protected
    Procedure Imprimir; OverRide;
    Procedure PesquisarDados; OverRide;
  public
    { Public declarations }
  end;

var
  FrmRelControleArmazenagem: TFrmRelControleArmazenagem;

implementation

{$R *.dfm}

uses uFuncoes, Views.Pequisa.Produtos, Views.Pequisa.Endereco, EnderecoCtrl, ProdutoCtrl,
     EstoqueCtrl, UsuarioCtrl, uFrmeXactWMS, Vcl.DialogMessage, Views.Pequisa.Usuarios;

procedure TFrmRelControleArmazenagem.BitBtn2Click(Sender: TObject);
begin
  inherited;
  if EdtUsuarioId.ReadOnly then Exit;
  inherited;
  FrmPesquisaUsuario := TFrmPesquisaUsuario.Create(Application);
  try
    if (FrmPesquisaUsuario.ShowModal = mrOk) then Begin
       EdtUsuarioId.Text := FrmPesquisaUsuario.Tag.ToString;
       EdtUsuarioIdExit(EdtUsuarioId);
    End;
  finally
    FreeAndNil(FrmPesquisaUsuario);
  end;
end;

procedure TFrmRelControleArmazenagem.BtnPesqEnderecoClick(Sender: TObject);
Var vEnderecoId : Integer;
    ObjEnderecoCtrl : TEnderecoCtrl;
begin
  FrmPesquisaEndereco := TFrmPesquisaEndereco.Create(Application);
  try
    if (FrmPesquisaEndereco.ShowModal = mrOk) then  Begin
       vEnderecoId := FrmPesquisaEndereco.Tag;
       ObjEnderecoCtrl := TEnderecoCtrl.Create();
       EdtEndereco.Text := ObjEnderecoCtrl.GetEndereco(vEnderecoId, 0, 0, 0, '', '', 'T', 2, 1)[0].Descricao;
       EdtEnderecoExit(EdtEndereco);
       ObjEnderecoCtrl := Nil;
    End;
  finally
    FreeAndNil(FrmPesquisaEndereco);
  end;
end;

procedure TFrmRelControleArmazenagem.BtnSearchProdMovInternaClick(
  Sender: TObject);
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

procedure TFrmRelControleArmazenagem.EdtCodProdutoChange(Sender: TObject);
begin
  inherited;
  vCodProduto := 0;
  LblProduto.Caption := '...';
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtCodProdutoExit(Sender: TObject);
Var ObjProdutoCtrl : TProdutoCtrl;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '...';
     Exit;
  End;
  if StrToInt64Def(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  if JsonProduto.GetValue<Integer>('codproduto') <= 0 then Begin
     ShowErro('Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     vCodProduto := 0;
     EdtCodProduto.Clear;
     EdtCodProduto.SetFocus;
     JsonProduto := Nil;
     Exit;
  End;
  vCodProduto := JsonProduto.GetValue<Integer>('codproduto');
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
  JsonProduto := Nil;
end;

procedure TFrmRelControleArmazenagem.EdtEnderecoChange(Sender: TObject);
begin
  inherited;
  vEnderecoId := 0;
  LblProduto.Caption := '...';
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtEnderecoExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    JsonArrayRetorno : TJsonArray;
begin
  inherited;
   LblEndereco.Caption := '';
   vEnderecoId := 0;
   if EdtEndereco.Text  = '' then Exit;
   ObjEnderecoCtrl := TEnderecoCtrl.Create();
   JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EdtEndereco.Text, EdtEndereco.Text, 'T', 2, 1);
   if JsonArrayRetorno.Count < 1 Then Begin //Items[0].TryGetValue<String>('Erro', vErro) then Begin
      EdtEndereco.SetFocus;
      ShowErro('Endereço não encontrado!');
   End
   Else Begin
      vEnderecoId := JsonArrayRetorno.Items[0].GetValue<Integer>('enderecoid');
      LblEndereco.Caption := (JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecoestrutura')).GetValue<String>('descricao')+' - '+
                             (JsonArrayRetorno.Items[0].GetValue<TJsonObject>('enderecamentozona')).GetValue<String>('descricao');
   End;
   JsonArrayRetorno := Nil;
   ObjEnderecoCtrl.Free;
end;

procedure TFrmRelControleArmazenagem.EdtDocumentoNrChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtUsuarioIdChange(Sender: TObject);
begin
  inherited;
  LblUsuario.Caption := '...';
  Limpar;
end;

procedure TFrmRelControleArmazenagem.EdtUsuarioIdExit(Sender: TObject);
Var ObjUsuarioCtrl   : TUsuarioCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  LblUsuario.Caption := '';
  if (Not EdtUsuarioId.ReadOnly) and (EdtUsuarioId.Text <> '') then Begin
     ObjUsuarioCtrl   := TUsuarioCtrl.Create();
     JsonArrayRetorno := ObjUsuarioCtrl.FindUsuario(EdtUsuarioId.Text, 0);
     if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) Then begin
        ShowErro(vErro);
        EdtUsuarioId.Clear;
        EdtUsuarioId.SetFocus;
     End
     Else
        LblUsuario.Caption := JsonArrayRetorno.Items[0].GetValue<String>('nome');
     JsonArrayRetorno := Nil;
     ObjUsuarioCtrl.Free;
  End;
end;

procedure TFrmRelControleArmazenagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmRelControleArmazenagem := Nil;
end;

procedure TFrmRelControleArmazenagem.FormCreate(Sender: TObject);
begin
  inherited;
  LstReport.ColWidths[ 0] :=  90;
  LstReport.ColWidths[ 1] :=  75;
  LstReport.ColWidths[ 2] :=  80;
  LstReport.ColWidths[ 3] := 300;
  LstReport.ColWidths[ 4] := 100;
  LstReport.ColWidths[ 5] :=  65;
  LstReport.ColWidths[ 6] :=  65; //Dt.Processo
  LstReport.ColWidths[ 7] :=  65;
  LstReport.ColWidths[ 8] :=  80;
  LstReport.ColWidths[ 9] :=  65;
  LstReport.ColWidths[10] :=  65;
  LstReport.ColWidths[11] := 180;
  LstReport.ColWidths[12] := 120;
  LstReport.Alignments[ 0, 0] := taCenter;
  LstReport.Alignments[ 1, 0] := taCenter;
  LstReport.Alignments[ 2, 0] := taRightJustify;
  LstReport.Alignments[ 5, 0] := taRightJustify;
  LstReport.Alignments[ 6, 0] := taRightJustify;
  LstReport.Alignments[ 7, 0] := taRightJustify;
  LstReport.Alignments[ 8, 0] := taRightJustify;
  LstReport.Alignments[ 9, 0] := taRightJustify;
  LstReport.Alignments[10, 0] := taRightJustify;
end;

procedure TFrmRelControleArmazenagem.Imprimir;
begin
  inherited;

end;

procedure TFrmRelControleArmazenagem.LstReportClickCell(Sender: TObject; ARow,
  ACol: Integer);
begin
  inherited;
  if (aRow = 0) then Begin
     LstReport.SortSettings.Column := aCol;
     LstReport.QSort;
  End
end;

procedure TFrmRelControleArmazenagem.MontaListaCA;
Var xRecno : Integer;
begin
  FdMemPesqGeral.First;
  xRecno := 1;
  While Not FdMemPesqGeral.Eof do Begin
    LstReport.Cells[ 0, xRecno] := FdMemPesqGeral.FieldByName('Data').AsString;
    LstReport.Cells[ 1, xRecno] := FdMemPesqGeral.FieldByName('Hora').AsString;
    LstReport.Cells[ 2, xRecno] := FdMemPesqGeral.FieldByName('CodProduto').AsString;
    LstReport.Cells[ 3, xRecno] := FdMemPesqGeral.FieldByName('Produto').AsString;
    LstReport.Cells[ 4, xRecno] := FdMemPesqGeral.FieldByName('Lote').AsString;
    LstReport.Cells[ 5, xRecno] := FdMemPesqGeral.FieldByName('SaldoInicialOrigem').AsString;
    LstReport.Cells[ 6, xRecno] := FdMemPesqGeral.FieldByName('Qtde').AsString;
    LstReport.Cells[ 7, xRecno] := FdMemPesqGeral.FieldByName('SaldoFinalOrigem').AsString;
    LstReport.Cells[ 8, xRecno] := FdMemPesqGeral.FieldByName('EnderecoDestino').AsString;
    LstReport.Cells[ 9, xRecno] := FdMemPesqGeral.FieldByName('SaldoInicialDestino').AsString;
    LstReport.Cells[10, xRecno] := FdMemPesqGeral.FieldByName('SaldoFinalDestino').AsString;
    LstReport.Cells[11, xRecno] := FdMemPesqGeral.FieldByName('UsuarioId').AsString+' '+FdMemPesqGeral.FieldByName('Nome').AsString;
    LstReport.Cells[12, xRecno] := FdMemPesqGeral.FieldByName('Terminal').AsString;
    LstReport.Alignments[0, xRecno] := taCenter;
    LstReport.Alignments[1, xRecno] := taCenter;
    LstReport.Alignments[2, xRecno] := taRightJustify;
    LstReport.Alignments[5, xRecno] := taRightJustify;
    LstReport.Alignments[6, xRecno] := taRightJustify;
    LstReport.Alignments[7, xRecno] := taRightJustify;
    LstReport.Alignments[8, xRecno] := taRightJustify;
    LstReport.Alignments[9, xRecno] := taRightJustify;
    LstReport.Alignments[10, xRecno] := taRightJustify;
    FdMemPesqGeral.Next;
    Inc(xRecno);
  End;
end;

procedure TFrmRelControleArmazenagem.PesquisarDados;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    pDataInicial     : TDateTime;
    pDataFinal       : TDateTime;
    vErro : String;
begin
  inherited;
  if (StrToIntDef(EdtCodProduto.Text, 0)=0) and (EdtDocumentoNr.Text='') and
     (EdtDataInicial.Text='  /  /    ') and (EdtDataFinal.Text='  /  /    ') and
     (EdtEndereco.Text='') and (StrToIntDef(EdtUsuarioId.Text, 0) = 0) then Begin
     ShowErro('Informe os parâmetro para pesquisa.');
     EdtCodProduto.SetFocus;
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
  TDialogMessage.ShowWaitMessage('Buscando Dados dos Volumes...',
  procedure
  Begin
    ObjEstoqueCtrl   := TEstoqueCtrl.Create;
    JsonArrayRetorno := ObjEstoqueCtrl.GetControleArmazenagem(pDataInicial, pDataFinal,
                        vCodProduto, EdtDocumentoNr.Text, vEnderecoId, StrToIntDef(EdtUsuarioId.text, 0));
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro(vErro);
       EdtCodProduto.SetFocus;
    End
    Else Begin
       LstCadastro.RowCount := JsonArrayRetorno.Count+1;
       FdMemPesqGeral.LoadFromJSON(JsonArrayRetorno, False);
       MontaListaCA;
    End;
    JsonArrayRetorno := Nil;
    ObjEstoqueCtrl.Free;
  End);
end;

End.
