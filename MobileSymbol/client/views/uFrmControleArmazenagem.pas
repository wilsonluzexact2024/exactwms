unit uFrmControleArmazenagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, FMX.ListView.Types, FMX.ListView.Appearances, DataSet.Serialize,
  FMX.ListView.Adapters.Base, System.Rtti, FMX.Grid.Style, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope,
  FMX.ActnList, System.Actions, FMX.TabControl, FMX.Edit, FMX.ScrollBox,
  System.JSON, REST.Json, Rest.Types, FMX.Grid, FMX.ListView, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, Generics.Collections, FMX.ListBox
  , EnderecoClass, EnderecoCtrl, ProdutoCtrl
  , EstoqueClass, EstoqueCtrl, FMX.Ani, FMX.Effects, ksTypes,
  ksLoadingIndicator, FMX.Media, FMX.Filter.Effects, FMX.DialogService
  ;

type
  TTipoMovimentacao  = (poNenhum, poAbastecimentoPicking, poPulmao, poRetidadaStage, poSegregado);

  TFrmControleArmazenagem = class(TFrmBase)
    LytMovimentacao: TLayout;
    LytMovimentacaoDigitacao: TLayout;
    RctOrigem: TRectangle;
    RctDestino: TRectangle;
    EdtEnderecoOrigem: TEdit;
    Line5: TLine;
    LblEdtOrigem: TLabel;
    LblZonaOrigem: TLabel;
    LblEnderecoOrigem: TLabel;
    EdtProduto: TEdit;
    Line1: TLine;
    Label6: TLabel;
    LblProdutoPicking: TLabel;
    LblProdutoOrigem: TLabel;
    Label7: TLabel;
    LblEstoqueOrigem: TLabel;
    CbLote: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    LblVencimento: TLabel;
    EdtQtdMovimentacao: TEdit;
    Line2: TLine;
    Label10: TLabel;
    Label11: TLabel;
    EdtEstoqueLoteDisponivel: TEdit;
    Line3: TLine;
    LblEdtDestino: TLabel;
    EdtEnderecoDestino: TEdit;
    Line4: TLine;
    LblZonaDestino: TLabel;
    LblDestino: TLabel;
    FdMemEstoqueDestino: TFDMemTable;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    StringField2: TStringField;
    IntegerField6: TIntegerField;
    IntegerField7: TIntegerField;
    StringField3: TStringField;
    StringField4: TStringField;
    IntegerField8: TIntegerField;
    IntegerField9: TIntegerField;
    IntegerField10: TIntegerField;
    IntegerField11: TIntegerField;
    StringField5: TStringField;
    DateField2: TDateField;
    DateField3: TDateField;
    IntegerField12: TIntegerField;
    StringField6: TStringField;
    IntegerField13: TIntegerField;
    StringField7: TStringField;
    IntegerField14: TIntegerField;
    IntegerField15: TIntegerField;
    IntegerField16: TIntegerField;
    StringField8: TStringField;
    IntegerField17: TIntegerField;
    IntegerField18: TIntegerField;
    IntegerField19: TIntegerField;
    IntegerField20: TIntegerField;
    StringField9: TStringField;
    IntegerField21: TIntegerField;
    IntegerField22: TIntegerField;
    DateField4: TDateField;
    TimeField1: TTimeField;
    DateTimeField1: TDateTimeField;
    IntegerField23: TIntegerField;
    IntegerField24: TIntegerField;
    FdMemEstoqueOrigem: TFDMemTable;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    FdMemEstoqueOrigemUnidadeId: TIntegerField;
    FdMemEstoqueOrigemUnidadeSecundariaId: TIntegerField;
    FdMemEstoqueOrigemEmbPrim: TStringField;
    FdMemEstoqueOrigemEmbSec: TStringField;
    FdMemEstoqueOrigemQtdUnid: TIntegerField;
    FdMemEstoqueOrigemFatorConversao: TIntegerField;
    FdMemEstoqueOrigemMesSaidaMinima: TIntegerField;
    IntegerField3: TIntegerField;
    FdMemEstoqueOrigemDescrLote: TStringField;
    FdMemEstoqueOrigemFabricacao: TDateField;
    DateField1: TDateField;
    FdMemEstoqueOrigemEnderecoId: TIntegerField;
    FdMemEstoqueOrigemEndereco: TStringField;
    FdMemEstoqueOrigemEstruturaId: TIntegerField;
    FdMemEstoqueOrigemEstrutura: TStringField;
    FdMemEstoqueOrigemPickingFixo: TIntegerField;
    FdMemEstoqueOrigemStatus: TIntegerField;
    FdMemEstoqueOrigemZonaId: TIntegerField;
    FdMemEstoqueOrigemZona: TStringField;
    FdMemEstoqueOrigemQtdeProducao: TIntegerField;
    FdMemEstoqueOrigemQtdeReserva: TIntegerField;
    FdMemEstoqueOrigemQtde: TIntegerField;
    FdMemEstoqueOrigemEstoqueTipoId: TIntegerField;
    FdMemEstoqueOrigemEstoqueTipo: TStringField;
    FdMemEstoqueOrigemProducao: TIntegerField;
    FdMemEstoqueOrigemDistribuicao: TIntegerField;
    FdMemEstoqueOrigemDtEntrada: TDateField;
    FdMemEstoqueOrigemHrEntrada: TTimeField;
    FdMemEstoqueOrigemHorario: TDateTimeField;
    FdMemEstoqueOrigemUsuarioId: TIntegerField;
    FdMemEstoqueOrigemOrdem: TIntegerField;
    ActFuncoes: TActionList;
    ActConfirmarMovimentacao: TAction;
    ActCancelarMovimentacao: TAction;
    RctMens: TRectangle;
    LblConfMens: TLabel;
    LblMens1: TLabel;
    LblMens2: TLabel;
    LblMens3: TLabel;
    LblMens4: TLabel;
    LblMens5: TLabel;
    ShadowEffect1: TShadowEffect;
    RctFootMens: TRectangle;
    FloatAnimation2: TFloatAnimation;
    SbConfirmarMov: TSpeedButton;
    Rectangle1: TRectangle;
    Label12: TLabel;
    SbCancelarMov: TSpeedButton;
    Rectangle2: TRectangle;
    Label13: TLabel;
    Layout3: TLayout;
    TabOptionMovimentacao: TTabItem;
    RctOptionMovimentacao: TRectangle;
    SbSegregado: TSpeedButton;
    RctSegregado: TRectangle;
    Label4: TLabel;
    Path2: TPath;
    SbAbastecerPicking: TSpeedButton;
    RctAbastacerPicking: TRectangle;
    PthAbPicking: TPath;
    Label1: TLabel;
    SbMovimentarPulmao: TSpeedButton;
    RctMovimentarPulmao: TRectangle;
    Label2: TLabel;
    PrhPulmao: TPath;
    RctTitleMovimentacao: TRectangle;
    Label5: TLabel;
    LblTipoMovimentacao: TLabel;
    ChgTabOptionMovimetancao: TChangeTabAction;
    LytMainMenuOptionMovimentacao: TLayout;
    Layout1: TLayout;
    SbRestiradaStage: TSpeedButton;
    RctRetiradaStage: TRectangle;
    Label3: TLabel;
    Path1: TPath;
    Layout2: TLayout;
    RctAlertaDivergenciaEndDestino: TRectangle;
    Label14: TLabel;
    LblEstoqueDescr: TLabel;
    EdtDestinoConfirma: TEdit;
    Line6: TLine;
    LblDestinoConfirma: TLabel;
    Button1: TButton;
    CbMotivoSegregado: TComboBox;
    Label42: TLabel;
    RctMotivoSegregado: TRectangle;
    FDMemEnderecoMovimentacao: TFDMemTable;
    FDMemEnderecoMovimentacaoEnderecoId: TIntegerField;
    FDMemEnderecoMovimentacaoDescricao: TStringField;
    FDMemEnderecoMovimentacaoZonaId: TIntegerField;
    FDMemSegregadoCausa: TFDMemTable;
    FDMemSegregadoCausaSegregadoCausaId: TIntegerField;
    FDMemSegregadoCausaDescricao: TStringField;
    procedure SbAbastecerPickingClick(Sender: TObject);
    procedure EdtProdutoKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtEnderecoOrigemTyping(Sender: TObject);
    procedure EdtProdutoTyping(Sender: TObject);
    procedure CbLoteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtQtdMovimentacaoExit(Sender: TObject);
    procedure EdtProdutoExit(Sender: TObject);
    procedure EdtEnderecoOrigemKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtProdutoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtQtdMovimentacaoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure CbLoteKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure EdtEnderecoDestinoKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure SbCancelarMovClick(Sender: TObject);
    procedure ActCancelarMovimentacaoExecute(Sender: TObject);
    procedure SbConfirmarMovClick(Sender: TObject);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure RctAlertaDivergenciaEndDestinoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure EdtEnderecoOrigemValidate(Sender: TObject; var Text: string);
    procedure EdtDestinoConfirmaValidate(Sender: TObject; var Text: string);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }

    ObjEnderecoCtrl, ObjEnderecoDestinoCtrl : TEnderecoCtrl;
    ObjProdutoCtrl: tProdutoCtrl;
    TipoMovimentacao : TTipoMovimentacao;
    vZonaOrigem : Integer;
    Procedure DefinirLabelTipoMovimentacao;
    Procedure ClearMovimentacao(Sender : TObject);
    Function GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId,
                         pProducao, pDistribuicao: Integer; Sender : TObject) : Boolean;
    Procedure ConfirmarMovimentacao(pOrigem, pDestino : String);
    Procedure AtivarEdits(pOnOff : Boolean);
    Function GetProduto : Boolean;
    function ValidarMovimentacao(Sender: TObject): Boolean;
    Function VerificarLoteFIFOparaPicking : Boolean;
  Protected
    Procedure AtivaCampoDefault; OverRide;
  public
    { Public declarations }
  end;

