# enovia_script
3DEXPERRENCE SCRIPTS



# 3DEXPERIENCE R2024x windows server installation




## website

```batch
start https://dsplm24x.jxjty.com/3dpassport
start https://dsplm24x.jxjty.com/3ddashboard
start http://dsplm24x.jxjty.com:19001
start https://dsplm24x.jxjty.com/3dswym
start https://dsplm24x.jxjty.com/3dspace
start https://dsplm24x.jxjty.com/federated/search?query=test

```
## host
```batch

echo 127.0.0.1 dsplm24x.jxjty.com>> C:\Windows\System32\drivers\etc\hosts
echo 127.0.0.1 untrusted.dsplm24x.jxjty.com>> C:\Windows\System32\drivers\etc\hosts

```


## java

cd /d %~dp0

```batch
unzip.exe ibm-semeru-open-jdk_x64_windows_17.0.9_9_openj9-0.41.0.zip -d c:\
```

```batch
setx /m Path "%PATH%;%JAVA_HOME%\bin;%JAVA_HOME%\jre\bin;"
```

## apps

- 7zip
- firefox


## user data

- all password 
    
    Qwer1234


## oracle

```batch

unzip httpd-2.4.55-o111s-x64-vs17 -d C:\oracle\product\19c\db_home

```

```batch
sqlplus "/as sysdba" 
```

```batch
SELECT * FROM dba_profiles s WHERE s.profile='DEFAULT'AND resource_name='PASSWORD_LIFE_TIME';
```

```batch
alter profile default limit password_life_time unlimited;
```

### start database
```batch
net start OracleOraDB19Home1TNSListener
net start OracleRemExecServiceV2
net start OracleServiceENOVIAV6

```
```batch
net stop OracleOraDB19Home1TNSListener
net stop OracleRemExecServiceV2
net stop OracleServiceENOVIAV6

```


## apache

```batch
unzip httpd-2.4.55-o111s-x64-vs17 -d c:\
```

创建一个 dsplm24x_jxjty_com.ext 在ssl文件夹，内容如下，后期会用到

```conf

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = dsplm24x.jxjty.com
DNS.2 = dsplm24x.jxjty.com

```
逐步运行如下脚本

```batch

set PATH=C:\Apache24\bin;%JAVA_HOME%\bin;%PATH%

openssl genrsa -des3 -out RootCA.key -passout pass:Qwer1234 2048

openssl req -x509 -sha256 -new -nodes -key RootCA.key -days 3650 -out RootCA.crt -passin pass:Qwer1234 -subj "/C=ZH/ST=BJ/L=BJ/O=DSCN/OU=CS/CN=RootCA"

openssl rsa -in RootCA.key -out dsplm24x_jxjty_com.key -passin pass:Qwer1234

openssl req -new -key dsplm24x_jxjty_com.key -out dsplm24x_jxjty_com.csr -subj "/C=ZH/ST=BJ/L=BJ/O=DSCN/OU=CS/CN=*.jxjty.com"

openssl x509 -sha256 -req -in dsplm24x_jxjty_com.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial -out dsplm24x_jxjty_com.crt -days 3650 -passin pass:Qwer1234 -extfile dsplm24x_jxjty_com.ext

openssl x509 -noout -text -in dsplm24x_jxjty_com.crt

keytool -importcert -keystore "%JAVA_HOME%\lib\security\cacerts" -noprompt -storepass changeit -file RootCA.crt -alias RootCA


keytool -list -keystore "%JAVA_HOME%\lib\security\cacerts" -storepass changeit -alias RootCA

keytool -delete -alias RootCA -keystore "%JAVA_HOME%\lib\security\cacerts" -storepass changeit

keytool -list -keystore /path/to/keystore.jks
keytool -list -v -keystore /path/to/keystore.jks | grep -A 10 'Alias name: mycert'

keytool -list -v -keystore "%JAVA_HOME%\lib\security\cacerts" -storepass changeit


C:\Apache24\bin\openssl.exe x509 -noout -text -in r2022x.crt


```


