--自评预算执行情况业务表
i number;
begin
  -- 新建临时表  备份数据
  select count(*) into i from user_tables t where t.TABLE_NAME ='PERF_T_SELFPROFUND_ONE';
   if i = 0 then
    --有数据，新加临时表，保存原表数据
    execute immediate'create table PERF_T_SELFPROFUND_ONE as select * from PERF_T_SELFPROFUND';
  end if;
  
  -- 删除原来的表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_SELFPROFUND';
   if i>0 then
       execute immediate'drop table PERF_T_SELFPROFUND';
   end if;
  
  --重构表 
 SELECT COUNT(*) INTO i FROM USER_TABLES T WHERE T.TABLE_NAME='PERF_T_SELFPROFUND';
  if i = 0 then
    execute immediate '
      create table PERF_T_SELFPROFUND
      (
        guid         VARCHAR2(40) not null,
        name         VARCHAR2(2000),
        amt1         NUMBER(20,2),
        amt2         NUMBER(20,2),
        amt3         NUMBER(20,2),
        amt4         NUMBER(20,2),
        amt5         NUMBER(20,2),
        amt6         NUMBER(20,2),
        amt7         NUMBER(20,2),
        amt8         NUMBER(20,2),
        amt9         NUMBER(20,2),
        ordernum     NUMBER(9),
        mainguid     VARCHAR2(40),
        isedit       VARCHAR2(40),
        agencyguid   VARCHAR2(40),
        agency_code  VARCHAR2(40),
        pro_code     VARCHAR2(40),
        proguid     VARCHAR2(40),
        creater      VARCHAR2(40),
        create_time  VARCHAR2(17),
        update_time  VARCHAR2(17),
        is_deleted   NUMBER(1),
        fiscal_year  VARCHAR2(4) not null,
        mof_div_code VARCHAR2(9) not null,
        year         VARCHAR2(4) not null,
        province     VARCHAR2(9) not null,
        bgtget       VARCHAR2(30),
        economic     VARCHAR2(40),
        completion   VARCHAR2(2000),
        score        VARCHAR2(40),
        fzscore      VARCHAR2(40),
        code         VARCHAR2(100),
        agency_name  VARCHAR2(500)
      )';
execute immediate '
alter table PERF_T_SELFPROFUND
  add constraint PK_PERF_SELFPROFUND primary key (GUID, PROVINCE, YEAR)';
  end if;
   
  -- 数据插入到新表中
  execute immediate '
  delete from PERF_T_SELFPROFUND ';
  execute immediate '
  insert into PERF_T_SELFPROFUND (GUID, NAME, AMT1, AMT2, AMT3, AMT4, AMT5, AMT6, AMT7, AMT8, AMT9, ORDERNUM, MAINGUID, ISEDIT, AGENCYGUID, AGENCY_CODE, PRO_CODE, PROGUID, CREATER, CREATE_TIME, UPDATE_TIME, IS_DELETED, FISCAL_YEAR, MOF_DIV_CODE, YEAR, PROVINCE, BGTGET, ECONOMIC, COMPLETION, SCORE, FZSCORE, CODE, AGENCY_NAME)
  select * from PERF_T_SELFPROFUND_ONE';
  
  -- 删除临时表
  execute immediate '
  drop table PERF_T_SELFPROFUND_ONE ';
  
  
  --重构视图
  execute immediate'
  create or replace view v_perf_t_selfprofund as
select *
    from perf_t_selfprofund t
      where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
