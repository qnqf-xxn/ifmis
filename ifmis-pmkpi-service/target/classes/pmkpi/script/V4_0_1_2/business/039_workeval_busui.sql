begin

--绩效工作管理考核
--填报
delete from p#busfw_t_uitable t where key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C3372D3FF15C5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'V_PERF_T_WORKTASKASSIGN', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF1785B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF1815B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'CODE', '部门编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF1825B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'NAME', '部门名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF1805B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'AGENCYGUID', '预算部门', 5, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF17A5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'TASKTYPE', '考核对象', 6, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF17B5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'TASKYEAR', '考核年度', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF1795B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'GUID', 'guid', 10, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF17C5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'STARTDATE', '开始时间', 11, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF17D5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'ENDDATE', '截止时间', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);


delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3372D3FF1945B5CE053B11FA8C07204', 'pmkpi', '/pmkpi/workevaluate/report/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'workevalreport.clickTabpage', null, '已送审', null, '填报/修改,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3372D3FF1955B5CE053B11FA8C07204', 'pmkpi', '/pmkpi/workevaluate/report/list', '待送审', 'waitaudit', 1, 1, 'choosed', 'workevalreport.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3372D3FF1965B5CE053B11FA8C07204', 'pmkpi', '/pmkpi/workevaluate/report/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'workevalreport.clickTabpage', null, '曾经办', null, '填报/修改,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);


delete from p#busfw_t_uifunction t where key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3372D3FF1A75B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', '送审', 1, 4, 'searchicon', 'workevalreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{remark:true}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3372D3FF1A85B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', '审核情况', 1, 6, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3372D3FF1A95B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', '取消送审', 1, 5, 'searchicon', 'workevalreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3372D3FF1AA5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', '填报/修改', 1, 2, 'searchicon', 'workevalreport.addOredit', null, '填报/修改', 'pmkpi', 'save', null, '{deptworkeval2:''deptkeywork''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3372D3FF1AB5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', '查看明细', 1, 7, 'searchicon', 'workevalreport.addOredit', null, '查看明细', 'pmkpi', 'querydetailed', null, '{deptworkeval2:''deptkeywork''}');


delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF1AD5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'NAME', '部门名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_T_WORKTASKASSIGN', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C3372D3FF1AF5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'CODE', '部门编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_WORKTASKASSIGN', null, null);

