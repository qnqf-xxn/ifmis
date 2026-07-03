
  i number;
begin
  select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_REVIEW' and t.COLUMN_NAME='ISBACK';
  
  if i=0 then
     execute immediate 'alter table PERF_T_REVIEW add ISBACK VARCHAR2(40)';
  end if;


execute immediate '
create or replace view v_perf_t_review as
select t.*
from PERF_T_REVIEW t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
