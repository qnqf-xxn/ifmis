num NUMBER;
begin
SELECT COUNT(1) INTO num from cols where table_name = upper('PERF_T_EVALUATETEMP') and column_name = upper('ISTOTAL');
   IF num > 0 THEN execute immediate 'alter table PERF_T_EVALUATETEMP MODIFY ISTOTAL NUMBER(1)';
  ELSE 
 execute immediate 'alter table PERF_T_EVALUATETEMP add ISTOTAL NUMBER(1) Default 1';
 execute immediate 'create or replace view v_perf_t_evaluatetemp as select * from PERF_T_EVALUATETEMP t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  END IF;
 SELECT COUNT(1) INTO num from cols where table_name = upper('PERF_TMP_EVALUATETEMP') and column_name = upper('ISTOTAL');
   IF num > 0 THEN execute immediate 'alter table PERF_TMP_EVALUATETEMP MODIFY ISTOTAL NUMBER(1)';
  ELSE 
 execute immediate 'alter table PERF_TMP_EVALUATETEMP add ISTOTAL NUMBER(1) Default 1';
  END IF;
