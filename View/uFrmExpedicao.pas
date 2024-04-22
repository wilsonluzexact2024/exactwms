unit uFrmExpedicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFrmBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, dxBarBuiltInMenu, AdvUtil,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.JSON, REST.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  System.ImageList, Vcl.ImgList, AsgLinks, AsgMemo, AdvGrid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtDlgs, Vcl.ExtCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses, Vcl.StdCtrls, Vcl.Mask, JvExMask, JvSpin,
  acPNG, acImage, AdvLookupBar, AdvGridLookupBar, Vcl.Grids, AdvObj, BaseGrid, cxPC
  , PedidoVolumeCtrl, JvToolEdit, JvBaseEdits, dxSkinsCore,
  dxSkinsDefaultPainters, Vcl.Buttons, Vcl.ComCtrls, Vcl.DBGrids, ACBrBase,
  ACBrETQ, dxCameraControl, uFrmeXactWMS;

type
  TFrmExpedicao = class(TFrmBase)
    LstASGExpedicao: TAdvStringGrid;
    EdtVolumeId: TJvCalcEdit;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    EdtPedidoId: TEdit;
    Label4: TLabel;
    EdtDocumentoData: TEdit;
    Label5: TLabel;
    EdtDestino: TEdit;
    Label6: TLabel;
    EdtRota: TEdit;
    Label7: TLabel;
    LblOrdem: TLabel;
    Label8: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtVolumeIdEnter(Sender: TObject);
    procedure EdtVolumeIdExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TabPrincipalShow(Sender: TObject);
  private
    { Private declarations }
    ObjPedidoVolumeCtrl : TPedidoVolumeCtrl;
    Function GetListaVolumeExpedicao : Boolean;
    Function GetListaVolumeExpedido  : Boolean;
    Procedure RegistrarVolume;
    Procedure LimparExpedicao;
  Protected
    Procedure GetListaLstCadastro; OverRide;
  public
    { Public declarations }
  end;

var
  FrmExpedicao: TFrmExpedicao;

implementation

{$R *.dfm}

uses uFuncoes;

procedure TFrmExpedicao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmExpedicao := Nil;
end;

procedure TFrmExpedicao.FormCreate(Sender: TObject);
begin
  inherited;
  ObjPedidoVolumeCtrl := TPedidoVolumeCtrl.Create;
  LstCadastro.ColWidths[0] := 	70;
  LstCadastro.ColWidths[1] := 	80;
  LstCadastro.ColWidths[2] := 	150;
  LstCadastro.ColWidths[3] := 	150;
  LstCadastro.Alignments[0, 0] := taRightJustify;
  LstCadastro.FontStyles[0, 0] := [FsBold];
  LstCadastro.Alignments[1, 0] := taRightJustify;
  //GetListaVolumeExpedido;
  LstASGExpedicao.ColWidths[0] := 	70;
  LstASGExpedicao.ColWidths[1] := 	80;
  LstASGExpedicao.ColWidths[2] := 	150;
  LstASGExpedicao.ColWidths[3] := 	150;
  LstASGExpedicao.Alignments[0, 0] := taRightJustify;
  LstASGExpedicao.FontStyles[0, 0] := [FsBold];
  LstASGExpedicao.Alignments[1, 0] := taRightJustify;
  GetListaVolumeExpedicao;
end;

procedure TFrmExpedicao.FormDestroy(Sender: TObject);
begin
  ObjPedidoVolumeCtrl.Free;
  inherited;
end;

procedure TFrmExpedicao.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  inherited;

end;

procedure TFrmExpedicao.GetListaLstCadastro;
begin
  inherited;
  GetListaVolumeExpedido;
end;

