begin

  --÷ÿππ ”Õº
  execute immediate '
  create or replace view v_bas_perf_indicator as
  select t.*
  FROM BAS_PERF_INDICATOR T
  WHERE province = global_multyear_cz.v_pmdivid and is_deleted =2
  ';
