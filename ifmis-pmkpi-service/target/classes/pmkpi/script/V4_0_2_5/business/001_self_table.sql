
 i number;
begin
  -- PERF_T_SELFPERFINDEX 扩展字段长度
  --NAME  长度 200 改为 1000
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFPERFINDEX' and t.column_name='NAME';
     if i=1 then
       execute immediate 'alter table PERF_T_SELFPERFINDEX modify NAME VARCHAR2(1000)';
     end if;


update bus_t_diccolumn t set t.datalength='1000' where t.tablecode='PERF_T_SELFPERFINDEX' and t.columncode='NAME';


update bus_t_diccolumn t set t.datalength='1000' where t.tablecode='PERF_T_PROINDEXTRACE' and t.columncode='NAME';

