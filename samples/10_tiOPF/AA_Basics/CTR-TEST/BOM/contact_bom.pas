

unit contact_bom;
// ---------------------------------------------------------
// Automatically generated on 15.03.2017 14:41:17
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
,tiAutoMap
,tiOPFManager
,tiVisitorDB
,tiVisitorCriteria
,tiCriteria
,tiSQLParser
,mapper
;

type


// Enumerations
TTitleType = (ttSingle, ttMulti);



// ---------------------------------------------
// Generated Classes
// ---------------------------------------------


TBaseBusinessClass = class of TBaseBusiness;
{ Generated Class: TBaseBusiness}
TBaseBusiness = class(TtiObject)
protected
FOIDContactTitle: String;
FName1: String;
FName2: String;
FName3: String;
FAddition: String;
procedure   SetOIDContactTitle(const AValue: String); virtual;
procedure   SetName1(const AValue: String); virtual;
procedure   SetName2(const AValue: String); virtual;
procedure   SetName3(const AValue: String); virtual;
procedure   SetAddition(const AValue: String); virtual;
public
procedure   Read; override;
procedure   Save; override;
published
property    OIDContactTitle: String read FOIDContactTitle write SetOIDContactTitle;
property    Name1: String read FName1 write SetName1;
property    Name2: String read FName2 write SetName2;
property    Name3: String read FName3 write SetName3;
property    Addition: String read FAddition write SetAddition;
end;

{ List of TBaseBusiness.  TtiMappedFilteredObjectList descendant. }
TBaseBusinessList = class(TtiMappedFilteredObjectList)
private
class var FItemClass: TBaseBusinessClass;
protected
procedure   SetItems(i: integer; const AValue: TBaseBusiness); reintroduce;
function    GetItems(i: integer): TBaseBusiness; reintroduce;
public
property    Items[i:integer] : TBaseBusiness read GetItems write SetItems;
procedure   Add(AObject: TBaseBusiness); reintroduce;
procedure   Read; override;
procedure   Save; override;
class property ItemClass: TBaseBusinessClass read FItemClass write FItemClass;
{ Return count (1) if successful. }
function    FindByOID(const AOID: string): integer;
end;

TBaseContactTitleClass = class of TBaseContactTitle;
{ Generated Class: TBaseContactTitle}
TBaseContactTitle = class(TtiObject)
protected
FTitleType: TTitleType;
FTitle: String;
FSearchTitle: String;
FBusinessList: TBaseBusinessList;
procedure   SetTitleType(const AValue: TTitleType); virtual;
procedure   SetTitle(const AValue: String); virtual;
procedure   SetSearchTitle(const AValue: String); virtual;
procedure   SetBusinessList(const AValue: TBaseBusinessList); virtual;
public
procedure   Read; override;
procedure   Save; override;
published
property    TitleType: TTitleType read FTitleType write SetTitleType;
property    Title: String read FTitle write SetTitle;
property    SearchTitle: String read FSearchTitle write SetSearchTitle;
property    BusinessList: TBaseBusinessList read FBusinessList write SetBusinessList;
end;

{ List of TBaseContactTitle.  TtiMappedFilteredObjectList descendant. }
TBaseContactTitleList = class(TtiMappedFilteredObjectList)
private
class var FItemClass: TBaseContactTitleClass;
protected
procedure   SetItems(i: integer; const AValue: TBaseContactTitle); reintroduce;
function    GetItems(i: integer): TBaseContactTitle; reintroduce;
public
property    Items[i:integer] : TBaseContactTitle read GetItems write SetItems;
procedure   Add(AObject: TBaseContactTitle); reintroduce;
procedure   Read; override;
procedure   Save; override;
class property ItemClass: TBaseContactTitleClass read FItemClass write FItemClass;
{ Return count (1) if successful. }
function    FindByOID(const AOID: string): integer;
end;

{ Read Visitor for TBaseBusiness }
TBaseBusiness_Read = class(TtiVisitorSelect)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
procedure   MapRowToObject; override;
end;

{ Create Visitor for TBaseBusiness }
TBaseBusiness_Create = class(TtiVisitorUpdate)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
end;

{ Update Visitor for TBaseBusiness }
TBaseBusiness_Update = class(TtiVisitorUpdate)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
end;

{ Delete Visitor for TBaseBusiness }
TBaseBusiness_Delete = class(TtiVisitorUpdate)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
end;

