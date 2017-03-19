unit FilenameDisplay;

interface

uses
  tiFileName_BOM
  , tiDisplayHelpers
  , tiObject;

Type
  // its a Facade Pattern.
  // Formating is not possible in MGM
  TFilenameDisplay = class(TBaseDisplayObject)
  private
    FFilename : TtiFilename;
    Procedure SeTtiFileName(const AValue : TtiFileName);
    function GetDisplay(AIndex : Integer) : String;
    function CheckFilename : Boolean;
  public
    constructor CreateCustom(const AFilename : TtiFileName);
    destructor Destroy; override;
    property Filename : TtiFileName read FFilename write SeTtiFileName;
  published
    property PathAndName : String index 0 read GetDisplay;
    property Date : String index 1 read GetDisplay;
    property Size : String index 2 read GetDisplay;
    property CRC : String index 3 read GetDisplay;
  End;


  TFilenameDisplayList = class(TBaseDisplayList)
  protected
    function CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject; override;
    function FindDisplayObject(AObject: TtiObject): TBaseDisplayObject; override;
  end;

implementation

uses SysUtils;

{ TFilenameDisplay }

function TFilenameDisplay.CheckFilename: Boolean;
begin
  Result := Assigned(FFilename);
end;

constructor TFilenameDisplay.CreateCustom(const AFilename: TtiFileName);
begin
  Inherited Create;
  Filename := AFilename;
end;

destructor TFilenameDisplay.Destroy;
begin
  Filename := nil;
  inherited;
end;

function TFilenameDisplay.GetDisplay(AIndex: Integer): String;
begin
  if CheckFilename then
  begin
    case AIndex of
      0 : Result := Filename.PathAndName;
      1 : Result := DateToStr(Filename.Date);
      2 : Result := IntToStr(Filename.Size);
      3 : Result := IntToStr(Filename.CRC);
    end; { Case }
  end;
end;

procedure TFilenameDisplay.SeTtiFileName(const AValue: TtiFileName);
begin
  if Filename = AValue then Exit;
  if CheckFilename then
    FFilename.DetachObserver(Self);
  FFilename := AValue;
  if CheckFilename then
    FFilename.AttachObserver(Self);
end;

{ TFilenameDisplayList }

function TFilenameDisplayList.CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject;
begin
  Result := TFilenameDisplay.CreateCustom(TtiFileName(AItem));
end;

function TFilenameDisplayList.FindDisplayObject(AObject: TtiObject): TBaseDisplayObject;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if (TFilenameDisplay(Items[i]).Filename = AObject) then
    begin
      Result := TBaseDisplayObject(Items[i]);
      break;
    end;
  end;
end;

end.
