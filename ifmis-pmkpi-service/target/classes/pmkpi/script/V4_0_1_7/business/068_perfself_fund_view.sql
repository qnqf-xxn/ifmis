begin
  -- 自评（项目） 预算执行情况取数试图
  execute immediate 'create or replace view v_perf_selfbdgpay_project as
select t.name as name, --资金来源
       (case when t.name = ''预算内'' then 1
        when t.name = ''其他资金'' then 2
          when t.name = ''专户资金'' then 3
        else 9
       end) as ordernum, -- 资金的排序
       t.pro_code, -- 项目编码唯一
       max(t.amt1) as AMT1, -- 年初预算
       sum(t.amt2) as AMT2, -- 调整预算
       (sum(t.amt2) + max(t.amt1)) as AMT3, -- 调整后预算（调整预算之和+年初预算）
       sum(t.amt4) as AMT4, -- 全年执行数
       decode((sum(t.amt2) + max(t.amt1)),
              0,
              0,
              round(sum(t.amt4) / (sum(t.amt2) + max(t.amt1))*100, 2)) as BGTGET, -- 预算执行率（实际执行数/调整后预算数）
       '''' as SCORE, --自评得分
       t.year,
       t.province
  from PERF_T_PROFUND t
 WHERE t.month <= PERF_FUNDPAY_VIEW.get_month
   and t.pro_code = PERF_FUNDPAY_VIEW.get_procode
   and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
   and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
 group by t.name, t.pro_code, t.year, t.province
 ';  
    
 -- 自评（部门） 预算执行情况取数试图
  execute immediate'
  CREATE OR REPLACE VIEW V_PERF_SELFBDGPAY_DEPT AS
SELECT k.name,
       (case
         when k.name = ''预算内'' then
          1
         when k.name = ''其他资金'' then
          2
         when k.name = ''专户资金'' then
          3
         else
          9
       end) as ordernum, -- 资金的排序
       k.agencyguid,
       sum(k.AMT1) as AMT1, --各个项目的年初预算总和
       sum(k.AMT2) as AMT2,
       (sum(k.AMT1) + sum(k.AMT2)) as AMT3,
       sum(k.AMT4) as AMT4,
       decode((sum(k.AMT1) + sum(k.AMT2)),
              0,
              0,
              round(sum(k.AMT4) / (sum(k.AMT1) + sum(k.AMT2))*100, 2)) as BGTGET, -- 预算执行率（实际执行数/调整后预算数）
       '''' as SCORE, -- 得分
       k.year, k.province
  FROM (select t.name as name, --资金来源

               t.pro_code, -- 部门内部的项目
               t.agencyguid, -- 部门编码
               max(t.amt1) as AMT1, -- 年初预算，相同项目的明细应该是一样的
               sum(t.amt2) as AMT2, -- 调整预算
               (sum(t.amt2) + max(t.amt1)) as AMT3, -- 调整后预算（调整预算之和+年初预算）
               sum(t.amt4) as AMT4, -- 全年执行数
               t.year,
               t.province
          from PERF_T_PROFUND t
         WHERE t.month <= PERF_FUNDPAY_VIEW.get_month
           and t.agencyguid = PERF_FUNDPAY_VIEW.get_agencyguid
           and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
           and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
         group by t.name, t.agencyguid, t.pro_code, t.year, t.province) k
 group by k.name, k.agencyguid,k.year, k.province
';