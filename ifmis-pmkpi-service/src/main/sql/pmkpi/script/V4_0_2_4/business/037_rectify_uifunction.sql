begin 
delete from p#busfw_t_uifunction where key in('/pmkpi/rectification/programAdd','/pmkpi/rectification/deptAdd');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DA2B705B99452100E0533315A8C01D6A', '/pmkpi/rectification/deptAdd', '保存并下发', 1, 2, null, 'addprogram.saveaudit', null, '保存并下发', 'pmkpi', 'audit', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36BBD274CE0533315A8C0ACDD', '/pmkpi/rectification/deptAdd', '保存', 0, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36BBE274CE0533315A8C0ACDD', '/pmkpi/rectification/deptAdd', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D9C4261289087117E0533315A8C0B939', '/pmkpi/rectification/programAdd', '保存并下发', 1, 2, null, 'addprogram.saveaudit', null, '保存并下发', 'pmkpi', 'audit', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36BBB274CE0533315A8C0ACDD', '/pmkpi/rectification/programAdd', '保存', 0, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E36BBC274CE0533315A8C0ACDD', '/pmkpi/rectification/programAdd', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');


delete from p#busfw_t_uifunction where key in('/pmkpi/rectification/program/add','/pmkpi/rectification/dept/add');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E368B8274CE0533315A8C0ACDD', '/pmkpi/rectification/program/add', '保存', 0, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E368B9274CE0533315A8C0ACDD', '/pmkpi/rectification/program/add', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E368CA274CE0533315A8C0ACDD', '/pmkpi/rectification/program/add', '保存并下发', 1, 2, null, 'addprogram.saveaudit', null, '保存并下发', 'pmkpi', 'audit', null, '{}');


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E369CF274CE0533315A8C0ACDD', '/pmkpi/rectification/dept/add', '保存', 0, 0, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E369D0274CE0533315A8C0ACDD', '/pmkpi/rectification/dept/add', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E369D1274CE0533315A8C0ACDD', '/pmkpi/rectification/dept/add', '保存并下发', 1, 2, null, 'addprogram.saveaudit', null, '保存并下发', 'pmkpi', 'audit', null, '{}');


delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/financialAdd';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D22E75969C2A8EE0533315A8C01269', '/pmkpi/rectification/financialAdd', '保存', 0, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D22E75969D2A8EE0533315A8C01269', '/pmkpi/rectification/financialAdd', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3D3E368CA274CE0533315A8C0AC90', '/pmkpi/rectification/financialAdd', '保存并下发', 1, 2, null, 'addprogram.saveaudit', null, '保存并下发', 'pmkpi', 'audit', null, '{}');



delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/program/add','/pmkpi/rectification/dept/add');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3795C274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/program/add', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并下发', '{url:''/pmkpi/rectification/program/proinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E3795D274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37966274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并下发', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A63274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/dept/add', '基本信息', 'proinfo', 1, 1, 'choosed', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并下发', '{url:''/pmkpi/rectification/program/deptinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A64274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并下发', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A65274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/programAdd','/pmkpi/rectification/deptAdd');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A32274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/programAdd', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并下发', '{url:''/pmkpi/rectification/program/proinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A33274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/programAdd', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A76274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/programAdd', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并下发', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378F3274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/deptAdd', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并下发', '{url:''/pmkpi/rectification/program/deptinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378F4274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/deptAdd', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378F5274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/deptAdd', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并下发', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitabpage where key ='/pmkpi/rectification/financialAdd';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E7596992A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financialAdd', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E75969A2A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financialAdd', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并下发', '{url:''/pmkpi/evaluation/financial/confirm/editor.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D22E75969B2A8EE0533315A8C01269', 'pmkpi', '/pmkpi/rectification/financialAdd', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并下发', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

