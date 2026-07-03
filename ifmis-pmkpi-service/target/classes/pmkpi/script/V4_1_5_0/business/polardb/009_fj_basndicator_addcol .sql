  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--BAS_PERF_INDICATOR INDEXSTANDARDS
select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='INDEXSTANDARDS';
if i=1 then
	execute immediate 'alter table BAS_PERF_INDICATOR modify INDEXSTANDARDS VARCHAR2(400)';
end if;

--BAS_PERF_INDICATOR INDEXSTANDARDSVAL1
select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='INDEXSTANDARDSVAL1';
if i=0 then
	execute immediate 'alter table BAS_PERF_INDICATOR add INDEXSTANDARDSVAL1 VARCHAR2(1000)';
end if;

--BAS_PERF_INDICATOR INDEXSTANDARDSVAL2
select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='INDEXSTANDARDSVAL2';
if i=0 then
	execute immediate 'alter table BAS_PERF_INDICATOR add INDEXSTANDARDSVAL2 VARCHAR2(1000)';
end if;

--BAS_PERF_INDICATOR INDEXSTANDARDSVAL3
select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='INDEXSTANDARDSVAL3';
if i=0 then
	execute immediate 'alter table BAS_PERF_INDICATOR add INDEXSTANDARDSVAL3 VARCHAR2(1000)';
end if;

--BAS_PERF_INDICATOR INDEXSTANDARDSVAL4
select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='INDEXSTANDARDSVAL4';
if i=0 then
	execute immediate 'alter table BAS_PERF_INDICATOR add INDEXSTANDARDSVAL4 VARCHAR2(1000)';
end if;

--BAS_PERF_INDICATOR INDEXSTANDARDSVAL5
select count(*) into i from user_tab_columns t where t.table_name ='BAS_PERF_INDICATOR' and t.column_name='INDEXSTANDARDSVAL5';
if i=0 then
	execute immediate 'alter table BAS_PERF_INDICATOR add INDEXSTANDARDSVAL5 VARCHAR2(1000)';
end if;

v_sql :='
create or replace view V_BAS_PERF_INDICATOR as
select *
FROM BAS_PERF_INDICATOR T
WHERE province = global_multyear_cz.v_pmdivid and is_deleted =2';
select fn_alterview('V_BAS_PERF_INDICATOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;	