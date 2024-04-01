CREATE USER x3ddashadmin IDENTIFIED BY x3ddashadmin;
GRANT CREATE SESSION TO x3ddashadmin;
GRANT RESOURCE TO x3ddashadmin;
CREATE SMALLFILE TABLESPACE x3ddashadmin LOGGING DATAFILE 'x3ddashadmin.dbf' SIZE 10M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED EXTENT MANAGEMENT LOCAL SEGMENT SPACE MANAGEMENT AUTO;
ALTER USER x3ddashadmin default tablespace x3ddashadmin;
ALTER USER x3ddashadmin QUOTA UNLIMITED ON x3ddashadmin;
GRANT UNLIMITED TABLESPACE TO x3ddashadmin;