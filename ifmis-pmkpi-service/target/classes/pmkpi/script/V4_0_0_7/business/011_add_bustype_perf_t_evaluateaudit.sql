
i integer;
begin

   select count(1) into i from user_tab_cols t where t.table_name='PERF_T_EVALUATEAUDIT' and t.column_name='BUSTYPE';
     if i=0 then
       execute immediate 'alter table PERF_T_EVALUATEAUDIT add BUSTYPE VARCHAR2(40)';
       
       DELETE FROM Bus_t_Diccolumn t where t.tablecode='PERF_T_EVALUATEAUDIT' and t.columncode='BUSTYPE';
       insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
       values (null, null, null, '0', 'BUSTYPE', '1', '2020', '87', 'B45a303CE6656613E053B11FA8C23111', 'BUSTYPE', 'PERF_T_EVALUATEAUDIT', 'Àà±ð', 'S', '40', null, null, 1, null, sysdate);

     end if;

execute immediate 'create or replace view v_perf_t_evaluateaudit as
select * FROM PERF_T_EVALUATEAUDIT T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
      and T.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';
