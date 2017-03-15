unit VIEW_Hash;

{$mode objfpc}{$H+}

interface

uses
  BOM_Hash, tiDisplayHelpers, tiObject;

Type
  THashDisplay = class(TBaseDisplayObject)
  private
    FHash : THash;
    Procedure SetHash(const AValue : THash);
    function GetDisplay(AIndex : Integer) : String;
    function CheckHash : Boolean;
  public
    constructor CreateCustom(const AHash : THash);
    destructor Destroy; override;
    property AHash : THash read FHash write SetHash;
  published
    property FileHash : String index 0 read GetDisplay;
    property Filename : String index 1 read GetDisplay;
    property StoreDate : String index 2 read GetDisplay;
  End;

  THashDisplayList = class(TBaseDisplayList)
  protected
    function CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject; override;
    function FindDisplayObject(AObject: TtiObject): TBaseDisplayObject; override;
  end;

implementation

uses SysUtils;

{ THashDisplay }

function THashDisplay.CheckHash: Boolean;
begin
  Result := Assigned(AHash);
end;

constructor THashDisplay.CreateCustom(const AHash: THash);
begin
  Inherited Create;
  FHash := AHash;
end;

destructor THashDisplay.Destroy;
begin
  AHash := nil;
  inherited;
end;

function THashDisplay.GetDisplay(AIndex: Integer): String;
begin
  if CheckHash then
  begin
    case AIndex of
      0 : Result := AHash.FileHash;
      1 : Result := AHash.FileName;
      2 : Result := DateToStr(AHash.StoreDate);
    end; { Case }
  end;
end;

procedure THashDisplay.SetHash(const AValue: THash);
begin
  if AHash = AValue then Exit;
  if CheckHash then
    AHash.DetachObserver(Self);
  FHash := AValue;
  if CheckHash then
    AHash.AttachObserver(Self);
end;

{ THashDisplayList }

function THashDisplayList.CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject;
begin
  Result := THashDisplay.CreateCustom(THash(AItem));
end;

function THashDisplayList.FindDisplayObject(AObject: TtiObject): TBaseDisplayObject;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if (THashDisplay(Items[i]).AHash = AObject) then
    begin
      Result := TBaseDisplayObject(Items[i]);
      break;
    end;
  end;
end;

end.


