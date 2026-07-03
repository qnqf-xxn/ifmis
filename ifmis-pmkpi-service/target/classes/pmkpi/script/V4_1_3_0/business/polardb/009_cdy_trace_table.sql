  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_PROMONITOR' and t.column_name='PROGRESS';
  if i=0 then
    execute immediate 'alter table PERF_T_PROMONITOR add PROGRESS VARCHAR2(4000)';
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

delete from bus_t_diccolumn t where t.tablecode in('PERF_T_PROMONITOR') and t.columncode in('PROGRESS');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROGRESS', '1', '2024', '87', '1F2424DFE6EBDC39E063030011AC0A86', 'PROGRESS', 'PERF_T_PROMONITOR', '实施进度', 'S', '4000', null, 1, 1, null, sysdate);
