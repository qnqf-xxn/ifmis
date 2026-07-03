  i number;
begin
--历史数据修复脚本(升级脚本之前做好bgt_perf_indicator表备份)
update bgt_perf_indicator set kpi_evalstd = '1', update_time = to_char(SYSDATE,'yyyyMMddHH24miss') where kpi_evalstd is null;
--修改字段为必填
select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='KPI_EVALSTD' and t.nullable = 'Y';
if i = 1 then
  execute immediate 'ALTER TABLE BGT_PERF_INDICATOR MODIFY KPI_EVALSTD NOT NULL';
end if;