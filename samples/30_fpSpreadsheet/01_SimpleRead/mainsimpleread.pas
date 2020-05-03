unit mainsimpleread;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpsTypes, fpspreadsheetctrls, fpspreadsheetgrid;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Memo: TMemo;
    OpenDialog: TOpenDialog;
    sWorkbookSource: TsWorkbookSource;
    sWorkbookTabControl1: TsWorkbookTabControl;
    sWorksheetGrid1: TsWorksheetGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    InputFileName: TCaption;
    function GetFileName: boolean;
  public

  end;

var
  Form1: TForm1;

implementation

uses
  fpspreadsheet, LazUTF8, fpsutils
  // needed for the detection of the supported format !!
  // wird zwingend benötigt um das verwendete Format zu erkennen !!
  , {%H-}fpsallformats
  // without, you get an unsupported format error at runtime
  // in some laz-packages it is loaded, in some not
  // so its safer to use it here
  // ohne, gibt es einen Fehler unsupported format error zur Laufzeit
  // in einigen Laz-Pakete ist es enthalten, in einigen nicht
  // so ist es besser es hier zu verwenden
  ;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  MyWorkbook: TsWorkbook;
  MyWorksheet: TsWorksheet;
  CurCell: PCell;
begin
  // Open the input file
  if not GetFileName then
    exit; //==>>
  // Create the spreadsheet
  MyWorkbook := TsWorkbook.Create;
  try
    MyWorkbook.Options := MyWorkbook.Options + [boReadFormulas];
    MyWorkbook.ReadFromFile(InputFilename, sfExcel8);
    MyWorksheet := MyWorkbook.GetFirstWorksheet;

    // Write all cells with contents to the console
    Memo.Append('');
    Memo.Append('Contents of the first worksheet of the file:');
    Memo.Append('');

    for CurCell in MyWorksheet.Cells do
    begin
      Memo.Append('Row: '+ intTostr(CurCell^.Row)+
       ' Col: '+ IntToStr(CurCell^.Col) + ' Value: ' +
       UTF8ToConsole(MyWorkSheet.ReadAsText(CurCell^.Row,
         CurCell^.Col))
       );
      if HasFormula(CurCell) then
        Memo.Append(' Formula: '+ MyWorkSheet.ReadFormulaAsString(CurCell))
      else
        Memo.Append('');
    end;

  finally
    // Finalization
    MyWorkbook.Free;
  end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  // Open the input file
  if not GetFileName then
    exit; //==>>
  sWorkbookSource.FileFormat:=sfUser;
  sWorkbookSource.AutoDetectFormat:= True;
  sWorkbookSource.Options:= sWorkbookSource.Options + [boReadFormulas];
  sWorkbookSource.FileName:= InputFileName;
end;

function TForm1.GetFileName:boolean;
begin
  Result := False;
  // Open the input file
  InputFileName := Edit1.Text;
  while not FileExists(InputFileName) do begin
    Memo.Append('Input file '+ InputFileName+ ' does not exist.');
    if not OpenDialog.Execute then begin
      Memo.Append('canceld');
      exit; // ==>>
    end;
    Memo.Append('Open dialog now');
    InputFileName:= OpenDialog.FileName;
  end;
  Memo.Append('Opening input file '+ InputFilename);
  Result:= True;
end;

end.

