
i number(9);
begin 
  
  select count(1) into i from user_tab_cols where table_name = upper('PERF_T_REVIEW') and column_name = upper('PRO_CODE');
if i = 0 then
     execute immediate 'alter table PERF_T_REVIEW add PRO_CODE varchar2(40)';
  end if;
  
execute immediate '
create or replace view v_perf_t_review as
select *
from PERF_T_REVIEW where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate 'CREATE OR REPLACE VIEW V_PERF_PRO_INFOREVIEW AS
select t.*,
       a.FOPINION,
       a.SOPINION,
       a.REMARK,
       a.CONCLUSION,
       b.freviewname,
       b.sreviewname
 from (select m.PRO_ID as proguid,
       m.PRO_CODE,
       m.PRO_NAME,
       m.PRO_CAT_CODE,
       m.AGENCY_CODE,
       m.MOF_DEP_CODE,
       m.FININTORGGUID,
       m.DEPT_CODE,
       m.MANAGE_DEPT_CODE,
       m.MANAGE_MOF_DEP_CODE,
       m.TRAOBJ_AGENCY_CODE,
       m.CEN_TRA_PRO_CODE,
       m.PRO_SOURCE_CODE,
       m.SETUP_YEAR,
       m.PRO_START_YEAR,
       m.PRO_TERM,
       m.DISTRI_TYPE_CODE,
       m.DRAFT_TEMPLATE_CODE,
       m.PRO_DESC,
       m.EXP_FUNC_CODE,
       m.PRO_TOTAL_AMT,
       m.SCOI_INVEST_FUND,
       m.FUN_RES_CODE,
       m.IS_USESET,
       m.IS_TRACK,
       m.IS_END,
       m.IS_CAPTIAL_CONS_PRO,
       m.IS_SCIENTIFIC,
       m.PRO_DEPREVIEW,
       m.PRO_BGTREVIEW,
       m.DEP_AUD_OPINION_CODE,
       m.MOF_AUD_OPINION_CODE,
       m.CREATE_TIME,
       m.UPDATE_TIME,
       m.VERSION,
       m.VERSION_NAME,
       m.IS_DELETED,
       m.MOF_DIV_CODE,
       m.LASTAUDIT,
       m.STORE_PHASE,
       m.PRO_PHASE,
       m.PRO_LEVONE_ID,
       m.PRO_LEVONE_CODE,
       m.PRO_LEVONE_NAME,
       m.PRO_LEV,
       m.LEADER_NAME,
       m.LEADER_TEL,
       m.LEADER_PHONE,
       m.IS_PERFORM,
       m.IS_ATTACH,
       m.IS_GOVPUR,
       m.IS_BGT,
       m.IS_THIN,
       m.IS_OTHER_EDIT,
       m.IS_WAIT_DIVIDE,
       m.IS_DIVIDE_PRO,
       m.IS_TO_DOWN,
       m.MID_PLAN_YEAR,
       m.VCHTYPEID,
       m.CREATER,
       m.PROVINCE,
       m.YEAR,
       m.ADJSTATUS,
       m.FROMGUID,
       m.ISHISTORY,
       m.ISPUBLISH,
       m.AGENCYGUID,
       m.PROJECTKIND,
       t.GUID,
       t.ISRECHECK,
       t.TYPE,
       t.AUDITOR,
       t.LASTUPDATETIME,
       t.CREATETIME,
       t.UPDATETIME,
       t.WFSTATUS,
       t.WFID,
       t.STATUS,
       t.EXPERT,
       t.INSTITUTION,
       t.ISLAST,
       t.REVIEWNUM,
       t.ISCONFIRM
  from v_perf_t_review t
  ,v_perf_project_info m
where t.PRO_CODE = m.PRO_CODE and t.ISLAST=1) t
left join v_perf_t_auditmain a on a.mainguid=t.guid
left join (select c.*,e.name as freviewname,f.name as sreviewname from perf_t_audititems c 
left join v_perf_enum e on e.guid=c.freview
left join v_perf_enum f on f.guid=c.sreview
 where exists(select 1 from v_perf_t_reviewtemp d where d.name=''综合评定'' and d.guid=c.tempguid))b on b.mainguid=t.guid';
 
 
execute immediate 'CREATE OR REPLACE VIEW V_PERF_DEPT_INFOREVIEW AS
select t.*,
       a.FOPINION,
       a.SOPINION,
       a.REMARK,
       a.CONCLUSION,
       b.freviewname,
       b.sreviewname
 from (select m.GUID as PROGUID,
       m.NAME,
       m.CODE,
       m.LINKMAN,
       m.TELEPHONE,
       m.GIST,
       m.FUNCDESC,
       m.AGENCYGUID,
       m.STATUS,
       m.CREATETIME,
       m.UPDATETIME,
       m.CREATER,
       m.PROVINCE,
       m.YEAR,
       m.ORDERNUM,
       m.FININTORGGUID,
       m.AUDITOR,
       m.LASTUPDATETIME,
       m.SUBAGENCYNUM,
       m.THEJOBNUM,
       m.STAFFNUM,
       m.INSTITUTIONSNUM,
       m.FUNCTION,
       m.PERFGOAL,
       m.BUDGETTOTAL,
       m.FINANCIALFUND,
       m.OTHERFUND,
       m.BASICEXPEND,
       m.THREEPUBLICFUND,
       m.SPECIALFUND,
       m.BUDGETAMT,
       m.GOVEFUNCAMT,
       m.TAXRANAMT,
       m.PROJEXPAMT,
       m.GOVTFUNDS,
       m.OTHERFUNDS,
       m.STATECAPITALBUDGET,
       m.PUBBUDGET,
       m.SUMFUNDS,
       t.GUID,
       t.ISRECHECK,
       t.TYPE,
       t.WFSTATUS,
       t.WFID,
       t.ISCONFIRM
  from v_perf_t_review t, v_perf_t_deptperfdeclare m
where t.PROGUID = m.GUID and t.ISLAST=1) t
left join v_perf_t_auditmain a on a.mainguid=t.guid
left join (select c.*,e.name as freviewname,f.name as sreviewname from perf_t_audititems c 
left join v_perf_enum e on e.guid=c.freview
left join v_perf_enum f on f.guid=c.sreview
 where exists(select 1 from v_perf_t_reviewtemp d where d.name=''综合评定'' and d.guid=c.tempguid))b on b.mainguid=t.guid';

delete from bus_t_diccolumn t where t.tablecode='PERF_T_REVIEW' and t.dbcolumncode in('PRO_CODE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_CODE', '1', '2020', '87', 'CA498B116C1F6372E0533315A8C0E634', 'PRO_CODE', 'PERF_T_REVIEW', '项目编码', 'S', '40', null, null, 1, null, sysdate);
