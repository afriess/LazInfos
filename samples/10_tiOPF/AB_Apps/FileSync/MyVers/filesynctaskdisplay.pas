unit FileSyncTaskdisplay;

interface

uses
  tiFileSync_Mgr
  , tiDisplayHelpers
  , tiObject;

Type
  // its a Facade Pattern.
  // Formating is not possible in MGM
  TFileSyncTaskDisplay = class(TBaseDisplayObject)
  private
    FFileSyncTask : TtiFileSyncTask;
    Procedure SeTtiFileSyncTask(const AValue : TtiFileSyncTask);
    function GetDisplay(AIndex : Integer) : String;
    function CheckFileSyncTask : Boolean;
  public
    constructor CreateCustom(const AFileSyncTask : TtiFileSyncTask);
    destructor Destroy; override;
    property FileSyncTask : TtiFileSyncTask read FFileSyncTask write SeTtiFileSyncTask;
  published
    property PathAndName : String index 0 read GetDisplay;
    property Date : String index 1 read GetDisplay;
    property Size : String index 2 read GetDisplay;
  End;


  TFileSyncTaskDisplayList = class(TBaseDisplayList)
  protected
    function CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject; override;
    function FindDisplayObject(AObject: TtiObject): TBaseDisplayObject; override;
  end;

implementation

uses SysUtils;

{ TFileSyncTaskDisplay }

function TFileSyncTaskDisplay.CheckFileSyncTask: Boolean;
begin
  Result := Assigned(FFileSyncTask);
end;

constructor TFileSyncTaskDisplay.CreateCustom(const AFileSyncTask: TtiFileSyncTask);
begin
  Inherited Create;
  FileSyncTask := AFileSyncTask;
end;

destructor TFileSyncTaskDisplay.Destroy;
begin
  FileSyncTask := nil;
  inherited;
end;

function TFileSyncTaskDisplay.GetDisplay(AIndex: Integer): String;
begin
  if CheckFileSyncTask then
  begin
    case AIndex of
      0 : Result := FileSyncTask.PathAndName;
      1 : Result := DateToStr(FileSyncTask.Date);
      2 : Result := IntToStr(FileSyncTask.Size);
    end; { Case }
  end;
end;

procedure TFileSyncTaskDisplay.SeTtiFileSyncTask(const AValue: TtiFileSyncTask);
begin
  if FileSyncTask = AValue then Exit;
  if CheckFileSyncTask then
    FFileSyncTask.DetachObserver(Self);
  FFileSyncTask := AValue;
  if CheckFileSyncTask then
    FFileSyncTask.AttachObserver(Self);
end;

{ TFileSyncTaskDisplayList }

function TFileSyncTaskDisplayList.CreateDisplayInstance(AItem: TtiObject): TBaseDisplayObject;
begin
  Result := TFileSyncTaskDisplay.CreateCustom(TtiFileSyncTask(AItem));
end;

function TFileSyncTaskDisplayList.FindDisplayObject(AObject: TtiObject): TBaseDisplayObject;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
  begin
    if (TFileSyncTaskDisplay(Items[i]).FileSyncTask = AObject) then
    begin
      Result := TBaseDisplayObject(Items[i]);
      break;
    end;
  end;
end;

end.

