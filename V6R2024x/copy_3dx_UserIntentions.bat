@echo off
title XCOPY

cd /d %~dp0

md InstallData
xcopy /s /e /c /y /h /r /d D:\DassaultSystemes\*UserIntentions*.xml .\InstallData\
