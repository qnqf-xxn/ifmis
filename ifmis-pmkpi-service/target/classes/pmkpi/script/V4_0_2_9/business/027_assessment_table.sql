
i number(1);
begin

  select count(1) into i from user_tables t where t.TABLE_NAME='PERF_T_ASSESSMENTOPINION';
  if i=0 then
    execute immediate '
    create table PERF_T_ASSESSMENTOPINION
    (
      guid           VARCHAR2(40) not null,
      mainguid       VARCHAR2(40),
      agencyguid     VARCHAR2(40),
      prorecommended VARCHAR2(4000),
      adjustopinion  VARCHAR2(4000),
      arrangebgt     VARCHAR2(4000),
      createtime     VARCHAR2(17),
      updatetime     VARCHAR2(17) not null,
      creater        VARCHAR2(40),
      province       VARCHAR2(32) not null,
      year           NUMBER(4) not null,
      is_deleted     NUMBER(1),
      pro_code       VARCHAR2(40),
      status         NUMBER(1)
    )';
    execute immediate '
    alter table PERF_T_ASSESSMENTOPINION
      add constraint PK_PERF_ASSESSMENTOPINION primary key (GUID, YEAR, PROVINCE)';
  end if;  

  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENTTEMP' and t.column_name='CREATETIME';
  if i=1 then
     execute immediate 'alter table PERF_T_ASSESSMENTTEMP modify CREATETIME default TO_CHAR(SYSDATE,''YYYYMMDDhh24miss'')';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENTTEMP' and t.column_name='UPDATETIME';
  if i=1 then
     execute immediate 'alter table PERF_T_ASSESSMENTTEMP modify UPDATETIME default TO_CHAR(SYSDATE,''YYYYMMDDhh24miss'')';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENTTEMP' and t.column_name='AGENCYGUID';
  if i=1 then
     execute immediate 'alter table PERF_T_ASSESSMENTTEMP drop column agencyguid';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENTTEMP' and t.column_name='FININTORGGUID';
  if i=1 then
     execute immediate 'alter table PERF_T_ASSESSMENTTEMP drop column finintorgguid';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENT' and t.column_name='FININTORGGUID';
  if i=1 then
     execute immediate 'alter table PERF_T_ASSESSMENT drop column finintorgguid';
  end if;


  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENT' and t.column_name='PRO_CODE';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENT add pro_code varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENT' and t.column_name='IS_DELETED';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENT add IS_DELETED NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENT' and t.column_name='STANDARD';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENT add STANDARD varchar2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_ASSESSMENT' and t.column_name='REMARKS';
  if i=0 then
     execute immediate 'alter table PERF_T_ASSESSMENT add REMARKS varchar2(4000)';
  end if;


execute immediate '
create or replace view v_perf_t_assessmenttemp as
select t.*
  from perf_t_assessmenttemp t
 where province = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';

execute immediate '
create or replace view v_perf_t_assessment as
select t.*
  from perf_t_assessment t
 where t.is_deleted = 2
   and province = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';

execute immediate '
create or replace view v_perf_t_assessmentopinion as
select t.*
  from perf_t_assessmentopinion t
 where t.is_deleted = 2
   and province = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')';
