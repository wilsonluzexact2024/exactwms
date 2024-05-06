unit uFrmCargaCarregar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmBase, System.Rtti, FMX.Grid.Style, FMX.ListView.Types, System.JSON, REST.Json, Rest.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FireDAC.Stan.Intf, System.Generics.Collections,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, DataSet.Serialize,
  Data.Bind.EngExt, Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.Components, Data.Bind.Grid, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.DBScope, FMX.Gestures,
  FMX.ActnList, System.Actions, FMX.TabControl, FMX.Objects, ksTypes,
  ksLoadingIndicator, FMX.Media, FMX.Effects, FMX.Filter.Effects, FMX.Ani,
  FMX.ListView, FMX.ListBox, FMX.Edit, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Grid, FMX.Layouts, U_MsgD
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
  , CargasCtrl;
type
  TFrmCargaCarregar = class(TFrmBase)
    LblTit02: TLabel;
    LblTit03: TLabel;
    Label1: TLabel;
    EdtDtCarga: TEdit;
    Line1: TLine;
    EdtDestinatario: TEdit;
    Line2: TLine;
    Label2: TLabel;
    EdtRota: TEdit;
    Line3: TLine;
    Label3: TLabel;
    RctDestinatario: TRectangle;
    Rectangle3: TRectangle;
    Label8: TLabel;
    Label11: TLabel;
    LstDestinatario: TListView;
    QryCargaDestinatario: TFDMemTable;
    QryCargaPedido: TFDMemTable;
    Label9: TLabel;
    RctPedidos: TRectangle;
    Rectangle1: TRectangle;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LstPedidos: TListView;
    QryCargaPedidoPedidoid: TIntegerField;
    QryCargaPedidoQtdVolumes: TIntegerField;
    QryCargaPedidoItens: TIntegerField;
    QryCargaPedidoConferido: TIntegerField;
    Label10: TLabel;
    QryCargaDestinatarioCargaId: TIntegerField;
    QryCargaDestinatarioPessoaId: TIntegerField;
    QryCargaDestinatarioCodPessoaERP: TIntegerField;
    QryCargaDestinatarioRazao: TStringField;
    QryCargaDestinatarioOrdem: TIntegerField;
    QryCargaDestinatarioConferido: TIntegerField;
    Label12: TLabel;
    QryCargaVolumes: TFDMemTable;
    IntegerField1: TIntegerField;
    QryCargaVolumesPessoaId: TIntegerField;
    QryCargaVolumesPedidoVolumeId: TIntegerField;
    QryCargaVolumesConferido: TIntegerField;
    ImgLstFdoWhite: TImage;
    QryCargaDestinatarioTotPed: TIntegerField;
    EdtVolumeId: TEdit;
    Line4: TLine;
    TabVolumes: TTabItem;
    LytLegendaCargaVolumes: TLayout;
    RctCargaVolumes: TRectangle;
    RctVolumeConferido: TRectangle;
    LblVolumeConferido: TLabel;
    RctVolumePendente: TRectangle;
    LblVolumePendente: TLabel;
    ChgTabCargaVolumes: TChangeTabAction;
    ActCancelarCarregamento: TAction;
    ActConfirmarCancelamento: TAction;
    FDMemCargaVolumesResumo: TFDMemTable;
    LytVolumes: TLayout;
    RctLegendaVolumes: TRectangle;
    LblLegVolume: TLabel;
    LblLegConferencia: TLabel;
    LblLegEmbalagem: TLabel;
    LstCargaVolumes: TListView;
    LblLegPedido: TLabel;
    ChkDestinatario: TCheckBox;
    ChkPendente: TCheckBox;
    QryCargaDestinatarioFantasia: TStringField;
    procedure BtnSearchPesqClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LstPrincipalItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure EdtCodigoTyping(Sender: TObject);
    procedure EdtCodigoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure BtnCancelClick(Sender: TObject);
    procedure EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure EdtCodigoChange(Sender: TObject);
    procedure PgcPrincipalChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActCancelarCarregamentoExecute(Sender: TObject);
    procedure ActConfirmarCancelamentoExecute(Sender: TObject);
    procedure ChkDestinatarioClick(Sender: TObject);
    procedure LstCargaVolumesItemClick(const Sender: TObject;
      const AItem: TListViewItem);
  private
    ObjCargaCtrl : TCargasCtrl;
    Procedure GetCarga(pCargaId : Integer);
    procedure OpenCarga(pCargaId, pRotaId, pProcessoId: Integer);
    procedure ThreadTerminate(Sender: TObject);
    { Private declarations }
    Function GetListaCarga(pCarga, pRotaId, pProcessoid : Integer) : Boolean;
    Procedure CargaDestinatario;
    Procedure MontaCargaDestinatario;
    Procedure CargaPedido;
    Procedure MontaCargaPedido;
    Procedure AtivarDestinatario;
    Procedure AtualizarDestinatario;
    Function AtualizarConferenciaVolume : Boolean;
    procedure CargaVolumes;
    Procedure InserirVolumeSqlLite;
    Procedure InserirPedidoSqlLite;
    Procedure InserirDestinatarioSqlLite;
    Procedure GetCargaVolumes;
  public
    { Public declarations }
  protected
    Function PesquisarComFiltro(pCampo : Integer; PConteudo : String) : Boolean ; OverRide;
    Procedure GetListaLstCadastro; OverRide;
    Procedure Limpar; OverRide;
    Procedure ShowDados; OverRide;
  end;