{ List Read Visitor for TBaseBusinessList }
TBaseBusinessList_Read = class(TtiVisitorSelect)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   MapRowToObject; override;
end;

{ Read Visitor for TBaseContactTitle }
TBaseContactTitle_Read = class(TtiVisitorSelect)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
procedure   MapRowToObject; override;
end;

{ Create Visitor for TBaseContactTitle }
TBaseContactTitle_Create = class(TtiVisitorUpdate)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
end;

{ Update Visitor for TBaseContactTitle }
TBaseContactTitle_Update = class(TtiVisitorUpdate)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
end;

{ Delete Visitor for TBaseContactTitle }
TBaseContactTitle_Delete = class(TtiVisitorUpdate)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   SetupParams; override;
end;

{ List Read Visitor for TBaseContactTitleList }
TBaseContactTitleList_Read = class(TtiVisitorSelect)
protected
function    AcceptVisitor: Boolean; override;
procedure   Init; override;
procedure   MapRowToObject; override;
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
{ Automap registrations for TBaseBusiness }
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseBusiness, 
'ctr_Business', 'OID', 'OID', [pktDB]);
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseBusiness,
'ctr_Business','OIDContactTitle', 'OIDContactTitle');
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseBusiness,
'ctr_Business','Name1', 'Name1');
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseBusiness,
'ctr_Business','Name2', 'Name2');
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseBusiness,
'ctr_Business','Name3', 'Name3');
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseBusiness,
'ctr_Business','Addition', 'Addition');
GTIOPFManager.ClassDBMappingMgr.RegisterCollection(TBaseBusinessList, TBaseBusiness);

{ Automap registrations for TBaseContactTitle }
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseContactTitle, 
'ctr_ContactTitle', 'OID', 'OID', [pktDB]);
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseContactTitle,
'ctr_ContactTitle','TitleType', 'TitleType');
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseContactTitle,
'ctr_ContactTitle','Title', 'Title');
GTIOPFManager.ClassDBMappingMgr.RegisterMapping(TBaseContactTitle,
'ctr_ContactTitle','SearchTitle', 'SearchTitle');
GTIOPFManager.ClassDBMappingMgr.RegisterCollection(TBaseContactTitleList, TBaseContactTitle);

end;

procedure RegisterVisitors;
begin
{ NOTE: The most reliable order of registering visitors are
        Read, Delete, Update, Create }
GTIOPFManager.VisitorManager.RegisterVisitor('LoadBaseBusinessList', TBaseBusinessList_Read);
GTIOPFManager.VisitorManager.RegisterVisitor('LoadBaseBusiness', TBaseBusiness_Read);
GTIOPFManager.VisitorManager.RegisterVisitor('SaveBaseBusiness', TBaseBusiness_Delete);
GTIOPFManager.VisitorManager.RegisterVisitor('SaveBaseBusiness', TBaseBusiness_Update);
GTIOPFManager.VisitorManager.RegisterVisitor('SaveBaseBusiness', TBaseBusiness_Create);

{ NOTE: The most reliable order of registering visitors are
        Read, Delete, Update, Create }
GTIOPFManager.VisitorManager.RegisterVisitor('LoadBaseContactTitleList', TBaseContactTitleList_Read);
GTIOPFManager.VisitorManager.RegisterVisitor('LoadBaseContactTitle', TBaseContactTitle_Read);
GTIOPFManager.VisitorManager.RegisterVisitor('SaveBaseContactTitle', TBaseContactTitle_Delete);
GTIOPFManager.VisitorManager.RegisterVisitor('SaveBaseContactTitle', TBaseContactTitle_Update);
GTIOPFManager.VisitorManager.RegisterVisitor('SaveBaseContactTitle', TBaseContactTitle_Create);

end;

procedure TBaseBusiness.SetOIDContactTitle(const AValue: String);
begin
if FOIDContactTitle = AValue then
Exit;
BeginUpdate;
FOIDContactTitle := AValue;
EndUpdate;
end;

procedure TBaseBusiness.SetName1(const AValue: String);
begin
if FName1 = AValue then
Exit;
BeginUpdate;
FName1 := AValue;
EndUpdate;
end;

procedure TBaseBusiness.SetName2(const AValue: String);
begin
if FName2 = AValue then
Exit;
BeginUpdate;
FName2 := AValue;
EndUpdate;
end;

procedure TBaseBusiness.SetName3(const AValue: String);
begin
if FName3 = AValue then
Exit;
BeginUpdate;
FName3 := AValue;
EndUpdate;
end;

