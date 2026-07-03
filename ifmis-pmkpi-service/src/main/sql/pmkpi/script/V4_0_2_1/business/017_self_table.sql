
 i number;
begin

select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFEVALTASK' and t.COLUMN_NAME='BUDGETAMOUNT';
 if i>0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK drop column budgetamount';
 end if;
 
select count(1) into i from user_tab_cols t where t.TABLE_NAME='PERF_T_SELFPERFINDEX' and t.COLUMN_NAME='ACTUALWEIGHT';
 if i=0 then
    execute immediate 'alter table PERF_T_SELFPERFINDEX add actualweight NUMBER(5,2)';
 end if;

select count(1) into i from user_views t where t.VIEW_NAME='V_PERF_V_SELFEVALTASK';
 if i>0 then
    execute immediate 'drop view v_perf_v_selfevaltask';
 end if;

select count(1) into i from user_views t where t.VIEW_NAME='V_PERF_V_SELFEVALTASK_HB';
 if i>0 then
    execute immediate 'drop view v_perf_v_selfevaltask_hb';
 end if;

select count(1) into i from user_views t where t.VIEW_NAME='V_PERF_SELFPERFDESC';
 if i>0 then
    execute immediate 'drop view v_perf_selfperfdesc';
 end if;

execute immediate '
    create or replace view v_perf_t_selfevaltask as
    select t.*
    from PERF_T_SELFEVALTASK t
    where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2';

execute immediate '
    create or replace view v_perf_t_selfperfindex as
	select t.*
	 from PERF_T_SELFPERFINDEX t
	where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
	  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';

execute immediate'
create or replace view perf_v_selfevaltask as
select t.*
       ,''2'' as rectifytype,
       a.amt1 as budgetamount,  --全年预算数
       a.amt3 as execratenum,  --调整后预算数
       a.amt4 as execamount, --预算执行数
       a.bgtget as execrate, --预算执行率
       to_date(t.evalend, ''yyyymmdd'') -
       to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') warndays,
       decode(s.score,null,0,s.score) score,
       s.selfresult,
       s.warn
  from v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join (select mainguid,sum(amt1)as amt1, sum(amt3)as amt3, sum(amt4)as amt4,to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') as bgtget from v_perf_t_selfprofund group by mainguid) a on a.mainguid = t.guid
  where 1=1'
;
execute immediate '
create or replace view perf_v_selfevaltask_hb as
select t.*
       ,''2'' as rectifytype,
       
       a.amt1 as budgetamount,  --全年预算数
       a.amt3 as execratenum,  --调整后预算数
       a.amt4 as execamount, --预算执行数
       a.bgtget as execrate, --预算执行率
       to_date(t.evalend, ''yyyymmdd'') -
       to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') warndays,
       decode(s.score,null,0,s.score) score,
       s.selfresult,
       s.warn
  from v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join v_perf_project_info pro on pro.guid = t.PROJGUID
    left join (select mainguid,sum(amt1)as amt1, sum(amt3)as amt3, sum(amt4)as amt4,to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') as bgtget from v_perf_t_selfprofund group by mainguid) a on a.mainguid = t.guid
  where 1=1'
;

