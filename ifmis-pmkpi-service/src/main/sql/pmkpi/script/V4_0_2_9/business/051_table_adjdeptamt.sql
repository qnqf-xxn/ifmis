i number;
begin
--资金调整表
select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_ADJDEPTAMT';
if i=0 then
    execute immediate '
      create table PERF_T_ADJDEPTAMT
      (
        guid       VARCHAR2(40) not null,
        agencyguid VARCHAR2(40),
        agencyname VARCHAR2(200),
        typename   VARCHAR2(100),
        fundname   VARCHAR2(100),
        yearamt    NUMBER(20,2),
        rate       NUMBER(20,4),
        famt       NUMBER(20,2),
        samt       NUMBER(20,2),
        mainguid   VARCHAR2(40),
        createtime VARCHAR2(17) not null,
        updatetime VARCHAR2(17),
        creater    VARCHAR2(40) not null,
        province   VARCHAR2(40) not null,
        year       NUMBER(4) not null,
        is_deleted NUMBER(1),
        ordernum   NUMBER(3)
      )
    ';
    execute immediate 'alter table PERF_T_ADJDEPTAMT add constraint PK_PERF_ADJDEPTAMT primary key (GUID, YEAR, PROVINCE)';
end if;

--创建视图
execute immediate '
create or replace view V_PERF_T_ADJDEPTAMT as
select * from PERF_T_ADJDEPTAMT
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';