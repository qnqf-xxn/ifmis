begin

--绩效目标调整填报
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/report');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662BB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/adjust/report', '曾经办', 'alldeals', 1, 3, 'nomal', 'adjustreport.clickTabpage', 0, '曾经办', null, '调整,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662CB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/adjust/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'adjustreport.clickTabpage', 0, '已送审', null, '调整,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/adjust/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'adjustreport.clickTabpage', 0, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/report');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C6AF05E29E637CE053B11FA8C06B90', '/pmkpi/adjust/report', '选择项目', 1, 1, 'searchicon', 'adjustreport.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F5984661AB918E053B11FA8C0831D', '/pmkpi/adjust/report', '调整', 1, 2, 'searchicon', 'adjustreport.adjustment', null, '调整', 'pmkpi', 'toEdit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F59846619B918E053B11FA8C0831D', '/pmkpi/adjust/report', '送审', 1, 3, 'searchicon', 'adjustreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F5984661BB918E053B11FA8C0831D', '/pmkpi/adjust/report', '取消送审', 1, 4, 'searchicon', 'adjustreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F59846618B918E053B11FA8C0831D', '/pmkpi/adjust/report', '审核情况', 1, 5, 'searchicon', 'adjustreport.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616324744E053B11FA8C01BA3', '/pmkpi/adjust/report', '查看明细', 1, 6, 'searchicon', 'adjustreport.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

--项目列表
delete from p#busfw_t_uitable t where key in('/pmkpi/adjust/report/program');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B98F5984660DB918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'V_PERF_PROJECT_INFOQUERY', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/adjust/report/program');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9ED1F7009BF2EC2E053B11FA8C00E35', '/pmkpi/adjust/report/program', 'ADJUSTNUM', '调整次数', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8673863AE9D5B8E053B11FA8C03A82', '/pmkpi/adjust/report/program', 'WFSTATUS', '状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F5984660FB918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'PRO_CODE', '项目编码', 4, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F59846612B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'PRO_NAME', '项目名称', 5, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F5984660EB918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'AGENCYGUID', '预算单位', 6, 1, 0, 0, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F59846615B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'YEAR', '预算年份', 7, 1, 0, 0, null, null, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F59846610B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'CREATE_TIME', '填报时间', 9, 1, 0, 0, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F59846611B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'FININTORGGUID', '业务科室', 13, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F59846614B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'WFSTATUS', '审核状态', 15, 0, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F59846616B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'GUID', '主键', 15, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F59846613B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'WFID', '工作流id', 20, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/adjust/report/program');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9ED1F7009C32EC2E053B11FA8C00E35', '/pmkpi/adjust/report/program', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B98F59846620B918E053B11FA8C0831D', '/pmkpi/adjust/report/program', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);
delete from p#busfw_t_uitable t where key in('/pmkpi/adjust/report/dept');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9A266E250F8383EE053B11FA8C05B3C', '/pmkpi/adjust/report/dept', 'V_PERF_DEPT_INFOQUERY', 100, 0, 0, null, null, 'pmkpi', null);

--部门列表
delete from p#busfw_t_uicolumn t where key in('/pmkpi/adjust/report/dept');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9ED1F7009C02EC2E053B11FA8C00E35', '/pmkpi/adjust/report/dept', 'ADJUSTNUM', '调整次数', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 60, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8673863AE8D5B8E053B11FA8C03A82', '/pmkpi/adjust/report/dept', 'WFSTATUS', '状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9A266E250F3383EE053B11FA8C05B3C', '/pmkpi/adjust/report/dept', 'CODE', '单位编码', 3, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9A266E250F4383EE053B11FA8C05B3C', '/pmkpi/adjust/report/dept', 'NAME', '单位名称', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9A266E250F5383EE053B11FA8C05B3C', '/pmkpi/adjust/report/dept', 'LINKMAN', '联系人', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9A266E250F6383EE053B11FA8C05B3C', '/pmkpi/adjust/report/dept', 'YEAR', '预算年度', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9A266E250F2383EE053B11FA8C05B3C', '/pmkpi/adjust/report/dept', 'GUID', 'guid', 10, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/adjust/report/dept');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9ED1F7009C52EC2E053B11FA8C00E35', '/pmkpi/adjust/report/dept', 'CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B98F5984661EB918E053B11FA8C0831D', '/pmkpi/adjust/report/dept', 'NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', '{}', null);


--选择项目
delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/report/check');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C975E5A7F2F59EE053B11FA8C05A36', '/pmkpi/adjust/report/check', '确定', 1, 1, 'Keepicon', 'adjustreportcheck.save', null, '确定', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C975E5A7F3F59EE053B11FA8C05A36', '/pmkpi/adjust/report/check', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