var
  FrmCargaCarregar: TFrmCargaCarregar;

implementation

{$R *.fmx}

uses uFuncoes, uFrmeXactWMS, ProcessoCtrl, uDmClient, System.Threading;

procedure TFrmCargaCarregar.ActCancelarCarregamentoExecute(Sender: TObject);
begin
  inherited;
//
end;

procedure TFrmCargaCarregar.ActConfirmarCancelamentoExecute(Sender: TObject);
begin
  inherited;
  if ResultConfirm then Begin
     ObjCargaCtrl.CancelarCarregamento(ObjCargaCtrl.ObjCargas.cargaid);
     GetListaLstCadastro;
  End;
end;

procedure TFrmCargaCarregar.AtivarDestinatario;
begin
  //QryCargaDestinatario.First;
  TThread.Synchronize(TThread.CurrentThread, procedure
    begin
      EdtDestinatario.Text := QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+' - '+QryCargaDestinatario.FieldByName('Fantasia').AsString;
    End);
end;

Function TFrmCargaCarregar.AtualizarConferenciaVolume : Boolean;
var Th: TThread;
    xRegPedido, xRegDestinatario : Integer;
    JsonVolumeCarregamento : TJsonObject;
    vPedidoVolumeId : String;
    vErro           : String;
    vPos1, vPos2    : Integer;
    JsonObjectErro  : TJsonObject;
begin
  Result := False;
  ShowLoading;
//  Th := TThread.CreateAnonymousThread(procedure
//  Var vPos1, vPos2 : Integer;
//  begin
    vPedidoVolumeid := EdtVolumeId.Text;
    if QryCargaVolumes.Locate('PedidoVolumeId', EdtVolumeId.Text, []) then Begin
       if QryCargaVolumes.FieldByName('PessoaId').AsInteger <> QryCargaDestinatario.FieldByName('PessoaId').AsInteger then Begin
          EdtVolumeId.Text := '';
          HideLoading;
          ShowErro('Aten��o: Volume('+vPedidoVolumeId+') n�o pertence ao Destinat�rio('+QryCargaDestinatario.FieldByName('PessoaId').AsString+') do Carregamento!');
          DelayEdSetFocus(EdtVolumeId);
          Exit;
       End
       Else if QryCargaVolumes.FieldByName('Conferido').AsInteger = 1 then Begin
          EdtVolumeId.Text := '';
          HideLoading;
          ShowErro('Aten��o: Volume('+vPedidoVolumeId+') j� conferido"');
          DelayEdSetFocus(EdtVolumeId);
          Exit;
       End;
    End
    Else Begin
       EdtVolumeId.Text := '';
       HideLoading;
       ShowErro('Aten��o: Volume('+vPedidoVolumeId+') n�o pertence a Carga!');
       DelayEdSetFocus(EdtVolumeId);
       Exit;
    End;
    Try
      JsonVolumeCarregamento := TJsonObject.Create();
      JsonVolumeCarregamento.AddPair('cargaid',  TJsonNumber.Create(ObjCargaCtrl.ObjCargas.CargaId));
      JsonVolumeCarregamento.AddPair('pedidovolumeid', TJsonNumber.Create(StrToIntDef(EdtVolumeId.Text, 0)));
      JsonVolumeCarregamento.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWms.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
      JsonVolumeCarregamento.AddPair('terminal', NomeDoComputador);
      JsonVolumeCarregamento.AddPair('processo', 'CA');
      JsonObjectErro := ObjCargaCtrl.RegistrarCarregamento(JsonVolumeCarregamento);
      if JsonObjectErro.TryGetValue('Erro', vErro) then Begin
         ShowErro('Erro: Volumme('+edtVolumeId.text+'). '+vErro);
         Result := False;
         EdtVolumeId.Text := '';
         DelayEdSetFocus(EdtVolumeId);
      End
      Else Begin
         JsonVolumeCarregamento.Free;
         QryCargaVolumes.Edit;
         QryCargaVolumes.FieldByName('Conferido').AsInteger := 1;
         QryCargaVolumes.Post;
         if QryCargaPedido.Locate('PedidoId', QryCargaVolumes.FieldByName('PedidoId').AsInteger, []) then Begin
            QryCargaVolumes.Filter := 'Conferido = 1 and PedidoId = '+QryCargaVolumes.FieldByName('PedidoId').AsString;
            QryCargaVolumes.Filtered := True;
            QryCargaPedido.Edit;
            QryCargaPedido.FieldByName('Conferido').AsInteger := QryCargaVolumes.RecordCount;
            QryCargaPedido.Post;
            QryCargaVolumes.Filter := '';
            QryCargaVolumes.Filtered := False;
            xRegPedido := QryCargaPedido.RecNo;
            MontaCargaPedido;
            QryCargaPedido.RecNo := xRegPedido;
            if QryCargaPedido.FieldByName('Conferido').AsInteger = QryCargaPedido.FieldByName('QtdVolume').AsInteger then Begin
               QryCargaDestinatario.Edit;
               QryCargaDestinatario.FieldByName('Conferido').AsInteger := QryCargaDestinatario.FieldByName('Conferido').AsInteger + 1;
               QryCargaDestinatario.Post;
               xRegDestinatario := QryCargaDestinatario.RecNo;
               MontaCargaDestinatario;
               QryCargaDestinatario.RecNo := xRegDestinatario;
               vPos1 := QryCargaDestinatario.FieldByName('TotPed').AsInteger;
               vPos2 := QryCargaDestinatario.FieldByName('Conferido').AsInteger;
               if QryCargaDestinatario.FieldByName('Conferido').AsInteger >= QryCargaDestinatario.FieldByName('TotPed').AsInteger then
                  AtualizarDestinatario;
            End
            Else
               FrmeXactWMS.PlaySound('toast2.wav');
         End;
         Result := True;
      End;
      EdtVolumeId.Text := '';
      DelayEdSetFocus(EdtVolumeId);
    except On E: Exception do Begin
      Result := False;
      ShowErro('Erro: '+E.Message, 'sirene1');
      if assigned(JsonVolumeCarregamento) then
         EdtVolumeId.Text := '';
      DelayEdSetFocus(EdtVolumeId);
      JsonVolumeCarregamento.Free;
      End;
    End;
    HideLoading;
