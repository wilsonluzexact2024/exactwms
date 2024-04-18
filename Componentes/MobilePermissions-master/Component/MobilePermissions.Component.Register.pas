unit MobilePermissions.Component.Register;

interface

uses
  {$IFDEF MSWINDOWS} DesignIntf, {$ENDIF}
  MobilePermissions.Component,
  MobilePermissions.Component.Editor,
  MobilePermissions.UsesPermissions.Interfaces,
  MobilePermissions.UsesPermissions.OTA.Standard,
  MobilePermissions.UsesPermissions.OTA.Dangerous,
  MobilePermissions.UsesPermissions.OTA.Signature,
  System.Classes;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('TDevRocks', [TMobilePermissions]);
  {$IFDEF MSWINDOWS}
  RegisterComponentEditor(TMobilePermissions, TMobilePermissionsEditor);
  {$ENDIF}
end;

initialization
  // Precisei colocar aqui para isolar a ToolsAPI do fonte;
  // Sen�o o projeto que usasse o componente precisaria referenciar tamb�m o
  // designide no RuntimePackage do Projeto.
  FPermissionsSignature := TUsesPermissionsOTASignature.New;
  FPermissionsDangerous := TUsesPermissionsOTADangerous.New;
  FPermissionsStandard  := TUsesPermissionsOTAStandard.New;

end.
