unit tdbfrmmain;

{$mode objfpc}{$H+}
{$modeswitch nestedprocvars}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, XMLPropStorage, Grids, DBGrids, ZConnection, ZSqlProcessor, ZDataset
  ,LazLogger;

type

  { TtdbFormMain }

  TtdbFormMain = class(TForm)
    BuScriptDB: TButton;
    BuConvert: TButton;
    LEConFile: TLabeledEdit;
    LEScript: TLabeledEdit;
    LEdb: TLabeledEdit;
    Memo: TMemo;
    TestCon: TZConnection;
    SQLProcessor: TZSQLProcessor;
    XMLPropStorage1: TXMLPropStorage;
    procedure BuConvertClick(Sender: TObject);
    procedure BuScriptDBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  tdbFormMain: TtdbFormMain;

implementation

uses
  lcsvutils
  , UTextFileStream
  ;

{$R *.lfm}

{ TtdbFormMain }

procedure TtdbFormMain.FormCreate(Sender: TObject);
begin
  DebugLnEnter('FormCreate start');
  //
  DebugLnExit('FormCreate end');
end;

procedure TtdbFormMain.BuScriptDBClick(Sender: TObject);
var
  sl : TStringList;
  DBFile, DBSQLListe : String;
  i: Integer;
  myConnect : TZConnection;
begin
  myConnect := TestCon;
  myConnect.Connected:=false;
  sl := TStringList.Create;
  DBFile := '';
  DBSQLListe := '';
  try
    Memo.Append('BuCreateDBClick');
    Memo.Append('delete old DB start');
    TestCon.Connected:=false;
    //
    DBFile := LEdb.Text;
    DBSQLListe:= LEScript.Text;
    if FileExists(DBFile) then begin
      Memo.Append('DB File exists '+DBFile+'-> delete');
      try
        DeleteFile(DBFile);
        Memo.Append('deleted');
      except
        on e:exception do
          Memo.Append('Exception: '+e.ToString);
      end;
    end
    else begin
      Memo.Append('DB File not exists '+DBFile);
    end;
    DebugLnExit('delete old DB end');
    //
    Memo.Append('Open DB start');
    TestCon.Protocol := 'sqlite-3';
    TestCon.HostName:='';
    TestCon.User:='tester';
    TestCon.Password := 'tester';
    TestCon.Database:= DBFile;
    //TestCon.LibraryLocation:='driver';
    // Wenn es die DB nicht gibt, so legt Connected die bei SQLite an
    TestCon.Connected:=true;
    Memo.Append('Open DB end');
    //
    // Use the sqlProzessor to execute all the statements
    DBSQLListe:= LEScript.Text;
    Memo.Append('SQL-List start');
    sl.Clear;
    SQLProcessor.Connection := myConnect;
    if FileExists(DBSQLListe) then begin
      Memo.Append('SQL-List exists: '+DBSQLListe);
      try
        sl.LoadFromFile(DBSQLListe);
        Memo.Append('loaded '+ IntToStr(sl.Count) + ' entries');
      except
        on e:exception do
          Memo.Append('Exception: '+e.ToString);
      end;
    end
    else begin
      Memo.Append('SQL-List did not exists '+DBSQLListe);
    end;
    Memo.Append('SQL-List end');
    Memo.Append('Process list start');
    for i := 0 to sl.Count -1 do begin
      Memo.Append('Process line '+IntToStr(i));
      if FileExists(sl[i]) then begin
        Memo.Append('SQL-File exists: '+sl[i]);
        try
          SQLProcessor.Clear;
          SQLProcessor.LoadFromFile(sl[i]);
          Memo.Append('SQL-File executing: '+sl[i]);
          SQLProcessor.Execute;
        except
          on e:exception do
            Memo.Append('Exception: '+e.ToString);
        end;
      end
    end;
    Memo.Append('Process list end');
  finally
    sl.Free;
  end;
  Memo.Append('BuCreateDBClick end');
end;


procedure TtdbFormMain.BuConvertClick(Sender: TObject);
var
  FileName : String;
  TFSW : TTextFileStream;
  LineCount : Integer;
  strTemp : String;

  procedure NewRecord(Fields:TStringlist);
  var
    i: Integer;
  begin
    inc(LineCount);
    if (Fields.Count = 0) then
    begin
      Memo.Append('Empty line: '+IntToStr(LineCount) + ' skipping');
      exit;
    end;
    if ((LineCount mod 100) = 0) then Memo.Append('Process line: '+IntToStr(LineCount));
    if (LineCount <= 1) then begin
      // First line
      Memo.Append('First line: '+IntToStr(LineCount));
      exit;
    end
    else begin
      // All other lines
      strTemp := strTemp
      +'INSERT OR REPLACE INTO [DEMO] (' + LineEnding
      +'   [MyDate],' + LineEnding
      +'   [Value1],' + LineEnding
      +'   [Value2],' + LineEnding
      +'   [Value3],' + LineEnding
      +'   [Value4],' + LineEnding
     +'   [PK_identity])' + LineEnding
      +' VALUES (' + LineEnding;
      for i:= 0 to Fields.Count-(1) do begin
        strTemp:=strTemp
        +'    '''+Fields.Strings[i]+''','+LineEnding;
      end;
      strTemp:=strTemp
        +'    '''+IntToStr(LineCount)+''' '+LineEnding
        +' );'+LineEnding+LineEnding;
      //
    end;
  end;

begin
  FileName := LEConFile.Text;
  if not FileExists(FileName) then begin
    Memo.Append('Error -> file '+FileName+' didnt exists');
    exit;
  end;
  TFSW:= TTextFileStream.Create(ChangeFileExt(FileName,'.sql'),fmCreate);
  try
    strTemp:='';
    strTemp:='DROP TABLE IF EXISTS [DEMO];'+LineEnding+LineEnding
      +'CREATE TABLE IF NOT EXISTS [DEMO] ('+LineEnding
      +'	[MyDate] [int] NOT NULL, '+LineEnding
      +'	[Value1] [varchar](256) NULL, '+LineEnding
      +'	[Value2] [varchar](256) NULL, '+LineEnding
      +'	[Value3] [varchar](256) NULL, '+LineEnding
      +'	[Value4] [varchar](256) NULL, '+LineEnding
      +'	[PK_identity] [int] NOT NULL '+LineEnding
      +'); '+LineEnding+LineEnding;
    LineCount:=0;
    LCSVUtils.LoadFromCSVFile(FileName, @NewRecord, ',');
    if strTemp='' then strTemp :='nothing';
    TFSW.Write(strTemp[1], Length(strTemp));
    TFSW.Write(LineEnding, Length(LineEnding));
  finally
    TFSW.Free;
  end;
end;


end.

