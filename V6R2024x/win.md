

# windows server installation




## website

```batch
start https://dsplm24x.jxjty.com/3dpassport
start https://dsplm24x.jxjty.com/3ddashboard
start http://dsplm24x.jxjty.com:19001
start https://dsplm24x.jxjty.com/3dswym
start https://dsplm24x.jxjty.com/3dspace


```
## host
```batch

echo 127.0.0.1 dsplm24x.jxjty.com>> C:\Windows\System32\drivers\etc\hosts
echo 127.0.0.1 untrusted.dsplm24x.jxjty.com>> C:\Windows\System32\drivers\etc\hosts

```


## java

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
sqlplus "/as sysdba" 
```

```batch
SELECT * FROM dba_profiles s WHERE s.profile='DEFAULT'AND resource_name='PASSWORD_LIFE_TIME';
```

```batch
alter profile default limit password_life_time unlimited;
```

## start database
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

openssl req -new -key dsplm24x_jxjty_com.key -out dsplm24x_jxjty_com.csr -subj"/C=ZH/ST=BJ/L=BJ/O=DSCN/OU=CS/CN=*.jxjty.com"

openssl x509 -sha256 -req -in dsplm24x_jxjty_com.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial -out dsplm24x_jxjty_com.crt -days 3650 -passin pass:Qwer1234 -extfile dsplm24x_jxjty_com.ext

openssl x509 -noout -text -in dsplm24x_jxjty_com.crt

keytool -importcert -keystore "%JAVA_HOME%\lib\security\cacerts" -noprompt -storepass changeit -file RootCA.crt -alias RootCA


keytool -list -keystore "%JAVA_HOME%\lib\security\cacerts" -storepass changeit -alias RootCA

```

## apache

v6r2024x_v1.conf

```conf

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


|  ServerName   | ShutdownPort  |  HTTPPort   | RedirectPort  |
|  ----  | ----  | ----  | ----  |
| 3dpassport | 8005 | 8080 | 8443|
| 3ddashboard | 8006 | 8081 | 8444
| 3dsearch | 8007 | 8082 | 8445 |
| 3dspace(CAS) | 8008 | 8083 | 8446 |
| FCS | 9005 | 8084 | 8447 |
| 3dswym |9006 | 8085 | 8448 |
| 3dcomment | 9007  | 8086  | 8449 |
| 3dnotification| 8089 | 8087  | 8450 |


```batch

md c:\tomee\3dpassport
md c:\tomee\3ddashboard
md c:\tomee\3dsearch
md c:\tomee\3dspace_cas
md c:\tomee\fcs
md c:\tomee\3dswym
md c:\tomee\3dcomment
md c:\tomee\3dnotification

unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\3dpassport
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\3ddashboard
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\3dsearch
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\3dspace_cas
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\fcs
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\3dswym
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\3dcomment
unzip.exe apache-tomee-9.1.2-plus.zip -d c:\tomee\3dnotification


```


## slient  installation



## UserIntentions

备份

```batch
md c:\UserIntentions\3dpassport\
copy D:\DassaultSystemes\R2024x\3DPassport\InstallData\*UserIntentions*.xml c:\UserIntentions\3dpassport\

md c:\UserIntentions\3ddashboard\
copy D:\DassaultSystemes\R2024x\3DDashboard\InstallData\*UserIntentions*.xml c:\UserIntentions\3ddashboard\

md c:\UserIntentions\3dspaceindex\
copy D:\DassaultSystemes\R2024x\3DSpaceIndex\InstallData\*UserIntentions*.xml c:\UserIntentions\3dspaceindex\

```

```batch
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

