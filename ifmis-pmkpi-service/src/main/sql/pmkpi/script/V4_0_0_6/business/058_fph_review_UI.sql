begin

--绩效目标评审
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/report/program';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B98F5984660DB918E053B11FA8C0erfg', '/pmkpi/review/report/program', 'V_PERF_PRO_INFOREVIEW', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/report/program';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC61B11F07B530EDE053B11FA8C08DAC', '/pmkpi/review/report/program', 'ISCONFIRM', '是否确认', 1, 1, 0, 0, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D3C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474CFC0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D6C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D1C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D2C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'FININTORGGUID', '业务处室', 13, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D0C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'CREATER', '创建人', 14, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D7C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D5C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B98F570474D4C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/program', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9D9531D6EECF12BE053B11FA8C045BC', '/pmkpi/review/report/program', 'PROGUID', '评审表guid', 20, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/review/report/program';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F56F00E053B11FA8C05B38', '/pmkpi/review/report/program', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PRO_INFOREVIEW', '{}', null);


DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/report/dept';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9B648D940E66F00E053B11FA8C05B38', '/pmkpi/review/report/dept', 'V_PERF_DEPT_INFOREVIEW', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/report/dept';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F06F00E053B11FA8C05B38', '/pmkpi/review/report/dept', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC61B11F07B330EDE053B11FA8C08DAC', '/pmkpi/review/report/dept', 'ISCONFIRM', '是否确认', 1, 1, 0, 0, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F16F00E053B11FA8C05B38', '/pmkpi/review/report/dept', 'CODE', '单位编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F26F00E053B11FA8C05B38', '/pmkpi/review/report/dept', 'NAME', '单位名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F36F00E053B11FA8C05B38', '/pmkpi/review/report/dept', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F46F00E053B11FA8C05B38', '/pmkpi/review/report/dept', 'YEAR', '预算年度', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9D9531D6EEDF12BE053B11FA8C045BC', '/pmkpi/review/report/dept', 'PROGUID', '项目guid', 10, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/review/report/program';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F56F00E053B11FA8C05B38', '/pmkpi/review/report/program', 'PRO_NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PRO_INFOREVIEW', '{}', null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/review/report/list';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F570474DAC0DCE053B11FA8C0D7F5', '/pmkpi/review/report/list', '评审', 1, 5, 'searchicon', 'pmkpireviewreport.assess', null, '评审', 'pmkpi', 'assess', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DE0C5A5F375F71E053B11FA8C0DEB0', '/pmkpi/review/report/list', '取消委托专家', 0, 6, 'searchicon', 'pmkpireviewreport.cancelassess', null, '取消委托专家', 'pmkpi', 'cancelasse', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F570474D9C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/list', '审核情况', 0, 7, 'searchicon', 'pmkpireviewreport.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9DE0C5A5F375F71E053B11FA8C0DEB0', '/pmkpi/review/report/list', '委托专家', 0, 8, 'searchicon', 'pmkpireviewreport.entrustexpert', null, '委托专家', 'pmkpi', 'entrustexpert', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F570474D8C0DCE053B11FA8C0D7F5', '/pmkpi/review/report/list', '查询', 0, 9, 'searchicon', 'pmkpireviewreport.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9F230636A680C3CE053B11FA8C0BC80', '/pmkpi/review/report/list', '提交', 1, 10, 'searchicon', 'pmkpireviewreport.confirm', null, '提交', 'pmkpi', 'confirm', null, '{"flag":"1"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C7D80EC0418933E053B11FA8C0A5D6', '/pmkpi/review/report/list', '生成工作流', 0, 10, 'searchicon', 'pmkpireviewreport.create', null, '生成工作流', 'pmkpi', 'create', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BC61B11F07B230EDE053B11FA8C08DAC', '/pmkpi/review/report/list', '取消确认评审', 0, 11, 'searchicon', 'pmkpireviewreport.confirm', null, '取消确认评审', 'pmkpi', 'unconfirm', null, '{"flag":"2"}');

DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/review/report/list';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F570474DBC0DCE053B11FA8C0D7F5', 'pmkpi', '/pmkpi/review/report/list', '已确认', 'allconfirm', 1, 3, 'nomal', 'pmkpireviewreport.clickTabpage', 0, '已确认', ' t.type=''goal'' and t.isconfirm in (''1'',''2'')', '确认评审,评审,生成工作流,取消委托专家,委托专家', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B99D7BA8413C628AE053B11FA8C0BED3', 'pmkpi', '/pmkpi/review/report/list', '已处理', 'alreadyaudit', 1, 2, 'nomal', 'pmkpireviewreport.clickTabpage', 0, '已处理', ' t.type=''goal'' and t.isconfirm =''0''  or t.isconfirm is null', '评审,生成工作流,确认评审,委托专家', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B99D7BA8413D628AE053B11FA8C0BED3', 'pmkpi', '/pmkpi/review/report/list', '待处理', 'waitaudit', 1, 1, 'choosed', 'pmkpireviewreport.clickTabpage', 0, '待处理', ' t.type=''goal''', '取消委托专家', '{}', null, '0', null, null, null, null, null, null, null);


--项目绩效目标评审编辑页面
DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/review/report/proinfo';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABDE277FE053B11FA8C0A853', '/pmkpi/review/report/proinfo', 'V_PERF_PROJECT_INFO', 's', '项目名称', 'PRO_NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABDF277FE053B11FA8C0A853', '/pmkpi/review/report/proinfo', 'V_PERF_PROJECT_INFO', 's', '项目编号', 'PRO_CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE0277FE053B11FA8C0A853', '/pmkpi/review/report/proinfo', 'V_PERF_PROJECT_INFO', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/report/mxdatatable';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9DE0C5A5F3F5F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'V_PERF_T_OUTPAYPROJECT', 0, 1, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/report/mxdatatable';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F405F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 1, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F415F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'EXPFUNC', '功能科目', 2, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4FBA14C3FD42401F9CEF59F970EFFE71', '/pmkpi/review/report/mxdatatable', 'ECONOMIC', '经济科目', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F425F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'GOVECONOMIC', '政府经济科目', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F435F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'C1', '总计', 5, 1, 0, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F445F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'C2', '财政拨款', 6, 1, 0, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F455F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'C3', '经费拨款', 7, 1, 0, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F465F71E053B11FA8C0DEB0', '/pmkpi/review/report/mxdatatable', 'C6', '行政事业性收费', 8, 1, 0, null, null, null, null, null, null, null, null, null, 1, 'amt', '{}', null);


DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/review/report/progoal';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C7D80EC0318933E053B11FA8C0A5D6', '/pmkpi/review/report/progoal', 'V_PM_PERF_GOAL_INFO', 's', 'guid', 'GUID', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C7D80EC0328933E053B11FA8C0A5D6', '/pmkpi/review/report/progoal', 'V_PM_PERF_GOAL_INFO', 'textarea', '绩效中期目标', 'ZQGOAL', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C7D80EC0338933E053B11FA8C0A5D6', '/pmkpi/review/report/progoal', 'V_PM_PERF_GOAL_INFO', 'textarea', '年度绩效目标', 'KPI_TARGET', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/review/report/proedit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C7D80EC0308933E053B11FA8C0A5D6', 'pmkpi', '/pmkpi/review/report/proedit', '绩效指标', 'yearindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标', null, null, '{url:''/pmkpi/review/report/proindex.page'',busguid:''B9D9531D6EEEF12BE053B11FA8C045BC'',tablecode:''v_pm_perf_goal_info''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53EFE2EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53EFF2EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '资金明细', 'bugamt', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '资金明细', null, '保存', '{}', null, '0', 'mxdatatable', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53F002EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '绩效目标', 'progoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, null, '{viewtype:''query''}', null, '0', 'goaleditform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9BA5CC53F022EB4E053B11FA8C08954', 'pmkpi', '/pmkpi/review/report/proedit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);


