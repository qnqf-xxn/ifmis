-- ÉóºË¶¨ÒåÊÓÍ¼±í  ÐÞ¸Ä×Ö¶ÎÀàÐÍ
 i integer;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_CUSTOMAUDITVIEW' and t.column_name='REMARKBFTEMP';
  if i=0 then
     execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW add REMARKBFTEMP varchar2(4000)';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_CUSTOMAUDITVIEW' and t.column_name='REMARKTEMP';
  if i=0 then
     execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW add REMARKTEMP varchar2(4000)';
  end if;
  
  -- ÁÙÊ±×Ö¶Î´æ´¢ÒªÐÞ¸Ä×Ö¶ÎµÄÖµ
  execute immediate 'UPDATE PERF_T_CUSTOMAUDITVIEW t1 SET t1.REMARKBFTEMP = (select t2.REMARKBF from PERF_T_CUSTOMAUDITVIEW t2 where t1.guid = t2.guid)';
  execute immediate 'UPDATE PERF_T_CUSTOMAUDITVIEW t1 SET t1.REMARKTEMP = (select t2.REMARK from PERF_T_CUSTOMAUDITVIEW t2 where t1.guid = t2.guid)';
 
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_CUSTOMAUDITVIEW' and t.column_name='REMARKBF';
  if i>0 then
     --É¾³ýÔ­×Ö¶Î
     execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW drop column REMARKBF';
     -- Ìí¼ÓÐÂ×Ö¶Î
     execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW add REMARKBF varchar2(4000)';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_CUSTOMAUDITVIEW' and t.column_name='REMARK';
  if i>0 then
     --É¾³ýÔ­×Ö¶Î
     execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW drop column REMARK';
     -- Ìí¼ÓÐÂ×Ö¶Î
     execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW add REMARK varchar2(4000)';
  end if;
  
  -- ÁÙÊ±×Ö¶ÎµÄÖµ¸øÐÂ×Ö¶Î
  execute immediate 'UPDATE PERF_T_CUSTOMAUDITVIEW t1 SET t1.REMARKBF = (select t2.REMARKBFTEMP from PERF_T_CUSTOMAUDITVIEW t2 where t1.guid = t2.guid)';
  execute immediate 'UPDATE PERF_T_CUSTOMAUDITVIEW t1 SET t1.REMARK = (select t2.REMARKTEMP from PERF_T_CUSTOMAUDITVIEW t2 where t1.guid = t2.guid)';
  
  
  -- É¾³ýÁÙÊ±×Ö¶Î
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_CUSTOMAUDITVIEW' and t.column_name='REMARKBFTEMP';
    if i>0 then
       execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW drop column REMARKBFTEMP';
  end if;
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_CUSTOMAUDITVIEW' and t.column_name='REMARKTEMP';
    if i>0 then
       execute immediate 'alter table PERF_T_CUSTOMAUDITVIEW drop column REMARKTEMP';
  end if;
