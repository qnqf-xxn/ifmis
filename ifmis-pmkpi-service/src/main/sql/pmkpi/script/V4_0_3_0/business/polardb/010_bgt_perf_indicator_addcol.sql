begin

--÷ÿππ ”Õº
execute immediate '
create or replace view v_bgt_perf_indicator as
select * from bgt_perf_indicator
where year = global_multyear_cz.v_pmyear
      and province = global_multyear_cz.v_pmdivid and is_deleted = 2
';
