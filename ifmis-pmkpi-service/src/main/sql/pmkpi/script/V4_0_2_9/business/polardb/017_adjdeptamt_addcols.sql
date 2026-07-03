begin

--2.÷ÿππ ”Õº
execute immediate '
create or replace view v_perf_t_adjdeptamt as
select * from PERF_T_ADJDEPTAMT t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid
 and is_deleted = 2';