--部门绩效目标评审编辑
DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/review/report/deptinfo';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE1277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '基本支出', 'BASICEXPEND', 1, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE2277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '项目支出', 'PROJEXPAMT', 1, null, 1, null, 14, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE3277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'textarea', '部门职能职责概述', 'FUNCDESC', 1, null, 0, null, 17, 3, '3', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE4277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE5277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门编号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE6277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE7277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系人', 'LINKMAN', 1, null, 1, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE8277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系电话', 'TELEPHONE', 1, null, 0, null, 4, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABE9277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '资金总额', 'BUDGETTOTAL', 1, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABEA277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '一般公共预算', 'BUDGETAMT', 1, null, 1, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABEB277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '政府性基金拨款', 'GOVEFUNCAMT', 1, null, 1, null, 13, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABEC277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '纳入专户管理的非税收入拨款', 'TAXRANAMT', 1, null, 1, null, 15, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9C4CE9FABED277FE053B11FA8C0A853', '/pmkpi/review/report/deptinfo', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '其他资金', 'OTHERFUND', 1, null, 1, null, 16, null, null, 'pmkpi', 0, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/report/perftask';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9DE0C5A5F395F71E053B11FA8C0DEB0', '/pmkpi/review/report/perftask', 'V_PERF_T_DEPTTASK', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/report/perftask';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F3A5F71E053B11FA8C0DEB0', '/pmkpi/review/report/perftask', 'OTHERFUND', '其他资金', 5, 1, 0, 0, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F3B5F71E053B11FA8C0DEB0', '/pmkpi/review/report/perftask', 'NAME', '任务名称', 1, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F3C5F71E053B11FA8C0DEB0', '/pmkpi/review/report/perftask', 'CONTEXT', '主要内容', 2, 1, 0, 0, null, null, 0, null, null, null, null, 500, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F3D5F71E053B11FA8C0DEB0', '/pmkpi/review/report/perftask', 'TOTALAMT', '总金额', 3, 1, 0, 0, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9DE0C5A5F3E5F71E053B11FA8C0DEB0', '/pmkpi/review/report/perftask', 'FINANCIALFUND', '财政资金', 4, 1, 0, 0, null, null, 0, '[''预算金额'']', null, null, null, 150, 0, 's', null, null);


DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/review/report/deptgoal';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9DE0C5A5F495F71E053B11FA8C0DEB0', '/pmkpi/review/report/deptgoal', 'BGT_PERF_GOAL_INFO', 's', 'guid', 'GUID', 0, null, 0, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('35D3r5A5F495F71E053B11FA8343fgf6', '/pmkpi/review/report/deptgoal', 'BGT_PERF_GOAL_INFO', 'textarea', '绩效目标', 'ZQGOAL', 0, null, 0, null, 1, 3, '3', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('reE0C5A5er5F71E053B11FA8C0DEB0t3', '/pmkpi/review/report/deptgoal', 'BGT_PERF_GOAL_INFO', 'textarea', '绩效目标', 'KPI_TARGET', 1, null, 0, null, 2, 3, '8', 'pmkpi', 0, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/review/report/deptedit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9DE0C5A5F475F71E053B11FA8C0DEB0', 'pmkpi', '/pmkpi/review/report/deptedit', '绩效指标', 'yearindex', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标', null, null, '{url:''/pmkpi/review/report/proindex.page'',busguid:''B9D9531D6EEEF12BE053B11FA8C045BC'',tablecode:''v_bgt_perf_goal_info''}', null, '0', 'iframeindextable', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9DE0C5A5F485F71E053B11FA8C0DEB0', 'pmkpi', '/pmkpi/review/report/deptedit', '绩效目标', 'progoal', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, null, '{viewtype:''query''}', null, '0', 'goaleditform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C4CE9FABDB277FE053B11FA8C0A853', 'pmkpi', '/pmkpi/review/report/deptedit', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C4CE9FABDC277FE053B11FA8C0A853', 'pmkpi', '/pmkpi/review/report/deptedit', '年度任务', 'bugamt', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度任务', null, '保存', '{}', null, '0', 'mxdatatable', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9C4CE9FABDD277FE053B11FA8C0A853', 'pmkpi', '/pmkpi/review/report/deptedit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);


---评审页面

DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/report/proindex';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9C7D80EC0198933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', 'V_PM_PERF_INDICATOR', 0, 1, 0, null, null, 'pmkpi', '{title:"绩效指标表"}');


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/report/proindex';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC01F8933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', 'TARGETVALUE', '中期目标值', 4, 0, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC0208933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', 'FINDEX', '一级指标', 1, 1, 0, 0, null, null, 1, null, '#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC0218933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', 'INDEXVAL', '年度目标值', 5, 1, 1, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC0228933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', 'NAME', '三级指标', 3, 1, 0, 0, null, null, 1, null, null, null, null, 350, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC0238933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', 'SINDEX', '二级指标', 2, 1, 0, 0, null, null, 1, null, '#name', null, null, 200, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC0248933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', 'WEIGHT', '权重', 9, 1, 1, 1, null, null, 1, null, null, null, null, 100, 1, 'amt', null, null);


DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/proreview';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9C7D80EC02A8933E053B11FA8C0A5D6', '/pmkpi/review/proreview', 'PERF_T_AUDITITEMS', 0, 0, 0, null, null, 'pmkpi', '{title:"绩效目标评审"}');


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/proreview';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC02B8933E053B11FA8C0A5D6', '/pmkpi/review/proreview', 'NAME', '审核类别', 1, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC02C8933E053B11FA8C0A5D6', '/pmkpi/review/proreview', 'CONTEXT', '评审内容', 2, 1, 0, 0, null, null, 1, null, null, null, null, 400, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC02D8933E053B11FA8C0A5D6', '/pmkpi/review/proreview', 'FREVIEW', '初审意见', 3, 1, 1, 0, null, null, 1, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC02E8933E053B11FA8C0A5D6', '/pmkpi/review/proreview', 'SREVIEW', '复审意见', 4, 1, 1, 0, null, null, 1, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9C7D80EC02F8933E053B11FA8C0A5D6', '/pmkpi/review/proreview', 'PROPOSAL', '备注', 5, 1, 1, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);


