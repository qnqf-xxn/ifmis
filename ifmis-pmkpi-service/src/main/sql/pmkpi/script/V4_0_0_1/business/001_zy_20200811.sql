 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_AGENCY';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_AGENCY
(
  guid VARCHAR2(40) not null
)
on commit delete rows';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTPERFDECLARE';
  if i=0 then
     execute immediate '
create table PERF_T_DEPTPERFDECLARE
(
  guid           VARCHAR2(40) not null,
  name           VARCHAR2(200),
  code           VARCHAR2(200),
  linkman        VARCHAR2(50),
  telephone      VARCHAR2(30),
  gist           VARCHAR2(500),
  funcdesc       VARCHAR2(3000),
  agencyguid     VARCHAR2(40),
  wfstatus       VARCHAR2(40),
  status         NUMBER(1),
  createtime     VARCHAR2(17) not null,
  updatetime     VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
  creater        VARCHAR2(40) not null,
  province       VARCHAR2(32) not null,
  year           NUMBER(4) not null,
  ordernum       NUMBER(9),
  finintorgguid  VARCHAR2(40),
  wfid           VARCHAR2(40),
  auditor        VARCHAR2(32),
  lastupdatetime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss'')
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_DEPTPERFDECLARE
  add constraint PERF_T_DEPTPERFDECLARE primary key (GUID, YEAR, PROVINCE)
  using index';

  end if;



  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTFUNCTION';
  if i=0 then
     execute immediate '
