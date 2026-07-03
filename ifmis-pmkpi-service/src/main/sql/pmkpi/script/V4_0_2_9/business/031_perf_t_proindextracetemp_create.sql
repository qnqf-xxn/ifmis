 i number;
begin

--监控指标草稿表
select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_PROINDEXTRACETEMP';
if i=0 then
    execute immediate '
      create table PERF_T_PROINDEXTRACETEMP
      (
        guid              VARCHAR2(40) not null,
        name              VARCHAR2(1000),
        targetvalue       VARCHAR2(1000),
        computesign       VARCHAR2(40),
        meterunit         VARCHAR2(40),
        completeanalysis  VARCHAR2(2000),
        deviationanalysis VARCHAR2(200),
        otherreasons      VARCHAR2(2000),
        ordernum          NUMBER(9),
        mainguid          VARCHAR2(40),
        proguid           VARCHAR2(40),
        warn              VARCHAR2(40),
        agencyguid        VARCHAR2(40),
        creater           VARCHAR2(40),
        create_time       VARCHAR2(17),
        update_time       VARCHAR2(17),
        is_deleted        NUMBER(1),
        fiscal_year       VARCHAR2(4),
        mof_div_code      VARCHAR2(9),
        year              VARCHAR2(4) not null,
        province          VARCHAR2(9) not null,
        completeanalyscon VARCHAR2(40),
        agency_code       VARCHAR2(21),
        remark            VARCHAR2(2000),
        indexval          VARCHAR2(1000),
        findex            VARCHAR2(300),
        sindex            VARCHAR2(300),
        tindex            VARCHAR2(300)
      )
    ';
    execute immediate 'alter table PERF_T_PROINDEXTRACETEMP add constraint PK_PERF_T_PROINDEXTRACETEMP primary key (GUID, YEAR, PROVINCE)';
end if;

--创建视图
execute immediate '
create or replace view v_perf_t_proindextracetemp as
select * from perf_t_proindextracetemp
where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
';
