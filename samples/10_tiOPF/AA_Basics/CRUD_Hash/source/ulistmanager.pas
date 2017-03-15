unit uListManager;

// ONLY FOR TEST !!!!!!!!!

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,tiObject
  ,BOM_Hash
;

type

{ TListManager }

{ Holds all the persistent lists of the project, use only the
   singleton gListManager }
TListManager = class(TtiObject)
private
  FTHashList: THashList;
public
  constructor Create; override;
  destructor  Destroy; override;
published
  property HashList: THashList read FTHashList;
end;


{ Global singleton, holds all the persistent lists of the project }
function gListManager: TListManager;


implementation

var
  uManager: TListManager;

function gListManager: TListManager;
begin
  if not Assigned(uManager) then
    uManager:= TListManager.Create;
  result:= uManager;
end;

{ TListManager }

constructor TListManager.Create;
begin
  inherited Create;
  FTHashList:= THashList.Create;
  FTHashList.Owner:= self;
end;

destructor TListManager.Destroy;
begin
  FTHashList.Free;
  inherited Destroy;
end;


finalization
  uManager.Free;

end.

