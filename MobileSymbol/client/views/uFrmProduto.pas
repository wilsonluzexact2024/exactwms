unit uFrmProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, System.Generics.Collections,
  FMX.ListView.Adapters.Base, MultiDetailAppearanceU, FMX.Edit, FMX.ListView,
  FMX.Controls.Presentation, FMX.TabControl, FMX.Layouts, FMX.Gestures,
  FMX.ListBox, FMX.Objects, System.Actions, FMX.ActnList, uMyTabOrderClassHelper,
  uDmClient, Data.DbxJsonReflect, System.Rtti, DataSet.Serialize,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, System.JSON, REST.Json, Rest.Types,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB, Data.FireDACJSONReflect,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Grid,
  FireDAC.Stan.StorageBin, ksTypes, ksLoadingIndicator, System.StrUtils,
  FMX.Grid.Style, FMX.ScrollBox
  {$IFDEF IOS}
      ,Macapi.Helpers
  {$ENDIF IOS}
  {$IFDEF ANDROID} // or  {$IFDEF IOS}
    ,Androidapi.Helpers
    ,Androidapi.JNI.GraphicsContentViewText
    ,Androidapi.JNI.App, Androidapi.JNI.Net, Androidapi.JNI.JavaTypes
    ,Androidapi.JNI.Os
    ,Androidapi.JNI.Telephony //Sms
  {$Endif}
  , ProdutoCtrl, ProdutoClass
  , uTEnderecoColetor
  , uTProdutoColetor
  , uTProdutoControle
  , RastroCtrl, RastroClass, FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani;

