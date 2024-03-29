

# windows server installation

## host

```batch

echo 127.0.0.1 dsplm24x.jxjty.com>> C:\Windows\System32\drivers\etc\hosts
echo 127.0.0.1 untrusted.dsplm24x.jxjty.com>> C:\Windows\System32\drivers\etc\hosts

```
## java

%JAVA_HOME%\bin
%JAVA_HOME%\jre\bin



## apps

- 7zip
- firefox
- oracle
- apache

Qwer1234

## website

```batch
start https://dsplm24x.jxjty.com/3dpassport
start https://dsplm24x.jxjty.com/3ddashboard
start http://dsplm24x.jxjty.com:19001
start https://dsplm24x.jxjty.com/3dswym
start https://dsplm24x.jxjty.com/3dspace


```

## sql

sqlplus "/as sysdba" 

```sql
SELECT * FROM dba_profiles s WHERE s.profile='DEFAULT'AND resource_name='PASSWORD_LIFE_TIME';

alter profile default limit password_life_time unlimited;

```

## ssl

dsplm24x_jxjty_com.ext

```conf

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = dsplm24x.jxjty.com
DNS.2 = dsplm24x.jxjty.com

```

```sql

set PATH=C:\Apache24\bin;%JAVA_HOME%\bin;%PATH%

openssl genrsa -des3 -out RootCA.key -passout pass:Qwer1234 2048

openssl req -x509 -sha256 -new -nodes -key RootCA.key -days 3650 -out RootCA.crt -
passin pass:Qwer1234 -subj "/C=ZH/ST=BJ/L=BJ/O=DSCN/OU=CS/CN=RootCA"

openssl rsa -in RootCA.key -out dsplm24x_jxjty_com.key -passin pass:Qwer1234

openssl req -new -key dsplm24x_jxjty_com.key -out dsplm24x_jxjty_com.csr -subj"/C=ZH/ST=BJ/L=BJ/O=DSCN/OU=CS/CN=*.jxjty.com"

openssl x509 -sha256 -req -in dsplm24x_jxjty_com.csr -CA RootCA.crt -CAkey RootCA.key -CAcreateserial -out dsplm24x_jxjty_com.crt -days 3650 -passin pass:Qwer1234 -extfile dsplm24x_jxjty_com.ext

openssl x509 -noout -text -in dsplm24x_jxjty_com.crt

keytool -importcert -keystore "%JAVA_HOME%\lib\security\cacerts" -noprompt -storepass changeit -file RootCA.crt -alias RootCA


keytool -list -keystore "%JAVA_HOME%\lib\security\cacerts" -storepass changeit -alias RootCA


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

//dsplm24x.jxjty.com:1521/enoviav6

x3dpasstokens


admin_platform@jxjty.com
Qwer1234

https://dsplm24x.jxjty.com:443/3dpassport

https://dsplm24x.jxjty.com:443/3dspace

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


## UserIntentions

md c:\UserIntentions\3dpassport\
copy D:\DassaultSystemes\R2024x\3DPassport\InstallData\*UserIntentions*.xml c:\UserIntentions\3dpassport\

md c:\UserIntentions\3ddashboard\
copy D:\DassaultSystemes\R2024x\3DDashboard\InstallData\*UserIntentions*.xml c:\UserIntentions\3ddashboard\

md c:\UserIntentions\3dspaceindex\
copy D:\DassaultSystemes\R2024x\3DSpaceIndex\InstallData\*UserIntentions*.xml c:\UserIntentions\3dspaceindex\