end;

procedure TFrmCargaCarregar.AtualizarDestinatario;
Var pJsonFinalizar : TJsonObject;
begin
  QryCargaDestinatario.Next;
  if QryCargaDestinatario.Eof then Begin
     pJsonFinalizar := TJsonObject.Create();
     pJsonFinalizar.AddPair('cargaid', TJsonNumber.Create(StrToIntDef(EdtCodigo.Text, 0)));
     pJsonFinalizar.AddPair('usuarioid', TJsonNumber.Create(FrmeXactWMS.ObjUsuarioCtrl.ObjUsuario.UsuarioId));
     pJsonFinalizar.AddPair('terminal', NomeDoComputador);
     pJsonFinalizar.AddPair('operacao', 'CA');
     ObjCargaCtrl.FinalizarCarregamento(pJsonFinalizar);
     EdtCodigo.Text   := '';
     EdtConteudoPesq.Text := '';
     ShowOk('Carga Conclu�da!!!');
     Try
     Limpar;
     Except
     ShowErro('Erro na funcao Limpar');
     End;
     Try
     GetListaLstCadastro;
     Except
     ShowErro('Erro na funcao Limpar');
     End;
     Exit;
  End;
  CargaPedido;
  CargaVolumes;
  EdtDestinatario.Text := QryCargaDestinatario.FieldByName('CodPessoaERP').AsString+' - '+QryCargaDestinatario.FieldByName('Fantasia').AsString;
  DelayEdSetFocus(EdtVolumeId);
end;

procedure TFrmCargaCarregar.BtnCancelClick(Sender: TObject);
//Var vCargaId : Integer;
begin
  MsgD.FormMsg    := FrmeXactWMS;
  MsgD.Title      := 'Cancelar Carregamento';
  MsgD.Text       := 'Deseja desfazer o Carregamento?';
  MsgD.ActionOk   := ActConfirmarCancelamento;
  MsgD.ActionCancel := ActCancelarCarregamento;
  MsgD.TypeInfo   := tMsgDInformation;
  MsgD.Height      := 200;
  MsgD.ShowMsgD;
//  inherited;
//  vCargaId := ObjCargaCtrl.ObjCargas.cargaid;
//  if ResultConfirm then Begin
//     ObjCargaCtrl.CancelarCarregamento(vCargaId);
//     GetListaLstCadastro;
//  End;
end;

procedure TFrmCargaCarregar.BtnSearchPesqClick(Sender: TObject);
begin
//  inherited;
  if StrToIntDef(EdtConteudoPesq.Text, 0) =  0 then
     ShowErro('Informe um Id v�lido');
  EdtCodigo.Text := EdtConteudoPesq.Text;
  OpenCarga(StrToIntDef(EdtConteudoPesq.Text, 0), 0 , 0);
end;

procedure TFrmCargaCarregar.CargaDestinatario;
Var JsonArrayDestinatario : TJsonArray;
    vErro  : String;
    xDest  : Integer;
begin
//  Showloading;
  Try
    JsonArrayDestinatario := ObjCargaCtrl.GetCargaPessoas(ObjCargaCtrl.ObjCargas.cargaid, 0);
    if JsonArrayDestinatario.Items[0].TryGetValue('Erro', vErro) then Begin
       JsonArrayDestinatario := Nil;
       raise Exception.Create(vErro);
       Exit;
    End;
    If QryCargaDestinatario.Active then
       QryCargaDestinatario.EmptyDataSet;
    QryCargaDestinatario.Close;
    QryCargaDestinatario.LoadFromJSON(JsonArrayDestinatario, False);
    //QryCargaDestinatario.IndexFieldNames := 'CodPessoaERP';
    MontaCargaDestinatario;
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
//  JsonArrayDestinatario.Free;
//  HideLoading;
end;

procedure TFrmCargaCarregar.CargaPedido;
Var JsonArrayPedido : TJsonArray;
    vErro  : String;
