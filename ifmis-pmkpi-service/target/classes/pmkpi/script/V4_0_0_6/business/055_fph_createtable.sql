
  i integer;
begin
  --评审表
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_T_REVIEW';
  if i=0 then
     execute immediate '
     create table PERF_T_REVIEW
      (
        guid           VARCHAR2(40) not null,
        proguid        VARCHAR2(40),
        isrecheck      VARCHAR2(40),
        type           VARCHAR2(40),
        conclusion     VARCHAR2(40),
        auditor        VARCHAR2(40),
        lastupdatetime VARCHAR2(20),
        agencyguid     VARCHAR2(40),
        finintorgguid  VARCHAR2(50),
        creater        VARCHAR2(32),
        createtime     VARCHAR2(20),
        updatetime     VARCHAR2(20),
        wfstatus       VARCHAR2(50),
        wfid           VARCHAR2(100),
        status         NUMBER(1),
        province       VARCHAR2(9) not null,
        year           CHAR(4) not null,
        expert         VARCHAR2(40),
        institution    VARCHAR2(40),
        islast         CHAR(1) default 0,
        reviewnum      VARCHAR2(100),
        isconfirm      CHAR(1) default 0
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';
      execute immediate'alter table PERF_T_REVIEW 
      add constraint PK_PERF_T_REVIEW primary key (GUID,PROVINCE,YEAR) using index ';
    execute immediate 'create or replace view V_PERF_T_REVIEW as 
      select * FROM PERF_T_REVIEW T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'') 
      and T.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      ';
end if;

  --评审模板表
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_T_REVIEWTEMP';
  if i=0 then
     execute immediate '
     create table PERF_T_REVIEWTEMP
      (
        guid       VARCHAR2(40) not null,
        name       VARCHAR2(100),
        context    VARCHAR2(1000),
        ordernum   NUMBER(9),
        agencyguid VARCHAR2(40),
        status     NUMBER(1),
        createtime VARCHAR2(17) not null,
        updatetime VARCHAR2(17),
        creater    VARCHAR2(40) not null,
        province   VARCHAR2(40) not null,
        year       NUMBER(4) not null
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';
      execute immediate'alter table PERF_T_REVIEWTEMP 
      add constraint PK_PERF_T_REVIEWTEMP primary key (GUID,PROVINCE,YEAR) using index ';
    execute immediate 'create or replace view V_PERF_T_REVIEWTEMP as 
      select * FROM PERF_T_REVIEWTEMP T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'') 
      and T.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      ';
end if;


  --评审专家关联表
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PERF_EXPERTREVIEW';
  if i=0 then
     execute immediate '
     create table PERF_EXPERTREVIEW
      (
        guid       VARCHAR2(40) not null,
        code       VARCHAR2(100),
        name       VARCHAR2(200),
        status     CHAR(1),
        creater    VARCHAR2(40),
        createtime VARCHAR2(17),
        updatetime VARCHAR2(17),
        year       CHAR(4) not null,
        province   VARCHAR2(9) not null,
        ordernum   NUMBER(9),
        proguid    VARCHAR2(40),
        mainguid   VARCHAR2(40),
        expertguid VARCHAR2(40),
        isgroup    VARCHAR2(40)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';
      execute immediate'alter table PERF_EXPERTREVIEW 
      add constraint PK_PERF_EXPERTREVIEW primary key (GUID,PROVINCE,YEAR) using index ';
    execute immediate 'create or replace view V_PERF_EXPERTREVIEW as 
      select * FROM PERF_EXPERTREVIEW T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'') 
      and T.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      ';
