
num number;
begin
SELECT COUNT(1) INTO num from user_tab_cols t where table_name = upper('PERF_T_CUSTOMAUDITVIEW') and column_name = upper('CHECKSQL');
   if num = 0 then 
     execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW add checksql varchar2(4000)';
   end if;

execute immediate ' 
create or replace view v_perf_t_customauditview as
select *
from perf_t_customauditview where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';


execute immediate ' 
create or replace view v_perf_t_auditdefine as
select *
from perf_t_auditdefine where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
