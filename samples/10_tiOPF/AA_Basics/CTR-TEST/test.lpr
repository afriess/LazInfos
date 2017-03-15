program test;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent
//  , tiQuerySqldbSQLite3 // SQLite 3 with SqlDB is used
  , SysUtils
  , tiQueryZeosMySQL50
  , tiUtils
  , tiOPFManager
  , tiConstants
  , tiLog
  , tiLogToFile
  , GuiTest, contact_bom, frm_edittitle, contactdisplay,
  contactmodel;

{$R *.res}

procedure StartLog;
var
  aFileName : String;
  i : Integer;
  LS : String;
begin
  // Log
  aFileName := tiSwapExt(ParamStr(0),'log');
  gLog.RegisterLog(TtiLogToFile.CreateWithFileName(ExtractFilePath(aFileName),ExtractFileName(aFileName),True));
  gLog.SevToLog :=  [
    lsNormal
    ,lsUserInfo
    ,lsObjCreation
    ,lsVisitor
    ,lsConnectionPool
    ,lsAcceptVisitor
    ,lsQueryTiming
    ,lsDebug
    ,lsWarning
    ,lsError
    ,lsSQL
    ];
  Log('Starting', lsNormal);
  GTIOPFManager.DefaultPersistenceLayerName := cTIPersistZeosMySQL50;
  LS := '';
  for i := 0 to GTIOPFManager.PersistenceLayers.Count - 1 do
  begin
    if LS <> '' then
      LS := LS + cLineEnding;
    if Trim(GTIOPFManager.PersistenceLayers.Items[i].DBConnectionPools.DetailsAsString) = '' then
      LS := LS + 'Persistence layer: "'+ GTIOPFManager.PersistenceLayers.Items[i].PersistenceLayerName +
            '" loaded, but not connected to a database.'
    else
      LS := LS + GTIOPFManager.PersistenceLayers.Items[i].DBConnectionPools.DetailsAsString
  end;
  if LS <> '' then
    Log(LS, lsDebug)
  else
    Log('No persistence layers loaded', lsDebug);
end;


begin
  Application.Title:='CTR-NEU';
  RequireDerivedFormResource:=True;
  StartLog;
  Application.Initialize;
  Application.CreateForm(TfrmGuiTest, frmGuiTest);
  Application.CreateForm(TEditTitle, EditTitle);
  Application.Run;
end.