```XML

mod_authz_core.so
mod_cache.so
mod_cache_disk.so
mod_deflate.so
mod_filter.so
mod_headers.so
mod_log_config.so
mod_proxy.so
mod_proxy_http.so
mod_proxy_wstunnel.so
mod_rewrite.so
mod_setenvif.so
mod_socache_shmcb.so
mod_ssl.so
mod_slotmem_shm.so
mod_alias.so
mod_authz_host.so
mod_dir.so
mod_mime.so

```


v6r2024x_v1.conf

```xml

KeepAlive On
KeepAliveTimeout 6
MaxKeepAliveRequests 400
#LoadModule cache_module modules/mod_cache.so

<IfModule mod_cache.c>
#LoadModule cache_disk_module modules/mod_cache_disk.so
    <IfModule mod_cache_disk.c>
    CacheRoot /opt/data/memory_vol
    CacheEnable disk /
    CacheDirLevels 5
    CacheDirLength 2
    </IfModule>

</IfModule>

#LoadModule deflate_module modules/mod_deflate.so
AddOutputFilterByType DEFLATE text/plain
AddOutputFilterByType DEFLATE text/xml
AddOutputFilterByType DEFLATE text/html
AddOutputFilterByType DEFLATE text/css
AddOutputFilterByType DEFLATE application/xml
AddOutputFilterByType DEFLATE application/x-javascript
AddOutputFilterByType DEFLATE application/javascript
#AddOutputFilterByType DEFLATE application/x-httpd-php
AddOutputFilterByType DEFLATE application/json
AddOutputFilterByType DEFLATE text/javascript
AddOutputFilterByType DEFLATE application/xhtml+xml
AddOutputFilterByType DEFLATE application/rss+xml
AddOutputFilterByType DEFLATE application/atom_xml
Listen 443

<VirtualHost *:443>
    ServerName dsplm24x.jxjty.com
    ServerAlias dsplm24x.jxjty.com
    SSLEngine on
    SSLProxyEngine On
    SSLCertificateFile conf/ssl/dsplm24x_jxjty_com.crt
    SSLCertificateKeyFile conf/ssl/dsplm24x_jxjty_com.key
    ProxyRequests Off
    #Include conf/3DPassport_httpd_fragment.conf
    #Include conf/3DDashboard_httpd_fragment.conf
    #Include conf/mepreferences_httpd_fragment.conf
    #Include conf/federated_httpd_fragment.conf
    #Include conf/3DSpace_httpd_fragment.conf
    #Include conf/fcs_httpd_fragment.conf
    #Include conf/3DSwym_httpd_fragment.conf
    #Include conf/3DNotification_httpd_fragment.conf
    #Include conf/3DComment_httpd_fragment.conf
</VirtualHost>

<VirtualHost *:443>
    ServerName untrusted.dsplm24x.jxjty.com
    ServerAlias untrusted.dsplm24x.jxjty.com
    SSLEngine on
    SSLProxyEngine On
    SSLCertificateFile conf/ssl/dsplm24x_jxjty_com.crt
    SSLCertificateKeyFile conf/ssl/dsplm24x_jxjty_com.key
    ProxyRequests Off
</VirtualHost>

```



## tomee

端口号设置

|  ServerName   | ShutdownPort  |  HTTPPort   | RedirectPort  |
|  ----  | ----  | ----  | ----  |
| 3dpassport | 8005 | 8080 | 8443|
| 3ddashboard | 8006 | 8081 | 8444
| 3dsearch | 8007 | 8082 | 8445 |
| 3dspace_CAS | 8008 | 8083 | 8446 |
| 3dspace_NoCAS | 8009 | 8070 | 8456 |
| FCS | 9005 | 8084 | 8447 |
| 3dswym |9006 | 8085 | 8448 |
| 3dcomment | 9007  | 8086  | 8449 |
| 3dnotification| 8089 | 8087  | 8450 |


使用以下批处理进行文件自动解压

```batch

cd /d %~dp0

md c:\TomEE\3DPassport
md c:\TomEE\3DDashboard
md c:\TomEE\3DSearch
md c:\TomEE\3DSpace_CAS
md c:\TomEE\3DSpace_NoCAS
md c:\TomEE\FCS
md c:\TomEE\3DSwym
md c:\TomEE\3DComment
md c:\TomEE\3DNotification


:a
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\3dpassport
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\3ddashboard
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\3dsearch
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\3dspace_cas
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\fcs
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\3dswym
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\3dcomment
unzip.exe apache-tomee-8.0.12-plus.zip -d c:\TomEE\3dnotification
goto 0
:b
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\3dpassport
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\3ddashboard
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\3dsearch
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\3dspace_cas
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\fcs
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\3dswym
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\3dcomment
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\TomEE\3dnotification
goto 0
:0


```