begin
  Try
    JsonArrayPedido := ObjCargaCtrl.GetCargaPedidos(ObjCargaCtrl.ObjCargas.cargaid,
                                                    QryCargaDestinatario.FieldByName('PessoaId').AsInteger, 'CA', 0);
    if JsonArrayPedido.Items[0].TryGetValue('Erro', vErro) then Begin
       raise Exception.Create(vErro);
       Exit;
    End;
    If QryCargaPedido.Active then
       QryCargaPedido.EmptyDataSet;
    QryCargaPedido.Close;
    QryCargaPedido.LoadFromJSON(JsonArrayPedido, False);
    //QryCargaDestinatario.IndexFieldNames := 'CodPessoaERP';
    MontaCargaPedido;
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
//  JsonArrayPedido.Free;
end;

procedure TFrmCargaCarregar.CargaVolumes;
Var JsonArrayVolumes : TJsonArray;
    vErro  : String;
begin
  Try
    JsonArrayVolumes := ObjCargaCtrl.GetCargaCarregarVolumes(ObjCargaCtrl.ObjCargas.cargaid,
                                                             QryCargaDestinatario.FieldByName('PessoaId').AsInteger,
                                                             'CA', 0);
    if JsonArrayVolumes.Items[0].TryGetValue('Erro', vErro) then Begin
       raise Exception.Create(vErro);
       Exit;
    End;
    If QryCargaVolumes.Active then
       QryCargaVolumes.EmptyDataSet;
    QryCargaVolumes.Close;
    QryCargaVolumes.LoadFromJSON(JsonArrayVolumes, False);
  Except On E: Exception do
    raise Exception.Create('Erro: '+E.Message);
  End;
//  JsonArrayPedido.Free;
end;

procedure TFrmCargaCarregar.ChkDestinatarioClick(Sender: TObject);
begin
  inherited;
  GetCargaVolumes;
end;

procedure TFrmCargaCarregar.EdtCodigoChange(Sender: TObject);
begin
  inherited;
  PgcPrincipal.tabs[2].visible := False;
  LstCargaVolumes.Items.Clear;
end;

procedure TFrmCargaCarregar.EdtCodigoKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if EdtCodigo.Text = '' then
     Exit;
  if StrToIntDef(EdtCodigo.Text, 0) <= 0 then Begin
     EdtCodigo.Text := '';
     ShowErro('Id de Carga inv�lido!');
     DelayEdSetFocus(EdtCodigo);
     Exit;
  End;
  if Key = 13 then Begin
     OpenCarga(StrToIntDef(EdtCodigo.Text, 0), 0, 0);
  End;
end;

procedure TFrmCargaCarregar.EdtCodigoTyping(Sender: TObject);
begin
  inherited;
  Limpar;
end;

procedure TFrmCargaCarregar.EdtVolumeIdKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  inherited;
  if EdtVolumeId.Text = '' then Exit;
  if (Key = 13) or (Key = vkTab) then Begin
     If Not AtualizarConferenciaVolume then Begin
        EdtVolumeId.Text := '';
        DelayEdSetFocus(EdtVolumeId);
     End;
  End;
end;

procedure TFrmCargaCarregar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(ObjCargaCtrl) then
     ObjCargaCtrl.Free;
  inherited;
  FrmCargaCarregar.DisposeOf;
end;

Procedure TFrmCargaCarregar.FormCreate(Sender: TObject);
begin
  ObjCargaCtrl    := TCargasCtrl.Create;
  CircleStatus.Visible := False;
  LblAtivo.Visible     := False;
  inherited;
  //PgcPrincipal.ActiveTab := TabLista;
  //GetListaLstCadastro;
  PgcPrincipal.tabs[2].Visible := False;
end;

procedure TFrmCargaCarregar.GetCarga(pCargaId : Integer);
Var JsonArrayCarga : TJsonArray;
    vErro          : String;
Var Th : TThread;
begin
//  Th := TThread.CreateAnonymousThread(procedure
//    begin
      JsonArrayCarga := ObjCargaCtrl.GetCargas(pCargaId, 0, 0, '', '', '', 0, '', '', 0);
         TThread.Synchronize(nil,
           procedure()
           begin
             if JsonArrayCarga.Items[0].TryGetValue('Erro', vErro) then Begin
                    EdtCodigo.Enabled := True;
                    DelayEdSetFocus(EdtCodigo);
                    raise Exception.Create(vErro);
             End;
         //    ObjCargaCtrl.ObjCargas := ObjCargaCtrl.ObjCargas.JsonToClass((JsonArrayCarga.Items[0] as TJsonObject).ToString);
             if (JsonArrayCarga.Items[0].GetValue<Integer>('processoid') = 21) then Begin //<> vProcessoId then Begin
                    EdtCodigo.Enabled := True;
                    DelayEdSetFocus(EdtCodigo);
                    raise Exception.Create('Carga cancelada!!!');
                Exit;
             End;
             ObjCargaCtrl.ObjCargas.cargaid    := JsonArrayCarga.Items[0].GetValue<Integer>('cargaid');
             ObjCargaCtrl.ObjCargas.rotaid     := JsonArrayCarga.Items[0].GetValue<Integer>('rotaid');
             EdtRota.Text                      := JsonArrayCarga.Items[0].GetValue<String>('rota');
             ObjCargaCtrl.ObjCargas.dtinclusao := StrToDate(JsonArrayCarga.Items[0].GetValue<string>('dtinclusao'));
             ObjCargaCtrl.ObjCargas.transportadora.PessoaId := JsonArrayCarga.Items[0].GetValue<Integer>('transportadoraid');
             ObjCargaCtrl.ObjCargas.transportadora.Razao    := JsonArrayCarga.Items[0].GetValue<String>('transportadora');
             ObjCargaCtrl.ObjCargas.veiculo.VeiculoId       := JsonArrayCarga.Items[0].GetValue<Integer>('veiculoid');
             ObjCargaCtrl.ObjCargas.Veiculo.Placa           := JsonArrayCarga.Items[0].GetValue<String>('placa');
             ObjCargaCtrl.ObjCargas.Veiculo.Modelo          := JsonArrayCarga.Items[0].GetValue<String>('modelo');
             ObjCargaCtrl.ObjCargas.motorista.CodPessoa     := JsonArrayCarga.Items[0].GetValue<Integer>('motoristaid');
             ObjCargaCtrl.ObjCargas.Motorista.Razao         := JsonArrayCarga.Items[0].GetValue<String>('motorista');
             ObjCargaCtrl.ObjCargas.ProcessoId              := JsonArrayCarga.Items[0].GetValue<Integer>('processoid');
             ShowDados;
           end);
