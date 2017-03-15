unit frm_edittitle;

{$mode objfpc}{$H+}

interface

uses
  Classes
  , SysUtils
  , FileUtil
  , Forms
  , Controls
  , Graphics
  , Dialogs
  , StdCtrls
  , tiModelMediator
  , contactmodel
  ;

type

  { TEditTitle }

  TEditTitle = class(TForm)
    btnAbort: TButton;
    btnSaveExit: TButton;
    btnDebug: TButton;
    cbTitleType: TComboBox;
    edSearchTitle: TEdit;
    edTitle: TEdit;
    edTitleType: TEdit;
    procedure btnAbortClick(Sender: TObject);
    procedure btnDebugClick(Sender: TObject);
    procedure btnSaveExitClick(Sender: TObject);
  private
    FMediator: TtiModelMediator;
    FData: TContactTitle;
    procedure SetData(const AValue: TContactTitle);
    procedure SetupMediators;
  public
     property  Data: TContactTitle read FData write SetData;
  end;

var
  EditTitle: TEditTitle;
  function EditTitleData(AData: TContactTitle): boolean;

implementation

{$R *.lfm}
uses
  tiBaseMediator,
  contactmanager,
  tiDialogs             // tiOPF-Dialoge z.B. für tiShowString
  ;

function EditTitleData(AData: TContactTitle): boolean;
var
  frm: TEditTitle;
begin
  frm:= TEditTitle.Create(nil);
  try
    frm.Data:=AData;
    result:= frm.ShowModal = mrOK;
  finally
    frm.Free;
  end;
end;

{ TEditCityForm }

procedure TEditTitle.btnAbortClick(Sender: TObject);
begin
  close;
end;

procedure TEditTitle.btnDebugClick(Sender: TObject);
begin
    tiShowString(FData.AsDebugString);

end;

procedure TEditTitle.btnSaveExitClick(Sender: TObject);
begin
   FMediator.Subject.Dirty:=True;
  gContactManager.ContactTitles.Save;
  close;
end;

procedure TEditTitle.SetData(const AValue: TContactTitle);
begin
  FData:=AValue;
  SetupMediators;
end;

procedure TEditTitle.SetupMediators;
begin
  if not Assigned(FMediator) then
  begin
    FMediator := TtiModelMediator.Create(self);
    FMediator.AddProperty('Title', edTitle);
    FMediator.AddProperty('SearchTitle', edSearchTitle);
    //FMediator.AddProperty('Country', cbCountry).ValueList := gContactManager.CountryList;
  end;
  FMediator.Subject := FData;
  FMediator.Active := True;
end;
end.

