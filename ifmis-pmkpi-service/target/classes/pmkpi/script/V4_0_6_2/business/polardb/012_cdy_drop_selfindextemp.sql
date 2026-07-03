  i number;
begin
  select count(*) into i from user_views t where t.view_name ='V_PERF_T_SELFPERFINDEXTEMP';
  if i=1 then
      execute immediate 'drop view V_PERF_T_SELFPERFINDEXTEMP';
  end if;
  select count(*) into i from user_tables t where t.table_name ='PERF_T_SELFPERFINDEXTEMP';
  if i=1 then
      execute immediate 'drop table PERF_T_SELFPERFINDEXTEMP';
  end if;

  delete from bus_t_dictable t where t.tablecode='PERF_T_SELFPERFINDEXTEMP';
  delete from bus_t_diccolumn t where t.tablecode='PERF_T_SELFPERFINDEXTEMP';
