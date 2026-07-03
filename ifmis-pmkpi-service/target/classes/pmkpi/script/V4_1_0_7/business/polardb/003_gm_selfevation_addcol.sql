  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

  select count(1) into i from user_tab_columns where table_name = 'PERF_T_EVALUATEINFO' and column_name = 'SELFGRADE';
  if i = 0 then
     execute immediate 'alter table PERF_T_EVALUATEINFO add SELFGRADE VARCHAR2(40)';
  end if;
  
  SELECT count(1) into i FROM  bus_t_diccolumn c where c.tablecode ='PERF_T_EVALUATEINFO' and c.dbcolumncode = 'SELFGRADE';
  if i < 1 then
    insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
    values (null, null, null, '1', 'SELFGRADE', '1', '2016', '87', '0E2EFD5D5E883CE9E0630A64A8C06853', 'SELFGRADE', 'PERF_T_EVALUATEINFO', 'µÈ¼¶', 'S', '40', null, 1, 0, null, sysdate);
  end if;
  
  v_sql :='
  create or replace view V_PERF_T_EVALUATEINFO as
  select *
    from PERF_T_EVALUATEINFO t where year = global_multyear_cz.v_pmyear
      and province = global_multyear_cz.v_pmdivid';
    select fn_alterview('V_PERF_T_EVALUATEINFO',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;