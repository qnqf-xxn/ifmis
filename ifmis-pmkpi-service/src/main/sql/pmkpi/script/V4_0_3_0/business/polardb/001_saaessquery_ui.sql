begin

update p#busfw_t_uiqueryform set isvisiable = '0' where key = '/pmkpi/assess/query' and columncode = 'WFSTATUS';

execute immediate '
CREATE OR REPLACE VIEW bgt_330000.V_PERF_PROJECT_INFOASSESS
AS 
select 
t.pro_id,
    t.pro_code,
    t.pro_name,
    t.pro_cat_code,
    t2.name as agency_code,
    t.mof_dep_code,
    t.dept_code,
    t.manage_dept_code,
    t.manage_mof_dep_code,
    t.create_time,
    t.update_time,
    t.is_deleted,
    t.guid,
    t.mof_div_code,
    t.pro_levone_id,
    t.pro_levone_code,
    t.pro_levone_name,
    t.pro_lev,
    t1.name as wfstatus,
    t.wfid,
    t.creater,
    t.lastupdatetime,
    t.auditor,
    t.province,
    t.year,
    t.ishistory,
    t.agencyguid,
    t.projectkind,
    t.sub_mof_div_code,
    t3.name as finintorgguid,
	t.v_col12
from V_PERF_PROJECT_INFO t 
left join FASP_T_PUBWFSTATUS t1 on t.WFSTATUS = t1.code
left join pmkpi_fasp_t_pubagency t2 on t.AGENCY_CODE = t2.code
left join V_ELE_VC01004 t3 on t.FININTORGGUID = t3.code';