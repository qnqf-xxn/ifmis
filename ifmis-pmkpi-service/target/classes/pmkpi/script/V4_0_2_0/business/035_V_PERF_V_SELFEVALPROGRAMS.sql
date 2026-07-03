begin

execute immediate '
CREATE OR REPLACE VIEW V_PERF_V_SELFEVALPROGRAMS AS
SELECT nvl(tsk.GUID,sys_guid()) as guid,
       pro.guid as projguid,
       pro.pro_code,
       pro.pro_name as name,
       pro.agencyguid,
       pro.mof_dep_code as finintorgguid,
       pro.YEAR,
       pro.PROVINCE,
       pro.projectkind as prokind,
       1 as bustype,
       pro.pro_cat_code as procategory,
       pro.exp_func_code as func,
       pro.WFSTATUS as WFSTATUS,
       tsk.remainingdays,
       tsk.evalend,
       tsk.evalstart,
       tsk.evalstatus,
       tsk.UPDATETIME,
       tsk.WFID,
       a.amt1 as BUDGETAMOUNT,  --全年预算数
       a.amt3 as EXECRATENUM,  --调整后预算数
       a.amt4 as EXECAMOUNT, --预算执行数
       a.bgtget as EXECRATE --预算执行率
  FROM v_perf_adjustproject_info pro  --项目guid
    left join v_perf_t_selfevaltask tsk on pro.pro_code = tsk.pro_code
    left join (select pro_code, nvl(sum(amt1),0) amt1, nvl(sum(amt3),0) amt3, nvl(sum(amt4),0) amt4, to_char(sum(amt4) / decode((sum(amt2) + sum(amt1)),0,1,(sum(amt2) + sum(amt1))) * 100, ''FM990.00'') bgtget from v_perf_t_selfprofund group by pro_code) a on a.pro_code = tsk.pro_code'
    ;
