--增加字段 整改反馈-预算调整建议
  i number;
begin
  select count(*) into i from user_tab_cols  t where t.TABLE_NAME='PERF_T_RECTIFY' and t.COLUMN_NAME='ADJUSTADVICE';
  if i=0 then
     execute immediate 'alter table PERF_T_RECTIFY add ADJUSTADVICE varchar2(40)';
  end if;

execute immediate '
create or replace view v_perf_t_rectify as
select *
from PERF_T_RECTIFY
where year = global_multyear_cz.v_pmyear and
     province = global_multyear_cz.v_pmdivid';
