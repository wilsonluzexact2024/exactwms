unit uFrmFREnderecamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil, Generics.Collections,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  frxExportXLS, frxClass, frxExportPDF, frxExportMail, frxExportImage,
  frxExportHTML, frxDBSet, frxExportBaseDialog, frxExportCSV, System.ImageList,
  Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, AdvLookupBar, DataSet.Serialize,
  AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Buttons, Vcl.Mask,
  JvExMask, JvToolEdit, JvSpin, dxSkinsCore, dxSkinsDefaultPainters, Vcl.DBGrids,
  Vcl.ComCtrls, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmFREnderecamentos = class(TFrmReportBase)
    Label2: TLabel;
    CbEstrutura: TComboBox;
    Label3: TLabel;
    EdtZona: TJvComboEdit;
    BtnPesqZona: TBitBtn;
    LblZona: TLabel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    EdtEnderecoIni: TJvComboEdit;
    BtnSearchLocalIni: TBitBtn;
    EdtEnderecoFin: TJvComboEdit;
    BtnSearchLocalFin: TBitBtn;
    FdMemPesqGeralEnderecoId: TIntegerField;
    FdMemPesqGeralEstruturaID: TIntegerField;
    FdMemPesqGeralEstrutura: TStringField;
    FdMemPesqGeralRuaId: TIntegerField;
    FdMemPesqGeralRua: TStringField;
    FdMemPesqGeralLado: TStringField;
    FdMemPesqGeralOrdem: TIntegerField;
    FdMemPesqGeralPickingFixo: TIntegerField;
    FdMemPesqGeralZonaId: TIntegerField;
    FdMemPesqGeralZona: TStringField;
    FdMemPesqGeralEndereco: TStringField;
    FdMemPesqGeralDesenhoArmazemId: TIntegerField;
    FdMemPesqGeralStatus: TIntegerField;
    FdMemPesqGeralMascara: TStringField;
    GbOcupacaoEndereco: TGroupBox;
    RbTodos: TRadioButton;
    RbLivres: TRadioButton;
    RbOcupados: TRadioButton;
    FdMemPesqGeralCodProduto: TIntegerField;
    FdMemPesqGeralProduto: TStringField;
    GbStatus: TGroupBox;
    RbStatusTodos: TRadioButton;
    RbStatusAtivo: TRadioButton;
    RbStatusInativo: TRadioButton;
    FdMemPesqGeralQtde: TIntegerField;
    FdMemPesqGeralQtdePulmao: TIntegerField;
    FDMemReUsoPicking: TFDMemTable;
    FDMemReUsoPickingEnderecoId: TIntegerField;
    FDMemReUsoPickingEndereco: TStringField;
    FDMemReUsoPickingCodProduto: TIntegerField;
    FDMemReUsoPickingProduto: TStringField;
    FDMemReUsoPickingMascara: TStringField;
    FDMemReUsoPickingZona: TStringField;
    FDMemReUsoPickingStatus: TIntegerField;
    FDMemReUsoPickingSaldo: TIntegerField;
    TabReUsoPicking: TcxTabSheet;
    Label4: TLabel;
    EdtZonaIdReUso: TJvComboEdit;
    BtnPesqZonaReUso: TBitBtn;
    LblZonaReUso: TLabel;
    Label6: TLabel;
    CbDias: TComboBox;
    LstPickingReuso: TAdvStringGrid;
    LblTotRegPickingReuso: TLabel;
    LblTotPickingReuso: TLabel;
    BtnDesvincularPicking: TPanel;
    ImgDesvincularPicking: TsImage;
    FdMemPesqGeralQtdePicking: TIntegerField;
    FdMemPesqGeralQtdeReserva: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesquisarStandClick(Sender: TObject);
    procedure EdtEnderecoIniChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtZonaChange(Sender: TObject);
    procedure EdtZonaExit(Sender: TObject);
    procedure FdMemPesqGeralStatusGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure FdMemPesqGeralLadoGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure CbEstruturaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnPesqZonaClick(Sender: TObject);
    procedure CbDiasChange(Sender: TObject);
    procedure LstPickingReusoClickCell(Sender: TObject; ARow, ACol: Integer);
    procedure BtnDesvincularPickingClick(Sender: TObject);
  private
    { Private declarations }
    SelEndereco : Boolean;
    Procedure GetEstrutura;
    Procedure PesquisarPickingReuso;
    Procedure CalcularTotalEndereco;
  Protected
    Procedure Limpar; OverRide;
  public
    { Public declarations }
  end;

