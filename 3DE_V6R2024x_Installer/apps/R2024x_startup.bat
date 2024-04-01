@echo off

goto 2

:2



set CATALINA_HOME=C:\TomEE\3dpassport
call C:\TomEE\3dpassport\bin\startup.bat
timeout /t 20

set CATALINA_HOME=C:\TomEE\3ddashboard
call C:\TomEE\3ddashboard\bin\startup.bat
timeout /t 20

set CATALINA_HOME=C:\tomee\3dsearch
call C:\tomee\3dsearch\bin\startup.bat
timeout /t 40

set CATALINA_HOME=C:\TomEE\3dspace_cas
call C:\TomEE\3dspace_cas\bin\startup.bat
timeout /t 30

set CATALINA_HOME=C:\TomEE\3dspace_nocas
call C:\TomEE\3dspace_nocas\bin\startup.bat
timeout /t 30

goto 1

set CATALINA_HOME=C:\TomEE\3dspaceNoCAS
call C:\TomEE\3dspaceNoCAS\bin\startup.bat
timeout /t 40

set CATALINA_HOME=C:\TomEE\CentralFCS
call C:\TomEE\CentralFCS\bin\startup.bat
timeout /t 40

set CATALINA_HOME=C:\TomEE\3dcomment
call C:\TomEE\3dcomment\bin\startup.bat
timeout /t 20

set CATALINA_HOME=C:\TomEE\3dsywm
call C:\TomEE\3dsywm\bin\startup.bat

:1
