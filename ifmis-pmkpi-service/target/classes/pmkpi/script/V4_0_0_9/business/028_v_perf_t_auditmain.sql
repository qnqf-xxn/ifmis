begin 
  
execute immediate 'create or replace view v_perf_t_auditmain as
select * from PERF_T_AUDITMAIN where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
