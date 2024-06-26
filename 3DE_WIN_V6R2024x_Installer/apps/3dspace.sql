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