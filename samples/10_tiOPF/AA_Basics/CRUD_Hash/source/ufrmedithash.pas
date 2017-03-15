unit ufrmeditHash;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ActnList, Menus, Grids
  , BOM_Hash
  , VIEW_Hash
  , tiModelMediator
  , FtiPerEditDialog
  , tiObject
  ;

type

  { TfrmEditHash }

  TfrmEditHash = class(TFormTIPerEditDialog)
    actAdd: TAction;
    actDel: TAction;
    actEdit: TAction;
    ActionList1: TActionList;
    ImageList1: TImageList;
    sgHash: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actDelExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure sgHashDblClick(Sender: TObject);
  private
    FMediator: TtiModelMediator;
    FDisplayList : THashDisplayList;

    procedure SetupMediators;
    { private declarations }
  protected
    procedure SetData(const AValue: TtiObject); override;
    function  FormIsValid : boolean; override;
    function  FormIsEdited : boolean; override;
  public
    { public declarations }
    Property DisplayList : THashDisplayList Read FDisplayList Write FDisplayList;

  end;


implementation

uses
  uListManager
  , tiDialogs
  , tiListMediators
  , tiBaseMediator
  , tiMediators
  , FtiPerAutoEditDialog
  ;

{$R *.lfm}


{ TfrmEditHash }

procedure TfrmEditHash.FormCreate(Sender: TObject);
begin
  inherited;
  RegisterFallBackMediators;
  RegisterFallBackListmediators;
end;

procedure TfrmEditHash.FormDestroy(Sender: TObject);
begin
  inherited;
end;

procedure TfrmEditHash.actAddExecute(Sender: TObject);
begin
  ShowMessage('Not implemented');
end;

procedure TfrmEditHash.actDelExecute(Sender: TObject);
var
  c: THash;
  D : THashDisplay;
  M : TtiMediatorView;
begin
  if sgHash.SelectedRangeCount < 1 then
  begin
    tiAppError('You need to select a Hash first');
    Exit;
  end;
  M:= FMediator.FindByComponent(sgHash).Mediator;
  D := THashDisplay(TtiStringGridMediatorView(M).SelectedObject);

  c := D.AHash;

  if tiAppConfirmation('Are you sure you want to delete <%s>', [c.FileHash]) then
  begin
    { We can't use .Deleted property here, because we don't actually save
      changes. This means the ObjectState will only be posDelete and not
      posDeleted, which is what .FreeDeleted is looking for. }
    THashList(Databuffer).BeginUpdate('');
    if Assigned(c) then
    begin
      c.Deleted := True;
      { If we used a database, this call would trigger the delete visitor.
        The database referential integrity checks would also prevent the
        deletion of a record is use. }
      c.Save;
      { If the Save() was successful, this call would remove and free the
        object in memory. }
      THashList(Databuffer).Remove(c);
    end;
    THashList(Databuffer).EndUpdate;
  end;
//  SetupMediators;
end;

procedure TfrmEditHash.actEditExecute(Sender: TObject);
var
  c: THash;
  D : THashDisplay;
  M : TtiMediatorView;
begin
  if sgHash.SelectedRangeCount < 1 then
  begin
    tiAppError('You need to select a Hash first');
    Exit;
  end;
  M:= FMediator.FindByComponent(sgHash).Mediator;
  D := THashDisplay(TtiStringGridMediatorView(M).SelectedObject);

  c := D.AHash;

  TFormTIPerAutoEditDialog.Execute(c,false);

end;

procedure TfrmEditHash.sgHashDblClick(Sender: TObject);
begin
  actDelExecute(Sender);
end;

procedure TfrmEditHash.SetupMediators;
begin
  if not Assigned(FMediator) then
  begin
    FMediator := TtiModelMediator.Create(self);
    FMediator.AddComposite('StoreDate;FileHash;FileName', sgHash);
  end;
  FMediator.Subject := DisplayList;
  FMediator.Active := True;
end;

procedure TfrmEditHash.SetData(const AValue: TtiObject);
begin
  inherited SetData(AValue);
  if AValue is THashList then
  begin
    DisplayList := THashDisplayList.CreateCustom(Databuffer as TtiObjectList);
    // The next call is important, because we have first created the data and after
    //   this the Display List, so we have to inform the displaylist for the data
    DisplayList.Update(Databuffer as TtiObjectList, noChanged, nil);
    SetupMediators;
  end;
end;

function TfrmEditHash.FormIsValid: boolean;
begin
  Result:=inherited FormIsValid;
end;

function TfrmEditHash.FormIsEdited: boolean;
begin
  Result:=inherited FormIsEdited;
end;


initialization
  gMediatorManager.RegisterMediator(TtiStringGridMediatorView, THashDisplayList);
end.

