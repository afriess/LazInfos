unit DBConnect_TST;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry;

type

  { TTestDBConnect }

  TTestDBConnect= class(TTestCase)
  protected
    procedure SetUp; override;
    procedure TearDown; override;
    // Nicht verwendet aktuell
    procedure TestDeleteIfNeededDB;
    procedure TestConnect;
    procedure TestDisconnect;
    procedure TestDeleteDatabase;
  published
    procedure TestPrerequisitesSQLite;
  end;

implementation
uses
  connection_util;


procedure TTestDBConnect.SetUp;
begin

end;

procedure TTestDBConnect.TearDown;
begin

end;

procedure TTestDBConnect.TestConnect;
var
  lConnected: boolean;
begin
  lConnected := ConnectToDatabase(mDBConnect.DBPath, mDBConnect.DBHost,
    mDBConnect.UserName, mDBConnect.Password);

  AssertTrue('Could not connect to database', lConnected);

end;

procedure TTestDBConnect.TestDisconnect;
var
  lDisConnected: boolean;
begin
  lDisConnected := DisconnectFromDatabase(mDBConnect.DBPath, mDBConnect.DBHost);
  AssertFalse('Could not disconnect from database', lDisConnected);
end;

procedure TTestDBConnect.TestDeleteDatabase;
var
  lDeleteDB: boolean;
begin
  lDeleteDB := DeleteDatabase(mDBConnect.DBPath, mDBConnect.DBHost);
  AssertFalse('Not able to delete Database', DatabaseFileExists(mDBConnect.DBPath, mDBConnect.DBHost));
end;

procedure TTestDBConnect.TestDeleteIfNeededDB;
begin
  DeleteDatabase(mDBConnect.DBPath, mDBConnect.DBHost);
  AssertFalse('Database was not deleted', DatabaseFileExists(mDBConnect.DBPath, mDBConnect.DBHost));
end;

procedure TTestDBConnect.TestPrerequisitesSQLite;
var
  PathName, Filename : string;
  lFound : Boolean;
begin
  PathName := ExtractFileDir(mDBConnect.DBPath);
  FileName := IncludeTrailingBackslash(PathName) + 'sqlite3.dll';
  lFound:= FileExists(Filename);
  AssertTrue('Found not the required sqlite3.dll in testdirectory', lFound);
end;

end.

