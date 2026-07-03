  i number;
begin

--1.AI指标推荐 增加ai推荐指标标识
--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='AI_RECOINDEXMARK';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR add AI_RECOINDEXMARK varchar2(40)';
end if;

execute immediate '
create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2 and t.sub_mof_div_code is null and t.sub_mof_div_code is null';

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='AI_RECOINDEXMARK';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR_TEMP add AI_RECOINDEXMARK varchar2(40)';
end if;

execute immediate '
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='AI_RECOINDEXMARK';
if i=0 then
   execute immediate 'alter table PERF_T_ADJUSTINDEX add AI_RECOINDEXMARK varchar2(40)';
end if;

execute immediate '
create or replace view V_PERF_T_ADJUSTINDEX as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2 and t.sub_mof_div_code is null';

execute immediate '
create or replace view v_perf_t_adjustallindex as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';


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
execute immediate '
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
		AND (auditpoint1 is not null OR auditpoint2 is not null OR auditpoint3 is not null)--三个维度审核项都为空的不展示 可根据实际情况自行修改
)
SELECT 
    pro_code, province, year, timestamps, 
    agency_code, agency_name, pro_name, auditpoint1, auditpoint2, auditpoint3, auditpoint4, auditpoint5
FROM ranked_data
WHERE rn = 1
AND province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
AND year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';

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
	   (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-2)||''年预算资金数为''||nvl((select max(cur_amt) from perf_bgt_pm_annual a where a.pro_code = t.pro_code and a.mof_div_code = t.mof_div_code and a.fiscal_year = (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-2) group by mof_div_code,fiscal_year,pro_code),0)||''元,''
       ||(global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-1)||''年预算资金数为''||nvl((select max(cur_amt) from perf_bgt_pm_annual a where a.pro_code = t.pro_code and a.mof_div_code = t.mof_div_code and a.fiscal_year = (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-1) group by mof_div_code,fiscal_year,pro_code),0)||''元,''
       ||global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')||''年预算资金数为''||nvl((select max(cur_amt) from bgt_pm_annual b  where b.pro_code = t.pro_code and b.mof_div_code = t.mof_div_code and b.fiscal_year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and b.is_deleted =2 and b.found_type_code in(''11'',''21'') group by mof_div_code,fiscal_year,pro_code),0)||''元。''
       as perfbgtamt
       from V_PERF_ALLPROJECT_INFO t';
end if;

--AI辅助审核用湖北单独的指标视图
--湖北本年度指标聚合视图 V_PM_PERF_INDICATORAGGHB
execute immediate '
CREATE OR REPLACE VIEW V_PM_PERF_INDICATORAGGHB AS
with frameindex as (select pf.code,pf.name,pf.levelno from v_perf_t_frame pf where pf.frametype = ''PM001'')
SELECT pro_code, xmlagg(xmlparse(content ''绩效目标：''||nvl((select c.kpi_target
             from V_PM_PERF_GOAL_INFO c where c. yearflag = ''0'' and c.guid = t.goalguid),''空'')||'',指标编码：''||t.code||'',一级指标：''||(select name from frameindex f where f.code =t.findex)||'',二级指标：''||(select name from frameindex f where f.code =t.sindex)||'',指标名称：''||t.name||'',运算符号：''||(select a.name
             from v_perf_enum a where a.elementcode = ''PMKPIZBXS'' and a.code = t.computesign)||'',指标值：''||t.indexval||'',计量单位：''||t.meterunit||'';'' wellformed)
    order by 1).getclobval() as perfindex
FROM V_PM_PERF_INDICATOR t where yearflag = ''0''and is_deleted = ''2'' and goalguid is not null GROUP BY pro_code';

--湖北上年度指标聚合视图 V_PM_PERF_INDICATORAGGLASTHB
execute immediate '
create or replace view V_PM_PERF_INDICATORAGGLASTHB as
with frameindex as (select pf.code,pf.name,pf.levelno from v_perf_t_frame pf where pf.frametype = ''PM001'')
select pro_code,province,year, xmlagg(xmlparse(content ''绩效目标：''||nvl((select c.kpi_target
             from PM_PERF_GOAL_INFO c where c. yearflag = ''0'' and c.is_deleted =''2'' and c.is_backup=2 and c.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and c.year = (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-1) and c.guid = t.goalguid),''空'')||'',指标编码：''||t.code||'',一级指标：''||(select name from frameindex f where f.code =t.findex)||'',二级指标：''||(select name from frameindex f where f.code =t.sindex)||'',指标名称：''||t.name||'',运算符号：''||(select a.name
             from v_perf_enum a where a.elementcode = ''PMKPIZBXS'' and a.code = t.computesign)||'',指标值：''||t.indexval||'',计量单位：''||t.meterunit||'';'' wellformed)
    order by 1).getclobval() as perfindex
FROM PM_PERF_INDICATOR t where t.yearflag = ''0'' and t.is_deleted = ''2'' and t.is_backup=2 and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-1)
 and t.goalguid is not null GROUP BY pro_code,province,year';

--AI辅助审核用的指标视图
--上年度指标聚合视图 V_PM_PERF_INDICATORAGGLAST
execute immediate '
create or replace view V_PM_PERF_INDICATORAGGLAST as
select pro_code,province,year, xmlagg(xmlparse(content ''指标编码：''||t.code||'',指标名称：''||t.name||'',运算符号：''||(select a.name
             from v_perf_enum a where a.elementcode = ''PMKPIZBXS'' and a.code = t.computesign)||'',指标值：''||t.indexval||'',计量单位：''||t.meterunit||'';'' wellformed)
    order by 1).getclobval() as perfindex
FROM PM_PERF_INDICATOR t where t.yearflag = ''0'' and t.is_deleted = ''2'' and t.is_backup=2 and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-1)
 GROUP BY pro_code,province,year';

--前年自评指标聚合视图 V_PM_PERF_EVALINDEXAGGLAST
execute immediate '
create or replace view V_PM_PERF_EVALINDEXAGGLAST as
select pro_code,province,year, xmlagg(xmlparse(content ''指标编码：''||t.code||'',指标名称：''||t.name||'',运算符号：''||(select a.name
             from v_perf_enum a where a.elementcode = ''PMKPIZBXS'' and a.code = t.computesign)||'',指标值：''||t.actualvalue||'',计量单位：''||t.meterunit||'';'' wellformed)
    order by 1).getclobval() as perfindex
FROM perf_t_selfperfindex t where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = (global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')-2)
and is_deleted = ''2'' GROUP BY pro_code,province,year';