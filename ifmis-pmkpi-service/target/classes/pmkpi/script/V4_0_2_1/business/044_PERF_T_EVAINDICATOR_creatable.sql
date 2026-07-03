--declare
 i number;
begin
select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_EVAINDICATOR';
  if i=0 then
     execute immediate '
create table PERF_T_EVAINDICATOR
(
  guid         VARCHAR2(38) default SYS_GUID() not null,
  code       VARCHAR2(40),
  name       VARCHAR2(100),
  ele_catalog_id VARCHAR2(38),
  mof_div_code   VARCHAR2(9) default 87 not null,
  superid      VARCHAR2(38),
  levelno       NUMBER(2) default 1,
  isleaf        NUMBER(1) default 1,
  ordernum       NUMBER(9),
  weight         NUMBER(18,2),
  indexval       VARCHAR2(1000),
  adjust         VARCHAR2(1000),
  computesign    VARCHAR2(40),
  meterunit      VARCHAR2(200),
  remark         VARCHAR2(2000),
  mainguid         VARCHAR2(38),
  start_date     VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  end_date       VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  is_enabled     NUMBER(1) default 1,
  update_time    VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  is_deleted     NUMBER(1) default 2 not null,
  create_time    VARCHAR2(17) default TO_CHAR(SYSDATE,''YYYYMMDD''),
  fiscal_year    VARCHAR2(4) not null,
  year           NUMBER(4) not null,
  province       VARCHAR2(9) not null
)';
execute immediate 'alter table PERF_T_EVAINDICATOR
  add constraint PERF_T_EVAINDICATOR_PK primary key (GUID,mainguid)';
execute immediate 'CREATE OR REPLACE VIEW v_PERF_T_EVAINDICATOR
 AS
 SELECT t.*,
 ''1'' as status
   FROM PERF_T_EVAINDICATOR t
  WHERE t.is_deleted = ''2'' AND year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
 end if;

