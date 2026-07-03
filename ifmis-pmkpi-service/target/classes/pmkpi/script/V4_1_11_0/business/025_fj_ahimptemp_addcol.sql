i number;
begin

--add col PERF_T_IMPTEMP.ENDNUM
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_IMPTEMP' and t.column_name='ENDNUM';
if i=0 then
   execute immediate 'alter table PERF_T_IMPTEMP add ENDNUM NUMBER(3)';
end if;

execute immediate 'create or replace view v_perf_t_imptemp as
select * from perf_t_imptemp t
where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

