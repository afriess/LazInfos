unit uSheets;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpspreadsheetctrls, fpspreadsheetgrid, fpspreadsheet;

type

  { TForm1 }

  TForm1 = class(TForm)
    BuCreateSheets: TButton;
    BuWP: TButton;
    sWorkbookSource: TsWorkbookSource;
    sWorkbookTabControl: TsWorkbookTabControl;
    sWorksheetGrid: TsWorksheetGrid;
    procedure BuCreateSheetsClick(Sender: TObject);
    procedure BuWPClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.BuCreateSheetsClick(Sender: TObject);
var
  i: Integer;
  strWsName: String;
begin
  // Clear all old sheets
  sWorkbookSource.CreateNewWorkbook;
  // Create 5 Sheets with different name
  for i:= 0 to 5 do begin
    strWsName := 'WS'+IntToStr(i+1);
    sWorkbookSource.Workbook.AddWorksheet(strWsName,False);
  end;
  // Now its safe to remove the unwanted sheet
  sWorkbookSource.Workbook.RemoveWorksheet(sWorkbookSource.Workbook.GetWorksheetByIndex(0));
end;

procedure TForm1.BuWPClick(Sender: TObject);
var
  i: Integer;
  strWsName: String;
  book: TsWorkbook;
begin
  book := TsWorkbook.Create;
  for i:=0 to 5 do begin
    strWsName := 'WS' + IntToStr(i+1);
    book.AddWorksheet(strWsName, false);
  end;
  sWorkbookSource.LoadFromWorkbook(book);
  // book not freed, because it is used in WorkbookSource
  // book nicht freigeben, da es im WorkbookSource weiterverwendet wird
end;

end.

