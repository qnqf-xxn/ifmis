i number;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_DEPTAMT';
    if i=0 then
       execute immediate '
  create table PERF_T_DEPTAMT
  (
    guid       VARCHAR2(40) not null,
    agencyguid VARCHAR2(40),
    agencyname VARCHAR2(200),
    typename   VARCHAR2(100),
    fundname   VARCHAR2(100),
    yearamt    NUMBER(20,2),
    rate       NUMBER(20,4),
    famt       NUMBER(20,2),
    samt       NUMBER(20,2),
    mainguid   VARCHAR2(40),
    createtime VARCHAR2(17) not null,
    updatetime VARCHAR2(17),
    creater    VARCHAR2(40) not null,
    province   VARCHAR2(40) not null,
    year       NUMBER(4) not null,
    is_deleted NUMBER(1),
    ordernum   NUMBER(3)
  )';
  execute immediate 'alter table PERF_T_DEPTAMT
  add constraint PK_PERF_DEPTAMT primary key (GUID, YEAR, PROVINCE)';
   
  execute immediate '
  create index NQ_PERF_DEPTAMT_MAIN on PERF_T_DEPTAMT (MAINGUID)';
  execute immediate '
  CREATE OR REPLACE VIEW V_PERF_T_DEPTAMT AS
  SELECT * from PERF_T_DEPTAMT WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM (''YEAR'')
      AND province = global_multyear_cz.Secu_f_GLOBAL_PARM (''DIVID'')
      AND is_deleted = 2';
end if;