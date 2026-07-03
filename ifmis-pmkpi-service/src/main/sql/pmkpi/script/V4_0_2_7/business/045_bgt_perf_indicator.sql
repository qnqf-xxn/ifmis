
  i number;
begin
select count(1) into i from user_tab_cols t where t.table_name='BGT_PERF_INDICATOR' and t.column_name='KPI_CONTENT' and t.nullable = 'N';
if i= 1 then
     execute immediate 'alter table BGT_PERF_INDICATOR modify kpi_content null';
   end if;