## slient  installation




## install data


//dsplm24x.jxjty.com:1521/enoviav6

| name | password |
|  ----  | ----  |
| admin_platform@jxjty.com |Qwer1234 |


https://dsplm24x.jxjty.com:443/3dpassport

https://dsplm24x.jxjty.com:443/3dspace


## 3dpassport

```sql

CREATE SMALLFILE TABLESPACE "x3dpassadmin" LOGGING DATAFILE 'passdb.dbf'
SIZE 10M AUTOEXTEND
ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
create user x3dpassadmin identified by x3dpassadmin;
grant CREATE SEQUENCE to x3dpassadmin;
grant CREATE SESSION to x3dpassadmin;
grant CREATE SYNONYM to x3dpassadmin;
grant CREATE TABLE to x3dpassadmin;
ALTER USER x3dpassadmin default tablespace "x3dpassadmin";
ALTER USER x3dpassadmin QUOTA UNLIMITED ON "x3dpassadmin";

CREATE SMALLFILE TABLESPACE "x3dpasstokens" LOGGING DATAFILE 'passtkdb.dbf'
SIZE 10M AUTOEXTEND
ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
create user x3dpasstokens identified by x3dpasstokens;
grant CREATE SEQUENCE to x3dpasstokens;
grant CREATE SESSION to x3dpasstokens;
grant CREATE SYNONYM to x3dpasstokens;
grant CREATE TABLE to x3dpasstokens;
ALTER USER x3dpasstokens default tablespace "x3dpasstokens";
ALTER USER x3dpasstokens QUOTA UNLIMITED ON "x3dpasstokens";

```


```batch

copy D:\DassaultSystemes\R2024x\3DPassport\win_b64\templates\*.conf C:\Apache24\conf

```



## 3ddashboard


```sql

CREATE USER x3ddashadmin IDENTIFIED BY x3ddashadmin;
GRANT CREATE SESSION TO x3ddashadmin;
GRANT RESOURCE TO x3ddashadmin;
CREATE SMALLFILE TABLESPACE x3ddashadmin LOGGING DATAFILE 'x3ddashadmin.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
ALTER USER x3ddashadmin default tablespace x3ddashadmin;
ALTER USER x3ddashadmin QUOTA UNLIMITED ON x3ddashadmin;
GRANT UNLIMITED TABLESPACE TO x3ddashadmin;


```

```batch
copy D:\DassaultSystemes\R2024x\3DDashboard\win_b64\templates\*.conf C:\Apache24\conf

```

## 3dSearch

```batch
copy D:\DassaultSystemes\R2024x\FedSearch\win_b64\templates\*.conf C:\Apache24\conf

```

## 3dspace

Error : Can not load mxoci80.dll ?

[msvcp120.dll](./24_3dspace/msvcp120.dll)

[msvcr120.dll](./24_3dspace/msvcr120.dll)

```batch
copy msvcp120.dll D:\DS\V6R2024x\AM_3DEXP_Platform.AllOS\2\3DSpace\Windows64\1\inst\DBConnectionTest\win_b64\code\bin\

copy msvcr120.dll D:\DS\V6R2024x\AM_3DEXP_Platform.AllOS\2\3DSpace\Windows64\1\inst\DBConnectionTest\win_b64\code\bin

```