--编辑
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/report/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3395BDB3BE0441CE053B11FA8C0A614', 'pmkpi', '/pmkpi/workevaluate/report/deptedit', '基本信息', 'editinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''C3395BDB3BF3441CE053B11FA8C0A614''}', null, '0', 'infoeditformformal', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3395BDB3BE1441CE053B11FA8C0A614', 'pmkpi', '/pmkpi/workevaluate/report/deptedit', '市直部门预算绩效管理工作考核评分表', 'deptwork', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '市直部门预算绩效管理工作考核评分表', null, null, '{url:''/pmkpi/workevaluate/report/deptedit/score.page?scoretype=deptwork'',busguid:''C3395BDB3BF5441CE053B11FA8C0A614'',action:''workevalscore.save''}', null, '0', 'deptworkiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3395BDB3BE2441CE053B11FA8C0A614', 'pmkpi', '/pmkpi/workevaluate/report/deptedit', '市预算绩效管理重点推进任务考核评分表', 'deptkeywork', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '市预算绩效管理重点推进任务考核评分表', null, null, '{url:''/pmkpi/workevaluate/report/deptedit/score.page?scoretype=deptkeywork'',busguid:''C3395BDB3BF6441CE053B11FA8C0A614'',action:''workevalscore.save''}', null, '0', 'deptkeyworkiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3395BDB3BE4441CE053B11FA8C0A614', 'pmkpi', '/pmkpi/workevaluate/report/deptedit', '附件上传', 'workfile', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存', '{filebustype:''deptworkeval'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);


delete from p#busfw_t_uifunction t where key in('/pmkpi/workevaluate/report/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3395BDB3C06441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3395BDB3C07441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

--基本信息
delete from p#busfw_t_uieditform t where key in('/pmkpi/workevaluate/report/deptedit/info');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C23441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '部门编码', 'CODE', 1, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C31441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '部门名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313E056ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '联系方式', 'TEL', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C2F441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '填报人', 'LINKMAN', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C25441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '事前绩效评估覆盖率', 'ASSESSMENTRATE', 1, null, 0, null, 10, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C30441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '绩效目标管理覆盖率', 'GOALRATE', 1, null, 0, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313E156ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '绩效监控管理覆盖率', 'TRACERATE', 1, null, 0, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C2B441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '绩效评价管理覆盖率', 'EVALUATIONRATE', 1, null, 0, null, 13, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C32441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '区划', 'PROVINCE', 0, null, 0, null, 20, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C2E441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '最后修改时间', 'LASTUPDATETIME', 0, null, 0, null, 21, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C2C441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '是否删除', 'IS_DELETED', 0, null, 0, null, 22, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C2A441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '主建', 'GUID', 0, null, 0, null, 23, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C28441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 24, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C27441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '创建人', 'CREATER', 0, null, 0, null, 25, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C26441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '任务类型', 'BUSTYPE', 0, null, 0, null, 26, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C22441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', 'AUDITOR', 'AUDITOR', 0, null, 0, null, 30, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3395BDB3C24441CE053B11FA8C0A614', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '下达单位或区划的guid', 'AGENCYGUID', 0, null, 0, null, 31, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313E356ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '工作流ID', 'WFID', 0, null, 0, null, 32, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313E256ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '修改时间', 'UPDATE_TIME', 0, null, 0, null, 33, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313E556ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '年度', 'YEAR', 0, null, 0, null, 34, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313E456ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '工作流状态', 'WFSTATUS', 0, null, 0, null, 35, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313DF56ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '考核对象', 'TASKTYPE', 0, null, 0, null, 40, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313DE56ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '主单guid', 'TASKGUID', 0, null, 0, null, 41, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313DC56ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '状态', 'STATUS', 0, null, 0, null, 42, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313DD56ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '下级区划', 'SUBPROVINCE', 0, null, 0, null, 43, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C3609C8313F856ABE053B11FA8C02D2C', '/pmkpi/workevaluate/report/deptedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '处室', 'FININTORGGUID', 0, null, 0, null, 44, null, null, 'pmkpi', 0, null, '{}', null, null, null);


--评分表
delete from p#busfw_t_uitable t where key in('/pmkpi/workevaluate/report/deptedit/score');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C33B7C69F920C57FE053B11FA8C07BA0', '/pmkpi/workevaluate/report/deptedit/score', 'V_PERF_T_DEPTSCORE', 0, 1, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/workevaluate/report/deptedit/score');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A2F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'NAME', '考核标准', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 160, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A4F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'SCORE', '分值', 2, 1, 0, 1, null, 0, 6, null, null, null, null, 30, 0, 'f', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A3F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'EVALSTD', '评分标准', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 220, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A5F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'SELFSCORE', '自评分数', 4, 1, 1, 1, null, 1, 6, null, null, null, null, 30, 0, 'f', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A7F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'RATISCORE', '评定分数', 5, 1, 1, 1, null, 0, 6, null, null, null, null, 30, 0, 'f', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A6F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'REMARK', '备注', 6, 1, 0, 0, null, 0, 6, null, null, null, null, 250, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A8F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'FILE', '佐证材料', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A9F175E053B11FA8C04705', '/pmkpi/workevaluate/report/deptedit/score', 'GUID', 'guid', 8, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

--审核
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848185B21E053B11FA8C06DFA', 'pmkpi', '/pmkpi/workevaluate/audit/list', '审核', 'waitaudit', 1, 1, 'choosed', 'workevalaudit.clickTabpage', 0, '审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848175B21E053B11FA8C06DFA', 'pmkpi', '/pmkpi/workevaluate/audit/list', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'workevalaudit.clickTabpage', 0, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C37063D848165B21E053B11FA8C06DFA', 'pmkpi', '/pmkpi/workevaluate/audit/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'workevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D848195B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '审核', 1, 1, 'searchicon', 'workevalaudit.auditOrDetailed', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit",deptworkeval2:''deptkeywork''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D8481A5B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '取消审核', 1, 2, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D8481B5B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '审核情况', 1, 3, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C37063D8481C5B21E053B11FA8C06DFA', '/pmkpi/workevaluate/audit/list', '查看明细', 1, 4, 'searchicon', 'workevalaudit.auditOrDetailed', null, '查看明细', 'pmkpi', 'detailed', null, '{deptworkeval2:''deptkeywork''}');

--审核编辑
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/audit/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C373C41C45EA023FE053B11FA8C01B8B', 'pmkpi', '/pmkpi/workevaluate/audit/deptedit', '基本信息', 'editinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存,保存并审核', '{busguid:''C3395BDB3BF3441CE053B11FA8C0A614'',viewtype:''query''}', null, '0', 'infoeditformformal', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C373C41C45EB023FE053B11FA8C01B8B', 'pmkpi', '/pmkpi/workevaluate/audit/deptedit', '市直部门预算绩效管理工作考核评分标', 'deptwork', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '市直部门预算绩效管理工作考核评分标', null, null, '{url:''/pmkpi/workevaluate/report/deptedit/score.page?scoretype=deptwork'||chr(38)||'pagetype=audit'',busguid:''C3395BDB3BF5441CE053B11FA8C0A614'',action:''workevalscore.save''}', null, '0', 'deptworkiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C373C41C45EC023FE053B11FA8C01B8B', 'pmkpi', '/pmkpi/workevaluate/audit/deptedit', '市预算绩效管理重点推进任务考核评分表', 'deptkeywork', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '市预算绩效管理重点推进任务考核评分表', null, null, '{url:''/pmkpi/workevaluate/report/deptedit/score.page?scoretype=deptkeywork'||chr(38)||'pagetype=audit'',busguid:''C3395BDB3BF6441CE053B11FA8C0A614'',action:''workevalscore.save''}', null, '0', 'deptkeyworkiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C373C41C45ED023FE053B11FA8C01B8B', 'pmkpi', '/pmkpi/workevaluate/audit/deptedit', '附件上传', 'workfile', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存,保存并审核', '{filebustype:''deptworkeval'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/workevaluate/audit/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C373C41C45EE023FE053B11FA8C01B8B', '/pmkpi/workevaluate/audit/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C373C41C45F0023FE053B11FA8C01B8B', '/pmkpi/workevaluate/audit/deptedit', '保存并审核', 1, 2, 'Nofinishicon', 'tabfreamedit.saveaudit', null, '保存并审核', 'pmkpi', 'audit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C373C41C45EF023FE053B11FA8C01B8B', '/pmkpi/workevaluate/audit/deptedit', '取消', 1, 3, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);
