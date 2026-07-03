begin
  --添加按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/evaluation/financial/check';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3697C274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/check', '确定', 1, 1, 'Keepicon', 'financialprocheck.save', null, '确定', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3697D274CE0533315A8C0ACDD', '/pmkpi/evaluation/financial/check', '取消', 1, 3, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3697D274CE0533315A8C0ACD0', '/pmkpi/evaluation/financial/check', '查看项目明细', 1, 2, 'searchicon', 'financialprocheck.queryView', null, '查看项目明细', 'pmkpi', null, null, null);



delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E7E8F16FCFD14C9DE0533315A8C0D443', '/pmkpi/rectification/check/proj', '确定(批量)', 1, 2, 'addaction', 'rectificationcheck.add', null, '确定(批量)', 'pmkpi', '确定(批量)', null, '{checkbox:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E7E8F16FCFD24C9DE0533315A8C0D443', '/pmkpi/rectification/check/proj', '确定(单个)', 1, 1, 'addaction', 'rectificationcheck.add', null, '确定(单个)', 'pmkpi', '确定(单个)', null, '{checkbox:false}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E7E8F16FCFD34C9DE0533315A8C0D443', '/pmkpi/rectification/check/proj', '关闭', 1, 4, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3697D274CE0533315A8C0AC21', '/pmkpi/rectification/check/proj', '查看项目明细', 1, 3, 'addaction', 'rectificationcheck.detailed', null, '查看项目明细', 'pmkpi', '查看项目明细', null, null);

delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E7E8F16FCFD44C9DE0533315A8C0D443', '/pmkpi/rectification/check/deptproj', '确定(批量)', 1, 1, 'addaction', 'rectificationcheck.add', null, '确定(批量)', 'pmkpi', '确定(批量)', null, '{checkbox:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E7E8F16FCFD54C9DE0533315A8C0D443', '/pmkpi/rectification/check/deptproj', '确定(单个)', 1, 2, 'addaction', 'rectificationcheck.add', null, '确定(单个)', 'pmkpi', '确定(单个)', null, '{checkbox:false}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E3697D274CE0533315A8C0AC22', '/pmkpi/rectification/check/deptproj', '查看项目明细', 1, 3, 'addaction', 'rectificationcheck.detailed', null, '查看项目明细', 'pmkpi', '查看项目明细', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E7E8F16FCFD64C9DE0533315A8C0D443', '/pmkpi/rectification/check/deptproj', '关闭', 1, 4, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);

