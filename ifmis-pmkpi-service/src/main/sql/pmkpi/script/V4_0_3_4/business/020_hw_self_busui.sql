begin

update perf_t_treetab set hidebtns = '查看项目,导出项目自评表,导出项目支出支出绩效自评表（河北）' where key = '/pmkpi/perfself/query' and code='dept';

update perf_t_treetab set hidebtns = '查看项目' where key = '/pmkpi/perfself/apply' and code = 'dept';
