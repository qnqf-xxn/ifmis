  i number;
begin
--绩效监控-目标调整表-增加调整说明字段
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='ADJUSTREMARK';
    if i=0 then
    execute immediate 'alter table PERF_T_ADJUSTGOAL add(ADJUSTREMARK VARCHAR2(4000))';
end if;

execute immediate 'create or replace view v_perf_t_adjustgoal as
select *
from perf_t_adjustgoal t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
