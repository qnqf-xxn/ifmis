begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/indexlib/list','/pmkpi/indexlib/deptlist','/pmkpi/index/audit','/pmkpi/index/query') and t.code in('expdata','export');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/list', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/index/audit', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/index/query', '导出列表', 1, 10, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdata', null, '{}');

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/indexlib/list') and t.code='tranpayimport';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/list', '转移支付绩效指标导入', 1, 6, 'searchicon', 'indexlib.import', null, '转移支付绩效指标导入', 'pmkpi', 'tranpayimport', null, '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/indexlib/list') and t.columncode in('INDEXTRANPAY');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/indexlib/list', 'INDEXTRANPAY', '专项资金名称', 9, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{iscommon:"2"}', null);

update p#busfw_t_uicolumn t set t.config='{iscommon:"0",lefttype:"INDEXTRANPAY"}' where t.key in('/pmkpi/indexlib/list') and t.columncode in('INDEXCATEGORIES'); 