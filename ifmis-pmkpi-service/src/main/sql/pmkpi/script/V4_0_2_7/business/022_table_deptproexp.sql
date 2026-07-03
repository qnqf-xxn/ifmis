i number;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTPROEXP';
    if i=0 then
       execute immediate '
  create table PERF_T_DEPTPROEXP
  (
    guid       VARCHAR2(40) not null,
    pro_name   VARCHAR2(200),
    protype    VARCHAR2(200),
    totalamt   NUMBER(20,2),
    yearamt    NUMBER(20,2),
    expusage   VARCHAR2(2000),
    mainguid   VARCHAR2(40),
    createtime VARCHAR2(17) not null,
    updatetime VARCHAR2(17),
    creater    VARCHAR2(40) not null,
    province   VARCHAR2(40) not null,
    year       NUMBER(4) not null,
    is_deleted NUMBER(1),
    agencyguid VARCHAR2(40),
    ordernum   NUMBER(4)
  )';
  execute immediate 'alter table PERF_T_DEPTPROEXP
  add constraint PK_PERF_DEPTPROEXP primary key (GUID, YEAR, PROVINCE)';
   
  execute immediate '
  create index NQ_DEPTPROEXP_main on PERF_T_DEPTPROEXP (mainguid)';
  execute immediate '
  CREATE OR REPLACE VIEW V_PERF_T_DEPTPROEXP AS
  SELECT * from PERF_T_DEPTPROEXP WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM (''YEAR'')
      AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')
      AND is_deleted = 2';
end if;