begin


delete from P#BUSFW_T_UITABLE t where t.key in('/pmkpi/evaluation/financial/deptcheck');
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD2A3B90E5163AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'PERF_T_DEPTPERFDECLARE', 100, 0, 0, 'code', null, 'pmkpi', null);
