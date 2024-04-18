unit MobilePermissions.UsesPermissions.Factory;

interface

uses
  MobilePermissions.UsesPermissions.FMX.Standard,
  MobilePermissions.UsesPermissions.FMX.Dangerous,
  MobilePermissions.UsesPermissions.FMX.Signature,
  MobilePermissions.UsesPermissions.Interfaces;

type TFactoryUsesPermissions = class(TInterfacedObject, IFactoryUsesPermissions)

  public
    function createPermissionsStandard : IUsesPermissionsStandard;
    function createPermissionsDangerous: IUsesPermissionsDangerous;
    function createPermissionsSignature: IUsesPermissionsSignature;

    class function New: IFactoryUsesPermissions;
end;

implementation

{ TFactoryUsesPermissions }

function TFactoryUsesPermissions.createPermissionsDangerous: IUsesPermissionsDangerous;
begin
  // OTA
  if Assigned(FPermissionsDangerous) then
    Exit(FPermissionsDangerous);

  Exit( TUsesPermissionsFMXDangerous.New );
end;

function TFactoryUsesPermissions.createPermissionsSignature: IUsesPermissionsSignature;
begin
  // OTA
  if Assigned(FPermissionsSignature) then
    Exit(FPermissionsSignature);

  Exit( TUsesPermissionsFMXSignature.New );
end;

function TFactoryUsesPermissions.createPermissionsStandard: IUsesPermissionsStandard;
begin
  // OTA
  if Assigned(FPermissionsStandard) then
    Exit(FPermissionsStandard);

  Exit( TUsesPermissionsFMXStandard.New );
end;

class function TFactoryUsesPermissions.New: IFactoryUsesPermissions;
begin
  result := Self.Create;
end;

end.
