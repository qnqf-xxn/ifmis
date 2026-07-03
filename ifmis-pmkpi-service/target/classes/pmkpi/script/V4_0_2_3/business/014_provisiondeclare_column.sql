i number;
begin
  --PERF_T_PROVISIONDECLARE名称字段长度扩展到200
  select count(*) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_PROVISIONDECLARE' and t.COLUMN_NAME='PRO_NAME';
  if i>0 then
    execute immediate 'alter table PERF_T_PROVISIONDECLARE modify PRO_NAME VARCHAR2(200) ';
  end if;
