
i number;
begin
   select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPERFINDEX' and t.COLUMN_NAME='OPINION_REMARK';
  if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add opinion_remark VARCHAR2(4000)';
  end if;
  
   select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPERFINDEX' and t.COLUMN_NAME='AUDIT_SCORE';
  if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add audit_score NUMBER(5,2)';
  end if;

   select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPERFINDEX' and t.COLUMN_NAME='DEDUCT_SCORE';
  if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add deduct_score NUMBER(5,2)';
  end if;
  
  execute immediate ' create or replace view v_perf_t_selfperfindex as
select *
from perf_t_selfperfindex where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
    and is_deleted = 2';
