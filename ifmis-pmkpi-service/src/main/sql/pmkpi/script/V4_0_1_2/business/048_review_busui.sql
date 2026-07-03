begin

delete from busfw_t_uifunction t where key in('/pmkpi/review/report/list') and t.name='导入评审意见';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BDB38A62B8A5FFF1E053B11FA8C04B84', '/pmkpi/review/report/list', '导入评审意见', 1, 13, 'searchicon', 'pmkpireviewreport.import', null, '导入评审意见', 'pmkpi', 'import', null, '{expfilename:''绩效目标评审意见''}');

