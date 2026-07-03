   i number;
begin
--绩效目标修订授权-已授权
--加字段
select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROREVISION_AGENCY' and t.column_name='PROVINCE';
if i=0 then
    execute immediate 'alter table PERF_PROREVISION_AGENCY add(PROVINCE VARCHAR2(40))';
end if;
select count(*) into i from user_tab_columns t where t.table_name ='PERF_PROREVISION_AGENCY' and t.column_name='YEAR';
if i=0 then
    execute immediate 'alter table PERF_PROREVISION_AGENCY add(YEAR NUMBER(4))';
end if;
--处理历史数据
execute immediate 'update PERF_PROREVISION_AGENCY t set t.year = ''2022'' where t.year is null';
execute immediate 'update PERF_PROREVISION_AGENCY t set t.province = (select province from fasp_t_causer where guid = t.creater)  where t.province is null';

--主键改为组合主键
execute immediate 'alter table PERF_PROREVISION_AGENCY drop constraint PK_PERF_PROREVISION_AGENCY';
select count(*) into i from user_indexes where index_name='PK_PERF_PROREVISION_AGENCY';
if i>0 then
    execute immediate 'drop index PK_PERF_PROREVISION_AGENCY';
end if;
execute immediate 'alter table PERF_PROREVISION_AGENCY add constraint PK_PERF_PROREVISION_AGENCY primary key(GUID,PROVINCE,YEAR)';

--创建视图
execute immediate '
create or replace view V_PERF_PROREVISION_AGENCY as
select * from PERF_PROREVISION_AGENCY where province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
';
 