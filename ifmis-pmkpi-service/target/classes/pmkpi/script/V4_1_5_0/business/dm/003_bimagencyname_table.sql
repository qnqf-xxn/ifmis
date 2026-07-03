
 i number;
begin
  
  select count(*) into i from user_tables t where t.table_name ='PERF_T_BIMMODNAMECONFIG';
  if i=0 then
    execute immediate '
    create table PERF_T_BIMMODNAMECONFIG
    (
      guid      VARCHAR2(32) not null,
      isagency  VARCHAR2(1),
      colcode   VARCHAR2(100),
      upcolcode VARCHAR2(100),
      tablecode VARCHAR2(32),
      status    NUMBER(1) default 1,
      filtersql VARCHAR2(255),
      remark    VARCHAR2(255),
      isstand   VARCHAR2(1)
    )';
    execute immediate 'alter table PERF_T_BIMMODNAMECONFIG add primary key (GUID)';
  end if;

  select count(*) into i from user_tables t where t.table_name ='PERF_T_BIMMODNAMELOG';
  if i=0 then
    execute immediate '
    create table PERF_T_BIMMODNAMELOG
    (
      guid        VARCHAR2(32) not null,
      msgid       VARCHAR2(32),
      status      NUMBER(1),
      create_time VARCHAR2(17),
      remark      VARCHAR2(255),
      year        VARCHAR2(4),
      province    VARCHAR2(9),
      msgdata     VARCHAR2(2000)
    )';
    execute immediate 'create index INX_PERF_BIMMODNAMELOG on PERF_T_BIMMODNAMELOG (YEAR, PROVINCE, STATUS)';
    execute immediate 'alter table PERF_T_BIMMODNAMELOG add primary key (GUID)';
  end if;