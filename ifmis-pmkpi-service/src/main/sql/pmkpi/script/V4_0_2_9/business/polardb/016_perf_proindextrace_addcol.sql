begin     

execute immediate '
create or replace view v_perf_t_proindextrace as
select * FROM PERF_T_PROINDEXTRACE 
WHERE province = global_multyear_cz.v_pmdivid and year = global_multyear_cz.v_pmyear';
