 i number;
begin
  SELECT COUNT(*) INTO i from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('PRO_TYPE');
   IF i = 0 THEN 
     execute immediate 'alter table BAS_PERF_INDICATOR add PRO_TYPE varchar2(300)';
  END IF; 
  SELECT COUNT(*) INTO i from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('PRO_NAME');
   IF i = 0 THEN 
     execute immediate 'alter table BAS_PERF_INDICATOR add PRO_NAME varchar2(1000)';
  END IF; 
--÷ÿππ ”Õº
execute immediate'
create or replace view v_bas_perf_indicator as
select *
FROM BAS_PERF_INDICATOR T 
WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
