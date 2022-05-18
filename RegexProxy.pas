UNIT RegexProxy;

interface USES
  RegularExpressions, RegularExpressionsCore,
  Dialogs, Windows, Forms,  system.SysUtils,
  System.Diagnostics, System.Win.Registry, System.StrUtils, System.IOUtils;

function ExecuteProcess( const FileName, Params: string; Folder: string; WaitUntilTerminated, WaitUntilIdle, RunMinimized: boolean;
  var ErrorCode: integer): boolean;

TYPE
   TreFlag = TRegExOption;
   TMyRegexProxy = record
    reEngine: TRegEx;
    rePattern: String;    reFlags: TRegexOptions;
    reSubject: String;
    //=====================
    MatchCol: TMatchCollection;
    GroupCol: TGroupCollection;
    MatchItem: TMatch;
    GroupItem: TGroup;
    procedure ResolveForEach_old_safe( SubjectString: String ); overload;                          // loop
    procedure ResolveForEach_old_sparse( SubjectString: String; sparse: Boolean ); overload;  // GLOBAL loop to-do
   public
    constructor Open( pattern: String; flags: TRegexOptions );
    procedure   ResolveForEach( SubjectString: String );                                         // STICKY matches()
  end;

  procedure   DebugPrint( fmtString: String;   const Args: array of Const );
VAR
  MyRegexProxy1: TMyRegexProxy;

implementation

constructor TMyRegexProxy.Open( pattern: String; flags: TRegexOptions );
begin
  self.reFlags := flags;    self.rePattern := pattern;
  self.reEngine := TRegEx.Create( self.repattern, self.reFlags );
end;

procedure TMyRegexProxy.ResolveForEach( SubjectString: String );                   // STICKY
begin
  self.reSubject := SubjectString;
  try
    MatchCol := reEngine.Matches( reSubject );
  except
    on E: ERegularExpressionError do begin  ShowMessage( 'ERegularExpressionError' );    end;
  end;
end;

procedure TMyRegexProxy.ResolveForEach_old_sparse( SubjectString: String; sparse: Boolean );     // GLOBAL to-do
begin
  self.reSubject := SubjectString;
    try
      MatchItem := reEngine.Match( reSubject );
      while MatchItem.Success do begin
        for var I := 1 to MatchItem.Groups.Count-1 do begin
          GroupItem := MatchItem.Groups[I];
          if GroupItem.Success then begin
            DebugPrint( '%s_%d_%d', [GroupItem.Value, GroupItem.Index, GroupItem.Length] );
          end;
        end;
        var matchCurrent :=  MatchItem.NextMatch();
        if matchCurrent.Success = False then self.GroupCol := MatchItem.Groups;
        MatchItem := MatchItem.NextMatch();
      end;
    except
      on E: ERegularExpressionError do begin  ShowMessage( 'ERegularExpressionError' );      end;
    end;
end;

procedure TMyRegexProxy.ResolveForEach_old_safe( SubjectString: String );                // Current Implementation
begin
  self.reSubject := SubjectString;
    try
      MatchItem := reEngine.Match( reSubject );
      DebugPrint( '%s',  [ self.MatchItem.Value ] );
      while MatchItem.Success do begin
        for var I := 1 to MatchItem.Groups.Count-1 do begin
          GroupItem := MatchItem.Groups[I];
          if GroupItem.Success then begin
            DebugPrint( '%s_%d_%d', [GroupItem.Value, GroupItem.Index, GroupItem.Length] );
          end;
        end;
        var matchCurrent :=  MatchItem.NextMatch();
        if matchCurrent.Success = False then self.GroupCol := MatchItem.Groups;
        MatchItem := MatchItem.NextMatch();
      end;
      // if MatchItem.Success = False then
    except
      on E: ERegularExpressionError do begin  ShowMessage( 'ERegularExpressionError' );      end;
    end;
end;
//===============================================================================================
procedure DebugPrint( fmtString: String;   const Args: array of Const );
begin
  var FormattedString : string := Format( fmtString, Args );
  OutputDebugString( PChar('DEBUG_PRINT >>> [ ' + FormattedString + ' ]' + ' <<< DEBUG_PRINT') );
end;

//========================================================================================================================

function ExecuteProcess(  const FileName, Params: string; Folder: string; WaitUntilTerminated, WaitUntilIdle, RunMinimized: boolean;
  var ErrorCode: integer): boolean;
var
  CmdLine: string;
  WorkingDirP: PChar;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  LMarshaller: TMarshaller;
begin
  Result := true;
  CmdLine := '"' + Copy( FileName, 1, Length(FileName)-1) + '" ' + Params;
  if Folder = '' then Folder := ExcludeTrailingPathDelimiter(ExtractFilePath(FileName));
  ZeroMemory(@StartupInfo, SizeOf(StartupInfo));
  StartupInfo.cb := SizeOf(StartupInfo);
  if RunMinimized then
    begin
      StartupInfo.dwFlags := STARTF_USESHOWWINDOW;
      StartupInfo.wShowWindow := SW_SHOWMINIMIZED;
    end;
  if Folder <> '' then WorkingDirP := PChar(Folder)
  else WorkingDirP := nil;
  if not CreateProcess(nil, PChar(CmdLine), nil, nil, false, 0, nil, WorkingDirP, StartupInfo, ProcessInfo) then
    begin
      Result := false;
      ErrorCode := GetLastError;
      exit;
    end;
  with ProcessInfo do
    begin
      CloseHandle(hThread);
      if WaitUntilIdle then WaitForInputIdle(hProcess, INFINITE);
      if WaitUntilTerminated then
        repeat
          Application.ProcessMessages;
        until MsgWaitForMultipleObjects(1, hProcess, false, INFINITE, QS_ALLINPUT) <> WAIT_OBJECT_0 + 1;
      CloseHandle(hProcess);
    end;
end;


END.
