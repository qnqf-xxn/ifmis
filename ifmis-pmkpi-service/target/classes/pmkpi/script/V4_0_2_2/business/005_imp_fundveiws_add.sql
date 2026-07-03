begin
  execute immediate '
  create or replace view v_perf_fund_impproject as
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
       t.year,
       t.province
  from PERF_T_PROFUND t
 WHERE t.month <= PERF_FUNDPAY_VIEW.get_month
   and exists (select 1 from PERF_TMP_GUIDS s where t.pro_code = s.code)
   and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
   and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
 group by t.name, t.pro_code, t.year, t.province
  ';