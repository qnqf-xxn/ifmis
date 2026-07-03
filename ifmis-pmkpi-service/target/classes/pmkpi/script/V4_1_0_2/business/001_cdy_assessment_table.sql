
  i number;
begin

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ASSESSMENTTEMP' and t.column_name='BUSTYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENTTEMP add bustype varchar2(40)';
  end if;

  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_ASSESSMENT' and t.column_name='BUSTYPE';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENT add bustype varchar2(40)';
  end if;

execute immediate '
create or replace view v_perf_t_assessmenttemp as
select t.*
  from perf_t_assessmenttemp t
 where province = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';

execute immediate '
create or replace view v_perf_t_assessment as
select t.*
  from perf_t_assessment t
 where t.is_deleted = 2
   and province = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
