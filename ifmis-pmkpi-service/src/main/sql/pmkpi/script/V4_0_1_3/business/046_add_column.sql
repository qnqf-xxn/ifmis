num NUMBER;
 BEGIN 
 --PERF_T_PROINDEXTRACE
    SELECT COUNT(1) INTO num from cols where table_name = upper('PERF_T_PROINDEXTRACE') and column_name = upper('COMPLETEANALYSCON');
   IF num > 0 THEN execute immediate 'alter table PERF_T_PROINDEXTRACE MODIFY COMPLETEANALYSCON varchar2(2000)';
  ELSE 
 execute immediate 'alter table PERF_T_PROINDEXTRACE add COMPLETEANALYSCON varchar2(2000)';
 execute immediate 'create or replace view v_perf_t_proindextrace as select * from PERF_T_PROINDEXTRACE t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  END IF;
  --PERF_T_PROINDEXTRACE
    SELECT COUNT(1) INTO num from cols where table_name = upper('PERF_T_PROINDEXTRACE') and column_name = upper('DEVIATIONANALYSIS');
   IF num > 0 THEN execute immediate 'alter table PERF_T_PROINDEXTRACE MODIFY DEVIATIONANALYSIS varchar2(500)';
  ELSE 
    execute immediate 'alter table PERF_T_PROINDEXTRACE add DEVIATIONANALYSIS varchar2(500)';
  END IF; 
  --PERF_T_PROBGTFUND
    SELECT COUNT(1) INTO num from cols where table_name = upper('PERF_T_PROBGTFUND') and column_name = upper('ECONOMIC');
   IF num > 0 THEN execute immediate 'alter table PERF_T_PROBGTFUND MODIFY ECONOMIC varchar2(40)';
  ELSE 
 execute immediate 'alter table PERF_T_PROBGTFUND add ECONOMIC varchar2(40)';
  END IF;
