@Echo off
cls

Title Graph 1.0 Demo File by TheBATeam - www.thebateam.org
Set "Path=%Path%;%cd%;%cd%\files"
Color 0a
Mode 80,25

:Main
Cls
Echo.
cls
::Call Graph x 0a 0,99 10,88 20,77 30,66 40,55 50,44 60,33 70,22 80,11 90,5 100,3 110,2 120,1 130,0 160,99
Call Graph x aa 1,1 2,2 3,3 5,5 10,10 20,20 30,22 45,15 60,27

Pause >nul