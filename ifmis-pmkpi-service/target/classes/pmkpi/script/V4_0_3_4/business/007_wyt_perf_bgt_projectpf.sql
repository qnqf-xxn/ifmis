begin
  --重构试图 (绩效批复查询视图)
execute immediate '
 CREATE OR REPLACE VIEW PERF_BGT_V_PROJECTPF AS
select t.*
  ,nvl(b.bgtamt,0) bgtamt  --当年预算金额
  from PERF_BGT_PROJECTPF t  --批复项目表
  left join (SELECT p.pro_code, REPLY_AMT as bgtamt
                FROM 
                (Select t.PRO_CODE, sum(REPLY_AMT) REPLY_AMT --批复数
                     from V_BGT_PM_ANNUAL t --部门预算项目
                       where t.is_deleted = 2
                         and taskguid in (''A69147082E975D0733386A42C3E5F4B5'', ''9EE3A842793449818960559B00660C1B'')
                       group by t.PRO_CODE
                       
                      Union all
                      
                      Select t.PRO_CODE, sum(REPLY_AMT) REPLY_AMT --批复数
                        from V_BGT_TRA t --转移支付项目
                       where t.is_deleted = 2
                       group by t.PRO_CODE) p) b
       on t.PRO_CODE = b.PRO_CODE
      where t.year = global_multyear_cz.Secu_f_GLOBAL_PARM(''YEAR'')
    and t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'') and t.is_deleted = 2
    ';
