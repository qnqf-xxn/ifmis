i number;
begin
  --批复项目表
  select count(*) into i from user_tab_columns t where t.TABLE_NAME='PERF_BGT_PROJECTPF' and t.COLUMN_NAME='FININTORGGUID';
  if i = 0 then
    execute immediate'alter table PERF_BGT_PROJECTPF add FININTORGGUID VARCHAR2(6)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.TABLE_NAME='PERF_BGT_PROJECTPF' and t.COLUMN_NAME='PRO_LEV';
  if i = 0 then
    execute immediate'alter table PERF_BGT_PROJECTPF add PRO_LEV VARCHAR2(2)';
  end if;
  
  select count(*) into i from user_tab_columns t where t.TABLE_NAME='PERF_BGT_PROJECTPF' and t.COLUMN_NAME='PRO_CAT_CODE';
  if i = 0 then
    execute immediate'alter table PERF_BGT_PROJECTPF add PRO_CAT_CODE VARCHAR2(4)';
  end if;
  
  execute immediate '
create or replace view v_perf_bgt_projectpf as
select
    *
from
    perf_bgt_projectpf
where
    year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted = 2
';
