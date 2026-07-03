begin

--财政评价项目确定
delete from p#busfw_t_uitable t where key in('/pmkpi/evaluation/financial/program');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD25F32C9EA677B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'V_PERF_T_FINEVALUATION', 100, 0, null, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/evaluation/financial/program');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EAE77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'WFSTATUS', '审核状态', 1, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EA777B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E4FC3AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/program', 'CODE', '单位编码', 3, 1, 0, null, null, null, 6, null, null, null, null, 80, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E4FD3AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/program', 'NAME', '单位名称', 4, 1, 0, null, null, null, 6, null, null, null, null, 150, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EA877B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'AGENCYGUID', '预算单位', 6, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E4FE3AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/program', 'YEAR', '预算年度', 7, 1, 0, null, null, null, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EAB77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'FININTORGGUID', '业务科室', 12, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EAC77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'CREATER', '填报人', 13, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EAD77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EAF77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/proconfirm');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD25F32C9EBC77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/financial/proconfirm', '待确认', 'waitaudit', 1, 1, 'choosed', 'finproconfirm.clickTabpage', 0, '待确认', null, '取消提交', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD25F32C9EBD77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/financial/proconfirm', '已确认', 'alreadyaudit', 1, 2, 'nomal', 'finproconfirm.clickTabpage', 0, '已确认', null, '提交,选择项目,新增项目,修改项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD25F32C9EBE77B9E053B11FA8C041F0', 'pmkpi', '/pmkpi/evaluation/financial/proconfirm', '曾经办', 'allconfirm', 1, 3, 'nomal', 'finproconfirm.clickTabpage', 0, '曾经办', null, '提交,取消提交,选择项目,新增项目,修改项目,删除项目', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/proconfirm');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EED77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '选择项目', 1, 1, 'searchicon', 'finproconfirm.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EEE77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '新增项目', 1, 2, 'searchicon', 'finproconfirm.add', null, '新增项目', 'pmkpi', 'add', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EEF77B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '修改项目', 1, 3, 'searchicon', 'finproconfirm.mod', null, '修改项目', 'pmkpi', 'mod', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF077B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '删除项目', 1, 4, 'searchicon', 'finproconfirm.del', null, '删除项目', 'pmkpi', 'del', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF177B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '提交', 1, 7, 'searchicon', 'finproconfirm.wfAudit', null, '提交', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF277B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '取消提交', 1, 8, 'searchicon', 'finproconfirm.wfAudit', null, '取消提交', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF377B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '导出项目', 0, 9, 'searchicon', 'finproconfirm.expdadta', null, '导出项目', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF477B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '查看项目明细', 1, 14, 'searchicon', 'finproconfirm.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF577B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '审核情况', 1, 15, 'searchicon', 'finproconfirm.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD25F32C9EF577B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/proconfirm', '上传附件', 0, 13, 'searchicon', 'finproconfirm.impfile', null, '上传附件', 'pmkpi', 'impfile', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/evaluation/financial/program');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EB177B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_FINEVALUATION', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD25F32C9EB277B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'FININTORGGUID', '业务处室', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_FINEVALUATION', '{format:''#name''}', null);


--选择项目
--项目

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/check');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2A3B90E5113AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/check', '确定', 1, 1, 'Keepicon', 'financialprocheck.save', null, '确定', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2A3B90E5123AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/check', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

--部门
delete from p#busfw_t_uitable t where key in('/pmkpi/evaluation/financial/deptcheck');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD2A3B90E5163AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'PMKPI_FASP_T_PUBAGENCY', 100, 0, 0, 'code', 'isleaf<>1 and levelno=1', 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/evaluation/financial/deptcheck');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E5273AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E5283AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E5293AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'CODE', '编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E52A3AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E5323AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'AGENCYGUID', '单位', 11, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/evaluation/financial/deptcheck');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E52B3AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'NAME', '名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD2A3B90E52C3AC1E053B11FA8C06F54', '/pmkpi/evaluation/financial/deptcheck', 'CODE', '编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);


--项目编辑
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/finconfirm/proedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53D3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''BD2A3B90E5403AC1E053B11FA8C06F54''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53E3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '附件管理', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/finconfirm/proedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2A3B90E5413AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/proedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2A3B90E5423AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/proedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/evaluation/finconfirm/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E5843AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 's', 'guid', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E5853AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E5863AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 's', '项目名称', 'NAME', 1, null, 1, null, 3, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E5873AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'tree', '预算单位', 'AGENCYGUID', 1, null, 0, null, 4, null, null, 'pmkpi', 1, 0, '{"format":"#code-#name"}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E5883AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'd', '开始日期', 'PRO_START_YEAR', 1, null, 1, null, 6, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E5893AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'd', '截止日期', 'ENDTIME', 1, null, 0, null, 7, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E58B3AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 's', '项目负责人', 'LEADER_NAME', 0, null, 0, null, 9, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E58C3AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 's', '项目联系人', 'PROJECTCON', 1, null, 1, null, 10, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E58D3AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 's', '联系人电话', 'LEADER_PHONE', 1, null, 0, null, 11, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E58E3AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'amt', '项目总金额', 'PRO_TOTAL_AMT', 1, null, 1, null, 12, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD2A3B90E58F3AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'amt', '当年预算金额', 'PROJAMT', 0, null, 1, null, 13, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD8C08690B222973E053B11FA8C01253', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'tree', '财政评价类型', 'CATEGORY', 1, null, 1, null, 16, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BEACBF7062DA2AC8E053B11FA8C05B8C', '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'tree', '牵头处室', 'FININTORGGUID', 1, null, 1, null, 17, null, null, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0);

