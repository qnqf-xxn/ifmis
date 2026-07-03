begin

--删除重复数据
delete from perf_t_customauditview a where (province,code,guid) 
in (select province,code,guid from perf_t_customauditview group by province,code,guid having count(*) > 1)
   and rowid not in (select min(rowid) from perf_t_customauditview group by province,code,guid having count(*) > 1);

--删除分区同步配置
delete from bus_t_settmp t where upper(tablecode) like '%PERF_T_CUSTOMAUDITVIEW%';

--删除结转
delete from busfw_t_nextyeartable where appid='pmkpi' and upper(tablecode) like '%PERF_T_CUSTOMAUDITVIEW%';

execute immediate '
create or replace view v_perf_t_customauditview as
select *
from PERF_T_CUSTOMAUDITVIEW where  province = global_multyear_cz.Secu_f_GLOBAL_PARM(''DIVID'')';
