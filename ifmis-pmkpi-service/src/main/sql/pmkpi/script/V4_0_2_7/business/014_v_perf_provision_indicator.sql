begin

execute immediate '
create or replace view v_perf_provision_indicator as
select *
 from PERF_PROVISION_INDICATOR WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted=2';
