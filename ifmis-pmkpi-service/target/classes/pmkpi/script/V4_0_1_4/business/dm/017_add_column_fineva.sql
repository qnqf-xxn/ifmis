
num NUMBER;
 BEGIN 
 --PERF_T_PROINDEXTRACE
    SELECT COUNT(1) INTO num from user_tab_cols  where table_name = upper('PERF_T_FINEVALUATION') and column_name = upper('AUDITTYPE');
   IF num > 0 THEN execute immediate 'alter table PERF_T_FINEVALUATION MODIFY AUDITTYPE VARCHAR2(40)';
  ELSE 
 execute immediate 'alter table PERF_T_FINEVALUATION add AUDITTYPE varchar2(40)';
  END IF;
  execute immediate 'create or replace view v_PERF_T_FINEVALUATION as select * from PERF_T_FINEVALUATION t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