procedure TBaseBusiness.SetAddition(const AValue: String);
begin
if FAddition = AValue then
Exit;
BeginUpdate;
FAddition := AValue;
EndUpdate;
end;

procedure TBaseBusiness.Read;
begin
GTIOPFManager.VisitorManager.Execute('LoadBaseBusiness', self);
end;

procedure TBaseBusiness.Save;
begin
GTIOPFManager.VisitorManager.Execute('SaveBaseBusiness', self);
end;

 {TBaseBusinessList }

procedure TBaseBusinessList.Add(AObject: TBaseBusiness);
begin
inherited Add(AObject);
end;

function TBaseBusinessList.GetItems(i: integer): TBaseBusiness;
begin
result := inherited GetItems(i) as TBaseBusiness;
end;

procedure TBaseBusinessList.Read;
begin
GTIOPFManager.VisitorManager.Execute('LoadBaseBusinessList', self);
end;

procedure TBaseBusinessList.Save;
begin
GTIOPFManager.VisitorManager.Execute('SaveBaseBusiness', self);
end;

procedure TBaseBusinessList.SetItems(i: integer; const AValue: TBaseBusiness);
begin
inherited SetItems(i, AValue);
end;

function TBaseBusinessList.FindByOID(const AOID: string): integer;
begin
if self.Count > 0 then
self.Clear;

Criteria.ClearAll;
Criteria.AddEqualTo('OID', AOID);
Read;
result := Count;
end;

procedure TBaseContactTitle.SetTitleType(const AValue: TTitleType);
begin
if FTitleType = AValue then
Exit;
BeginUpdate;
FTitleType := AValue;
EndUpdate;
end;

procedure TBaseContactTitle.SetTitle(const AValue: String);
begin
if FTitle = AValue then
Exit;
BeginUpdate;
FTitle := AValue;
EndUpdate;
end;

procedure TBaseContactTitle.SetSearchTitle(const AValue: String);
begin
if FSearchTitle = AValue then
Exit;
BeginUpdate;
FSearchTitle := AValue;
EndUpdate;
end;

procedure TBaseContactTitle.SetBusinessList(const AValue: TBaseBusinessList);
begin
if FBusinessList = AValue then
Exit;
BeginUpdate;
FBusinessList := AValue;
EndUpdate;
end;

procedure TBaseContactTitle.Read;
begin
GTIOPFManager.VisitorManager.Execute('LoadBaseContactTitle', self);
end;

procedure TBaseContactTitle.Save;
begin
GTIOPFManager.VisitorManager.Execute('SaveBaseContactTitle', self);
end;

 {TBaseContactTitleList }

procedure TBaseContactTitleList.Add(AObject: TBaseContactTitle);
begin
inherited Add(AObject);
end;

function TBaseContactTitleList.GetItems(i: integer): TBaseContactTitle;
begin
result := inherited GetItems(i) as TBaseContactTitle;
end;

procedure TBaseContactTitleList.Read;
begin
GTIOPFManager.VisitorManager.Execute('LoadBaseContactTitleList', self);
end;

procedure TBaseContactTitleList.Save;
begin
GTIOPFManager.VisitorManager.Execute('SaveBaseContactTitle', self);
end;

procedure TBaseContactTitleList.SetItems(i: integer; const AValue: TBaseContactTitle);
begin
inherited SetItems(i, AValue);
end;

function TBaseContactTitleList.FindByOID(const AOID: string): integer;
begin
if self.Count > 0 then
self.Clear;

Criteria.ClearAll;
Criteria.AddEqualTo('OID', AOID);
Read;
result := Count;
end;

{ TBaseBusiness_Create }
function TBaseBusiness_Create.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseBusiness) and (Visited.ObjectState = posCreate);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseBusiness_Create.Init;
begin
Query.SQLText :=
'INSERT INTO ctr_Business(' +
' OID, ' +
' OIDContactTitle, ' +
' Name1, ' +
' Name2, ' +
' Name3, ' +
' Addition' +
') VALUES (' +
' :OID, ' +
' :OIDContactTitle, ' +
' :Name1, ' +
' :Name2, ' +
' :Name3, ' +
' :Addition' +
') ';
end;

