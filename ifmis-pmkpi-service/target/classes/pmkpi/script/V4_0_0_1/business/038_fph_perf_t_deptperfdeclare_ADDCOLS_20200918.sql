
 
  i integer;
begin
  --PERF_T_DEPTPERFDECLARE  下属单位个数   SUBAGENCYNUM
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='SUBAGENCYNUM';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(SUBAGENCYNUM varchar2(40))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  年末在职人数   THEJOBNUM
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='THEJOBNUM';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(THEJOBNUM varchar2(40))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  年末编制人数   STAFFNUM
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='STAFFNUM';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(STAFFNUM varchar2(40))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  内设机构数     INSTITUTIONSNUM
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='INSTITUTIONSNUM';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(INSTITUTIONSNUM varchar2(40))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  职能  FUNCTION
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='FUNCTION';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(FUNCTION varchar2(4000))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  年度绩效目标   PERFGOAL
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='PERFGOAL';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(PERFGOAL varchar2(4000))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  部门整体预算总额   BUDGETTOTAL
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='BUDGETTOTAL';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(BUDGETTOTAL NUMBER(20,5))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  财政资金   FINANCIALFUND
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='FINANCIALFUND';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(FINANCIALFUND NUMBER(20,5))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  其他资金   OTHERFUND
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='OTHERFUND';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(OTHERFUND NUMBER(20,5))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  基本支出   BASICEXPEND
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='BASICEXPEND';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(BASICEXPEND NUMBER(20,5))';
  end if;
  
  --PERF_T_DEPTPERFDECLARE  三公经费   THREEPUBLICFUND
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='THREEPUBLICFUND';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(THREEPUBLICFUND NUMBER(20,5))';
  end if;
  
  ----PERF_T_DEPTPERFDECLARE  专项资金   SPECIALFUND
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_DEPTPERFDECLARE' and t.column_name='SPECIALFUND';
  if i=0 then
     execute immediate 'alter table PERF_T_DEPTPERFDECLARE add(SPECIALFUND NUMBER(20,5))';
  end if;

execute immediate '
create or replace view v_PERF_T_DEPTPERFDECLARE as
select * from PERF_T_DEPTPERFDECLARE where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