function TFrmExpedicao.GetListaVolumeExpedicao: Boolean;
Var xReturn         : Integer;
    ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  LstASGExpedicao.ClearRect(0, 1, LstASGExpedicao.ColCount-1, LstASGExpedicao.RowCount-1);
  ReturnJsonArray      := ObjPedidoVolumeCtrl.VolumeExpedicao;
  LstASGExpedicao.RowCount := 1;
  If ReturnJsonArray.Get(0).TryGetValue('Erro', vErro) then Begin
     Result := False;
     Exit;
  End;
  LstASGExpedicao.RowCount  := ReturnJsonArray.Count+1;
  Result := ReturnJsonArray.Count >= 1;
  If ReturnJsonArray.Count >= 1 then Begin
     LstASGExpedicao.FixedRows := 1;
     For xReturn := 0 To ReturnJsonArray.Count-1 do begin
       LstASGExpedicao.Cells[0, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidoid').ToString();
       LstASGExpedicao.Cells[1, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidovolumeid').ToString();
       LstASGExpedicao.Cells[2, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('embalagem');
       LstASGExpedicao.Cells[3, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('processo');
       LstASGExpedicao.Alignments[0, xReturn+1] := taRightJustify;
       LstASGExpedicao.FontStyles[0, xReturn+1] := [FsBold];
       LstASGExpedicao.Alignments[1, xReturn+1] := taRightJustify;
     end;
     LstASGExpedicao.SortSettings.Column := 1;
     LstASGExpedicao.QSort;
     AdvGridLookupBar1.Column := 1;
     ReturnJsonArray := Nil;
  End;
end;

Function TFrmExpedicao.GetListaVolumeExpedido : Boolean;
Var xReturn         : Integer;
    ReturnJsonArray : TJsonArray;
    vErro           : String;
begin
  LstCadastro.ClearRect(0, 1, LstCadastro.ColCount-1, LstCadastro.RowCount-1);
  ReturnJsonArray      := ObjPedidoVolumeCtrl.VolumeExpedido;
  LstCadastro.RowCount := 1;
  If ReturnJsonArray.Get(0).TryGetValue('Erro', vErro) then Begin
     Result := False;
     ReturnJsonArray := Nil;
     Exit;
  End;
  LstCadastro.RowCount  := ReturnJsonArray.Count+1;
  Result := ReturnJsonArray.Count >= 1;
  If ReturnJsonArray.Count >= 1 then Begin
     LstCadastro.FixedRows := 1;
     For xReturn := 0 To ReturnJsonArray.Count-1 do begin
       LstCadastro.Cells[0, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidoid').ToString();
       LstCadastro.Cells[1, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<Integer>('pedidovolumeid').ToString();
       LstCadastro.Cells[2, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('embalagem');
       LstCadastro.Cells[3, xReturn+1] := ReturnJsonArray.Get(xReturn).GetValue<string>('processo');
       LstCadastro.Alignments[0, xReturn+1] := taRightJustify;
       LstCadastro.FontStyles[0, xReturn+1] := [FsBold];
       LstCadastro.Alignments[1, xReturn+1] := taRightJustify;
     end;
     LstCadastro.SortSettings.Column := 1;
     LstCadastro.QSort;
     AdvGridLookupBar1.Column := 1;
  End;
  ReturnJsonArray := Nil;
end;

procedure TFrmExpedicao.LimparExpedicao;
begin
  EdtVolumeId.Clear;
  EdtPedidoId.Clear;
  EdtDOcumentoData.Clear;
  EdtDestino.Clear;
  EdtRota.Clear;
  LblOrdem.Caption := '';
end;

procedure TFrmExpedicao.RegistrarVolume;
Var ObjVolumeCtrl    : TPedidoVolumeCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
    vVolumeEtapaId   : Integer;
begin
  Try
    ObjVolumeCtrl := TPedidoVolumeCtrl.Create;
    JsonArrayRetorno := ObjVolumeCtrl.GetVolume(0, StrToIntDef(EdtVolumeId.Text, 0), 0, 0);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       MensagemSis('Aten��o', 'Volume: '+EdtVolumeId.Text, vErro, '', False, True);
       EdtVolumeId.Clear;
       edtvolumeId.setFocus;
       JsonArrayRetorno := Nil;
       ObjVolumeCtrl.Free;
       Exit;
    End
    Else If JsonArrayRetorno.Items[0].GetValue<Integer>('qtdsuprida') = 0 then Begin
       MensagemSis('Aten��o', 'Volume: '+EdtVolumeId.Text, 'Cancelar o Volume.', '', False, True);
       EdtVolumeId.Clear;
       edtvolumeId.setFocus;
       JsonArrayRetorno := Nil;
       ObjVolumeCtrl.Free;
       Exit;
    End
    Else Begin
       EdtPedidoId.Text      := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('pedido').GetValue<String>('pedidoid');
       EdtDocumentoData.Text := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('pedido').GetValue<String>('documentodata');
       EdtDestino.Text       := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('destino').GetValue<String>('codpessoaerp')+' '+
                                JsonArrayRetorno.Items[0].GetValue<TJsonObject>('destino').GetValue<String>('fantasia');
       EdtRota.Text          := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('rotaid')+' '+
                                JsonArrayRetorno.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('rota');
       LblOrdem.Caption      := JsonArrayRetorno.Items[0].GetValue<TJsonObject>('rota').GetValue<String>('ordem');
    End;
    if Not (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid') in [8, 10, 12]) then Begin
       EdtVolumeId.Text := '';
       MensagemSis('Aten��o!', 'Opera��o n�o permitida! ', 'Etapa atual: '+JsonArrayRetorno.Items[0].GetValue<String>('processo'), '', False, True);
       EdtVolumeId.SetFocus;
       JsonArrayRetorno := Nil;
       ObjVolumeCtrl.Free;
       Exit;
    End;
    if (FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExigirReconferenciaToExpedicao = 1) and
        (JsonArrayRetorno.Items[0].GetValue<Integer>('processoid')<>12) then Begin
        LimparExpedicao;
        MensagemSis('Aten��o', 'O Volume('+EdtVolumeId.Text+') deve ser Reconferido!', '', '', False, True);
        Exit;
    End;
    ObjVolumeCtrl.ObjPedidoVolume.PedidoVolumeId := StrToIntDef(EdtVolumeId.Text, 0);
    if FrmeXactWMS.ConfigWMS.ObjConfiguracao.ExpedicaoOffLine = 0 then
       JsonArrayRetorno := ObjVolumeCtrl.RegistrarDocumentoEtapaComBaixaEstoqueJson(13)
    Else
       JsonArrayRetorno := ObjVolumeCtrl.RegistrarDocumentoEtapaSemBaixaEstoqueJson(13);
    if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
       MensagemSis('ATEN��O:', 'Erro na Expedi��o!', vErro, 'Repita o processo.', False, True);
    End
    Else Begin
      ShowOk('concluido');
      GetListaVolumeExpedicao;
    End;
    EdtVolumeId.Text := '';
    EdtVolumeId.SetFocus;
    JsonArrayRetorno    := Nil;
    ObjVolumeCtrl.Free;
  Except On E: Exception do Begin
    JsonArrayRetorno    := Nil;
    EdtvolumeId.setFocus;
    ObjVolumeCtrl.Free;
    MensagemSis('ATEN��O:', 'Erro na Expedi��o!', E.Message, 'Repita o processo.', False, True);
    End;
  End;
end;

procedure TFrmExpedicao.TabPrincipalShow(Sender: TObject);
begin
  inherited;
  EdtVolumeId.SetFocus;
end;

procedure TFrmExpedicao.EdtVolumeIdEnter(Sender: TObject);
begin
  inherited;
  EnterFocus(Sender);
end;

procedure TFrmExpedicao.EdtVolumeIdExit(Sender: TObject);
begin
  inherited;
  ExitFocus(EdtVolumeId);
end;

procedure TFrmExpedicao.EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = VK_RETURN) and (EdtVolumeId.Value > 0)then
     RegistrarVolume;
end;

end.
