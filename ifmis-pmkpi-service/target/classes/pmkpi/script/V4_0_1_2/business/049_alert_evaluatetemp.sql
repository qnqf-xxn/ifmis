i integer;
begin
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EVALUATETEMP' and t.column_name='QUERYSQL';
     if i=0 then
       execute immediate 'alter table PERF_T_EVALUATETEMP add QUERYSQL VARCHAR2(4000)';
   end if;
   
   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EVALUATETEMP' and t.column_name='ISEDIT';
     if i=0 then
       execute immediate 'alter table PERF_T_EVALUATETEMP add ISEDIT VARCHAR2(1)';
   end if;
   
   
execute immediate '
create or replace view v_perf_t_evaluatetemp as
select *
from PERF_T_EVALUATETEMP t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

