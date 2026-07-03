  num NUMBER;
BEGIN 
  --PERF_T_PROVISIONDECLARE新增字段MODTYPE
   SELECT COUNT(1) INTO num from cols where table_name = upper('PERF_T_PROVISIONDECLARE') and column_name = upper('MODTYPE');
   IF num = 0 THEN 
     execute immediate 'alter table PERF_T_PROVISIONDECLARE  ADD MODTYPE varchar2(40)';
   END IF;
   
   DELETE FROM bus_t_diccolumn t where t.tablecode='PERF_T_PROVISIONDECLARE' and t.columncode='MODTYPE';
   insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
   values (null, null, null, '1', 'MODTYPE', '1', '2016', '87', 'E507041D0D8541D8BFE04A439715A4C2', 'MODTYPE', 'PERF_T_PROVISIONDECLARE', '修改类型', 'S', '40', null, null, 1, null, sysdate);
  
   execute immediate '
   create or replace view V_PERF_T_PROVISIONDECLARE as 
   select * from PERF_T_PROVISIONDECLARE t 
   where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
   and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