procedure TBaseBusiness_Create.SetupParams;
var
lObj: TBaseBusiness;
begin
lObj := TBaseBusiness(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
Query.ParamAsString['OIDContactTitle'] := lObj.OIDContactTitle;
Query.ParamAsString['Name1'] := lObj.Name1;
Query.ParamAsString['Name2'] := lObj.Name2;
Query.ParamAsString['Name3'] := lObj.Name3;
Query.ParamAsString['Addition'] := lObj.Addition;
end;

{ TBaseBusiness_Update }
function TBaseBusiness_Update.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseBusiness) and (Visited.ObjectState = posUpdate);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseBusiness_Update.Init;
begin
Query.SQLText :=
'UPDATE ctr_Business SET ' +
' OIDContactTitle = :OIDContactTitle, ' +
' Name1 = :Name1, ' +
' Name2 = :Name2, ' +
' Name3 = :Name3, ' +
' Addition = :Addition ' +
'WHERE OID = :OID' ;
end;

procedure TBaseBusiness_Update.SetupParams;
var
lObj: TBaseBusiness;
begin
lObj := TBaseBusiness(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
Query.ParamAsString['OIDContactTitle'] := lObj.OIDContactTitle;
Query.ParamAsString['Name1'] := lObj.Name1;
Query.ParamAsString['Name2'] := lObj.Name2;
Query.ParamAsString['Name3'] := lObj.Name3;
Query.ParamAsString['Addition'] := lObj.Addition;
end;

{ TBaseBusiness_Read }
function TBaseBusiness_Read.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseBusiness) and ((Visited.ObjectState = posPK) OR (Visited.ObjectState = posClean));
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseBusiness_Read.Init;
begin
Query.SQLText :=
'SELECT ' +
' OID, ' +
' OIDContactTitle, ' +
' Name1, ' +
' Name2, ' +
' Name3, ' +
' Addition ' +
'FROM ctr_Business WHERE OID = :OID' ;
end;

procedure TBaseBusiness_Read.SetupParams;
var
lObj: TBaseBusiness;
begin
lObj := TBaseBusiness(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
end;

procedure TBaseBusiness_Read.MapRowToObject;
var
lObj: TBaseBusiness;
begin
lObj := TBaseBusiness(Visited);
lObj.OID.AssignFromTIQuery('OID',Query);
lObj.OIDContactTitle := Query.FieldAsString['OIDContactTitle'];
lObj.Name1 := Query.FieldAsString['Name1'];
lObj.Name2 := Query.FieldAsString['Name2'];
lObj.Name3 := Query.FieldAsString['Name3'];
lObj.Addition := Query.FieldAsString['Addition'];
end;

{ TBaseBusiness_Delete }
function TBaseBusiness_Delete.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseBusiness) and (Visited.ObjectState = posDelete);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseBusiness_Delete.Init;
begin
Query.SQLText := 
'DELETE FROM ctr_Business ' +
'WHERE OID = :OID';
end;

procedure TBaseBusiness_Delete.SetupParams;
var
lObj: TBaseBusiness;
begin
lObj := TBaseBusiness(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
end;

{ TBaseBusinessList_Read }
function TBaseBusinessList_Read.AcceptVisitor: Boolean;
begin
result := (Visited.ObjectState = posEmpty);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseBusinessList_Read.Init;
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
' OID, ' +
' OIDContactTitle, ' +
' Name1, ' +
' Name2, ' +
' Name3, ' +
' Addition ' +
'FROM  ctr_Business %s %s ;';

Query.SQLText := gFormatSQL(Format(lSQL, [lWhere, lOrder]), TBaseBusiness);

end;

procedure TBaseBusinessList_Read.MapRowToObject;
var
lObj: TBaseBusiness;
lItemClass : TBaseBusinessClass = TBaseBusiness;
begin
if Assigned(TBaseBusinessList.ItemClass) then
lItemClass := TBaseBusinessList.ItemClass;
lObj := lItemClass.Create;
lObj.OID.AssignFromTIQuery('OID',Query);
lObj.OIDContactTitle := Query.FieldAsString['OIDContactTitle'];
lObj.Name1 := Query.FieldAsString['Name1'];
lObj.Name2 := Query.FieldAsString['Name2'];
lObj.Name3 := Query.FieldAsString['Name3'];
lObj.Addition := Query.FieldAsString['Addition'];
lObj.ObjectState := posClean;
TtiObjectList(Visited).Add(lObj);
end;

{ TBaseContactTitle_Create }
function TBaseContactTitle_Create.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseContactTitle) and (Visited.ObjectState = posCreate);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseContactTitle_Create.Init;
begin
Query.SQLText :=
'INSERT INTO ctr_ContactTitle(' +
' OID, ' +
' TitleType, ' +
' Title, ' +
' SearchTitle' +
') VALUES (' +
' :OID, ' +
' :TitleType, ' +
' :Title, ' +
' :SearchTitle' +
') ';
end;