//    end);
//  Th.OnTerminate := ThreadTerminate;
//  Th.Start;
end;

procedure TFrmCargaCarregar.GetCargaVolumes;
Var Th : TThread;
begin
  Th := TThread.CreateAnonymousThread(procedure
     Var JsonArrayVolumes : TJsonArray;
         vErro : String;
     begin
       JsonArrayVolumes := ObjCargaCtrl.GetCargaPedidoVolumes(ObjCargaCtrl.ObjCargas.cargaid, 'CA');
       if JsonArrayVolumes.Items[0].TryGetValue('Erro', vErro) then Begin
          JsonArrayVolumes := Nil;
          raise Exception.Create('Erro: Carregando volumes!');
       End
       Else Begin
         If FDMemCargaVolumesResumo.Active then
            FDMemCargaVolumesResumo.EmptyDataSet;
         FDMemCargaVolumesResumo.Close;
         FDMemCargaVolumesResumo.LoadFromJSON(JsonArrayVolumes, False);
         if (ChkDestinatario.IsChecked) and (ChkPendente.IsChecked) then Begin
            FdMemCargaVolumesResumo.Filter   := '(pessoaid='+QryCargaDestinatario.FieldByName('PessoaId').AsString+') and (Conferido=0)';
            FdMemCargaVolumesResumo.Filtered := True;
         End
         Else if (ChkDestinatario.IsChecked) then Begin
            FdMemCargaVolumesResumo.Filter   := 'pessoaid='+QryCargaDestinatario.FieldByName('PessoaId').AsString;
            FdMemCargaVolumesResumo.Filtered := True;
         End
         Else if (ChkPendente.IsChecked) then Begin
            FdMemCargaVolumesResumo.Filter   := '(Conferido=0)';
            FdMemCargaVolumesResumo.Filtered := True;
         End;
         TThread.Synchronize(TThread.CurrentThread, procedure
         Var item : TListViewItem;
             txt  : TListItemText;
             img  : TListItemImage;
         begin
           LstCargaVolumes.BeginUpdate;
           LstCargaVolumes.Items.Clear;
           FDMemCargaVolumesResumo.First;
           While Not FDMemCargaVolumesResumo.Eof do Begin
             item := LstCargaVolumes.Items.Add;
             item.Objects.Clear;
             item.Tag := FDMemCargaVolumesResumo.FieldByName('PedidoVolumeid').AsLargeInt;
             with item do begin
               img := TListItemImage(Objects.FindDrawable('ImgFdoVolumes'));
               img.ScalingMode := TImageScalingMode.Stretch;
               If FDMemCargaVolumesResumo.FieldByName('Conferido').AsInteger = 1 Then       //Inicializado
                  img.Bitmap := ImgLstFdoGreen.Bitmap
               Else
                  img.Bitmap := ImgLstFdoYellow.Bitmap;
               txt := TListItemText(Objects.FindDrawable('PedidoId'));
               txt.Text := FDMemCargaVolumesResumo.FieldByName('PedidoId').AsString;

               txt := TListItemText(Objects.FindDrawable('PedidoVolumeId'));
               txt.Text := FDMemCargaVolumesResumo.FieldByName('PedidoVolumeId').AsString;

               txt := TListItemText(Objects.FindDrawable('Embalagem'));
               txt.Text := FDMemCargaVolumesResumo.FieldByName('Embalagem').AsString;

               txt := TListItemText(Objects.FindDrawable('Conferencia'));
               txt.Text := FDMemCargaVolumesResumo.FieldByName('Data').AsString+' '+
                           FDMemCargaVolumesResumo.FieldByName('Hora').AsString;
             End;
             FDMemCargaVolumesResumo.Next;
           End;
           LstCargaVolumes.EndUpdate;
           FdMemCargaVolumesResumo.Filter   := '';
           FdMemCargaVolumesResumo.Filtered := False;
         End);
       End;
       //JsonArrayVolumes.Free;
     End);
  Th.OnTerminate := ThreadTerminate;
  Th.Start;
