unit connection_util;

{$IFDEF FPC}
  {$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  Classes
  ,SysUtils
  ,tiQuerySqldbSQLite3  // SQLite 3 with SqlDB is used
  ,tiOPFManager
  ,tiConstants
  ,tiOIDGUID
  ;

type

  TConnectRec = record
    DBHost: string;
    DBPath: string;
    UserName: string;
    Password: string;
  end;


function ConnectToDatabase(const ADataSource: string; const AServer: string;
  const AUser: string; const APass: string): boolean;

function DisconnectFromDatabase(const ADataSource: string;
  const AServer: string):Boolean;

function DeleteDatabase(const ADataSource: string;
  const AServer: string):Boolean;

function DatabaseFileExists(const ADataSource: string;
  const AServer: string):Boolean;

var
  mDBConnect: TConnectRec;

implementation

var
    mConnected: boolean;

{ SQLite3 only: Connect to the Database. If no DB exists, a new one will created }
function ConnectToDatabase(const ADataSource: string; const AServer: string;
  const AUser: string; const APass: string): boolean;
var
  lResource: string;
begin

  result := mConnected;

  if not result then
    begin
      GTIOPFManager.DefaultPersistenceLayerName := cTIPersistSqldbSQLite3;

      if AServer <> '' then
        lResource := AServer + ':' + ADataSource
      else
        lResource := ADataSource;

      result := GTIOPFManager.TestThenConnectDatabase(lResource, AUser, APass);
      mConnected := result;

    end;

end;

{ SQLite3 only: Disconnect from the Database.}
function DisconnectFromDatabase(const ADataSource: string; const AServer: string):Boolean;
var
  lResource: string;
begin
  Result := false;
  if AServer <> '' then
    lResource := AServer + ':' + ADataSource
  else
    lResource := ADataSource;
  try
//    GTIOPFManager.DisconnectDatabase(lResource);
    if gTIOPFManager.DefaultPerLayer.DBConnectionPools.Count > 0 then
    begin
      gTIOPFManager.DisconnectDatabase;
      Result := true;
    end;
  finally
    // Nothing
  end;
end;

{ SQLite3 only: Delete the Database from Filesystem }
function DeleteDatabase(const ADataSource: string; const AServer: string
  ): Boolean;
var
  lResource: string;
begin
  Result := false;
  if AServer <> '' then
    lResource := AServer + ':' + ADataSource
  else
    lResource := ADataSource;
  // Delete the file
  if FileExists(lResource) then
    DeleteFile(lResource);
  Result := not FileExists(lResource);
end;

function DatabaseFileExists(const ADataSource: string; const AServer: string
  ): Boolean;
var
  lResource: string;
begin
  Result := false;
  if AServer <> '' then
    lResource := AServer + ':' + ADataSource
  else
    lResource := ADataSource;
  Result := FileExists(lResource);
end;

end.

