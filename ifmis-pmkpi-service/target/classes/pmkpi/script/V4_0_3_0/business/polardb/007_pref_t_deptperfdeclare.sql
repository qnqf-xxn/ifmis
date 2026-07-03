begin
    
    --÷ÿππ ”Õº
    execute immediate'create or replace view v_perf_t_deptperfdeclare as
select *
    from PERF_T_DEPTPERFDECLARE t where year = global_multyear_cz.v_pmyear
      and province = global_multyear_cz.v_pmdivid';
