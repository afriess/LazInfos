(*
{ <UTextFileStream>

  Copyright (C) <2015> <name of author> <contact>

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

Source: http://forum.lazarus.freepascal.org/index.php/topic,9509.15.html
*)
unit UTextFileStream;

{$mode objfpc}{$H+}

interface

uses Classes, SysUtils, Dialogs;

type
  TTextFileStream = class(TFileStream)
  private
    FBuffer: string;
    //FLineLength :integer;
  public
    function Eof: Boolean;
    function WriteLn(Text: string):int64;
    function ReadLn: string;
    function Seek(const Offset: Int64; Origin: TSeekOrigin): Int64; override;
    function RowCount: Integer;
    function EditLine(Line :integer; NewText :string):string;
  end;

implementation

{ TTextFileStream }

const
  NewLine = #13#10;

function TTextFileStream.Eof: Boolean;
begin
  Eof := Position - Length(FBuffer) = Size;
end;

function TTextFileStream.ReadLn: string;
const
  BufferLength = 10000;
var
  NewBuffer: string;
  Readed: Integer;
begin
  Readed := 1;
  while (Pos(#13, FBuffer) = 0) and (Readed > 0) do begin
    SetLength(NewBuffer, BufferLength + 2);
    Readed := Read(NewBuffer[1], BufferLength);
    SetLength(NewBuffer, Readed);
    FBuffer := FBuffer + NewBuffer;
  end;
  if Pos(#13, FBuffer) > 0 then begin
    Result := Copy(FBuffer, 1, Pos(#13, FBuffer) - 1);
    Delete(FBuffer, 1, Pos(#13, FBuffer) + 1);
  end else begin
    Result := FBuffer;
    FBuffer := '';
  end;
end;

function TTextFileStream.RowCount: Integer;
begin
  Result := 0;
  FBuffer := '';
  Seek(0, soBeginning);
  while not Eof do begin
    ReadLn;
    Inc(Result);
  end;
  Seek(0, soBeginning);
end;

function TTextFileStream.Seek(const Offset: Int64;
  Origin: TSeekOrigin): Int64;
begin
  if Origin = soCurrent then
    Result := inherited Seek(Offset - Length(FBuffer), Origin)
    else Result := inherited Seek(Offset, Origin);
  FBuffer := '';
end;

function TTextFileStream.WriteLn(Text: string):int64;
begin
  Result := 0;
  if Seek(0, soCurrent) > 0 then
    Write(LineEnding, Length(LineEnding));
  Write(Text[1], Length(Text));
  Result := RowCount;
end;

function TTextFileStream.EditLine(Line :integer; NewText :string):string;
var
  n :integer;
  s :string;
  Buffer :string;
  BytesRead :integer;
  FileLength :integer;
  FilePos :integer;
begin
  Result := '';
  n := 0;
  s := '';
  BytesRead := 1;
  FilePos := 0;
  while (n <= Line) and not Eof do
  begin
    s := Readln;
    Inc(n);
    FilePos := FilePos + Length(s) + Length(NewLine);
  end;
  if Line >= n then
    raise Exception.Create('Line index out of bounds.');
  //FilePos := Position;
  FileLength := Seek(0, soEnd);
  Seek(FilePos, soBeginning);
  SetLength(Buffer, FileLength + Length(NewLine));
  BytesRead := Read(Buffer[1], FileLength - FilePos);
  SetLength(Buffer, BytesRead);
  NewText := NewText + NewLine;
  Seek(int64(FilePos) - int64(Length(s)) - int64(Length(NewLine)), soBeginning);
  Write(NewText[1], Length(NewText));
  Write(Buffer[1], BytesRead);
  SetSize(FilePos - Length(s) - Length(NewLine) + BytesRead + Length(NewText));
  Result := s;
end;

end.