```

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



## user intentions

```xml
<SetVariableProtected name="PASS_ORACLE_SQLPasswordAdmin" value="x3dpassadmin"/>
```

遇到以上需要写密码的，删除 Protected ，在后面值里面写上密码

### 3dpassport_ga

```xml
<?xml version="1.0" encoding="UTF-8"?>
<UserIntentions mediaName="CODE\win_b64\X3D_PASS.media" mediaVersion="426">
  <SetVariable name="Java@jdk" value="C:\jdk-17.0.10+7"/>
  <SetVariable name="installEmbeddedServerJRE" value="false"/>
  <SetVariable name="install_Embedded_TomEE" value="false"/>
  <SetVariable name="TomEEPath" value="C:\tomee\3dpassport"/>
  <SetVariable name="PASS_ORACLE_OraclePassTnsNames" value=""/>
  <SetVariable name="PASS_ORACLE_SQLURL_HOST_AND_PORT" value="//dsplm24x.jxjty.com:1521/enoviav6"/>
  <SetVariable name="PASS_ORACLE_SQLURLCas_HOST_AND_PORT" value="//dsplm24x.jxjty.com:1521/enoviav6"/>
  <SetVariable name="PASS_ORACLE_SQLUserAdmin" value="x3dpassadmin"/>
  <SetVariable name="PASS_ORACLE_SQLPasswordAdmin" value="x3dpassadmin"/>
  <SetVariable name="PASS_ORACLE_SQLUserCas" value="x3dpasstokens"/>
  <SetVariable name="PASS_ORACLE_SQLPasswordCas" value="x3dpasstokens"/>
  <SetVariable name="PASS_ORACLE_DatabaseConnectionCheck" value="true"/>
  <SetVariable name="X3DCSMA_3DPassportURL" value="https://dsplm24x.jxjty.com:443/3dpassport"/>
  <SetVariable name="X3DCSMA_3DCompassURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_SMTP_HOST" value="localhost"/>
  <SetVariable name="X3DCSMA_SMTP_MAIL_SENDER" value="admin_platform@service.mydomain"/>
  <SetVariable name="ForceLowerCase" value="false"/>
  <SetVariable item="oracle" name="DatabaseType" value="true"/>
  <SetVariable name="AdminPlatformEmail" value="admin_platform@jxjty.com"/>
  <SetVariable name="AdminPlatformPassword" value="Qwer1234"/>
  <SetVariable name="DSYWelcomePanel"/>
  <SetVariable name="TARGET_PATH" value="D:\DassaultSystemes\R2024x\3DPassport"/>
  <SetVariable name="FinishPanel"/>
</UserIntentions>
```
### 3dpassport_fd01

```xml
<?xml version="1.0" encoding="UTF-8"?>
<UserIntentions mediaName="CODE\win_b64\X3D_PASS.media" mediaVersion="426.1">
  <SetVariable name="Java@jdk" value="C:\jdk-17.0.10+7"/>
  <SetVariable name="installEmbeddedServerJRE" value="false"/>
  <SetVariable name="TomEEPath" value="C:\tomee\3dpassport"/>
  <SetVariable name="PASS_ORACLE_OraclePassTnsNames" value=""/>
  <SetVariable name="PASS_ORACLE_SQLURL_HOST_AND_PORT" value="//dsplm24x.jxjty.com:1521/enoviav6"/>
  <SetVariable name="PASS_ORACLE_SQLURLCas_HOST_AND_PORT" value="//dsplm24x.jxjty.com:1521/enoviav6"/>
  <SetVariable name="PASS_ORACLE_SQLUserAdmin" value="x3dpassadmin"/>
  <SetVariableProtected name="PASS_ORACLE_SQLPasswordAdmin" value="x3dpassadmin"/>
  <SetVariable name="PASS_ORACLE_SQLUserCas" value="x3dpasstokens"/>
  <SetVariableProtected name="PASS_ORACLE_SQLPasswordCas" value="x3dpasstokens"/>
  <SetVariable name="PASS_ORACLE_DatabaseConnectionCheck" value="true"/>
  <SetVariable name="X3DCSMA_3DPassportURL" value="https://dsplm24x.jxjty.com:443/3dpassport"/>
  <SetVariable name="X3DCSMA_3DCompassURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_SMTP_HOST" value="localhost"/>
  <SetVariable name="X3DCSMA_SMTP_MAIL_SENDER" value="admin_platform@service.mydomain"/>
  <SetVariable name="ForceLowerCase" value="false"/>
  <SetVariable item="oracle" name="DatabaseType" value="true"/>
  <SetVariable name="AdminPlatformEmail" value="admin_platform@jxjty.com"/>
  <SetVariableProtected name="AdminPlatformPassword" value="Put your password here."/>
  <SetVariable name="DSYWelcomePanel"/>
  <SetVariable name="FinishPanel"/>
