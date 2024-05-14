unit Services.VolumeEmbalagem;

interface

uses
  System.SysUtils, System.Classes, Services.Base.Cadastro, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TServiceBaseCadastro1 = class(TServiceBaseCadastro)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ServiceBaseCadastro1: TServiceBaseCadastro1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
