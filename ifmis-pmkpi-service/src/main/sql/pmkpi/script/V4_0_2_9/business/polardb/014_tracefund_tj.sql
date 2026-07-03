begin
   
    --÷ÿππ ”Õº
    execute immediate'
    create or replace view v_perf_t_probgtfund as
select t.*
      from perf_t_probgtfund t  where YEAR= global_multyear_cz.v_pmyear
      and PROVINCE = global_multyear_cz.v_pmdivid';
