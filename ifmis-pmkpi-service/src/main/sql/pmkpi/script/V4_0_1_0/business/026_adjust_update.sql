begin
delete from p#busfw_t_uifunction where key = '/pmkpi/adjust/report' and name = '删除项目';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F5984661BB918E053B11FA8C08PPP', '/pmkpi/adjust/report', '删除项目', 1, 7, 'searchicon', 'adjustreport.deladjust', null, '删除项目', 'pmkpi', 'deladjust', null, '{}');

update p#busfw_t_uitabpage t set t.HIDEBTNS = '调整,送审,删除项目' where t.title = '已送审' and key = '/pmkpi/adjust/report';
update p#busfw_t_uitabpage t set t.HIDEBTNS = '调整,送审,取消送审,删除项目' where t.title = '曾经办' and key = '/pmkpi/adjust/report';

update p#busfw_t_uicolumn t set t.isedit=1 where key in('/pmkpi/adjust/report/proedit/index') and t.columncode='INDEXVAL';