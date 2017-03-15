unit SUPPORT_Hash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,BOM_Hash
  ,tiOPFManager
  ,mapper
  ;


{ CreateTables }
procedure CreateTables;

{ DeleteTables }
procedure DeleteTables;

implementation
uses
  tiQuery
  , tiLog
  ;


procedure CreateTables;
var
  lMD : TtiDBMetaDataTable;
begin
  Log('SUPPORT_Hash.CreateTables: Create Table in DB', lsDebug);

  // Create the needed tables
  lMD :=TtiDBMetaDataTable.Create;
  try
    lMD.AddInstance('HashID', qfkString, 36);
    lMD.AddInstance('FileHash', qfkString, 255);
    lMD.AddInstance('FileName', qfkString, 255);
    lMD.AddInstance('StoreDate', qfkDateTime, 0);
    lMD.Name := 'Hashes';
    gTIOPFManager.CreateTable(lMD);
  finally
    lMD.Free;
  end;
end;

procedure DeleteTables;
begin
  Log('SUPPORT_Hash.DeleteTables: Delete Table Hashes in DB', lsDebug);
  if GTIOPFManager.TableExists('Hashes') then
    GTIOPFManager.DropTable('Hashes');

end;


end.

