begin

update p#busfw_t_uifunction t set t.action='Ext.lt.pmkpi.expdata' where key='/pmkpi/deptperformance/audit/index' and t.code='export';

update p#busfw_t_uifunction t set t.action='Ext.lt.pmkpi.expdata' where key='/pmkpi/deptperformance/report/index' and t.code='export';

update p#busfw_t_uifunction t set t.action='Ext.lt.pmkpi.expdata' where t.key='/pmkpi/deptperformance/query/index' and t.code='export';
