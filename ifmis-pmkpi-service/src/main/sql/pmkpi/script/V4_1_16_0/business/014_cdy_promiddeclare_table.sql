begin
  
execute immediate '
create or replace view v_perf_t_promiddeclare as
select t.*, decode(a.code,null,''·ñ'',''ÊÇ'') as iscase
 from v_perf_t_deptperfmiddeclare t
 left join v_perf_t_case a on t.pro_code=a.code and t.province=a.province';