DELETE FROM P#busfw_t_Uieditform t where t.key= '/pmkpi/review/report/proindex';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9BA5CC53F062EB4E053B11FA8C08954', '/pmkpi/review/report/proindex', 'PERF_T_AUDITITEMS', 's', 'guid', 'GUID', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9BA5CC53F072EB4E053B11FA8C08954', '/pmkpi/review/report/proindex', 'PERF_T_AUDITITEMS', 'textarea', '修改完善意见（初审）', 'FOPINION', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9BA5CC53F082EB4E053B11FA8C08954', '/pmkpi/review/report/proindex', 'PERF_T_AUDITITEMS', 'textarea', '修改完善意见（复审）', 'SOPINION', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/review/report/proindex';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C7D80EC03F8933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', '保存', 1, 2, 'Keepicon', 'pmkpireviewproindex.save', null, '保存', 'pmkpi', 'save', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C7D80EC0408933E053B11FA8C0A5D6', '/pmkpi/review/report/proindex', '关闭', 1, 1, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'colse', null, '{}');

DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/review/report/proindex';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BC763EBA166FFC3BE053B11FA8C02423', 'pmkpi', '/pmkpi/review/report/proindex', '年度绩效指标', 'year', 1, 2, 'nomal', 'pmkpireviewproindex.clickTabpage', 0, '年度绩效指标', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BC763EBA1670FC3BE053B11FA8C02423', 'pmkpi', '/pmkpi/review/report/proindex', '总体绩效指标', 'total', 1, 1, 'choosed', 'pmkpireviewproindex.clickTabpage', 0, '总体绩效指标', null, null, '{}', null, '0', null, null, null, null, null, null, null);


--委托专家

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/review/entrust/expert';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F570474D8C0DCE053B11FA8C0D7F5', '/pmkpi/review/entrust/expert', '查询', 1, 5, 'searchicon', 'pmkpientrustexpert.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F570474D9C0DCE053B11FA8C0D7F5', '/pmkpi/review/entrust/expert', '确认勾选', 1, 1, 'searchicon', 'pmkpientrustexpert.sel', null, '确认勾选', 'pmkpi', 'sel', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B98F570474DAC0DCE053B11FA8C0D7F5', '/pmkpi/review/entrust/expert', '取消勾选', 1, 2, 'searchicon', 'pmkpientrustexpert.canceldel', null, '取消勾选', 'pmkpi', 'canceldel', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9C7D80EC0418933E053B11FA8C0A5D6', '/pmkpi/review/entrust/expert', '确认组长', 1, 4, 'searchicon', 'pmkpientrustexpert.group', null, '确认组长', 'pmkpi', 'group', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9F230636A670C3CE053B11FA8C0BC80', '/pmkpi/review/entrust/expert', '保存', 1, 6, 'searchicon', 'pmkpientrustexpert.entrust', null, '保存', 'pmkpi', 'entrust', null, '{}');


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/review/entrust/expert';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9E1D070EFC413CAE053B11FA8C0BAA7', '/pmkpi/review/entrust/expert', 'CREDITNO', '信用等级', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9E1D070EFC513CAE053B11FA8C0BAA7', '/pmkpi/review/entrust/expert', 'PROFESSIONAL', '专业技术职称', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9E1D070EFC613CAE053B11FA8C0BAA7', '/pmkpi/review/entrust/expert', 'NAME', '专家名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);


DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/entrust/selexpert';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9E1D070EFC813CAE053B11FA8C0BAA7', '/pmkpi/review/entrust/selexpert', 'V_PERF_EXPERTREVIEW', 100, 0, 0, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/review/entrust/selexpert';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2F35A6719C484F8441D271FD9A27752', '/pmkpi/review/entrust/selexpert', 'NAME', '专家名称', 1, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('817DC42F125420592457D1E007B2FB3', '/pmkpi/review/entrust/selexpert', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C5032639F21049E2352521742671FF', '/pmkpi/review/entrust/selexpert', 'CATEGORY', '专家类别', 15, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FEE3A6E2253BDBAD8C6623523522rg', '/pmkpi/review/entrust/selexpert', 'WORKEXPERIE', '工作经验', 5, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8D3D7578tew98BgwgD532E4643232525', '/pmkpi/review/entrust/selexpert', 'CREDITNO', '信用等级', 7, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('235235tgwsfgw9529542B2329A5A235C', '/pmkpi/review/entrust/selexpert', 'EVALUATENUM', '评价累计数', 9, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BCAF6235252357A7D772E3235252355', '/pmkpi/review/entrust/selexpert', 'REGION', '专家地域', 11, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2B4F35253253264235A272352ABF6144', '/pmkpi/review/entrust/selexpert', 'PHONE', '联系电话', 13, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D9207173923522557950A2991DB38235', '/pmkpi/review/entrust/selexpert', 'WORKPLACE', '工作单位', 3, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('23526712B52253956D411A9E4A823523', '/pmkpi/review/entrust/selexpert', 'PROFESSIONAL', '专业技术职称', 5, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BA9281B6B717B0E4E053B11FA8C0418B', '/pmkpi/review/entrust/selexpert', 'ISGROUP', '是否组长', 17, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);



DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/review/entrust/expert';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9E1D070EFC713CAE053B11FA8C0BAA7', '/pmkpi/review/entrust/expert', 'V_PERF_EXPERTINIFO', 100, 0, 0, null, null, 'pmkpi', null);

DELETE FROM busfw_t_Uicolumn t where t.key='/pmkpi/review/entrust/expert';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('23241CA6719C484F8441D271FD9A2775', '/pmkpi/review/entrust/expert', 'NAME', '专家名称', 1, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('817DC42F114B420532432407B2FB3235', '/pmkpi/review/entrust/expert', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C5023523F1049E1990B9031742671FF', '/pmkpi/review/entrust/expert', 'CATEGORY', '专家类别', 15, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FEE3A6E22A9C4D235D8C663CC7BA3325', '/pmkpi/review/entrust/expert', 'WORKEXPERIE', '工作经验', 5, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('82357578535E2B01EC98B0B5D5322352', '/pmkpi/review/entrust/expert', 'CREDITNO', '信用等级', 7, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E35529542B9A14CB8FB29A5A58C23532', '/pmkpi/review/entrust/expert', 'EVALUATENUM', '评价累计数', 9, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B5347A7D772E3F4DCFED0tw23523523', '/pmkpi/review/entrust/expert', 'REGION', '专家地域', 11, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2B4FF2350A56423556A8ABF614423511', '/pmkpi/review/entrust/expert', 'PHONE', '联系电话', 13, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D93253239F674D47950A2991DB325212', '/pmkpi/review/entrust/expert', 'WORKPLACE', '工作单位', 3, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6F2263252B91956D411A9E4A87F92352', '/pmkpi/review/entrust/expert', 'PROFESSIONAL', '专业技术职称', 5, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);


----专家评审页面

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/review/expert/list';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9F4DBE230800432E053B11FA8C005EC', '/pmkpi/review/expert/list', '查询', 1, 9, 'searchicon', 'pmkpireviewreport.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9F4DBE230810432E053B11FA8C005EC', '/pmkpi/review/expert/list', '评审', 1, 5, 'searchicon', 'pmkpireviewreport.assess', null, '评审', 'pmkpi', 'assess', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9F4DBE230820432E053B11FA8C005EC', '/pmkpi/review/expert/list', '确认评审', 1, 8, 'searchicon', 'pmkpireviewreport.confirm', null, '确认评审', 'pmkpi', 'confirm', null, '{"flag":"2"}');


--评审查询
DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/review/query/list';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9E1D070EFC113CAE053B11FA8C0BAA7', '/pmkpi/review/query/list', '查询', 1, 9, 'searchicon', 'pmkpireviewquery.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2424D9C0DCE053B11FA8C0D7F5242saw', '/pmkpi/review/query/list', '审核情况', 1, 7, 'searchicon', 'pmkpireviewquery.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA054DBD86D63316E053B11FA8C0178B', '/pmkpi/review/query/list', '查看明细', 1, 5, 'searchicon', 'pmkpireviewquery.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');
