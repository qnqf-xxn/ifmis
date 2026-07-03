begin
  
execute immediate '
create or replace view v_perf_index_code as
select *
FROM PERF_INDEX_CODE T WHERE province = global_multyear_cz.v_pmdivid';