--编辑区
--项目
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/report/proedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9B1886CA78600A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/adjust/report/proedit', '基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{busguid:''B9B1886CA7A400A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/info.page''}', null, '0', 'infoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9B1886CA78700A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/adjust/report/proedit', '资金明细', 'bugamt', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '资金明细', null, '保存', '{busguid:''B9B1886CA7A500A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/bgtamt.page''}', null, '0', 'bgtamtiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9B1886CA78800A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/adjust/report/proedit', '绩效目标调整', 'progoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标调整', null, null, '{busguid:''B9B1886CA7A600A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/goal.page'',action:''adjustgoal.save''}', null, '0', 'progoaliframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9B1886CA78900A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/adjust/report/proedit', '绩效指标调整', 'proindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整', null, null, '{busguid:''B9B1886CA7A700A1E053B11FA8C0DBA4'',url:''/pmkpi/adjust/report/proedit/index.page'',action:''adjustindex.save''}', null, '0', 'proindexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9B1886CA78A00A1E053B11FA8C0DBA4', 'pmkpi', '/pmkpi/adjust/report/proedit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/report/proedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9B1886CA7B800A1E053B11FA8C0DBA4', '/pmkpi/adjust/report/proedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9B1886CA7B900A1E053B11FA8C0DBA4', '/pmkpi/adjust/report/proedit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

--基础信息
delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/proedit/info');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9B4E70E0FE242E9E053B11FA8C0D47C', '/pmkpi/adjust/report/proedit/info', 'V_PERF_T_ADJUST', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9B4E70E0FE342E9E053B11FA8C0D47C', '/pmkpi/adjust/report/proedit/info', 'V_PERF_T_ADJUST', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

--调整目标
delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/proedit/goal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C975E5A810F59EE053B11FA8C05A36', '/pmkpi/adjust/report/proedit/goal', 'V_PERF_T_ADJUSTGOAL', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C975E5A811F59EE053B11FA8C05A36', '/pmkpi/adjust/report/proedit/goal', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整前年度绩效目标', 'KPI_TARGET', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C975E5A812F59EE053B11FA8C05A36', '/pmkpi/adjust/report/proedit/goal', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整后年度绩效目标', 'ADJUSTNDGOAL', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--调整指标
delete from p#busfw_t_uitable t where key in('/pmkpi/adjust/report/proedit/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9C975E5A8ECF59EE053B11FA8C05A36', '/pmkpi/adjust/report/proedit/index', 'V_PM_PERF_INDICATOR', 0, 1, 0, null, ' (yearflag <> 1 or yearflag is null)', 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/adjust/report/proedit/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4AD4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4AE4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'OBLIGATE3', '操作', 2, 0, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9D8BDAA8AB0DDAEE053B11FA8C04101', '/pmkpi/adjust/report/proedit/index', 'STATUS', '数据状态', 2, 1, 0, 0, null, 0, null, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4AC4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'NAME', '指标名称', 3, 1, 0, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4A54655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'EXPLAIN', '公式或说明', 4, 0, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4A44655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'COMPUTESIGN', '计算符号', 9, 1, 0, 0, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4A84655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'INDEXVAL', '指标值', 10, 1, 0, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4AB4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'METERUNIT', '计量单位', 11, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C975E5A904F59EE053B11FA8C05A36', '/pmkpi/adjust/report/proedit/index', 'ADJUSTINDEXVAL', '调整后指标值', 11, 1, 1, 1, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4AA4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B24655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'WEIGHT', '权重', 16, 0, 0, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4A94655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'ISLINKED', '是否为与预算总额挂钩产出指标', 17, 0, 0, 0, null, 0, null, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4AF4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'RULE', '赋分原则', 18, 0, 0, 0, null, 0, 6, null, null, null, null, 180, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B54655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'KPI_REMARK', '目标值说明', 19, 1, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C975E5A906F59EE053B11FA8C05A36', '/pmkpi/adjust/report/proedit/index', 'ADJUSTREMARK', '调整说明', 20, 0, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4A64655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B04655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4A74655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B14655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B34655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'KPI_CONTENT', '指标内容', 27, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA167C07B4B44655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'KPI_EVALSTD', '扣分标准', 28, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/report/edit/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA0A0BDBBC07FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/edit/index', '精准推荐', 0, 1, 'keepicon', 'adjustindex.recom', null, '精准推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA0A0BDBBC08FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/edit/index', '新增指标', 1, 2, 'keepicon', 'adjustindex.add', null, '新增指标', 'pmkpi', 'add', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA0A0BDBBC09FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/edit/index', '修改指标', 1, 3, 'keepicon', 'adjustindex.mod', null, '修改指标', 'pmkpi', 'mod', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA0A0BDBBC0AFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/edit/index', '删除指标', 1, 4, 'keepicon', 'adjustindex.del', null, '删除指标', 'pmkpi', 'del', null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/proedit/index');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA167C07B4BC4655E053B11FA8C02221', '/pmkpi/adjust/report/proedit/index', 'V_PERF_T_ADJUST', 'textarea', '调整说明', 'ADJUSTREMARK', 1, null, 1, null, 2, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--项目指标编辑
delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/report/edit/editindex');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA0A0BDBBC25FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/edit/editindex', '保存', 1, 1, 'Keepicon', 'adjusteditindex.save', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA0A0BDBBC26FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/edit/editindex', '取消', 1, 2, 'Nofinishicon', 'adjusteditindex.close', null, '取消', 'pmkpi', null, null, null);

