begin
  --天津预算执行情况  分层级取数视图
  execute immediate'
  create or replace view v_perf_fund_tj as
select t.name as name, --资金来源
       t.isedit as isedit,
       (case when t.name =''年度资金总额'' then 1
        when t.name =''财政资金'' then 2
          when t.name =''其他资金'' then 2
        else 3
       end) as levelno, --层级
       (case when t.name =''年度资金总额'' then ''sumamt''
        when t.name =''财政资金'' then ''finamt''
          when t.name =''其他资金'' then ''otheramt''
        else t.guid
       end)  as code, --编码
       (case when t.name =''年度资金总额'' then ''''
        when t.name =''财政资金'' then ''sumamt''
          when t.name =''其他资金'' then ''sumamt''
        else ''finamt''
       end) as superguid, --父级id
       t.ordernum, -- 资金的排序
       t.pro_code, -- 项目编码唯一
       max(t.amt1) as AMT1, -- 年初预算数
       sum(t.amt3) as AMT3, -- 调整后预算数
       sum(t.amt4) as AMT4, -- 1-X月执行数
       decode(sum(amt3),null,0,0,0,
              round(sum(t.amt4) / sum(t.amt3)*100,2)) as BGTGET,-- 预算执行率（1-X月执行数/调整后预算数）
       sum(t.amt5) as AMT5 --全年预计执行数
 from perf_t_profund t
 WHERE t.month <=PERF_FUNDPAY_VIEW.get_month
   and t.pro_code =PERF_FUNDPAY_VIEW.get_procode
   and year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
   and province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
 group by t.guid,t.name, t.pro_code, t.year, t.province,t.pro_name,t.ordernum,t.isedit';

