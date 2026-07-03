begin
--财政评价项目审核页面添加 发起整改 按钮（默认隐藏)
delete from p#busfw_t_uifunction where key ='/pmkpi/evaluation/financial/audit' and code ='rectify';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3B52A3C9C52407E053B11FA8C01730', '/pmkpi/evaluation/financial/audit', '发起整改', 0, 10, 'searchicon', 'finevalaudit.rectify', null, '发起整改', 'pmkpi', 'rectify', null, '{}');

--财政评价成果审核页面删除 下达整改通知 按钮
delete from p#busfw_t_uifunction t where t.key ='/pmkpi/evaluation/financial/resultaudit' and title ='下达整改通知';


--部门评价项目审核页面添加 发起整改 按钮（默认隐藏)
delete from p#busfw_t_uifunction where key ='/pmkpi/evaluation/dept/audit' and code ='rectify';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('PPPB52A3C9C52407E053B11FA8C01731', '/pmkpi/evaluation/dept/audit', '发起整改', 0, 5, 'searchicon', 'deptaudit.rectify', null, '发起整改', 'pmkpi', 'rectify', null, '{}');


