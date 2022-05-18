unit UEnvVars;

interface

{$IFDEF CONDITIONALEXPRESSIONS}
  {$IF CompilerVersion >= 15.0} // >= Delphi 7
    {$WARN UNSAFE_CODE OFF}
  {$IFEND}
{$ENDIF}


uses
  // Delphi
  Classes;


function GetEnvVarValue(const VarName: string): string;
function SetEnvVarValue(const VarName, VarValue: string): Integer;
function DeleteEnvVar(const VarName: string): Integer;
function CreateEnvBlock(const NewEnv: TStrings; const IncludeCurrent: Boolean;
  const Buffer: Pointer; const BufSize: Integer): Integer;
function ExpandEnvVars(const Str: string): string;
function GetAllEnvVars(const Vars: TStrings): Integer;


implementation

uses
  // Delphi
  Windows, SysUtils;

function GetEnvVarValue(const VarName: string): string;
var
  BufSize: Integer;  // buffer size required for value
begin
  // Get required buffer size (inc. terminal #0)
  BufSize := GetEnvironmentVariable(PChar(VarName), nil, 0);
  if BufSize > 0 then
  begin
    // Read env var value into result string
    SetLength(Result, BufSize - 1);
//    GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
      GetEnvironmentVariable(PChar(VarName), PChar(Result), BufSize);
  end
  else
    // No such environment variable
    Result := '';
end;

function SetEnvVarValue(const VarName, VarValue: string): Integer;
begin
  if SetEnvironmentVariable(PChar(VarName), PChar(VarValue)) then
    Result := 0
  else
    Result := GetLastError;
end;

function DeleteEnvVar(const VarName: string): Integer;
begin
  if SetEnvironmentVariable(PChar(VarName), nil) then
    Result := 0
  else
    Result := GetLastError;
end;

function CreateEnvBlock(const NewEnv: TStrings;
  const IncludeCurrent: Boolean; const Buffer: Pointer;
  const BufSize: Integer): Integer;
var
  EnvVars: TStringList; // env vars in new block
  Idx: Integer;         // loops thru env vars
  PBuf: PChar;          // start env var entry in block
begin
  // String list for new environment vars
  EnvVars := TStringList.Create;
  try
    // include current block if required
    if IncludeCurrent then
      GetAllEnvVars(EnvVars);
    // store given environment vars in list
    if Assigned(NewEnv) then
      EnvVars.AddStrings(NewEnv);
    // Calculate size of new environment block
    Result := 0;
    for Idx := 0 to Pred(EnvVars.Count) do
      Inc(Result, Length(EnvVars[Idx]) + 1);
    Inc(Result);
    // Create block if buffer large enough
    if (Buffer <> nil) and (BufSize >= Result) then
    begin
      // new environment blocks are always sorted
      EnvVars.Sorted := True;
      // do the copying
      PBuf := Buffer;
      for Idx := 0 to Pred(EnvVars.Count) do
      begin
        StrPCopy(PBuf, EnvVars[Idx]);
        Inc(PBuf, Length(EnvVars[Idx]) + 1);
      end;
      // terminate block with additional #0
      PBuf^ := #0;
    end;
  finally
    EnvVars.Free;
  end;
end;

function ExpandEnvVars(const Str: string): string;
var
  BufSize: Integer; // size of expanded string
  LMarshaller: TMarshaller;
begin
  // Get required buffer size
  BufSize := ExpandEnvironmentStrings(PChar(Str), nil, 0);
  if BufSize > 0 then
  begin
    // Read expanded string into result string
    SetLength(Result, BufSize);
//    var WideBuffer : PChar;
//    ExpandEnvironmentStrings(PChar(Str), WideBuffer, BufSize);
//    Result := WideBuffer;
    ExpandEnvironmentStrings(PChar(Str), PChar(Result), BufSize);
  end
  else
    // Trying to expand empty string
    Result := '';
end;

function GetAllEnvVars(const Vars: TStrings): Integer;
var
  PEnvVars: PChar;    // pointer to start of environment block
  PEnvEntry: PChar;   // pointer to an env string in block
begin
  // Clear the list
  if Assigned(Vars) then
    Vars.Clear;
  // Get reference to environment block for this process
  PEnvVars := GetEnvironmentStrings;
  if PEnvVars <> nil then
  begin
    // We have a block: extract strings from it
    // Env strings are #0 separated and list ends with #0#0
    PEnvEntry := PEnvVars;
    try
      while PEnvEntry^ <> #0 do
      begin
        if Assigned(Vars) then
          Vars.Add(PEnvEntry);
        Inc(PEnvEntry, StrLen(PEnvEntry) + 1);
      end;
      // Calculate length of block
      Result := (PEnvEntry - PEnvVars) + 1;
    finally
      // Dispose of the memory block
      Windows.FreeEnvironmentStrings(PEnvVars);
    end;
  end
  else
    // No block => zero length
    Result := 0;
end;

end.

