unit fmyViewFiles;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls
  , myFileSync_Mgr
  , tiModelMediator
  , tiObject
  , FilenameDisplay
  , FileSyncTaskdisplay
  ;

type

  { TFormViewFiles }

  TFormmyViewFiles = class(TForm)
    LVTar: TListView;
    LVCpy: TListView;
    LVDel: TListView;
    LVUpd: TListView;
    LVSrc: TListView;
    PC: TPageControl;
    TSUpdate: TTabSheet;
    TSDelete: TTabSheet;
    TSCopy: TTabSheet;
    TSTarget: TTabSheet;
    TSSource: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure PCChange(Sender: TObject);
  private
    { Private declarations }
    FFileSyncMgr: TmyFileSyncMgr;
    FMediatorSrc: TtiModelMediator;
    FMediatorTar: TtiModelMediator;
    FMediatorUpd: TtiModelMediator;
    FMediatorDel: TtiModelMediator;
    FMediatorCpy: TtiModelMediator;
    FDisplayListSrc : TFilenameDisplayList;
    FDisplayListTar : TFilenameDisplayList;
    FDisplayListUpd : TFilenameDisplayList;
    FDisplayListDel : TFilenameDisplayList;
    FDisplayListCpy : TFileSyncTaskDisplayList;
    procedure SetFileSyncMgr(const Value: TmyFileSyncMgr);
    procedure SetupMediators;
  public
    { public declarations }
    property FileSyncMgr : TmyFileSyncMgr read FFileSyncMgr write SetFileSyncMgr ;
  published
    Property DisplayListSrc : TFilenameDisplayList Read FDisplayListSrc Write FDisplayListSrc;
    Property DisplayListTar : TFilenameDisplayList Read FDisplayListTar Write FDisplayListTar;
    Property DisplayListUpd : TFilenameDisplayList Read FDisplayListUpd Write FDisplayListUpd;
    Property DisplayListDel : TFilenameDisplayList Read FDisplayListDel Write FDisplayListDel;
    Property DisplayListCpy : TFileSyncTaskDisplayList Read FDisplayListCpy Write FDisplayListCpy;
  end;

var
  FormMyViewFiles: TFormMyViewFiles;

implementation

uses
  tiListMediators
  , tiBaseMediator
  , tiMediators
  ;

{$R *.lfm}

{ TFormViewFiles }

procedure TFormmyViewFiles.PCChange(Sender: TObject);
begin
  if FFileSyncMgr <> nil then
  begin
    // we can do something
    if Assigned(FDisplayListSrc)then
      FDisplayListSrc.Free; // Free tho old list
    FDisplayListSrc := TFilenameDisplayList.CreateCustom(FFileSyncMgr.SourceFileNames);
    if Assigned(FDisplayListSrc)then
      FDisplayListSrc.Update(nil,noChanged,nil);

    if Assigned(FDisplayListTar)then
      FDisplayListTar.Free; // Free tho old list
    FDisplayListTar := TFilenameDisplayList.CreateCustom(FFileSyncMgr.TargetFileNames);
    if Assigned(FDisplayListTar)then
      FDisplayListTar.Update(nil,noChanged,nil);

    if Assigned(FDisplayListDel)then
      FDisplayListDel.Free; // Free tho old list
    FDisplayListDel := TFilenameDisplayList.CreateCustom(FFileSyncMgr.DeleteFileNames);
    if Assigned(FDisplayListDel)then
      FDisplayListDel.Update(nil,noChanged,nil);

    if Assigned(FDisplayListUpd)then
      FDisplayListUpd.Free; // Free tho old list
    FDisplayListUpd := TFilenameDisplayList.CreateCustom(FFileSyncMgr.UpdateFileNames);
    if Assigned(FDisplayListUpd)then
      FDisplayListUpd.Update(nil,noChanged,nil);

    if Assigned(FDisplayListCpy)then
      FDisplayListCpy.Free; // Free tho old list
    FDisplayListCpy := TFileSyncTaskDisplayList.CreateCustom(FFileSyncMgr.CopyFileNames);
    if Assigned(FDisplayListCpy)then
      FDisplayListCpy.Update(nil,noChanged,nil);

  end;
  // To rebuild the list, because it was not populated before
  SetupMediators;
end;

procedure TFormmyViewFiles.FormCreate(Sender: TObject);
begin
  RegisterFallBackMediators;
  RegisterFallBackListmediators;
end;

procedure TFormmyViewFiles.SetFileSyncMgr(const Value: TmyFileSyncMgr);
begin
  if Value <> FFileSyncMgr then
  begin
    // Value have changed
    FFileSyncMgr := Value;
    PCChange(self);
  end;
end;

procedure TFormmyViewFiles.SetupMediators;

  procedure SubSetupMediator(AMediatorSrc: TtiModelMediator; ADisplayList: TFilenameDisplayList; ALV: TListView );
  begin
    if not Assigned(AMediatorSrc) then
    begin
      AMediatorSrc := TtiModelMediator.Create(self);
      AMediatorSrc.AddComposite('PathAndName(300,"File",<);Date(70,"Data",>);Size(70,"Size",>)',ALV);
    end;
    AMediatorSrc.Subject := ADisplayList;
    AMediatorSrc.Active := True;
  end;

begin
  if not Assigned(FMediatorSrc) then
  begin
    FMediatorSrc := TtiModelMediator.Create(self);
    FMediatorSrc.AddComposite('PathAndName(300,"File",<);Date(70,"Data",>);Size(70,"Size",>)',LVSrc);
  end;
  FMediatorSrc.Subject := DisplayListSrc;
  FMediatorSrc.Active := True;

  if not Assigned(FMediatorTar) then
  begin
    FMediatorTar := TtiModelMediator.Create(self);
    FMediatorTar.AddComposite('PathAndName(300,"File",<);Date(70,"Data",>);Size(70,"Size",>)',LVTar);
  end;
  FMediatorTar.Subject := DisplayListTar;
  FMediatorTar.Active := True;

  if not Assigned(FMediatorDel) then
  begin
    FMediatorDel := TtiModelMediator.Create(self);
    FMediatorDel.AddComposite('PathAndName(300,"File",<);Date(70,"Data",>);Size(70,"Size",>)',LVDel);
  end;
  FMediatorDel.Subject := DisplayListDel;
  FMediatorDel.Active := True;

    if not Assigned(FMediatorUpd) then
  begin
    FMediatorUpd := TtiModelMediator.Create(self);
    FMediatorUpd.AddComposite('PathAndName(300,"File",<);Date(70,"Data",>);Size(70,"Size",>)',LVUpd);
  end;
  FMediatorUpd.Subject := DisplayListUpd;
  FMediatorUpd.Active := True;

  if not Assigned(FMediatorCpy) then
  begin
    FMediatorCpy := TtiModelMediator.Create(self);
    FMediatorCpy.AddComposite('PathAndName(300,"File",<);Date(70,"Data",>);Size(70,"Size",>)',LVCpy);
  end;
  FMediatorCpy.Subject := DisplayListCpy;
  FMediatorCpy.Active := True;


end;

end.
