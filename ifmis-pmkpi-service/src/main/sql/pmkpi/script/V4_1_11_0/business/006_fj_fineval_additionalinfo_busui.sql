begin

delete from p#busfw_t_uieditform where key ='/pmkpi/evaluation/financial/additionalinfo';

insert into p#busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/additionalinfo', 'V_PERF_T_EVALADDITIONALINFO', 'tree', '被评价单位', 'EVALEDAGENCY', 1, null, 0, null, 1, 2, null, 'pmkpi', 1, null, '{"format":"#code-#name","isMulti":true}', null, null, null, '87', '2016', null, null, null);

insert into p#busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/additionalinfo', 'V_PERF_T_EVALADDITIONALINFO', 'amtinput', '评价分数', 'EVALSCORE', 1, null, 1, null, 2, 1, null, 'pmkpi', 1, null, null, null, null, null, '87', '2016', null, null, null);

insert into p#busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/additionalinfo', 'V_PERF_T_EVALADDITIONALINFO', 'textarea', '其他情况', 'OTHERINFO', 1, null, 0, null, 3, 3, '4', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);


delete from p#busfw_t_uitabpage where key in('/pmkpi/evaluation/finconfirm/proedit','/pmkpi/evaluation/financial/deptfill/proedit','/pmkpi/evaluation/financial/result/edit') and code ='addinfo';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/financial/deptfill/proedit', '评价补充信息', 'addinfo', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '评价补充信息', null, null, '{url:''/pmkpi/evaluation/financial/additionalinfo.page'',action:''additionalinfo.save''}', null, '0', 'addinfoiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '评价补充信息', 'addinfo', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '评价补充信息', null, '保存', '{url:''/pmkpi/evaluation/financial/additionalinfo.page?viewtype=query''}', null, '0', 'addinfoiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评价补充信息', 'addinfo', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '评价补充信息', null, '保存', '{url:''/pmkpi/evaluation/financial/additionalinfo.page?viewtype=query''}', null, '0', 'addinfoiframe', null, null, null, null, null, '87', '2016', null, null, null);


delete from perf_t_pagemenu t where t.uikey='/pmkpi/evaluation/financial/additionalinfo';

insert into perf_t_pagemenu (GUID, CODE, NAME, UIKEY, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, STATUS, CREATETIME, UPDATETIME, CREATER, PROVINCE, YEAR)
values (sys_guid(), '4', '评价补充信息', '/pmkpi/evaluation/financial/additionalinfo', 'D613341C95491822E0533315A8C006A3', 5, 1, 4, 1, '20251015134423', '20251015134436', '2ABB1E119E395E6EEC48EFA9D6ABB0CD', '87', '2016');



