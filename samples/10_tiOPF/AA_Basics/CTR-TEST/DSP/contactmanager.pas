unit contactmanager;
// To make saving and loading easier, a single class
// which owns all global listes is implemented


{$mode objfpc}{$H+}

interface

uses
  contactmodel
  , tiObject;



type

  TContactManager = class(TtiObject)
  private
    FBusinesses: TBusinesses;
    FContactTitles: TContactTitles;
    //*********  TitleType for Combobox
    //FTitleType: TTitleType;
    //function GetTitleTypeGUI: string;
    //procedure SetTitleTypeGUI(const AValue: string);

  public
    constructor Create; override;
    destructor Destroy; override;
    procedure PopulateContacts;
  published
    property ContactTitles: TContactTitles read FContactTitles;
    property Businesses: TBusinesses read FBusinesses;
    //*********  TitleType for Combobox
    //property TitleTypeGUI: string read GetTitleTypeGUI write SetTitleTypeGUI;

  end;


// Global singleton
function gContactManager: TContactManager;


implementation

uses
  SysUtils;

var
  uContactManager: TContactManager;

function gContactManager: TContactManager;
begin
  if not Assigned(uContactManager) then
    uContactManager := TContactManager.Create;
  Result := uContactManager;
end;

constructor TContactManager.Create;
begin
  inherited Create;
  FContactTitles := TContactTitles.Create;
  FContactTitles.Owner := self;
  FBusinesses := TBusinesses.Create;
  //FBusinesses.Owner := self;


end;

destructor TContactManager.Destroy;
begin
  FBusinesses.Free;
  ContactTitles.Free;
  inherited Destroy;
end;
//*********  TitleType for Combobox
//function TContactManager.GetTitleTypeGUI: string;
//begin
//  Result := cTitleType[FTitleType];
//end;

//*********  TitleType for Combobox
//procedure TContactManager.SetTitleTypeGUI(const AValue: string);
//var
//  i: TTitleType;
//begin
  //for i := Low(TTitleType) to High(TTitleType) do
  //begin
  //  if cTitleType[i] = AValue then
  //  begin
  //    TitleType := i;
  //    Exit; //==>
  //  end;
  //end;
  //TitleType := ttSingle;
//end;


procedure TContactManager.PopulateContacts;
var
  i: integer;
begin
  ContactTitles.Read;

  // here is to insert grouplists
  FBusinesses.Read;

end;

initialization
  uContactManager := nil;

finalization
  uContactManager.Free;
end.
