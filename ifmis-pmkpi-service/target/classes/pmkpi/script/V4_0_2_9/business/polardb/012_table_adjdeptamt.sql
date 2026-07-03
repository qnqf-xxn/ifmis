begin

--¥¥Ω® ”Õº
execute immediate '
create or replace view V_PERF_T_ADJDEPTAMT as
select * from PERF_T_ADJDEPTAMT
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid
';