begin
  
execute immediate 'create or replace view v_perf_t_prosourcefund as
select '''' as pro_code, '''' as pro_name, '''' as agencyguid, '''' as name, '''' as amt1, '''' as amt2, '''' as amt3
 from dual t';
