i number;
begin

--AI辅助审核结果
select count(*) into i from user_tables t where t.table_name ='PERF_T_AISUPPORTAUDIDETAIL';
if i=0 then
execute immediate '
create table PERF_T_AISUPPORTAUDIDETAIL
(
  guid          VARCHAR2(40) not null,
  province      VARCHAR2(9) not null,
  year          VARCHAR2(4) not null,
  create_time   VARCHAR2(40),
  agency_code   VARCHAR2(40),
  agency_name   VARCHAR2(4000),
  pro_code      VARCHAR2(40),
  pro_name      VARCHAR2(4000) not null,
  audit_point   VARCHAR2(4000),
  audit_content VARCHAR2(4000),
  ispass        VARCHAR2(40),
  nopass_indi   VARCHAR2(4000),
  ordernum      NUMBER(5),
  warn_level    VARCHAR2(40)
)';
end if;

--添加索引
select count(1) into i from user_indexes t where t.index_name = 'IDX_AISUPPORTDETAIL_PARTITION';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AISUPPORTDETAIL_PARTITION ON PERF_T_AISUPPORTAUDIDETAIL(PRO_CODE, PROVINCE, YEAR)';
end if; 

select count(1) into i from user_indexes t where t.index_name = 'IDX_AISUPPORTDETAIL_TIMESTAMP';
if i = 0 then
 execute immediate 'CREATE INDEX IDX_AISUPPORTDETAIL_TIMESTAMP ON PERF_T_AISUPPORTAUDIDETAIL(create_time DESC)';
end if; 


--结果记录视图 默认取最新
execute immediate '
CREATE OR REPLACE VIEW PERF_V_AISUPPORTAUDIDETAIL AS
SELECT 
    pro_code, province, year, create_time, 
    agency_code, agency_name, pro_name, audit_point, audit_content, ispass, nopass_indi,warn_level, ordernum
FROM PERF_T_AISUPPORTAUDIDETAIL t1
WHERE create_time = (
    SELECT MAX(create_time)
    FROM PERF_T_AISUPPORTAUDIDETAIL t2
    WHERE t2.pro_code = t1.pro_code 
      AND t2.province = t1.province 
      AND t2.year = t1.year
)
and t1.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') 
and t1.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';


