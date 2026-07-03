  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
--½×¶ÎÖ´ÐÐÊý
select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='STAGEBGTAMT';
if i=0 then
  execute immediate 'alter table PERF_T_PROMONITOR add STAGEBGTAMT NUMBER(20,2)';
end if;

v_sql :='
create or replace view V_PERF_T_PROMONITOR as
select *
   from perf_t_promonitor t
      WHERE year = global_multyear_cz.v_pmyear
    and province = global_multyear_cz.v_pmdivid';
select fn_alterview('V_PERF_T_PROMONITOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;	 