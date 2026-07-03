  i number;
begin

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTGOAL' and t.column_name='ADJREASON';
if i=0 then
   execute immediate 'ALTER TABLE PERF_T_ADJUSTGOAL ADD ADJREASON VARCHAR2(40)';
end if;

execute immediate 'create or replace view V_PERF_T_ADJUSTGOAL as
select * from PERF_T_ADJUSTGOAL t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
  and t.is_deleted=2 and t.sub_mof_div_code is null';
