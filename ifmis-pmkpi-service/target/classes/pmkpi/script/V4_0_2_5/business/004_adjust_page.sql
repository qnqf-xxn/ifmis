begin
   
delete from bus_t_pagecomponent where id ='pmkpi_adjusteditquery';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjusteditquery', '绩效目标调整查询', null, '绩效目标调整查询', '/pmkpi/adjust/editquery/editqueryservice.js', 'Ext.lt.pmkpi.adjust.editqueryservice', 'pmkpi', 'pmkpi.adjust.editquery.EditQueryService');
