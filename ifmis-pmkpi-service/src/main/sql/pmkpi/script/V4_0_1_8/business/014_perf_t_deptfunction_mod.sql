-- 部门绩效申报-部门职能字数改为150（需要在测试窗口执行）
  i number;
begin
  -- Test statements here
  select count(1) into i from user_tab_cols t where t.table_name='P#PERF_T_DEPTFUNCTION' and t.column_name='NAME';
  if i=1 then
      execute immediate 'alter table P#PERF_T_DEPTFUNCTION modify  NAME VARCHAR2(300)';
  end if;
