begin

execute immediate ' 
create or replace view perf_v_queryallindex as
select guid,findex,sindex,''''tindex,code from v_bas_perf_indicator
union all
select guid,findex,sindex,tindex,code from v_bgt_perf_indicator
union all
select guid,findex,sindex,tindex,code from v_pm_perf_indicator
union all
select guid,findex,sindex,tindex,code from v_perf_t_adjustindex
union all
select guid,findex,sindex,tindex,code from v_perf_t_casemodelindex';
