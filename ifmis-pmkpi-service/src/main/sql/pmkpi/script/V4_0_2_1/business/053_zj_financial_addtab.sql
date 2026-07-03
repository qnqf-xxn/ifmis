i number;
begin

  select count(*) INTO i from user_tab_columns where table_name ='PERF_T_FINEVALUATION' and column_name = 'FINWORD';
  if i = 0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add FINWORD VARCHAR2(4000)';
  end if;
  
  select count(*) INTO i from user_tab_columns where table_name ='PERF_T_FINEVALUATION' and column_name = 'FINREPORT';
  if i = 0 then
     execute immediate 'alter table PERF_T_FINEVALUATION add FINREPORT VARCHAR2(4000)';
  end if;


  execute immediate'create or replace view v_PERF_T_FINEVALUATION as
    select * from PERF_T_FINEVALUATION t
    where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
    PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
	