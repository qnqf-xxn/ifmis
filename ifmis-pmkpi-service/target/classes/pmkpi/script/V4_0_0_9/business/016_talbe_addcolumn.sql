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


select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EVALUATEAUDIT' and t.column_name='BUSTYPE';
     if i=0 then
       execute immediate 'alter table PERF_T_EVALUATEAUDIT add BUSTYPE VARCHAR2(40)';
       
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EVALUATEAUDIT' and t.columncode='BUSTYPE';
       insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '0', 'BUSTYPE', '1', '2020', '87', 'B45a303CE6656613E053B11FA8C23111', 'BUSTYPE', 'PERF_T_EVALUATEAUDIT', '类别', 'S', '40', null, null, 1, null, sysdate);

     end if;

execute immediate 'create or replace view v_perf_t_evaluateaudit as
select * FROM PERF_T_EVALUATEAUDIT T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
      and T.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';
      
      
select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='VALUE_DESC';
     if i=0 then
       execute immediate 'alter table PERF_T_CASEMODELINDEX add VALUE_DESC VARCHAR2(2000)';
       
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_CASEMODELINDEX' and t.columncode='VALUE_DESC';
       insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '1', 'VALUE_DESC', '1', '2021', '87', 'BE6BEAA420514413E053B11FA8C0A9AC', 'VALUE_DESC', 'PERF_T_CASEMODELINDEX', '参考指标值', 'S', '2000', null, 1, 0, null, sysdate);

     end if;

execute immediate 'create or replace view v_PERF_T_CASEMODELINDEX as
select * FROM PERF_T_CASEMODELINDEX T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
