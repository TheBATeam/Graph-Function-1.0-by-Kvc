@Echo off
Setlocal enabledelayedexpansion

REM Description:
REM This Graph function simply plots multiple Characters (maybe '*') on the cmd console...
REM As specified to the function through passed arguments or a'Graph file'.

REM This Function is Created by Kvc At,4:16 PM 31/5/2016 ... 

REM It maybe useful in mathematical calculations,graphs, Analysis etc.

REM We hope, you'll like our work... Show your love and Response at our Blog:
REM https://batchprogrammers.blogspot.com

Set Error=1
If /i "%~1" == "" (goto :help)
If /i "%~2" == "" (goto :help)

Set Error=0
If /i "%~1" == "/h" (goto :help)
If /i "%~1" == "-h" (goto :help)
If /i "%~1" == "help" (goto :help)
If /i "%~1" == "/?" (goto :help)
If /i "%~1" == "ver" (Echo.1.0&&goto :Eof)

Set _Console_Height=35
Set _Console_Width=120

Fn.dll Font 1
Mode !_Console_Width!,!_Console_Height!

REM Extra Decoration module for Graph function...
Set /A _Console_Height-=1
Set /A _Console_Width-=1

:: FOR /L %%A In (0,5,!_Console_Height!) Do (Call Line 0 %%A !_Console_Width! %%A 250 08)
:: FOR /L %%A In (0,10,!_Console_Width!) Do (Call Line %%A 0 %%A !_Console_Height! 250 08)

REM Setting-up necessary variables for the function...
Set "_Char=%~1"
Set "_Char=!_Char:~0,1!"
Set _Color=%~2
Set _String=
Set _Points=
Set _Previous_X=%~3
Set /A _Previous_Y=%~4*-1

If /i "%~3" == "-F" (Goto :For_Loop)
Shift /3
Shift /3

:Loop
If /i "%~3" == "" (Goto :End)
Set /a _Y=%~4*-1
Call Line !_Previous_X! !_Previous_Y! %~3 !_Y! !_Char! !_Color! _Result
Set "_String=!_String! %_Result%"
Set "_Points=!_Points!/g %~3 !_Y! /d "!_Char!" "

Set _Previous_X=%~3
Set _Previous_Y=!_Y!
Shift /3
Shift /3
goto :Loop

:For_Loop
If NOT Exist "%~4" (Exit /b 404)
Set _Previous_X=%~3
Set /A _Previous_Y=%~4*-1

For /f "usebackq eol=# Tokens=1,2 delims=," %%A in ("%~4") do (
Set /a _Y=%%B*-1
Call Line !_Previous_X! !_Previous_Y! %~3 !_Y! !_Char! !_Color! _Result
Set "_String=!_String! !_Result!"
Set "_Points=!_Points!/g %~3 !_Y! /d "!_Char!" "
Set _Previous_X=%~3
Set _Previous_Y=!_Y!
)

:End
Batbox /o 0 !_Console_Height! !_String! /c 0x0c !_Points! /c 0x07 
exit /b 0


:help
Echo.
Echo. This function simply prints a Specified Character on the cmd console at
Echo. the specified location. The Bottom-left of the console is taken origin
Echo. then points are plotted against that origin.
ECHo. It maybe helpful in various mathematical operations, or graphs,Analysis
Echo.
Echo. Syntax: Call Graph [Char] [Color] [Co-ord] [Co-ord] [Co-ord] ...
Echo.         Call Graph [Char] [Color] -F "File.Plot"
Echo.         Call Graph [-h ^| help ^| /^? ^| /h]
Echo.         Call Graph [ver]
Echo.         
Echo. Where:
Echo. Char:		Character to represent printing of Points on console...
Echo. Color:		Hexadecimal color code for the Character...
Echo. Ver:		To know version of current plot Function...
Echo. File.plot:	Plot File, It will contain all the co-ordinates to be 
Echo. 		printed on the cmd console...
Echo. Co-Ord:	Co-Ordinates in the form of {X,Y}...
ECHo. -h,help,/h,/?:	To get this help menu...
Echo.
Echo. Example: Call Graph * 0a 2,2 3,3 4,4 5,5 6,6 7,7 8,8
Echo. Example: Call Graph * 0c -F "Example.Plot"
Echo. 
Echo. For more: visit, https://batchprogrammers.blogspot.com #TheBATeam
Exit /b %error%
