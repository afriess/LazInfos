unit myFileSync_mgr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  , tiFileSync_Mgr
  ;

type

  { TmyFileSyncMgr }

  TmyFileSyncMgr = class(TtiFileSyncMgr)
  protected
    FTerminated : boolean;

  public
    constructor Create; override;
    destructor  Destroy; override;
    procedure   ReadIndexes; override;
    procedure   Execute;
    procedure   Terminate;

  published

  end;



implementation

{ TmyFileSyncMgr }


constructor TmyFileSyncMgr.Create;
begin
  inherited Create;
end;

destructor TmyFileSyncMgr.Destroy;
begin
  inherited Destroy;
end;

procedure TmyFileSyncMgr.ReadIndexes;
begin

    if FTerminated then Exit; //==>
    Clear;

    if FTerminated then Exit; //==>
    ReadFileLists;

    if FTerminated then Exit; //==>
    //BuildCopyLists;
    //
    //if FTerminated then Exit; //==>
    //if fsaCopy in FileSyncActions then
    //  Inc(FiFileCount, FCopyPathNames.Count);
    //if fsaDelete in FileSyncActions then
    //  Inc(FiFileCount, FDeletePathNames.Count);
    //if fsaUpdate in FileSyncActions then
    //  Inc(FiFileCount, FUpdateFileNames.Count);
    //if fsaCopy in FileSyncActions then
    //  Inc(FiFileCount, FCopyFileNames.Count);
    //if fsaDelete in FileSyncActions then
    //  Inc(FiFileCount, FDeleteFileNames.Count);
    //
    //if FiFileCount = 0 then
    //  Inc(FiFileCount, 1);
    //
    //UpdateProgressMajor(nil, FiFileCount, 1);
    //FiFileNum := 1;

end;

procedure TmyFileSyncMgr.Execute;
begin
  inherited execute;
end;

procedure TmyFileSyncMgr.Terminate;
begin
  FTerminated := true;
end;

end.