--部门编辑
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/finconfirm/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02D12359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/finconfirm/deptedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''BD2A3B90E5403AC1E053B11FA8C06F54''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02D22359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/finconfirm/deptedit', '附件管理', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/finconfirm/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02D32359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02D42359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/evaluation/finconfirm/deptedit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02CF2359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', 'guid', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02D02359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02CD2359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '部门编码', 'CODE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02CE2359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '部门名称', 'NAME', 1, null, 1, null, 4, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0);

--财政评价项目审核
delete from p#busfw_t_uitable t where key in('/pmkpi/evaluation/financial/program/audit');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD672DCCF3398602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'V_PERF_T_FINEVALUATION', 0, 0, null, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/evaluation/financial/program/audit');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3298602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'WFSTATUS', '状态', 1, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3358602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'NAME', '单位名称', 2, 1, 0, null, null, null, 6, null, null, null, null, 150, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF32A8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'NAME', '项目名称', 3, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF32B8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'AGENCYGUID', '预算单位', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3348602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'CODE', '单位编码', 5, 1, 0, null, null, null, 6, null, null, null, null, 80, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF32C8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'YEAR', '预算年份', 6, 1, 0, null, null, null, 1, null, null, null, null, 80, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3378602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'FININTORGGUID', '业务科室', 7, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF32E8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'CREATER', '填报人', 9, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3328602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'ISRELEASE', '是否下达', 11, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF36B8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'ISNOTICE', '是否接收通知', 12, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF32F8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3308602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/program/audit', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{ispro:1}', null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/audit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD3B52A3C9BE2407E053B11FA8C0173F', 'pmkpi', '/pmkpi/evaluation/financial/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'finevalaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD3B52A3C9BF2407E053B11FA8C0173F', 'pmkpi', '/pmkpi/evaluation/financial/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'finevalaudit.clickTabpage', 0, '已审核', null, '审核,指派中介,指派专家', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD3B52A3C9C02407E053B11FA8C0173F', 'pmkpi', '/pmkpi/evaluation/financial/audit', '曾经办', 'allconfirm', 1, 3, 'nomal', 'finevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,指派中介,指派专家', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/audit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3B52A3C9C12407E053B11FA8C0173F', '/pmkpi/evaluation/financial/audit', '审核', 1, 1, 'searchicon', 'finevalaudit.wfAudit', null, '审核', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3B52A3C9C22407E053B11FA8C0173F', '/pmkpi/evaluation/financial/audit', '取消审核', 1, 2, 'searchicon', 'finevalaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3B52A3C9C32407E053B11FA8C0173F', '/pmkpi/evaluation/financial/audit', '指派中介', 0, 3, 'searchicon', 'finevalaudit.intermediary', null, '指派中介', 'pmkpi', 'intermediary', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3B52A3C9C62407E053B11FA8C0173F', '/pmkpi/evaluation/financial/audit', '指派专家', 0, 4, 'searchicon', 'finevalaudit.expert', null, '指派专家', 'pmkpi', 'expert', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD63043B99DD2939E053B11FA8C04509', '/pmkpi/evaluation/financial/audit', '查看自评信息', 0, 6, 'searchicon', 'finevalaudit.queryassessment', null, '查看自评信息', 'pmkpi', 'queryassessment', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD63043B99E12939E053B11FA8C04509', '/pmkpi/evaluation/financial/audit', '下达评价通知', 1, 7, 'searchicon', 'finevalaudit.givenotice', null, '下达评价通知', 'pmkpi', 'givenotice', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD672DCCF33A8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/audit', '取消下达评价通知', 1, 7, 'searchicon', 'finevalaudit.givenotice', null, '取消下达评价通知', 'pmkpi', 'ungivenotice', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3B52A3C9C42407E053B11FA8C0173F', '/pmkpi/evaluation/financial/audit', '查看项目明细', 1, 8, 'searchicon', 'finevalaudit.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3B52A3C9C52407E053B11FA8C0173F', '/pmkpi/evaluation/financial/audit', '审核情况', 1, 9, 'searchicon', 'finevalaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

