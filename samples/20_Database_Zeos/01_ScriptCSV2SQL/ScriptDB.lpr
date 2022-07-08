program ScriptDB;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, tdbfrmmain
  { you can add units after this }
  ,LazLogger;

{$R *.res}
// Debugging start with --debug-log=<file> on commandline

procedure Doinstall;
begin
  //
end;

procedure DoUninstall;
begin
  //
end;

procedure WriteHelp(msg : string ='');
begin
  DebugLn('ScriptDB');
  DebugLn(' ---------------------------- ');
  DebugLn('/u --uninstall        : uninstall');
  DebugLn('/i --install          : install');
  DebugLn('/h --help             : write this help');
  DebugLn('  --debug-log=<file> : enable logging to file');
  DebugLn(' ---------------------------- ');
  DebugLn(msg);
  DebugLn(' ');
end;

var
  ErrorMsg : String;

begin
  DebugLn('****************************************************************');
  DebugLn('Starting...');
  RequireDerivedFormResource:=True;
  Application.Initialize;
  // Check Parameters
  DebugLnEnter('check commandline start');
  ErrorMsg := Application.CheckOptions('hiud', 'help install uninstall debug-log:');
  if ErrorMsg <> '' then begin
    debugln('commandline option not found');
    WriteHelp(ErrorMsg);
    Halt;
  end;
  // Work with the parameters
  if Application.HasOption('h', 'help') then begin
    DebugLn('help');
    WriteHelp;
    Halt;
  end;
  if Application.HasOption('i', 'install') then begin
    DoInstall;
    Halt;
  end;
  if Application.HasOption('u', 'uninstall') then begin
    DoUninstall;
    Halt;
  end;
  if Paramcount=0 then
  begin
    DebugLn('No executable filename parameters');
  end;
  DebugLnExit('check commandline end');
  Application.CreateForm(TtdbFormMain, tdbFormMain);
  Application.Run;
  DebugLn('...Finishing');
end.

