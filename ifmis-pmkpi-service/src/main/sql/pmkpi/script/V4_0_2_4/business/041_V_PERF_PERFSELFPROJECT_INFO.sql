  i number;
begin

select count(*) into i from user_tab_columns t where t.table_name ='PERF_T_SELFEVALTASK' and t.column_name='PRO_LEV';
if i=0 then
    execute immediate 'alter table PERF_T_SELFEVALTASK add(PRO_LEV VARCHAR2(40))';
end if;
--处理历史数据
execute immediate 'update PERF_T_SELFEVALTASK t set t.PRO_LEV = (select PRO_LEV from pm_project_info where guid = t.projguid)  where t.PRO_LEV is null';
--重建视图
execute immediate '
create or replace view v_perf_t_selfevaltask as
select t.*
    from PERF_T_SELFEVALTASK t
    where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
      and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2';
      
execute immediate '
create or replace view V_PERF_PERFSELFPROJECT_INFO as
select *
    from v_perf_project_info t
   where exists (select 1
            from v_bgt_pm_annual an
           where an.is_deleted = 2
             and an.pro_code = t.pro_code
             and an.pro_code is not null)
  union
  select *
    from v_perf_project_info b
   where exists (select 1
            from v_perf_t_deptperfmiddeclare nz
           where nz.pro_code = b.pro_code
             and nz.wfstatus = ''011'')
  union
select *
    from v_perf_project_info t
   where t.PRO_LEV = ''1'' ';
   
execute immediate '
create or replace view perf_v_selfevaltask as
select t.*
       ,''2'' as rectifytype,
       a.amt1 as budgetamount,  --全年预算数
       a.amt3 as execratenum,  --调整后预算数
       a.amt4 as execamount, --预算执行数
       to_date(t.evalend, ''yyyymmdd'') -
       to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') warndays,
       decode(s.score,null,0,s.score) score,
       s.selfresult,
       s.warn
  from v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join (select mainguid,sum(amt1)as amt1, sum(amt3)as amt3, sum(amt4)as amt4 from v_perf_t_selfprofund group by mainguid) a on a.mainguid = t.guid
  where 1=1'
;