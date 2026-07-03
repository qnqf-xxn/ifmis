    i number;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_BGT_LINKBGTINFO';
  if i=0 then
     execute immediate '
      create table PERF_BGT_LINKBGTINFO
      (
        guid          VARCHAR2(40) not null,
        findex        VARCHAR2(300),
        sindex        VARCHAR2(300),
        name          VARCHAR2(1000) not null,
        kpi_val1      VARCHAR2(1000),
        kpi_val2      VARCHAR2(1000),
        kpi_val3      VARCHAR2(1000),
        computesign   VARCHAR2(40),
        kpi_val       VARCHAR2(1000) not null,
        meterunit     VARCHAR2(200),
        bgtamt1       NUMBER(18,2),
        bgtamt2       NUMBER(18,2),
        bgtamt3       NUMBER(18,2),
        score         NUMBER(5,2),
        baseperiod    VARCHAR2(200),
        couplerate    NUMBER(5,2),
        coupleamt     NUMBER(18,2),
        agencyguid    VARCHAR2(40),
        status        NUMBER(1),
        is_deleted    NUMBER(1) default 2 not null,
        createtime    VARCHAR2(17) not null,
        updatetime    VARCHAR2(17),
        creater       VARCHAR2(40) not null,
        province      VARCHAR2(32) not null,
        year          NUMBER(4) not null,
        ordernum      NUMBER(9),
        finintorgguid VARCHAR2(40),
        mainguid      VARCHAR2(40),
        remark        VARCHAR2(1000),
        indexguid     VARCHAR2(40)
      )';
    execute immediate 'alter table PERF_BGT_LINKBGTINFO
  add constraint PK_PERFBGTLINKBGTINFO primary key (GUID, PROVINCE, YEAR)';
  end if;
    execute immediate '
    CREATE OR REPLACE VIEW V_PERF_BGT_LINKBGTINFO AS
    SELECT * FROM PERF_BGT_LINKBGTINFO
    where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
    and IS_DELETED <> 1';
