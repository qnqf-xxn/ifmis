
i number;
begin
  select count(1) into i from user_tab_columns where table_name = 'BAS_PERF_INDICATOR' and column_name = 'INDEXTRANPAY';
  if i = 0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add INDEXTRANPAY varchar2(40)';
  end if;
  
execute immediate '
create or replace view v_bas_perf_indicator as
select *
 FROM BAS_PERF_INDICATOR T
  WHERE province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';
