i number;
begin

--1.标识业务
--add col
select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='IS_REMARKED';
if i=0 then
   execute immediate 'alter table BAS_PERF_INDICATOR add IS_REMARKED NUMBER(1) default 2';
end if;

execute immediate '
create or replace view v_bas_perf_indicator as 
select t.* from BAS_PERF_INDICATOR t 
where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';


select count(1) into i from user_tab_columns t where t.table_name='BAS_PERF_INDICATOR' and t.column_name='PRONAME';
if i=0 then
   execute immediate '
	create or replace view bas_perf_v_indicator as
	select t.*,
		   t1.name as PRONAME
	  FROM BAS_PERF_INDICATOR T
	  left join V_PERF_T_INDEXCOMFUNC t1
		on t.pro_name = t1.GUID
	 WHERE t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
	   and t.is_deleted = 2';
end if;

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_CASEMODELINDEX' and t.column_name='IS_REMARKED';
if i=0 then
   execute immediate 'alter table PERF_T_CASEMODELINDEX add IS_REMARKED NUMBER(1) default 2';
end if;

execute immediate '
create or replace view v_perf_t_casemodelindex as
select t.* from PERF_T_CASEMODELINDEX t
where t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR' and t.column_name='IS_REMARKED';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR add IS_REMARKED NUMBER(1) default 2';
end if;

execute immediate '
create or replace view v_pm_perf_indicator as
select * from pm_perf_indicator t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2 and is_backup =2 and nvl(t.is_adj, 2) = 2 and t.sub_mof_div_code is null';

--add col
select count(1) into i from user_tab_columns t where t.table_name='PM_PERF_INDICATOR_TEMP' and t.column_name='IS_REMARKED';
if i=0 then
   execute immediate 'alter table PM_PERF_INDICATOR_TEMP add IS_REMARKED NUMBER(1) default 2';
end if;

execute immediate '
create or replace view V_PM_PERF_INDICATOR_TEMP as
select * from PM_PERF_INDICATOR_TEMP t
where PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and is_deleted =2';

--add col
select count(1) into i from user_tab_columns t where t.table_name='PERF_T_ADJUSTINDEX' and t.column_name='IS_REMARKED';
if i=0 then
   execute immediate 'alter table PERF_T_ADJUSTINDEX add IS_REMARKED NUMBER(1) default 2';
end if;

execute immediate '
create or replace view V_PERF_T_ADJUSTINDEX as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2 and t.sub_mof_div_code is null';

execute immediate '
create or replace view v_perf_t_adjustallindex as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') and PROVINCE = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted=2';


--2.统计视图
execute immediate '
create or replace view perf_v_indimarked as
WITH pm_markedindi_data AS (
        select code,year,province,count(1) indi_count,global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'') as currentyear from pm_perf_indicator pi where pi.yearflag =''0'' and pi.is_deleted =2 and pi.is_backup =2 and nvl(pi.is_adj, 2) = 2 group by pi.code,pi.year,pi.province
    ),
     perfgxclass_data AS (
        select guid,code,name,superid,levelno,isleaf,ordernum from v_perf_enum en where en.elementcode = ''PERFGXCLASSIFICATION''
    )
select 
t.mainguid as case_guid,t.code as indi_code,t.name as indi_name,
a.name as case_name,a.casetype,e.name as casetype_name,f.name as caseparent_name,
nvl(b.indi_count,0) as indi_count1,nvl(c.indi_count,0) as indi_count2,nvl(d.indi_count,0) as indi_count3,
a.agencyguid,a.finintorgguid,
t.province,a.bustype
from 
v_perf_t_casemodelindex t 
inner join v_perf_t_case a on t.mainguid = a.guid
left join pm_markedindi_data b on t.code = b.code and t.province = b.province and b.year=b.currentyear-2
left join pm_markedindi_data c on t.code = c.code and t.province = c.province and c.year=c.currentyear-1
left join pm_markedindi_data d on t.code = d.code and t.province = d.province and d.year=d.currentyear
inner join perfgxclass_data e on e.guid = a.casetype
left join perfgxclass_data f on f.guid = e.superid        
where t.framesystem = ''PM001'' and t.is_remarked =1 and nvl(t.status, 2) <> 3 and (b.indi_count>0 or c.indi_count>0 or d.indi_count>0)  
order by e.code,t.mainguid,t.code';


--3.统计视图用索引
select count(*) into i from user_indexes where index_name='IDX_PM_PERF_GRP' ;
if i = 0 then
   execute immediate 'CREATE INDEX IDX_PM_PERF_GRP ON pm_perf_indicator (
    yearflag, 
    is_deleted, 
    is_backup, 
    is_adj, 
    code, 
    year, 
    province
) COMPRESS';
end if;

select count(*) into i from user_indexes where index_name='IDX_CASE_MODEL' ;
if i = 0 then
   execute immediate 'CREATE INDEX IDX_CASE_MODEL ON perf_t_casemodelindex (
    is_remarked,
    framesystem, 
	is_deleted,
    code, 
    province, 
    mainguid 
)';
end if;



