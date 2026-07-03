  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

--数量指标录入表
select count(*) into i from user_tables t where t.table_name ='PM_PERF_INDICATORPAYQUANTITY';
if i=0 then
execute immediate '
create table PM_PERF_INDICATORPAYQUANTITY
(
  guid               VARCHAR2(40) not null,
  code               VARCHAR2(300),
  name               VARCHAR2(1000),
  creater            VARCHAR2(40) not null,
  province           VARCHAR2(32) not null,
  year               NUMBER(4) not null,
  ordernum           NUMBER(9),
  superid            VARCHAR2(40),
  levelno            NUMBER(2),
  computesign        VARCHAR2(40),
  meterunit          VARCHAR2(200),
  targetvalue        VARCHAR2(1000),
  indexval           VARCHAR2(1000),
  pro_code           VARCHAR2(21),
  payid        		 VARCHAR2(40),
  kpi_content        VARCHAR2(2000),
  kpi_remark         VARCHAR2(2000),
  version            VARCHAR2(38) not null,
  version_name       VARCHAR2(400) not null,
  update_time        VARCHAR2(17) not null,
  create_time        VARCHAR2(17) not null,
  is_deleted         NUMBER(1) not null,
  findex             VARCHAR2(300),
  sindex             VARCHAR2(300),
  tindex             VARCHAR2(300),
  yearflag           VARCHAR2(9)
)';
end if;

v_sql :='
create or replace view V_PM_PERF_INDICATORPAYQUANTITY as
select * from PM_PERF_INDICATORPAYQUANTITY
WHERE province = global_multyear_cz.v_pmdivid AND year = global_multyear_cz.v_pmyear and is_deleted = 2';
select fn_alterview('V_PM_PERF_INDICATORPAYQUANTITY',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

--自行修改视图内标记字段条件 例：case when t.name like ''%培训%'' then ''1'' else ''2'' end as ismarkpro
v_sql :='create or replace view PERF_V_PROMONITOR as
select
    t.* 
    ,case
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) > to_number(b.warndays) then ''black''
        when to_number(to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')) <= to_number(b.warndays) then ''red''
        when to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') > to_date(b.enddate, ''yyyymmdd'') then ''000''
    end warn,
    case
     when to_date(b.enddate, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(b.enddate, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end as warndays,
    t.update_time as updatetime,
    b.taskstage,
    b.startdate,
    b.enddate,
    b.tasktype,
    b.bustype,
    b.name as taskname,
    ''2'' as ismarkpro
from
    v_perf_t_promonitor t
    left join v_perf_t_taskset b on b.guid = t.taskguid
where
    to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') >= to_date(b.startdate, ''yyyymmdd'') - 1 '; 
select fn_alterview('PERF_V_PROMONITOR',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;	