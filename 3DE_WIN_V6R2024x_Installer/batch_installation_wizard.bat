@echo off

cd /d %~dp0
::License
@REM echo localhost:4085 >>C:\ProgramData\DassaultSystemes\Licenses\DSLicSrv.txt
:GA
echo 3DPassport
AM_3DEXP_Platform.AllOS\1\3DPassport\Windows64\1\StartTUI.exe --silent InstallData\3DPassport\UserIntentions_CODE.xml
echo 3DDashboard
AM_3DEXP_Platform.AllOS\1\3DDashboard\Windows64\1\StartTUI.exe --silent InstallData\3DDashboard\UserIntentions_CODE.xml
echo 3DSearch
AM_3DEXP_Platform.AllOS\1\FederatedSearchFoundation\Windows64\1\StartTUI.exe --silent InstallData\FedSearch\UserIntentions_CODE.xml
echo 3DSpaceIndex
AM_3DEXP_Platform.AllOS\2\3DSpaceIndex\Windows64\1\StartTUI.exe --silent InstallData\3DSpaceIndex\UserIntentions_CODE.xml
echo 3DSpace
AM_3DEXP_Platform.AllOS\2\3DSpace\Windows64\1\StartTUI.exe --silent	InstallData\3DSpace\UserIntentions_CODE.xml

echo 3DSwym
echo 3DNotification
echo 3DComment


:FP
