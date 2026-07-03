i number;
begin
  -- Test statements here
  --´´½¨ÁÙÊ±×Ö¶Î
select count(1) into i from user_tab_cols t where t.table_name='perf_pendingtask' and t.column_name='TEMP';
  if i=0 then
      execute immediate 'alter table PERF_PENDINGTASK add TEMP VARCHAR2(3000)';
  end if;
  
  -- ÁÙÊ±×Ö¶Î´æ´¢ÒªÐÞ¸Ä×Ö¶ÎµÄÖµ
    execute immediate 'UPDATE PERF_PENDINGTASK t1 SET t1.TEMP = (select t2.PARAM from PERF_PENDINGTASK t2 where t1.guid = t2.guid)';
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_PENDINGTASK' and t.column_name='PARAM';
  if i>0 then
     --É¾³ýÔ­×Ö¶Î
     execute immediate 'alter table PERF_PENDINGTASK drop column PARAM';
     -- Ìí¼ÓÐÂ×Ö¶Î
     execute immediate 'alter table PERF_PENDINGTASK add PARAM varchar2(3000)';
  end if;
  
  -- ÁÙÊ±×Ö¶ÎµÄÖµ¸øÐÂ×Ö¶Î
  execute immediate 'UPDATE PERF_PENDINGTASK t1 SET t1.PARAM = (select t2.TEMP from PERF_PENDINGTASK t2 where t1.guid = t2.guid)';
  
  -- É¾³ýÁÙÊ±×Ö¶Î
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_PENDINGTASK' and t.column_name='TEMP';
    if i>0 then
       execute immediate 'alter table PERF_PENDINGTASK drop column TEMP';
  end if;
