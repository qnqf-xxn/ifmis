--双流程主表添加项目库参数
i number;
begin
  --MANAGE_DEPT_CODE 资金主管部门
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_REVIEW' and t.column_name='MANAGE_DEPT_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_REVIEW add manage_dept_code varchar2(40)';
    end if;
  --MANAGE_MOF_DEP_CODE 资金主管处室
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_REVIEW' and t.column_name='MANAGE_MOF_DEP_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_REVIEW add manage_mof_dep_code varchar2(40)';
    end if;
  --MOF_DEP_CODE 单位归口处室
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_REVIEW' and t.column_name='MOF_DEP_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_REVIEW add mof_dep_code varchar2(40)';
    end if;
  --DEPT_CODE  单位主管部门
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_REVIEW' and t.column_name='DEPT_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_REVIEW add dept_code varchar2(40)';
    end if;
  --AGENCY_CODE  单位
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_REVIEW' and t.column_name='AGENCY_CODE';
    if i=0 then
       execute immediate 'alter table PERF_T_REVIEW add agency_code varchar2(40)';
    end if;

--重构视图
execute immediate 'create or replace view v_perf_t_review as
select *
 from PERF_T_REVIEW t 
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and 
  PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
