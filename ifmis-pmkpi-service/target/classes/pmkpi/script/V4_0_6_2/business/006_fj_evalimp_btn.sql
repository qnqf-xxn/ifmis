begin

--财政评价项目确定 项目导入按钮 默认隐藏
delete from p#busfw_t_uifunction t where t.KEY ='/pmkpi/evaluation/financial/proconfirm' and CODE ='importProData';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/proconfirm', '项目导入', 0, 16, 'searchicon', 'finproconfirm.importProData', null, '项目导入', 'pmkpi', 'importProData', null, '{importcode:''eval_financial'',vchtypeid:''FD0EBF45FECB42C9E0533315A8C0C28A''}', null, null,'87',2016);

--部门评价项目申报 项目导入按钮 默认隐藏
delete from p#busfw_t_uifunction t where t.KEY ='/pmkpi/evaluation/dept/report' and CODE ='importProData';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG,PROVINCE,YEAR)
values (sys_guid(), '/pmkpi/evaluation/dept/report', '项目导入', 0, 16, 'searchicon', 'deptproconfirm.importProData', null, '项目导入', 'pmkpi', 'importProData', null, '{importcode:''eval_dept'',vchtypeid:''FD1D49A8156977D3E0533315A8C08A63''}', null, null,'87',2016);


--财政评价项目确定 项目导入按钮 切换隐藏配置修改
delete from perf_t_treetab where key ='/pmkpi/evaluation/financial/proconfirm';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E202901F2CE0533315A8C01584', '/pmkpi/evaluation/financial/proconfirm', 'program', '项目支出', 1, null, 1, 2016, '87', 'BD2785454440A0C1E053B11FA8C0DCF9', 'programfinconfirmhide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CF3C5CCB439E3375E0533315A8C0E201', '/pmkpi/evaluation/financial/proconfirm', 'dept', '部门整体', 1, '审核情况,新增项目,项目导入', 2, 2016, '87', 'BD2785454442A0C1E053B11FA8C0DCF9', 'deptfinconfirmhide');

--部门评价项目申报 项目导入按钮 切换隐藏配置修改
delete from perf_t_treetab where key ='/pmkpi/evaluation/dept/report';

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('CBFFE5E252901F2CE0533315A8C01588', '/pmkpi/evaluation/dept/report', 'program', '项目支出', 1, null, 1, 2016, '87', 'BE2FB8A81CF30A3DE053B11FA8C0BF96', 'programdeptevaluationreporthide');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values ('F16B24858FF06DFEE0533315A8C03225', '/pmkpi/evaluation/dept/report', 'dept', '部门整体', 1, '查看项目明细,项目导入', 2, 2016, '87','BE2FB8A81CF40A3DE053B11FA8C0BF96', 'deptdeptevaluationreporthide');
