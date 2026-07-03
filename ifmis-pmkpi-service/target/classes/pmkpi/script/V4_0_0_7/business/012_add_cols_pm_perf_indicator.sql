
i integer;
begin

   select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR' and t.column_name='VALUE_REMARK';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR add VALUE_REMARK VARCHAR2(2000)';
       
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PM_PERF_INDICATOR' and t.columncode='VALUE_REMARK';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'VALUE_REMARK', '1', '2021', '87', '1223BB8D6936B4CCE0580A050352adw1', 'VALUE_REMARK', 'PM_PERF_INDICATOR', '指标值解释', 'S', '2000', null, 1, 0, null, sysdate);

     end if;

execute immediate 'create or replace view v_PM_PERF_INDICATOR as
select * FROM PM_PERF_INDICATOR T
      WHERE year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
