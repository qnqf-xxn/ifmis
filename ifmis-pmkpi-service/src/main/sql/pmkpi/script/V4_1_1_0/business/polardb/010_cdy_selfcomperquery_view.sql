  i number;
  v_sql varchar2(2000);
  ln_i integer;
begin
  
v_sql :='
create or replace view v_perf_selfproject_comper as
select t.pro_code as guid,t.pro_code,t.pro_name as name,t.agencyguid,t.province,'''' as year,
mof_dep_code as finintorgguid,bgt_mof_dep_code as manage_mof_dep_code,pro_start_year,pro_term,t.pro_total_amt
from pm_project_info t where t.is_backup=2 and nvl(t.lastaudit, 2) = 1 and t.is_deleted=2
and t.province = global_multyear_cz.v_pmdivid
and exists(select 1 from perf_t_selfevaltask a where a.pro_code=t.pro_code and a.bustype=''program'' and a.is_deleted=2)
and to_number(t.pro_term)>1
and to_number(t.pro_start_year) - 1 + to_number(t.pro_term)>=to_number(global_multyear_cz.v_pmyear)';

select fn_alterview('V_PERF_SELFPROJECT_COMPER',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;

v_sql :='
create or replace view v_perf_selfcomper_query as
--查询项目
select t.*
       ,null as budgetamount,null as bgtamt,null as execamount,null as bgtget,null as score,null as selfresult,
       ''1'' as levelno,
       ''0'' as isleaf,
       ''0'' superid,
       ''program'' as bustype
  from v_perf_selfproject_comper t
union all
--获取自评（根据项目范围过滤）
select t.guid,
       t.pro_code,
       b.name,
       b.agencyguid,
       t.province,to_char(t.year),b.finintorgguid,t.manage_mof_dep_code,'''' as pro_start_year,'''' as pro_term,
       null as pro_total_amt,t.budgetamount,t.bgtamt,t.execamount,t.bgtget,a.score,a.selfresult,
       ''2'' as levelno,
       ''1'' as isleaf,
       t.pro_code as superid,
       t.bustype
  from perf_t_selfevaltask t
  left join perf_t_selfperfdesc a on a.mainguid = t.guid
  left join v_perf_selfproject_comper b on b.pro_code=t.pro_code
 where t.is_deleted=2 and t.bustype = ''program''
   and t.pro_code = b.pro_code';

select fn_alterview('V_PERF_SELFCOMPER_QUERY',v_sql) into ln_i;
if ln_i = 0 then
	return;
end if;
