unit uFrmVolumeEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, acPNG, acImage, Math,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Generics.Collections,
  Vcl.Buttons, Vcl.Mask, JvExMask, JvToolEdit, JvBaseEdits
  , VolumeEmbalagemCtrl, JvSpin, dxSkinsCore, dxSkinsDefaultPainters,
  Vcl.ComCtrls, Vcl.DBGrids, ACBrBase, ACBrETQ, dxCameraControl;

type
  TFrmVolumeEmbalagem = class(TFrmBase)
    EdtEmbalagemId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    Label2: TLabel;
    CbTipo: TComboBox;
    edtDescricao: TLabeledEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    EdtPeso: TJvCalcEdit;
    EdtAltura: TJvCalcEdit;
    EdtLargura: TJvCalcEdit;
    EdtComprimento: TJvCalcEdit;
    EdtVolume: TJvCalcEdit;
    EdtCapacidade: TJvCalcEdit;
    Label3: TLabel;
    EdtQtdLacres: TJvCalcEdit;
    Label5: TLabel;
    ChkCodigoBarras: TCheckBox;
    ChkDisponivel: TCheckBox;
    EdtPrecoCusto: TJvCalcEdit;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    EdtAproveitamento: TJvCalcEdit;
    EdtIdentificacao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtEmbalagemIdExit(Sender: TObject);
    procedure EdtEmbalagemIdKeyPress(Sender: TObject; var Key: Char);
    procedure EdtAlturaChange(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure EdtEmbalagemIdChange(Sender: TObject);
  private
    { Private declarations }
    ObjVolumeEmbalagemCtrl : TVolumeEmbalagemCtrl;
    function GetListaVolumeEmbalagem(pVolumeEmbalagemId: Integer = 0;
      pDescricao: String = ''): Boolean;
    function IfThen(AValue: Boolean; const ATrue, AFalse: String): String;
  Protected
    Procedure ShowDados; override;  public
    Procedure PesquisarClickInLstCadastro(aCol, aRow : Integer); OverRide;
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Function DeleteReg : Boolean;  OverRide;
    Function SalvarReg : Boolean;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmVolumeEmbalagem: TFrmVolumeEmbalagem;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrmVolumeEmbalagem.BtnEditarClick(Sender: TObject);
begin
  inherited;
  CbTipo.SetFocus;
end;

procedure TFrmVolumeEmbalagem.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  CbTipo.SetFocus;
end;

function TFrmVolumeEmbalagem.DeleteReg: Boolean;
begin
   Result := ObjVolumeEmbalagemCtrl.DelVolumeEmbalagem;
end;

procedure TFrmVolumeEmbalagem.EdtAlturaChange(Sender: TObject);
begin
  inherited;
  if (Not TJvCalcEdit(Sender).ReadOnly) then
     EdtVolume.Value := EdtAltura.Value * EdtLargura.Value * EdtComprimento.Value;
end;

procedure TFrmVolumeEmbalagem.EdtEmbalagemIdChange(Sender: TObject);
begin
  inherited;
  if (Not EdtEmbalagemId.ReadOnly) and (StrToIntDef(EdtEmbalagemId.Text, 0)<>ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId) then
     Limpar;
end;

procedure TFrmVolumeEmbalagem.EdtEmbalagemIdExit(Sender: TObject);
begin
  inherited;
  if (Not EdtEmbalagemId.ReadOnly) and (EdtEmbalagemId.Text<>'') and (StrToIntDef(EdtEmbalagemId.Text,0)<>ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId) then Begin
     Limpar;
     if StrToIntDef(EdtEmbalagemId.Text, 0) <= 0 then
        raise Exception.Create('Id('+EdtEmbalagemId.Text+') inválido!');
     ObjVolumeEmbalagemCtrl := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagem(StrToIntDef(EdtEmbalagemId.Text, 0), '', 1)[0];
     if ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId > 0 then
        ShowDados;
  End;
  ExitFocus(Sender)
end;

procedure TFrmVolumeEmbalagem.EdtEmbalagemIdKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmVolumeEmbalagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmVolumeEmbalagem := Nil;
end;

procedure TFrmVolumeEmbalagem.FormCreate(Sender: TObject);
begin
  inherited;
  ObjVolumeEmbalagemCtrl := TVolumeEmbalagemCtrl.Create;
  With LstCadastro do Begin
    ColWidths[0] := 40;
    ColWidths[1] := 250;
    ColWidths[2] := 100;
    ColWidths[3] := 100;
    ColWidths[4] := 80;
    ColWidths[5] := 80;
    ColWidths[6] := 80;
    ColWidths[7] := 60;
    Alignments[0 ,0] := taRightJustify;
    LstCadastro.FontStyles[0, 0] := [FsBold];
    Alignments[4 ,0] := taRightJustify;
    Alignments[5 ,0] := taRightJustify;
    Alignments[6 ,0] := taRightJustify;
  End;
  GetListaVolumeEmbalagem;
end;

procedure TFrmVolumeEmbalagem.GetListaLstCadastro;
begin
  inherited;
  GetListaVolumeEmbalagem(0, '');
end;

function TFrmVolumeEmbalagem.GetListaVolumeEmbalagem(pVolumeEmbalagemId: Integer; pDescricao: String): Boolean;
Var xLista, xImg       : Integer;
    LstVolumeEmbalagem : TObjectList<TVolumeEmbalagemCtrl>;
begin
//  LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
  if pDescricao = '' then
     LstVolumeEmbalagem   := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagem(pVolumeEmbalagemId, '')
  Else LstVolumeEmbalagem := ObjVolumeEmbalagemCtrl.GetVolumeEmbalagem(0, pDescricao);
  LstCadastro.RowCount  := 1;
  Result := LstVolumeEmbalagem.Count >= 1;
  If LstVolumeEmbalagem.Count >= 1 then Begin
     LstCadastro.RowCount  := LstVolumeEmbalagem.Count+1;
     LstCadastro.FixedRows := 1;
     for xImg := 1 to LstCadastro.RowCount do
       LstCadastro.AddDataImage(7, xImg, 0, haCenter, vaTop);
     For xLista := 0 To LstVolumeEmbalagem.Count-1 do begin
       With LstVolumeEmbalagem[xLista].ObjVolumeEmbalagem do Begin
         LstCadastro.Cells[0, xLista+1] := EmbalagemId.ToString();
         LstCadastro.Cells[1, xLista+1] := Descricao;
         LstCadastro.Cells[2, xLista+1] := IfThen(Tipo = 'R', 'Retornável',
         IfThen(Tipo = 'P', 'Própria',
         IfThen(Tipo = 'C','Pacote',
         'Reutilizável')));
         LstCadastro.Cells[3, xLista+1] := Identificacao;
         LstCadastro.Cells[4, xLista+1] := FormatFloat('0.00', Volume);
         LstCadastro.Cells[5, xLista+1] := FormatFloat('0.000', Tara);
         LstCadastro.Cells[6, xLista+1] := FormatFloat('0.00', Capacidade);
         LstCadastro.Cells[7, xLista+1] := Status.ToString;
       End;
       LstCadastro.Alignments[0, xLista+1] := taRightJustify;
       LstCadastro.FontStyles[0, xLista+1] := [FsBold];
       LstCadastro.Alignments[4, xLista+1] := taRightJustify;
       LstCadastro.Alignments[5, xLista+1] := taRightJustify;
       LstCadastro.Alignments[6, xLista+1] := taRightJustify;
     end;
     LstVolumeEmbalagem := Nil;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
end;

function TFrmVolumeEmbalagem.IfThen(AValue: Boolean; const ATrue,
  AFalse: String): String;
begin
 if AValue then
    Result := ATrue
 else
    Result := AFalse;
end;

procedure TFrmVolumeEmbalagem.Limpar;
begin
  EnabledButtons := False;
  If Assigned(ObjVolumeEmbalagemCtrl) Then ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.Limpar;
  if Not EdtEmbalagemId.Enabled then
     EdtEmbalagemId.Clear;
  edtDescricao.Clear;
  CbTipo.ItemIndex := -1;
  EdtIdentificacao.Clear;
  EdtPeso.Value           := 0;
  EdtAltura.Value         := 0;
  EdtLargura.Value        := 0;
  EdtComprimento.Value    := 0;
  EdtVolume.Value         := 0;
  EdtCapacidade.Value     := 0;
  EdtAproveitamento.value := 0;
  EdtQtdLacres.Value      := 0;
  EdtPrecoCusto.Value     := 0;
  ChkCodigoBarras.Checked := False;
  ChkDisponivel.Checked   := False;
  ChkCadastro.Checked     := False;
end;

procedure TFrmVolumeEmbalagem.PesquisarClickInLstCadastro(aCol, aRow: Integer);
begin
  inherited;
  EdtEmbalagemId.Text := LstCadastro.Cells[0, aRow];
  EdtEmbalagemIdExit(EdtEmbalagemId);
end;

function TFrmVolumeEmbalagem.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaVolumeEmbalagem(StrToIntDef(EdtConteudoPesq.Text, 0), '')
     Else if CbCampoPesq.ItemIndex = 1 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaVolumeEmbalagem(-1, EdtConteudoPesq.Text);
     EdtConteudoPesq.Clear;
  End;
end;

function TFrmVolumeEmbalagem.SalvarReg: Boolean;
begin
  With ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem do begin
    EmbalagemId    := StrToIntDef(EdtEmbalagemId.Text, 0);
    Descricao      := EdtDescricao.Text;
    case CbTipo.ItemIndex of
      0: Tipo := 'R';
      1: Tipo := 'P';
      2: Tipo := 'C';
      3: Tipo := 'U';
      Else Tipo := '';
    end;
    Identificacao := EdtIdentificacao.Text;
    Tara        := EdtPeso.Value;
    Altura      := EdtAltura.Value;
    Largura     := EdtLargura.Value;
    Comprimento := EdtComprimento.value;
    Aproveitamento := Round(EdtAproveitamento.Value);
    Capacidade  := EdtCapacidade.Value;
    QtdLacres   := Round(EdtQtdLacres.Value);
    PrecoCusto  := EdtPrecoCusto.Value;
    CodBarras   := Ord(ChkCodigoBarras.Checked);
    Disponivel := Ord(ChkDisponivel.Checked);
    Status := Ord(ChkCadastro.Checked);
  end;
  Result := ObjVolumeEmbalagemCtrl.Salvar;
  if Result then ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem.EmbalagemId := 0;
end;

procedure TFrmVolumeEmbalagem.ShowDados;
begin
  inherited;
  With ObjVolumeEmbalagemCtrl.ObjVolumeEmbalagem do Begin
    If EmbalagemId <> 0 Then Begin
       PgcBase.ActivePage     := TabPrincipal;
       EnabledButtons         := True;
    End;
    EdtEmbalagemId.Text := EmbalagemId.ToString();
    edtDescricao.Text   := Descricao;
    if Tipo = 'R' then CbTipo.ItemIndex := 0
    Else if Tipo = 'P' then CbTipo.ItemIndex := 1
    Else if Tipo = 'C' then CbTipo.ItemIndex := 2
    Else CbTipo.ItemIndex := 3;
    EdtIdentificacao.Text := Identificacao;
    EdtPeso.Value         := Tara;
    EdtAltura.Value       := Altura;
    EdtLargura.Value      := Largura;
    EdtComprimento.Value  := Comprimento;
    EdtVolume.Value       := Volume;
    EdtCapacidade.Value   := Capacidade;
    EdtAproveitamento.value := Aproveitamento;
    EdtQtdLacres.Value    := QtdLacres;
    EdtPrecoCusto.Value   := PrecoCusto;
    ChkCodigoBarras.Checked := CodBarras = 1;
    ChkDisponivel.Checked   := Disponivel = 1;
    ChkCadastro.Checked     := Status = 1;
  End;
end;

end.
