unit uFrmSegregadoBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, dxSkinsCore,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, ACBrBase, ACBrETQ, Vcl.ExtDlgs,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  dxCameraControl, acPNG, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids,
  dxGDIPlusClasses, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj,
  BaseGrid, cxPC, Vcl.Mask, JvExMask, JvSpin, uFuncoes, Generics.Collections,
  System.Json, Rest.Types, JvToolEdit, EnderecoCtrl, JvBaseEdits;

type
  TFrmSegregadoBaixa = class(TFrmBase)
    EdtBaixaId: TLabeledEdit;
    btnPesquisar: TBitBtn;
    Label3: TLabel;
    EdtDocumentoData: TJvDateEdit;
    EdtCodPessoa: TLabeledEdit;
    BtnPesqPessoa: TBitBtn;
    LblPessoa: TLabel;
    GroupBox7: TGroupBox;
    Label12: TLabel;
    LblProduto: TLabel;
    EdtCodProduto: TEdit;
    BtnPesqProduto: TBitBtn;
    Endereço: TLabel;
    EdtEndereco: TEdit;
    BtnPesqEndereco: TBitBtn;
    Label2: TLabel;
    EdtLote: TEdit;
    BtnPesqLote: TBitBtn;
    Label4: TLabel;
    JvCalcEdit1: TJvCalcEdit;
    Label5: TLabel;
    BtnSalvarBaixa: TPanel;
    ShpBtnSalvarBaixa: TShape;
    SpbBtnSalvarBaixa: TSpeedButton;
    PnlBtnSalvarBaixa: TPanel;
    ImgBtnSalvarBaixa: TImage;
    EdtNotaFiscal: TLabeledEdit;
    Label6: TLabel;
    CbDescarte: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnPesqProdutoClick(Sender: TObject);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtCodProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure BtnPesqPessoaClick(Sender: TObject);
    procedure EdtCodPessoaExit(Sender: TObject);
    procedure EdtEnderecoExit(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSegregadoBaixa: TFrmSegregadoBaixa;

implementation

{$R *.dfm}

Uses Views.Pequisa.Pessoas, Views.Pequisa.Produtos, PessoaCtrl, ProdutoCtrl;

procedure TFrmSegregadoBaixa.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtDocumentoData.Text := DateToStr(Now());
  EdtCodPessoa.SetFocus;
  CbDescarte.ItemIndex := -1;
end;

procedure TFrmSegregadoBaixa.BtnPesqPessoaClick(Sender: TObject);
begin
  inherited;
  if EdtCodPessoa.ReadOnly then Exit;
  FrmPesquisaPessoas := TFrmPesquisaPessoas.Create(Application);
  try
    FrmPesquisaPessoas.PessoaTipoId := 2;
    if (FrmPesquisaPessoas.ShowModal = mrOk) then Begin
       EdtCodPessoa.Text := FrmPesquisaPessoas.Tag.ToString();
       EdtCodPessoaExit(EdtCodPessoa);
    End;
  finally
    FreeAndNil(FrmPesquisaPessoas);
  end;

end;

procedure TFrmSegregadoBaixa.BtnPesqProdutoClick(Sender: TObject);
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

procedure TFrmSegregadoBaixa.EdtCodProdutoExit(Sender: TObject);
Var vProdutoId  : Integer;
    JsonProduto : TJsonObject;
begin
  inherited;
  if EdtCodProduto.Text = '' then Begin
     LblProduto.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtCodProduto.Text, 0) <= 0 then Begin
     LblProduto.Caption := '';
     ShowErro( '😢Código do produto('+EdtCodProduto.Text+') inválido!' );
     EdtCodProduto.Clear;
     Exit;
  end;
  JsonProduto := TProdutoCtrl.GetEan(EdtCodProduto.Text);
  vProdutoId  := JsonProduto.GetValue<Integer>('produtoid');
  if vProdutoId <= 0 then Begin
     ShowErro('😢Código do Produto('+EdtCodProduto.Text+') não encontrado!');
     EdtCodProduto.Clear;
     Exit;
  End;
  LblProduto.Caption := JsonProduto.GetValue<String>('descricao');
  ExitFocus(Sender);
end;

procedure TFrmSegregadoBaixa.EdtCodProdutoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  SoNumeros(Key);
end;

procedure TFrmSegregadoBaixa.EdtEnderecoExit(Sender: TObject);
Var ObjEnderecoCtrl  : TEnderecoCtrl;
    RetornoJsonArray : TJsonArray;
    vErro : String;
begin
  inherited;
  if (Not EdtEndereco.ReadOnly) then Begin
     ObjEnderecoCtrl := TEnderecoCtrl.Create;
     RetornoJsonArray := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 3, 0, EdtEndereco.Text, EdtEndereco.Text, 'T', 3);
     if (RetornoJsonArray.Items[0].TryGetValue('Erro', vErro)) or (RetornoJsonArray.Count < 1) then Begin
        EdtEndereco.Text := '';
        RetornoJsonArray := Nil;
        ObjEnderecoCtrl.Free;
        raise Exception.Create('Endereço ('+EdtEndereco.Text+') não encontrado!');
     End;
     RetornoJsonArray := Nil;
     ObjEnderecoCtrl.Free;
  End;
  ExitFocus(Sender);
end;

procedure TFrmSegregadoBaixa.EdtCodPessoaExit(Sender: TObject);
Var ObjPessoaCtrl   : TPessoaCtrl;
    ReturnjsonArray : TJsonArray;
    vErro           : String;
begin
  inherited;
  if EdtCodPessoa.Text = '' then Begin
     LblPessoa.Caption := '';
     Exit;
  End;
  if StrToIntDef(EdtCodPessoa.Text, 0) <= 0 then Begin
     LblPessoa.Caption := '';
     ShowErro( '😢Código de Fornecedor('+EdtCodPessoa.Text+') inválido!' );
     EdtCodPessoa.Clear;
     EdtCodPessoa.SetFocus;
     Exit;
  end;
  ObjPessoaCtrl := TPessoaCtrl.Create;
  ReturnjsonArray := ObjPessoaCtrl.FindPessoa(0, StrToIntDef(EdtCodPessoa.text, 0), '', '', 2, 0);
  if (ReturnjsonArray.Count <= 0) or (ReturnjsonArray.Get(0).tryGetValue<String>('Erro', vErro)) then Begin
     LblPessoa.Caption := '';
     ShowErro( '😢Erro: ' );
     EdtCodPessoa.Clear;
  end
  Else
     LblPessoa.Caption := (ReturnjsonArray.Items[0] as TJSONObject).GetValue<String>('razao');
  ReturnJsonArray := Nil;
  ObjPessoaCtrl.Free;
  ExitFocus(Sender);
end;

procedure TFrmSegregadoBaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmSegregadoBaixa := Nil;
end;

end.