--部门
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/report/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9D8BDAA8B28DDAEE053B11FA8C04101', 'pmkpi', '/pmkpi/adjust/report/deptedit', '基本信息', 'deptinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{busguid:''B9D8BDAA8B2DDDAEE053B11FA8C04101'',url:''/pmkpi/adjust/report/deptedit/info.page''}', null, '0', 'infoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9D8BDAA8B29DDAEE053B11FA8C04101', 'pmkpi', '/pmkpi/adjust/report/deptedit', '年度任务', 'yeartask', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度任务', null, '保存', '{busguid:''B9D8BDAA8B2EDDAEE053B11FA8C04101'',url:''/pmkpi/adjust/report/deptedit/task.page''}', null, '0', 'yeartaskiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9D8BDAA8B2ADDAEE053B11FA8C04101', 'pmkpi', '/pmkpi/adjust/report/deptedit', '绩效目标调整', 'deptgoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标调整', null, null, '{busguid:''B9D8BDAA8B2FDDAEE053B11FA8C04101'',url:''/pmkpi/adjust/report/deptedit/goal.page'',action:''adjustgoal.save''}', null, '0', 'deptgoaliframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9D8BDAA8B2BDDAEE053B11FA8C04101', 'pmkpi', '/pmkpi/adjust/report/deptedit', '绩效指标调整', 'deptindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标调整', null, null, '{busguid:''B9D8BDAA8B30DDAEE053B11FA8C04101'',url:''/pmkpi/adjust/report/deptedit/index.page'',action:''adjustindex.save''}', null, '0', 'deptindexiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9D8BDAA8B2CDDAEE053B11FA8C04101', 'pmkpi', '/pmkpi/adjust/report/deptedit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/report/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9D8BDAA8B0ADDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9D8BDAA8B0BDDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

--基础信息
delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/deptedit/info');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B31DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/info', 'V_PERF_T_ADJUST', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B32DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/info', 'V_PERF_T_ADJUST', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

--调整目标
delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/deptedit/goal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B64DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B65DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整前年度绩效目标', 'KPI_TARGET', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B66DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整后年度绩效目标', 'ADJUSTNDGOAL', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--调整指标
delete from p#busfw_t_uitable t where key in('/pmkpi/adjust/report/deptedit/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9D8BDAA8B82DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/index', 'V_BGT_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/adjust/report/deptedit/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF5FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCEBFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'STATUS', '数据状态', 2, 1, 0, 0, null, 0, null, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF6FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'OBLIGATE3', '操作', 2, 0, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF4FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'NAME', '指标名称', 3, 1, 0, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCEDFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'EXPLAIN', '公式或说明', 4, 0, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCECFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'COMPUTESIGN', '计算符号', 9, 1, 0, 1, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF0FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'INDEXVAL', '指标值', 10, 1, 0, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF3FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'METERUNIT', '计量单位', 11, 1, 0, 1, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCE9FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'ADJUSTINDEXVAL', '调整后指标值', 11, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF2FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCFAFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'WEIGHT', '权重', 16, 0, 0, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF1FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'ISLINKED', '是否为与预算总额挂钩产出指标', 17, 0, 0, 0, null, 0, null, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF7FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'RULE', '赋分原则', 18, 0, 0, 0, null, 0, 6, null, null, null, null, 180, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCFDFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'KPI_REMARK', '目标值说明', 19, 1, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCEAFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'ADJUSTREMARK', '调整说明', 20, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCEEFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF8FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCEFFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCF9FD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCFBFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'KPI_CONTENT', '指标内容', 27, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA0A0BDBBCFCFD6DE053B11FA8C09B70', '/pmkpi/adjust/report/deptedit/index', 'KPI_EVALSTD', '扣分标准', 28, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/adjust/report/deptedit/index');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA167C07B4BE4655E053B11FA8C02221', '/pmkpi/adjust/report/deptedit/index', 'V_PERF_T_ADJUST', 'textarea', '调整说明', 'ADJUSTREMARK', 1, null, 1, null, 2, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--审核
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/adjust/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662BB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/adjust/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'adjustaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662CB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/adjust/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'adjustaudit.clickTabpage', 0, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F5984662DB918E053B11FA8C0831D', 'pmkpi', '/pmkpi/adjust/audit', '审核', 'waitaudit', 1, 1, 'choosed', 'adjustaudit.clickTabpage', 0, '审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/audit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616974744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '审核', 1, 1, 'searchicon', 'adjustaudit.audit', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616994744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '取消审核', 1, 2, 'searchicon', 'adjustaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E616964744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '审核情况', 1, 3, 'searchicon', 'adjustaudit.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DD48E6169A4744E053B11FA8C01BA3', '/pmkpi/adjust/audit', '查看明细', 1, 4, 'searchicon', 'adjustaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

--查询
delete from p#busfw_t_uifunction t where key in('/pmkpi/adjust/query');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9ED1F70095B2EC2E053B11FA8C00E35', '/pmkpi/adjust/query', '审核情况', 1, 3, 'searchicon', 'adjustquery.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9ED1F70095C2EC2E053B11FA8C00E35', '/pmkpi/adjust/query', '查看明细', 1, 4, 'searchicon', 'adjustquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
