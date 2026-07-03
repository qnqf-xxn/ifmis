  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  
select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='VERSIONTYPE';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add versiontype NUMBER(1) default 0';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='IS_BACKUP';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add is_backup NUMBER(1) default 2';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='IS_ADJ';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add is_adj NUMBER(1) default 2';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='INDEXCATEGORIES';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add indexcategories VARCHAR2(40)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='INDUSTRYCATEGORY';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add industrycategory VARCHAR2(40)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='INDEXCATEGORY';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add indexcategory VARCHAR2(40)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='FILED';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add filed VARCHAR2(40)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='OCCUPATION';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add occupation VARCHAR2(40)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='ISFIXED';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add isfixed NUMBER(1)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='ISFROMPARENT';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add isfromparent NUMBER(1)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='ISAPPLY';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add isapply NUMBER(1) default 1';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='ISALLOWEDIT';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add isallowedit NUMBER(1)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_INDICATOR' and t.column_name='ONLYSELF';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_INDICATOR add onlyself NUMBER(1)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_GOAL' and t.column_name='RATIO';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_GOAL add ratio NUMBER(4,1)';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_GOAL' and t.column_name='VERSIONTYPE';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_GOAL add versiontype NUMBER(1) default 0';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_GOAL' and t.column_name='IS_BACKUP';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_GOAL add is_backup NUMBER(1) default 2';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_GOAL' and t.column_name='IS_ADJ';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_GOAL add is_adj NUMBER(1) default 2';
end if;

select count(*) into i from user_tab_columns t where t.table_name ='PERF_TRANSFER_GOAL' and t.column_name='APPLYFINAMT';
if i=0 then
  execute immediate 'alter table PERF_TRANSFER_GOAL add applyfinamt NUMBER(20,2)';
end if;

v_sql :='
create or replace view V_PERF_TRANSFER_INDICATOR as
select *
from perf_transfer_indicator where year = global_multyear_cz.v_pmyear
      and province = global_multyear_cz.v_pmdivid and is_deleted = 2 and is_backup=2';
select fn_alterview('V_PERF_TRANSFER_INDICATOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

v_sql :='
create or replace view V_PERF_TRANSFER_GOAL as
select *
from perf_transfer_goal t where year = global_multyear_cz.v_pmyear
  and province = global_multyear_cz.v_pmdivid and t.is_deleted=2 and is_backup=2';
select fn_alterview('V_PERF_TRANSFER_GOAL',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;