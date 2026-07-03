  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  
v_sql :='create or replace view V_PERF_T_PROMIDDECLARE as
select t.*, decode(a.code,null,''·ñ'',''ÊÇ'') as iscase
 from v_perf_t_deptperfmiddeclare t
 left join v_perf_t_case a on t.pro_code=a.code and t.province=a.province';
select fn_alterview('V_PERF_T_PROMIDDECLARE',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;