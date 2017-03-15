unit contact_vishc;

{$I tiDefines.inc}

interface

uses
  tiVisitorDB
  , tiObject
  , contact_BOM;

type

  TVisBaseContactTitle_Read = class(TtiVisitorSelect)
  private
    FBaseContactTitle: TBaseContactTitle;
  protected
    function AcceptVisitor: boolean; override;
    procedure Init; override;
    procedure SetupParams; override;
    procedure MapRowToObject; override;
  end;

  TVisBaseContactTitle_Create = class(TtiVisitorUpdate)
  protected
    function AcceptVisitor: boolean; override;
    procedure Init; override;
    procedure SetupParams; override;
  end;

  TVisBaseContactTitle_Update = class(TtiVisitorUpdate)
  protected
    function AcceptVisitor: boolean; override;
    procedure Init; override;
    procedure SetupParams; override;
  end;

  TVisBaseContactTitle_Delete = class(TtiVisitorUpdate)
  protected
    function AcceptVisitor: boolean; override;
    procedure Init; override;
    procedure SetupParams; override;
    procedure Final(const AVisited: TtiObject); override;
  end;

  TVisBaseBusiness_Create = class(TtiVisitorUpdate)
  protected
    function AcceptVisitor: boolean; override;
    procedure Init; override;
    procedure SetupParams; override;
  end;

  TVisBaseBusiness_Update = class(TtiVisitorUpdate)
  protected
    function AcceptVisitor: boolean; override;
    procedure Init; override;
    procedure SetupParams; override;
  end;

  TVisBaseBusiness_Delete = class(TtiVisitorUpdate)
  protected
    function AcceptVisitor: boolean; override;
    procedure Init; override;
    procedure SetupParams; override;
  end;

procedure RegisterVisitors;

implementation

uses
  tiOPFManager;

procedure RegisterVisitors;
begin
  // Note: Registration order is important
  GTIOPFManager.RegReadVisitor(TVisBaseContactTitle_Read);

  GTIOPFManager.RegSaveVisitor(TVisBaseContactTitle_Create);
  GTIOPFManager.RegSaveVisitor(TVisBaseContactTitle_Update);
  GTIOPFManager.RegSaveVisitor(TVisBaseBusiness_Create);
  GTIOPFManager.RegSaveVisitor(TVisBaseBusiness_Update);

  GTIOPFManager.RegSaveVisitor(TVisBaseBusiness_Delete);
  GTIOPFManager.RegSaveVisitor(TVisBaseContactTitle_Delete);

end;

{ TVisBaseContactTitle_Read }

function TVisBaseContactTitle_Read.AcceptVisitor: boolean;
begin
  Result := (Visited is TBaseContactTitleList) and (Visited.ObjectState = posEmpty);
end;

procedure TVisBaseContactTitle_Read.Init;
begin
  Query.SQL.Text :=
    'select ' +
    '   c.oid as OID ' +
    '  ,c.TitleType as TitleType ' +
    '  ,c.Title as Title ' +
    '  ,c.SearchTitle as SearchTitle ' +
    '  ,b.oid as OID ' +
    '  ,b.OIDContactTitle as OIDContactTitle ' +
    '  ,b.Name1 as Name1 ' +
    '  ,b.Name2 as Name2 ' +
    '  ,b.Name3 as Name3 ' +
    '  ,b.Addition as Addition ' +
    'from ' +
    '  ctr_ContactTitle  c ' +
    'left join ctr_Business b on b.OIDContactTitle = c.oid ' +
    'order by ' +
    'Title ';
end;

procedure TVisBaseContactTitle_Read.MapRowToObject;
var
  lBaseBusiness: TBaseBusiness;
begin
  if (FBaseContactTitle = nil) or (FBaseContactTitle.OID.AsString <> Query.FieldAsString ['OID']) then
  begin
    FBaseContactTitle := TBaseContactTitle.Create;
    FBaseContactTitle.OID.AssignFromTIQuery('OID', Query);
    //FBaseContactTitle.TitleType := Query.FieldAsString['TitleType'];
    FBaseContactTitle.Title := Query.FieldAsString ['Title'];
    FBaseContactTitle.SearchTitle := Query.FieldAsString ['SearchTitle'];
    FBaseContactTitle.ObjectState := posClean;
    FBaseContactTitle.BusinessList.ObjectState := posClean;
    TBaseContactTitleList(Visited).Add(FBaseContactTitle);
  end;

  if Query.FieldAsString ['Phone_Number_OID'] <> '' then
  begin
    lBaseBusiness := TBaseBusiness.Create;
    lBaseBusiness.OID.AssignFromTIQuery('OID', Query);
    lBaseBusiness.OIDContactTitle := Query.FieldAsString ['OIDContactTitle'];
    lBaseBusiness.Name1 := Query.FieldAsString ['Name1'];
    lBaseBusiness.Name2 := Query.FieldAsString ['Name2'];
    lBaseBusiness.Name3 := Query.FieldAsString ['Name3'];
    lBaseBusiness.Addition := Query.FieldAsString ['Addition'];
    lBaseBusiness.ObjectState := posClean;
    FBaseContactTitle.BusinessList.Add(lBaseBusiness);
  end;

end;

procedure TVisBaseContactTitle_Read.SetupParams;
begin
  // Do nothing
end;

{ TVisBaseContactTitle_Create }

function TVisBaseContactTitle_Create.AcceptVisitor: boolean;
begin
  Result := (Visited is TBaseContactTitle) and (Visited.ObjectState = posCreate);
end;

