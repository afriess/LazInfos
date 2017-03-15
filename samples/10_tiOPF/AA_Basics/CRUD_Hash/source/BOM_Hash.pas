

unit BOM_Hash;
// ---------------------------------------------------------
// Automatically generated on 22.08.2016 10:16:19
// Warning: 
//   If you rerun timap, your changes in this file will be lost
// ---------------------------------------------------------


{$IFDEF FPC}
{$mode objfpc}{$H+}
{$ENDIF}


interface


uses
  SysUtils
  ,tiObject
  ,typinfo
  ,tiAutoMap
  ,tiOPFManager
  ,tiVisitorDB
  ,tiVisitorCriteria
  ,tiCriteria
  ,tiSQLParser
  ,mapper
  ;

type


  // ---------------------------------------------
  // Generated Classes
  // ---------------------------------------------


  THashClass = class of THash;
  { Generated Class: THash}
  THash = class(TtiObject)
  protected
    FFileHash: String;
    FFileName: String;
    FStoreDate: TDateTime;
    procedure   SetFileHash(const AValue: String); virtual;
    procedure   SetFileName(const AValue: String); virtual;
    procedure   SetStoreDate(const AValue: TDateTime); virtual;
  public
    procedure   Read; override;
    procedure   Save; override;
  published
    property    FileHash: String read FFileHash write SetFileHash;
    property    FileName: String read FFileName write SetFileName;
    property    StoreDate: TDateTime read FStoreDate write SetStoreDate;
  end;
  
  { List of THash.  TtiMappedFilteredObjectList descendant. }
  THashList = class(TtiMappedFilteredObjectList)
  private
    class var FItemClass: THashClass;
  protected
    procedure   SetItems(i: integer; const AValue: THash); reintroduce;
    function    GetItems(i: integer): THash; reintroduce;
  public
    property    Items[i:integer] : THash read GetItems write SetItems;
    procedure   Add(AObject: THash); reintroduce;
    procedure   Read; override;
    procedure   Save; override;
    class property ItemClass: THashClass read FItemClass write FItemClass;
    { Return count (1) if successful. }
    function    FindByOID(const AOID: string): integer;
    { Returns Number of objects retrieved. }
    function    FindHash(const FileHash: string): integer;
  end;
  
  { Read Visitor for THash }
  THash_Read = class(TtiVisitorSelect)
  protected
    function    AcceptVisitor: Boolean; override;
    procedure   Init; override;
    procedure   SetupParams; override;
    procedure   MapRowToObject; override;
  end;
  
  { Create Visitor for THash }
  THash_Create = class(TtiVisitorUpdate)
  protected
    function    AcceptVisitor: Boolean; override;
    procedure   Init; override;
    procedure   SetupParams; override;
  end;
  
  { Update Visitor for THash }
  THash_Update = class(TtiVisitorUpdate)
  protected
    function    AcceptVisitor: Boolean; override;
    procedure   Init; override;
    procedure   SetupParams; override;
  end;
  
  { Delete Visitor for THash }
  THash_Delete = class(TtiVisitorUpdate)
  protected
    function    AcceptVisitor: Boolean; override;
    procedure   Init; override;
    procedure   SetupParams; override;
  end;
  
  { List Read Visitor for THashList }
  THashList_Read = class(TtiVisitorSelect)
  protected
    function    AcceptVisitor: Boolean; override;
    procedure   Init; override;
    procedure   MapRowToObject; override;
  end;
  
  { THashList_FindHashVis }
  THashList_FindHashVis = class(TtiMapParameterListReadVisitor)
  protected
    function    AcceptVisitor: Boolean; override;
    procedure   MapRowToObject; override;
    procedure   SetupParams; override;
  end;
  

  { Visitor Manager Registrations }
  procedure RegisterVisitors;

  { Register Auto Mappings }
  procedure RegisterMappings;


implementation


uses
  tiUtils
  ,tiLog
  ;

procedure RegisterMappings;
begin
  { Automap registrations for THash }
  GTIOPFManager.ClassDBMappingMgr.RegisterMapping(THash, 
    'Hashes', 'OID', 'HashID', [pktDB]);
  GTIOPFManager.ClassDBMappingMgr.RegisterMapping(THash,
    'Hashes','FileHash', 'FileHash');
  GTIOPFManager.ClassDBMappingMgr.RegisterMapping(THash,
    'Hashes','FileName', 'FileName');
  GTIOPFManager.ClassDBMappingMgr.RegisterMapping(THash,
    'Hashes','StoreDate', 'StoreDate');
  GTIOPFManager.ClassDBMappingMgr.RegisterCollection(THashList, THash);
  
