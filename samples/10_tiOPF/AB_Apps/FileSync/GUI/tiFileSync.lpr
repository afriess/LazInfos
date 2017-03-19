program tiFileSync;

{$MODE Delphi}

uses
  tiBaseObject,
  tiLog,
  Forms, Interfaces,
  tiOPFManager,
  tiUtils,
  tiFileSyncDependencies,
  FMain in 'FMain.pas' {FormMain},
  FViewFiles in 'FViewFiles.pas' {FormViewFiles},
  FProgress in 'FProgress.pas' {FormProgress},
  FFileSyncSetupEdit in 'FFileSyncSetupEdit.pas' {FormFileSyncSetupEdit},
  FFileNameFilterEdit in 'FFileNameFilterEdit.pas' {FormFileNameFilterEdit},
  FtiDialogAbs in 'FtiDialogAbs.pas' {FormTiDialogAbs};

{$R *.res}

begin
  //SetupLogForClient ;
  Application.Initialize;
  tiFileSyncDependencies.RegisterMappings;
  tiFileSyncDependencies.ConnectToDatabase;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;

end.
