  i integer;
begin   
   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='VALUE_REMARK';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add VALUE_REMARK VARCHAR2(2000)';
     end if;
     
     select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='VALUE_DESC';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add VALUE_DESC VARCHAR2(4000)';
     end if;
     
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PM_PERF_INDICATOR_TEMP' and t.columncode='VALUE_REMARK';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'VALUE_REMARK', '1', '2021', '87', 'BED43D216F82A1A5E053B11FA8C09CA8', 'VALUE_REMARK', 'PM_PERF_INDICATOR_TEMP', '指标值说明', 'S', '2000', null, 1, 0, null, sysdate);

       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PM_PERF_INDICATOR_TEMP' and t.columncode='VALUE_DESC';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'VALUE_DESC', '1', '2021', '87', 'BF5EB36C5FCD937FE053B11FA8C04F08', 'VALUE_DESC', 'PM_PERF_INDICATOR_TEMP', '参考指标值', 'S', '4000', null, 1, 0, null, sysdate);
