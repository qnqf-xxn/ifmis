  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--1.AI指标推荐 增加ai推荐指标标识
--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='AI_RECOINDEXMARK';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR add AI_RECOINDEXMARK varchar2(40)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2 and t.sub_mof_div_code is null';
select fn_alterview('V_PM_PERF_INDICATOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='AI_RECOINDEXMARK';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR_TEMP add AI_RECOINDEXMARK varchar2(40)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.v_pmdivid and is_deleted =2';
select fn_alterview('V_PM_PERF_INDICATOR_TEMP',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='AI_RECOINDEXMARK';
if i=0 then
   execute immediate 'alter table PERF_T_ADJUSTINDEX add AI_RECOINDEXMARK varchar2(40)';
end if;

v_sql :='
create or replace view V_PERF_T_ADJUSTINDEX as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2 and t.sub_mof_div_code is null';
select fn_alterview('V_PERF_T_ADJUSTINDEX',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

v_sql :='
create or replace view V_PERF_T_ADJUSTALLINDEX as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid and t.is_deleted=2';
select fn_alterview('V_PERF_T_ADJUSTALLINDEX',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--2.AI辅助审核 增加审核要点扩展
--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_AISUPPORTAUDIRESULT' and t.column_name='AUDITPOINT4';
if i=0 then
   execute immediate 'alter table PERF_T_AISUPPORTAUDIRESULT add AUDITPOINT4 VARCHAR2(4000)';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_AISUPPORTAUDIRESULT' and t.column_name='AUDITPOINT5';
if i=0 then
   execute immediate 'alter table PERF_T_AISUPPORTAUDIRESULT add AUDITPOINT5 VARCHAR2(4000)';
end if;

--AI辅助审核结果记录视图重建
v_sql :='
CREATE OR REPLACE VIEW V_PERF_T_AISUPPORTAUDIRESULT AS
WITH ranked_data AS (
    SELECT 
        t.*,
        ROW_NUMBER() OVER (
            PARTITION BY pro_code, province, year 
            ORDER BY timestamps DESC
        ) AS rn
    FROM PERF_T_AISUPPORTAUDIRESULT t
    WHERE status = ''success''
		AND (auditpoint1 is not null OR auditpoint2 is not null OR auditpoint3 is not null OR auditpoint4 is not null)--三个维度审核项都为空的不展示
)
SELECT 
    pro_code, province, year, timestamps, 
    agency_code, agency_name, pro_name, auditpoint1, auditpoint2, auditpoint3, auditpoint4, auditpoint5
FROM ranked_data
WHERE rn = 1
AND province = global_multyear_cz.v_pmdivid 
AND year = global_multyear_cz.v_pmyear';
select fn_alterview('V_PERF_T_AISUPPORTAUDIRESULT',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;


--创建中间表-用于查询历史年度资金 perf_bgt_pm_annual
select count(*) into i from user_tables t where t.table_name ='PERF_BGT_PM_ANNUAL';
if i=0 then
	execute immediate '
create table perf_bgt_pm_annual as
select mof_div_code,mof_div_name,fiscal_year ,agency_code ,agency_name,pro_code ,pro_name ,cur_amt from bgt_pm_annual t
where t.is_deleted =2 and t.found_type_code in(''11'',''21'')';
end if;

--AI辅助审核用资金视图 V_PM_PERF_BGTAMTNOWANDLAST，前年和上年从中间表perf_bgt_pm_annual获取，本年从预算资金表bgt_pm_annual获取
select count(*) into i from user_views where VIEW_NAME = 'V_PM_PERF_BGTAMTNOWANDLAST';
if i=0 then
	execute immediate '
create or replace view V_PM_PERF_BGTAMTNOWANDLAST as
select t.pro_code,
	   (global_multyear_cz.v_pmyear-2)||''年预算资金数为''||nvl((select max(cur_amt) from perf_bgt_pm_annual a where a.pro_code = t.pro_code and a.mof_div_code = t.mof_div_code and a.fiscal_year = (global_multyear_cz.v_pmyear-2) group by mof_div_code,fiscal_year,pro_code),0)||''元,''
       ||(global_multyear_cz.v_pmyear-1)||''年预算资金数为''||nvl((select max(cur_amt) from perf_bgt_pm_annual a where a.pro_code = t.pro_code and a.mof_div_code = t.mof_div_code and a.fiscal_year = (global_multyear_cz.v_pmyear-1) group by mof_div_code,fiscal_year,pro_code),0)||''元,''
       ||global_multyear_cz.v_pmyear||''年预算资金数为''||nvl((select max(cur_amt) from bgt_pm_annual b  where b.pro_code = t.pro_code and b.mof_div_code = t.mof_div_code and b.fiscal_year = global_multyear_cz.v_pmyear and b.is_deleted =2 and b.found_type_code in(''11'',''21'') group by mof_div_code,fiscal_year,pro_code),0)||''元。''
       as perfbgtamt
       from V_PERF_ALLPROJECT_INFO t';
end if;


--AI辅助审核用的指标视图
--上年度指标聚合视图 V_PM_PERF_INDICATORAGGLAST
v_sql :='
CREATE OR REPLACE VIEW V_PM_PERF_INDICATORAGGLAST AS
SELECT 
  pro_code, province, year,
  string_agg(
    ''指标编码：''||t.code||
    '',指标名称：''||t.name||
    '',运算符号：''||(SELECT a.name FROM v_perf_enum a 
                   WHERE a.elementcode = ''PMKPIZBXS'' AND a.code = t.computesign)||
    '',指标值：''||t.indexval||
    '',计量单位：''||t.meterunit, 
    ''; '' ORDER BY t.code
  ) AS perfindex
FROM PM_PERF_INDICATOR t 
WHERE t.yearflag = ''0'' and t.is_deleted = ''2'' and t.is_backup=2 and t.province = global_multyear_cz.v_pmdivid and t.year = (global_multyear_cz.v_pmyear-1)
GROUP BY pro_code, province, year';
select fn_alterview('V_PM_PERF_INDICATORAGGLAST',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--前年自评指标聚合视图 V_PM_PERF_EVALINDEXAGGLAST
v_sql :='
CREATE OR REPLACE VIEW V_PM_PERF_EVALINDEXAGGLAST AS
SELECT 
  pro_code, province, year,
  string_agg(
    ''指标编码：''||t.code||
    '',指标名称：''||t.name||
    '',运算符号：''||(SELECT a.name FROM v_perf_enum a 
                   WHERE a.elementcode = ''PMKPIZBXS'' AND a.code = t.computesign)||
    '',指标值：''||t.actualvalue||
    '',计量单位：''||t.meterunit, 
    ''; '' ORDER BY t.code
  ) AS perfindex
FROM perf_t_selfperfindex t 
WHERE t.province = global_multyear_cz.v_pmdivid and t.year = (global_multyear_cz.v_pmyear-2)
  AND is_deleted = ''2'' 
GROUP BY pro_code, province, year';
select fn_alterview('V_PM_PERF_EVALINDEXAGGLAST',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
