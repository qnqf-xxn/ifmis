i number;

begin

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_PROINDEXTRACETEMP';
if i=1 then
    execute immediate 'drop table PERF_T_PROINDEXTRACETEMP';
	execute immediate 'drop view V_PERF_T_PROINDEXTRACETEMP';
end if;

select count(*) into i from user_tables where TABLE_NAME = 'PERF_MIDSAVE';
if i=0 then
    execute immediate '
    create table PERF_MIDSAVE
	(
	  guid           VARCHAR2(32) not null,
	  url            VARCHAR2(200),
	  mainguid       VARCHAR2(32),
	  userid         VARCHAR2(32),
	  menueguid      VARCHAR2(32),
	  data           CLOB,
	  createtime     VARCHAR2(20),
	  lastupdatetime VARCHAR2(20),
	  status         VARCHAR2(2),
	  province       VARCHAR2(9) not null,
	  year           CHAR(4) not null,
	  componentid    VARCHAR2(50),
	  compconfigid   VARCHAR2(50)
	)
    ';
    execute immediate 'alter table PERF_MIDSAVE add constraint PK_PERF_MIDSAVE primary key (GUID,YEAR,PROVINCE)';
end if;

select count(1) into i from user_indexes t where t.index_name='IDX_PERF_MIDSAVE_COMPCONFIGID' and t.table_name='PERF_MIDSAVE';
if i = 0 then
	execute immediate 'create index IDX_PERF_MIDSAVE_COMPCONFIGID on PERF_MIDSAVE(COMPCONFIGID)';
end  if;

select count(1) into i from user_indexes t where t.index_name='IDX_PERF_MIDSAVE_MAINGUID' and t.table_name='PERF_MIDSAVE';
if i = 0 then
	execute immediate 'create index IDX_PERF_MIDSAVE_MAINGUID on PERF_MIDSAVE(MAINGUID)';
end  if;

select count(1) into i from user_indexes t where t.index_name='IDX_PERF_MIDSAVE_URL' and t.table_name='PERF_MIDSAVE';
if i = 0 then
	execute immediate 'create index IDX_PERF_MIDSAVE_URL on PERF_MIDSAVE(URL)';
end  if;