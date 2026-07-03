-- 重构试图
begin

execute immediate '
create or replace view v_perf_t_auditdefine as
select * from perf_t_auditdefine where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
