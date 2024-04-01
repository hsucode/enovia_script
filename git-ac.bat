
@echo off
Rem xcopy "C:\XUS\200-CODE\Dassault_Systemes\3DEXPERIENCE_XUS_Code\B423\win_b64"\*.* C:\XUS\100-APPS\3DEXPERIENCE_APP\CATApps\BMEDI_B423\CATApps\win_b64    /s /e /c /y /h /r  /d


cd /d %~dp0

rem git add V5R27  V5R28 V5R29 V5R30 V5R31 V6R2019x V6R2020x V6R2021x V6R2022x V6R2023x
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git add .

@echo WRITE UPDATE AND PRESS ENTER:
::set /p GetYourLog=
git commit -m "%date%"
rem git push -u origin master
git push 
cd ..

timeout /t 3