end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITMAIN' and t.column_name='PROGUID';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITMAIN add PROGUID VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITMAIN' and t.column_name='FOPINION';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITMAIN add FOPINION VARCHAR2(4000)';
     end if;
     
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITMAIN' and t.column_name='SOPINION';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITMAIN add SOPINION VARCHAR2(4000)';
     end if;
     
     
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITITEMS' and t.column_name='PROGUID';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITITEMS add PROGUID VARCHAR2(40)';
     end if;

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITITEMS' and t.column_name='FREVIEW';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITITEMS add FREVIEW VARCHAR2(40)';
     end if;
     
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_AUDITITEMS' and t.column_name='SREVIEW';
     if i=0 then
       execute immediate 'alter table PERF_T_AUDITITEMS add SREVIEW VARCHAR2(40)';
     end if;


    execute immediate 'CREATE OR REPLACE VIEW V_PERF_PRO_INFOREVIEW AS
    select m."PRO_ID" as proguid,
       m."PRO_CODE",
       m."PRO_NAME",
       m."PRO_CAT_CODE",
       m."AGENCY_CODE",
       m."MOF_DEP_CODE" as FININTORGGUID,
       m."DEPT_CODE",
       m."MANAGE_DEPT_CODE",
       m."MANAGE_MOF_DEP_CODE",
       m."TRAOBJ_AGENCY_CODE",
       m."CEN_TRA_PRO_CODE",
       m."PRO_SOURCE_CODE",
       m."SETUP_YEAR",
       m."PRO_START_YEAR",
       m."PRO_TERM",
       m."DISTRI_TYPE_CODE",
       m."DRAFT_TEMPLATE_CODE",
       m."PRO_DESC",
       m."EXP_FUNC_CODE",
       m."PRO_TOTAL_AMT",
       m."SCOI_INVEST_FUND",
       m."FUN_RES_CODE",
       m."IS_USESET",
       m."IS_TRACK",
       m."IS_END",
       m."IS_CAPTIAL_CONS_PRO",
       m."IS_SCIENTIFIC",
       m."PRO_DEPREVIEW",
       m."PRO_BGTREVIEW",
       m."DEP_AUD_OPINION_CODE",
       m."MOF_AUD_OPINION_CODE",
       m."CREATE_TIME",
       m."UPDATE_TIME",
       m."VERSION",
       m."VERSION_NAME",
       m."IS_DELETED",
       m."MOF_DIV_CODE",
       m."LASTAUDIT",
       m."STORE_PHASE",
       m."PRO_PHASE",
       m."PRO_LEVONE_ID",
       m."PRO_LEVONE_CODE",
       m."PRO_LEVONE_NAME",
       m."PRO_LEV",
       m."LEADER_NAME",
       m."LEADER_TEL",
       m."LEADER_PHONE",
       m."IS_PERFORM",
       m."IS_ATTACH",
       m."IS_GOVPUR",
       m."IS_BGT",
       m."IS_THIN",
       m."IS_OTHER_EDIT",
       m."IS_WAIT_DIVIDE",
       m."IS_DIVIDE_PRO",
       m."IS_TO_DOWN",
       m."MID_PLAN_YEAR",
       m."VCHTYPEID",
       m."CREATER",
       m."PROVINCE",
       m."YEAR",
       m."ADJSTATUS",
       m."FROMGUID",
       m."ISHISTORY",
       m."ISPUBLISH",
       m."AGENCYGUID",
       m."PROJECTKIND",
       t."GUID",
       t."ISRECHECK",
       t."TYPE",
       t."CONCLUSION",
       t."AUDITOR",
       t."LASTUPDATETIME",
       t."CREATETIME",
       t."UPDATETIME",
       t."WFSTATUS",
       t."WFID",
       t."STATUS",
       t."EXPERT",
       t."INSTITUTION",
       t."ISLAST",
       t."REVIEWNUM",
       t.ISCONFIRM
  from (SELECT * FROM  v_perf_t_review t where  ISLAST=1) t ,  v_perf_project_info m
where t.PROGUID = m.PRO_ID';
      
    execute immediate 'create or replace view v_perf_dept_inforeview as
select m."GUID" as PROGUID,
       m."NAME",
       m."CODE",
       m."LINKMAN",
       m."TELEPHONE",
       m."GIST",
       m."FUNCDESC",
       m."AGENCYGUID",
       m."STATUS",
       m."CREATETIME",
       m."UPDATETIME",
       m."CREATER",
       m."PROVINCE",
       m."YEAR",
       m."ORDERNUM",
       m."FININTORGGUID",
       m."AUDITOR",
       m."LASTUPDATETIME",
       m."SUBAGENCYNUM",
       m."THEJOBNUM",
       m."STAFFNUM",
       m."INSTITUTIONSNUM",
       m."FUNCTION",
       m."PERFGOAL",
       m."BUDGETTOTAL",
       m."FINANCIALFUND",
       m."OTHERFUND",
       m."BASICEXPEND",
       m."THREEPUBLICFUND",
       m."SPECIALFUND",
       m."BUDGETAMT",
       m."GOVEFUNCAMT",
       m."TAXRANAMT",
       m."PROJEXPAMT",
       m."GOVTFUNDS",
       m."OTHERFUNDS",
       m."STATECAPITALBUDGET",
       m."PUBBUDGET",
       m."SUMFUNDS",
       t."GUID",
       t."ISRECHECK",
       t."TYPE",
       t."CONCLUSION",
       t."WFSTATUS",
       t."WFID",
       t.ISCONFIRM
  from (SELECT * FROM  v_perf_t_review t where  ISLAST=1) t , v_perf_t_deptperfdeclare m   
where t.PROGUID = m.GUID';

