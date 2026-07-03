
 i number(9);
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_BUSWFPARALLEL';
  if i=0 then
     execute immediate '
      create table PERF_T_BUSWFPARALLEL
      (
        guid                  varchar2(40) not null,
        proguid               varchar2(40) not null,
        mainguid              varchar2(40) not null,
        modeltype             varchar2(40),
        bustype               varchar2(40),
        agencyguid            varchar2(40),
        finintorgguid         varchar2(40),
        manage_dept_code      varchar2(40), 
        manage_mof_dep_code   varchar2(40),
        mof_dep_code          varchar2(40),
        dept_code             varchar2(40),
        agency_code           varchar2(40),
        creater               varchar2(32),
        createtime            varchar2(20),
        updatetime            varchar2(20),
        wfstatus              varchar2(50),
        wfid                  varchar2(100),
        status                number(1),
        province              varchar2(9) not null,
        year                  char(4) not null,
        lastupdatetime        varchar2(20),
        auditor               varchar2(40),
        is_deleted            number(1) default 2
      )';
execute immediate '
alter table PERF_T_BUSWFPARALLEL
  add constraint PK_PERF_BUSWFPARALLEL primary key (GUID, YEAR, PROVINCE)';

end if;

execute immediate '
create or replace view v_perf_t_buswfparallel as
select * from PERF_T_BUSWFPARALLEL
 where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
   and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')  and is_deleted =2';
