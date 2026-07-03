--目标修订指标表 name字段修改长度
  i number;
begin
  
   select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'PERF_PROVISION_INDICATOR' and t.COLUMN_NAME = 'TEMPSQL';
  if i = 0 then
     execute immediate 'alter table PERF_PROVISION_INDICATOR add TEMPSQL VARCHAR2(1000)';
  end if;
  
   --临时字段存储要修改字段的值
  execute immediate 'UPDATE PERF_PROVISION_INDICATOR t1 SET t1.TEMPSQL = (select t2.NAME from PERF_PROVISION_INDICATOR t2 where t1.guid = t2.guid and t1.province = t2.province)';
  
   select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROVISION_INDICATOR' and t.column_name='NAME';
  if i>0 then
     --删除原字段
     execute immediate 'alter table PERF_PROVISION_INDICATOR drop column NAME';
     -- 添加新字段
     execute immediate 'alter table PERF_PROVISION_INDICATOR add NAME VARCHAR2(1000)';
  end if;
  
  -- 临时字段的值给新字段
  execute immediate 'UPDATE PERF_PROVISION_INDICATOR t1 SET t1.NAME = (select t2.TEMPSQL from PERF_PROVISION_INDICATOR t2 where t1.guid = t2.guid and t1.province = t2.province)';
  
  
  -- 删除临时字段
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROVISION_INDICATOR' and t.column_name='TEMPSQL';
    if i>0 then
       execute immediate 'alter table PERF_PROVISION_INDICATOR drop column TEMPSQL';
  end if;

  
