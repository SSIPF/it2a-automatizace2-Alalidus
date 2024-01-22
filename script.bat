@echo off

set file=
set passwrd=123

:parameters
	if /I %~1 == -file SET file=%2& SHIFT
	if /I %~1 == -pswd SET passwrd=%2& SHIFT
	if /I %~1 == -help goto help shift
	SHIFT

if not (%1)==() goto parameters


FOR /F "tokens=*" %%i IN (%file%) DO call :vytvoreni %%i %passwrd%

:vytvoreni
net user %1 /fullname:"%1 %2" %3 /add

goto END

:help
echo help:
echo -file --cesta k souboru
echo -pswd --heslo k uctu

:END
