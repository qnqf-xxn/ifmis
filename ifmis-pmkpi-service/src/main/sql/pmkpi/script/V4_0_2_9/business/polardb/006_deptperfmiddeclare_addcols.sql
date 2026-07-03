begin

--÷ÿππ ”Õº
execute immediate '
create or replace view V_PERF_T_DEPTPERFMIDDECLARE as
select * from perf_t_deptperfmiddeclare
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid
';

