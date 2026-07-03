
i number;

begin
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='ZQGOAL';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add ZQGOAL VARCHAR2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='NDGOAL';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add NDGOAL VARCHAR2(4000)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='MAINGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add MAINGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='CREATETIME';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add CREATETIME VARCHAR2(17)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='UPDATETIME';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add UPDATETIME VARCHAR2(17)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='KPI_PER_ID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add KPI_PER_ID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='PROGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add PROGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='FROMGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add FROMGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='ADJ_BATCH_NO';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add ADJ_BATCH_NO VARCHAR2(6)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='FROMISDEL';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add FROMISDEL NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='STATUS';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add STATUS NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='TRANSGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add TRANSGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='RATIO';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add RATIO NUMBER(4,1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='VERSIONTYPE';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add VERSIONTYPE NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='IS_BACKUP';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add IS_BACKUP NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='IS_ADJ';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add IS_ADJ NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_GOAL' and t.column_name='APPLYFINAMT';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_GOAL add APPLYFINAMT NUMBER(20,2)';
  end if;
  
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='STATUS';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add STATUS NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='CREATETIME';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add CREATETIME VARCHAR2(17)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='UPDATETIME';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add UPDATETIME VARCHAR2(17)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='MAINGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add MAINGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='PROGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add PROGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='KPI_ID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add KPI_ID VARCHAR2(38)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='FROMGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add FROMGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='YEARFLAG';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add YEARFLAG VARCHAR2(9)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='IS_ADJ';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add IS_ADJ VARCHAR2(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='FROMISDEL';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add FROMISDEL NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='TRANSGUID';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add TRANSGUID VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='ISUNMOD';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add ISUNMOD VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='VERSIONTYPE';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add VERSIONTYPE NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='IS_BACKUP';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add IS_BACKUP NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='IS_ADD';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add IS_ADD NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='INDEXCATEGORIES';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add INDEXCATEGORIES VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='INDUSTRYCATEGORY';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add INDUSTRYCATEGORY VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='INDEXCATEGORY';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add INDEXCATEGORY VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='FILED';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add FILED VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='OCCUPATION';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add OCCUPATION VARCHAR2(40)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='ISFIXED';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add ISFIXED NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='ISFROMPARENT';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add ISFROMPARENT NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='ISAPPLY';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add ISAPPLY NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='ISALLOWEDIT';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add ISALLOWEDIT NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='ONLYSELF';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add ONLYSELF NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='SUMTYPE';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add SUMTYPE NUMBER(1)';
  end if;
  
  select count(1) into i from user_tab_cols t where t.table_name='PERF_TRANSFER_INDICATOR' and t.column_name='ESTIMATED_VAL';
  if i=0 then
    execute immediate 'alter table PERF_TRANSFER_INDICATOR add ESTIMATED_VAL VARCHAR2(1000)';
  end if;

execute immediate '
create or replace view v_perf_transfer_indicator as
select *
from perf_transfer_indicator where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2';

execute immediate '
create or replace view v_perf_transfer_goal as
select *
from perf_transfer_goal t where year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';
