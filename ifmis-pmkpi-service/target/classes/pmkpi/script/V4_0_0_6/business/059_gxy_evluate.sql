begin

execute immediate 'declare
   num number(2);
begin
   select count(*) INTO num from user_tables where table_name = ''PERF_REVIEWINTERMEDIARY'';
   if num = 1 then
      execute immediate ''drop table PERF_REVIEWINTERMEDIARY cascade constraints'';
   end if;
end;   
';

execute immediate '
create table PERF_REVIEWINTERMEDIARY
(
  GUID           VARCHAR2(40) not null,
  REVIEW         VARCHAR2(40),
  INTERMEDIARY   VARCHAR2(40),
  PROVINCE       VARCHAR2(32) not null,
  YEAR           NUMBER(4) not null
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

execute immediate '
create or replace view v_perf_t_projreview as
select
       t.PRO_ID,t.PRO_CODE,t.PRO_NAME,t.PRO_CAT_CODE,t.AGENCY_CODE,t.MOF_DEP_CODE,t1.FININTORGGUID FININTORGGUID,t.DEPT_CODE,
       t.MANAGE_DEPT_CODE,t.MANAGE_MOF_DEP_CODE,t.TRAOBJ_AGENCY_CODE,t.CEN_TRA_PRO_CODE,t.PRO_SOURCE_CODE,t.SETUP_YEAR,
       t.PRO_START_YEAR,t.PRO_TERM,t.DISTRI_TYPE_CODE,t.DRAFT_TEMPLATE_CODE,t.PRO_DESC,t.EXP_FUNC_CODE,t.PRO_TOTAL_AMT,
       t.SCOI_INVEST_FUND,t.FUN_RES_CODE,t.IS_USESET,t.IS_TRACK,t.IS_END,t.IS_CAPTIAL_CONS_PRO,t.IS_SCIENTIFIC,t.PRO_DEPREVIEW,
       t.PRO_BGTREVIEW,t.DEP_AUD_OPINION_CODE,t.MOF_AUD_OPINION_CODE,SUBSTR(t.CREATE_TIME,0,4) CREATE_TIME,SUBSTR(t.UPDATE_TIME,0,4) UPDATE_TIME,t.VERSION,t.VERSION_NAME,
       t.IS_DELETED,t1.GUID,t.MOF_DIV_CODE,t.LASTAUDIT,t.STORE_PHASE,t.PRO_PHASE,t.PRO_LEVONE_ID,t.PRO_LEVONE_CODE,t.PRO_LEVONE_NAME,
       t.PRO_LEV,t.LEADER_NAME,t.LEADER_TEL,t.LEADER_PHONE,t.IS_PERFORM,t.IS_ATTACH,t.IS_GOVPUR,t.IS_BGT,t.IS_THIN,t.IS_OTHER_EDIT,
       t.IS_WAIT_DIVIDE,t.IS_DIVIDE_PRO,t.IS_TO_DOWN,t.MID_PLAN_YEAR,t.ORDERNO1,t.ORDERNO2,t.ORDERNO3,t.ORDERNO4,t.VCHTYPEID,
       t1.WFSTATUS WFSTATUS,t1.WFID,t.CREATER,t.LASTUPDATETIME,t1.AUDITOR,t.V_COL1,t.V_COL2,t.V_COL3,t.V_COL4,t.V_COL5,t.V_COL6,t.V_COL7,
       t.V_COL8,t.V_COL9,t.V_COL10,t.V_COL11,t.V_COL12,t.V_COL13,t.V_COL14,t.V_COL15,t.V_COL16,t.V_COL17,t.V_COL18,t.V_COL19,
       t.V_COL20,t.V_COL21,t.V_COL22,t.V_COL23,t.V_COL24,t.V_COL25,t.V_COL26,t.V_COL27,t.V_COL28,t.V_COL29,t.V_COL30,t.N_COL1,
       t.N_COL2,t.N_COL3,t.N_COL4,t.N_COL5,t.N_COL6,t.N_COL7,t.N_COL8,t.PROVINCE,t1.YEAR YEAR,t.ADJSTATUS,t.FROMGUID,t.ISHISTORY,
       t.ISPUBLISH,t.AGENCYGUID,t.PROJECTKIND,
       t1.CONCLUSION,t1.PROGUID,t1.type
from V_PERF_PROJECT_INFO t
left join V_PERF_T_REVIEW t1 on t1.PROGUID = t.guid
';


execute immediate 'declare
   num number(2);
begin
   select count(*) INTO num from user_tables where table_name = ''PERF_PREEVALUATE_OPINION'';
   if num = 1 then
      execute immediate ''drop table PERF_PREEVALUATE_OPINION cascade constraints'';
   end if;
end;   
';

execute immediate '
create table PERF_PREEVALUATE_OPINION
(
  GUID           VARCHAR2(40) not null,
  CONTENT        VARCHAR2(4000),
  MAINGUID	     VARCHAR2(40),
  CREATER		 VARCHAR2(40),
  CREATETIME     VARCHAR2(17),
  UPDATETIME     VARCHAR2(17),
  PROVINCE       VARCHAR2(32) not null,
  YEAR           NUMBER(4) not null,
  PRECONTENT	 VARCHAR2(4000),
  TYPE	         VARCHAR2(40)
)
partition by list (PROVINCE)
subpartition by list (YEAR)
(
  partition P87 values (''87'')
    pctfree 10
    initrans 1
    maxtrans 255
  (
    subpartition P87_Y2016 values (''2016'')
  )
)';