end;

procedure RegisterVisitors;
begin
  { NOTE: The most reliable order of registering visitors are
          Read, Delete, Update, Create }
  GTIOPFManager.VisitorManager.RegisterVisitor('LoadHashList', THashList_Read);
  GTIOPFManager.VisitorManager.RegisterVisitor('LoadHash', THash_Read);
  GTIOPFManager.VisitorManager.RegisterVisitor('SaveHash', THash_Delete);
  GTIOPFManager.VisitorManager.RegisterVisitor('SaveHash', THash_Update);
  GTIOPFManager.VisitorManager.RegisterVisitor('SaveHash', THash_Create);
  GTIOPFManager.VisitorManager.RegisterVisitor('THashList_FindHashVis', THashList_FindHashVis);
  
end;

procedure THash.SetFileHash(const AValue: String);
begin
  if FFileHash = AValue then
    Exit;
  FFileHash := AValue;
end;

procedure THash.SetFileName(const AValue: String);
begin
  if FFileName = AValue then
    Exit;
  FFileName := AValue;
end;

procedure THash.SetStoreDate(const AValue: TDateTime);
begin
  if FStoreDate = AValue then
    Exit;
  FStoreDate := AValue;
end;

procedure THash.Read;
begin
  GTIOPFManager.VisitorManager.Execute('LoadHash', self);
end;

procedure THash.Save;
begin
  GTIOPFManager.VisitorManager.Execute('SaveHash', self);
end;

 {THashList }

procedure THashList.Add(AObject: THash);
begin
  inherited Add(AObject);
end;

function THashList.GetItems(i: integer): THash;
begin
  result := inherited GetItems(i) as THash;
end;

procedure THashList.Read;
begin
  GTIOPFManager.VisitorManager.Execute('LoadHashList', self);
end;

procedure THashList.Save;
begin
  GTIOPFManager.VisitorManager.Execute('SaveHash', self);
end;

procedure THashList.SetItems(i: integer; const AValue: THash);
begin
  inherited SetItems(i, AValue);
end;

function THashList.FindByOID(const AOID: string): integer;
begin
  if self.Count > 0 then
    self.Clear;
    
  Criteria.ClearAll;
  Criteria.AddEqualTo('HashID', AOID);
  Read;
  result := Count;
end;

function THashList.FindHash(const FileHash: string): integer;
begin
  if self.Count > 0 then
    self.Clear;
    
  Params.Clear;
  AddParam('FileHash', 'Hash_param', ptString, FileHash);
  self.SQL := 
    ' select HASHES.OID , HASHES.FILEHASH, HASHES.FILENAME,  ' + 
    ' HASHES.STOREDATE from Hashes where FileHash = :Hash_param'; 
  GTIOPFManager.VisitorManager.Execute('THashList_FindHashVis', self);
  result := self.Count;
end;

{ THash_Create }
function THash_Create.AcceptVisitor: Boolean;
begin
  result := (Visited is THash) and (Visited.ObjectState = posCreate);
  Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure THash_Create.Init;
begin
  Query.SQLText :=
    'INSERT INTO Hashes(' +
    ' HashID, ' +
    ' FileHash, ' +
    ' FileName, ' +
    ' StoreDate' +
    ') VALUES (' +
    ' :HashID, ' +
    ' :FileHash, ' +
    ' :FileName, ' +
    ' :StoreDate' +
    ') ';
end;

procedure THash_Create.SetupParams;
var
  lObj: THash;
begin
  lObj := THash(Visited);
  lObj.OID.AssignToTIQuery('HashID',Query);
  Query.ParamAsString['FileHash'] := lObj.FileHash;
  Query.ParamAsString['FileName'] := lObj.FileName;
  Query.ParamAsDateTime['StoreDate'] := lObj.StoreDate;
end;

{ THash_Update }
function THash_Update.AcceptVisitor: Boolean;
begin
  result := (Visited is THash) and (Visited.ObjectState = posUpdate);
  Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure THash_Update.Init;
begin
  Query.SQLText :=
    'UPDATE Hashes SET ' +
    ' FileHash = :FileHash, ' +
    ' FileName = :FileName, ' +
    ' StoreDate = :StoreDate ' +
    'WHERE HashID = :HashID' ;
end;

procedure THash_Update.SetupParams;
var
  lObj: THash;
begin
  lObj := THash(Visited);
  lObj.OID.AssignToTIQuery('HashID',Query);
  Query.ParamAsString['FileHash'] := lObj.FileHash;
  Query.ParamAsString['FileName'] := lObj.FileName;
  Query.ParamAsDateTime['StoreDate'] := lObj.StoreDate;
