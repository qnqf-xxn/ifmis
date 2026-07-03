	num number;
begin 

--PAY_PERF_MONITOR_INFO
select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_INFO') and column_name = upper('PRO_BGT_COMP');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_INFO MODIFY PRO_BGT_COMP NUMBER(18,6)';
  else execute immediate 'alter table PAY_PERF_MONITOR_INFO add PRO_BGT_COMP NUMBER(18,6)';
end if;

select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_INFO') and column_name = upper('EST_PRO_BGT_ANNUAL');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_INFO MODIFY EST_PRO_BGT_ANNUAL NUMBER(18,6)';
  else execute immediate 'alter table PAY_PERF_MONITOR_INFO add EST_PRO_BGT_ANNUAL NUMBER(18,6)';
end if;

select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_INFO') and column_name = upper('LV1_PERF_IND_CODE');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_INFO MODIFY LV1_PERF_IND_CODE VARCHAR2(300)';
  else execute immediate 'alter table PAY_PERF_MONITOR_INFO add LV1_PERF_IND_CODE VARCHAR2(300)';
end if;

select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_INFO') and column_name = upper('LV2_PERF_IND_CODE');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_INFO MODIFY LV2_PERF_IND_CODE VARCHAR2(300)';
  else execute immediate 'alter table PAY_PERF_MONITOR_INFO add LV2_PERF_IND_CODE VARCHAR2(300)';
end if;

select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_INFO') and column_name = upper('LV3_PERF_IND_CODE');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_INFO MODIFY LV3_PERF_IND_CODE VARCHAR2(300)';
  else execute immediate 'alter table PAY_PERF_MONITOR_INFO add LV3_PERF_IND_CODE VARCHAR2(300)';
end if;

select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_INFO') and column_name = upper('COMPLETE_RATE');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_INFO MODIFY COMPLETE_RATE NUMBER(18,6)';
  else execute immediate 'alter table PAY_PERF_MONITOR_INFO add COMPLETE_RATE NUMBER(18,6)';
end if;

execute immediate '
create or replace view v_pay_perf_monitor_info as
select t.*
 from pay_perf_monitor_info t
where t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t.is_deleted=2';


--PAY_PERF_MONITOR_ATTACH
select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_ATTACH') and column_name = upper('MOF_DIV_CODE');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_ATTACH MODIFY MOF_DIV_CODE VARCHAR2(9)';
  else execute immediate 'alter table PAY_PERF_MONITOR_ATTACH add MOF_DIV_CODE VARCHAR2(9)';
end if;

select count(1) into num from user_tab_cols  where table_name = upper('PAY_PERF_MONITOR_ATTACH') and column_name = upper('FILE_NAME');
if num > 0 then execute immediate 'alter table PAY_PERF_MONITOR_ATTACH MODIFY FILE_NAME VARCHAR2(600)';
  else execute immediate 'alter table PAY_PERF_MONITOR_ATTACH add FILE_NAME VARCHAR2(600)';
end if;

execute immediate '
create or replace view v_pay_perf_monitor_attach as
select t.*
 from pay_perf_monitor_attach t
where t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t.is_deleted=2';

--PERF_PUBLIC_FILE
select count(1) into num from user_tab_cols  where table_name = upper('PERF_PUBLIC_FILE') and column_name = upper('FILE_NAME');
if num > 0 then execute immediate 'alter table PERF_PUBLIC_FILE MODIFY FILE_NAME VARCHAR2(600)';
  else execute immediate 'alter table PERF_PUBLIC_FILE add FILE_NAME VARCHAR2(600)';
end if;

execute immediate '
create or replace view v_perf_public_file as
select t.*
 from perf_public_file t
where t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') 
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
and t.is_deleted=2';

--PERF_MANAGE_FILE
select count(1) into num from user_tab_cols  where table_name = upper('PERF_MANAGE_FILE') and column_name = upper('FILE_NAME');
if num > 0 then execute immediate 'alter table PERF_MANAGE_FILE MODIFY FILE_NAME VARCHAR2(600)';
  else execute immediate 'alter table PERF_MANAGE_FILE add FILE_NAME VARCHAR2(600)';
end if;

execute immediate '
create or replace view v_perf_manage_file as
select t.*
 from PERF_MANAGE_FILE t
where t.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and t.mof_div_code = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
and t.is_deleted=2';

