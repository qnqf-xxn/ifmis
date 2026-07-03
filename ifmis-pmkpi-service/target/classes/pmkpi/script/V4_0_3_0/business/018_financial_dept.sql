begin

delete from P#BUSFW_T_UITABLE t where key='/pmkpi/evaluation/financial/deptcheck';
insert into BUSFW_T_UITABLE (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30F6B274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/deptcheck', 'V_PERF_T_DEPTPERFDECLARE', 100, 0, 0, 'code', null, 'pmkpi', null);

