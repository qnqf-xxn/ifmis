--审核定义表   修改字段类型 
i integer;
begin
  -- Test statements here
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_AUDITDEFINE' and t.column_name='TEMPSQL';
  if i=0 then
     execute immediate 'alter table PERF_T_AUDITDEFINE add TEMPSQL varchar2(4000)';
  end if;
  
  -- 临时字段存储要修改字段的值
  execute immediate 'UPDATE PERF_T_AUDITDEFINE t1 SET t1.TEMPSQL = (select t2.AUDITSQL from PERF_T_AUDITDEFINE t2 where t1.guid = t2.guid)';
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_AUDITDEFINE' and t.column_name='AUDITSQL';
  if i>0 then
     --删除原字段
     execute immediate 'alter table PERF_T_AUDITDEFINE drop column AUDITSQL';
     -- 添加新字段
     execute immediate 'alter table PERF_T_AUDITDEFINE add AUDITSQL varchar2(4000)';
  end if;
  
  -- 临时字段的值给新字段
  execute immediate 'UPDATE PERF_T_AUDITDEFINE t1 SET t1.AUDITSQL = (select t2.TEMPSQL from PERF_T_AUDITDEFINE t2 where t1.guid = t2.guid)';
  
  -- 删除临时字段
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_AUDITDEFINE' and t.column_name='TEMPSQL';
    if i>0 then
       execute immediate 'alter table PERF_T_AUDITDEFINE drop column TEMPSQL';
  end if;