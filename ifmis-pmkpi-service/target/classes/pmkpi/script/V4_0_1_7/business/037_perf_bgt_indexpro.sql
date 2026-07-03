  i number;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_BGT_INDEXPRO';
  if i=0 then
     execute immediate '
      create table PERF_BGT_INDEXPRO
      (
        guid          VARCHAR2(40) not null,
        pro_id        VARCHAR2(40),
        pro_code      VARCHAR2(40),
        pro_name      VARCHAR2(180),
        pro_total_amt NUMBER(18,2),
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
        indexguid     VARCHAR2(40),
        remark        VARCHAR2(1000)
      )
      partition by list (PROVINCE)
      subpartition by list (YEAR)
      (
        partition P87 values (''87'')
        (
          subpartition P87_Y2016 values (''2016'')
        )
      )';
    execute immediate 'alter table PERF_BGT_INDEXPRO
  add constraint PK_PERF_BGTINDEXPRO primary key (GUID, PROVINCE, YEAR)
  using index';
  end if;
    execute immediate '
    CREATE OR REPLACE VIEW V_PERF_BGT_INDEXPRO AS
    SELECT * FROM PERF_BGT_INDEXPRO
    where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
    and IS_DELETED <> 1';