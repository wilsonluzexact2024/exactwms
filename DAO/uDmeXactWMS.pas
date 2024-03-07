unit uDmeXactWMS;

interface

uses
  Dialogs, System.SysUtils, System.Classes, uDmBase, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, IniFiles,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, ACBrBase, ACBrSocket,
  ACBrConsultaCNPJ, FireDAC.Comp.Script, FireDAC.Comp.Client, Data.DB,
  FireDAC.Comp.DataSet, VCL.Forms, WinApi.Windows, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSon, ConfiguracaoClass,
  JvMemoryDataset, FireDAC.Phys.MSSQLDef, FireDAC.Comp.UI,
  FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL;

type
  TDmeXactWMS = class(TDmBase)
    JvMemoryData1: TJvMemoryData;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    Procedure GetConfig;
    procedure CopyArqIni;
  public
    { Public declarations }
    BASEURL, BASEURLREPORT : String;
  end;

var
  DmeXactWMS: TDmeXactWMS;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses uFuncoes, uFrmeXactWMS, LZExpand;

procedure TDmeXactWMS.DataModuleCreate(Sender: TObject);
var vlData: TSystemTime;

begin
  inherited;
  GetConfig;
{
   If ConectarFD Then Begin
      Application.MessageBox('Erro de conex�o com Banco de Dados.', 'Erro', MB_ICONERROR + MB_OK);
      Application.Terminate;
   End;
   qryData.Close;
   qryData.Open;
   DateTimeToSystemTime(qryData.FieldByName('Data').AsDateTime, vlData);
   SetLocalTime(vlData);
   QryData.Close;
}
end;

procedure TDmeXactWMS.GetConfig;
Var ArqIni : TIniFile;
    vIpMain,   vIpReport,   vIpSeach    : AnsiString;
    vPortMain, vPortReport, vPortSearch : String;
    EtqCodBarra_Modelo, EtqCodBarra_Porta, TimeEtq, Temperatura : String;
begin
  inherited;
  if Not fileexists(ExtractFilePath( Application.ExeName )+'eXactWMS.ini') then Begin
     Try
       CopyArqIni
     Except
       //ShowMessage('Entrei aqui');
     End;
     if Not fileexists(ExtractFilePath( Application.ExeName )+'eXactWMS.ini') then Begin
        ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.Ini');
