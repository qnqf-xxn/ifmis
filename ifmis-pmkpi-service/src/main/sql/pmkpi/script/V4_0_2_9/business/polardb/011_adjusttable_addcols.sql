begin

--2.÷ÿππ ”Õº
execute immediate '
create or replace view v_perf_t_adjust as
select * from perf_t_adjust t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid';
