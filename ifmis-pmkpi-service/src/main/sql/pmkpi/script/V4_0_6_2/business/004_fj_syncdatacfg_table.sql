--增加字段 同步数据配置表-配置项
  i number;
begin
  select count(*) into i from user_tab_cols  t where t.TABLE_NAME='PERF_T_SYNCTASKCFG' and t.COLUMN_NAME='CONFIG';
  if i=0 then
     execute immediate 'alter table PERF_T_SYNCTASKCFG add CONFIG varchar2(4000)';
  end if;

