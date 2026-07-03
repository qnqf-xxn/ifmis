begin
  --指标推荐  推荐案例视图
  execute immediate '
create or replace view perf_v_case as
select *
 FROM PERF_T_CASE T
      WHERE T.PROVINCE = global_multyear_cz.Secu_f_Global_Parm(''DIVID'')
      and t.wfstatus=''011'' and t.is_deleted=2 and t.status <> ''3''';
