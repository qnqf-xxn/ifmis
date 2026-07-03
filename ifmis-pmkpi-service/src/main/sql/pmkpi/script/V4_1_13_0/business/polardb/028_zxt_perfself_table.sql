  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='IS_EXTRACT';
if i=0 then
   execute immediate 'alter table perf_t_selfevaltask add is_extract varchar2(40)';
   execute immediate 'comment on column perf_t_selfevaltask.is_extract is ''是否抽取''';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='EXTRACT_TYPE';
if i=0 then
   execute immediate 'alter table perf_t_selfevaltask add extract_type varchar2(40)';
   execute immediate 'comment on column perf_t_selfevaltask.extract_type is ''抽取类型''';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='IS_SUE';
if i=0 then
   execute immediate 'alter table perf_t_selfevaltask add is_sue varchar2(40)';
   execute immediate 'comment on column perf_t_selfevaltask.is_sue is ''是否下发''';
end if;

select count(1) into i from user_tab_columns t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='PROTYPE';
if i=0 then
   execute immediate 'alter table perf_t_selfevaltask add protype varchar2(40)';
   execute immediate 'comment on column perf_t_selfevaltask.protype is ''项目类型''';
end if;

v_sql :='
create or replace view v_perf_t_selfevaltask as
select * from PERF_T_SELFEVALTASK 
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid';
select fn_alterview('v_perf_t_selfevaltask',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;


  v_sql :='
create or replace view perf_v_selfevaltask as
select
    t.*
    ,''2'' as rectifytype,
    case
     when to_date(t.evalend, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(t.evalend, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end warndays, --截止天数
    nvl(s.score,0) score,
    s.selfresult,
    s.warn
from
    v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid';
	select fn_alterview('perf_v_selfevaltask',v_sql) into ln_i;
	if ln_i = 0 then
	    return;
	end if;	  

v_sql :='
create or replace view PERF_V_SELFRANDOM as
select t1.*,agency.name as dept_name from (
       select 
         dept_code,
         dept_code as agencyguid,
         year,
         province,
         count(*) as SELF_COUNT1,
         round(count(*) * (select PARAMVALUE from v_perf_t_systemset where PARAMCODE = ''perfselfrandom'') / 100) as SELF_COUNT2,
         SUM(CASE WHEN IS_EXTRACT = ''1'' THEN 1 ELSE 0 END) AS SELF_COUNT3,
         CASE WHEN MAX(IS_SUE) = 1 THEN ''1'' ELSE ''2'' END AS IS_SUE
       from V_PERF_T_SELFEVALTASK 
       where  is_deleted = 2 group by dept_code,year,province) t1
       left join fasp_t_pubagency agency on t1.dept_code = agency.code
       where (dept_code != '''' or dept_code is not null)';
select fn_alterview('PERF_V_SELFRANDOM',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

select count(*) into i from user_tables t where t.TABLE_NAME='PERF_T_SELFFUNDMANAG';
if i = 0 then
    execute immediate '	
	create table PERF_T_SELFFUNDMANAG
    (
      guid                VARCHAR2(32) not null,
      pro_code            VARCHAR2(40),
      code                VARCHAR2(40),
      name                VARCHAR2(500),
      col1                VARCHAR2(4000),
      col2                VARCHAR2(4000),
      col3                VARCHAR2(4000),
      col4                VARCHAR2(4000),
      col5                VARCHAR2(4000),
      mainguid            VARCHAR2(40),
      is_deleted          NUMBER(1) default 2 not null,
      year                VARCHAR2(4) not null,
      province            VARCHAR2(9) not null,
      creater             VARCHAR2(40) not null,
      create_time         VARCHAR2(40) not null,
      update_time         VARCHAR2(40) not null
    )
	';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.guid  is ''主键''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.pro_code  is ''项目编码''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.code  is ''编码''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.name  is ''名称''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.col1  is ''情况说明''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.col2  is ''存在问题''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.col3  is ''备用3''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.col4  is ''备用4''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.col5  is ''备用5''';
	execute immediate 'comment on column PERF_T_SELFFUNDMANAG.mainguid  is ''自评主键''';
	execute immediate 'alter table PERF_T_SELFFUNDMANAG
	  add constraint PK_PERF_T_SELFFUNDMANAG primary key (GUID)';
end if;


v_sql :='
create or replace view v_perf_t_selffundmanag as
select * from
    perf_t_selffundmanag 
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid';
select fn_alterview('v_perf_t_selffundmanag',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
