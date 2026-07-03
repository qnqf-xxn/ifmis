  i number(9);
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_HBPROMONITOR';
  if i=0 then
     execute immediate '
      create table PERF_T_HBPROMONITOR
      (
        guid           VARCHAR2(40) not null,
        name           VARCHAR2(200),
        taskguid       VARCHAR2(40),
        proguid        VARCHAR2(40),
        depttask       VARCHAR2(40),
        provincetask   VARCHAR2(40),
        bgtwarn        VARCHAR2(40),
        goalwarn       VARCHAR2(40),
        islast         NUMBER(1),
        tracenum       NUMBER(1),
        tracestatus    NUMBER(1),
        status         NUMBER(1),
        agencyguid     VARCHAR2(40),
        agency_code    VARCHAR2(40),
        creater        VARCHAR2(40),
        create_time    VARCHAR2(17),
        update_time    VARCHAR2(17),
        is_deleted     NUMBER(1),
        fiscal_year    VARCHAR2(4) not null,
        mof_div_code   VARCHAR2(9) not null,
        year           VARCHAR2(4) not null,
        province       VARCHAR2(9) not null,
        wfstatus       VARCHAR2(40),
        auditor        VARCHAR2(32),
        lastupdatetime VARCHAR2(17) default to_char(sysdate,''yyyyMMddHH24miss''),
        finintorgguid  VARCHAR2(40),
        wfid           VARCHAR2(40),
        construction   VARCHAR2(4000),
        promanagement  VARCHAR2(4000),
        finmanagement  VARCHAR2(4000),
        audittype      VARCHAR2(40),
        deviate        VARCHAR2(40),
        gzdeviate      VARCHAR2(40),
        gzfunddeviate  VARCHAR2(40),
        mainguid       VARCHAR2(40)
      )
      ';
    execute immediate 'alter table PERF_T_HBPROMONITOR
  add constraint PK_PERF_HBPROMONITOR primary key (GUID, PROVINCE, YEAR)
  using index';
  end if;
  
  execute immediate 'create or replace view v_perf_t_hbpromonitor as 
select * from perf_t_HBpromonitor t
 where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
  
  execute immediate 'create or replace view perf_v_hbpromonitor as
select t.GUID,
       t.NAME,
       t.TASKGUID,
       t.PROGUID,
       t.DEPTTASK,
       t.PROVINCETASK,
       t.BGTWARN,
       t.GOALWARN,
       t.ISLAST,
       t.TRACENUM,
       t.TRACESTATUS,
       t.STATUS,
       t.AGENCYGUID,
       t.AGENCY_CODE,
       t.CREATER,
       t.CREATE_TIME,
       t.UPDATE_TIME,
       t.IS_DELETED,
       t.FISCAL_YEAR,
       t.MOF_DIV_CODE,
       t.YEAR,
       t.PROVINCE,
       t.WFSTATUS,
       t.AUDITOR,
       t.LASTUPDATETIME,
       t.FININTORGGUID,
       t.WFID,
       t.CONSTRUCTION,
       t.PROMANAGEMENT,
       t.FINMANAGEMENT,
       t.AUDITTYPE,
       case
         when to_number(to_date(b.enddate, ''yyyymmdd'') -
                        to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) >
              to_number(b.warndays) then
          ''black''
         when to_number(to_date(b.enddate, ''yyyymmdd'') -
                        to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <=
              to_number(b.warndays) then
          ''red''
         when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >
              to_date(b.enddate, ''yyyymmdd'') then
          ''000''
       end warn,
       to_date(b.enddate, ''yyyymmdd'') -
       to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') warndays,
       t.update_time updatetime,
       a.pro_code,
       a.pro_name,
       b.taskstage,
       b.startdate,
       b.enddate,
       b.tasktype,
       b.bustype
  from v_PERF_T_HBPROMONITOR t
  left join v_perf_project_info a
    on t.proguid = a.guid
  left join v_perf_t_taskset b
    on b.guid = t.taskguid
 where to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >
       to_date(b.startdate, ''yyyymmdd'') - 1';
