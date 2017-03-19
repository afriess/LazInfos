unit tiFileSyncDependencies;

{ $ MODE Delphi}

{$I tiDefines.inc}

interface
uses
   tiOIDGUID
  ,cFileSync
  ,tiFileSyncReader_Abs
  ,tiFileSyncReader_DiskFiles
  {$IFDEF UseRemoteSync}
  ,tiFileSyncReader_Remote
  ,tiHTTPIndy
  {$ENDIF}
  ,tiFileSyncSetup_BOM
  ,tiFileName_BOM
  ,tiFileSync_Mgr
  ,tiCompressZLib
 ;

procedure ConnectToDatabase;
procedure RegisterMappings;

implementation
uses
   tiUtils
  ,tiOPFManager
  ,tiConstants
 ;

procedure RegisterMappings;
begin
  tiFileSyncSetup_BOM.RegisterMappings;
end;

procedure ConnectToDatabase;
var
  lDB : string;
begin
  lDB := tiSwapExt(ParamStr(0), 'xml');
  if not gTIOPFManager.TestThenConnectDatabase(lDB,  'null', 'null', cTIPersistXMLLight) then
  begin
    gTIOPFManager.CreateDatabase(lDB,  'null', 'null', cTIPersistXMLLight);
    gTIOPFManager.TestThenConnectDatabase(lDB,  'null', 'null', cTIPersistXMLLight);
    tiFileSyncSetup_BOM.CreateTables;
  end;

end;

end.
