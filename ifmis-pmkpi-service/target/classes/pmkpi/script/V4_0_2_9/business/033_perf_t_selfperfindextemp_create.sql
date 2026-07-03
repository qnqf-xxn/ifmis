i number;
begin

--自评指标草稿表
select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_SELFPERFINDEXTEMP';
if i=0 then
    execute immediate '
      create table PERF_T_SELFPERFINDEXTEMP
      (
        guid          VARCHAR2(40) not null,
        code          VARCHAR2(300),
        name          VARCHAR2(1000),
        taskguid      VARCHAR2(40),
        isleaf        VARCHAR2(40),
        superid       VARCHAR2(40),
        levelno       VARCHAR2(40),
        mainguid      VARCHAR2(40),
        projguid      VARCHAR2(40),
        agencyguid    VARCHAR2(40),
        wfstatus      VARCHAR2(40),
        status        NUMBER(1),
        createtime    VARCHAR2(17),
        updatetime    VARCHAR2(17),
        creater       VARCHAR2(40),
        province      VARCHAR2(32) not null,
        year          NUMBER(4) not null,
        ordernum      NUMBER(9),
        finintorgguid VARCHAR2(40),
        wfid          VARCHAR2(40),
        rule          VARCHAR2(200),
        kpi_remark    VARCHAR2(2000),
        kpi_evalstd   VARCHAR2(2000),
        indexval      VARCHAR2(1000),
        computesign   VARCHAR2(40),
        meterunit     VARCHAR2(200),
        actualvalue   VARCHAR2(1000),
        weight        NUMBER(5,2),
        score         NUMBER(5,2),
        operation     VARCHAR2(40),
        is_deleted    NUMBER(1) not null,
        kpivalsource  VARCHAR2(40),
        pro_code      VARCHAR2(21),
        findex        VARCHAR2(300),
        sindex        VARCHAR2(300),
        tindex        VARCHAR2(300),
        actualweight  NUMBER(5,2),
        score_remark  VARCHAR2(2000),
        datatype      VARCHAR2(40)
      )
    ';
    execute immediate 'alter table PERF_T_SELFPERFINDEXTEMP add constraint PK_PERF_T_SELFPERFINDEXTEMP primary key (GUID, YEAR, PROVINCE)';
end if;

--创建视图
execute immediate '
create or replace view v_perf_t_selfperfindextemp as
select * from perf_t_selfperfindextemp
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';
