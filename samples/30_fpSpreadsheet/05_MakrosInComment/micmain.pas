unit micMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SdfData, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, fpspreadsheetctrls, fpspreadsheetgrid;

const
  // we define a special char for the search
  // wir definieren einen speziellen Charakter für die Suche
  co_makrochar = ':';

type

  { TFormMiC }

  TFormMiC = class(TForm)
    BuSample: TButton;
    EdData: TEdit;
    EdExcel: TEdit;
    LblExcel: TLabel;
    LblData: TLabel;
    MemoLog: TMemo;
    PanelDetail: TPanel;
    sCellEdit1: TsCellEdit;
    sCellIndicator1: TsCellIndicator;
    sWbSrc: TsWorkbookSource;
    sWorkbookTabControl: TsWorkbookTabControl;
    sWSGrid: TsWorksheetGrid;
    procedure BuSampleClick(Sender: TObject);
    procedure sWSGridClick(Sender: TObject);
  private
    FileExcel,
    FileCsv : String;
    procedure Test01;
  public

  end;

var
  FormMiC: TFormMiC;

implementation

uses
  Grids
  , fpspreadsheet
  // for TsSearchParams,.. we need fpsTypes
  // für TsSearchParams,.. benötigen wir fpsTypes
  , fpsTypes
  // for InitSearchParams,.. we need fpsutils
  // für InitSearchParams,.. benötigen wir fpsutils
  , fpsutils
  // fpsallformats needed for the detection of the supported format !!
  //   without, you get an unsupported format error at runtime
  //   in some laz-packages it is loaded, in some not
  //   so its safer to use it here
  // fpsallformats wird zwingend benötigt um das verwendete Format zu erkennen !!
  //   ohne, gibt es einen Fehler unsupported format error zur Laufzeit
  //   in einigen Laz-Pakete ist es enthalten, in einigen nicht
  //   so ist es besser es hier zu verwenden
  , {%H-}fpsallformats
  // for TsSearchEngine,.. we need fpsSearch
  // für TsSearchEngine,.. benötigen wir fpsSearch
  , fpsSearch
  // for TFieldType,.. we need db
  // für TFieldType,.. benötigen wir db
  , db
  ;

{$R *.lfm}

function ReplaceCellWithCode(wb: TsWorkBook; code, replace: string): Boolean;
var
  MyRow, MyCol: Cardinal;
  MyWorksheet: TsWorksheet;
  MySearchParams: TsSearchParams;
  MyReplacParams: TsReplaceParams;

begin
  Result := False;
  MySearchparams := InitSearchParams(code, [soEntireDocument], swWorkbook);
  MyReplacParams := InitReplaceParams(replace, [roReplaceEntireCell]);
  // Create search engine and execute replace
  MyRow := 0;
  MyCol := 0;
  with TsSearchEngine.Create(wb) do begin
    Result:= ReplaceFirst(MySearchParams, MyReplacParams, MyWorksheet, MyRow, MyCol);
    Free;
  end;
end;

function FindCellWithCode(wb: TsWorkBook; code: string): PCell;
var
  MyRow, MyCol: Cardinal;
  MyWorksheet: TsWorksheet;
  MySearchParams: TsSearchParams;
begin
  Result := nil;
  MySearchparams := InitSearchParams(code, [soEntireDocument], swWorkbook);
  // Create search engine and execute search
  MyRow := 0;
  MyCol := 0;
  with TsSearchEngine.Create(wb) do begin
    if FindFirst(MySearchParams, MyWorksheet, MyRow, MyCol) then
      Result := MyWorksheet.FindCell(MyRow, MyCol);
    Free;
  end;
end;

{ TFormMiC }

procedure TFormMiC.BuSampleClick(Sender: TObject);
begin
  MemoLog.Clear;
  FileCsv:= EdData.Text;
  FileExcel:= EdExcel.Text;
    // Check if file exists
  if not FileExists(FileCsv) then begin
    MemoLog.Append('Datafile: '+ FileCsv +' not found');
    exit;
  end;
  if not FileExists(FileExcel) then begin
    MemoLog.Append('Excelfile: '+ FileExcel +' not found');
    exit;
  end;
  // select test
  Test01;
end;

procedure TFormMiC.sWSGridClick(Sender: TObject);
begin

end;

// Replace nothing, shows only the sheet
// Ersetzt gar nichts, zeigt nur das Sheet Arbeitsblatt an
procedure TFormMiC.Test01;
var
 Q : TSdfDataSet;
 i: Integer;
 code, replace: String;
begin
  MemoLog.Append('Test01 start');
  Q:= TSdfDataSet.Create(nil);
  try
    // Open the dataset
    Q.FileName:= EdData.Text;
    Q.FileMustExist:= True;
    Q.FirstLineAsSchema:=True;
    Q.Open;
    // Load the Excelsheet
    sWSGrid.Options:= sWSGrid.Options + [goColSizing, goRowSizing];
    sWbSrc.LoadFromSpreadsheetFile(EdExcel.Text);
    // do nothing - Dummy
    Q.Close;
  finally
    Q.Free;
  end;
  MemoLog.Append('Done...');
end;

end.