procedure TVisBaseContactTitle_Create.Init;
begin
  Query.SQL.Text :=
    'Insert into ctr_ContactTitle (OID, TitleType, Title, SearchTitle) ' +
    'Values ' +
    '(:OID,:TitleType,:Title,:SearchTitle)';
end;

procedure TVisBaseContactTitle_Create.SetupParams;
var
  lData: TBaseContactTitle;
begin
  lData := Visited as TBaseContactTitle;
  lData.OID.AssignToTIQuery('OID', Query);
  //Query.ParamAsString['TitleType'] := lData.TitleType;
  Query.ParamAsString['Title'] := lData.Title;
  Query.ParamAsString['SearchTitle'] := lData.SearchTitle;
end;

{ TVisBaseContactTitle_Update }

function TVisBaseContactTitle_Update.AcceptVisitor: boolean;
begin
  Result := (Visited is TBaseContactTitle) and (Visited.ObjectState = posUpdate);
end;

procedure TVisBaseContactTitle_Update.Init;
begin
  Query.SQL.Text :=
    'Update ctr_ContactTitle Set ' +
    '  TitleType =:TitleType ' +
    ' ,Title =:Title ' +
    ' ,SearchTitle =:SearchTitle ' +
    'where ' +
    ' OID =:OID';
end;

procedure TVisBaseContactTitle_Update.SetupParams;
var
  lData: TBaseContactTitle;
begin
  lData := Visited as TBaseContactTitle;
  lData.OID.AssignToTIQuery('OID', Query);
  //Query.ParamAsString['TitleType'] := lData.TitleType;
  Query.ParamAsString['Title'] := lData.Title;
  Query.ParamAsString['SearchTitle'] := lData.SearchTitle;
end;

{ TVisBaseContactTitle_Delete }

function TVisBaseContactTitle_Delete.AcceptVisitor: boolean;
begin
  Result := (Visited is TBaseContactTitle) and (Visited.ObjectState = posDelete);
end;

procedure TVisBaseContactTitle_Delete.Final(const AVisited: TtiObject);
var
  lData: TBaseContactTitle;
begin
  inherited;
  lData := AVisited as TBaseContactTitle;
  lData.BusinessList.ObjectState := posClean;
end;

procedure TVisBaseContactTitle_Delete.Init;
begin
  Query.SQL.Text :=
    'delete from ctr_ContactTitle where oid =:oid';
end;

procedure TVisBaseContactTitle_Delete.SetupParams;
var
  lData: TBaseContactTitle;
begin
  lData := Visited as TBaseContactTitle;
  lData.OID.AssignToTIQuery('OID', Query);
end;

{ TVisBaseBusiness_Create }

function TVisBaseBusiness_Create.AcceptVisitor: boolean;
begin
  Result := (Visited is TBaseBusiness) and (Visited.ObjectState = posCreate);
end;

procedure TVisBaseBusiness_Create.Init;
begin
  Query.SQL.Text :=
    'Insert into ctr_Business (OID, OIDContactTitle, Name1, Name2, Name2, Addition) ' +
    'Values ' +
    '(:OID,:OIDContactTitle,:Name1,:Name2,:Name3,:Addition)';
end;

procedure TVisBaseBusiness_Create.SetupParams;
var
  lData: TBaseBusiness;
begin
  lData := Visited as TBaseBusiness;
  lData.OID.AssignToTIQuery('OID', Query);
  lData.Owner.OID.AssignToTIQuery('OIDContactTitle', Query);
  Query.ParamAsString['Name1'] := lData.Name1;
  Query.ParamAsString['Name2'] := lData.Name2;
  Query.ParamAsString['Name3'] := lData.Name3;
  Query.ParamAsString['Addition'] := lData.Addition;
end;

{ TVisBaseBusiness_Update }

function TVisBaseBusiness_Update.AcceptVisitor: boolean;
begin
  Result := (Visited is TBaseBusiness) and (Visited.ObjectState = posUpdate);
end;

procedure TVisBaseBusiness_Update.Init;
begin
  Query.SQL.Text :=
    'Update ctr_Business Set ' +
    //'  OIDContactTitle =:OIDContactTitle ' +
    ' ,Name1 =:Name1 ' +
    ' ,Name2 =:Name2 ' +
    ' ,Name3 =:Name3 ' +
    ' ,Addition =:Addition ' +
    'where ' +
    ' OID =:OID';
end;

procedure TVisBaseBusiness_Update.SetupParams;
var
  lData: TBaseBusiness;
begin
  lData := Visited as TBaseBusiness;
  lData.OID.AssignToTIQuery('OID', Query);
  Query.ParamAsString['OID'] := lData.OID.AsString;
  Query.ParamAsString['OIDContactTitle'] := lData.OIDContactTitle;
  Query.ParamAsString['Name1'] := lData.Name1;
  Query.ParamAsString['Name2'] := lData.Name2;
  Query.ParamAsString['Name3'] := lData.Name3;
  Query.ParamAsString['Addition'] := lData.Addition;
end;

{ TVisBaseBusiness_Delete }

function TVisBaseBusiness_Delete.AcceptVisitor: boolean;
begin
  Result := (Visited is TBaseBusiness) and (Visited.ObjectState = posDelete);
end;

procedure TVisBaseBusiness_Delete.Init;
begin
  Query.SQL.Text :=
    'delete from ctr_Business where oid =:oid';
end;

procedure TVisBaseBusiness_Delete.SetupParams;
var
  lData: TBaseBusiness;
begin
  lData := Visited as TBaseBusiness;
  lData.OID.AssignToTIQuery('OID', Query);
end;

end.































