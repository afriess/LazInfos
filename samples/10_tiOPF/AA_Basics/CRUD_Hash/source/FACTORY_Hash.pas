unit FACTORY_Hash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,BOM_Hash
  ,tiObject
  ,tiOPFManager
  ,mapper
;


type
  { THashFactory }

  THashFactory = class(TPerObjFactory)
  public
    Function   CreateInstance( const pStrClassID : string) : THash ; reintroduce ;
  end;

function gHashFactory : THashFactory ;


implementation
uses
  tiQuery
  , tiLog
  ;

var
  uHashFactory : THashFactory;


function gHashFactory: THashFactory;
begin
  if uHashFactory = nil then
    uHashFactory := THashFactory.Create ;
  result := uHashFactory ;
end;


{ THashFactory }

function THashFactory.CreateInstance(const pStrClassID: string): THash;
begin
  Result := nil;
  Log([ClassName, pStrClassID ], lsDebug);
  if pStrClassID = '' then
    exit; //==>
  Result := THash( inherited CreateInstance( pStrClassID )) ;
  Log([ClassName, Result.FileHash, pStrClassID ], lsDebug);
end;


initialization
  gHashFactory.RegisterClass('Hash', THash);

finalization
  uHashFactory.Free ;

end.

