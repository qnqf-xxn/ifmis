i number;
begin

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTINDEX' and
t.column_name='ADJUSTWEIGHT';
     if i<1 then
       execute immediate 'alter table PERF_T_ADJUSTINDEX add ADJUSTWEIGHT NUMBER(5)';
      end if;


 execute immediate '
  create or replace view V_PERF_T_ADJUSTINDEX as
  select * from perf_t_adjustindex t
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
