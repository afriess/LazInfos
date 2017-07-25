unit mainworktemplatesXLSX;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Spin, ComCtrls, fpsTypes, fpspreadsheetctrls, fpspreadsheetgrid, fgl;

type

  { TWorkPageSource }

  TWorkPageSource = class(TsWorkbookSource)
  private
    FZusatztext: String;
    procedure SetZusatztext(AValue: String);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Zusatztext: String read FZusatztext write SetZusatztext;
  end;

  TWBSrcList = specialize TFPGObjectList<TWorkPageSource>;

  { TForm1 }

  TForm1 = class(TForm)
    BuLoad: TButton;
    BuSave: TButton;
    BuContent: TButton;
    ComboBox: TComboBox;
    Edit1: TEdit;
    Memo: TMemo;
    SpinEdit: TSpinEdit;
    sWorkbookTabControl1: TsWorkbookTabControl;
    sWorksheetGrid1: TsWorksheetGrid;
    TabControl1: TTabControl;
    procedure BuContentClick(Sender: TObject);
    procedure BuLoadClick(Sender: TObject);
    procedure BuSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
  private
    WBSrcList : TWBSrcList;
  public

  end;

var
  Form1: TForm1;

implementation

uses
  fpspreadsheet
  , {%H-}fpsallformats  // zwingend für das Laden benötigt !!
  , LazUTF8
  , fpsutils
  , fpsSearch
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
  MySearchparams := InitSearchParams(code, [soEntireDocument,soSearchInComment], swWorkbook);
  MyReplacParams := InitReplaceParams(replace, [roReplaceEntireCell]);
  // Create search engine and execute replace
  MyRow := 0;
  MyCol := 0;
  with TsSearchEngine.Create(wb) do begin
    Result:= ReplaceFirst(MySearchParams, MyReplacParams, MyWorksheet, MyRow, MyCol);
    Free;
  end;
end;

{ TWorkPageSource }

procedure TWorkPageSource.SetZusatztext(AValue: String);
begin
  if FZusatztext=AValue then Exit;
  FZusatztext:=AValue;
end;

constructor TWorkPageSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TWorkPageSource.Destroy;
begin
  inherited Destroy;
end;

{ TForm1 }

procedure TForm1.BuLoadClick(Sender: TObject);
var
  InputFileName: RawByteString;
  i: Integer;
  MyWBS: TWorkPageSource;
  book: TsWorkbook;
begin
  // Open the input file
  InputFileName := Edit1.Text;
  if not FileExists(InputFileName) then begin
    Memo.Append('Input file '+ InputFileName+ ' does not exist.');
    exit; // ==>>
  end;
  Memo.Append('Opening input file '+ InputFilename);
  sWorksheetGrid1.WorkbookSource:= Nil;
  WBSrcList.Clear;
  TabControl1.Tabs.Clear;
  for i:= 0 to SpinEdit.Value-1 do begin
    MyWBS:= TWorkPageSource.Create(nil);
    // Lesen der Vorlage
    book := TsWorkbook.Create;
    book.Options:=book.Options+[boReadFormulas];
    book.ReadFromFile(InputFileName,sfidUnknown);
    MyWBS.LoadFromWorkbook(book);
    // In die Liste aufnehmen und Tab erstellen
    WBSrcList.Add(MyWBS);
    TabControl1.Tabs.Add('Tab ' + IntToStr(i));
  end;
  TabControl1Change(nil);
end;

procedure TForm1.BuContentClick(Sender: TObject);
begin
  ReplaceCellWithCode(sWorksheetGrid1.Workbook,':test',FormatDateTime('hh:mm:ss',Now));
end;

procedure TForm1.BuSaveClick(Sender: TObject);
var
  Filename : String;
  idx: Integer;
  WBSrc : TWorkPageSource;
begin
  FileName := '';
  idx:= TabControl1.TabIndex;
  // Ist ein Tab selected
  if idx < 0 then exit; //==>>
  // Ist das Sheet vorhanden
  if (WBSrcList.Count-1) < idx then exit; //==>>
  // Anzeigen
  WBSrc:= WBSrcList[idx];
  // Erzeuge Dateinamen füpr Test
  Filename:= FormatDateTime('YYYYMMDDhhmmss',Now) + '_Test';
  WBSrc.SaveToSpreadsheetFile(ChangeFileExt(FileName,'.xls'),TsSpreadsheetFormat.sfExcel8,True);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  WBSrcList:= TWBSrcList.Create(True);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Assigned(WBSrcList) then
    FreeAndNil(WBSrcList);
end;

procedure TForm1.TabControl1Change(Sender: TObject);
var
  idx: Integer;
begin
  idx:= TabControl1.TabIndex;
  // Ist ein Tab selected
  if idx < 0 then exit; //==>>
  // Ist das Sheet vorhanden
  if (WBSrcList.Count-1) < idx then exit; //==>>
  // Anzeigen
  sWorksheetGrid1.WorkbookSource:= WBSrcList[idx];
end;

end.