procedure TBaseContactTitle_Create.SetupParams;
var
lObj: TBaseContactTitle;
begin
lObj := TBaseContactTitle(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
Query.ParamAsInteger['TitleType'] := Integer(lObj.TitleType);
Query.ParamAsString['Title'] := lObj.Title;
Query.ParamAsString['SearchTitle'] := lObj.SearchTitle;
end;

{ TBaseContactTitle_Update }
function TBaseContactTitle_Update.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseContactTitle) and (Visited.ObjectState = posUpdate);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseContactTitle_Update.Init;
begin
Query.SQLText :=
'UPDATE ctr_ContactTitle SET ' +
' TitleType = :TitleType, ' +
' Title = :Title, ' +
' SearchTitle = :SearchTitle ' +
'WHERE OID = :OID' ;
end;

procedure TBaseContactTitle_Update.SetupParams;
var
lObj: TBaseContactTitle;
begin
lObj := TBaseContactTitle(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
Query.ParamAsInteger['TitleType'] := Integer(lObj.TitleType);
Query.ParamAsString['Title'] := lObj.Title;
Query.ParamAsString['SearchTitle'] := lObj.SearchTitle;
end;

{ TBaseContactTitle_Read }
function TBaseContactTitle_Read.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseContactTitle) and ((Visited.ObjectState = posPK) OR (Visited.ObjectState = posClean));
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseContactTitle_Read.Init;
begin
Query.SQLText :=
'SELECT ' +
' OID, ' +
' TitleType, ' +
' Title, ' +
' SearchTitle ' +
'FROM ctr_ContactTitle WHERE OID = :OID' ;
end;

procedure TBaseContactTitle_Read.SetupParams;
var
lObj: TBaseContactTitle;
begin
lObj := TBaseContactTitle(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
end;

procedure TBaseContactTitle_Read.MapRowToObject;
var
lObj: TBaseContactTitle;
begin
lObj := TBaseContactTitle(Visited);
lObj.OID.AssignFromTIQuery('OID',Query);
lObj.TitleType := TTitleType(Query.FieldAsInteger['TitleType']);
lObj.Title := Query.FieldAsString['Title'];
lObj.SearchTitle := Query.FieldAsString['SearchTitle'];
end;

{ TBaseContactTitle_Delete }
function TBaseContactTitle_Delete.AcceptVisitor: Boolean;
begin
result := (Visited is TBaseContactTitle) and (Visited.ObjectState = posDelete);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseContactTitle_Delete.Init;
begin
Query.SQLText := 
'DELETE FROM ctr_ContactTitle ' +
'WHERE OID = :OID';
end;

procedure TBaseContactTitle_Delete.SetupParams;
var
lObj: TBaseContactTitle;
begin
lObj := TBaseContactTitle(Visited);
lObj.OID.AssignToTIQuery('OID',Query);
end;

{ TBaseContactTitleList_Read }
function TBaseContactTitleList_Read.AcceptVisitor: Boolean;
begin
result := (Visited.ObjectState = posEmpty);
Log([ClassName, Visited.ClassName, Visited.ObjectStateAsString, Result], lsAcceptVisitor);
end;

procedure TBaseContactTitleList_Read.Init;
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
' OID, ' +
' TitleType, ' +
' Title, ' +
' SearchTitle ' +
'FROM  ctr_ContactTitle %s %s ;';

Query.SQLText := gFormatSQL(Format(lSQL, [lWhere, lOrder]), TBaseContactTitle);

end;

procedure TBaseContactTitleList_Read.MapRowToObject;
var
lObj: TBaseContactTitle;
lItemClass : TBaseContactTitleClass = TBaseContactTitle;
begin
if Assigned(TBaseContactTitleList.ItemClass) then
lItemClass := TBaseContactTitleList.ItemClass;
lObj := lItemClass.Create;
lObj.OID.AssignFromTIQuery('OID',Query);
lObj.TitleType := TTitleType(Query.FieldAsInteger['TitleType']);
lObj.Title := Query.FieldAsString['Title'];
lObj.SearchTitle := Query.FieldAsString['SearchTitle'];
lObj.ObjectState := posClean;
TtiObjectList(Visited).Add(lObj);
end;

initialization
RegisterVisitors;
RegisterMappings;


end.
