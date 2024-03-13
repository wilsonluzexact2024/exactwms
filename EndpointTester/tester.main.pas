unit tester.main;

interface

uses
  System.SysUtils,
  json,
  System.NetEncoding,
  rtti,
  System.ZLib,

  System.Types,
  System.UITypes,
  math,
  System.Classes,
  System.Variants,
  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  System.ImageList,
  FMX.ImgList,
  FMX.StdCtrls,
  FMX.Edit,
  FMX.ListBox,
  FMX.Layouts,
  System.IOUtils,
  FMX.Objects,
  FMX.Controls.Presentation,
  FMX.DialogService,
  System.Sensors,
  FMX.Effects,
  FMX.Filter.Effects,
  System.Sensors.Components,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient,
  IdSMTPBase,
  IdSMTPRelay,
  FMX.Ani,

  System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, FMX.Memo.Types, FMX.ScrollBox,
  tester.service.http, FMX.Memo

    ;

type
  TFmain = class(TForm)
    BackgroundImage: TImage;
    BackgroundGaussianBlurEffect: TGaussianBlurEffect;
    VertScrollBox1: TVertScrollBox;
    HeaderLayout: TLayout;
    CopperDarkStyleBook: TStyleBook;
    AniIndicator1: TAniIndicator;
    memoUrls: TMemo;
    MemoResults: TMemo;
    SignInRectBTN: TRectangle;
    bt_executar: TButton;
    CenterLayout: TLayout;
    LogoCircle: TCircle;
    LogoImage: TImage;
    flarotatiologo: TFloatAnimation;
    chethreads: TCheckBox;
    procedure bt_executarClick(Sender: TObject);
    procedure tm_initTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnewuserClick(Sender: TObject);
    procedure otesteClick(Sender: TObject);
    procedure netreqRequestCompleted(const Sender: TObject;
      const AResponse: IHTTPResponse);

    function decompress(value: TStream): TStream;
    procedure btresendepassClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure flarotatiologoFinish(Sender: TObject);
  private
    FfatalMsg: Boolean;
    FExecPath: TExecPath;
    FtheadsCount: Integer;
    FcountFinalized: Integer;

    procedure DoConsulta(Url: string);
    function GetInfoAcount: string;
    procedure ProcessConsulta(Sender: TObject);
    procedure onfinalizethd(Sender: TObject);
    procedure onfinalizeinfoconta(Sender: TObject);

  public
    { Public declarations }
  end;

var
  Fmain: TFmain;

implementation

{$R *.fmx}

{ ----------------------------------------------------------------------------- }
procedure TFmain.ProcessConsulta(Sender: TObject);

begin
  try
    try
      if FcountFinalized >= pred(FtheadsCount) then
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure()
          begin
            Application.ProcessMessages;
            bt_executar.Enabled := true;
            AniIndicator1.Visible := false;
            AniIndicator1.Enabled := false;
          end);

      end;
      Application.ProcessMessages;
      if (Sender as TExecPath).returnCod <> 200 then
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure()
          begin
            MemoResults.Lines.Add('ERRO  ' + (Sender as TExecPath).Lurl + ' - '
              + copy((Sender as TExecPath).Retorno, 0, 200));
          end);

      end
      else
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure()
          begin
            MemoResults.Lines.Add('SUCESSO  ' + (Sender as TExecPath).Lurl +
              ' - ' + copy((Sender as TExecPath).Retorno, 0, 200));
          end);

      end;

    except
      on e: exception do
      begin
        // ShowMessage(e.Message);
      end;
    end;
  finally
    inc(FcountFinalized);
  end;

end;

procedure TFmain.btresendepassClick(Sender: TObject);
begin

end;

{ ----------------------------------------------------------------------------- }
procedure TFmain.DoConsulta(Url: string);
begin
  try

    FExecPath := TExecPath.Create(true);
    FExecPath.Lurl := Url;
    FExecPath.FreeOnTerminate := true;
    FExecPath.OnTerminate := ProcessConsulta;
    if chethreads.IsChecked then
    Begin

      FExecPath.Resume;
    End
    else
    begin
      FExecPath.Execute;
      sleep(200);

      ProcessConsulta(FExecPath);

    end;
  except
    on e: exception do
    begin

    end;
  end;

end;

procedure TFmain.flarotatiologoFinish(Sender: TObject);
begin

end;

{ ----------------------------------------------------------------------------- }
Function TFmain.GetInfoAcount: string;
const
  AccountType = 'com.google';
var
  AccountNames: TArray<String>;
  AccountLoopCounter: Integer;
begin
{$IF DEFINED(ANDROID)}
{$ENDIF}
end;

{ ----------------------------------------------------------------------------- }
function TFmain.decompress(value: TStream): TStream;
begin
  // compress to buff (System.ZLib)
  value.Position := 0;
  result := TstringStream.Create;
  ZDecompressStream(value, result);
end;

procedure TFmain.netreqRequestCompleted(const Sender: TObject;
const AResponse: IHTTPResponse);
begin
  AResponse.ContentStream;
end;

{ ----------------------------------------------------------------------------- }
procedure TFmain.onfinalizeinfoconta(Sender: TObject);
begin

end;

procedure TFmain.onfinalizethd(Sender: TObject);
begin
  TThread.Synchronize(TThread.CurrentThread,
    procedure()
    begin
      AniIndicator1.Visible := false;
      AniIndicator1.Enabled := false;
    end);

end;

procedure TFmain.otesteClick(Sender: TObject);
begin
end;

{ ----------------------------------------------------------------------------- }
procedure TFmain.FormCreate(Sender: TObject);
begin
{$IF DEFINED(MSWINDOWS)}
  Self.FullScreen := false;
  Self.ShowFullScreenIcon := false;
{$ELSE}
  Self.FullScreen := true;
  Self.ShowFullScreenIcon := true;
{$ENDIF}
  AniIndicator1.Align := TAlignLayout(11);

end;

procedure TFmain.FormShow(Sender: TObject);
begin
  flarotatiologo.Start;

end;

procedure TFmain.btnewuserClick(Sender: TObject);
begin

end;

{ ----------------------------------------------------------------------------- }
procedure TFmain.bt_executarClick(Sender: TObject);
var

  myThread: TThread;

begin
  bt_executar.Enabled := false;
  AniIndicator1.Visible := true;
  AniIndicator1.Enabled := true;
  FtheadsCount := 0;
  FcountFinalized := 0;
  myThread := TThread.CreateAnonymousThread(
    procedure
    begin
      var
        i: Integer;
      MemoResults.Lines.Clear;
      for i := 0 to memoUrls.Lines.Count do
      begin
        sleep(100);
        try

          TThread.Synchronize(TThread.CurrentThread,
            procedure()
            begin
              caption := memoUrls.Lines[i];
            end);

          inc(FtheadsCount);
          DoConsulta(memoUrls.Lines[i]);

        except
          on e: exception do
          begin
            Application.ProcessMessages;

            TThread.Synchronize(TThread.CurrentThread,
              procedure()
              begin
                caption := memoUrls.Lines[i] + ' eror ' + e.Message;
              end);

          end;
        end;
        TThread.Synchronize(TThread.CurrentThread,
          procedure()
          begin
            Application.ProcessMessages;
            bt_executar.Enabled := true;
            AniIndicator1.Visible := false;
            AniIndicator1.Enabled := false;
          end);

      end;

    end);

  myThread.Start();

end;

procedure TFmain.tm_initTimer(Sender: TObject);
begin

end;

{ ----------------------------------------------------------------------------- }
end.