var
  FrmControleArmazenagem: TFrmControleArmazenagem;

implementation

{$R *.fmx}

uses uFuncoes, Notificacao, uFrmeXactWMS, uMyTabOrderClassHelper;

procedure TFrmControleArmazenagem.ActCancelarMovimentacaoExecute(Sender: TObject);
begin
  inherited;
  FloatAnimation2.StartValue := (Self.Height / 2) - (RctMens.Height /2);
  FloatAnimation2.StopValue  := -RctMens.Height;
  FloatAnimation2.Start;
  ClearMovimentacao(EdtEnderecoDestino);
end;

procedure TFrmControleArmazenagem.AtivaCampoDefault;
begin
  inherited;
  if CampoDefault = 'EdtEnderecoOrigem' then Begin
     EdtEnderecoOrigem.Text := '';
     DelayEdSetFocus(EdtEnderecoOrigem);
  End
  Else if CampoDefault = 'EdtEnderecoDestino' then Begin
     EdtEnderecoDestino.Text := '';
     DelayEdSetFocus(EdtEnderecoDestino);
  End
  Else if CampoDefault = 'EdtProduto' then Begin
     EdtProduto.Text := '';
     DelayEdSetFocus(EdtProduto);
  End
  Else if CampoDefault = 'EdtQtdMovimentacao' then Begin
     EdtQtdMovimentacao.Text := '';
     DelayEdSetFocus(EdtQtdMovimentacao);
  End
  Else if CampoDefault = 'EdtDestinoConfirma' then Begin
     EdtDestinoConfirma.Text := '';
     DelayEdSetFocus(EdtDestinoConfirma);
  End
  Else if CampoDefault = 'CbLote' then Begin
     CbLote.ItemIndex := -1;
     DelayEdSetFocus(CbLote);
  End
end;

procedure TFrmControleArmazenagem.AtivarEdits(pOnOff : Boolean);
begin
  RctDestino.Enabled := pOnOff;
  EdtEnderecoOrigem.Enabled  := True;
  EdtProduto.Enabled         := True;
  //CbLote.Enabled             := pOnOff;
  EdtQtdMovimentacao.Enabled := pOnOff;
  EdtEnderecoDestino.Enabled := pOnOff;
end;

procedure TFrmControleArmazenagem.Button1Click(Sender: TObject);
begin
  inherited;
  ConfirmarMovimentacao(EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True),
                        EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True) );
end;

procedure TFrmControleArmazenagem.CbLoteChange(Sender: TObject);
begin
  inherited;
  EdtQtdMovimentacao.Text := '';
  EdtEnderecoDestino.Text := '';
  if CbLote.ItemIndex < 0 then Exit;
  If FdMemEstoqueOrigem.Locate('ProdutoId;DescrLote', VarArrayOf([ObjProdutoCtrl.ObjProduto.IdProduto, CbLote.Items.Strings[CbLote.ItemIndex]]), []) then Begin
     LblVencimento.Text := FdMemEstoqueOrigem.FieldByName('Vencimento').AsString;
     EdtEstoqueLoteDisponivel.Text := FdMemEstoqueOrigem.FieldByName('Qtde').AsString;
  End
  Else Begin
     SetCampoDefault('CbLote');
     ShowErro('Lote n�o encontrado');
  End;
end;

procedure TFrmControleArmazenagem.CbLoteKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if key = vkReturn then
     DelayedSetFocus(EdtQtdMovimentacao);
end;

procedure TFrmControleArmazenagem.ClearMovimentacao(Sender: TObject);
begin
  //RctMens.Visible := False;
  if Not (Sender = EdtEnderecoOrigem) then Begin
     If TipoMovimentacao <> poRetidadaStage then// poAbastecimentoPicking then
        EdtEnderecoOrigem.Text := ''

     Else
        DelayEdSetFocus(EdtEnderecoOrigem);
     If (LytMovimentacao.Visible) then Begin
        case TipoMovimentacao of
           poAbastecimentoPicking, poPulmao: DelayedSetFocus(EdtEnderecoOrigem);
           poRetidadaStage: DelayedSetFocus(EdtProduto);
        end;
     End;
  End;
  //RctDestino.Enabled := Not (Sender = EdtEnderecoOrigem) or (Sender= EdtProduto);
  AtivarEdits(Not (Sender = EdtEnderecoOrigem) or (Sender= EdtProduto));
  LblEnderecoOrigem.Text := '';
  LblZonaOrigem.Text     := '';
  LblDestino.Text        := '';
  LblZonaDestino.Text    := '';
  LblEstoqueOrigem.Text  := '';
  LblEstoqueDescr.Text   := '';
  LblVencimento.Text     := '';
  LblProdutoOrigem.Text  := '';
  LblProdutoPicking.Text := '';
  EdtProduto.Text        := '';
  CbLote.Items.Clear;
  EdtQtdMovimentacao.Text := '';
  EdtEnderecoDestino.Text := '';
  EdtDestinoConfirma.Text := '';
  EdtEstoqueLoteDisponivel.Text := '';
  if (FdMemEstoqueOrigem.Active) then Begin
     FdMemEstoqueOrigem.EmptyDataSet;
     FdMemEstoqueOrigem.Close;
  End;
  if (FdMemEstoqueDestino.Active) then Begin
     FdMemEstoqueDestino.EmptyDataSet;
     FdMemEstoqueDestino.Close;
  End;
  //RctDestino.Enabled :=
  AtivarEdits(False);
end;

Procedure TFrmControleArmazenagem.ConfirmarMovimentacao(pOrigem, pDestino : String);
begin
  RctMens.Visible      := True;
  if TipoMovimentacao = poAbastecimentoPicking then
     LblMens1.Text   := 'Opera��o: Ressuprir Picking'
  Else if TipoMovimentacao = poPulmao then
     LblMens1.Text   := 'Opera��o: Retirada do Pulm�o'
  Else if TipoMovimentacao = poRetidadaStage then
     LblMens1.Text   := 'Opera��o: Retirada da State'
  Else if TipoMovimentacao = poSegregado then
     LblMens1.Text   := 'Opera��o: Movimentar Segregado';
  LblMens2.Text      := 'Produto: '+LblProdutoOrigem.Text;
  LblMens3.Text      := 'Lote: '+CbLote.Items.Strings[CbLote.ItemIndex]+'  Vencto: '+LblVencimento.Text;
  LblMens4.Text      := 'De: '+pOrigem+'   Para: '+pDestino;
  LblMens5.Text      := 'Quantidade: '+EdtQtdMovimentacao.Text;
  RctMens.Visible := True;
  With FloatAnimation2 do Begin
    StartValue := -RctMens.Height;
    StopValue := (Self.Height /2) - (RctMens.Height/2);
    Start;
  End;
end;
procedure TFrmControleArmazenagem.DefinirLabelTipoMovimentacao;
Var LstEndereco : TObjectList<TEndereco>;
begin
  ClearMovimentacao(EdtEnderecoOrigem);
  LytMovimentacao.Visible    := True;
  EdtEnderecoOrigem.Enabled  := True;
  EdtEnderecoOrigem.Enabled  := True;
  RctMotivoSegregado.Visible := False;
  case TipoMovimentacao of
    poNenhum: Begin
       LblTipoMovimentacao.Text := '...';
       LytMovimentacao.Visible := False;
       DelayEdSetFocus(EdtEnderecoOrigem);
    End;
    poAbastecimentoPicking: Begin
      LblTipoMovimentacao.Text := 'Reabastecendo Picking';
      LblEdtOrigem.Text  := 'Picking Destino';
      LblEdtDestino.Text := 'Pulm�o Origem';
      DelayedSetFocus(EdtEnderecoOrigem);
    end;
    poPulmao: Begin
      LblTipoMovimentacao.Text := 'Movimentando Estoque';
      LblEdtOrigem.Text := 'Origem';
      LblEdtDestino.Text := 'Destino';
      DelayedSetFocus(EdtEnderecoOrigem);
    End;

    poRetidadaStage: Begin
      LblTipoMovimentacao.Text := 'Retirando da Stage';
      LblEdtOrigem.Text  := 'Stage - Origem';
      LblEdtDestino.Text := 'Destino';
      //EdtEnderecoOrigem.Enabled := False;