type
  TFrmProduto = class(TFrmBase)
    EdtDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtEndereco: TEdit;
    Label3: TLabel;
    CbRastroTipo: TComboBox;
    Label4: TLabel;
    EdtFabricante: TEdit;
    EdtAltura: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    EdtLargura: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    EdtComprimento: TEdit;
    EdtVolume: TEdit;
    SwtLiquido: TSwitch;
    Label11: TLabel;
    Label10: TLabel;
    EdtPeso: TEdit;
    RctCapPickShelfLife: TRectangle;
    Label14: TLabel;
    Label15: TLabel;
    Label12: TLabel;
    EdtEstoqMin: TEdit;
    EdtEstoqMax: TEdit;
    Label13: TLabel;
    Label16: TLabel;
    EdtValidadeMinEnt: TEdit;
    EdtValidadeMinSai: TEdit;
    Label17: TLabel;
    TabEstoque: TTabItem;
    ChgTabEstoque: TChangeTabAction;
    GdEstoque: TGrid;
    Switch1: TSwitch;
    Label18: TLabel;
    BindSourceDB1: TBindSourceDB;
    QryPrdEstoque: TFDMemTable;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    Line5: TLine;
    Line2: TLine;
    Line3: TLine;
    Line4: TLine;
    Line6: TLine;
    Line7: TLine;
    Line8: TLine;
    Line10: TLine;
    Line12: TLine;
    Line13: TLine;
    Line14: TLine;
    Line15: TLine;
    SwtImportado: TSwitch;
    Label19: TLabel;
    Label20: TLabel;
    SwtInflamavel: TSwitch;
    Label21: TLabel;
    SwtPerigoso: TSwitch;
    Label22: TLabel;
    SwtMedicamento: TSwitch;
    Label23: TLabel;
    EdtFabricanteId: TEdit;
    Line16: TLine;
    RctUnidProd: TRectangle;
    Label24: TLabel;
    EdtUnidIdPrim: TEdit;
    Line17: TLine;
    LblUnidPrimaria: TLabel;
    Label25: TLabel;
    EdtQtdeUnidPrim: TEdit;
    Line18: TLine;
    Label26: TLabel;
    EdtUnidIdSec: TEdit;
    Line19: TLine;
    LblUnidSecundaria: TLabel;
    Label28: TLabel;
    EdtFatorConversao: TEdit;
    Line20: TLine;
    Label5: TLabel;
    SwtSngpc: TSwitch;
    Label27: TLabel;
    LstProduto: TListView;
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtCodigoValidate(Sender: TObject; var Text: string);
    procedure FormCreate(Sender: TObject);
    procedure EdtCodigoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure GdSearchHeaderClick(Column: TColumn);
    procedure GdSearchDblClick(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure GdEstoqueGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure GdSearchGesture(Sender: TObject;
      const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure EdtCodigoTyping(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtEnderecoValidate(Sender: TObject; var Text: string);
    procedure BtnSaveClick(Sender: TObject);
    procedure EdtEnderecoEnter(Sender: TObject);
    procedure EdtFabricanteIdTyping(Sender: TObject);
    procedure EdtUnidIdPrimTyping(Sender: TObject);
    procedure EdtUnidIdSecTyping(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    Procedure Limpar;
  private
    { Private declarations }
    ObjProdutoCtrl : TProdutoCtrl;
    Procedure GetProduto;
    Procedure GetProdutoControle;
    Procedure PositionField;
    Procedure ShowProduto;
    Procedure ValidarBeepProduto;
    Function GetPickUsed(pCdProduto : Int64; pNmEndereco : String) : Boolean;
    Function GetListaProduto(pId, pCodigoERP : String; pDescricao : String; pRecsSkip : Integer) : Boolean;
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
  public
    { Public declarations }
  end;

var
  FrmProduto : TFrmProduto;

implementation

{$R *.fmx}
{$R *.NmXhdpiPh.fmx ANDROID}

Uses uRetorno, uFuncoes, uFrmeXactWMS, EnderecoCtrl;

procedure TFrmProduto.BtnAddClick(Sender: TObject);
begin
  FuncaoDesabilitada(FrmProduto);
  //inherited;
end;

procedure TFrmProduto.BtnDelClick(Sender: TObject);
begin
  FuncaoDesabilitada(FrmProduto);
  //inherited;
end;

procedure TFrmProduto.BtnEditClick(Sender: TObject);
begin
  if (ObjProdutoCtrl.ObjProduto = Nil) or (EdtCodigo.Text = '') then
     raise Exception.Create('Altera��o inv�lida...');
  inherited;

end;

procedure TFrmProduto.BtnSaveClick(Sender: TObject);
Var JsonProduto : TJsonObject;
begin
  if EdtCodigo.Text = '' then Exit;
  ShowLoading;

  ObjProdutoCtrl.ObjProduto.Laboratorio.IdLaboratorio := StrToIntDef(EdtFabricanteId.Text, 0);
    //Endereco           := TEndereco;
  ObjProdutoCtrl.ObjProduto.Unid.Id            := StrToIntDef(EdtUnidIdPrim.Text, 0);
  ObjProdutoCtrl.ObjProduto.QtdUnid            := StrToIntDef(EdtQtdeUnidPrim.Text, 0);
  ObjProdutoCtrl.ObjProduto.UnidSecundaria.Id  := StrToIntDef(EdtUnidIdSec.Text, 0);
  ObjProdutoCtrl.ObjProduto.FatorConversao     := StrToIntDef(EdtFatorConversao.Text, 0);
  ObjProdutoCtrl.ObjProduto.Rastro.RastroId    := StrToIntDef(Copy(CbRastroTipo.Items.Text, 1, 1), 0);
  ObjProdutoCtrl.ObjProduto.Rastro.Descricao   := Copy(CbRastroTipo.Items.Text, 3,  Length(CbRastroTipo.Items.Text)-2);
  ObjProdutoCtrl.ObjProduto.Liquido            := SwtLiquido.IsChecked;
  ObjProdutoCtrl.ObjProduto.Importado          := SwtImportado.IsChecked;
  ObjProdutoCtrl.ObjProduto.Inflamavel         := SwtInflamavel.IsChecked;
  ObjProdutoCtrl.ObjProduto.Perigoso           := SwtPerigoso.IsChecked;
  ObjProdutoCtrl.ObjProduto.Medicamento        := SwtMedicamento.IsChecked;
  ObjProdutoCtrl.ObjProduto.SNGPC              := SwtSNGPC.IsChecked;
  ObjProdutoCtrl.ObjProduto.Peso               := StrToIntDef(EdtPeso.Text, 0);
  ObjProdutoCtrl.ObjProduto.Altura             := StrToIntDef(EdtAltura.Text, 0);
  ObjProdutoCtrl.ObjProduto.Largura            := StrToIntDef(EdtLargura.Text, 0);
  ObjProdutoCtrl.ObjProduto.Comprimento        := StrToIntDef(EdtComprimento.Text, 0);
  ObjProdutoCtrl.ObjProduto.Volume             := StrToIntDef(EdtVolume.Text, 0);
  ObjProdutoCtrl.ObjProduto.MaxPicking         := StrToIntDef(EdtEstoqMax.Text, 0); //Capacidade M�xima do Picking
  ObjProdutoCtrl.ObjProduto.MesEntradaMinima   := StrToIntDef(EdtValidadeMinEnt.Text, 0);
  ObjProdutoCtrl.ObjProduto.MesSaidaMinima     := StrToIntDef(EdtValidadeMinSai.Text, 0);

{  JsonProduto := TJsonObject.Create;
  JsonProduto.AddPair('idproduto', TJsonNumber.Create(ObjProdutoCtrl.ObjProduto.IdProduto));
  JsonProduto.AddPair('codproduto', EdtCodigo.Text);
  JsonProduto.AddPair('descricao', EdtDescricao.Text);
  JsonProduto.AddPair('descricaored', EdtDescricao.Text);
  JsonProduto.AddPair('qtdunid', '1');
  JsonProduto.AddPair('fatorconversao', EdtFatorConversao.Text);
  JsonProduto.AddPair('endereco', EdtEndereco.Text);
  JsonProduto.AddPair('rastroid', Copy(CbTipoControle.Items.Strings[CbTipoControle.ItemIndex], 1, 1));
  JsonProduto.AddPair('peso', TJsonNumber.Create(StrToFloat(EdtPeso.Text)));
  JsonProduto.AddPair('altura', TJsonNumber.Create(StrToFloat(EdtAltura.Text)));
  JsonProduto.AddPair('largura', TJsonNumber.Create(StrToFloat(EdtLargura.Text)));
  JsonProduto.AddPair('comprimento', TJsonNumber.Create(StrToFloat(EdtComprimento.Text)));
  JsonProduto.AddPair('mesentradaminima', TJsonNumber.Create(StrToFloat(EdtValidadeMinEnt.Text)));
  JsonProduto.AddPair('messaidaminima', TJsonNumber.Create(StrToFloat(EdtValidadeMinSai.Text)));
}  If ObjProdutoCtrl.Salvar Then Begin
     ObjProdutoCtrl.ObjProduto.IdProduto := 0;
     HideLoading;
     inherited;
     MensagemStand('Registro salvo com sucesso!')
  End
  else Begin
    HideLoading;
    MensagemStand('Ocorreu um erro: Registro n�o salvo!');
  End;
//  JsonProduto := Nil;
end;

procedure TFrmProduto.EdtCodigoKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
//  If ( (Sender=EdtCodigo) and ( (not (KeyChar in['0'..'9',Chr(8)]))) ) Then
//     KeyChar := #0;
  if (Sender = EdtCodigo) and (KeyChar<>#13) then
     Limpar;
end;

procedure TFrmProduto.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$if defined(Android)}
   var I : JIntent;
{$Endif}
begin
  inherited;
  if (Sender=Edtcodigo) and (FrmeXactWMS.Brand_Collector = 'Zebra') then Begin
     If ((key = 0) and (IntToStr(ord(KeyChar))='0') ) then Begin //Descobrir Key do Ativador de Leitor de C�digo de Barras//  https://developer.zebra.com/thread/29927
        {$if defined(Android)}
          i := TJIntent.JavaClass.init;
          i.setAction(StringToJString('com.motorolasolutions.emdk.datawedge.api.ACTION_SOFTSCANTRIGGER'));
          i.putExtra(StringToJString('com.motorolasolutions.emdk.datawedge.api.EXTRA_PARAMETER'), StringtoJString('TOGGLE_SCANNING'));
          TAndroidHelper.Activity.sendBroadcast(i);  //SharedActivity.sendBroadcast(i);
        {$Endif}
     end;
  End;
  case Key of
    vkReturn:
        TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
//    vkTab:
//      TControl(Self).SelectNext(TControl(Screen.FocusControl), (not (ssShift in Shift)));
  end;
end;

procedure TFrmProduto.EdtCodigoTyping(Sender: TObject);
begin
  inherited;
  if sender=EdtCodigo then Limpar;
end;

procedure TFrmProduto.EdtCodigoValidate(Sender: TObject; var Text: string);
begin
  inherited;
  if EdtCodigo.Text = '' then Exit;
     GetProduto;
end;

procedure TFrmProduto.EdtEnderecoEnter(Sender: TObject);
begin
  inherited;
  if (Not EdtEndereco.ReadOnly) and (EdtEndereco.Text<>'') then
     EdtEndereco.Text := StringReplace(StringReplace(EdtEndereco.Text, '.', '', [rfreplaceAll]), '.', '', [rfreplaceAll]);
end;

procedure TFrmProduto.EdtEnderecoValidate(Sender: TObject; var Text: string);
//Var vObjEnd : TEnderecoColetor;

Var ObjEnderecoCtrl  : TEnderecoCtrl;
    RetornoJsonArray : TJsonArray;
    vEndereco        : String;
begin
  inherited;
  if (Not EdtEndereco.ReadOnly) then Begin
     //ObjProdutoCtrl.ObjProduto.Endereco := TEndereco.Create;
     if (EdtEndereco.Text<>'') then Begin
        Try
          vEndereco := Text;
          ObjEnderecoCtrl  := TEnderecoCtrl.Create;
          RetornoJsonArray := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EnderecoMask(EdtEndereco.Text, '', False),
                                                              EnderecoMask(EdtEndereco.Text, '', False), 'T', 0);
          if RetornoJsonArray.Count < 1 then Begin
             Text := '';
             MensagemStand('Endere�o '+vEndereco+'n�o encontrado!');
             DelayEdSetFocus(EdtEndereco);
         End;
          ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId := 0;
          If RetornoJsonArray.Items[0].GetValue<Integer>('enderecoid') = 0 then Begin
             Text := '';
             MensagemStand('Endereco('+EnderecoMask(EdtEndereco.Text, '', False)+') inexistente');
             DelayEdSetFocus(EdtEndereco);
          End
          Else If (RetornoJsonArray.Items[0].GetValue<TJsonObject>('enderecoestrutura')).GetValue<Integer>('pickingfixo') <> 1 then Begin
             Text := '';
             MensagemStand('Tipo de Estrutura inv�lida! Endere�o n�o � picking!');
             DelayEdSetFocus(EdtEndereco);
          End
          Else if ((RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> 0) and
                  ((RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<Integer>('produtoid') <> ObjProdutoCtrl.ObjProduto.IdProduto) then Begin
             Text := '';
             MensagemStand('Picking inv�lido, j� utilizado pelo Produto: '+
                                    (RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<String>('produtoid')+' '+
                                    (RetornoJsonArray.Items[0].GetValue<TJsonObject>('produto')).GetValue<String>('descricao') );
             DelayEdSetFocus(EdtEndereco);
          End
          Else Begin
//            ObjEnderecoCtrl.ObjEndereco := RetornoJsonArray.Items[0] as TJSONObject;
            ObjEnderecoCtrl.ObjEndereco := ObjEnderecoCtrl.ObjEndereco.JsonToClass((RetornoJsonArray.Items[0] as TJSONObject).ToString());
            ObjProdutoCtrl.ObjProduto.Endereco := ObjEnderecoCtrl.ObjEndereco;
          End;
          if Text <> '' then
             Text := EnderecoMask(EdtEndereco.Text, ObjProdutoCtrl.ObjProduto.Endereco.EnderecoEstrutura.Mascara, True);
        Except On E: Exception do Begin
          ObjEnderecoCtrl := Nil; //.DisposeOf;
          RetornoJsonArray := Nil; //.DisposeOf;
          raise Exception.Create('Endere�o: '+EnderecoMask(EdtEndereco.Text, '', False)+sLineBreak+E.Message);
          End;
        End;
        ObjEnderecoCtrl  := Nil; //.DisposeOf;
        RetornoJsonArray := Nil; //.DisposeOf;
     End
     Else Begin
        ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId := 0;
        ObjProdutoCtrl.ObjProduto.Endereco.Descricao  := '';
     End;
  End;
end;

procedure TFrmProduto.EdtFabricanteIdTyping(Sender: TObject);
begin
  inherited;
  EdtFabricante.Text := '...';
end;

procedure TFrmProduto.EdtUnidIdPrimTyping(Sender: TObject);
begin
  inherited;
  LblUnidPrimaria.Text := '...';
end;

procedure TFrmProduto.EdtUnidIdSecTyping(Sender: TObject);
begin
  inherited;
  LblUnidSecundaria.Text := '...';
end;

procedure TFrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryPrdEstoque.Close;
  QryListaPadrao.Close;
  inherited;
  FrmProduto.disposeOf;
end;

procedure TFrmProduto.FormCreate(Sender: TObject);
begin
  inherited;
  ObjProdutoCtrl         := TProdutoCtrl.Create;
  GetProdutoControle;
  PositionField;
  PgcPrincipal.ActiveTab := TabDetalhes;
  //BtnArrowLeft.Action  := ChgTabEstoque;
  LstPrincipal.Visible   := False;
  GdSearch.Visible       := True;
  //GetListaLstCadastro;
  PgcPrincipal.ActiveTab := TabDetalhes;
//  if FrmeXactWMS.Brand_Collector = 'Honeywell' then
//       VKAutoShowMode  := TVKAutoShowMode.DefinedBySystem;  // Always
end;

procedure TFrmProduto.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(ObjProdutoCtrl) then
     ObjProdutoCtrl.DisposeOf;
end;

procedure TFrmProduto.GdEstoqueGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
//  raise Exception.Create('Acionou o Gesto2');
  If EventInfo.GestureID = igiLongTap then
     GdSearchDblClick(GdSearch);
//  raise Exception.Create('Acionou o Gesto1');
//  inherited;
end;

procedure TFrmProduto.GdSearchDblClick(Sender: TObject);
begin
  inherited;
  if (QryListaPadrao.Active = False) or (QryListaPadrao.IsEmpty) then Exit;
  EdtCodigo.Text := QryListaPadrao.FieldByName('CdProduto').AsString;
  PgcPrincipal.ActiveTab := TabDetalhes;
End;

procedure TFrmProduto.GdSearchGesture(Sender: TObject;
  const EventInfo: TGestureEventInfo; var Handled: Boolean);
begin
  inherited;
  if (EventInfo.GestureID = igiLongTap) and (QryListaPadrao.FieldByName('CdProduto').AsString<>'') then Begin
     PgcPrincipal.ActiveTab := TabDetalhes;
     EdtCodigo.Text := QryListaPadrao.FieldByName('CdProduto').AsString;
  End;
end;

procedure TFrmProduto.GdSearchHeaderClick(Column: TColumn);
begin
  inherited;
  QryListaPadrao.IndexFieldNames := QryListaPadrao.FieldDefList.FieldDefs[Column.Index].Name;
end;

procedure TFrmProduto.GetListaLstCadastro;
begin
  inherited;
  GetListaProduto('-1', '-1', '', 0);
end;

Function TFrmProduto.GetListaProduto(pId, pCodigoERP, pDescricao: String;
  pRecsSkip: Integer): Boolean;
Var JsonArrayProduto : TJsonArray;
    vErro            : String;
    xProduto         : Integer;
begin
  Result := False;
  Showloading;
  if pDescricao = '%' then pDescricao := '*';
  JsonArrayProduto := ObjProdutoCtrl.FindProduto(pId, pCodigoERP, pDescricao, pRecsSkip, 0);
  if JsonArrayProduto.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     Exit;
  End;
  Result := JsonArrayProduto.Count >= 1;
  LstProduto.BeginUpdate;
  LstProduto.Items.Clear;
  If JsonArrayProduto.Count >= 1 then Begin
     For xProduto := 0 to Pred(JsonArrayProduto.Count) do Begin
       With LstProduto.Items.Add do Begin
         TListItemText(Objects.FindDrawable('CodERP')).Text    := JsonArrayProduto.Items[xProduto].GetValue<Integer>('codProduto').ToString;
         TListItemText(Objects.FindDrawable('Descricao')).Text := JsonArrayProduto.Items[xProduto].GetValue<String>('descricao');
         TListItemText(Objects.FindDrawable('Picking')).Text   := EnderecoMask(JsonArrayProduto.Items[xProduto].GetValue<TJsonObject>('endereco').GetValue<String>('descricao'),
                                                                               JsonArrayProduto.Items[xProduto].GetValue<TJsonObject>('endereco').GetValue<TJsonObject>('enderecoEstrutura').GetValue<String>('mascara'),
                                                                               True);
         If JsonArrayProduto.Items[xProduto].GetValue<TJsonObject>('endereco').GetValue<Integer>('enderecoId') = 0 then
            TListItemImage(Objects.FindDrawable('Image2')).Bitmap := ImgLstFdoRed.BitMap
         Else TListItemImage(Objects.FindDrawable('Image2')).Bitmap := Nil;
       End;
     End;
  End;
  LstProduto.EndUpdate;
  HideLoading;
end;

function TFrmProduto.GetPickUsed(pCdProduto: Int64;
  pNmEndereco: String): Boolean;
Var jArr : TJSONArray;
    xCdProduto : String;
begin
  Result := False;
  jArr := DmClient.GetPickUsed(pCdProduto, pNmEndereco);
  if jArr.Items[0] = Nil then Result := True
  Else Begin
  xCdProduto := (jArr.Items[0] as TJsonObject).Get('CdProduto').JsonValue.Value;
  if (xCdproduto='') or (xCdProduto = EdtCodigo.Text) then
     Result := True;
  End;
  FreeAndNil(jArr);
{  With QryMemAjLotesPrd do Begin //Buscando todos os lotes do Produto
    Close;
    CreateDataSet;
    EmptyDataSet;
    for I := 0 to jArr.Count - 1 do Begin
      jObj := jArr.Items[I] as TJSONObject;
      Append;
      FieldByName('CdProduto').AsLargeInt     := jObj.Get('cdProduto').JsonValue.Value.ToInt64();
      FieldByName('CdLote').AsInteger         := jObj.Get('cdLote').JsonValue.Value.ToInteger();
      FieldByName('nmLote').AsString          := jObj.Get('nmLote').JsonValue.Value;
      FieldByName('dtFabricacao').AsDateTime  := StrToDate(jObj.Get('dtFabricacao').JsonValue.Value);
      FieldByName('dtVencimento').AsDateTime  := StrToDate(jObj.Get('dtVencimento').JsonValue.Value);
      FieldByName('qtEspera').AsInteger       := jObj.Get('qtEspera').JsonValue.Value.ToInteger();
      FieldByName('qtEstoque').AsInteger      := jObj.Get('qtEstoque').JsonValue.Value.ToInteger();
      FieldByName('qtSegregada').AsInteger    := jObj.Get('qtSegregada').JsonValue.Value.ToInteger();
      FieldByName('qtCrossDocking').AsInteger := jObj.Get('qtCrossDocking').JsonValue.Value.ToInteger();
      FieldByName('qtTotal').AsInteger        := jObj.Get('qtTotal').JsonValue.Value.ToInteger();
      Post;
    End;
  End;
  ChkSemEstoqueClick(ChkSemEstoque); }
end;

procedure TFrmProduto.GetProduto;
begin
  if EdtCodigo.Text = '' then Exit;
  ShowLoading;
  application.ProcessMessages;
  Try
  //ObjProduto := TProduto.Create();
//  ObjProdutoCtrl.ObjProduto :=  DmClient.GetProduto(EdtCodigo.Text); //.ToInt64());
    ObjProdutoCtrl.GetCodigoERP(EdtCodigo.Text);
  Except On E: Exception do Begin
    ObjProdutoCtrl := Nil;
    HideLoading;
    ShowErro('erro: '+E.Message);
    Exit;
    End;
  End;
  if (ObjProdutoCtrl.ObjProduto=Nil) or (ObjProdutoCtrl.ObjProduto.IdProduto = 0) then Begin
     EdtCodigo.Text := '';
     HideLoading;
     MensagemStand('Produto n�o encontrado!');
     DelayedSetFocus(EdtCodigo);
     DelayedSetFocus(EdtCodigo);
     Exit;
  End;
  ShowProduto;
  HideLoading;
end;

procedure TFrmProduto.GetProdutoControle;
Var unMarshal : TJsonUnmarshal;
    xCount    : Integer;
    ListaProdContr : TListaProdutoControle;
    ArrayRetorno : TJsonArray;
begin
  inherited;
  DmClient.RESTRequest1.ResetToDefaults;
  //DmClient.RESTClient1.ResetToDefaults;
  DmClient.RESTResponse1.ResetToDefaults;
  DmClient.RESTResponseDataSetAdapter1.Response := Nil;
  With dmClient.RESTRequest1 do Begin
    Resource  := 'v1/rastro';
    Method    := RmGet;
    Execute;
    if (dmClient.RESTResponse1.StatusCode = Ok200) or (dmClient.RESTResponse1.StatusCode = Ok201) Then Begin
        CbRastroTipo.Items.Clear;
        ArrayRetorno := DmClient.RESTResponse1.JSONValue as TJsonArray;
        For xCount := 0 to Pred(ArrayRetorno.Count) do
          CbRastroTipo.Items.Add(ArrayRetorno.Items[xCount].GetValue<String>('rastroId')+' '+ArrayRetorno.Items[xCount].GetValue<String>('descricao'));
        ArrayRetorno := Nil;
    End;
  End;
end;

procedure TFrmProduto.Limpar;
begin
  EdtEndereco.Text       := '';
  CbRastroTipo.ItemIndex := -1;
  Edtdescricao.Text      := '';
  EdtFabricanteId.Text   := '';
  EdtFabricante.Text     := '';
  EdtUnidIdPrim.Text     := '';
  LblUnidPrimaria.Text   := '...';
  EdtQtdeUnidPrim.Text   := '';
  EdtUnidIdSec.Text      := '';
  LblUnidSecundaria.Text := '';
  EdtFatorConversao.Text := '';
  EdtAltura.Text         := '';
  EdtLargura.Text        := '';
  EdtComprimento.Text    := '';
  EdtVolume.Text         := '';
  EdtPeso.Text           := '';
  SwtLiquido.IsChecked   := False;
  SwtImportado.IsChecked   := False;
  SwtInflamavel.IsChecked  := False;
  SwtPerigoso.IsChecked    := False;
  SwtMedicamento.IsChecked := False;
  SwtSngpc.IsChecked       := False;
  EdtEstoqMin.Text         := '';
  EdtEstoqMax.Text         := '';
  EdtValidadeMinEnt.Text   := '';
  EdtValidadeMinSai.Text   := '';
  QryPrdEstoque.Active     := False;
  LstProduto.Items.Clear;
end;

function TFrmProduto.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  if pConteudo = '0' then raise Exception.Create('conte�do inv�lido para pesquisar!');
  if (EdtConteudoPesq.Text <> '') then begin
     if CbCampoPesq.ItemIndex < 0 then
        raise Exception.Create('Selecione o campo para procurar!');
     if CbCampoPesq.ItemIndex = 0 then //0 Id 1-Criar no server consulta por Cod.ERP
        Result := GetListaProduto('0', EdtConteudoPesq.Text, '', 0)
     Else if CbCampoPesq.ItemIndex = 1 then Begin//Descricao
       if Length(EdtConteudoPesq.Text) < 3 then
          raise Exception.Create('voc� deve digitar pelo menos 3 character!');
        Result := GetListaProduto('0', '0', EdtConteudoPesq.Text, 0);
     End;
     EdtConteudoPesq.Text := '';
  End;
  if Result = False then
     raise Exception.Create('N�o econtrei dados da pesquisa!');
end;

procedure TFrmProduto.PgcPrincipalChange(Sender: TObject);
Var Ret_SaiProcessamento : TFDJSONDataSets;
begin
  inherited;
  FrmeXactWMS.KsLoadingIndicator1.ShowLoading;
  if (PgcPrincipal.ActiveTab = TabLista) then Begin
     BtnArrowLeft.Action  := ChgTabEstoque;
     BtnArrowRigth.Action := ChgTabDet;
  End
  Else if (PgcPrincipal.ActiveTab = TabDetalhes) then Begin
     BtnArrowLeft.Action  := ChgTabLista;
     BtnArrowRigth.Action := ChgTabEstoque;
     DelayedSetFocus(EdtCodigo);
  End
  Else if (PgcPrincipal.ActiveTab = TabEstoque) then Begin
     BtnArrowLeft.Action  := ChgTabDet;
     BtnArrowRigth.Action := ChgTabLista;
  End;
  if ((PgcPrincipal.ActiveTab = TabLista) and (Not QryListaPadrao.Active)) then Begin
//     Ret_SaiProcessamento := dmClient.GetvProdSaiProcessamento;
//Busca os Produtos e Lotes do Volume para Separa��o
//     With QryListaPadrao do Begin
//       Close;
//       AppendData(TFDJSONDataSetsReader.GetListValue(Ret_SaiProcessamento, 0));
//       Open;
//     End;
  End;
  if ((PgcPrincipal.ActiveTab = TabEstoque) and (Not QryPrdEstoque.Active)) then Begin
     //Ret_SaiProcessamento := dmClient.GetEstoqueProducao(ObjProduto.Codigo, '');
//Busca os Produtos e Lotes do Volume para Separa��o
//     With QryPrdEstoque do Begin
//       Close;
//       AppendData(TFDJSONDataSetsReader.GetListValue(Ret_SaiProcessamento, 0));
//       Open;
//     End;
  End;
  if assigned(Ret_SaiProcessamento) then Begin
     //FreeAndNil(Ret_SaiProcessamento);
     Ret_SaiProcessamento := Nil;
  End;
  FrmeXactWMS.KsLoadingIndicator1.HideLoading;
end;

procedure TFrmProduto.PositionField;
begin
  EdtCodigo.TabOrder         := 0;
  EdtEndereco.TabOrder       := 1;
  CbRastroTipo.TabOrder      := 2;
  EdtDescricao.TabOrder      := 3;
  EdtFabricanteId.TabOrder   := 4;
  EdtFabricante.TabOrder     := 5;
  RctUnidProd.TabOrder       := 6;
  EdtUnidIdPrim.TabOrder     := 0;
  EdtQtdeUnidPrim.TabOrder   := 1;
  EdtUnidIdSec.TabOrder      := 2;
  EdtFatorConversao.TabOrder := 3;
  EdtAltura.TabOrder         := 7;
  EdtLargura.TabOrder        := 8;
  EdtComprimento.TabOrder    := 9;
  EdtVolume.TabOrder         := 10;
  EdtPeso.TabOrder           := 11;
  SwtLiquido.TabOrder        := 12;
  SwtImportado.TabOrder      := 13;
  SwtInflamavel.TabOrder     := 14;
  SwtPerigoso.TabOrder       := 15;
  SwtMedicamento.TabOrder    := 16;
  SwtSngpc.TabOrder          := 17;
  RctCapPickShelfLife.TabOrder := 18;
  EdtEstoqMin.TabOrder       := 0;
  EdtEstoqMax.TabOrder       := 1;
  EdtValidadeMinEnt.TabOrder := 2;
  EdtValidadeMinSai.TabOrder := 3;
end;

procedure TFrmProduto.ShowProduto;
begin
  if Assigned(ObjProdutoCtrl) then Begin
     //EdtCodigo.Text   := ObjProdutoCtrl.ObjProduto.CodProduto.ToString();
     EdtEndereco.Text         := ObjProdutoCtrl.ObjProduto.Endereco.Descricao;
     CbRastroTipo.ItemIndex   := CbRastroTipo.Items.IndexOf(ObjProdutoCtrl.ObjProduto.Rastro.RastroId.ToString+' '+ObjProdutoCtrl.ObjProduto.Rastro.Descricao);
     EdtDescricao.Text        := ObjProdutoCtrl.ObjProduto.Descricao;
     EdtFabricanteId.Text     := ObjProdutoCtrl.ObjProduto.Laboratorio.IdLaboratorio.ToString();
     EdtFabricante.Text       := ObjProdutoCtrl.ObjProduto.Laboratorio.NOme;
     EdtUnidIdPrim.Text       := ObjProdutoCtrl.ObjProduto.Unid.Id.ToString();
     LblUnidPrimaria.Text     := ObjProdutoCtrl.Objproduto.Unid.Descricao;
     EdtQtdeUnidPrim.Text     := ObjProdutoCtrl.ObjProduto.QtdUnid.toString();
     EdtUnidIdSec.Text        := ObjProdutoCtrl.ObjProduto.UnidSecundaria.Id.ToString();
     LblUnidSecundaria.Text   := ObjProdutoCtrl.ObjProduto.UnidSecundaria.Descricao;
     EdtFatorConversao.Text   := ObjProdutoCtrl.ObjProduto.FatorConversao.ToString();
     EdtAltura.Text           := ObjProdutoCtrl.ObjProduto.Altura.ToString();
     EdtLargura.Text          := ObjProdutoCtrl.ObjProduto.Largura.ToString();
     EdtComprimento.Text      := ObjProdutoCtrl.ObjProduto.Comprimento.ToString();
     EdtVolume.Text           := ObjProdutoCtrl.ObjProduto.Volume.ToString();
     EdtPeso.Text             := ObjProdutoCtrl.ObjProduto.Peso.ToString();
     SwtLiquido.IsChecked     := ObjProdutoCtrl.ObjProduto.Liquido;
     SwtImportado.IsChecked   := ObjProdutoCtrl.ObjProduto.Importado;
     SwtInflamavel.IsChecked  := ObjProdutoCtrl.ObjProduto.Inflamavel;
     SwtPerigoso.IsChecked    := ObjProdutoCtrl.ObjProduto.Perigoso;
     SwtMedicamento.IsChecked := ObjProdutoCtrl.ObjProduto.Medicamento;
     SwtSngpc.IsChecked       := ObjProdutoCtrl.ObjProduto.SNGPC;
//     EdtEstoqMin.Text         := 0;//ObjProdutoCtrl.ObjProduto.MaxPicking.ToString();
     EdtEstoqMax.Text         := ObjProdutoCtrl.ObjProduto.MaxPicking.ToString();
     EdtValidadeMinSai.Text   := ObjProdutoCtrl.ObjProduto.MesEntradaMinima.ToString();
     EdtValidadeMinEnt.Text   := ObjProdutoCtrl.ObjProduto.MesSaidaMinima.ToString();
     DelayedSetFocus(EdtEndereco);
  End;
end;

procedure TFrmProduto.ValidarBeepProduto;
begin
  if EdtCodigo.Text = '' then Exit;
     GetProduto;
end;

end.

