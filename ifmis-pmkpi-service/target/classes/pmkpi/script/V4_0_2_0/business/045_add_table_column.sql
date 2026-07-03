i number;
begin
--部门评价
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and
t.column_name='MANAGE_DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTEVALUATION add MANAGE_DEPT_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and
t.column_name='MANAGE_MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTEVALUATION add MANAGE_MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and
t.column_name='MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTEVALUATION add MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTEVALUATION' and
t.column_name='DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTEVALUATION add DEPT_CODE varchar2(200)';
      end if;



 execute immediate '
  create or replace view V_PERF_T_DEPTEVALUATION as
  select * from perf_t_deptevaluation t
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';


--年度追加

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFMIDDECLARE' and
t.column_name='MANAGE_DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add MANAGE_DEPT_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFMIDDECLARE' and
t.column_name='MANAGE_MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add MANAGE_MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFMIDDECLARE' and
t.column_name='MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_DEPTPERFMIDDECLARE' and
t.column_name='DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_DEPTPERFMIDDECLARE add DEPT_CODE varchar2(200)';
      end if;


 execute immediate '
  create or replace view V_PERF_T_DEPTPERFMIDDECLARE as
  select * from perf_t_deptperfmiddeclare t
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';



--任务下达

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and
t.column_name='MANAGE_DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_SELFEVALTASK add MANAGE_DEPT_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and
t.column_name='MANAGE_MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_SELFEVALTASK add MANAGE_MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and
t.column_name='MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_SELFEVALTASK add MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and
t.column_name='DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_SELFEVALTASK add DEPT_CODE varchar2(200)';
      end if;



execute immediate '
  create or replace view V_PERF_T_SELFEVALTASK as
  select * from perf_t_selfevaltask t
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';


--财政评审确认

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and
t.column_name='MANAGE_DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_FINEVALUATION add MANAGE_DEPT_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and
t.column_name='MANAGE_MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_FINEVALUATION add MANAGE_MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and
t.column_name='MOF_DEP_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_FINEVALUATION add MOF_DEP_CODE varchar2(200)';
      end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_FINEVALUATION' and
t.column_name='DEPT_CODE';
     if i<1 then
       execute immediate 'alter table PERF_T_FINEVALUATION add DEPT_CODE varchar2(200)';
      end if;

execute immediate '
  create or replace view V_PERF_T_FINEVALUATION as
  select * from perf_t_finevaluation t
  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
