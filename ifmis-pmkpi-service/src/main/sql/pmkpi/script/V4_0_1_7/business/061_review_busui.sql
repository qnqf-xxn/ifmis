begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/review/report/list') and t.code in('batchadd','modprogram');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C9FA52DAFA842E9DE0533315A8C0319A', '/pmkpi/review/report/list', '批量提交送审', 1, 15, 'searchicon', 'pmkpireviewreport.batchadd', null, '批量提交送审', 'pmkpi', 'batchadd', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CAFEB343556F591DE0533315A8C05C95', '/pmkpi/review/report/list', '修改项目', 1, 16, 'searchicon', 'pmkpireviewreport.modProgram', null, '修改项目', 'pmkpi', 'modprogram', null, '{}');

--绩效目标评审填报
--项目支持
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/review/report/proedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C96DB7F5377B396EE0533315A8C0BF98', '/pmkpi/review/report/proedit', '关闭', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'colse', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C96DB7F5377A396EE0533315A8C0BF98', '/pmkpi/review/report/proedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', 'save', null, '{}');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/review/report/proedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53EFE2EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53EFF2EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '资金明细', 'bugamt', 0, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '资金明细', null, '保存', '{viewtype:''query''}', null, '0', 'mxdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53F002EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '绩效目标', 'progoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, '保存', '{url:''/pmkpi/program/report/protabgoal.page?showtab=1'',viewtype:''query''}', null, '0', 'iframegoal', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C7D80EC0308933E053B11FA8C0A5D6', 'pmkpi', '/pmkpi/review/report/proedit', '绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标', null, null, '{url:''/pmkpi/review/report/proindex.page'',busguid:''B9D9531D6EEEF12BE053B11FA8C045BC'',tablecode:''v_pm_perf_goal_info'',action:''pmkpireviewproindex.save''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53F022EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '附件管理', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''reviewreport'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C96DB7F53738396EE0533315A8C0BF98', 'pmkpi', '/pmkpi/review/report/proedit', '绩效指标(安徽)', 'indexopinion', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标(安徽)', null, null, '{url:''/pmkpi/review/opinion/proindex.page?showtab=1'',action:''prjtreeindex.save''}', null, '0', 'indexopinioniframe', null, null, null, null, null, null);

--部门整体
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/review/report/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C4CE9FABDB277FE053B11FA8C0A853', 'pmkpi', '/pmkpi/review/report/deptedit', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C4CE9FABDC277FE053B11FA8C0A853', 'pmkpi', '/pmkpi/review/report/deptedit', '年度任务', 'bugamt', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度任务', null, '保存', '{viewtype:''query''}', null, '0', 'mxdatatable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9DE0C5A5F485F71E053B11FA8C0DEB0', 'pmkpi', '/pmkpi/review/report/deptedit', '绩效目标', 'progoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, '保存', '{viewtype:''query''}', null, '0', 'goaleditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9DE0C5A5F475F71E053B11FA8C0DEB0', 'pmkpi', '/pmkpi/review/report/deptedit', '绩效指标', 'yearindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标', null, null, '{url:''/pmkpi/review/report/proindex.page'',busguid:''B9D9531D6EEEF12BE053B11FA8C045BC'',tablecode:''v_bgt_perf_goal_info'',action:''pmkpireviewproindex.save''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C4CE9FABDD277FE053B11FA8C0A853', 'pmkpi', '/pmkpi/review/report/deptedit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C9A7EEAF7DEF320EE0533315A8C03A7D', 'pmkpi', '/pmkpi/review/report/deptedit', '绩效指标(安徽)', 'indexopinion', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标(安徽)', null, null, '{url:''/pmkpi/review/opinion/deptindex.page?showtab=1'',action:''prjtreeindex.save''}', null, '0', 'indexopinioniframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/review/report/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C9A7EEAF7DED320EE0533315A8C03A7D', '/pmkpi/review/report/deptedit', '关闭', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'colse', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C9A7EEAF7DEE320EE0533315A8C03A7D', '/pmkpi/review/report/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', 'save', null, '{}');


--绩效指标审核意见填写
--项目支出
delete from p#busfw_t_uieditform t where t.key in('/pmkpi/review/opinion/index');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C9A7EEAF7D67320EE0533315A8C03A7D', '/pmkpi/review/opinion/index', 'PERF_T_AUDITMAIN', 's', 'guid', 'GUID', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C9A7EEAF7D68320EE0533315A8C03A7D', '/pmkpi/review/opinion/index', 'PERF_T_AUDITMAIN', 'textarea', '审核意见', 'REMARK', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C9A7EEAF7D69320EE0533315A8C03A7D', '/pmkpi/review/opinion/index', 'PERF_T_AUDITMAIN', 'tree', '审核结论', 'CONCLUSION', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{format:"#name"}', null, null, null);