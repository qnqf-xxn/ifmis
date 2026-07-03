num number(9);
begin 
  select count(1) into num from user_tab_cols where table_name = upper('PERF_T_SUPERVISION') and column_name = upper('ISADJ');
  if num = 0 then
     execute immediate 'alter table PERF_T_SUPERVISION  ADD ISADJ varchar2(2) default 0';
  end if;
  select count(1) into num from user_tab_cols where table_name = upper('PERF_T_SUPERVISION') and column_name = upper('ISADD');
  if num = 0 then
     execute immediate 'alter table PERF_T_SUPERVISION  ADD ISADD varchar2(2)';
  end if;
  select count(1) into num from user_tab_cols where table_name = upper('PERF_T_SUPERVISION') and column_name = upper('taskguid');
  if num = 0 then
     execute immediate 'alter table PERF_T_SUPERVISION  ADD taskguid varchar2(40)';
  end if;
  select count(1) into num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('is_add');
  if num = 0 then
     execute immediate 'alter table PM_PERF_INDICATOR  ADD is_add varchar2(2)';
  end if;

execute immediate '
create or replace view v_pm_perf_indicator as
select * from PM_PERF_INDICATOR
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and is_deleted = 2';


execute immediate '
create or replace view v_perf_t_supervision as
select * from PERF_T_SUPERVISION
where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';

execute immediate '
CREATE OR REPLACE VIEW v_perf_t_supervisionview
 AS
 SELECT t.guid,
    t.mainguid,
    t.wfid,
    t.auditor,
    t.status,
    t.createtime,
    t.updatetime,
    t.creater,
    t.province,
    t.year,
    t.options,
    t.protype,
    t.indexguid,
    t.lastupdatetime,
    t.wfstatus,
    t1.pro_name AS proname,
    t1.agency_code AS agencyguid,
    t1.finintorgguid AS finintirgguid,
    t1.manage_dept_code AS dept,
    t1.pro_total_amt AS proamt,
    t1.pro_levone_name AS yjproname,
    t1.pro_levone_id AS yjproid,
    t1.pro_levone_code AS yjprocode,
    t2.name AS kpi_lv3,
    t2.weight,
        CASE
            WHEN t.adjoption = ''1'' THEN ''指标不够完整''
            WHEN t.adjoption = ''2'' THEN ''指标不够细化、量化''
            WHEN t.adjoption = ''3'' THEN ''指标与项目的相关性不够''
            WHEN t.adjoption = ''4'' THEN ''指标与指标值不匹配''
            WHEN t.adjoption = ''5'' THEN ''建议拆分指标''
            WHEN t.adjoption = ''6'' THEN ''一级指标类型错误''
            WHEN t.adjoption = ''7'' THEN ''二级指标类型错误''
            WHEN t.adjoption = ''8'' THEN ''建议增加明确效益指标''
            WHEN t.adjoption = ''9'' THEN ''建议增加明确产出指标''
            WHEN t.adjoption = ''10'' THEN ''建议增加满意度指标''
            WHEN t.adjoption = ''11'' THEN ''其他''
            ELSE NULL
        END AS adjoption,
        CASE
            WHEN t2.computesign = 1 THEN ''≥'' || t2.kpi_val || t2.meterunit
            WHEN t2.computesign = 2 THEN ''＞'' || t2.kpi_val || t2.meterunit
            WHEN t2.computesign = 3 THEN ''＝'' || t2.kpi_val || t2.meterunit
            WHEN t2.computesign = 4 THEN ''＜'' || t2.kpi_val || t2.meterunit
            WHEN t2.computesign = 5 THEN ''≤'' || t2.kpi_val || t2.meterunit
            WHEN t2.computesign = 6 THEN t2.kpi_val
            ELSE NULL
        END AS kpi_val,
        CASE
            WHEN t1.v_col12 = ''1'' THEN ''是''
            WHEN t1.v_col12 = ''2'' THEN ''否''
            WHEN t1.v_col12 IS NULL THEN ''否''
            ELSE NULL
        END AS ispereval,
        CASE
            WHEN t2.is_add = ''1'' THEN ''是''
            WHEN t2.is_add = ''0'' THEN ''否''
            ELSE NULL
        END AS addindex,
    t3.name AS wfstatusname,
    t4.name AS agencyname,
    t5.name AS finintirgname,
    t6.name AS deptname,
    t7.name AS kpi_lv1,
    t8.name AS kpi_lv2,
    ''2'' AS is_deleted,
    t.isadj,
    t.taskguid,
    t.isadd
   FROM v_perf_t_supervision t
     LEFT JOIN v_perf_project_info t1 ON t.mainguid = t1.pro_code
     LEFT JOIN v_pm_perf_indicator t2 ON t.indexguid = t2.kpi_id
     LEFT JOIN pmkpi_t_wfstatus t3 ON t.wfstatus = t3.code
     LEFT JOIN pmkpi_fasp_t_pubagency t4 ON t1.agency_code = t4.code
     LEFT JOIN fasp_t_pubdepartment t5 ON t1.manage_mof_dep_code = t5.code
     LEFT JOIN pmkpi_fasp_t_pubagency t6 ON t1.manage_dept_code = t6.code
     LEFT JOIN v_perf_t_frame t7 ON t2.kpi_lv1 = t7.code
     LEFT JOIN v_perf_t_frame t8 ON t2.kpi_lv2 = t8.code';

	 
execute immediate '	 
CREATE OR REPLACE VIEW perf_bgt_supervision
 AS
 SELECT guid,
    mainguid,
    wfid,
    auditor,
    status,
    createtime,
    updatetime,
    creater,
    province,
    year,
    options,
    protype,
    indexguid,
    lastupdatetime,
    wfstatus,
    proname,
    agencyguid,
    finintirgguid,
    dept,
    proamt,
    yjproname,
    yjproid,
    yjprocode,
    kpi_lv3,
    weight,
    adjoption,
    kpi_val,
    ispereval,
    addindex,
    wfstatusname,
    agencyname,
    finintirgname,
    deptname,
    kpi_lv1,
    kpi_lv2,
    is_deleted,
    taskguid
   FROM v_perf_t_supervisionview';
   