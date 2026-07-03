 i number;
begin

--指标分级
select count(1) into i from user_tab_cols where table_name = 'BGT_PERF_INDICATOR' and  column_name = 'INDEXCATLEV';
if i=0 then
  execute immediate 'alter table BGT_PERF_INDICATOR add INDEXCATLEV varchar2(40)';
end if;
--一级指标名称
select count(1) into i from user_tab_cols where table_name = 'BGT_PERF_INDICATOR' and  column_name = 'LV1_PERF_IND_NAME';
if i=0 then
  execute immediate 'alter table BGT_PERF_INDICATOR add LV1_PERF_IND_NAME varchar2(200)';
end if;
--二级指标名称
select count(1) into i from user_tab_cols where table_name = 'BGT_PERF_INDICATOR' and  column_name = 'LV2_PERF_IND_NAME';
if i=0 then
  execute immediate 'alter table BGT_PERF_INDICATOR add LV2_PERF_IND_NAME varchar2(200)';
end if;

--重构视图
execute immediate '
create or replace view v_bgt_perf_indicator as
select * from bgt_perf_indicator
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';
