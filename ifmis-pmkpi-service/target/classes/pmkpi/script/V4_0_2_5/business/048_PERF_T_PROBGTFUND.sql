--监控预算执行情况业务表
i number;
begin
  -- 新建临时表  备份数据
  select count(*) into i from user_tables t where t.TABLE_NAME ='PERF_T_PROBGTFUND_ONE';
   if i = 0 then
    --有数据，新加临时表，保存原表数据
    execute immediate'create table PERF_T_PROBGTFUND_ONE as select * from PERF_T_PROBGTFUND';
  end if;
  
  -- 删除原来的表
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROBGTFUND';
   if i>0 then
       execute immediate'drop table PERF_T_PROBGTFUND';
   end if;
  
  --重构表 
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_PROBGTFUND';
    if i=0 then
       execute immediate '
          create table PERF_T_PROBGTFUND
            (
              guid         VARCHAR2(40) not null,
              name         VARCHAR2(200),
              totalamt    NUMBER(20,2),
              amt1         NUMBER(20,2),
              amt2         NUMBER(20,2),
              amt3         NUMBER(20,2),
              amt4         NUMBER(20,2),
              amt5         NUMBER(20,2),
              amt6         NUMBER(20,2),
              amt7         NUMBER(20,2),
              amt8         NUMBER(20,2),
              amt9         NUMBER(20,2),
              bgtget       VARCHAR2(30),
              ordernum     NUMBER(9),
              mainguid     VARCHAR2(40),
              isedit       VARCHAR2(40),
              agencyguid   VARCHAR2(40),
              agency_code  VARCHAR2(40),
              creater      VARCHAR2(40),
              create_time  VARCHAR2(17),
              update_time  VARCHAR2(17),
              is_deleted   NUMBER(1),
              fiscal_year  VARCHAR2(4) not null,
              mof_div_code VARCHAR2(9) not null,
              year         VARCHAR2(4) not null,
              province     VARCHAR2(9) not null,
              economic     VARCHAR2(40),
              agency_name  VARCHAR2(2000),
              pro_name     VARCHAR2(2000)
            )';
  execute immediate 'alter table PERF_T_PROBGTFUND
  add constraint PK_PERF_PROBGTFUND primary key (GUID, PROVINCE, YEAR)';
   end if;
   
-- 数据插入到新表中
  execute immediate '
  delete from PERF_T_PROBGTFUND ';
  execute immediate '
  insert into PERF_T_PROBGTFUND (GUID, NAME, TOTALAMT, AMT1, AMT2, AMT3, AMT4, AMT5, AMT6, AMT7, AMT8, AMT9, BGTGET, ORDERNUM, MAINGUID, ISEDIT, AGENCYGUID,AGENCY_CODE, CREATER, CREATE_TIME, UPDATE_TIME, IS_DELETED, FISCAL_YEAR, MOF_DIV_CODE, YEAR, PROVINCE, ECONOMIC, AGENCY_NAME, PRO_NAME)
  select * from PERF_T_PROBGTFUND_ONE';
  -- 删除临时表
  execute immediate '
  drop table PERF_T_PROBGTFUND_ONE ';
  
  --重构视图
  execute immediate '
create or replace view v_perf_t_probgtfund as
select t.*
 from perf_t_probgtfund t  where YEAR= global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
