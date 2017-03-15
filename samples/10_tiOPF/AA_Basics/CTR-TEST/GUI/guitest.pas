unit GuiTest;

{$mode objfpc}{$H+}

interface

uses
  Classes
  , SysUtils
  , FileUtil
  , Forms
  , Controls
  , Graphics
  , Dialogs
  , StdCtrls
  , Grids
  , contactdisplay
  , tiOPFManager
  , tiConstants
  , tiBaseMediator
  , tiQueryZeosMySQL50    // preferred Databas layer
  , tiDialogs             // tiOPF-Dialoge z.B. für tiShowString
  , tiModelMediator       // implement MGM for use with standard controls
  , tiOIDGUID             // To force linking GUID OIDs. Must be included in application at least once.
  , tiListMediators
  , tiMediators
  ;

type

  { TfrmGuiTest }

  TfrmGuiTest = class(TForm)
    btnShow: TButton;
    btnSave: TButton;
    btnEditTitle: TButton;
    cbTitleType: TComboBox;
    edName1: TEdit;
    edName2: TEdit;
    edName3: TEdit;
    edTitleType: TEdit;
    edSearchTitle: TEdit;
    edTitle: TEdit;
    lblTitle: TLabel;
    sgContactsTitle: TStringGrid;
    sgBusiness: TStringGrid;
    procedure btnEditTitleClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnShowClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sgContactsTitleSelection(Sender: TObject; aCol, aRow: integer);
    procedure sgBusinessSelection(Sender: TObject; aCol, aRow: integer);
  private
    { The object we will be working with. }

    //*** Deactivated deactivated direct BOM access and use DSP
    //FContactsTitleList: TContactsTitleList;
    //FContactsTitle: TContactsTitle;
    //*** End of Replacement

    { Form Mediator }
    FListMediator: TtiModelMediator;
    FListMediatorBusiness: TtiModelMediator;

    FMediator: TtiModelMediator;
    FMediatorBusiness: TtiModelMediator;
    FDisplayList: TContactTitleDisplayList;

    procedure SetupMediators;
  published
    property DisplayList: TContactTitleDisplayList read FDisplayList write FDisplayList;

  public
    { public declarations }
  end;

var
  frmGuiTest: TfrmGuiTest;

implementation

{$R *.lfm}

uses
  contactmodel
  , contactmanager
  , frm_EditTitle;

{ TfrmGuiTest }

procedure TfrmGuiTest.SetupMediators;
begin

  if not Assigned(FMediator) then
  begin
    FMediator := TtiModelMediator.Create(self);
    //FMediator.Name := 'ContactsTitleMediator';

    FMediator.AddComposite('TitleType(50,"Typ",<);Title(250,"Titel",<);SearchTitle(250,"Sortierbegriff",<)', sgContactsTitle);


    //FMediator.AddProperty('Title', lblTitle);
    //FMediator.AddProperty('Title', edTitle);
    //FMediator.AddProperty('SearchTitle', edSearchTitle);
    ////FMediator.AddProperty('City', cbCity).ValueList := gContactManager.CityList;
    //FMediator.AddProperty('TitleType', cbTitleType);
  end;
  FMediator.Subject := DisplayList;
  FMediator.Active := True;

  if not Assigned(FListMediatorBusiness) then
  begin
    FListMediatorBusiness := TtiModelMediator.Create(self);
    FListMediatorBusiness.Name := 'BusinessesMediator';
    FListMediatorBusiness.AddComposite('Name1(200,"Name1",<);Name2(200,"Name2",<);Name3(200,"Name3",<)', sgBusiness);
  end;
  FListMediatorBusiness.Subject := gContactManager.Businesses;
  FListMediatorBusiness.Active := True;

  if not Assigned(FMediatorBusiness) then
  begin
    FMediatorBusiness := TtiModelMediator.Create(self);
    FMediatorBusiness.Name := 'BusinessMediator';
    FMediatorBusiness.AddProperty('Name1', edName1);
    FMediatorBusiness.AddProperty('Name2', edName2);
    FMediatorBusiness.AddProperty('Name3', edName3);
  end;
  FMediatorBusiness.Subject := FListMediatorBusiness.SelectedObject[sgBusiness];
  FMediatorBusiness.Active := True;

end;

procedure TfrmGuiTest.btnShowClick(Sender: TObject);
begin
  tiShowString(gContactManager.AsDebugString);
end;

procedure TfrmGuiTest.btnSaveClick(Sender: TObject);
begin
  // This is not the right way I think ...
  FListMediatorBusiness.SelectedObject[sgBusiness].Dirty := True;
  //FListMediator.SelectedObject[sgContactsTitle].Dirty := True;
  FMediator.SelectedObject[sgContactsTitle].Dirty:=True;
  //TContactsTitleDisplay(TtiStringGridMediatorView(M).SelectedObject).Dirty:=True;
  gContactManager.Businesses.Save;
  gContactManager.ContactTitles.Save;
end;

procedure TfrmGuiTest.btnEditTitleClick(Sender: TObject);
var
  M: TtiMediatorView;
  D: TContactTitleDisplay;
  C: TContactTitle;
begin
  M := FMediator.FindByComponent(sgContactsTitle).Mediator;
  D := TContactTitleDisplay(TtiStringGridMediatorView(M).SelectedObject);
  C := D.ContactTitle;
  if Assigned(C) then
    if EditTitleData(C) then
    begin
      gContactManager.ContactTitles.Extract(c);
      C.Deleted := True;
      C.Free;
      M.ObjectToGui;
    end;
end;

procedure TfrmGuiTest.FormCreate(Sender: TObject);
begin
  gTiOPFManager.DefaultPersistenceLayerName := cTIPersistZeosMySQL50;
  gTiOPFManager.ConnectDatabase('CTR-NEU', 'root', 'test', 'Hostname=localhost', cTIPersistZeosMySQL50);

  RegisterFallbackListMediators;
  RegisterFallbackMediators;

  FDisplayList := TContactTitleDisplayList.CreateCustom(gContactManager.ContactTitles);
  gContactManager.PopulateContacts;
  SetupMediators;

end;

procedure TfrmGuiTest.FormDestroy(Sender: TObject);
begin
  //*** Deactivated deactivated direct BOM access and use DSP
  //FContactsTitleList.Free;
  //FContactsTitle.Free;
  //*** End of Replacement
end;

procedure TfrmGuiTest.FormShow(Sender: TObject);
begin
  //SetupMediators;
end;

procedure TfrmGuiTest.sgContactsTitleSelection(Sender: TObject; aCol, aRow: integer);
begin
  //FMediator.Active := False;
  //FMediator.Subject := FListMediator.SelectedObject[sgContactsTitle];
  //FMediator.Active := True;
end;

procedure TfrmGuiTest.sgBusinessSelection(Sender: TObject; aCol, aRow: integer);
begin
  FMediatorBusiness.Active := False;
  FMediatorBusiness.Subject := FListMediatorBusiness.SelectedObject[sgBusiness];
  FMediatorBusiness.Active := True;
end;

initialization



end.






