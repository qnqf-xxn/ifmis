i number;
begin

--AI辅助审核任务 新增API_CODE
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_AISUPPORTAUDITTASK' and t.column_name='API_CODE';
if i=0 then
   execute immediate 'alter table PERF_T_AISUPPORTAUDITTASK add API_CODE VARCHAR2(40)';
end if;

