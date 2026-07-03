  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_PROBLEMFEEDBACK' and t.column_name='PLANRECTIFY_RESULT';
if i=0 then
   execute immediate 'alter table PERF_T_PROBLEMFEEDBACK add PLANRECTIFY_RESULT VARCHAR2(4000)';
end if;

v_sql :='create or replace view v_perf_t_problemfeedback as select t.* from perf_t_problemfeedback t 
where t.year = global_multyear_cz.v_pmyear
and t.province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_PROBLEMFEEDBACK',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

v_sql :='create or replace view v_perf_t_problemtaskquery as 
select t.*,
t.agency_code as agencyguid,
t.lead_department as finintorgguid,
case when (select count(1) from v_perf_file a where a.billguid = t.guid and a.filetype=''problemtaskplan001'' group by filetype,billguid) > 0 then 1 else 0 end as plan_file,
case when (select count(1) from v_perf_file a where a.billguid = t.guid and a.filetype=''problemtaskfeedback001'' group by filetype,billguid) > 0 then 1 else 0 end as support_file
from v_perf_t_problemfeedback t';
select fn_alterview('V_PERF_T_PROBLEMTASKQUERY',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
