
  i number;
begin
  select count(*) into i from user_tab_cols  t where t.TABLE_NAME='PERF_T_PROINDEXTRACE' and t.COLUMN_NAME='CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_PROINDEXTRACE add CODE varchar2(40)';
  end if;

execute immediate '
create or replace view v_perf_t_proindextrace as
select *
from PERF_T_PROINDEXTRACE
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
