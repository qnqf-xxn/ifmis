begin

--¥¥Ω® ”Õº
execute immediate '
create or replace view v_perf_t_proindextracetemp as
select * from perf_t_proindextracetemp
where year = global_multyear_cz.v_pmyear and province = global_multyear_cz.v_pmdivid
';
