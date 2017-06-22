unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  fpspreadsheetgrid, fpspreadsheet, fpstypes, fpsutils;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    TemplateGrid: TsWorksheetGrid;
    FinalGrid: TsWorksheetGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TemplateGridClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  StrUtils;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  cell: PCell;
  rcell: PCell;
  finalformula: String;
  templateformula: String;
begin
  for cell in TemplateGrid.Worksheet.Cells do begin
    templateformula := '';
    finalformula := '';
    if HasFormula(cell) then begin
      // Remember original formula
      templateFormula := cell^.Formulavalue;
      // Replace placeholder to get new formula
      finalformula := StringReplace(templateFormula, '#(RANGEEND)', Edit1.Text, [rfReplaceAll, rfIgnoreCase]);
      // Workaround to avoid checking of template formula when template cell is copied
      cell^.Formulavalue := 'A1';
    end;
    // Copy template cell to new sheet
    FinalGrid.Worksheet.CopyCell(cell^.Row, cell^.Col, cell^.Row, cell^.Col, TemplateGrid.Worksheet);
    // If the cell has a formula attach the formula to the cell in the new sheet
    if finalformula <> '' then
      FinalGrid.Worksheet.WriteFormula(cell^.Row, cell^.Col, finalformula);
    // Restore formula in template sheet
    if templateformula <> '' then
      cell^.Formulavalue := templateformula;
  end;

  Finalgrid.Worksheet.CalcFormulas;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  TemplateGrid.Workbook.Options := TemplateGrid.Workbook.Options - [boAutoCalc, boReadFormulas];

  TemplateGrid.Worksheet.WriteNumber(0, 0, 1);
  TemplateGrid.Worksheet.WriteNumber(1, 0, 2);
  TemplateGrid.Worksheet.WriteNumber(2, 0, -3);
  TemplateGrid.Worksheet.WriteNumber(3, 0, -1);
  TemplateGrid.Worksheet.WriteNumber(4, 0, 1);
  TemplateGrid.Worksheet.WriteNumber(5, 0, 2.5);
  TemplateGrid.Worksheet.WriteNumber(6, 0, -2.5);

  TemplateGrid.Worksheet.Writeformula(0, 1, 'SUM(A1:#(RANGEEND))');
end;

procedure TForm1.TemplateGridClick(Sender: TObject);
var
  cell: PCell;
begin
  cell := TemplateGrid.Worksheet.FindCell(TemplateGrid.Row-1, templateGrid.Col-1);
  if HasFormula(cell) then
    Label2.Caption := cell^.Formulavalue else
    Label2.Caption := '- no formula -';
end;

end.