--审核意见
delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/auditedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3E5F9FB2977ECEE053B11FA8C00129', '/pmkpi/evaluation/financial/auditedit', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3E5F9FB2987ECEE053B11FA8C00129', '/pmkpi/evaluation/financial/auditedit', '确认', 1, 1, 'searchicon', 'finauditedit.save', null, '确认', 'pmkpi', 'save', null, '{}');

delete from p#busfw_t_uieditform t where key in('/pmkpi/evaluation/financial/auditedit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD3E5F9FB2997ECEE053B11FA8C00129', '/pmkpi/evaluation/financial/auditedit', 'PERF_T_EVALUATEAUDIT', 'textarea', '审核意见', 'OPINION', 1, null, 1, null, 2, 2, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD3E5F9FB29A7ECEE053B11FA8C00129', '/pmkpi/evaluation/financial/auditedit', 'PERF_T_EVALUATEAUDIT', 'tree', '常用审核意见', 'OLDOPINION', 1, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD3E5F9FB29B7ECEE053B11FA8C00129', '/pmkpi/evaluation/financial/auditedit', 'PERF_T_EVALUATEAUDIT', 'tree', '审核操作', 'ORDINARYTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, null, null);

--财政评价成果上传
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/resultupload');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02702359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultupload', '待提交', 'waitaudit', 1, 1, 'choosed', 'finevaluationresult.clickTabpage', 0, '待提交', null, '取消提交', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02712359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultupload', '已提交', 'alreadyaudit', 1, 2, 'nomal', 'finevaluationresult.clickTabpage', 0, '已提交', null, '上传成果,提交', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02722359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultupload', '曾经办', 'allconfirm', 1, 3, 'nomal', 'finevaluationresult.clickTabpage', 0, '曾经办', null, '上传成果,提交,取消提交', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/resultupload');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02732359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultupload', '上传成果', 1, 1, 'searchicon', 'finevaluationresult.resultupload', null, '上传成果', 'pmkpi', 'resultupload', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02742359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultupload', '提交', 1, 2, 'searchicon', 'finevaluationresult.wfAudit', null, '提交', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02752359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultupload', '取消提交', 1, 3, 'searchicon', 'finevaluationresult.wfAudit', null, '取消提交', 'pmkpi', 'cancelaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02762359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultupload', '查看项目明细', 0, 7, 'searchicon', 'finevaluationresult.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02772359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultupload', '审核情况', 1, 8, 'searchicon', 'finevaluationresult.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02782359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultupload', '查看评价成果', 1, 6, 'searchicon', 'finevaluationresult.resultupload', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}');

--项目上传
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/result/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02D72359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02872359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '项目附件', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{url:''/pmkpi/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02862359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02D82359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/result/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B029C2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/result/edit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B029D2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/result/edit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/evaluation/financial/result/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B028F2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 's', 'guid', 'GUID', 0, null, 0, null, 1, 0, '0', 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B028E2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '存在问题', 'EXISTQUESTION', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02902359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '整改措施和建议', 'FEEDBACK', 1, null, 1, null, 3, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

--部门上传
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/result/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02E32359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/deptedit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02E42359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/deptedit', '项目附件', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{url:''/pmkpi/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02E52359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/deptedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B02E62359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/result/deptedit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/result/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BE5D4038AF63192EE053B11FA8C0ACB2', '/pmkpi/evaluation/financial/result/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BE5D4038AF66192EE053B11FA8C0ACB2', '/pmkpi/evaluation/financial/result/deptedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);

--财政评价成果审核
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/resultaudit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03142359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'finevaluationresult.clickTabpage', 0, '待审核', null, '取消审核,下达整改通知', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03152359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'finevaluationresult.clickTabpage', 0, '已审核', null, '审核,评价成果修改', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53D19B03162359E053B11FA8C0BCA2', 'pmkpi', '/pmkpi/evaluation/financial/resultaudit', '曾经办', 'allconfirm', 1, 3, 'nomal', 'finevaluationresult.clickTabpage', 0, '曾经办', null, '审核,取消审核,评价成果修改,下达整改通知', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/resultaudit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B03492359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultaudit', '审核', 1, 1, 'searchicon', 'finevaluationresult.wfAudit', null, '审核', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B034A2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultaudit', '取消审核', 1, 2, 'searchicon', 'finevaluationresult.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B034D2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultaudit', '评价成果修改', 1, 3, 'searchicon', 'finevaluationresult.resultupload', null, '评价成果修改', 'pmkpi', 'resultupload', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B034C2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultaudit', '查看评价成果', 1, 4, 'searchicon', 'finevaluationresult.resultupload', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B034B2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultaudit', '审核情况', 1, 5, 'searchicon', 'finevaluationresult.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B034E2359E053B11FA8C0BCA2', '/pmkpi/evaluation/financial/resultaudit', '下达整改通知', 1, 6, 'searchicon', 'finevaluationresult.notice', null, '下达整改通知', 'pmkpi', 'resultupload', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD672DCCF3B48602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/resultaudit', '反馈意见查看', 1, 7, 'searchicon', 'finevaluationresult.feedback', null, '反馈意见查看', 'pmkpi', 'queryfeedback', null, '{}');

