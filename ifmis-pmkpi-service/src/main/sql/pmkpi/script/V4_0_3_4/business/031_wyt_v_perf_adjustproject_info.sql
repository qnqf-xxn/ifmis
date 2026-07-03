      --选择项目视图
  i number;
  begin
  execute immediate '
  create or replace view v_perf_adjustproject_info as
  select t.*
    from v_perf_project_info t
   where t.wfstatus=''011''';

  select count(*) into i from user_views  t where t.VIEW_NAME='V_BGT_PM_ANNUAL';
  if i=1 then
    execute immediate '
    create or replace view v_perf_adjustproject_info as
      select t.*,
      t1.CUR_AMT as bgtamt   --当年预算金额
        from v_perf_project_info t
        left join ( select pro_code, sum(CUR_AMT) as CUR_AMT   --变动后预算数
         from v_bgt_pm_annual where is_deleted = 2 group by pro_code)t1
         on t.PRO_CODE = t1.PRO_CODE
       where exists (select 1
                from v_bgt_pm_annual an  --部门预算项目
               where an.is_deleted = ''2''
                 and an.pro_code = t.pro_code
                 and an.pro_code is not null)
      union
      select t.*,
      t2.CUR_AMT as bgtamt  --当年预算金额
        from v_perf_project_info t
         left join  ( select pro_code,sum(CUR_AMT) as CUR_AMT  --变动后预算数
         from v_bgt_tra where is_deleted = 2 group by pro_code)t2
         on t.PRO_CODE = t2.PRO_CODE
         where exists (select 1
         from v_bgt_tra b  --转移支付项目
         where  b.IS_DELETED = ''2''
          and b.PRO_CODE = t.PRO_CODE
          and b.FIN_AUDIT_MONEY > 0) ';
  end if;
