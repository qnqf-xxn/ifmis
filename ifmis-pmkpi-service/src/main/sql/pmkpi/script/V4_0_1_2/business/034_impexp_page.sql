begin

delete from bus_t_pagecomponent t where t.id in('pmkpiimpexp');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpiimpexp', '绩效导入导出', null, '绩效导入导出', '/pmkpi/perfcommon/impexp/impexp_a.js,/pmkpi/common/perfutil.js', 'Ext.lt.pmkpi.impexp_a', 'pmkpi', 'pmkpi.perfcommon.impexp.ImpExpAComponet');

