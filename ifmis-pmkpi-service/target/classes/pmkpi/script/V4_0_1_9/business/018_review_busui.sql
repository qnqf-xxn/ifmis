begin
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/review/report/list') and code ='export';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BDB38A62B8A6FFF1E053B11FA8C04B84', '/pmkpi/review/report/list', '导出', 0, 14, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出', 'pmkpi', 'export', null, '{"bobeanid":"pmkpi.perfreview.PerfReviewBOTX"}');
