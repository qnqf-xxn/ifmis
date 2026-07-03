begin

--2.重构视图
execute immediate '
create or replace view v_perf_t_adjustindex as
select * from PERF_T_ADJUSTINDEX t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid';


--2.重构视图
execute immediate '
create or replace view v_perf_t_adjustgoal as
select * from perf_t_adjustgoal t
where YEAR = global_multyear_cz.v_pmyear and PROVINCE = global_multyear_cz.v_pmdivid';
