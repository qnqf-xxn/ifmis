begin

update bus_t_diccolumn t set t.datalength=(select a.datalength from fasp_t_diccolumn a where a.columncode=t.columncode and a.tablecode='V_PM_PROJECT_INFO') where t.tablecode='PERF_PROJECT_INFO';
update perf_t_impexpsub t set t.columncode='pro_code' where t.mainguid='program' and t.name='ÏîÄ¿±àÂë';