(*
       LstEndereco := ObjEnderecoCtrl.GetEndereco(0, 0, 1, 0, '', '', 'T', 2, 1);
       if LstEndereco.Count = 1 then Begin
          ObjEnderecoCtrl.ObjEndereco := LstEndereco[0];//   ObjEnderecoCtrl.GetEndereco(0, 0, 1, 0, '', '', 'T', 0)[0];
          DelayedSetFocus(EdtProduto);
          EdtEnderecoOrigem.Text      := LstEndereco[0].Descricao;
          //Ver como acionar o evento OnValidate

          //EdtEnderecoOrigemExit(EdtEnderecoOrigem);
          //GetEstoque(0, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 1, 1, EdtEnderecoOrigem);
          if FdMemEstoqueOrigem.IsEmpty then Begin
             SetCampoDefault('EdtEnderecoOrigem');
             ShowErro('N�o h� estoque dispon�vel na Stage.');
             Exit;
          End;
          EdtEnderecoOrigem.Enabled   := False;
          //DelayedSetFocus(EdtProduto);
       End
       Else
*)        DelayedSetFocus(EdtEnderecoOrigem);

    End;
    poSegregado: Begin
      LblTipoMovimentacao.Text := 'Estoque Segregaddo';
      LblEdtOrigem.Text := 'Endere�o Origem';
      LblEdtDestino.Text := 'Destino';
      DelayedSetFocus(EdtEnderecoOrigem);
      RctMotivoSegregado.Visible := True;
    End;
  end;
  EdtDestinoConfirma.Visible := TipoMovimentacao = poAbastecimentoPicking;
  LblDestinoConfirma.Visible := TipoMovimentacao = poAbastecimentoPicking;
end;

procedure TFrmControleArmazenagem.EdtDestinoConfirmaValidate(Sender: TObject;
  var Text: string);
Var vOrigem, vDestino : String;
begin
  inherited;
  Try
    if EdtDestinoConfirma.Text = '' then Exit;
    if (Text <> EdtEnderecoDestino.Text) then Begin
       SetCampoDefault('EdtDestinoConfirma');
       ShowErro('Endere�o n�o confere com indicado.');
    End
    Else Begin //ValidarMovimentacao(EdtDestinoConfirma);
       ValidarMovimentacao(EdtEnderecoDestino);
       vOrigem  := EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
       vDestino := EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
       ConfirmarMovimentacao(vOrigem, vDestino);
    End;
  Except On E: Exception do Begin
    Text := '';
    SetCampoDefault('EdtDestinoConfirma');
    ShowErro('Erro77: '+E.Message);
    End;
  End;
end;

procedure TFrmControleArmazenagem.EdtEnderecoDestinoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if key = VkReturn then Begin
     if (Sender = EdtEnderecoDestino) then Begin
        if TipoMovimentacao <> poAbastecimentoPicking then
           ValidarMovimentacao(EdtEnderecoDestino);
        Exit;
     End;
     if Sender = EdtDestinoConfirma then Begin
        //Key := 0;
        //KeyChar := #0;
        //DelayedSetFocus(EdtDestinoConfirma);
        //TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     End
     Else Begin
        //Key := 0;
        //KeyChar := #0;
        //DelayedSetFocus(EdtEnderecoOrigem);
        //TControl(Self).SelectNext(TControl(Screen.FocusControl), True);
     End;
  End
  Else if Key = vkEscape then
     ClearMovimentacao(EdtEnderecoDestino);
end;

Function TFrmControleArmazenagem.ValidarMovimentacao(Sender : TObject) : Boolean;
Var vOrigem, vDestino : String;
    vZonaId : Integer;
    ObjEstoqueCtrl   : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro : String;
