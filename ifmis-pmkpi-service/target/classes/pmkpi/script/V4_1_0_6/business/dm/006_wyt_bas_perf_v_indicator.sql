begin
  --湖北部门指标库查询视图
execute immediate '
create or replace view bas_perf_v_indicator as
select t.*,
       t1.name as PRONAME
  FROM BAS_PERF_INDICATOR T
  left join V_PERF_T_INDEXCOMFUNC t1
    on t.pro_name = t1.GUID
 WHERE t.province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')
   and t.is_deleted = 2';