var
  FrmFREnderecamentos: TFrmFREnderecamentos;

implementation

{$R *.dfm}

uses EnderecamentoZonaClass, EnderecamentoZonaCtrl, EnderecoEstruturaClass, EnderecamentoEstruturaCtrl,
     EnderecoClass, EnderecoCtrl, uFuncoes, TypInfo, uFrmeXactWMS,
     Vcl.DialogMessage, Views.Pequisa.EnderecamentoZonas;

procedure TFrmFREnderecamentos.BtnPesqZonaClick(Sender: TObject);
var LForm: TFrmPesquisaEnderecamentoZonas;
begin
  inherited;
  FrmPesquisaEnderecamentoZonas := TFrmPesquisaEnderecamentoZonas.Create(Application);
  try
    if (FrmPesquisaEnderecamentoZonas.ShowModal = mrOk) then  Begin
       if Sender = BtnPesqzonaReUso then Begin
          EdtZonaIdReUso.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaExit(EdtZonaIdReUso);
       End
       Else Begin
          EdtZona.Text := FrmPesquisaEnderecamentoZonas.Tag.ToString();
          EdtZonaExit(EdtZona);
       End;
    End;
  finally
    FreeAndNil(FrmPesquisaEnderecamentoZonas);
  end;
end;

procedure TFrmFREnderecamentos.BtnDesvincularPickingClick(Sender: TObject);
begin
  inherited;
  if Confirmacao('Reuso de Picking', 'Deseja Desvincular os ('+LblTotPickingReuso.Caption+') produtos?', True) then Begin
     TDialogMessage.ShowWaitMessage('Buscando Informações...',
       procedure
       Var vErro  : String;
           JsonArrayRetorno : TJsonArray;
           ObjEnderecoCtrl   : TEnderecoCtrl;
           JsonArrayEndereco : TJsonArray;
           xEndereco         : Integer;
       begin
         JsonArrayEndereco := TJsonArray.Create;
         for xEndereco := 1 to Pred(LstPickingReuso.RowCount) do Begin
           if LstPickingReuso.Cells[7, xEndereco].toInteger() = 1 then
              JsonArrayEndereco.AddElement(TJsonObject.Create.AddPair('enderecoid', TJsonNumber.Create(LstPickingReuso.Cells[8, xEndereco].toInteger())));
         End;
         if JsonArrayEndereco.Count > 0 then Begin
            ObjEnderecoCtrl := TEnderecoCtrl.Create;
            JsonArrayRetorno := ObjEnderecoCtrl.DesvincularPicking(JsonArrayEndereco);
            If JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then
               ShowErro('Erro: '+vErro)
            Else Begin
               ShowOk(JsonArrayRetorno.Count.ToString+' Picking´s liberado(s) para reuso.');
               Limpar;
               EdtZonaIdReUso.SetFocus;
            End;
            JsonArrayRetorno := Nil;
            ObjEnderecoCtrl.Free;
         End;
         JsonArrayEndereco.Free;
         BtnDesvincularPicking.Visible := False;
       End);
  End;
end;

procedure TFrmFREnderecamentos.BtnPesquisarStandClick(Sender: TObject);
Var ArrayJsonEndereco : TJsonArray;
    ObjEnderecoCtrl   : TEnderecoCtrl;
    vOcupacao, vErro  : String;
    xRetorno, vStatus : Integer;
    vEstruturaId      : Integer;