end;

Function TFrmCargaCarregar.GetListaCarga(pCarga, pRotaId, pProcessoid : Integer) : Boolean;
Var JsonArrayCarga : TJsonArray;
    vErro          : String;
    xCarga         : Integer;
begin
  Result := False;
  Showloading;
  Try
    JsonArrayCarga := ObjCargaCtrl.Lista(0, 0, 16, 1);
    if JsonArrayCarga.Items[0].TryGetValue('Erro', vErro) then Begin
       ShowErro(vErro);
       Exit;
    End;
    Result := JsonArrayCarga.Count >= 1;
    If QryListaPadrao.Active then
       QryListaPadrao.EmptyDataSet;
    QryListaPadrao.Close;
    QryListaPadrao.LoadFromJSON(JsonArrayCarga, False);
    LstPrincipal.BeginUpdate;
    LstPrincipal.Items.Clear;
    For xCarga := 0 to Pred(JsonArrayCarga.Count) do Begin
      With LstPrincipal.Items.Add do Begin
        TListItemText(Objects.FindDrawable('CargaId')).Text := JsonArrayCarga.Items[xCarga].GetValue<Integer>('cargaid').ToString;
        TListItemText(Objects.FindDrawable('Data')).Text  := JsonArrayCarga.Items[xCarga].GetValue<String>('data');
        TListItemText(Objects.FindDrawable('Rota')).Text         := JsonArrayCarga.Items[xCarga].GetValue<String>('rota');
      End;
    End;
    LstPrincipal.EndUpdate;
    Result := True;
  Except On E: Exception do
    ShowErro('Erro: '+E.Message);
  End;
  HideLoading;
end;

procedure TFrmCargaCarregar.GetListaLstCadastro;
begin
  inherited;
  GetListaCarga(0, 0, 16);
end;

procedure TFrmCargaCarregar.InserirDestinatarioSqlLite;
begin
  Exit;
  With DmClient.QryCargaDestinatario do Begin
    Close;
    Sql.Clear;
    SQL.Add('insert into CargaDestinatario values (:pCargaId, :pPessoaId, :pCodPessoaERP, :pRazao, :pOrdem, :pTPed , :pConferido)');
    ParamByName('pCargaId').Value      := ObjCargaCtrl.ObjCargas.cargaid;
    ParamByName('pPessoaId').Value     := QryCargaDestinatario.FieldByName('PessoaId').AsInteger;
    ParamByName('pCodPessoaERP').Value := QryCargaDestinatario.FieldByName('CodPessoaERP').AsInteger;
    ParamByName('pRazao').Value        := QryCargaDestinatario.FieldByName('Razao').AsString;
    ParamByName('pOrdem').Value        := QryCargaDestinatario.FieldByName('Ordem').AsInteger;
    ParamByName('pTPed').Value         := QryCargaDestinatario.FieldByName('TotPed').AsInteger;
    ParamByName('pConferido').Value    := QryCargaDestinatario.FieldByName('Conferido').AsInteger;
    ExecSQL;
  End;
end;

procedure TFrmCargaCarregar.InserirPedidoSqlLite;
begin
  Exit;
  With DmClient.QryCargaPedido do Begin
    Close;
    Sql.Clear;
    SQL.Add('insert into CargaPedido values (:pCargaId, :pPedidoId, :pQtdVolume, :pItens, :pConferido)');
    ParamByName('pCargaId').Value   := ObjCargaCtrl.ObjCargas.cargaid;
    ParamByName('pPedidoId').Value  := QryCargaPedido.FieldByName('PedidoId').AsInteger;
    ParamByName('pQtdVolume').Value := QryCargaPedido.FieldByName('QtdVolume').AsInteger;
    ParamByName('pItens').Value     := QryCargaPedido.FieldByName('Itens').AsInteger;
    ParamByName('pConferido').Value := QryCargaPedido.FieldByName('Conferido').AsInteger;
    ExecSQL;
  End;
end;

procedure TFrmCargaCarregar.InserirVolumeSqlLite;
begin
  Exit;
  With DmClient.QryCargaVolume do Begin
    Close;
    Sql.Clear;
    SQL.Add('insert into CargaVolumes values (:pCargaId, :pPedidoId, :pPessoaId, :pPedidoVolumeId, :pConferido)');
    ParamByName('pCargaId').Value        := ObjCargaCtrl.ObjCargas.cargaid;
    ParamByName('pPedidoId').Value       := QryCargaVolumes.FieldByName('PedidoId').AsInteger;
    ParamByName('pPessoaId').Value       := QryCargaVolumes.FieldByName('PessoaId').AsInteger;
    ParamByName('pPedidoVolumeId').Value := QryCargaVolumes.FieldByName('PedidoVolumeId').AsInteger;
    ParamByName('pConferido').Value      := QryCargaVolumes.FieldByName('Conferido').AsInteger;
    ExecSQL;
  End;
end;

