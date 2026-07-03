begin
--随机抽取管理-按钮注册
delete from p#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/random/index' and code = 'del';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', '删除', 1, 1, 'searchicon', 'randomcommentrandom.del', null, '删除', 'pmkpi', 'del', null, '{}','2016','87');

--随机抽取管理-页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/randomcomment/randoms';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/randoms', '待抽取', '1', 1, 1, 'choosed', 'randomcommentrandom.clickTabpage', null, '待抽取', 'wait', '删除', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/randoms', '已抽取', '2', 1, 2, 'nomal', 'randomcommentrandom.clickTabpage', null, '已抽取', 'done', '随机抽取设置,开始抽取', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

--范围标识-页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/randomcomment/scope';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/scope', '待标识', '1', 1, 1, 'choosed', 'randomcommentscope.clickTabpage', null, '待标识', 'toident', '删除', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/scope', '已标识', '2', 1, 2, 'nomal', 'randomcommentscope.clickTabpage', null, '已标识', 'isident', '提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');


--抽评对象确定-页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/randomcomment/object';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/object', '待提交', '1', 1, 1, 'choosed', 'randomcommentobject.clickTabpage', null, '待提交', 'waitaudit', '撤销已提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/object', '已提交', '2', 1, 2, 'nomal', 'randomcommentobject.clickTabpage', null, '已提交', 'alreadyaudit', '选择已有项目,提交,删除', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/object', '曾经办', '3', 0, 3, 'nomal', 'randomcommentobject.clickTabpage', null, '曾经办', 'alldeals', '选择已有项目,提交,删除,撤销已提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');


--绩效抽评委托-页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/randomcomment/entrust';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/entrust', '待提交', '1', 1, 1, 'choosed', 'randomcommententrust.clickTabpage', null, '待提交', 'waitaudit', '撤销已提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/entrust', '已提交', '2', 1, 2, 'nomal', 'randomcommententrust.clickTabpage', null, '已提交', 'alreadyaudit', '委托第三方', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

--随机抽取设置
delete from P#busfw_t_uieditform where key ='/pmkpi/randomcomment/randomAdd';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/randomAdd', 'PERF_T_RANDOM', 's', '主键ID', 'GUID', 0, '', 0, '', 0, null, '', 'pmkpi', 0, null, '{}', null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/randomAdd', 'PERF_T_RANDOM', 's', '抽取项目数量(优,良,中,差)', 'RANDOM', 1, '', 1, '', 2, null, '', 'pmkpi', 1, null, '{}', null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/randomAdd', 'PERF_T_RANDOM', 's', '待抽取项目数量(优,良,中,差)', 'RANDOMPROJ', 1, '', 0, '', 1, null, '', 'pmkpi', 0, null, '{}', null, null, null,'2016','87');


--抽评质量评分主表更新
update p#BUSFW_t_uitable set tablecode = 'V_PERF_RANDOMQUALITY' where key = '/pmkpi/randomcomment/result/edit/randomQualityEdit';
--抽评质量评分副标更新
update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:false,nogroupbox:true,name:''质量模板'',edit:true,checkbox:false,title:''质量模板'', groupcols:[''guid'',''superid'',''qualityname'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,tabcode:''V_PERF_T_RANDOMQUALITY_SCORE'',tabcode1:''V_PERF_RANDOMQUALITY_TYPE'',tabcode2:''V_PERF_T_RANDOMQUALITY_MENU''}'
where url = '/pmkpi/randomcomment/result/edit/randomQualityEdit' and componentid = 'busuidatatable';

--删除抽评废弃字段
delete from p#busfw_T_uicolumn where key = '/pmkpi/randomcomment/result/index' and columncode in ('BUDGETGOALCREATOR','PROJTYPE');
delete from p#busfw_T_uicolumn where key = '/pmkpi/randomcomment/entrust/index' and columncode in ('BUDGETGOALCREATOR','PROJTYPE');
delete from p#busfw_T_uicolumn where key = '/pmkpi/randomcomment/object/index' and columncode in ('BUDGETGOALCREATOR','PROJTYPE');
delete from p#busfw_T_uicolumn where key = '/pmkpi/randomcomment/query/index' and columncode in ('BUDGETGOALCREATOR','PROJTYPE');
delete from p#busfw_T_uicolumn where key = '/pmkpi/randomcomment/random/index' and columncode in ('BUDGETGOALCREATOR','PROJTYPE');
delete from p#busfw_T_uicolumn where key = '/pmkpi/randomcomment/scope/index' and columncode in ('BUDGETGOALCREATOR','PROJTYPE');