//Banco de Dados
        vIpMain := '127.0.0.1';
        repeat
          vIpMain := InputBox('Servidor de Servi�os eXactWMS', 'Informe o Ip do Server Principal.', '');
        until vIpMain <> '';
        vPortMain := '8200';
        repeat
          vPortMain := InputBox('Porta do Servidor eXactWMS', 'Informe a Porta do Server Principal.', '');
        until StrToIntDef(vPortMain, 0) <> 0;
        ArqIni.WriteString('msService','IpMain', CriptografarSimples(vIpMain+':'+vPortMain));

        vIpReport := '127.0.0.1';
        repeat
          vIpReport := InputBox('Servidor de Servi�os eXactWMS', 'Informe o Ip do Servi�o de Relat�rios', '');
        until vIpReport <> '';
        vPortReport := '8300';
        repeat
          vPortReport := InputBox('Porta do Servidor eXactWMS', 'Informe a Porta do Server de Relat�rios.', '');
        until StrToIntDef(vPortReport, 0) <> 0;
        ArqIni.WriteString('msService','IpReport',CriptografarSimples(vIpReport+':'+vPortReport));

        vIpSeach := '127.0.0.1';
        repeat
          vIpSeach := InputBox('Servidor de Servi�os eXactWMSt', 'Informe o Ip do Server de Consultas', '');
        until vIpSeach <> '';
        vPortSearch := '8400';
        repeat
          vPortSearch := InputBox('Porta do Servidor eXactWMS', 'Informe a Porta do Server de Consultas.', '');
        until StrToIntDef(vPortSearch, 0) <> 0;
        ArqIni.WriteString('msService','IpSearch',CriptografarSimples(vIpSeach+':'+vPortSearch)); //yeratad806092'));
      //Chave de Prote��o
        ArqIni.Destroy;
     End;
  End;
  Try
    ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.Ini');
    EtqCodBarra_Modelo := ArqIni.ReadString('Printer', 'EtqCodBarra_Modelo', '');
    EtqCodBarra_Porta  := ArqIni.ReadString('Printer', 'EtqCodBarra_Porta', '');
    TimeEtq            := ArqIni.ReadString('Printer', 'TimeEtq', '200');
    Temperatura        := ArqIni.ReadString('Printer', 'Temperatura', '10');
    Try
      CopyArqIni
    Except
      //ShowMessage('Entrei aqui');
    End;
    ArqIni := TIniFile.Create(ExtractFilePath( Application.ExeName )+'eXactWMS.Ini');
    ArqIni.WriteString('Printer', 'EtqCodBarra_Modelo', EtqCodBarra_Modelo);
    ArqIni.WriteString('Printer', 'EtqCodBarra_Porta', EtqCodBarra_Porta);
    ArqIni.WriteString('Printer', 'TimeEtq', timeEtq);
    ArqIni.WriteString('Printer', 'Temperatura', Temperatura);

    RESTClientWMS.BaseURL := 'http://'+CriptografarSimples(ArqIni.ReadString('msService', 'IpMain','127.0.0.1:8200'));
    ClientReport.BaseURL  := 'http://'+CriptografarSimples(ArqIni.ReadString('msService', 'IpReport','127.0.0.1:8200'));
    ClientGraphics.BaseURL := 'http://'+CriptografarSimples(ArqIni.ReadString('msService', 'IpMain','127.0.0.1:8200'));
    EtqCodBarra_Modelo := ArqIni.ReadString('Printer', 'EtqCodBarra_Modelo', '');
    EtqCodBarra_Porta  := ArqIni.ReadString('Printer', 'EtqCodBarra_Porta', '');
    BASEURL       := RESTClientWMS.BaseURL;
    BASEURLREPORT := ClientReport.BaseURL;
    FreeAndNil(ArqIni);
//    RESTRequestWMS.Timeout := (30000*10);
  Except
    Application.MessageBox('Inconsist�ncia no arquivo de par�metros de inicializa��o...', 'Erro', MB_ICONERROR + MB_OK);
    FreeAndNil(ArqIni);
    Application.Terminate;
  End;
end;

{This one uses LZCopy, which USES LZExpand.}

procedure TDmeXactWMS.CopyArqIni;
Var S, T : TFileStream;
    Str  : TStrings;
    PathAtualizar : String;
begin
  Str := TStringList.Create();
  Str.LoadFromFile(ExtractFilePath(ParamStr(0))+'configatualizador.dat');
  PathAtualizar := StringReplace(Str[0],'exe', 'ini', []);
  Str.Free;

  //if Not fileexists('\\192.168.1.5\atualiza\eXactWMS\eXactWMS.ini') then Exit;
  if (UpperCase(PathAtualizar) = UpperCase(ExtractFilePath(ParamStr(0))+'eXactWMS.ini')) or (Not fileexists(PathAtualizar)) then
     Exit;
  try
    Try
      S := TFileStream.Create(PathAtualizar, fmOpenRead);  //'\\192.168.1.5\atualiza\eXactWMS\eXactWMS.ini'
      T := TFileStream.Create( ExtractFilePath(ParamStr(0))+'eXactWMS.ini',
                               fmOpenWrite or fmCreate );
      //Atualizar Impressora no arquivo INI
      try
        T.CopyFrom(S, S.Size ) ;
      finally
        T.Free;
      end;
    Except
      //ShowMessage('Erro ao copiar o arquivo INI do eXactWMS');
    End;
  finally
    If Assigned(S) Then
       S.Free;
  end;
end;

end.
