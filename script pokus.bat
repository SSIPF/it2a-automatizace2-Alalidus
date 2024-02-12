@echo off
setlocal

set file="User_list.txt"
set passwrd="123"

:parameters
	if /I "%~1" == "-file" SET file="%~2"& SHIFT
	if /I "%~1" == "-pswd" SET passwrd="%~2"& SHIFT
	if /I "%~1" == "-help" goto napoveda shift
	SHIFT

if not "%1"=="" goto parameters

if not exist %file% (
	echo File %file% not found.
	pause
	exit /b 1
)

FOR /F "tokens=*" %%i IN (%file%) DO call :vytvoreni %%~i "%passwrd%"

goto END

:vytvoreni
pushd %~dp0
net user "%~1" /fullname:"%~1 %~2" "%~3" /add
if errorlevel 1 (
	echo Failed to create user account %~1.
	pause
	exit /b 2
) else (
	echo User account %~1 created successfully.
)
popd

goto :EOF

:napoveda
echo help:
echo -file --cesta k souboru
echo -pswd --heslo k uctu

:END