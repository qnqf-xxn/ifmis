begin

delete from p#busfw_t_uifunction t where key in('/pmkpi/indexlib/list') and t.code in('uncommonimport','commonimport');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C0EC31E8095EF7D9E053B11FA8C07BC8', '/pmkpi/indexlib/list', '个性绩效指标导入', 1, 5, 'searchicon', 'indexlib.import', null, '个性绩效指标导入', 'pmkpi', 'uncommonimport', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C0EC31E8095AF7D9E053B11FA8C07BC8', '/pmkpi/indexlib/list', '共性绩效指标导入', 1, 4, 'searchicon', 'indexlib.import', null, '共性绩效指标导入', 'pmkpi', 'commonimport', null, '{}');

