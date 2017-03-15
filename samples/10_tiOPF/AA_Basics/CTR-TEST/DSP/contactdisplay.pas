unit contactdisplay;
// In this unit the Display classes for the GUI will be inherited
// Here should also done the formatting tasks

interface

uses
  contactmodel,
  tiDisplayHelpers,
  tiObject;

Type

  { TContactDisplay }

  TContactTitleDisplay = class(TBaseDisplayObject)
  private
    FContactTitle : TContactTitle;
    Procedure SetContactTitle(const AValue : TContactTitle);
    function GetDisplay(AIndex : Integer) : String;
    function CheckContactTitle : Boolean;
  public
    constructor CreateCustom(const AContactTitle : TContactTitle);
    destructor Destroy; override;
    property ContactTitle : TContactTitle read FContactTitle write SetContactTitle;
  published
    property Title : String index 0 read GetDisplay;
    property SearchTitle : String index 1 read GetDisplay;
    //property Name3 : String index 2 read GetDisplay;
    //property Addition : String index 3 read GetDisplay;

  End;

  TContactTitleDisplayList = class(TBaseDisplayList)
  protected
    function CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject; override;
    function FindDisplayObject(AObject: TtiObject): TBaseDisplayObject; override;
  end;

implementation

uses SysUtils;

{ TContactTitleDisplay }

function TContactTitleDisplay.CheckContactTitle: Boolean;
begin
  Result := Assigned(FContactTitle);
end;

constructor TContactTitleDisplay.CreateCustom(const AContactTitle: TContactTitle);
begin
  Inherited Create;
  ContactTitle := AContactTitle;
end;

destructor TContactTitleDisplay.Destroy;
begin
  ContactTitle := nil;
  inherited;
end;

function TContactTitleDisplay.GetDisplay(AIndex: Integer): String;
begin
  if CheckContactTitle then
  begin
    case AIndex of
      0 : Result := ContactTitle.Title;
      1 : Result := ContactTitle.SearchTitle;
      //2 : Result := ContactTitle.Name3;
      //3 : Result := ContactTitle.Addition;

    end; { Case }
  end;
end;

procedure TContactTitleDisplay.SetContactTitle(const AValue: TContactTitle);
begin
  if ContactTitle = AValue then Exit;
  if CheckContactTitle then
    FContactTitle.DetachObserver(Self);
  FContactTitle := AValue;
  if CheckContactTitle then
    FContactTitle.AttachObserver(Self);
end;

{ TContactDisplayList }

function TContactTitleDisplayList.CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject;
begin
  Result := TContactTitleDisplay.CreateCustom(TContactTitle(AItem));
end;

function TContactTitleDisplayList.FindDisplayObject(AObject: TtiObject): TBaseDisplayObject;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if (TContactTitleDisplay(Items[i]).ContactTitle = AObject) then
    begin
      Result := TBaseDisplayObject(Items[i]);
      break;
    end;
  end;
end;

end.

