unit uGUIHashTest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls
  , ufrmeditHash
  , BOM_Hash
  , tiOPFManager
  , tiObject
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;


 var
  Form1: TForm1;

implementation

uses
  connection_util
  , SUPPORT_Hash
  , FACTORY_Hash
  , uListManager
  ;


{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  PathName, Filename : string;
  lFound : Boolean;
  lConnected: boolean;
  aHashList : THashList;
  aHash : THash;
begin
  // Setup
  with mDBConnect do
    begin
      DBPath := IncludeTrailingBackslash(ExtractFileDir(Application.ExeName))+'TestDB.sq3';
      UserName := 'tester'; // meaningless for SQLite
      Password := 'secret'; // meaningless for SQLite
    end;
  PathName := ExtractFileDir(mDBConnect.DBPath);
  FileName := IncludeTrailingBackslash(PathName) + 'sqlite3.dll';
  lFound:= FileExists(Filename);
  if not lFound then
  begin
    showmessage('sqlite3.dll not found');
    exit;
  end;
  lConnected := ConnectToDatabase(mDBConnect.DBPath, mDBConnect.DBHost,
      mDBConnect.UserName, mDBConnect.Password);
  if not lConnected then
  begin
    showmessage('cannot connect to DB');
    exit;
  end;
  if not GTIOPFManager.TableExists('Hashes') then
    SUPPORT_Hash.CreateTables;
  aHashList := gListManager.HashList;
  aHashList.Clear;

  aHash := THash(gHashFactory.CreateInstance('Hash'));
  aHash.Filename:='C:\Dummy0';
  aHash.FileHash:='1234567890';
  aHash.Dirty:=true;
  aHashList.Add(aHash);

  aHash := THash(gHashFactory.CreateInstance('Hash'));
  aHash.Filename:='C:\Dummy1';
  aHash.FileHash:='1234567891';
  aHash.Dirty:=true;
  aHashList.Add(aHash);

  aHash := THash(gHashFactory.CreateInstance('Hash'));
  aHash.Filename:='C:\Dummy2';
  aHash.FileHash:='1234567892';
  aHash.Dirty:=true;
  aHashList.Add(aHash);

  aHash := THash(gHashFactory.CreateInstance('Hash'));
  aHash.Filename:='C:\Dummy3';
  aHash.FileHash:='1234567893';
  aHash.Dirty:=true;
  aHashList.Add(aHash);
  aHashList.Dirty:=true;

  aHashList.Save;

  try
    TfrmEditHash.Execute(aHashList, false);
  finally
//    DisconnectFromDatabase(mDBConnect.DBPath, mDBConnect.DBHost);
//    DeleteDatabase(mDBConnect.DBPath, mDBConnect.DBHost);
  end;
end;

end.