</UserIntentions>
```

### 3ddashboard_ga

```xml
<?xml version="1.0" encoding="UTF-8"?>
<UserIntentions mediaName="CODE\win_b64\X3D_DASH.media" mediaVersion="426">
  <SetVariable name="Java@jdk" value="C:\jdk-17.0.10+7"/>
  <SetVariable name="installEmbeddedServerJRE" value="false"/>
  <SetVariable name="uwp_oracle_tnsnames_dir" value=""/>
  <SetVariable name="uwp_oracle_full_service" value="//dsplm24x.jxjty.com:1521/enoviav6"/>
  <SetVariable name="uwp_oracle_database_user" value="x3ddashadmin"/>
  <SetVariable name="uwp_oracle_database_password" value="x3ddashadmin"/>
  <SetVariable name="X3DCSMA_3DPassportURL" value="https://dsplm24x.jxjty.com:443/3dpassport"/>
  <SetVariable name="X3DCSMA_3DDashboardURL" value="https://dsplm24x.jxjty.com:443/3ddashboard"/>
  <SetVariable name="X3DCSMA_3DCompassURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_6WTAGURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_SMTP_HOST" value="localhost"/>
  <SetVariable name="X3DCSMA_SMTP_MAIL_SENDER" value="admin_platform@service.mydomain"/>
  <SetVariable name="install_Embedded_TomEE" value="false"/>
  <SetVariable name="TomEEPath" value="C:\tomee\3ddashboard"/>
  <SetVariable item="oracle" name="dsi_database_type" value="true"/>
  <SetVariable name="dsi_domain_untrusted" value="untrusted.dsplm24x.jxjty.com"/>
  <SetVariable name="dsi_uwaProxy_domainWhiteList" value=".*"/>
  <SetVariable name="dsi_shared_dir" value="D:\DassaultSystemes\3DDashboardData"/>
  <SetVariable name="DSYWelcomePanel"/>
  <SetVariable name="TARGET_PATH" value="D:\DassaultSystemes\R2024x\3DDashboard"/>
  <SetVariable name="FinishPanel"/>
</UserIntentions>
```
### 3ddashboard_fd01

```xml
<?xml version="1.0" encoding="UTF-8"?>
<UserIntentions mediaName="CODE\win_b64\X3D_DASH.media" mediaVersion="426.1">
  <SetVariable name="Java@jdk" value="C:\jdk-17.0.10+7"/>
  <SetVariable name="installEmbeddedServerJRE" value="false"/>
  <SetVariable name="uwp_oracle_tnsnames_dir" value=""/>
  <SetVariable name="uwp_oracle_full_service" value="//dsplm24x.jxjty.com:1521/enoviav6"/>
  <SetVariable name="uwp_oracle_database_user" value="x3ddashadmin"/>
  <SetVariable name="uwp_oracle_database_password" value="x3ddashadmin"/>
  <SetVariable name="X3DCSMA_3DPassportURL" value="https://dsplm24x.jxjty.com:443/3dpassport"/>
  <SetVariable name="X3DCSMA_3DDashboardURL" value="https://dsplm24x.jxjty.com:443/3ddashboard"/>
  <SetVariable name="X3DCSMA_3DCompassURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_6WTAGURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_SMTP_HOST" value="localhost"/>
  <SetVariable name="X3DCSMA_SMTP_MAIL_SENDER" value="admin_platform@service.mydomain"/>
  <SetVariable name="TomEEPath" value="C:\tomee\3ddashboard"/>
  <SetVariable item="oracle" name="dsi_database_type" value="true"/>
  <SetVariable name="dsi_domain_untrusted" value="untrusted.dsplm24x.jxjty.com"/>
  <SetVariable name="dsi_uwaProxy_domainWhiteList" value=".*"/>
  <SetVariable name="dsi_shared_dir" value="D:\DassaultSystemes\3DDashboardData"/>
  <SetVariable name="DSYWelcomePanel"/>
  <SetVariable name="FinishPanel"/>
