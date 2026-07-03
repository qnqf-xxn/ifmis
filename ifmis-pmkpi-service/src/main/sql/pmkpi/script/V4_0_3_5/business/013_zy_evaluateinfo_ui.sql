begin
  
delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply/edit' and code = 'selfinfo';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/apply/edit', '评价基本信息', 'selfinfo', 0, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '评价基本信息', null, null, '{url:''/pmkpi/perfself/apply/edit/selfinfo.page'',action:''selfinfo.save''}', null, '0', 'selfinfoiframe', null, null, null, null, null, null, null, null);



delete from p#busfw_t_uieditform where key = '/pmkpi/perfself/apply/edit/selfinfo';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '关联id', 'MAINGUID', 0, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '主键ID', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '项目名称', 'NAME', 1, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 'tree', '项目资金性质', 'FUND_TYPE_CODE', 1, null, 0, null, 5, null, null, 'pmkpi', 1, 0, '{"format":"#name","isMulti":true}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 'tree', '评价类型', 'EVALUATE_TYPE', 1, null, 0, null, 4, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 'tree', '评价组织实施方式', 'EVALUATE_MODE', 1, null, 0, null, 6, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '评价结论(分数)', 'SCORE', 1, null, 0, null, 8, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '第三方机构名称', 'INSTITUTION_NAME', 1, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 'tree', '线上线下', 'LINES', 1, null, 0, null, 10, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '评价结论(等级)', 'GRADE', 1, null, 0, null, 9, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);




delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply/dept/edit' and code = 'deptselfinfo';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '评价基本信息', 'deptselfinfo', 0, 11, 'nomal', 'tabfreamedit.clickTabpage', null, '评价基本信息', null, null, '{url:''/pmkpi/perfself/apply/editdept/selfinfo.page'',action:''selfinfo.save''}', null, '0', 'deptselfinfoiframe', null, null, null, null, null, null, null, null);



delete from p#busfw_t_uieditform where key = '/pmkpi/perfself/apply/editdept/selfinfo';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '评价结论(等级)', 'GRADE', 1, null, 0, null, 6, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '评价结论(分数)', 'SCORE', 1, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '第三方机构名称', 'INSTITUTION_NAME', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 'tree', '评价组织实施方式', 'EVALUATE_MODE', 1, null, 0, null, 3, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '部门名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '主键ID', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfinfo', 'V_PERF_T_EVALUATEINFO', 's', '关联id', 'MAINGUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);



delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/financial/result/edit' and columncode in ('NAME','LINES','INSTITUTION_NAME','EVALUATE_MODE','FUND_TYPE_CODE','EVALUATE_TYPE');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 's', '名称', 'NAME', 0, null, 0, null, 8, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'tree', '评价类型', 'EVALUATE_TYPE', 0, null, 0, null, 9, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'tree', '项目资金性质', 'FUND_TYPE_CODE', 0, null, 0, null, 10, null, null, 'pmkpi', 1, 0, '{"format":"#name","isMulti":true}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'tree', '评价组织实施方式', 'EVALUATE_MODE', 0, null, 0, null, 11, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 's', '第三方机构名称', 'INSTITUTION_NAME', 0, null, 0, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'tree', '线上线下', 'LINES', 0, null, 0, null, 13, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0, null, null, null);


