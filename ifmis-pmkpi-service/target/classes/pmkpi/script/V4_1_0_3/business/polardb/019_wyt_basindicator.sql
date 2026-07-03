i number;
v_sql varchar2(2000);
ln_i integer;
begin
  --项目级次
  select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='PRO_LEV';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add PRO_LEV varchar2(40)';
  end if;  
  --上级项目
  select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='PRO_PARENT';
  if i=0 then
     execute immediate 'alter table BAS_PERF_INDICATOR add PRO_PARENT varchar2(2000)';
  end if; 
  
  --重构视图
	v_sql :='CREATE OR REPLACE VIEW V_BAS_PERF_INDICATOR AS
    SELECT *
    FROM BAS_PERF_INDICATOR T
	WHERE PROVINCE = GLOBAL_MULTYEAR_CZ.V_PMDIVID AND T.IS_DELETED=2';
	select fn_alterview('V_BAS_PERF_INDICATOR',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;
