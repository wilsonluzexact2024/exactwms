unit uFrmDshRecebimentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uFrmReportBase, dxSkinsCore, DataSet.Serialize,
  dxSkinsDefaultPainters, dxBarBuiltInMenu, cxGraphics, cxControls, System.JSON, REST.Json, Rest.Types,
  cxLookAndFeels, cxLookAndFeelPainters, AdvUtil, Data.DB, FireDAC.Stan.Intf, Math,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxExportXLS, frxClass, frxExportPDF,
  frxExportMail, frxExportImage, frxExportHTML, frxDBSet, frxExportBaseDialog,
  frxExportCSV, ACBrBase, ACBrETQ, Vcl.ExtDlgs, System.ImageList, Vcl.ImgList,
  AsgLinks, AsgMemo, AdvGrid, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.Imaging.jpeg, dxCameraControl, acPNG, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, dxGDIPlusClasses, acImage,
  AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC, Vcl.Mask,
  JvExMask, JvSpin, JvToolEdit, Vcl.OleCtrls, SHDocVw, EntradaCtrl;

type
  TFrmDshRecebimentos = class(TFrmReportBase)
    GbPeriodo: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EdtInicio: TJvDateEdit;
    EdtTermino: TJvDateEdit;
    GbAtualizarDsh: TGroupBox;
    CbTime: TComboBox;
    GbDshPanel: TPanel;
    Label25: TLabel;
    Panel5: TPanel;
    Shape7: TShape;
    Label9: TLabel;
    LblTotCheckIn: TLabel;
    Image1: TImage;
    LblPercCheckin: TLabel;
    Panel6: TPanel;
    Shape8: TShape;
    Label10: TLabel;
    LblTotDevolucao: TLabel;
    LblPercDevolucao: TLabel;
    Image2: TImage;
    Panel1: TPanel;
    Shape9: TShape;
    Label11: TLabel;
    LblTotSegregado: TLabel;
    LblPercSegregado: TLabel;
    Image3: TImage;
    PnlPendencia: TPanel;
    Shape1: TShape;
    Label12: TLabel;
    LblTotPendencia: TLabel;
    LblPercPendente: TLabel;
    Image4: TImage;
    PnlDemanda: TPanel;
    Shape2: TShape;
    Label4: TLabel;
    LblTotDemanda: TLabel;
    Image5: TImage;
    PnlWebBrowser: TPanel;
    WebBrowser1: TWebBrowser;
    PnlCancelado: TPanel;
    Shape3: TShape;
    Label5: TLabel;
    LblTotCancelado: TLabel;
    lblPercCancelado: TLabel;
    Image6: TImage;
    PnlPedidos: TPanel;
    Label8: TLabel;
    PnlPedidoPendencia: TPanel;
    Shape10: TShape;
    Label22: TLabel;
    LblTotPedidoPendente: TLabel;
    LblPercPedPendente: TLabel;
    Image10: TImage;
    PntPedidoDemanda: TPanel;
    Shape11: TShape;
    Label26: TLabel;
    LblTotPedidoDemanda: TLabel;
    Image11: TImage;
    PnlPedidoCancelado: TPanel;
    Shape12: TShape;
    Label28: TLabel;
    LblTotPedidoCancelado: TLabel;
    LblPercPedCancelado: TLabel;
    Image12: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure ShowGraphic;
    procedure ThreadTerminate(Sender: TObject);
  Protected
    Procedure PesquisarDados; OverRide;
    Procedure Limpar;  OverRide;
  public
    { Public declarations }
  end;

var
  FrmDshRecebimentos: TFrmDshRecebimentos;

implementation

{$R *.dfm}

procedure TFrmDshRecebimentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmDshRecebimentos := Nil;
end;

procedure TFrmDshRecebimentos.FormCreate(Sender: TObject);
begin
  inherited;
//  WebBrowser1.Top   := GbDshPanel.Top+GbDshPanel.Height+20;
//  WebBrowser1.Align := AlBottom;
end;

procedure TFrmDshRecebimentos.Limpar;
begin
  inherited;
  CbTime.ItemIndex := 7;
  LblTotPedidoDemanda.Caption   := '0';
  LblTotPedidoCancelado.Caption := '0';
  LblTotPedidoPendente.Caption  := '0';
  LblPercPedCancelado.Caption   := '0';
  LblPercPedPendente.Caption    := '0';
  LblTotDemanda.Caption         := '0';
  LblTotCheckIn.Caption         := '0';
  LblTotDevolucao.Caption       := '0';
  LblTotSegregado.Caption       := '0';
  LblTotCancelado.Caption       := '0';
  LblTotPendencia.Caption       := '0';
  LblPercCheckin.Caption        := '0';
  LblPercDevolucao.Caption      := '0';
  LblPercSegregado.Caption      := '0';
  lblPercCancelado.Caption      := '0';
  LblPercPendente.Caption       := '0';
end;

