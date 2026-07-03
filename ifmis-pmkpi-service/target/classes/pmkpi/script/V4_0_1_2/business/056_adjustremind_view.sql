BEGIN
--1.–ﬁ∏ƒ ”Õº-v_perf_adjustremind
execute immediate '
create or replace view v_perf_adjustremind as
select f.PROGUID,f.PRO_CODE,f.PRO_NAME,f.PRO_CAT_CODE,f.AGENCY_CODE,f.MOF_DEP_CODE,f.FININTORGGUID,f.DEPT_CODE,f.MANAGE_DEPT_CODE,f.MANAGE_MOF_DEP_CODE,f.TRAOBJ_AGENCY_CODE,f.CEN_TRA_PRO_CODE,f.PRO_SOURCE_CODE,f.SETUP_YEAR,f.PRO_START_YEAR,f.PRO_TERM,f.DISTRI_TYPE_CODE,f.DRAFT_TEMPLATE_CODE,f.PRO_DESC,f.EXP_FUNC_CODE,f.PRO_TOTAL_AMT,f.SCOI_INVEST_FUND,f.FUN_RES_CODE,f.IS_USESET,f.IS_TRACK,f.IS_END,f.IS_CAPTIAL_CONS_PRO,f.IS_SCIENTIFIC,f.PRO_DEPREVIEW,f.PRO_BGTREVIEW,f.DEP_AUD_OPINION_CODE,f.MOF_AUD_OPINION_CODE,f.CREATE_TIME,f.UPDATE_TIME,f.VERSION,f.VERSION_NAME,f.IS_DELETED,f.MOF_DIV_CODE,f.LASTAUDIT,f.STORE_PHASE,f.PRO_PHASE,f.PRO_LEVONE_ID,f.PRO_LEVONE_CODE,f.PRO_LEVONE_NAME,f.PRO_LEV,f.LEADER_NAME,f.LEADER_TEL,f.LEADER_PHONE,f.IS_PERFORM,f.IS_ATTACH,f.IS_GOVPUR,f.IS_BGT,f.IS_THIN,f.IS_OTHER_EDIT,f.IS_WAIT_DIVIDE,f.IS_DIVIDE_PRO,f.IS_TO_DOWN,f.MID_PLAN_YEAR,f.ORDERNO1,f.ORDERNO2,f.ORDERNO3,f.ORDERNO4,f.VCHTYPEID,f.V_COL1,f.V_COL2,f.V_COL3,f.V_COL4,f.V_COL5,f.V_COL6,f.V_COL7,f.V_COL8,f.V_COL9,f.V_COL10,f.V_COL11,f.V_COL12,f.V_COL13,f.V_COL14,f.V_COL15,f.V_COL16,f.V_COL17,f.V_COL18,f.V_COL19,f.V_COL20,f.V_COL21,f.V_COL22,f.V_COL23,f.V_COL24,f.V_COL25,f.V_COL26,f.V_COL27,f.V_COL28,f.V_COL29,f.V_COL30,f.N_COL1,f.N_COL2,f.N_COL3,f.N_COL4,f.N_COL5,f.N_COL6,f.N_COL7,f.N_COL8,f.YEAR,f.ADJSTATUS,f.FROMGUID,f.ISHISTORY,f.ISPUBLISH,f.AGENCYGUID,f.PROVINCE,f.PROJECTKIND,t.GUID,f.WFSTATUS,f.WFID,f.ADJUSTNUM,f.ISLAST,p.status,t.ISJK,t.AMT1
from (select '''' as guid, pro.guid as proguid, '''' as ISJK, NULL as AMT1 from V_PERF_FUND_PROJECT v left join v_perf_project_info pro on pro.pro_code = v.pro_code union all
        select guid, proguid, ISJK, AMT1 from v_perf_t_pushremind ) t
  left join (select t.*, a.GUID, a.WFSTATUS, a.WFID, a.ADJUSTNUM, a.ISLAST
             from v_perf_project_infoquery t
             left join (select * from v_perf_t_adjust where islast = ''1'') a on a.PROGUID = t.proguid) f on t.proguid = f.proguid
  left join v_perf_t_adjustremind p on t.proguid = p.PROJGUID and t.guid = p.mainguid
';