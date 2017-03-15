unit contactmodel;
// In this unit I can inherit from the base classes and expand the Objects
// Only this unit has access to the business obeject model unit

{$mode objfpc}{$H+}

interface

uses
  Classes
  , SysUtils
  , tiObject
  , contact_bom;

const
  cTitleType: array[TTitleType] of string = ('Einzeladresse', 'Adressgruppe');


type


  { Forward Declaration }
  TBusiness = class;
  TBusinesses = class;
  TContactTitle = class;
  TContactTitles = class;


  { TContactTitles }

  TContactTitles = class(TBaseContactTitleList)
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  { TContactTitle }

  TContactTitle = class(TBaseContactTitle)
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  { TBusinesses }

  TBusinesses = class(TBaseBusinessList)
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
  end;

  TBusiness = class(TBaseBusiness)
  private

  public
    constructor Create; override;
    destructor Destroy; override;
  end;

implementation

{ TBusiness }

constructor TBusiness.Create;
begin
  inherited Create;
end;

destructor TBusiness.Destroy;
begin
  inherited Destroy;
end;

{ TBusinesses }

constructor TBusinesses.Create;
begin
  inherited Create;
end;

destructor TBusinesses.Destroy;
begin
  inherited Destroy;
end;

{ TContactTitles }

constructor TContactTitles.Create;
begin
  inherited Create;
end;

destructor TContactTitles.Destroy;
begin
  inherited Destroy;
end;

{ TContactTitle }

constructor TContactTitle.Create;
begin
  inherited Create;
  FBusinessList.Owner := Self;
  FBusinessList.ItemOwner := Self;
end;

destructor TContactTitle.Destroy;
begin
  inherited Destroy;
end;

end.