--财政评价反馈意见
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/feedback');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD672DCCF39C8602E053B11FA8C0BE47', 'pmkpi', '/pmkpi/evaluation/financial/feedback', '待反馈', 'waitaudit', 1, 1, 'choosed', 'finevaluationresult.clickTabpage', 0, '待审核', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD672DCCF39D8602E053B11FA8C0BE47', 'pmkpi', '/pmkpi/evaluation/financial/feedback', '已反馈', 'alreadyaudit', 1, 2, 'nomal', 'finevaluationresult.clickTabpage', 0, '已审核', null, '反馈意见', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD672DCCF39E8602E053B11FA8C0BE47', 'pmkpi', '/pmkpi/evaluation/financial/feedback', '曾经办', 'allconfirm', 1, 3, 'nomal', 'finevaluationresult.clickTabpage', 0, '曾经办', null, '反馈意见', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/feedback');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD672DCCF39F8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/feedback', '查看评价成果', 1, 2, 'searchicon', 'finevaluationresult.resultupload', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD672DCCF3A08602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/feedback', '反馈意见', 1, 1, 'searchicon', 'finevaluationresult.feedback', null, '反馈意见', 'pmkpi', 'feedback', null, '{}');

--
delete from p#busfw_t_uitable t where key in('/pmkpi/evaluation/financial/acceptnotice');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD672DCCF3428602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'V_PERF_T_FINEVALUATION', 0, 0, null, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/evaluation/financial/acceptnotice');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF35D8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'ISNOTICE', '是否接收通知', 1, 1, 0, null, null, null, null, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3568602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'NAME', '单位名称', 2, 1, 0, null, null, null, 6, null, null, null, null, 150, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3578602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'NAME', '项目名称', 3, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3588602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'AGENCYGUID', '预算单位', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF3598602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'CODE', '单位编码', 5, 1, 0, null, null, null, 6, null, null, null, null, 80, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF35A8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'YEAR', '预算年份', 6, 1, 0, null, null, null, 1, null, null, null, null, 80, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF35B8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'FININTORGGUID', '业务科室', 7, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF35C8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'CREATER', '填报人', 9, 1, 0, null, null, null, null, null, '#name', null, null, 90, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF35E8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD672DCCF35F8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{ispro:1}', null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/acceptnotice');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD672DCCF3408602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', '接收通知', 1, 1, 'searchicon', 'finevaluationresult.acceptnotice', null, '接收通知', 'pmkpi', 'acceptnotice', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD672DCCF33F8602E053B11FA8C0BE47', '/pmkpi/evaluation/financial/acceptnotice', '查看项目成果', 1, 2, 'searchicon', 'finevaluationresult.resultupload', null, '查看项目成果', 'pmkpi', 'queryresult', null, '{}');

--绩效评价类别维护
delete from p#busfw_t_uitable t where key in('/pmkpi/setting/dataset');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD8C08690B052973E053B11FA8C01253', '/pmkpi/setting/dataset', 'V_PERF_T_FINEVALCATEGORY', 0, 0, null, 'order by ordernum', null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/setting/dataset');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD8C08690B1B2973E053B11FA8C01253', '/pmkpi/setting/dataset', 'CODE', '编码', 1, 1, 1, null, null, 1, 6, null, null, null, null, 80, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD8C08690B1C2973E053B11FA8C01253', '/pmkpi/setting/dataset', 'NAME', '名称', 2, 1, 1, null, null, 1, 6, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD8C08690B1E2973E053B11FA8C01253', '/pmkpi/setting/dataset', 'ORDERNUM', '排序', 3, 1, 1, null, null, null, 6, null, null, null, null, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD8C08690B1D2973E053B11FA8C01253', '/pmkpi/setting/dataset', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/dataset');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD8B4C473A99F0CAE053B11FA8C0C384', '/pmkpi/setting/dataset', '保存', 1, 1, 'searchicon', 'perfdataset.save', null, '保存', 'pmkpi', 'save', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/setting/dataset');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BE5D4038AF76192EE053B11FA8C0ACB2', '/pmkpi/setting/dataset', 'NAME', '名称', 1, 1, 's', null, 1, 1, 'pmkpi', null, null, null);

update p#busfw_t_uicolumn t set t.COLUMNCODE='MOF_DEP_CODE' where COLUMNCODE='FININTORGGUID' and key='/pmkpi/program/report/list';
