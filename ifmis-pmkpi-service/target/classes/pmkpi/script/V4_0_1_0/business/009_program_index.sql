begin

delete from p#busfw_t_uifunction t where key in('/pmkpi/program/report/treeindex') and t.guid='C053501D18D20BCBE053B11FA8C0736E';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C053501D18D20BCBE053B11FA8C0736E', '/pmkpi/program/report/treeindex', '复制总体绩效指标', 1, 9, 'keepicon', 'Ext.lt.pmkpi.copytotalindex', null, '复制总体绩效指标', 'pmkpi', 'copytotalindex', null, null);

