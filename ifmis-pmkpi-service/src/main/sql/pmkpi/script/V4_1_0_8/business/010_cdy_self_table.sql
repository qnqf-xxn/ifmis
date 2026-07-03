
  i number(1);
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='PROVINCETASK';
  if i = 0 then
    execute immediate 'alter table perf_t_selfevaltask add provincetask varchar2(1) default 2';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name = 'PERF_T_SELFEVALTASK' and t.column_name= 'ARRANGERCREATER'; 
  if i = 0 then
    execute immediate 'alter table perf_t_selfevaltask add arrangercreater varchar2(40)';
  end if;
  
execute immediate '
create or replace view v_perf_t_selfevaltask as
select *
  from PERF_T_SELFEVALTASK t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2';

execute immediate '
create or replace view perf_v_selfevaltask as
select
    t.*
    ,''2'' as rectifytype,
    case
     when to_date(t.evalend, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(t.evalend, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end warndays, --½ØÖ¹ÌìÊý
    nvl(s.score,0) score,
    s.selfresult,
    s.warn
from
    v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid';