procedure TFrmDshRecebimentos.PesquisarDados;
Var ObjEntradaCtrl : TEntradaCtrl;
    JsonArrayRecebimento : TJsonArray;
    vErro : String;
begin
  inherited;
  if (EdtInicio.Text = '  /  /    ') and (EdtTermino.Text = '  /  /    ') then Begin
     ShowErro('Informe o período para gerar o Dashboar.');
     Exit;
  End;
  Try
    StrToDate(EdtInicio.Text);
  Except
    ShowErro('Data Inicial inválida');
    EdtInicio.SetFocus;
    Exit;
  End;
  Try
    StrToDate(EdtTermino.Text);
  Except
    ShowErro('Data Final inválida');
    EdtTermino.SetFocus;
    Exit;
  End;
  if StrToDate(EdtInicio.Text) > StrToDate(EdtTermino.Text) then Begin
    ShowErro('Período inválido para gerar o Dashboard.');
    EdtInicio.SetFocus;
    Exit;
  End;
  ObjEntradaCtrl := TEntradaCtrl.Create;
  JsonArrayRecebimento := ObjEntradaCtrl.GetRelDshRecebimentos(StrToDate(EdtInicio.Text), StrToDate(EdtTermino.Text));
  if JsonArrayRecebimento.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
  End
  Else Begin
    If FdMemPesqGeral.Active then
       FdMemPesqGeral.EmptyDataSet;
    FdMemPesqGeral.Close;
    FdMemPesqGeral.LoadFromJSON(JsonArrayRecebimento, False);
    ShowGraphic;
  End;
  //JsonArrayRecebimento := Nil;
  //ObjEntradaCtrl.Free;
end;

procedure TFrmDshRecebimentos.ShowGraphic;
Var Th : TThread;
    vDataInicial, vDataFinal : TDateTime;
begin
  Th := TThread.CreateAnonymousThread(procedure
     begin
       While Not FdMemPesqGeral.Eof do Begin
         TThread.Synchronize(TThread.CurrentThread, procedure
         begin
           LblTotPedidoDemanda.Caption   := FdMemPesqGeral.FieldByName('TotPedido').AsString;
           LblTotPedidoCancelado.Caption := FdMemPesqGeral.FieldByName('PedCancelado').AsString;
           LblPercPedCancelado.Caption   := RoundTo(FdMemPesqGeral.FieldByName('PedCancelado').AsInteger / FdMemPesqGeral.FieldByName('TotPedido').AsInteger * 100, -2).ToString+'%';
           LblTotPedidoPendente.Caption  := FdMemPesqGeral.FieldByName('PedPendente').AsString;
           LblPercPedPendente.Caption   := RoundTo(FdMemPesqGeral.FieldByName('PedPendente').AsInteger / FdMemPesqGeral.FieldByName('TotPedido').AsInteger * 100, -2).ToString+'%';
           LblTotDemanda.Caption    := FdMemPesqGeral.FieldByName('QtdXml').AsString;
           LblTotCheckIn.Caption    := FdMemPesqGeral.FieldByName('QtdCheckIn').AsString;
           LblPercCheckin.Caption   := RoundTo(FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotDevolucao.Caption  := FdMemPesqGeral.FieldByName('QtdDevolvida').AsString;
           LblPercDevolucao.Caption := RoundTo(FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotSegregado.Caption  := FdMemPesqGeral.FieldByName('QtdSegregada').AsString;
           LblPercSegregado.Caption := RoundTo(FdMemPesqGeral.FieldByName('QtdSegregada').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotCancelado.Caption  := FdMemPesqGeral.FieldByName('QtdCancelado').AsString;
           LblPercCancelado.Caption := RoundTo(FdMemPesqGeral.FieldByName('QtdCancelado').AsInteger / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
           LblTotPendencia.Caption  := (FdMemPesqGeral.FieldByName('QtdXml').AsInteger -
                                       (FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger+
                                        FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger+
                                        FdMemPesqGeral.FieldByName('QtdSegregada').Asinteger)).ToString;
           LblPercPendente.Caption  := RoundTo((FdMemPesqGeral.FieldByName('QtdXml').AsInteger -
                                              (FdMemPesqGeral.FieldByName('QtdCheckIn').AsInteger+
                                               FdMemPesqGeral.FieldByName('QtdDevolvida').AsInteger+
                                               FdMemPesqGeral.FieldByName('QtdSegregada').Asinteger)) / FdMemPesqGeral.FieldByName('QtdXml').AsInteger * 100, -2).ToString+'%';
         End);
         FdMemPesqGeral.Next;
       End;
     End);
  Th.OnTerminate := ThreadTerminate;
  Th.Start;
end;

procedure TFrmDshRecebimentos.ThreadTerminate(Sender: TObject);
begin
  if Sender is TThread then
  begin
    if Assigned(TThread(Sender).FatalException) then
    begin
      ShowErro(Exception(TThread(sender).FatalException).Message);
      exit;
    end;
  end;
end;

end.
