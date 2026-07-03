i integer;
begin
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PM_PERF_GOAL_TEMP';
  if i=0 then
     execute immediate '
     create table PM_PERF_GOAL_TEMP
    (
      guid       VARCHAR2(40) not null,
      zqgoal     VARCHAR2(4000),
      ndgoal     VARCHAR2(4000),
      mainguid   VARCHAR2(40),
      createtime VARCHAR2(17),
      updatetime VARCHAR2(17),
      creater    VARCHAR2(40),
      province   VARCHAR2(40),
      year       NUMBER(4),
      pro_code   VARCHAR2(21),
      kpi_target VARCHAR2(2000)
    )';
      execute immediate'create index IND_MAINGUID on PM_PERF_GOAL_TEMP (MAINGUID) ';
    execute immediate 'alter table PM_PERF_GOAL_TEMP
    add constraint PK_PERF_GOALTEMP01 primary key (GUID)
    using index';
    end if;
  select count(*) into i from user_tab_columns  t where t.TABLE_NAME='PM_PERF_INDICATOR_TEMP';
  if i=0 then
     execute immediate '
     create table PM_PERF_INDICATOR_TEMP
    (
      guid          VARCHAR2(40) not null,
      code          VARCHAR2(200),
      explain       VARCHAR2(200),
      weight        NUMBER(5,2),
      islinked      NUMBER(1),
      agencyguid    VARCHAR2(40),
      wfstatus      VARCHAR2(40),
      status        NUMBER(1),
      createtime    VARCHAR2(17),
      updatetime    VARCHAR2(17),
      creater       VARCHAR2(40),
      province      VARCHAR2(32),
      year          NUMBER(4),
      ordernum      NUMBER(9),
      finintorgguid VARCHAR2(40),
      mainguid      VARCHAR2(40),
      superid       VARCHAR2(40),
      levelno       NUMBER(2),
      rule          VARCHAR2(200),
      computesign   VARCHAR2(40),
      meterunit     VARCHAR2(200),
      tindex        VARCHAR2(40),
      wfid          VARCHAR2(40),
      proguid       VARCHAR2(40),
      targetvalue   VARCHAR2(60),
      kpi_id        VARCHAR2(38),
      mof_div_code  VARCHAR2(9),
      fiscal_year   VARCHAR2(4),
      pro_code      VARCHAR2(21),
      kpi_lv1       VARCHAR2(30),
      kpi_lv2       VARCHAR2(30),
      kpi_lv3       VARCHAR2(30),
      kpi_content   VARCHAR2(2000),
      kpi_evalstd   VARCHAR2(2000),
      kpi_val       VARCHAR2(60),
      kpi_remark    VARCHAR2(2000),
      busi_type     VARCHAR2(6),
      version       VARCHAR2(38),
      version_name  VARCHAR2(400),
      sub_mof_code  VARCHAR2(9),
      update_time   VARCHAR2(17),
      is_deleted    NUMBER(1),
      create_time   VARCHAR2(17),
      agency_code   VARCHAR2(38),
      findex        VARCHAR2(30),
      sindex        VARCHAR2(30),
      name          VARCHAR2(80),
      indexval      VARCHAR2(60),
      yearflag      VARCHAR2(9)
    )';

    execute immediate'create index INDX_MAIN_01 on PM_PERF_INDICATOR_TEMP (MAINGUID)';
  end if;
  
  	 
	select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='VALUE_DESC';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add VALUE_DESC VARCHAR2(2000)';
     end if;
	 
	select count(1) into i from user_tab_cols t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='KPIVALSOURCE';
     if i=0 then
       execute immediate 'alter table PM_PERF_INDICATOR_TEMP add KPIVALSOURCE VARCHAR2(40)';
     end if;