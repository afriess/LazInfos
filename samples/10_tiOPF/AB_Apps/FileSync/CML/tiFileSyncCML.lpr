program tiFileSyncCML;

{$MODE Delphi}

{ $ I tiDefines.inc}

{$IFDEF MSWINDOWS}
  {$APPTYPE CONSOLE}
{$ENDIF}

uses
  SysUtils,
  Interfaces, // this includes the LCL widgetset
  tiFileSyncCML_BOM in 'tiFileSyncCML_BOM.pas';

var
  lFileSyncCML: TtiFileSyncCML;
begin
  lFileSyncCML := TtiFileSyncCML.Create;
  try
    lFileSyncCML.Execute;
  finally
    lFileSyncCML.Free;
  end;
end.
