 i number;
begin
   select count(*) into i from user_tables t where t.TABLE_NAME ='PERF_TEMP_PROAGENCY';
   if i = 0 then
      execute immediate'
      create table PERF_TEMP_PROAGENCY
      (
        guid        VARCHAR2(40),
        pro_code    VARCHAR2(40) not null,
        agency_code VARCHAR2(40) not null,
        year        VARCHAR2(4),
        province    VARCHAR2(9),
        createtime  VARCHAR2(17),
        updatetime  VARCHAR2(17),
        agency_name VARCHAR2(4000),
        pro_name    VARCHAR2(4000),
        timestamp   VARCHAR2(17)
      )';
      
      execute immediate'alter table PERF_TEMP_PROAGENCY
      add constraint PK_PERF_TEMP_PROAGENCY primary key (GUID, TIMESTAMP)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROJECT_AGENCY' and t.column_name='AGENCY_NAME';
  if i=0 then
     execute immediate 'alter table PERF_PROJECT_AGENCY add(AGENCY_NAME VARCHAR2(4000))';
  end if;
  
  select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROJECT_AGENCY' and t.column_name='PRO_NAME';
  if i=0 then
     execute immediate 'alter table PERF_PROJECT_AGENCY add(PRO_NAME VARCHAR2(4000))';
  end if;
  
  
  --重构视图
  execute immediate'
    create or replace view v_perf_project_agency as
select t.*
    from perf_project_agency t
     where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and
     t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
     
     
 --列表查询视图
execute immediate'
create or replace view perf_v_project_agency as
select t.GUID,t.PRO_CODE,t.AGENCY_CODE,t.YEAR,t.PROVINCE,t.CREATETIME,t.UPDATETIME,t.AGENCY_NAME,
nvl(t.PRO_NAME,t1.PRO_NAME) as pro_name,t1.AGENCY_CODE as agencycode
    from perf_project_agency t
    left join v_perf_project_info t1 on t.PRO_CODE = t1.PRO_CODE
     where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
     and t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')';
     
