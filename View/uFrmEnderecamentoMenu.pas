unit uFrmEnderecamentoMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.StdCtrls, acPNG, Vcl.Buttons;

type
  TFrmEnderecamentoMenu = class(TForm)
    PnHeader: TPanel;
    LblForm: TLabel;
    ImgClose: TImage;
    ImgMinimize: TImage;
    Image1: TImage;
    BtnArmazem: TPanel;
    ShpArmazem: TShape;
    SpbArmazem: TSpeedButton;
    PnlArmazem: TPanel;
    ImgArmazem: TImage;
    BtnZonas: TPanel;
    ShpZonas: TShape;
    SpbZonas: TSpeedButton;
    PnlZonas: TPanel;
    ImgZonas: TImage;
    BtnRuas: TPanel;
    ShpRuas: TShape;
    SpbRuas: TSpeedButton;
    PnlRuas: TPanel;
    ImgRuas: TImage;
    BtnEnderecos: TPanel;
    ShpEnderecos: TShape;
    SpbEnderecos: TSpeedButton;
    PnlEnderecos: TPanel;
    ImgEnderecos: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Image1Click(Sender: TObject);
    procedure SpbArmazemClick(Sender: TObject);
    procedure SpbZonasClick(Sender: TObject);
    procedure SpbRuasClick(Sender: TObject);
    procedure SpbEnderecosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEnderecamentoMenu: TFrmEnderecamentoMenu;

implementation

{$R *.dfm}

uses uFrmEnderecamento, uFrmDesenhoArmazem, uFrmEnderecamentoRuas,
  uFrmEnderecamentoZonas, uFrmeXactWMS;

procedure TFrmEnderecamentoMenu.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    FrmEnderecamentoMenu := Nil;
end;

procedure TFrmEnderecamentoMenu.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmEnderecamentoMenu.SpbArmazemClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endere�amento CD')) then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmDesenhoArmazem) = False) then
     FrmDesenhoArmazem := TFrmDesenhoArmazem.Create(Application);
  try
    FrmDesenhoArmazem.Module     := 'Log�stica';
    FrmDesenhoArmazem.ModuleMenu := 'Armaz�ns';
    FrmDesenhoArmazem.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmDesenhoArmazem);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmEnderecamentoMenu.SpbZonasClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endere�amento CD')) then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmEnderecamentoZonas) = False) then
     FrmEnderecamentoZonas := TFrmEnderecamentoZonas.Create(Application);
  try
    FrmEnderecamentoZonas.Module     := 'Log�stica';
    FrmEnderecamentoZonas.ModuleMenu := 'Zonas';
    FrmEnderecamentoZonas.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEnderecamentoZonas);
      raise Exception.Create(e.Message);
    end;
  end;
end;

procedure TFrmEnderecamentoMenu.SpbEnderecosClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endere�amento CD')) and
     (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endere�amentos - Manuten��o')) then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmEnderecamento) = False) then
     FrmEnderecamento := TFrmEnderecamento.Create(Application);
  try
    FrmEnderecamento.Module     := 'Log�stica';
    FrmEnderecamento.ModuleMenu := 'Endere�amento CD';
    FrmEnderecamento.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEnderecamento);
      raise Exception.Create('FrmEnderecamentos: '+e.Message);
    end;
  end;
end;

procedure TFrmEnderecamentoMenu.SpbRuasClick(Sender: TObject);
begin
  if (Not FrmeXactWMS.ObjUsuarioCtrl.AcessoFuncionalidade('Endere�amento CD')) then
     raise Exception.Create('Acesso n�o autorizado a esta funcionalidade!');
  Close;
  if (Assigned(FrmEnderecamentoRuas) = False) then
     FrmEnderecamentoRuas := TFrmEnderecamentoRuas.Create(Application);
  try
    FrmEnderecamentoRuas.Module     := 'Log�stica';
    FrmEnderecamentoRuas.ModuleMenu := 'Endere�amento Ruas';
    FrmEnderecamentoRuas.Show;
  except on e: Exception do
    begin
      FreeAndNil(FrmEnderecamentoRuas);
      raise Exception.Create(e.Message);
    end;
  end;
end;

end.
