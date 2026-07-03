
i number;
begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='FRAMESYSTEM';
  if i=1 then
    execute immediate 'alter table PERF_T_CASE drop column FRAMESYSTEM';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='BUSTYPE';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add BUSTYPE varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='ISADJUST';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add ISADJUST varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='FININTORGGUID';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add FININTORGGUID varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='WFSTATUS';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add WFSTATUS varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='ADJUSTGUID';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add ADJUSTGUID varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='WFID';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add WFID varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='LASTUPDATETIME';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add LASTUPDATETIME varchar2(17)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='IS_DELETED';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add IS_DELETED number(1)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASE' and t.column_name='AUDITOR';
  if i=0 then
    execute immediate 'alter table PERF_T_CASE add AUDITOR varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='IS_DELETED';
  if i=0 then
    execute immediate 'alter table PERF_T_CASEMODELINDEX add IS_DELETED number(1)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='ADJUSTINDEXGUID';
  if i=0 then
    execute immediate 'alter table PERF_T_CASEMODELINDEX add ADJUSTINDEXGUID varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='REMARK';
  if i=0 then
    execute immediate 'alter table PERF_T_CASEMODELINDEX add REMARK varchar2(2000)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='INDUSTRYCATEGORY';
  if i=0 then
    execute immediate 'alter table PERF_T_CASEMODELINDEX add INDUSTRYCATEGORY varchar2(40)';
  end if;
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='VALUE_CHANGE';
  if i=0 then
    execute immediate 'alter table PERF_T_CASEMODELINDEX add VALUE_CHANGE varchar2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_T_CASEMODELGOAL' and t.column_name='IS_DELETED';
  if i=0 then
    execute immediate 'alter table PERF_T_CASEMODELGOAL add IS_DELETED number(1)';
  end if;

execute immediate '
create or replace view v_perf_t_case as
select *
 FROM PERF_T_CASE T 
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
      and t.is_deleted=2 and nvl(t.isadjust,''0'') =  ''0''' ;

execute immediate '
create or replace view v_perf_t_casemodelindex as
select * 
FROM PERF_T_CASEMODELINDEX T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
      and t.is_deleted=2';

execute immediate '
create or replace view v_perf_t_casemodelgoal as
select * 
from PERF_T_CASEMODELGOAL t where  
province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
