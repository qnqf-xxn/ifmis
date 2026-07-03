begin
 
  --÷ÿππ ”Õº
  execute immediate'
  create or replace view v_perf_t_evaluation as
  select *
       from PERF_T_EVALUATION
          where YEAR= global_multyear_cz.v_pmyear and
          PROVINCE = global_multyear_cz.v_pmdivid';
