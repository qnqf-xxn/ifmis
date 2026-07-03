  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--结转表
select count(*) into i from user_tables t where t.table_name ='PERF_PROJECT_CARRYOVER';
if i=0 then
execute immediate '
create table PERF_PROJECT_CARRYOVER
(
  guid              VARCHAR2(40) not null,
  province          VARCHAR2(9) not null,
  year              VARCHAR2(4) not null,
  pro_id			VARCHAR2(40) not null,
  pro_code          VARCHAR2(21) not null,
  pro_name          VARCHAR2(180) not null,
  agencyguid        VARCHAR2(21),
  agency_code       VARCHAR2(21),
  finintorgguid     VARCHAR2(6),
  pro_total_amt     NUMBER(20,2),
  bgt_amt           NUMBER(20,2),
  projectkind       VARCHAR2(32),
  isreport_lastyear VARCHAR2(40),
  isreport_nowyear  VARCHAR2(40),
  is_deleted        VARCHAR2(40) not null,
  create_time       VARCHAR2(14) not null,
  update_time       VARCHAR2(14) not null,
  creater           VARCHAR2(40),
  bustype           VARCHAR2(40)
)';
end if;

--添加索引
select count(1) into i from user_indexes t where t.index_name = 'IDX_PERFCARRYOVER_PROCODE';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_PERFCARRYOVER_PROCODE ON PERF_PROJECT_CARRYOVER(PRO_CODE)';
end if; 

v_sql :='
create or replace view V_PERF_PROJECT_CARRYOVER as
select * from PERF_PROJECT_CARRYOVER
WHERE province = global_multyear_cz.v_pmdivid AND year = global_multyear_cz.v_pmyear and is_deleted = 2';
select fn_alterview('V_PERF_PROJECT_CARRYOVER',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--待结转视图 根据实际情况自行修改来源视图t或者拼接条件
v_sql :='
create or replace view V_PERF_PROJECT_CARRYOVER_CHECK as
SELECT DISTINCT
    t.guid,
    t.pro_id,
    t.pro_code,
    t.pro_name,
    t.agencyguid,
    t.agency_code,
    t.finintorgguid,
    t.pro_total_amt,
    '''' as bgt_amt,
    t.projectkind,
    CASE WHEN g_last_year.guid IS NOT NULL THEN ''1'' ELSE ''2'' END as isreport_lastyear,
    CASE WHEN g_curr_year.guid IS NOT NULL THEN ''1'' ELSE ''2'' END as isreport_nowyear,
    ''program'' as bustype,
    2 as is_deleted,
    '''' as update_time,
    '''' as creater,
    '''' as create_time,
    global_multyear_cz.v_pmyear as year,
    t.province
FROM v_perf_project_info t
LEFT JOIN (
    SELECT pro_code, province, MIN(guid) as guid
    FROM PM_PERF_GOAL_INFO 
    WHERE yearflag = ''0'' 
    AND is_deleted = 2 
	AND is_backup = 2
	AND sub_mof_div_code is null
    AND year = global_multyear_cz.v_pmyear - 1
    GROUP BY pro_code, province
) g_last_year ON g_last_year.pro_code = t.pro_code AND g_last_year.province = t.province
LEFT JOIN (
    SELECT pro_code, province, MIN(guid) as guid
    FROM PM_PERF_GOAL_INFO
    WHERE yearflag = ''0''
    AND is_deleted = 2
	AND is_backup = 2
	AND sub_mof_div_code is null
    AND year = global_multyear_cz.v_pmyear
    GROUP BY pro_code, province
) g_curr_year ON g_curr_year.pro_code = t.pro_code AND g_curr_year.province = t.province
WHERE NOT EXISTS (
    SELECT 1 
    FROM V_PERF_PROJECT_CARRYOVER a 
    WHERE t.pro_code = a.pro_code
)';
select fn_alterview('V_PERF_PROJECT_CARRYOVER_CHECK',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;