procedure TFrmCargaCarregar.Limpar;
begin
  inherited;
  EdtDtCarga.Text      := '';
  EdtRota.Text         := '';
  EdtDestinatario.Text := '';
  EdtVolumeId.Text     := '';
  If QryCargaDestinatario.Active then
     QryCargaDestinatario.EmptyDataSet;
  QryCargaDestinatario.Close;
  If QryCargaPedido.Active then
     QryCargaPedido.EmptyDataSet;
  QryCargaPedido.Close;
  If QryCargaVolumes.Active then
     QryCargaVolumes.EmptyDataSet;
  QryCargaVolumes.Close;
  LstDestinatario.Items.Clear;
  LstPedidos.Items.Clear;
  EdtCodigo.Enabled   := True;
  EdtVolumeId.Enabled := False;
  DelayEdSetFocus(EdtCodigo);
  BtnSave.Enabled   := False;
  BtnCancel.Enabled := False;
  PthBtnSave.Fill.Color   := TAlphaColorRec.Darkgray;
  PthBtnCancel.Fill.Color := TAlphaColorRec.Darkgray;
end;

procedure TFrmCargaCarregar.LstCargaVolumesItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
    Teste : String;
begin
  inherited;
  TxtItem := TListItemText(LstCargaVolumes.Items[AItem.Index].Objects.FindDrawable('PedidoVolumeId'));
  Teste       := TxtItem.Text;
end;

procedure TFrmCargaCarregar.LstPrincipalItemClick(const Sender: TObject;
  const AItem: TListViewItem);
Var TxtItem : TListItemText;
begin
  inherited;
  TxtItem := TListItemText(LstPrincipal.Items[AItem.Index].Objects.FindDrawable('CargaId'));
  EdtConteudoPesq.text := TxtItem.Text; //Txt.TagString;
  EdtCodigo.Text       := TxtItem.Text;
end;

procedure TFrmCargaCarregar.MontaCargaDestinatario;
Var item : TListViewItem;
     txt : TListItemText;
     img : TListItemImage;
begin
  TThread.Synchronize(TThread.CurrentThread, procedure
  begin
    LstDestinatario.BeginUpdate;
    LstDestinatario.Items.Clear;
    QryCargaDestinatario.First;
    While Not QryCargaDestinatario.Eof do Begin
      item := LstDestinatario.Items.Add;
      item.Objects.Clear;
      item.Tag := QryCargaDestinatario.FieldByName('CodPessoaERP').AsLargeInt;
      with item do begin
        img := TListItemImage(Objects.FindDrawable('ImgFdoDestinatario'));
        img.ScalingMode := TImageScalingMode.Stretch;
        If QryCargaDestinatario.FieldByName('Conferido').AsInteger = 0 Then begin       //Inicializado
           img.Bitmap := ImgLstFdoWhite.Bitmap;
        End
        Else If QryCargaDestinatario.FieldByName('Conferido').AsInteger < QryCargaDestinatario.FieldByName('TotPed').AsInteger Then Begin  //Em Contagem
           img.Bitmap := ImgLstFdoYellow.Bitmap;
        End
        Else Begin  //Conclu�do/Finalizado
           img.Bitmap := ImgLstFdoGreen.BitMap;
        end;
        txt := TListItemText(Objects.FindDrawable('CodPessoaERP'));
        txt.Text := QryCargaDestinatario.FieldByName('CodPessoaERP').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;

        txt := TListItemText(Objects.FindDrawable('Destinatario'));
        txt.Text := QryCargaDestinatario.FieldByName('Razao').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;

        txt := TListItemText(Objects.FindDrawable('Ordem'));
        txt.Text := QryCargaDestinatario.FieldByName('Ordem').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;

        txt := TListItemText(Objects.FindDrawable('TPed'));
        txt.Text := QryCargaDestinatario.FieldByName('TotPed').AsString;//        TListItemText(Objects.FindDrawable('Destinatario')).Text := QryCargaDestinatario.FieldByName('Razao').AsString;
      End;
      QryCargaDestinatario.Next;
    End;
    LstDestinatario.EndUpdate;
  End);
end;

procedure TFrmCargaCarregar.MontaCargaPedido;
Var item : TListViewItem;
     txt : TListItemText;
     img : TListItemImage;
     Cor : Cardinal;
