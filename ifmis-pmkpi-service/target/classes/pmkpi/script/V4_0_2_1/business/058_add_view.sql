 i number;
begin
 --指标目标草稿表创建区划索引和视图（代码优化为分区视图）
 select count(*) into i from user_indexes where index_name='IDX_PMPERFGOALTEMP_PROVINCE' ;
 if i = 0 then 
  execute immediate 'create index IDX_PMPERFGOALTEMP_PROVINCE on pm_perf_goal_temp (PROVINCE)'; 
 end if;
 select count(*) into i from user_indexes where index_name='IDX_PMPERFGOALTEMP_ISDELETED' ;
 if i = 0 then
  execute immediate 'create index IDX_PMPERFGOALTEMP_ISDELETED on pm_perf_goal_temp (IS_DELETED)';
 end if;

 select count(*) into i from user_indexes where index_name='IDX_INDICATORTEMP_PROVINCE' ;
 if i = 0 then 
  execute immediate 'create index IDX_INDICATORTEMP_PROVINCE on pm_perf_indicator_temp (PROVINCE)'; 
 end if;
 select count(*) into i from user_indexes where index_name='IDX_INDICATORTEMP_ISDELETED' ;
 if i = 0 then
  execute immediate 'create index IDX_INDICATORTEMP_ISDELETED on pm_perf_indicator_temp (IS_DELETED)';
 end if;

execute immediate '
create or replace view V_PM_PERF_GOAL_TEMP as
select * FROM pm_perf_goal_temp  
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and is_deleted = ''2''
';

execute immediate '
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * FROM pm_perf_indicator_temp 
WHERE province = global_multyear_cz.secu_f_global_parm(''DIVID'') and is_deleted = ''2''
';