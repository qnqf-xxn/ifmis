i number;
begin
  -- 临时表添加code字段，存项目编码
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TMP_GUIDS' and t.column_name='CODE';
    if i=0 then
      execute immediate 'alter table PERF_TMP_GUIDS add CODE VARCHAR2(40)';
  end if;