begin
  if PgcBase.ActivePage = TabReUsoPicking then
     PesquisarPickingReuso
  Else begin
     inherited;
     if (EdtEnderecoIni.Text='') and (EdtEnderecoFin.Text='') and (CbEstrutura.Text='') and (EdtZona.Text='') then Begin
        ShowErro('🙋🏼‍♀ Informe o Tipo e/ou Faixa de Endereço para pesquisar.');
        EdtEnderecoIni.SetFocus;
        exit;
     End;
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     vStatus := 99;  //Qualquer Número diferente de 0(Inativo) e 1(Ativo)
     if RbStatusAtivo.Checked then vStatus := 1
     else if RbStatusInativo.Checked then vStatus := 0;
     if CbEstrutura.ItemIndex <= 0 then
        vEstruturaId := 0
     Else vEstruturaId := CbEstrutura.ItemIndex;
     if CbEstrutura.ItemIndex = 2 then
        LstReport.UnHideColumn(12)
     Else LstReport.HideColumn(12);
     if CbEstrutura.Itemindex = 2 then Begin
        if RbTodos.Checked then
           vOcupacao := 'T'
        Else if RbLivres.Checked then
           vOcupacao := 'L'
        Else if RbOcupados.Checked then
           vOcupacao := 'O';
        End
     Else vOcupacao := 'T';
       //Tela Aguarde...
     TDialogMessage.ShowWaitMessage('Buscando Informações...',
       procedure
       Var xRetorno : Integer;
           vErro : String;
       begin
         ArrayJsonEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, vEstruturaId, StrToIntDef(EdtZona.Text, 0), 0, EdtEnderecoIni.Text, EdtEnderecoFin.Text, vOcupacao, vStatus, 0);
         if ArrayJsonEndereco.Items[0].TryGetValue<string>('Erro', vErro) then Begin
            ShowErro('Não foram encontrado(s) dados para o relatório');
            //ObjEnderecoCtrl.Free;
         End
         Else Begin
            LstReport.RowCount := ArrayJsonEndereco.Count+1;
            LstReport.FixedRows := 1;
            LblTotRegistro.Caption := ArrayJsonEndereco.Count.ToString();
            For xRetorno := 1 to LstReport.RowCount - 1 do Begin
              LstReport.AddDataImage(5, xRetorno, 0, haCenter,vaTop);
              LstReport.AddDataImage(7, xRetorno, 0, haCenter,vaTop);
            End;
            If FdMemPesqGeral.Active then
               FdmemPesqGeral.EmptyDataSet;
            FdMemPesqGeral.Close;
            FdMemPesqGeral.Open;
            ImprimirExportar(True);
            for XRetorno := 0 to Pred(ArrayJsonEndereco.Count) do Begin
              LstReport.Cells[0, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('enderecoid').ToString;
              LstReport.Cells[1, xRetorno+1] :=  EnderecoMask(ArrayJsonEndereco.Items[xRetorno].GetValue<String>('descricao'), ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
              LstReport.Cells[2, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
              LstReport.Cells[3, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
              if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'U' then
                 LstReport.Cells[4, xRetorno+1] := 'Único'
              Else if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'I' then
                 LstReport.Cells[4, xRetorno+1] := 'Impar'
              Else if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado') = 'P' then
                 LstReport.Cells[4, xRetorno+1] := 'Par'
              Else LstReport.Cells[4, xRetorno+1] := '---';
              LstReport.Cells[5, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('pickingfixo');
              LstReport.Cells[6, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
              LstReport.Cells[7, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<String>('status');
              if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto') <> 0then begin
                 LstReport.Cells[8, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('codproduto');
                 LstReport.Cells[9, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
              end
              Else Begin
                 LstReport.Cells[8, xRetorno+1] := '';
                 LstReport.Cells[9, xRetorno+1] := '';
              End;
              if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde') <> 0 then
                 LstReport.Cells[10, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde').ToString()
              Else LstReport.Cells[10, xRetorno+1] := '';
              if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva') <> 0 then
                 LstReport.Cells[11, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva').ToString()
              Else LstReport.Cells[11, xRetorno+1] := '0';
              if ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao') <> 0 then
                 LstReport.Cells[12, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao').ToString()
              Else LstReport.Cells[12, xRetorno+1] := '';
              LstReport.Cells[13, xRetorno+1] :=  ArrayJsonEndereco.Items[xRetorno].GetValue<String>('Ocupacao')+'%';
              LstReport.Alignments[0,  xRetorno+1] := taRightJustify;
              LstReport.FontStyles[0,  xRetorno+1] := [FsBold];
              LstReport.FontStyles[1,  xRetorno+1] := [FsBold];
              LstReport.Alignments[1,  xRetorno+1] := taCenter;
              LstReport.Alignments[5,  xRetorno+1] := taCenter;
              LstReport.Alignments[7,  xRetorno+1] := taCenter;
              LstReport.Alignments[8,  xRetorno+1] := taRightJustify;
              LstReport.Alignments[10, xRetorno+1] := taRightJustify;
              LstReport.Alignments[11, xRetorno+1] := taRightJustify;
              LstReport.Alignments[12, xRetorno+1] := taRightJustify;
              LstReport.Alignments[13, xRetorno+1] := taRightJustify;
              With FdMemPesqGeral do begin
                Append;
                FieldByName('EnderecoId').AsInteger  := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('enderecoid');
                FieldByName('EstruturaID').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<integer>('estruturaid');
                FieldByName('Estrutura').AsString    := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('descricao');
                FieldByName('RuaId').AsInteger       := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ruaid');
                FieldByName('Rua').AsString          := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('descricao');
                FieldByName('Lado').AsString         := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<String>('lado');
                FieldByName('Ordem').AsInteger       := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecorua').GetValue<Integer>('ordem');
                FieldByName('PickingFixo').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<integer>('pickingfixo');
                FieldByName('ZonaID').AsInteger      := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('zonaid');
                FieldByName('Zona').AsString         := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecamentozona').GetValue<String>('descricao');
                FieldByName('Endereco').AsString     := EnderecoMask(ArrayJsonEndereco.Items[xRetorno].GetValue<String>('descricao'), ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara'), True);
                FieldByName('DesenhoArmazemID').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('desenhoarmazem').GetValue<integer>('Id');
                FieldByName('Status').AsInteger      := ArrayJsonEndereco.Items[xRetorno].GetValue<Integer>('status');
                FieldByName('Mascara').AsString      := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('enderecoestrutura').GetValue<String>('mascara');
                FieldByName('CodProduto').AsInteger  := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('codproduto');
                FieldByName('Produto').AsString      := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<String>('descricao');
                FieldByName('Qtde').AsInteger        := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtde');
                FieldByName('QtdePulmao').AsInteger  := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepulmao');
                FieldByName('QtdePicking').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdepicking');
                FieldByName('QtdeReserva').AsInteger := ArrayJsonEndereco.Items[xRetorno].GetValue<TJsonObject>('produto').GetValue<Integer>('qtdereserva');
                Post;
              End;
            End;
         End
       end);
     ArrayJsonEndereco := Nil;
     ObjEnderecoCtrl.Free;
  end;
end;

procedure TFrmFREnderecamentos.CbEstruturaClick(Sender: TObject);
begin
  inherited;
  GbOcupacaoEndereco.Visible := CbEstrutura.ItemIndex = 2;
  if CbEstrutura.ItemIndex <> 2 then
     LstReport.HideColumn(12)
  Else Begin
     LstReport.UnHideColumn(12);
     LstReport.RowCount :=  1;
//     LstReport.ColCount := 12;
     LstReport.Resize;
  End;
  Limpar;
end;

procedure TFrmFREnderecamentos.CalcularTotalEndereco;
Var xEndereco, xTotalEndereco : Integer;
begin
  xTotalEndereco := 0;
  for xEndereco := 1 to Pred(LstPickingReUso.RowCount) do Begin
    if LstPickingReUso.Cells[7, xEndereco].ToInteger = 1 then
       Inc(xTotalEndereco);
  End;
  LblTotPickingReuso.Caption    := xTotalEndereco.ToString;
  BtnDesvincularPicking.Visible := xTotalEndereco > 0;
end;

procedure TFrmFREnderecamentos.CbDiasChange(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmFREnderecamentos.EdtEnderecoIniChange(Sender: TObject);
begin
  inherited;
  Limpar;
  if CbEstrutura.ItemIndex <> 2 then
     LstReport.HideColumn(12)
  Else LstReport.HideColumn(12);
end;

procedure TFrmFREnderecamentos.EdtZonaChange(Sender: TObject);
begin
  inherited;
  if PgcBase.ActivePage = TabReUsoPicking then
     LblZonaReUso.Caption := ''
  Else
     LblZona.Caption := '';
  Limpar;
end;

procedure TFrmFREnderecamentos.EdtZonaExit(Sender: TObject);
Var ObjEnderecoZonaCtrl : TEnderecamentoZonaCtrl;
    ReturnLstZona       : TObjectList<TEnderecamentoZona>;
    xRetorno       : Integer;
    vErro          : String;
begin
  inherited;
  if PgcBase.ActivePage = TabReUsoPicking then Begin
     if EdtZOnaIdReUso.Text = '' then Exit;     
     LblZonaReUso.Caption := ''
  End
  Else Begin
     if EdtZona.Text = '' then Exit;
     
     LblZona.Caption  := '';
  End;
  ObjEnderecoZonaCtrl := TEnderecamentoZonaCtrl.Create;
  If PgcBase.ActivePage = TabReUsoPicking then
     ReturnLstZona       := ObjEnderecoZonaCtrl.GetEnderecamentoZona(StrtoIntDef(EdtZonaIdReUso.Text, 0), '', 0)
  Else
     ReturnLstZona       := ObjEnderecoZonaCtrl.GetEnderecamentoZona(StrtoIntDef(EdtZona.Text, 0), '', 0);
  if ReturnLstZona.Count <= 0 then Begin
     if PgcBase.ActivePage = TabReUsoPicking then Begin
        EdtZonaIdReUso.Clear;
        ShowErro('Zona('+EdtZonaIdReUso.Text+') não encontrada!');
     End
     Else Begin
        EdtZona.Clear;
        ShowErro('Zona('+EdtZona.Text+') não encontrada!');
     End
  End
  else Begin
     if PgcBase.ActivePage = TabReUsoPicking then
        LblZonaReUso.Caption   := ReturnLstZona.Items[0].Descricao
     Else
        LblZona.Caption   := ReturnLstZona.Items[0].Descricao;
  End;
  ReturnLstZona := Nil;
  ObjEnderecoZonaCtrl.Free;
end;

procedure TFrmFREnderecamentos.FdMemPesqGeralLadoGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := '---';
  if (Sender.AsString = 'U') then
     Text := 'Único'
  Else if (Sender.AsString = 'I') then
     Text := 'Impar'
  Else if (Sender.AsString = 'P') then
     Text := 'Par';
end;

procedure TFrmFREnderecamentos.FdMemPesqGeralStatusGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  inherited;
  Text := 'Ativo';
  if (Sender.AsInteger = 0) then
     Text := 'Inativo';
end;

procedure TFrmFREnderecamentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmFREnderecamentos := Nil;
end;

procedure TFrmFREnderecamentos.FormCreate(Sender: TObject);
begin
  inherited;
  SelEndereco := True;
  SetReadOnly;
  LstReport.RowCount   := 1;
  With LstReport do Begin
    ColWidths[0]  :=  70;
    ColWidths[1]  := 100;
    ColWidths[2]  :=  100;
    ColWidths[3]  :=  70;
    ColWidths[4]  :=  80;
    ColWidths[5]  :=  60;
    ColWidths[6]  :=  120;
    ColWidths[7]  :=  60;
    ColWidths[8]  :=  80;
    ColWidths[9]  :=  300;
    ColWidths[10] :=  70;
    ColWidths[11] :=  70;
    ColWidths[12] :=  80;
    ColWidths[13] :=  100;
    Alignments[0, 0]  := taRightJustify;
    FontStyles[0, 0]  := [FsBold];
    FontStyles[1, 0]  := [FsBold];
    Alignments[1, 0]  := taCenter;
    Alignments[5, 0]  := taCenter;
    Alignments[7, 0]  := taCenter;
    Alignments[8, 0]  := taRightJustify;
    Alignments[10, 0] := taRightJustify;
    Alignments[11, 0] := taRightJustify;
    Alignments[12, 0] := taRightJustify;
    Alignments[13, 0] := taRightJustify;
  End;
  With LstPickingReuso do Begin
    ColWidths[0] :=  70;
    ColWidths[1] := 120;
    ColWidths[2] := 100;
    ColWidths[3] := 400;
    ColWidths[4] := 180;
    ColWidths[5] :=  70;
    ColWidths[6] :=  50;
    ColWidths[7] :=  50;
    Alignments[0, 0] := taRightJustify;
    FontStyles[1, 0] := [FsBold];
    Alignments[1, 0] := taCenter;
    Alignments[2, 0] := taRightJustify;
    Alignments[5, 0] := taRightJustify;
    Alignments[6, 0] := taCenter;
    Alignments[7, 0] := taCenter;
  End;
  LstPickingReuso.HideColumn(8);
  GetEstrutura;
  RbStatusTodos.Checked := True;
  rbTodos.Checked       := True;
end;

procedure TFrmFREnderecamentos.FormShow(Sender: TObject);
begin
  inherited;
  RbTodos.Checked := True;
end;

procedure TFrmFREnderecamentos.GetEstrutura;
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
  ReturnLstEstrutura       := Nil;
  ObjEnderecoEstruturaCtrl.Free;
  CbEstrutura.ItemIndex    := 0;
end;

procedure TFrmFREnderecamentos.Limpar;
begin
  if PgcBase.ActivePage = TabReUsoPicking then Begin
     LstPickingReuso.RowCount      := 1;
     BtnDesvincularPicking.Visible := False;
     LbltotPickingReuso.Caption    := '';
     End
  Else
     inherited;
end;

procedure TFrmFREnderecamentos.LstPickingReusoClickCell(Sender: TObject; ARow, ACol: Integer);
Var xEndereco : Integer;
begin
  inherited;
  if LstPickingReuso.RowCount <= 1 then Exit;
  if (Arow=0) and (acol < 7) then Begin
     LstPickingReuso.SortSettings.Column := aCol;
     LstPickingReuso.QSort;
  End;
  If (aCol = 7) then Begin
     if (aRow = 0) and (LstPickingReuso.RowCount>1) then Begin
        For xEndereco := 1 to Pred(LstPickingReuso.RowCount) do Begin
          if LstPickingReuso.Cells[5, xEndereco].ToInteger = 0 then Begin
             if SelEndereco then Begin
                if LstPickingReuso.Cells[7, xEndereco] = '1' then
                   LstPickingReuso.Cells[7, xEndereco] := '0';
             End
             Else Begin
                if LstPickingReuso.Cells[7, xEndereco] = '0' then
                   LstPickingReuso.Cells[7, xEndereco] := '1';
             End;
          End;
        End;
        SelEndereco := Not SelEndereco;
     End
     Else Begin
       if LstPickingReuso.Cells[5, aRow].ToInteger = 0 then Begin
          if (StrToIntDef(LstPickingReuso.Cells[7, aRow], 0) = 0) then
             LstPickingReuso.Cells[7, aRow] := '1'
          Else
             LstPickingReuso.Cells[7, aRow] := '0';
       End;
     End;
     CalcularTotalEndereco;
  End;
end;

procedure TFrmFREnderecamentos.PesquisarPickingReuso;
begin
//  inherited;
  LstPickingReUso.RowCount := 1;
  If FdMemReUsoPicking.Active then
     FdMemReUsoPicking.EmptyDataSet;
  FdMemReUsoPicking.Close;
  if (EdtZonaIdReUso.Text='') or (StrToIntDef(EdtZonaIdReUso.Text, 0) = 0) then Begin
     ShowErro('🙋🏼‍♀ Informe a Zona/Setor para pesquisar Picking disponível para Reuso.');
     EdtZonaIdReUso.SetFocus;
     exit;
  End;
  if CbDias.ItemIndex < 0 then Begin
     ShowErro('🙋🏼‍♀ Informe a quantidade de dias para Análise de disponibilidade.');
     EdtZonaIdReUso.SetFocus;
     exit;
  End;
  TDialogMessage.ShowWaitMessage('Buscando Informações...',
    procedure
    Var xRecno : Integer;
        vErro  : String;
        vDias  : Integer;
        ArrayJsonEndereco : TJsonArray;
        ObjEnderecoCtrl   : TEnderecoCtrl;
        vProduto : String;
    begin
      if CbDias.ItemIndex = 0 then
         vDias := 0
      Else if CbDias.ItemIndex = 1 then
         vDias := 20
      Else if CbDias.ItemIndex = 2 then
         vDias := 30
      Else if CbDias.ItemIndex = 3 then
         vDias := 60
      Else if CbDias.ItemIndex = 4 then
         vDias := 120
      Else if CbDias.ItemIndex = 5 then
         vDias := 180
      Else if CbDias.ItemIndex = 6 then
         vDias := 240
      Else if CbDias.ItemIndex = 7 then
         vDias := 360
      Else if CbDias.ItemIndex = 8 then
         vDias := 361;
      ObjEnderecoCtrl   := TEnderecoCtrl.Create;
      ArrayJsonEndereco := ObjEnderecoCtrl.GetReUsoPicking(StrToIntDef(EdtZonaIdReUso.Text, 0), vDias);
      if ArrayJsonEndereco.Items[0].TryGetValue<string>('Erro', vErro) then Begin
         ShowErro('Não foram encontrado(s) dados para o relatório');
         //ObjEnderecoCtrl.Free;
      End
      Else Begin
         FdMemReUsoPicking.LoadFromJSON(ArrayJsonEndereco, False);
         LstPickingReUso.RowCount   := FdMemReUsoPicking.RecordCount+1;
         LstPickingReUso.FixedRows  := 1;
         xRecno := 1;
         For xRecno := 1 to FdMemReUsoPicking.RecordCount do Begin
           LstPickingReUso.AddDataImage(6, xRecno, 0, haCenter,vaTop);
           LstPickingReUso.AddDataImage(7, xRecno, 0, haCenter,vaTop);
         End;
         FdMemPesqGeral.Open;
         ImprimirExportar(True);
         FdMemReUsoPicking.First;
         xRecno := 1;
         While Not FdMemReUsoPicking.Eof do Begin
           LstPickingReUso.Cells[0, xRecno] := FdMemReUsoPicking.FieldByName('EnderecoId').AsString;
           LstPickingReUso.Cells[1, xRecno] := EnderecoMask(FdMemReUsoPicking.FieldByName('Endereco').AsString,
                                               FdMemReUsoPicking.FieldByName('Mascara').AsString, True);
           LstPickingReUso.Cells[2, xRecno] := FdMemReUsoPicking.FieldByName('CodProduto').AsString;
           LstPickingReUso.Cells[3, xRecno] := FdMemReUsoPicking.FieldByName('Produto').AsString;
           LstPickingReUso.Cells[4, xRecno] := FdMemReUsoPicking.FieldByName('Zona').AsString;
           LstPickingReUso.Cells[5, xRecno] := FdMemReUsoPicking.FieldByName('Saldo').AsString;
           LstPickingReUso.Cells[6, xRecno] := FdMemReUsoPicking.FieldByName('Status').AsString;
           if FdMemReUsoPicking.FieldByName('Saldo').AsInteger > 0 then
              LstPickingReUso.Cells[7, xRecno] := '0'
           Else
              LstPickingReUso.Cells[7, xRecno] := '1';
           LstPickingReUso.Cells[8, xRecno] := FdMemReUsoPicking.FieldByName('EnderecoId').AsString;
           LstPickingReUso.Alignments[0, xRecno] := taRightJustify;
           LstPickingReUso.FontStyles[0, xRecno] := [FsBold];
           LstPickingReUso.Alignments[1, xRecno] := taCenter;
           LstPickingReUso.FontStyles[1, xRecno] := [FsBold];
           LstPickingReUso.Alignments[2, xRecno] := taRightJustify;
           LstPickingReUso.Alignments[5, xRecno] := taRightJustify;
           LstPickingReUso.Alignments[6, xRecno] := taCenter;
           LstPickingReUso.Alignments[7, xRecno] := taCenter;
           FdMemReUsoPicking.Next;
           Inc(xRecno);
         End;
         CalcularTotalEndereco;
      End;
      ArrayJsonEndereco := Nil;
      ObjEnderecoCtrl.Free;
    end);
end;

end.
