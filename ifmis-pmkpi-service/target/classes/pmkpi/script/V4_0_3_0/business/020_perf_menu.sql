--绩效枚举表排序字段改为number类型
  i number;
begin
  
   select count(*) into i from user_tab_cols t where t.TABLE_NAME = 'PERF_ENUM' and t.COLUMN_NAME = 'TEMPSQL';
  if i = 0 then
     execute immediate 'alter table PERF_ENUM add TEMPSQL NUMBER(9)';
  end if;
  
   --临时字段存储要修改字段的值
  execute immediate 'UPDATE PERF_ENUM t1 SET t1.TEMPSQL = (select t2.ordernum from PERF_ENUM t2 where t1.guid = t2.guid and t1.province = t2.province)';
  
   select count(*) into i from user_tab_columns t where t.table_name ='PERF_ENUM' and t.column_name='ORDERNUM';
  if i>0 then
     --删除原字段
     execute immediate 'alter table PERF_ENUM drop column ORDERNUM';
     -- 添加新字段
     execute immediate 'alter table PERF_ENUM add ORDERNUM NUMBER(9)';
  end if;
  
  -- 临时字段的值给新字段
  execute immediate 'UPDATE PERF_ENUM t1 SET t1.ORDERNUM = (select t2.TEMPSQL from PERF_ENUM t2 where t1.guid = t2.guid and t1.province = t2.province)';
  
  
  -- 删除临时字段
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_ENUM' and t.column_name='TEMPSQL';
    if i>0 then
       execute immediate 'alter table PERF_ENUM drop column TEMPSQL';
  end if;
