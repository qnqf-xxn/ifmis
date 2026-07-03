 i number;
begin
  
--部门表添加金额字段
 select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='TASKTOALAMT';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add tasktoalamt NUMBER(20,5)';
  end if;
  
  --重构视图
  execute immediate'create or replace view v_perf_t_deptperfdeclare as
    select *
        from PERF_T_DEPTPERFDECLARE t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
          and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