begin
  TThread.Synchronize(TThread.CurrentThread, procedure
  begin
    LstPedidos.BeginUpdate;
    LstPedidos.Items.Clear;
    QryCargaPedido.First;
    While Not QryCargaPedido.Eof do Begin
      item := LstPedidos.Items.Add;
      item.Objects.Clear;
      item.Tag := QryCargaPedido.FieldByName('PedidoId').AsLargeInt;
      with item do begin
        img := TListItemImage(Objects.FindDrawable('ImgFdoCargaVolumes'));
        img.ScalingMode := TImageScalingMode.Stretch;
        If QryCargaPedido.FieldByName('Conferido').AsInteger = 0 Then begin       //Inicializado
           img.Bitmap := ImgLstFdoWhite.Bitmap;
           Cor:= $FF5DA9BC;
        End
        Else If QryCargaPedido.FieldByName('Conferido').AsInteger < QryCargaPedido.FieldByName('QtdVolume').AsInteger Then Begin  //Em Contagem
           img.Bitmap := ImgLstFdoYellow.Bitmap;
           Cor:= $FFE9C168;
        End
        Else Begin  //Conclu�do/Finalizado
           img.Bitmap := ImgLstFdoGreen.BitMap;
           Cor:= $FF32B932;
        end;
//        TListItemText(Objects.FindDrawable('PedidoId')).Text   := QryCargaPedido.FieldByName('PedidoId').AsString;
        txt := TListItemText(Objects.FindDrawable('PedidoId'));
        txt.Text := QryCargaPedido.FieldByName('PedidoId').AsString;
//        TListItemText(Objects.FindDrawable('QtdVolumes')).Text := QryCargaPedido.FieldByName('QtdVolume').AsString;
        txt := TListItemText(Objects.FindDrawable('QtdVolumes'));
        txt.Text := QryCargaPedido.FieldByName('QtdVolume').AsString;
//        TListItemText(Objects.FindDrawable('Itens')).Text      := QryCargaPedido.FieldByName('Itens').AsString;
        txt := TListItemText(Objects.FindDrawable('Itens'));
        txt.Text := QryCargaPedido.FieldByName('Itens').AsString;
//        TListItemText(Objects.FindDrawable('Conferido')).Text  := QryCargaPedido.FieldByName('Conferido').AsInteger.ToString;
        txt := TListItemText(Objects.FindDrawable('Conferido'));
        txt.Text := QryCargaPedido.FieldByName('Conferido').AsString;
      End;
      QryCargaPedido.Next;
    End;
{    QryCargaPedido.Filter := 'Status = 0';
    QryCargaPedido.Filtered := True;
    if QryCargaPedido.IsEmpty then Begin
       MensagemStand('Carga conclu�da!');
    End;
}    LstPedidos.EndUpdate;
  End);
end;

procedure TFrmCargaCarregar.OpenCarga(pCargaId, pRotaId, pProcessoId : Integer);
var Th: TThread;
Begin
  Try
    if pCargaId <= 0 then Begin
       ShowErro('Id('+pCargaId.ToString()+') inv�lido!');
       EdtCodigo.Text := '';
       if PgcPrincipal.ActiveTab = TabDetalhes then
          DelayEdSetFocus(EdtCodigo);
       Exit;
    End;
    ShowLoading;
    Th := TThread.CreateAnonymousThread(procedure
    begin
      GetCarga(pCargaId);
      CargaDestinatario;
      QryCargaDestinatario.First;
      While Not QryCargaDestinatario.Eof do Begin
        if QryCargaDestinatario.FieldByName('Conferido').Value = 0 then
           Break;
        QryCargaDestinatario.Next;
      End;
      AtivarDestinatario;
      CargaPedido;
      CargaVolumes;
      if ObjCargaCtrl.ObjCargas.ProcessoId in [ 16, 18 ] then Begin
         TThread.Synchronize(
           TThread.CurrentThread,
           procedure ()
           begin
             EdtCodigo.Enabled    := False;
             EdtVolumeId.Enabled  := True;
             EdtVolumeid.ReadOnly := False;
             DelayEdSetFocus(EdtVolumeId);
             BtnSave.Enabled   := True;
             BtnCancel.Enabled := True;
             PthBtnSave.Fill.Color   := TAlphaColorRec.Chocolate;
             PthBtnCancel.Fill.Color := TAlphaColorRec.Chocolate;
             PgcPrincipal.tabs[2].Visible := True;
             BtnArrowRigth.Action         := ChgTabCargaVolumes;
           End);
      End
      Else
         ShowErro('Carga - J� conclu�da!');
    End);
    Th.OnTerminate := ThreadTerminate;
    Th.Start;
//    JsonArrayRetorno := ObjCargaCtrl.GetCargas(StrToIntDef(EdtCargaId.Text, 0), 0, 0, '', '', '', 0, '', '', 1);
//    SelecionarClientePedidos(JsonArrayRetorno.Items[0].GetValue<TJsonArray>('pedidos'));
//    CalculaPesoVolume;

  //Montar Lista de Endere�os
  Except On E: Exception do
    ShowErro('Erro: '+E.Message);
  End;
  //HideLoading;
end;

function TFrmCargaCarregar.PesquisarComFiltro(pCampo: Integer;
  PConteudo: String): Boolean;
begin
  Result := True;
end;

procedure TFrmCargaCarregar.PgcPrincipalChange(Sender: TObject);
begin
  inherited;
  if (PgcPrincipal.ActiveTab = TabDetalhes) then Begin
     if (LstDestinatario.Items.Count>0)  then
        BtnArrowRigth.Action := ChgTabCargaVolumes
     Else BtnArrowRigth.Action := Nil;
     BtnArrowLeft.Action  := ChgTabLista;
  End
  Else if (PgcPrincipal.ActiveTab = TabLista) then Begin
     BtnArrowRigth.Action := ChgTabDet;
     BtnArrowLeft.Action  := Nil;
  End
  Else If (PgcPrincipal.ActiveTab = TabVolumes) then Begin
     BtnArrowLeft.Action  := ChgTabDet;
     BtnArrowRigth.Action := Nil;
     GetCargaVolumes;
  End;
end;

procedure TFrmCargaCarregar.ShowDados;
begin
  inherited;
  EdtCodigo.Text  := ObjCargaCtrl.ObjCargas.cargaid.ToString();
  EdtDtCarga.Text := DateToStr(ObjCargaCtrl.ObjCargas.dtinclusao);
end;

procedure TFrmCargaCarregar.ThreadTerminate(Sender: TObject);
begin
  HideLoading;
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

