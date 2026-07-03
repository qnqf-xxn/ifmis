begin
--财政评价成果上传--结果应用情况--页签
--uitab
delete from busfw_t_uitabpage where key ='/pmkpi/evaluation/financial/result/edit' and code = 'evaluresult';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '结果应用情况', 'evaluresult', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '结果应用情况', null, null, '{url:''/pmkpi/evaluation/financial/evaluresult.page'',action:''evaluresult.save''}', null, '0', 'evaluresultiframe', null, null, null, null, null, null);

--uitable
delete from busfw_t_uitable where key = '/pmkpi/evaluation/financial/evaluresult';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 100, 0, 0, null, null, 'pmkpi', '{}');

--uiedit
delete from busfw_t_uieditform where key = '/pmkpi/evaluation/financial/evaluresult';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'tree', '专报省政府', 'ISREPORTGOVERNMENT', 1, null, 0, null, 1, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'tree', '上级领导批示', 'ISGOVERNMENTINSTRU', 1, null, 0, null, 2, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'tree', '报人大', 'ISREPORTNPC', 1, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'tree', '人大领导批示', 'ISNPCINSTRU', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'tree', '反馈部门', 'ISBACKDEPART', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'tree', '政策调整', 'ISPOLIADJUST', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'tree', '预算应用', 'ISBUDGEAPPLY', 1, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 0, 0, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/evaluresult', 'V_PERF_T_EVALURESULT', 'textarea', '其他', 'OTHERREMARK', 1, null, 0, null, 8, 3, '4', 'pmkpi', 1, null, '{}', null, null, null, null);