```sql
create user M1 identified by M1;
grant connect, resource, create view to M1;
CREATE SMALLFILE TABLESPACE "M1" LOGGING DATAFILE 'M1.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ;
ALTER USER M1 default tablespace M1;
GRANT UNLIMITED TABLESPACE TO M1;

CREATE SMALLFILE TABLESPACE "I1_DATA" LOGGING DATAFILE 'I1_DATA.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;

CREATE SMALLFILE TABLESPACE "I1_INDEX" LOGGING DATAFILE 'I1_INDEX.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ;

CREATE SMALLFILE TABLESPACE "M1_DATA" LOGGING DATAFILE 'M1_DATA.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ;

CREATE SMALLFILE TABLESPACE "M1_INDEX" LOGGING DATAFILE 'M1_INDEX.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ;

CREATE SMALLFILE TABLESPACE "V1_DATA" LOGGING DATAFILE 'V1_DATA.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ;

CREATE SMALLFILE TABLESPACE "V1_INDEX" LOGGING DATAFILE 'V1_INDEX.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO ;


```
for cas
```batch
copy D:\DassaultSystemes\R2024x\3DSpace\win_b64\templates\*.conf C:\Apache24\conf

copy D:\DassaultSystemes\R2024x\3DSpace\win_b64\templates\*CAS*.bat C:\tomee\3dspace_cas\bin\

cd /d C:\tomee\3dspace_cas\bin\
ren setenvCAS.bat setenv.bat

copy  D:\DassaultSystemes\R2024x\3DSpace\distrib_CAS\*.war C:\tomee\3dspace_cas\webapps\
```

for nocas

```batch

copy D:\DassaultSystemes\R2024x\3DSpace\win_b64\templates\setenv.bat C:\tomee\3dspace_nocas\bin\

copy  D:\DassaultSystemes\R2024x\3DSpace\distrib_NoCAS\*.war C:\tomee\3dspace_nocas\webapps\
```


### hotfix

A manual step is required after this hot fix installation.
The following MQL command must be executed once all applications are installed (it may take several minutes).
Start a MQL command window from <server> installation and type this: 

```batch
MQL>set context person creator;
MQL>exec prog VPLMDataMigration;
```


## start server

```batch

@echo off
goto 2
:2
set CATALINA_HOME=C:\TomEE\3dpassport
call C:\TomEE\3dpassport\bin\startup.bat
timeout /t 30

set CATALINA_HOME=C:\TomEE\3ddashboard
call C:\TomEE\3ddashboard\bin\startup.bat
timeout /t 70

goto 1

set CATALINA_HOME=C:\TomEE\3dsearch
call C:\TomEE\3dsearch\bin\startup.bat
timeout /t 40

set CATALINA_HOME=C:\TomEE\3dspaceCAS
call C:\TomEE\3dspaceCAS\bin\startup.bat
timeout /t 160

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


```


## stop server

```batch
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

set CATALINA_HOME=C:\TomEE\3dspaceCAS
call C:\TomEE\3dspaceCAS\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dspaceNoCAS
call C:\TomEE\3dspaceNoCAS\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\CentralFCS
call C:\TomEE\CentralFCS\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dcomment
call C:\TomEE\3dcomment\bin\shutdown.bat
sleep 2

set CATALINA_HOME=C:\TomEE\3dsywm
call C:\TomEE\3dsywm\bin\shutdown.bat


```



## 静默安装方法

```xml
<SetVariableProtected name="PASS_ORACLE_SQLPasswordAdmin" value="x3dpassadmin"/>
```

遇到以上需要写密码的，删除 Protected ，在后面值里面写上密码

使用的自动安装xml 从以下地址复制

https://github.com/hsucode/enovia_script.git


自动复制安装数据

```batch

@echo off
title COPY_InstallData
cd /d %~dp0
md InstallData
xcopy /s /e /c /y /h /r /d .\DassaultSystemes\*UserIntentions*.xml .\InstallData\

```

```bash
cp -ra /app/DassaultSystemes/*UserIntentions*.xml /home/x3ds/Downloads/userdata/

find /app/DassaultSystemes/ -type f -name "*UserIntentions*.xml" -exec cp --parents \{} /home/x3ds/Downloads/userdata/ \;

```




使用以下命令进行软件的静默安装

```batch
@echo off

cd /d %~dp0

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

```

## 设置许可证

```batch
echo localhost:4085 >>C:\ProgramData\DassaultSystemes\Licenses\DSLicSrv.txt
```


powershell 删除所有空文件夹

```sh
$folderPath = "D:\InstallData\InstallData" # 替换为你要遍历的文件夹路径

Get-ChildItem -Path $folderPath -Recurse -Directory | ForEach-Object {
    if ((Get-ChildItem -Path $_.FullName -Recurse -File | Measure-Object).Count -eq 0) {
        Remove-Item -Path $_.FullName -Recurse -Force
    }
}
```
