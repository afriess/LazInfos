unit SVmain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ActnList,
  ComCtrls, StdCtrls
  , tiFileSync_Mgr
  , myFileSync_Mgr
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    ActMyViewFiles: TAction;
    ActViewFiles: TAction;
    ActionList1: TActionList;
    Ed_Source: TEdit;
    Ed_Dest: TEdit;
    Lb_Source: TLabel;
    Lb_Dest: TLabel;
    ToolBar1: TToolBar;
    TBViewFiles: TToolButton;
    ToolButton1: TToolButton;
    procedure ActMyViewFilesExecute(Sender: TObject);
    procedure ActViewFilesExecute(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  fViewFiles
  , fmyviewfiles
  , cFileSync
  , tiFileSyncReader_Abs
  , tiFileSyncReader_DiskFiles
  ;

{$R *.lfm}

{ TForm1 }

procedure TForm1.ActViewFilesExecute(Sender: TObject);
var
  lForm : TFormViewFiles ;
  lFSM  : TtiFileSyncMgr;
begin
  lFSM  := TtiFileSyncMgr.Create;
  try
    Screen.Cursor := crHourGlass ;
    try
      // lFSM.AssignFromFileSyncDir(FData.FileSyncDirs.Items[0]);
      lFSM.SourceFileNames.StartDir := Ed_Source.Text;
      lFSM.SourceReader             := cgsDiskFiles;
      lFSM.TargetFileNames.StartDir := Ed_Dest.Text;
      lFSM.TargetReader             := cgsDiskFiles;

      lFSM.ReadIndexes ;
    finally
      Screen.Cursor := crDefault ;
    end ;
    lForm := TFormViewFiles.Create( nil ) ;
    try
      lForm.FileSyncMgr := lFSM;
      lForm.ShowModal ;
    finally
      lForm.Free ;
    end ;
  finally
    lFSM.Free;
  end;
end;

procedure TForm1.ActMyViewFilesExecute(Sender: TObject);
var
  lForm : TFormMyViewFiles;
  lFSM  : TmyFileSyncMgr;
begin
  lFSM  := TmyFileSyncMgr.Create;
  try
    Screen.Cursor := crHourGlass ;
    try
      lFSM.SourceFileNames.StartDir := Ed_Source.Text;
      lFSM.SourceReader             := cgsDiskFiles;
      lFSM.TargetFileNames.StartDir := Ed_Dest.Text;
      lFSM.TargetReader             := cgsDiskFiles;

      lFSM.ReadIndexes ;
    finally
      Screen.Cursor := crDefault ;
    end ;
    lForm := TFormMyViewFiles.Create( nil ) ;
    try
      lForm.FileSyncMgr := lFSM ;
      lForm.ShowModal ;
    finally
      lForm.Free ;
    end ;
  finally
    lFSM.Free;
  end;
end;

end.