end;

{ THash_Read }
function THash_Read.AcceptVisitor: Boolean;
begin
  result := (Visited is THash) and ((Visited.ObjectState = posPK) OR (Visited.ObjectState = posClean));
  Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure THash_Read.Init;
begin
  Query.SQLText :=
    'SELECT ' +
    ' HashID, ' +
    ' FileHash, ' +
    ' FileName, ' +
    ' StoreDate ' +
    'FROM Hashes WHERE HashID = :HashID' ;
end;

procedure THash_Read.SetupParams;
var
  lObj: THash;
begin
  lObj := THash(Visited);
  lObj.OID.AssignToTIQuery('HashID',Query);
end;

procedure THash_Read.MapRowToObject;
var
  lObj: THash;
begin
  lObj := THash(Visited);
  lObj.OID.AssignFromTIQuery('HashID',Query);
  lObj.FileHash := Query.FieldAsString['FileHash'];
  lObj.FileName := Query.FieldAsString['FileName'];
  lObj.StoreDate := Query.FieldAsDatetime['StoreDate'];
end;

{ THash_Delete }
function THash_Delete.AcceptVisitor: Boolean;
begin
  result := (Visited is THash) and (Visited.ObjectState = posDelete);
  Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure THash_Delete.Init;
begin
  Query.SQLText := 
    'DELETE FROM Hashes ' +
    'WHERE HashID = :HashID';
end;

procedure THash_Delete.SetupParams;
var
  lObj: THash;
begin
  lObj := THash(Visited);
  lObj.OID.AssignToTIQuery('HashID',Query);
end;

{ THashList_Read }
function THashList_Read.AcceptVisitor: Boolean;
begin
  result := (Visited.ObjectState = posEmpty);
  Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure THashList_Read.Init;
var
  lFiltered: ItiFiltered;
  lWhere: string;
  lOrder: string;
  lSQL: string;
begin
  if Supports(Visited, ItiFiltered, lFiltered) then
  begin
    if lFiltered.GetCriteria.HasCriteria then
      lWhere := ' WHERE ' + tiCriteriaAsSQL(lFiltered.GetCriteria)
    else
      lWhere := '';
    if lFiltered.GetCriteria.hasOrderBy then
      lOrder := tiCriteriaOrderByAsSQL(lFiltered.GetCriteria)
    else
      lOrder := '';
  end;
  
  lSQL :=
    'SELECT ' +
    ' HashID, ' +
    ' FileHash, ' +
    ' FileName, ' +
    ' StoreDate ' +
    'FROM  Hashes %s %s ;';
  
  Query.SQLText := gFormatSQL(Format(lSQL, [lWhere, lOrder]), THash);
  
end;

procedure THashList_Read.MapRowToObject;
var
  lObj: THash;
  lItemClass : THashClass = THash;
begin
  if Assigned(THashList.ItemClass) then
    lItemClass := THashList.ItemClass;
  lObj := lItemClass.Create;
  lObj.OID.AssignFromTIQuery('HashID',Query);
  lObj.FileHash := Query.FieldAsString['FileHash'];
  lObj.FileName := Query.FieldAsString['FileName'];
  lObj.StoreDate := Query.FieldAsDatetime['StoreDate'];
  lObj.ObjectState := posClean;
  TtiObjectList(Visited).Add(lObj);
end;

{ THashList_FindHashVis }
function THashList_FindHashVis.AcceptVisitor: Boolean;
begin
  result := (Visited.ObjectState = posEmpty);
end;

procedure THashList_FindHashVis.MapRowToObject;
var
  lObj: THash;
begin
  lObj := THash.Create;
  lObj.OID.AssignFromTIQuery('OID',Query);
  lObj.FileHash := Query.FieldAsString['FileHash'];
  lObj.FileName := Query.FieldAsString['FileName'];
  lObj.StoreDate := Query.FieldAsDatetime['StoreDate'];
  lObj.ObjectState := posClean;
  TtiObjectList(Visited).Add(lObj);
end;

procedure THashList_FindHashVis.SetupParams;
var
  lCtr: integer;
  lParam: TSelectParam;
  lList: TtiMappedFilteredObjectList;
begin
  lList := TtiMappedFilteredObjectList(Visited);
  
  lParam := TSelectParam(lList.Params.FindByProps(['ParamName'], ['FileHash']));
  Query.ParamAsString['Hash_param'] := lParam.Value;
end;

initialization
  RegisterVisitors;
  RegisterMappings;


end.