create table PERF_T_DEPTFUNCTION
(
  guid          VARCHAR2(40) not null,
  code          VARCHAR2(100),
  name          VARCHAR2(200),
  isuse         VARCHAR2(2),
  findex        VARCHAR2(40),
  mainguid      VARCHAR2(40),
  agencyguid    VARCHAR2(40),
  wfstatus      VARCHAR2(40),
  status        NUMBER(1),
  createtime    VARCHAR2(17) not null,
  updatetime    VARCHAR2(17),
  creater       VARCHAR2(40) not null,
  province      VARCHAR2(32) not null,
  year          NUMBER(4) not null,
  ordernum      NUMBER(9),
  finintorgguid VARCHAR2(40),
  wfid          VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';
-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_DEPTFUNCTION
  add constraint PERF_T_DEPTFUNCTION primary key (GUID, YEAR, PROVINCE)
  using index';
  end if;


   select count(*) into i from user_sequences where sequence_name ='S_PERF_DEPTFUNCTION';
   if i = 0 then
      execute immediate 'CREATE SEQUENCE S_PERF_DEPTFUNCTION
              INCREMENT BY 1
              START WITH 1
               MAXVALUE 999999999        
               MINVALUE 1
              NOCYCLE
               CACHE 30
              ORDER';
   end if;



  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTAUDITINDEX';
  if i=0 then
     execute immediate '
create table PERF_T_DEPTAUDITINDEX
(
  guid          VARCHAR2(40) not null,
  code          VARCHAR2(40),
  name          VARCHAR2(500),
  explain       VARCHAR2(200),
  weight        NUMBER(5,2),
  indexval      VARCHAR2(32),
  rule          VARCHAR2(200),
  agencyguid    VARCHAR2(40),
  wfstatus      VARCHAR2(40),
  status        NUMBER(1),
  createtime    VARCHAR2(17) not null,
  updatetime    VARCHAR2(17),
  creater       VARCHAR2(40) not null,
  province      VARCHAR2(32) not null,
  year          NUMBER(4) not null,
  ordernum      NUMBER(9),
  finintorgguid VARCHAR2(40),
  wfid          VARCHAR2(40),
  mainguid      VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_DEPTAUDITINDEX
  add constraint PERF_T_DEPTAUDITINDEX primary key (GUID, YEAR, PROVINCE)
  using index';

  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITMAIN';
  if i=0 then
     execute immediate '
create table PERF_T_AUDITMAIN
(
  guid          VARCHAR2(42) not null,
  agencyguid    VARCHAR2(42),
  mainguid      VARCHAR2(42),
  type          VARCHAR2(40),
  conclusion    VARCHAR2(40),
  remark        VARCHAR2(500),
  createtime    VARCHAR2(17),
  updatetime    VARCHAR2(17),
  status        NUMBER(1),
  year          NUMBER(4) not null,
  province      VARCHAR2(40),
  projectstatus VARCHAR2(32),
  userguid      VARCHAR2(40),
  nodeguid      VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_AUDITMAIN
  add constraint PERF_T_AUDITMAIN primary key (GUID, YEAR, PROVINCE)
  using index ';

  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITITEMS';
  if i=0 then
     execute immediate '
create table PERF_T_AUDITITEMS
(
  GUID       VARCHAR2(40) not null,
  AGENCYGUID VARCHAR2(40),
  ANSWER     VARCHAR2(500),
  CREATETIME VARCHAR2(17),
  PROVINCE   VARCHAR2(40) not null,
  SCORE      NUMBER(16,2),
  STATUS     NUMBER(1),
  TYPE       VARCHAR2(40),
  UPDATETIME VARCHAR2(17),
  WEIGHT     NUMBER(5,2),
  YEAR       NUMBER(4) not null,
  QUESTTYPE  VARCHAR2(40),
  CONTENT    VARCHAR2(500),
  DETAIL     VARCHAR2(32),
  MAINGUID   VARCHAR2(40),
  PROPOSAL   VARCHAR2(500),
  TEMPGUID   VARCHAR2(40),
  AUDITGUID  VARCHAR2(40)
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_AUDITITEMS
  add constraint PERF_T_AUDITITEMS primary key (GUID, YEAR, PROVINCE)
  using index ';

  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_NATRUEAUDITTEMP';
  if i=0 then
     execute immediate '
create table PERF_T_NATRUEAUDITTEMP
(
  GUID       VARCHAR2(40) not null,
  NAME       VARCHAR2(100),
  CONTEXT    VARCHAR2(1000),
  ORDERNUM   NUMBER(9),
  AGENCYGUID VARCHAR2(40),
  STATUS     NUMBER(1),
  CREATETIME VARCHAR2(17) not null,
  UPDATETIME VARCHAR2(17),
  CREATER    VARCHAR2(40) not null,
  PROVINCE   VARCHAR2(40) not null,
  YEAR       NUMBER(4) not null
)

partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_NATRUEAUDITTEMP
  add constraint PK_PERF_NATRUEAUDITTEMP primary key (GUID, YEAR, PROVINCE)
  using index ';

  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITTYPECFG';
  if i=0 then
     execute immediate '
create table PERF_T_AUDITTYPECFG
(
  GUID       VARCHAR2(40) not null,
  WFID       VARCHAR2(40) not null,
  NODEGUID   VARCHAR2(40) not null,
  AUDITTYPE  VARCHAR2(40) not null,
  AGENCYGUID VARCHAR2(40),
  YEAR       NUMBER(4),
  PROVINCE   VARCHAR2(40),
  CREATER    VARCHAR2(40),
  CREATETIME VARCHAR2(17),
  UPDATETIME VARCHAR2(17)
)

partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_AUDITTYPECFG
  add constraint P_PERF_T_AUDITTYPECFG primary key (GUID)
  using index ';

  
execute immediate 'create index INDEX_PERF_T_AUDITTYPECFG on PERF_T_AUDITTYPECFG (WFID)';
  end if;  


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITMAIN';
  if i=0 then
     execute immediate '
create table PERF_T_AUDITMAIN
(
  GUID          VARCHAR2(42) not null,
  AGENCYGUID    VARCHAR2(42),
  MAINGUID      VARCHAR2(42),
  TYPE          VARCHAR2(40),
  CONCLUSION    VARCHAR2(40),
  REMARK        VARCHAR2(500),
  CREATETIME    VARCHAR2(17),
  UPDATETIME    VARCHAR2(17),
  STATUS        NUMBER(1),
  YEAR          NUMBER(4) not null,
  PROVINCE      VARCHAR2(40),
  PROJECTSTATUS VARCHAR2(32),
  USERGUID      VARCHAR2(40),
  NODEGUID      VARCHAR2(40)
)

partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_AUDITMAIN
  add constraint PERF_T_AUDITMAIN primary key (GUID)
  using index';

  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_AUDITITEMS';
  if i=0 then
     execute immediate '
create table PERF_T_AUDITITEMS
(
  GUID       VARCHAR2(40) not null,
  AGENCYGUID VARCHAR2(40),
  ANSWER     VARCHAR2(500),
  CREATETIME VARCHAR2(17),
  PROVINCE   VARCHAR2(40) not null,
  SCORE      NUMBER(16,2),
  STATUS     NUMBER(1),
  TYPE       VARCHAR2(40),
  UPDATETIME VARCHAR2(17),
  WEIGHT     NUMBER(5,2),
  YEAR       NUMBER(4) not null,
  QUESTTYPE  VARCHAR2(40),
  CONTENT    VARCHAR2(500),
  DETAIL     VARCHAR2(32),
  MAINGUID   VARCHAR2(40),
  PROPOSAL   VARCHAR2(500),
  TEMPGUID   VARCHAR2(40),
  AUDITGUID  VARCHAR2(40)
)

partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_AUDITITEMS
  add constraint PERF_T_AUDITITEMS primary key (GUID, YEAR, PROVINCE)
  using index ';

  end if;

  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_GUIDS';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_GUIDS
(
  GUID VARCHAR2(40)
)
on commit delete rows';
  end if;


  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_TMP_AUDITDEFINE';
  if i=0 then
     execute immediate '
create global temporary table PERF_TMP_AUDITDEFINE
(
  GUID VARCHAR2(40)
)
on commit delete rows';
  end if;



select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_BUSAUDITDEFINE';
  if i=0 then
     execute immediate '
create table PERF_T_BUSAUDITDEFINE
(
  GUID        VARCHAR2(40) not null,
  BUSGUID     VARCHAR2(40) not null,
  ORDERNUM    NUMBER(9) not null,
  AUDITDEFINE VARCHAR2(40) not null,
  ERRTYPE     VARCHAR2(40) not null
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate 'alter table PERF_T_BUSAUDITDEFINE
  add constraint P_PERF_BUSAUDITDEFINE primary key (GUID)
  using index ';

  end if;  