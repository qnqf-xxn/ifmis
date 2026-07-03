 i number;
begin
   select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_EVALUATION';
  if i=0 then
     execute immediate'
     create table PERF_T_EVALUATION
      (
        guid                VARCHAR2(40) not null,
        proguid             VARCHAR2(40),
        islast              NUMBER(1),
        auditor             VARCHAR2(40),
        lastupdatetime      VARCHAR2(20),
        agencyguid          VARCHAR2(40),
        finintorgguid       VARCHAR2(50),
        creater             VARCHAR2(32),
        createtime          VARCHAR2(20),
        updatetime          VARCHAR2(20),
        wfstatus            VARCHAR2(50),
        wfid                VARCHAR2(100),
        status              NUMBER(1),
        province            VARCHAR2(9) not null,
        year                CHAR(4) not null,
        bustype             VARCHAR2(40),
        pro_code            VARCHAR2(40),
        pro_name            VARCHAR2(200),
        manage_dept_code    VARCHAR2(40),
        manage_mof_dep_code VARCHAR2(40),
        mof_dep_code        VARCHAR2(40),
        dept_code           VARCHAR2(40),
        agency_code         VARCHAR2(40),
        items               VARCHAR2(4000),
        result              VARCHAR2(4000),
        bgtamt              NUMBER(20,2) default 0,
        pro_total_amt       NUMBER(20,2),
        audittype           VARCHAR2(40)
      )';
      
     execute immediate '
      alter table PERF_T_EVALUATION
        add constraint PK_PERF_T_EVALUATION primary key (GUID, YEAR, PROVINCE)';
     
     --÷ÿππ ‘Õº
     execute immediate'
       create or replace view v_perf_t_evaluation as
        select * from PERF_T_EVALUATION
          where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
          PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
   end if;
