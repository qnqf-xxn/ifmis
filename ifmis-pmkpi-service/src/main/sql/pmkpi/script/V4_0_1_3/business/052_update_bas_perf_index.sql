  i integer;
begin
  --当BAS_PERF_INDICATOR种存在KPI_VAL字段并且不可为空的时候才去执行置为空的语句
select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='KPI_VAL' and t.NULLABLE = 'N';
    if i=1 then
    execute immediate 'alter table BAS_PERF_INDICATOR modify KPI_VAL VARCHAR2(1000) null';
end if;
