
i integer;
begin
  
     select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='KPI_VAL';
     if i=1 then
       execute immediate 'alter table BAS_PERF_INDICATOR modify kpi_val VARCHAR2(1000)';
     end if;      

     select count(1) into i from user_tab_cols t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='KPI_VAL' and t.nullable='N';
     if i=1 then
       execute immediate 'alter table BAS_PERF_INDICATOR modify kpi_val VARCHAR2(1000) null';
     end if;
     

execute immediate ' 
create or replace view v_bas_perf_indicator as
select *
from BAS_PERF_INDICATOR t where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2
';

execute immediate ' 
create or replace view perf_v_queryallindex as
select guid,findex,sindex,''''tindex,code from v_bas_perf_indicator
union all
select guid,findex,sindex,tindex,code from v_bgt_perf_indicator
union all
select guid,findex,sindex,tindex,code from v_pm_perf_indicator
union all
select guid,findex,sindex,tindex,code from v_perf_t_adjustindex
union all
select guid,findex,sindex,tindex,code from v_perf_t_casemodelindex';
