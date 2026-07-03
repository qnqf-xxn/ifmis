 i number;
begin
  --部门评价主表 添加 pro_code字段
  select count(*) INTO i from user_tab_columns where table_name ='PERF_T_DEPTEVALUATION' and column_name = 'PRO_CODE';
  if i = 0 then
     execute immediate 'alter table PERF_T_DEPTEVALUATION add PRO_CODE VARCHAR2(40)';
  end if;
   
  --重构视图
  execute immediate'
  create or replace view v_perf_t_deptevaluation as
select *
from PERF_T_DEPTEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';