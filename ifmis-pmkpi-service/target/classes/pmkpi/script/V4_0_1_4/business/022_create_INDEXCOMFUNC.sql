  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PERF_T_INDEXCOMFUNC';
  if i=0 then
     execute immediate '
create table PERF_T_INDEXCOMFUNC
(
  GUID           VARCHAR2(40) not null,
  CODE        VARCHAR2(40),
  NAME        VARCHAR2(4000),
  DEPT        VARCHAR2(40),
  province    VARCHAR2(40),
  agencyguid  VARCHAR2(40),
  status      VARCHAR2(2) not null
)';

-- Create/Recreate primary, unique and foreign key constraints 
execute immediate '
alter table PERF_T_INDEXCOMFUNC
  add constraint PK_PERF_T_INDEXCOMFUNC primary key (GUID)';

execute immediate 'comment on column PERF_T_INDEXCOMFUNC.GUID is ''主键'' ';
execute immediate 'comment on column PERF_T_INDEXCOMFUNC.CODE is ''项目编码code'' ';
execute immediate 'comment on column PERF_T_INDEXCOMFUNC.NAME is ''项目名称'' ';
execute immediate 'comment on column PERF_T_INDEXCOMFUNC.DEPT is ''部门'' ';
execute immediate 'comment on column PERF_T_INDEXCOMFUNC.PROVINCE is ''区划'' ';
execute immediate 'comment on column PERF_T_INDEXCOMFUNC.AGENCYGUID is ''单位'' ';
execute immediate 'comment on column PERF_T_INDEXCOMFUNC.STATUS is ''1行业大类 2行业类别'' ';

end if;

select count(*) into i from user_tables  t where t.TABLE_NAME='PM_PROJECT_INFO';
  if i=1 then
execute immediate '
create or replace view v_perf_indexcomfunc as
select PM.pro_id as guid,
       PM.pro_code as code,
       PM.pro_name as name,
       PM.mof_dep_code as dept,
       PM.province,
       PM.agency_code as agencyguid,
       ''1'' as status
  from PM_PROJECT_INFO PM
 where PM.pro_lev = ''1''
 AND EXISTS (select * from V_BAS_PERF_INDICATOR P WHERE P.INDEXCATEGORIES = PM.PRO_ID AND P.IS_COMMON_IND <> 1 AND P.AGENCY_CODE IS NOT NULL )
 union all 
 select PF.guid,
       PF.code,
       PF.name,
       PF.SUPERGUID dept,
       PF.province,
       PF.code as agencyguid,
       ''1'' as status
  from pmkpi_fasp_t_pubagency PF
 where pf.status = ''1''
 AND EXISTS (select * from V_BAS_PERF_INDICATOR P WHERE P.INDEXCATEGORIES = PF.GUID AND P.IS_COMMON_IND <> 1 AND P.AGENCY_CODE IS NOT NULL )
 union all
 select * from PERF_T_INDEXCOMFUNC where status = ''1''';
end if;