i number;
begin  
--绩效自评表
 select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='PRO_TOTAL_AMT';
    if i=0 then
       execute immediate 'alter table PERF_T_SELFEVALTASK add(PRO_TOTAL_AMT NUMBER(20,2))';
    end if;
 select count(1) into i from user_tab_cols t where t.table_name='PERF_T_SELFEVALTASK' and t.column_name='BGTAMT';
    if i=0 then
       execute immediate 'alter table PERF_T_SELFEVALTASK add(BGTAMT NUMBER(20,2))';
    end if;   

--重构视图
execute immediate 'create or replace view v_perf_t_selfevaltask as
select * 
  from PERF_T_SELFEVALTASK t
 where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
  and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2';

--自评列表取数视图  
execute immediate '
create or replace view perf_v_selfevaltask as
select
    t.*,
    ''2'' as rectifytype,
    a.amt1 as budgetamount,  --全年预算数
    a.amt3 as execratenum,  --调整后预算数
    a.amt4 as execamount, --预算执行数
    case
     when to_date(t.evalend, ''yyyymmdd'') < to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'') then 0
     else to_date(t.evalend, ''yyyymmdd'') - to_date(to_char(sysdate, ''yyyymmdd''), ''yyyymmdd'')
    end warndays, --截止天数
    decode(s.score,null,0,s.score) score,
    s.selfresult,
    s.warn
from
    v_perf_t_selfevaltask t
    left join v_perf_t_selfperfdesc s on s.mainguid = t.guid
    left join (select mainguid,sum(amt1)as amt1, sum(amt3)as amt3, sum(amt4)as amt4 from v_perf_t_selfprofund group by mainguid) a on a.mainguid = t.guid
';
