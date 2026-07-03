  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='PROVINCETASK';
  if i = 0 then
    execute immediate 'alter table perf_t_selfevaltask add provincetask varchar2(1) default 2';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name = 'PERF_T_SELFEVALTASK' and t.column_name= 'ARRANGERCREATER'; 
  if i = 0 then
    execute immediate 'alter table perf_t_selfevaltask add arrangercreater varchar2(40)';
  end if;
  
--重构视图
  v_sql :='
create or replace view V_PERF_T_SELFEVALTASK as
select *
  from PERF_T_SELFEVALTASK t
 where t.year = global_multyear_cz.v_pmyear
  and t.province = global_multyear_cz.v_pmdivid and t.is_deleted = 2';
	select fn_alterview('V_PERF_T_SELFEVALTASK',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	  


  v_sql :='
create or replace view PERF_V_SELFEVALTASK as
select
    t.*
    ,''2'' as rectifytype,
    case
     when to_date(t.evalend, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(t.evalend, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end warndays, --截止天数
    nvl(s.score,0) score,
    s.selfresult,
    s.warn
from
    v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid';
	select fn_alterview('PERF_V_SELFEVALTASK',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	  