</UserIntentions>

```
### 3ddashboard_fd02

```xml
<?xml version="1.0" encoding="UTF-8"?>
<UserIntentions mediaName="CODE\win_b64\X3D_DASH.media" mediaVersion="426.2">
  <SetVariable name="Java@jdk" value="C:\jdk-17.0.10+7"/>
  <SetVariable name="installEmbeddedServerJRE" value="false"/>
  <SetVariable name="uwp_oracle_tnsnames_dir" value=""/>
  <SetVariable name="uwp_oracle_full_service" value="//dsplm24x.jxjty.com:1521/enoviav6"/>
  <SetVariable name="uwp_oracle_database_user" value="x3ddashadmin"/>
  <SetVariable name="uwp_oracle_database_password" value="x3ddashadmin"/>
  <SetVariable name="X3DCSMA_3DPassportURL" value="https://dsplm24x.jxjty.com:443/3dpassport"/>
  <SetVariable name="X3DCSMA_3DDashboardURL" value="https://dsplm24x.jxjty.com:443/3ddashboard"/>
  <SetVariable name="X3DCSMA_3DCompassURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_6WTAGURL" value="https://dsplm24x.jxjty.com:443/3dspace"/>
  <SetVariable name="X3DCSMA_SMTP_HOST" value="localhost"/>
  <SetVariable name="X3DCSMA_SMTP_MAIL_SENDER" value="admin_platform@service.mydomain"/>
  <SetVariable name="TomEEPath" value="C:\tomee\3ddashboard"/>
  <SetVariable item="oracle" name="dsi_database_type" value="true"/>
  <SetVariable name="dsi_domain_untrusted" value="untrusted.dsplm24x.jxjty.com"/>
  <SetVariable name="dsi_uwaProxy_domainWhiteList" value=".*"/>
  <SetVariable name="dsi_shared_dir" value="D:\DassaultSystemes\3DDashboardData"/>
  <SetVariable name="DSYWelcomePanel"/>
  <SetVariable name="FinishPanel"/>
</UserIntentions>

```






### 3dspaceindex

```xml
<?xml version="1.0" encoding="UTF-8"?>
<UserIntentions mediaName="CODE\win_b64\ENOVIA_SXI.media" mediaVersion="426">
  <SetVariable name="FullCloud_URL" value="http://dsplm24x.jxjty.com:19000"/>
  <SetVariable name="FullCloud_NumSlices" value="1"/>
  <SetVariable name="FullCloud_NumAnalyzers" value="8"/>
  <SetVariable name="FullCloud_AdminPassword" value="Qwer1234"/>
  <SetVariable item="NonHACloudview" name="Radio_InstallMODE" value="true"/>
  <SetVariable name="PATH_CVDATADIR_CUSTO" value="D:\DassaultSystemes\R2024x\3DSpaceIndex\win_b64\cv\data"/>
  <SetVariable item="Custom" name="Radio_mode" value="true"/>
  <SetVariable name="DSYWelcomePanel"/>
  <SetVariable name="TARGET_PATH" value="D:\DassaultSystemes\R2024x\3DSpaceIndex"/>
  <SetVariable name="FinishPanel"/>
</UserIntentions>
```


