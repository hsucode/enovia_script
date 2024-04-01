@echo off
cd /d C:\TomEE
set CATALINA_HOME=C:\TomEE\3dpassport
call C:\TomEE\3dpassport\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3ddashboard
call C:\TomEE\3ddashboard\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dsearch
call C:\TomEE\3dsearch\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dspace_CAS
call C:\TomEE\3dspace_CAS\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dspace_NoCAS
call C:\TomEE\3dspace_NoCAS\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\CentralFCS
call C:\TomEE\CentralFCS\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dcomment
call C:\TomEE\3dcomment\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dsywm
call C:\TomEE\3dsywm\bin\shutdown.bat