begin
  inherited;
  Result := False;
  if (EdtEnderecoDestino.Text<>'') then Begin
     //FdMemEstoqueOrigem.First;
     if (TipoMovimentacao = poSegregado) and (CbMotivoSegregado.ItemIndex < 0) then Begin
        SetCampoDefault('EdtEnderecoDestino');
        ShowErro('Informe o motivo da movimenta��o!');
        Exit;
     End;
     if (TipoMovimentacao = poAbastecimentoPicking) and (Not FdMemEstoqueOrigem.Locate('Endereco', EdtEnderecoDestino.Text, [])) then Begin
        SetCampoDefault('EdtEnderecoDestino');
        ShowErro('Endere�o inv�lido! N�o h� estoque dispon�vel para movimenta��o.');
        Exit;
     End;
     if EdtEnderecoDestino.Text = EdtEnderecoOrigem.Text then Begin
        SetCampoDefault('EdtEnderecoDestino');
        ShowErro('N�o � permitido movimentar para o mesmo endere�o.');
        Exit;
     End;
     if ((StrToIntDef(EdtQtdMovimentacao.Text, 0) < 1) or (StrToIntDef(EdtQtdMovimentacao.Text, 0) > StrToIntDef(EdtEstoqueLoteDisponivel.Text, 0))) and
        ((Sender=EdtDestinoConfirma) or (TipoMovimentacao<>poAbastecimentoPicking) ) then Begin
        SetCampoDefault('EdtQtdMovimentacao');
        //ExitFocus(Sender);
        ShowErro('Quantidade inv�lida para Movimenta��o!');
        Exit;
     End;
     vZonaId := 0;
     if (TipoMovimentAcao = poSegregadO) And (vZonaOrigem<>3) then
        vZonaId := 3;
     Try
      // if (Not Assigned(ObjEnderecoDestinoCtrl)) or (Not Assigned(ObjEnderecoDestinoCtrl.ObjEndereco)) or
         // (ObjEnderecoDestinoCtrl = Nil) or (ObjEnderecoDestinoCtrl.ObjEndereco = Nil) then Begin
        //   ShowOk('Criando o objeto Destino');
           ObjEnderecoDestinoCtrl := TEnderecoCtrl.Create;
       //End;
       ObjEnderecoDestinoCtrl.ObjEndereco := ObjEnderecoDestinoCtrl.GetEndereco(0, 0, vZonaId, 0,
                                           EdtEnderecoDestino.Text, EdtEnderecoDestino.Text, 'T', 1)[0];
     Except On E: Exception do Begin
         raise Exception.Create('Erro 44 - '+E.Message);
         End;
     End;
     if (TipoMovimentacao = poPulmao) and (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId  = 2) then Begin
        SetCampoDefault('EdtEnderecoDestino');
        ShowErro('Para Picking, use a op��o de Reabastecer.');
        Exit;
     End;

     if ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId > 0 then With ObjEnderecoDestinoCtrl.ObjEndereco do Begin
        if Status = 0 then Begin
           SetCampoDefault('EdtEnderecoDestino');
           //ExitFocus(Sender);
           ShowErro('Endere�o('+EdtEnderecoDestino.Text+') inativo!');
           Exit;
        End;
        LblDestino.Text := EnderecoMask(Descricao, EnderecoEstrutura.Mascara, True)+
                                     '   Rua: ' + EnderecoRua.Descricao + ' Lado: ' + EnderecoRua.Lado;
        if EnderecamentoZona.ZonaId = 1 then Begin
           LblZonaDestino.Text := 'Zona: Stage(�rea de Espera)';
        End
        Else if EnderecamentoZona.ZonaId = 2 then Begin
           LblZonaDestino.Text := 'Zona: Crossdocking';
        End
        Else if EnderecamentoZona.ZonaId = 3 then Begin
           LblZonaDestino.Text := 'Zona: Segregados';
        End
        Else Begin
           LblZonaDestino.Text := 'Zona: ' + EnderecamentoZona.Descricao;
        End;
     End;
     if TipoMovimentacao <> poAbastecimentoPicking then Begin
        If (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 1) then Begin
           If (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 1) then Begin
              SetCampoDefault('EdtEnderecoDestino');
              ShowErro('N�o � permitido movimentar de um Picking para outro Picking.');
              Exit;
           End
           Else If (ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId = 0) then Begin
              SetCampoDefault('EdtEnderecoDestino');
              ShowErro('Picking inv�lido! Produto n�o est� vinculado a um picking.');
              Exit;
           End
           else If (ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId <> ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId) then Begin
              SetCampoDefault('EdtEnderecoDestino');
              ShowErro('Picking n�o pertence ao produto da movimenta��o.');
              Exit;
           End;

        End;
        //validar Movimenta��o para Pallet no BD
        //Genilson 14Nov23
        If (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 1) and
           (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.ZonaId > 3) Then Begin
           ObjEstoqueCtrl   := TEstoqueCtrl.Create;
           JsonArrayRetorno := ObjEstoqueCtrl.ValidarMovimentacaoPallet(ObjProdutoCtrl.ObjProduto.IdProduto,
                                                                        ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId,
                                                                        CbLote.Items.Strings[CbLote.ItemIndex]);
           if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
              SetCampoDefault('CbLote');
              ShowErro('Aten��o: '+vErro, 'alarme');
              JsonArrayRetorno := Nil;
              ObjEstoqueCtrl.Free;
              Exit;
           End;
           JsonArrayRetorno := Nil;
           ObjEstoqueCtrl.Free;
        End;
{        if ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 0 then Begin
           With FdMemEstoqueDestino do While Not Eof do Begin
             if (FieldByName('ProdutoId').AsInteger = ObjProdutoCtrl.ObjProduto.IdProduto) and
                (FieldByName('LoteId').AsInteger <> FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger) and
                (FieldByName('ZonaId').AsInteger <= 3) then Begin
                SetCampoDefault('EdtEnderecoDestino');
                ShowErro('N�o � permitido lotes diferentes do produto no mesmo Porta Pallet.');
                Exit;
             End;
             Next;
           End;
        End;
}        vOrigem  := EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
        vDestino := EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
     End
     Else begin //Invers�o do Endereco Origem e Destino devido o fato do estoque ser destinado ao picking primeiro endere�o digitado.
        vOrigem  := EnderecoMask(ObjEnderecoDestinoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
        vDestino := EnderecoMask(ObjEnderecoCtrl.ObjEndereco.Descricao, ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.Mascara, True);
     end;
     if (ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo=1) Then Begin
         Result := VerificarLoteFIFOparaPicking;
         if Result = False then
            Exit;
     End;
     if ((TipoMovimentacao = poAbastecimentoPicking) and (Sender = EdtDestinoConfirma)) or
        (TipoMovimentacao <> poAbastecimentoPicking) then
        ConfirmarMovimentacao(vOrigem, vDestino);
     Result := True;
  End;
//  ExitFocus(Sender);
end;

function TFrmControleArmazenagem.VerificarLoteFIFOparaPicking: Boolean;
Var ObjEstoqueCtrl   : TEstoqueCtrl;
    xReturn          : Integer;
    JsonArrayRetorno : TJsonArray;
    vErro            : String;
begin
  Result := True;
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetEstoqueJson(ObjProdutoCtrl.ObjProduto.IdProduto, 0, 0, 0, 1, 1, 'N', 'N', 0);
  if Not JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     for xReturn := 0 to Pred(JsonArrayRetorno.Count) do Begin
       if StrToDate(JsonArrayRetorno.Items[xReturn].GetValue<String>('vencimento')) < FdMemEstoqueOrigem.FieldByName('Vencimento').AsDateTime then Begin
          ClearMovimentacao(EdtEnderecoDestino);
          SetCampoDefault('CbLote');
          ShowErro('Picking exige movimentar o lote com menor vencimento. End: '+JsonArrayRetorno.Items[xReturn].GetValue<String>('endereco')+' Lt: '+JsonArrayRetorno.Items[xReturn].GetValue<String>('descrlote'));
          Result := False;
          Break;
       End;
     End;
  End;
  JsonArrayRetorno := Nil;
  ObjEstoqueCtrl.Free;
end;

procedure TFrmControleArmazenagem.EdtEnderecoOrigemKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if (key = vkReturn) and (EdtEnderecoOrigem.Text<>'') then
     DelayedSetFocus(EdtProduto);
end;

procedure TFrmControleArmazenagem.EdtEnderecoOrigemTyping(Sender: TObject);
begin
  inherited;
  ClearMovimentacao(Sender);
end;

procedure TFrmControleArmazenagem.EdtEnderecoOrigemValidate(Sender: TObject;
  var Text: string);
Var JsonArrayEndereco : TJsonArray;
    vErro, vEndereco  : String;
begin
  inherited;
  if Text = '' then Exit;
  JsonArrayEndereco := ObjEnderecoCtrl.GetEnderecoJson(0, 0, 0, 0, EdtEnderecoOrigem.Text, EdtEnderecoOrigem.Text, 'T', 99, 0);
  if JsonArrayEndereco.Items[0].TryGetValue('Erro', vErro) then Begin
     SetCampoDefault(TEdit(Sender).name);
     Text := '';
     ShowErro(vErro);
     JsonArrayEndereco := Nil;
     Exit;
  End
  Else Begin
     ObjEnderecoCtrl.ObjEndereco  := ObjEnderecoCtrl.ObjEndereco.JsonToClass(JsonArrayEndereco.Items[0].ToString());
     ObjEnderecoCtrl.ObjEndereco.ProdutoId  := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').getValue<Integer>('produtoid');
     ObjEnderecoCtrl.ObjEndereco.CodProduto := JsonArrayEndereco.Items[0].GetValue<TJsonObject>('produto').getValue<Integer>('codproduto');
  End;
  With ObjEnderecoCtrl.ObjEndereco do Begin
    if JsonArrayEndereco.Items[0].GetValue<Integer>('status') = 0 then Begin
       Text := '';
       SetCampoDefault('EdtEnderecoOrigem');
       ShowErro('Endere�o inativo!');
       JsonArrayEndereco := Nil;
       Exit;
    End;
    vZonaOrigem := EnderecamentoZona.ZonaId;
    LblEnderecoOrigem.Text := EnderecoMask(Descricao, EnderecoEstrutura.Mascara, True)+
                              '   Rua: ' + EnderecoRua.Descricao + ' Lado: ' + EnderecoRua.Lado;
    vZonaOrigem := ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId;
    if ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId = 1 then
       LblZonaOrigem.Text := 'Zona: Stage(�rea de Espera)'

    Else if ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId = 2 then
       LblZonaOrigem.Text := 'Zona: Crossdocking'

    Else if ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.ZonaId = 3 then
       LblZonaOrigem.Text := 'Zona: Segregados'
    Else
       LblZonaOrigem.Text := 'Zona: ' + EnderecamentoZona.Descricao
  End;
  EdtProduto.Enabled := True;
  if ((TipoMovimentacao = poAbastecimentoPicking) or (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2)) Then Begin
     If (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId <> 2) then Begin
        vEndereco := EdtEnderecoOrigem.Text;
        Text := '';
        SetCampoDefault('EdtEnderecoOrigem');
        ClearMovimentacao(EdtEnderecoOrigem);
        ShowErro('Endere�o('+EdtEnderecoOrigem.Text+') inv�lido! Informe um endere�o de Picking!');
        JsonArrayEndereco := Nil;
        Exit;
     End;
     if ObjEnderecoCtrl.ObjEndereco.ProdutoId = 0 then Begin
        vEndereco := EdtEnderecoOrigem.Text;
        Text := '';
        ClearMovimentacao(EdtEnderecoOrigem);
        SetCampoDefault('EdtEnderecoOgigem');
        ShowErro('N�o h� produto vinculado a este endere�o('+EdtEnderecoOrigem.Text+').');
        JsonArrayEndereco := NIl;
        Exit;
     End;
     //GetEstoque(0, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 2, 0, EdtEnderecoOrigem);
     EdtProduto.Text    := ObjEnderecoCtrl.ObjEndereco.CodProduto.ToString;
     //EdtProdutoExit(EdtProduto);
     If GetProduto then Begin
        EdtProduto.Enabled := False;
        if CbLote.Enabled then
           DelayedSetFocus(CbLote);
     End
     Else Begin
       Text := '';
       DelayEdSetFocus(EdtEnderecoOrigem);
       JsonArrayEndereco := Nil;
       exit;
     End;
  End
  Else if (Sender <> EdtEnderecoOrigem) or (TipoMovimentacao <> poRetidadaStage) then   //Evitar Buscar Estoque
     GetEstoque(0, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 2, 2, EdtEnderecoOrigem);
  if (TipoMovimentacao = poAbastecimentoPicking) then
     DelayedSetFocus(EdtQtdMovimentacao)
  Else Begin
     if (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2) then
        DelayEdSetFocus(EdtQtdMovimentacao)
     Else
        DelayEdSetFocus(EdtProduto);
  End;
  JsonArrayEndereco := Nil;
//  ExitFocus(Sender);
end;

procedure TFrmControleArmazenagem.EdtProdutoExit(Sender: TObject);
begin
  inherited;
  if EdtProduto.Text = '' then Exit;
  if (StrToInt64Def(EdtProduto.Text, 0)) = 0 then Begin
     SetCampoDefault('EdtProduto');
     ShowErro('C�digo inv�lido!');
     Exit;
  End;
  if EdtEnderecoOrigem.Text = '' then Begin
     SetCampoDefault('EdtProduto');
     ShowErro('Informe o Endere�o de Origem!');
     Exit;
  End;
  GetProduto;
end;

procedure TFrmControleArmazenagem.EdtProdutoKeyDown(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  SoNumeros(KeyChar);
end;

procedure TFrmControleArmazenagem.EdtProdutoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if key = vkReturn then
     TControl(Self).SelectNext(TControl(Screen.FocusControl), True); //EdtProdutoExit(EdtProduto);
end;

procedure TFrmControleArmazenagem.EdtProdutoTyping(Sender: TObject);
begin
  inherited;
  LblDestino.Text        := '';
  LblZonaDestino.Text    := '';
  if TipoMovimentacao <> poAbastecimentoPicking then Begin
     LblEstoqueOrigem.Text := '';
     LblEstoqueDescr.Text  := '';
  End;
  LblVencimento.Text     := '';
  LblProdutoOrigem.Text  := '';
  LblProdutoPicking.Text := '';
  CbLote.Items.Clear;
  EdtQtdMovimentacao.Text := '';
  EdtEnderecoDestino.Text := '';
  EdtEstoqueLoteDisponivel.Text := '';
end;

procedure TFrmControleArmazenagem.EdtQtdMovimentacaoExit(Sender: TObject);
begin
  inherited;
  if EdtQtdMovimentacao.Text = '' then Exit;
  if StrToIntDef(EdtQtdMovimentacao.Text, 0) < 0 then Begin
     SetCampoDefault('EdtQtdMovimentacao');
     ShowErro('Quantidade('+EdtQtdMovimentacao.Text+') inv�lida para movimenta��o.');
     EdtQtdMovimentacao.Text := '';
  End
  Else if StrToIntDef(EdtQtdMovimentacao.Text, 0) > StrToIntDef(EdtEstoqueLoteDisponivel.Text, 0) then Begin
     SetCampoDefault('EdtQtdMovimentacao');
     ShowErro('Quantidade('+EdtQtdMovimentacao.Text+') inv�lida, maior que estoque dispon�vel.');
     EdtQtdMovimentacao.Text := '';
  End
  Else If StrToIntDef(EdtQtdMovimentacao.Text, 0)> 0 then Begin
     if Not EdtEnderecoDestino.Enabled then
        if TipoMovimentacao = poAbastecimentoPicking then
           DelayEdSetFocus(EdtDestinoConfirma)
        Else ValidarMovimentacao(EdtEnderecoDestino);
  End;
end;

procedure TFrmControleArmazenagem.EdtQtdMovimentacaoKeyUp(Sender: TObject;
  var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if key = vkReturn then Begin
     if EdtEnderecoDestino.Enabled then
        DelayedSetFocus(EdtEnderecoDestino)
     Else If StrToIntDef(EdtQtdMovimentacao.Text, 0) > 0 then
        EdtQtdMovimentacaoExit(EdtQtdMovimentacao);
  End;
end;

procedure TFrmControleArmazenagem.FloatAnimation2Finish(Sender: TObject);
begin
  inherited;
  RctMens.Visible := (FloatAnimation2.StartValue = -RctMens.Height);
  RctMens.Visible := RctMens.Visible;
end;

procedure TFrmControleArmazenagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FrmControleArmazenagem := Nil;
end;

procedure TFrmControleArmazenagem.FormCreate(Sender: TObject);
Var ObjEstoqueCtrl  : TEstoqueCtrl;
    JsonArrayRetorno : TJsonArray;
    vErro   : String;
    xMotivo : Integer;
begin
  inherited;
  LytMovimentacao.Visible := False;
  ObjEnderecoCtrl         := TEnderecoCtrl.Create();
  //ObjEnderecoDestinoCtrl  := TEnderecoCtrl.Create();
  ObjProdutoCtrl          := tProdutoCtrl.Create();
  AtivarEdits(False);
  RctMens.Visible         := False;
  PgcPrincipal.ActiveTab  := TabOptionMovimentacao;
  JsonArrayRetorno := ObjEnderecoCtrl.GetEnderecoPadraoMovimentacao;
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     JsonArrayRetorno := Nil;
     Exit;
  End
  Else Begin
    if (FDMemEnderecoMovimentacao.Active) then
       FDMemEnderecoMovimentacao.EmptyDataSet;
    FDMemEnderecoMovimentacao.Close;
    FDMemEnderecoMovimentacao.loadFromJson(JsonArrayRetorno, False);
    JsonArrayRetorno := Nil;
  End;
  CbMotivoSegregado.Items.Clear;
  ObjEstoqueCtrl  := TEstoqueCtrl.Create;
  JsonArrayRetorno := ObjEstoqueCtrl.GetMotivoMovimentacaoSegregado(1); //Somente Ativos
  if JsonArrayRetorno.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro('Erro: '+vErro);
     JsonArrayRetorno := Nil;
     ObjEstoqueCtrl.Free;
     Exit;
  End
  Else Begin
     if (FDMemSegregadoCausa.Active) then
        FDMemSegregadoCausa.EmptyDataSet;
     FDMemSegregadoCausa.Close;
     FDMemSegregadoCausa.loadFromJson(JsonArrayRetorno, False);
     for xMotivo := 0 to Pred(JsonArrayRetorno.Count) do
       CbMotivoSegregado.Items.Add(JsonArrayRetorno.Items[xmotivo].GetValue<String>('descricao'));
     JsonArrayRetorno := Nil;
     ObjEstoqueCtrl.Free;
  End;
  RctMotivoSegregado.Visible := False;
end;

Procedure TFrmControleArmazenagem.FormDestroy(Sender: TObject);
begin
  ObjProdutoCtrl.DisposeOf;
  ObjEnderecoCtrl.DisposeOf;
  If Assigned(ObjEnderecoDestinoCtrl) then
     ObjEnderecoDestinoCtrl.DisposeOf;
  inherited;
end;

Function TFrmControleArmazenagem.GetEstoque(pProdutoId, pLoteId, pEnderecoId,
  pEstoqueTipoId, pProducao, pDistribuicao: Integer; Sender: TObject) : Boolean;
Var ObjEstoqueCtrl : TEstoqueCtrl;
    xReturn        : Integer;
    LstEstoque     : TObjectList<TEstoque>;
    vEstoque       : Integer;
    JsonArrayEstoque : TJsonArray;
    vErro : String;
begin
Try
  Result := False;
  ObjEstoqueCtrl := TEstoqueCtrl.Create;
  if (Sender=EdtEnderecoOrigem) or (Sender=CbLote) or (Sender=CbLote)then
     if (TipoMovimentacao = poAbastecimentoPicking) then
        LstEstoque   := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'S', 'S', 0)
     Else Begin
        //LstEstoque := TObjectList<TEstoque>.Create;
        LstEstoque   := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'N', 'N', 0);
        //JsonArrayEstoque := ObjEstoqueCtrl.GetEstoqueJson(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'N', 'N', 0);
     End
  Else
     if (TipoMovimentacao = poAbastecimentoPicking) then
        LstEstoque := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'N', 'N', 0)
     Else LstEstoque := ObjEstoqueCtrl.GetEstoque(pProdutoId, pLoteId, pEnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'S', 'S', 0);
  vEstoque       := 0;
  if (LstEstoque.Count <= 0) and (((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
                                  ((Sender = EdtEnderecoDestino) and (TipoMovimentacao=poAbastecimentoPicking)))then Begin
     if (Sender = EdtEnderecoOrigem) then
        SetCampoDefault('EdtEnderecoOrigem')
     Else
        SetCampoDefault('EdtEnderecoDestino');
     If ((Sender = EdtEnderecoDestino) and (TipoMovimentacao=poAbastecimentoPicking)) then
        ShowErro('N�o h� estoque dispon�vel para o Abastecimento.')
     Else
        ShowErro('N�o h� estoque Dispon�vel para Movimenta��o.');
     result := False;
     Exit;
  End;
  if TipoMovimentacao = poRetidadaStage then Begin
     LblEstoqueOrigem.Text := '0';
     JsonArrayEstoque := ObjEstoqueCtrl.GetEstoqueJson(pProdutoId, 0, ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId, pEstoqueTipoId, pProducao, pDistribuicao, 'N', 'N', 0);
     if Not JsonArrayEstoque.Items[0].TryGetValue('Erro', vErro) then
        LblEstoqueOrigem.Text := FormatFloat('####0', JsonArrayEstoque.Items[0].GetValue<Integer>('qtde'));
     JsonArrayEstoque := Nil;
  End
  Else if ((pProdutoId <> 0) and (TipoMovimentacao <> poAbastecimentoPicking)) or
     ((TipoMovimentacao = poAbastecimentoPicking) and (pProdutoId=0)) then Begin
     For xReturn := 0 To LstEstoque.Count-1 do
       vEstoque := vEstoque + LstEstoque[xReturn].Qtde;
     LblEstoqueOrigem.Text := FormatFloat('0', vEstoque);
  End;
  if ((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
     ((Sender = EdtEnderecoDestino) and (TipoMovimentacao = poAbastecimentoPicking)) then Begin
     if not (FdMemEstoqueOrigem.Active) then
        FdMemEstoqueOrigem.Open;
     FdMemEstoqueOrigem.EmptyDataSet;
     //FdMemEstoqueOrigem.LoadFromJSON(JsonArrayEstoque, False);
     CbLote.Items.Clear;
  End
  Else Begin
     if not (FdMemEstoqueDestino.Active) then
        FdMemEstoqueDestino.Open;
     FdMemEstoqueDestino.EmptyDataSet;
  End;
  CbLote.Enabled             := True;
  EdtEnderecoDestino.Enabled := True;
  if ((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
       ((Sender = EdtEnderecoDestino) and (TipoMovimentacao = poAbastecimentoPicking)) then Begin
     CbLote.Items.Clear;
  End;
  if ((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
       ((Sender = EdtEnderecoDestino) and (TipoMovimentacao = poAbastecimentoPicking)) then
     CbLote.Items.Clear;
  for xReturn := 0 to Pred(LstEstoque.Count) do Begin
    if ((Sender = EdtEnderecoOrigem) and (TipoMovimentacao <> poAbastecimentoPicking)) or
       ((Sender = EdtEnderecoDestino) and (TipoMovimentacao = poAbastecimentoPicking)) then Begin
       FdMemEstoqueOrigem.Append;
       FdMemEstoqueOrigem.FieldByName('ProdutoId').AsInteger      := LstEstoque[xReturn].produtoid;
       FdMemEstoqueOrigem.FieldByName('CodigoERP').AsInteger      := LstEstoque[xReturn].codigoerp;
       FdMemEstoqueOrigem.FieldByName('Produto').AsString         := LstEstoque[xReturn].produto;
       FdMemEstoqueOrigem.FieldByName('Unidadeid').AsInteger      := LstEstoque[xReturn].UnidadeId;
       FdMemEstoqueOrigem.FieldByName('UnidadeSecundariaId').AsInteger := LstEstoque[xReturn].UnidadeSecundariaId;
       FdMemEstoqueOrigem.FieldByName('EmbPrim').AsString         := LstEstoque[xReturn].Embprim;
       FdMemEstoqueOrigem.FieldByName('EmbSec').AsString          := LstEstoque[xReturn].embsec;
       FdMemEstoqueOrigem.FieldByName('QtdUnid').AsInteger        := LstEstoque[xReturn].qtdunid;
       FdMemEstoqueOrigem.FieldByName('FatorConversao').AsInteger := LstEstoque[xReturn].fatorconversao;
       FdMemEstoqueOrigem.FieldByName('MesSaidaMinima').AsInteger := LstEstoque[xReturn].messaidaminima;
       FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger         := LstEstoque[xReturn].loteid;
       FdMemEstoqueOrigem.FieldByName('DescrLote').AsString       := LstEstoque[xReturn].Descrlote;
       FdMemEstoqueOrigem.FieldByName('Fabricacao').AsDateTime    := LstEstoque[xReturn].fabricacao;
       FdMemEstoqueOrigem.FieldByName('Vencimento').AsDateTime    := LstEstoque[xReturn].vencimento;
       FdMemEstoqueOrigem.FieldByName('EnderecoId').AsInteger     := LstEstoque[xReturn].enderecoid;
       FdMemEstoqueOrigem.FieldByName('Endereco').AsString        := LstEstoque[xReturn].endereco;
       FdMemEstoqueOrigem.FieldByName('EstruturaId').AsInteger    := LstEstoque[xReturn].estruturaid;
       FdMemEstoqueOrigem.FieldByName('Estrutura').AsString       := LstEstoque[xReturn].estrutura;
       FdMemEstoqueOrigem.FieldByName('PickingFixo').AsInteger    := LstEstoque[xReturn].pickingfixo;
       FdMemEstoqueOrigem.FieldByName('Status').AsInteger         := LstEstoque[xReturn].status;
       FdMemEstoqueOrigem.FieldByName('ZonaID').AsInteger         := LstEstoque[xReturn].zonaid;
       FdMemEstoqueOrigem.FieldByName('Zona').AsString            := LstEstoque[xReturn].zona;
       FdMemEstoqueOrigem.FieldByName('QtdeProducao').AsInteger   := LstEstoque[xReturn].QtdeProducao;
       FdMemEstoqueOrigem.FieldByName('QtdeReserva').AsInteger    := LstEstoque[xReturn].QtdeReserva;
       FdMemEstoqueOrigem.FieldByName('Qtde').AsInteger           := LstEstoque[xReturn].qtde;
       FdMemEstoqueOrigem.FieldByName('EstoqueTipoId').AsInteger  := LstEstoque[xReturn].EstoqueTipoId;
       FdMemEstoqueOrigem.FieldByName('EstoqueTipo').AsString     := LstEstoque[xReturn].EstoqueTipo;
       FdMemEstoqueOrigem.FieldByName('Producao').AsInteger       := LstEstoque[xReturn].producao;
       FdMemEstoqueOrigem.FieldByName('Distribuicao').AsInteger   := LstEstoque[xReturn].distribuicao;
       FdMemEstoqueOrigem.FieldByName('DtEntrada').AsDateTime     := LstEstoque[xReturn].dtentrada;
       FdMemEstoqueOrigem.FieldByName('HrEntrada').AsDateTime     := LstEstoque[xReturn].HrEntrada;
       FdMemEstoqueOrigem.FieldByName('Horario').AsDateTime       := LstEstoque[xReturn].Horario;
       FdMemEstoqueOrigem.FieldByName('UsuarioId').AsInteger      := LstEstoque[xReturn].UsuarioId;
       FdMemEstoqueOrigem.FieldByName('Ordem').AsInteger          := LstEstoque[xReturn].Ordem;
       FdMemEstoqueOrigem.Post;
       if pProdutoId <> 0 then Begin
          if TipoMovimentacao = poAbastecimentoPicking then Begin
             if FdMemEstoqueOrigem.IsEmpty then Begin
                if (Sender = EdtEnderecoOrigem) then
                   SetCampoDefault('EdtEnderecoOrigem')
                Else
                   SetCampoDefault('EdtEnderecoDestino');
                ShowErro('N�o existe estoque dispon�vel para reabastecer Picking!');
                Exit;
             End;
             CbLote.Items.Clear;
             CbLote.Items.Add(FdmemEstoqueOrigem.FieldByName('DescrLote').AsString);
             if FdMemEstoqueOrigem.RecordCount = 1 then Begin
                CbLote.ItemIndex           := 0;
                CbLoteChange(CbLote);
                EdtEnderecoDestino.Text    := FdMemEstoqueOrigem.FieldByName('Endereco').AsString;
                //EdtEstoqueLoteDisponivel.MaxValue := FdMemEstoqueOrigem.FieldByName('Qtde').AsInteger;
                CbLote.Enabled             := False;
                EdtEnderecoDestino.Enabled := False;
                EdtQtdMovimentacao.Enabled := True;
                DelayedSetFocus(edtQtdMovimentacao);
             End;
             Break;
          End
          Else
             CbLote.Items.Add(LstEstoque[xReturn].Descrlote);
       End;
    End
    Else Begin
       FdMemEstoqueDestino.Append;
       FdMemEstoqueDestino.FieldByName('ProdutoId').AsInteger      := LstEstoque[xReturn].produtoid;
       FdMemEstoqueDestino.FieldByName('CodigoERP').AsInteger      := LstEstoque[xReturn].codigoerp;
       FdMemEstoqueDestino.FieldByName('Produto').AsString         := LstEstoque[xReturn].produto;
       FdMemEstoqueDestino.FieldByName('Unidadeid').AsInteger      := LstEstoque[xReturn].UnidadeId;
       FdMemEstoqueDestino.FieldByName('UnidadeSecundariaId').AsInteger := LstEstoque[xReturn].UnidadeSecundariaId;
       FdMemEstoqueDestino.FieldByName('EmbPrim').AsString         := LstEstoque[xReturn].Embprim;
       FdMemEstoqueDestino.FieldByName('EmbSec').AsString          := LstEstoque[xReturn].embsec;
       FdMemEstoqueDestino.FieldByName('QtdUnid').AsInteger        := LstEstoque[xReturn].qtdunid;
       FdMemEstoqueDestino.FieldByName('FatorConversao').AsInteger := LstEstoque[xReturn].fatorconversao;
       FdMemEstoqueDestino.FieldByName('MesSaidaMinima').AsInteger := LstEstoque[xReturn].messaidaminima;
       FdMemEstoqueDestino.FieldByName('LoteId').AsInteger         := LstEstoque[xReturn].loteid;
       FdMemEstoqueDestino.FieldByName('DescrLote').AsString       := LstEstoque[xReturn].Descrlote;
       FdMemEstoqueDestino.FieldByName('Fabricacao').AsDateTime    := LstEstoque[xReturn].fabricacao;
       FdMemEstoqueDestino.FieldByName('Vencimento').AsDateTime    := LstEstoque[xReturn].vencimento;
       FdMemEstoqueDestino.FieldByName('EnderecoId').AsInteger     := LstEstoque[xReturn].enderecoid;
       FdMemEstoqueDestino.FieldByName('Endereco').AsString        := LstEstoque[xReturn].endereco;
       FdMemEstoqueDestino.FieldByName('EstruturaId').AsInteger    := LstEstoque[xReturn].estruturaid;
       FdMemEstoqueDestino.FieldByName('Estrutura').AsString       := LstEstoque[xReturn].estrutura;
       FdMemEstoqueDestino.FieldByName('PickingFixo').AsInteger    := LstEstoque[xReturn].pickingfixo;
       FdMemEstoqueDestino.FieldByName('Status').AsInteger         := LstEstoque[xReturn].status;
       FdMemEstoqueDestino.FieldByName('ZonaID').AsInteger         := LstEstoque[xReturn].zonaid;
       FdMemEstoqueDestino.FieldByName('Zona').AsString            := LstEstoque[xReturn].zona;
       FdMemEstoqueDestino.FieldByName('QtdeProducao').AsInteger   := LstEstoque[xReturn].QtdeProducao;
       FdMemEstoqueDestino.FieldByName('QtdeReserva').AsInteger    := LstEstoque[xReturn].QtdeReserva;
       FdMemEstoqueDestino.FieldByName('Qtde').AsInteger           := LstEstoque[xReturn].qtde;
       FdMemEstoqueDestino.FieldByName('EstoqueTipoId').AsInteger  := LstEstoque[xReturn].EstoqueTipoId;
       FdMemEstoqueDestino.FieldByName('EstoqueTipo').AsString     := LstEstoque[xReturn].EstoqueTipo;
       FdMemEstoqueDestino.FieldByName('Producao').AsInteger       := LstEstoque[xReturn].producao;
       FdMemEstoqueDestino.FieldByName('Distribuicao').AsInteger   := LstEstoque[xReturn].distribuicao;
       FdMemEstoqueDestino.FieldByName('DtEntrada').AsDateTime     := LstEstoque[xReturn].dtentrada;
       FdMemEstoqueDestino.FieldByName('HrEntrada').AsDateTime     := LstEstoque[xReturn].HrEntrada;
       FdMemEstoqueDestino.FieldByName('Horario').AsDateTime       := LstEstoque[xReturn].Horario;
       FdMemEstoqueDestino.FieldByName('UsuarioId').AsInteger      := LstEstoque[xReturn].UsuarioId;
       FdMemEstoqueDestino.FieldByName('Ordem').AsInteger          := LstEstoque[xReturn].Ordem;
       FdMemEstoqueDestino.IndexFieldNames := 'Vencimento';
       FdMemEstoqueDestino.First;
    End;
//    if ((CbLote.Items.Count = 1) or (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2)) and (Sender=EdtEnderecoOrigem) then Begin
//       CbLote.ItemIndex := 0;
//       DelayedSetFocus(EdtQtdMovimentacao);
//    End;
  End;

    if ((CbLote.Items.Count = 1) or (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2)) and (Sender=EdtEnderecoOrigem) then Begin
        if (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.EstruturaId = 2) then Begin
           if TipoMovimentacao <> poSegregado then Begin
              CbLote.ItemIndex := Pred(CbLote.Items.Count);
              CbLoteChange(CbLote);
              CbLote.Enabled  := False;
           End;
           DelayEdSetFocus(EdtQtdMovimentacao);
        End
        Else begin
          if CbLote.Items.Count = 1 then
             CbLote.ItemIndex := 0
          Else
             CbLote.ItemIndex := -1;
          DelayEdSetFocus(CbLote);
        end;
    End
    Else Begin
       if Not (TipoMovimentacao in [poAbastecimentoPicking]) then Begin
          if (EdtProduto.Text = '') then
             DelayedSetFocus(EdtProduto)
          Else Begin
             if Not ((Sender=EdtEnderecoDestino) and (TipoMovimentacao = poSegregado)) then
                DelayEdSetFocus(CbLote); //EdtProduto.SetFocus
          End;
       End
       Else begin
          DelayedSetFocus(EdtQtdMovimentacao);
          //EdtEnderecoDestino.Text := '';
       end;
    End;

  ObjEstoqueCtrl.DisposeOf;
  Result := True;
  //LstEstoque := Nil;
Except On E: Exception Do begin
  if (Sender = EdtEnderecoOrigem) then
     SetCampoDefault('EdtEnderecoOrigem')
  Else
     SetCampoDefault('EdtEnderecoDestino');
  ShowErro('Erro Estoque: '+E.Message);
  End;
End;
end;

Function TFrmControleArmazenagem.GetProduto : Boolean;
Var vCodProduto : Integer;
    vCodDig     : String;
    vCodErro    : String;
    vErro       : String;
    JsonArrayProduto : TJsonArray;
Begin
  Try
    Result := False;
    vCodErro := '7501';
    vCodProduto := ObjProdutoCtrl.GetCodProdEan(EdtProduto.Text);
    if vCodProduto <> 0 then Begin
       vCodErro := '7502';
       JsonArrayProduto := ObjProdutoCtrl.FindProduto(vCodProduto.ToString, '0', '', 1);
       if JsonArrayProduto.Items[0].TryGetValue('Erro', vErro) then Begin
          SetCampoDefault('EdtProduto');
          JsonArrayProduto := Nil;
          ShowErro(vErro);
          Exit;
       End;
       if ObjProdutoCtrl.ObjProduto.Status = 0 then Begin
          SetCampoDefault('EdtProduto');
          ShowErro('Produto('+vCodProduto.ToString()+') inativo, n�o pode sofrer movimenta��o!');
          JsonArrayProduto := Nil;
          Exit;
       End;
       if (ObjEnderecoCtrl.ObjEndereco.EnderecoEstrutura.PickingFixo = 1) and
          (ObjProdutoCtrl.ObjProduto.Endereco.EnderecoId <> ObjEnderecoCtrl.ObjEndereco.EnderecoId) then Begin
          SetCampoDefault('EdtProduto');
          ShowErro('Produto('+vCodProduto.ToString()+') n�o pertence ao Picking de origem para movimenta��o');
          JsonArrayProduto := Nil;
          Exit;
       End;
       LblProdutoOrigem.Text  := ObjProdutoCtrl.ObjProduto.Descricao;

       LblProdutoPicking.Text := EnderecoMask(ObjProdutoCtrl.ObjProduto.Endereco.Descricao, ObjProdutoCtrl.ObjProduto.Endereco.EnderecoEstrutura.Mascara, True)+ //ObjProdutoCtrl.ObjProduto.Endereco.Descricao +
                                 '     Unid.Prim: ' + ObjProdutoCtrl.ObjProduto.Unid.Descricao + '(' +
                                 ObjProdutoCtrl.ObjProduto.QtdUnid.ToString() + ')' + '    Uni.Sec: ' +
                                 ObjProdutoCtrl.ObjProduto.UnidSecundaria.Descricao + ' C/ ' +
                                 ObjProdutoCtrl.ObjProduto.FatorConversao.ToString();
        if TipoMovimentacao = poAbastecimentoPicking then Begin
           If Not GetEstoque(vCodProduto, 0, 0, 4, 1, 1, EdtEnderecoDestino) Then Begin
              ClearMovimentacao(EdtProduto);
              DelayEdSetFocus(EdtEnderecoOrigem);
              Exit;
           End;
        End
        Else If Not GetEstoque(vCodProduto, 0, ObjEnderecoCtrl.ObjEndereco.EnderecoId, 0, 2, 2, EdtEnderecoOrigem) Then Begin
           ClearMovimentacao(EdtProduto);
           DelayEdSetFocus(EdtEnderecoOrigem);
           Exit;
        End;
       AtivarEdits(True);
       if (CbLote.Items.Count = 1) and (TipoMovimentacao = poAbastecimentoPicking) then
          EdtEnderecoDestino.Enabled := False;
       if CbLote.Items.Count = 1 then
          DelayedSetFocus(EdtQtdMovimentacao)
       Else
          DelayedSetFocus(CbLote);
    End
    Else Begin
       vCodDig := edtProduto.Text;
       SetCampoDefault('Edtproduto');
       JsonArrayProduto := Nil;
       ShowErro('Produto n�o encontrado. Verifique o C�digo/Ean('+vCodDig+').');
       Exit;
    End;
    JsonArrayProduto := Nil;
    Result := True;
  Except On E: Exception do Begin
    DelayEdSetFocus(EdtProduto);
    raise Exception.Create('Erro: '+E.Message);
    End
  End
end;

procedure TFrmControleArmazenagem.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  Label5.Visible := True;
  if TipoMovimentacao = poNenhum then Begin
     PgcPrincipal.ActiveTab := TabOptionMovimentacao;
     Exit;
  End;
  //DefinirLabelTipoMovimentacao;
  if (PgcPrincipal.ActiveTab = TabLista) then Begin
     BtnArrowLeft.Action  := ChgTabOptionMovimetancao;
     BtnArrowRigth.Action := ChgTabDet;
  End
  Else if (PgcPrincipal.ActiveTab = TabDetalhes) then Begin
     BtnArrowLeft.Action  := ChgTabLista;
     ChgTabLista.Tab := TabLista;
     BtnArrowRigth.Action := ChgTabOptionMovimetancao;
     DelayedSetFocus(EdtCodigo);
  End
  Else if (PgcPrincipal.ActiveTab = TabOptionMovimentacao) then Begin
     Label5.Visible := False;
     LblTipoMovimentacao.Text := 'Tipo de Movimenta��o';
     BtnArrowLeft.Action  := ChgTabDet;
     BtnArrowRigth.Action := ChgTabLista;
     ChgTabLista.Tab := TabDetalhes;
  End;
end;

procedure TFrmControleArmazenagem.RctAlertaDivergenciaEndDestinoClick(
  Sender: TObject);
begin
  inherited;
     TThread.CreateAnonymousThread(procedure begin
       TThread.Synchronize(nil, procedure
       begin
         TLoading.ToastMessage(FrmeXactWMS, 'Notifica��o enviada ao Gestor!', TAlignLayout.top, CorToastSucesso);
         FrmeXactWMS.PlaySound('concluido.wav');
         //TLoading.Hide;
         DelayedSetFocus(EdtEnderecoOrigem);
       End);
     end).Start;
end;

procedure TFrmControleArmazenagem.SbAbastecerPickingClick(Sender: TObject);
begin
  inherited;
  Label5.Visible := True;
  ClearMovimentacao(EdtProduto);
  If Sender = SbAbastecerPicking Then
     TipoMovimentacao := poAbastecimentoPicking
  Else If Sender = SbMovimentarPulmao Then
     TipoMovimentacao := poPulmao
  Else If Sender = SbRestiradaStage Then
     TipoMovimentacao := poRetidadaStage
  Else If Sender = SbSegregado Then
     TipoMovimentacao := poSegregado;
  ChgTabDet.Execute;
  DefinirLabelTipoMovimentacao;
end;

procedure TFrmControleArmazenagem.SbCancelarMovClick(Sender: TObject);
begin
  inherited;
  ActCancelarMovimentacaoExecute(Sender);
end;

procedure TFrmControleArmazenagem.SbConfirmarMovClick(Sender: TObject);
Var jsonEstoque,
  jsonKardex,
  jsonEstoqueKardex : tJsonObject;
  JsonArrayEstoque,
  JsonArrayKardex   : tJsonArray;
  ObjEstoqueCtrl    : TEstoqueCtrl;
  Teste, vMotivoSegregado : Integer;
  ObjDestino : TEnderecoCtrl;
  JsonArrayDestino  : TJsonArray;
  vErro : String;
  JsonObjectRetorno : TJsonObject;
begin
  inherited;
  ObjEstoqueCtrl   := TEstoqueCtrl.Create;
  JsonEstoque      := tJsonObject.Create;
  JsonArrayEstoque := tJsonArray.Create;
  JsonArrayKardex  := tJsonArray.Create;
  With jsonEstoque do Begin //Origem
    AddPair('loteid',        TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger));
    AddPair('enderecoid',    TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('EnderecoId').AsInteger));
    AddPair('estoquetipoid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('EstoqueTipoId').AsInteger));
    Addpair('qtde',          TJSONNumber.Create(StrToIntDef(EdtQtdMovimentacao.Text, 0)*-1));
    AddPair('usuarioid',     TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Usuarioid));
    AddPair('nomeestacao',   NomeDoComputador);
    addPair('validarestoqueorigem', TJsonNumber.Create(1));
  End;
  if (TipoMovimentacao = poSegregado) and (FdMemEstoqueOrigem.FieldByName('ZonaId').AsInteger=3) then Begin
     vMotivoSegregado := 0;
     if FDMemSegregadoCausa.Locate('Descricao', CbMotivoSegregado.Items[CbMotivoSegregado.ItemIndex], []) then
        vMotivoSegregado := FDMemSegregadoCausa.FieldByName('segregadocausaid').AsInteger;
     jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(vMotivoSegregado));
     if FdMemEstoqueOrigem.FieldByName('ZonaId').AsInteger = 3 then
        jsonEstoque.AddPair('operacaosegregado', '-')
     Else jsonEstoque.AddPair('operacaosegregado', '+');
  End
  Else Begin
     jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(0));
     jsonEstoque.AddPair('operacaosegregado', '');
  End;
  ObjDestino := TEnderecoCtrl.Create;
  JsonArrayDestino := ObjDestino.GetEnderecoJson(0, 0, 0, 0,
                                 EdtEnderecoDestino.Text, EdtEnderecoDestino.Text, 'T', 2, 0);
  if JsonArrayDestino.Items[0].TryGetValue('Erro', vErro) then Begin
     ShowErro(vErro);
     JsonArrayDestino := Nil;
     ObjDestino.DisposeOf;
     Exit;
  End;
  JsonArrayEstoque.AddElement(jsonEstoque);

  JsonEstoque := tJsonObject.Create;
  With jsonEstoque do Begin //Destino
    AddPair('loteid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger));
    if TipoMovimentacao = poAbastecimentoPicking then Begin
       AddPair('enderecoid', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecoId));
       AddPair('estoquetipoid', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId));
    End
    Else Begin
       AddPair('enderecoid', TJSONNumber.Create( JsonArrayDestino.Items[0].GetValue<Integer>('enderecoid'))); //ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId));
       AddPair('estoquetipoid', TJSONNumber.Create(JsonArrayDestino.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('estoquetipoid'))); //ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId));
    End;
    Addpair('qtde', TJSONNumber.Create(StrToIntDef(EdtQtdMovimentacao.Text, 0)));
    AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Usuarioid));
    AddPair('nomeestacao', NomeDoComputador);
    if (TipoMovimentacao = poSegregado) and
       (JsonArrayDestino.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('zonaid')=3) then Begin
       vMotivoSegregado := 0;
       if FDMemSegregadoCausa.Locate('Descricao', CbMotivoSegregado.Items[CbMotivoSegregado.ItemIndex], []) then
          vMotivoSegregado := FDMemSegregadoCausa.FieldByName('segregadocausaid').AsInteger;
       jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(vMotivoSegregado));
       jsonEstoque.AddPair('operacaosegregado', '+');
    End
    Else Begin
       jsonEstoque.AddPair('motivosegregado',   TJSONNumber.Create(0));
       jsonEstoque.AddPair('operacaosegregado', '');
    End;
  End;
  JsonArrayEstoque.AddElement(jsonEstoque);

  JsonKardex := tJsonObject.Create;
  With jsonKardex do Begin
    AddPair('operacaotipoid', TJSONNumber.Create(8));
    AddPair('loteid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('LoteId').AsInteger));
    if TipoMovimentacao = poAbastecimentoPicking then
       AddPair('enderecoid', TJSONNumber.Create(JsonArrayDestino.Items[0].GetValue<Integer>('enderecoid')))//ObjEnderecoDestinoCtrl.ObjEndereco.EnderecoId))
    Else
       AddPair('enderecoid', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecoId));
    AddPair('estoquetipoid', TJSONNumber.Create(FdMemEstoqueOrigem.FieldByName('EstoqueTipoId').AsInteger));
    if TipoMovimentacao = poAbastecimentoPicking then
       AddPair('estoquetipoiddestino', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId))
    Else
       AddPair('estoquetipoiddestino', TJSONNumber.Create(JsonArrayDestino.Items[0].GetValue<TJsonObject>('enderecamentozona').GetValue<Integer>('estoquetipoid')));//ObjEnderecoDestinoCtrl.ObjEndereco.EnderecamentoZona.EstoqueTipoId));
    Addpair('quantidade', TJSONNumber.Create(StrToIntDef(EdtQtdMovimentacao.Text, 0)));
    if TipoMovimentacao = poAbastecimentoPicking then
       AddPair('enderecoiddestino', TJSONNumber.Create(ObjEnderecoCtrl.ObjEndereco.EnderecoId))
    Else
       AddPair('enderecoiddestino', TJSONNumber.Create(JsonArrayDestino.Items[0].GetValue<Integer>('enderecoid')));
    AddPair('usuarioid', TJSONNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.Usuarioid));
    if TipoMovimentacao = poAbastecimentoPicking then Begin
       AddPair('observacaoorigem',  'Movimenta��o interna '+JsonArrayDestino.Items[0].GetValue<Integer>('enderecoid').ToString+'-->' );
       AddPair('observacaodestino', 'Movimenta��o interna -->'+ObjEnderecoCtrl.ObjEndereco.EnderecoId.ToString );
    End
    Else Begin
       AddPair('observacaoorigem',  'Movimenta��o interna '+ObjEnderecoCtrl.ObjEndereco.EnderecoId.ToString+'-->' );
       AddPair('observacaodestino', 'Movimenta��o interna -->'+JsonArrayDestino.Items[0].GetValue<Integer>('enderecoid').ToString );
    End;
    AddPair('nomeestacao', NomeDoComputador);
  End;
  JsonArrayKardex.AddElement(jsonKardex);
  JsonEstoqueKardex := tJsonObject.create;
  JsonEstoqueKardex.AddPair('estoque', jsonArrayEstoque);
  JsonEstoqueKardex.AddPair('kardex', jsonArraykardex);
  JsonObjectRetorno := ObjEstoqueCtrl.Salvar(jsonEstoqueKardex);
//  FreeAndNil(JsonArrayEstoque);
//   FreeAndNil(JsonKardex);
//  FreeAndNil(ObjEstoqueCtrl);
  ObjDestino.DisposeOf;
  ObjEstoqueCtrl.DisposeOf;
//  JsonEstoque      := Nil;
//  JsonArrayEstoque := Nil;
//  JsonArrayKardex  := Nil;
  JsonEstoqueKardex.DisposeOf;
  FloatAnimation2.StartValue := (Self.Height / 2) - (RctMens.Height /2);
  FloatAnimation2.StopValue  := -RctMens.Height;
  FloatAnimation2.Start;
  ObjEnderecoDestinoCtrl.DisposeOf;
  ClearMovimentacao(EdtEnderecoDestino);
  if JsonObjectRetorno.TryGetValue('Erro', vErro ) then  Begin
     SetCampoDefault('');
     ShowErro('Erro:'+vErro);
  End
  Else
    ShowOk('Movimenta��o realizada!');
  JsonObjectRetorno := Nil;
end;

end.

