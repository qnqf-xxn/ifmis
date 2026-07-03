 i number;
begin
--perf_t_evaluresult（结果应用情况表）
select count(1) into i from user_tables t where t.table_name = 'PERF_T_EVALURESULT';
if i=0 then
    execute immediate 'create table PERF_T_EVALURESULT
    (
      guid               varchar2(40) not null,
      mainguid           varchar2(40),
      otherremark        varchar2(500),
      isbackdepart       varchar2(40),
      isbudgeapply       varchar2(40),
      isgovernmentinstru varchar2(40),
      isnpcinstru        varchar2(40),
      ispoliadjust       varchar2(40),
      isreportgovernment varchar2(40),
      isreportnpc        varchar2(40),
      is_deleted         number(1) not null,
      creater            varchar2(40),
      createtime         varchar2(17),
      updatetime         varchar2(17),
      year               varchar2(4) not null,
      province           varchar2(32) not null
    )
    ';
    execute immediate 'alter table PERF_T_EVALURESULT add constraint PK_PERF_T_EVALURESULT primary key (GUID, YEAR, PROVINCE)';
end if;

execute immediate '
create or replace view v_perf_t_evaluresult as
select
    *
from
    perf_t_evaluresult
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';


