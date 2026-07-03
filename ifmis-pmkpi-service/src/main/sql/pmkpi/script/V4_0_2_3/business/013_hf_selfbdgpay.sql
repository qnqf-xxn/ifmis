begin
  -- 合肥单独用的 自评预算执行情况取数视图 -- 项目
  execute immediate'
  create or replace view v_perf_selfbdgpay_project_hf as
select t.name as name, --资金来源
       (case when t.name = ''当年财政资金'' then 1
        when t.name = ''上年结转资金'' then 2
          when t.name = ''其他资金'' then 3
        else 9
       end) as ordernum, -- 资金的排序
       t.pro_code, -- 项目编码唯一
       max(t.amt1) as AMT1, -- 年初预算数
       sum(t.amt3) as AMT3, -- 全年预算数
       sum(t.amt4) as AMT4, -- 全年执行数
       decode((sum(t.amt3)),
              0,
              0,
              round(sum(t.amt4) / (sum(t.amt3))*100, 2)) as BGTGET, -- 预算执行率（全年执行数/全年预算数）
       t.year,
       t.province
  from PERF_T_PROFUND t
 WHERE t.month <= PERF_FUNDPAY_VIEW.get_month
   and t.pro_code = PERF_FUNDPAY_VIEW.get_procode
   and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
   and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
 group by t.name, t.pro_code, t.year, t.province';
