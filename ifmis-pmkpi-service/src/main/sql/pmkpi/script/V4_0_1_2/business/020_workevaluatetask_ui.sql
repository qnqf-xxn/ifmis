begin
 
---首页 
DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/workevaluate/task/list';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C30F1E26531EFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', '新增任务', 1, 1, 'searchicon', 'workevaluatetask.add', null, '新增任务', 'pmkpi', 'add', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C30F1E26531FFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', '修改任务', 1, 2, 'searchicon', 'workevaluatetask.mod', null, '修改任务', 'pmkpi', 'mod', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C30F1E265320FDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', '删除任务', 1, 3, 'searchicon', 'workevaluatetask.del', null, '删除任务', 'pmkpi', 'del', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C30F1E265321FDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', '下达任务', 1, 4, 'searchicon', 'workevaluatetask.issued', null, '下达任务', 'pmkpi', 'issued', null, '{}');


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/workevaluate/task/list';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652C7FDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'NAME', '任务名称', 3, 1, 's', null, null, null, 'pmkpi', 'PERF_T_WORKEVALUATETASK', '{}', null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652D2FDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'TASKYEAR', '考核年度', 1, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_WORKEVALUATETASK', '{format:''#name''}', null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652D5FDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'TASKTYPE', '考核对象', 2, 1, 'tree', null, 1, 1, 'pmkpi', 'PERF_T_WORKEVALUATETASK', '{format:''#name''}', 0);


DELETE FROM P#Busfw_t_Uitable t where t.key='/pmkpi/workevaluate/task/list';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C30F1E265265FDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'V_PERF_T_WORKEVALUATETASK', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#Busfw_t_Uicolumn t where t.key='/pmkpi/workevaluate/task/list';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652B9FDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'NAME', '任务名称', 1, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652BAFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'TASKTYPE', '考核对象', 2, 1, 0, null, null, null, null, null, '#name', null, null, 250, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652BBFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'TASKYEAR', '考核年度', 3, 1, 0, null, null, null, null, null, '#name', null, null, 50, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652BCFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'STARTDATE', '任务开始时间', 5, 1, 0, null, null, null, null, null, 'yyyy-MM-dd', null, null, 50, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652BDFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'ENDDATE', '任务结束时间', 6, 1, 0, null, null, null, null, null, 'yyyy-MM-dd', null, null, 50, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652BEFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'REMARK', '备注', 7, 1, 0, null, null, null, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C30F1E2652BFFDF7E053B11FA8C0FA88', '/pmkpi/workevaluate/task/list', 'GUID', '主键', 0, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);


--任务编辑

DELETE FROM p#Busfw_t_Uifunction t where t.key='/pmkpi/workevaluate/task/edit';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C31309734CC552A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', '取消', 1, 2, 'Nofinishicon', 'workevaluatetaskedit.close', null, '取消', 'pmkpi', null, null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C31309734CC652A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', '保存', 1, 1, 'Keepicon', 'workevaluatetaskedit.save', null, '保存', 'pmkpi', null, null, null);


DELETE FROM p#busfw_t_Uitabpage t where t.key='/pmkpi/workevaluate/task/edit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C31309734CDD52A1E053B11FA8C0828D', 'pmkpi', '/pmkpi/workevaluate/task/edit', '绩效管理工作考核任务', 'editform', 1, 1, 'choosed', 'workevaluatetaskedit.clickTabpage', null, '绩效管理工作考核任务', null, null, '{busguid:''C31309734CDA52A1E053B11FA8C0828D'',action:''workevaluatetaskedit.save''}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C31309734CE352A1E053B11FA8C0828D', 'pmkpi', '/pmkpi/workevaluate/task/edit', '附件管理', 'file', 1, 2, 'nomal', 'workevaluatetaskedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''workevaluatetask'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'iframemance', null, null, null, null, null, null);


DELETE FROM p#busfw_t_Uieditform t where t.key='/pmkpi/workevaluate/task/edit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD652A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '创建人', 'CREATER', 0, null, 0, null, 19, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD152A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '修改时间', 'UPDATE_TIME', 0, null, 0, null, 14, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD052A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '年度', 'FISCAL_YEAR', 0, null, 0, null, 13, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD552A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '单位', 'AGENCY_CODE', 0, null, 0, null, 18, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CC552A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '任务名称', 'NAME', 1, null, 1, null, 1, 2, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD752A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 20, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CC852A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 'd', '开始时间', 'STARTDATE', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD452A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '单位', 'AGENCYGUID', 0, null, 0, null, 17, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD252A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 'i', '状态', 'STATUS', 0, null, 0, null, 15, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CD352A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '区划', 'MOF_DIV_CODE', 0, null, 0, null, 16, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CCE52A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 'i', '是否删除', 'IS_DELETED', 0, null, 0, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CCF52A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '主建', 'GUID', 0, null, 1, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CC752A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '任务类型', 'BUSTYPE', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CC652A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 'tree', '考核对象', 'TASKTYPE', 1, '0', 1, null, 2, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CC952A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 'd', '结束时间', 'ENDDATE', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CCB52A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '联系人', 'LINKMAN', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CCC52A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 's', '联系方式', 'TEL', 1, null, 0, null, 8, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CCD52A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 'textarea', '备注', 'REMARK', 1, null, 0, null, 9, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C31309734CCA52A1E053B11FA8C0828D', '/pmkpi/workevaluate/task/edit', 'V_PERF_T_WORKEVALUATETASK', 'tree', '考核年度', 'TASKYEAR', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, null);


--部门下达

DELETE FROM p#busfw_T_uifunction t where t.key='/pmkpi/workevaluate/assign/agencylist';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3251C3805D9D98BE053B11FA8C01094', '/pmkpi/workevaluate/assign/agencylist', '关闭', 1, 4, 'Nofinishicon', 'pmkpitaskassign.close', null, '关闭', 'pmkpi', null, null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3251C3805DAD98BE053B11FA8C01094', '/pmkpi/workevaluate/assign/agencylist', '下达', 1, 1, 'Keepicon', 'pmkpitaskassign.assign', null, '下达', 'pmkpi', null, null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3251C3805DBD98BE053B11FA8C01094', '/pmkpi/workevaluate/assign/agencylist', '取消下达', 1, 2, 'Nofinishicon', 'pmkpitaskassign.unassign', null, '取消下达', 'pmkpi', null, null, null);


DELETE FROM p#busfw_t_Uitabpage t where t.key='/pmkpi/workevaluate/assign/agencylist';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3251C3805DED98BE053B11FA8C01094', 'pmkpi', '/pmkpi/workevaluate/assign/agencylist', '待下达单位', 'wait', 1, 1, 'choosed', 'pmkpitaskassign.clickTabpage', null, '待下达单位', ' t.levelno = ''1'' and t.superguid = ''#''', '取消下达', '{tablecode:''PMKPI_FASP_T_PUBAGENCY''}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3251C3805DDD98BE053B11FA8C01094', 'pmkpi', '/pmkpi/workevaluate/assign/agencylist', '已下达单位', 'already', 1, 2, 'nomal', 'pmkpitaskassign.clickTabpage', null, '已下达单位', null, '下达', '{tablecode:''V_PERF_T_WORKTASKASSIGN''}', null, '0', null, null, null, null, null, null, null);


DELETE FROM p#Busfw_t_Uitable t where t.key='/pmkpi/workevaluate/assign/agencylist';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C3251C3805DFD98BE053B11FA8C01094', '/pmkpi/workevaluate/assign/agencylist', 'V_PERF_T_WORKTASKASSIGN', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM p#Busfw_t_Uicolumn t where t.key='/pmkpi/workevaluate/assign/agencylist';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3251C3805E2D98BE053B11FA8C01094', '/pmkpi/workevaluate/assign/agencylist', 'CODE', '单位编码', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3251C3805E1D98BE053B11FA8C01094', '/pmkpi/workevaluate/assign/agencylist', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3251C3805E3D98BE053B11FA8C01094', '/pmkpi/workevaluate/assign/agencylist', 'NAME', '单位名称', 3, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);


--区县下达

DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/workevaluate/assign/provincelist';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C339A89F78224FB0E053B11FA8C05AC1', 'pmkpi', '/pmkpi/workevaluate/assign/provincelist', '已下达县（市）区、开发区', 'already', 1, 2, 'nomal', 'pmkpitaskassign.clickTabpage', null, '已下达县（市）区、开发区', null, '下达', '{tablecode:''V_PERF_T_WORKTASKASSIGN''}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C339A89F78174FB0E053B11FA8C05AC1', 'pmkpi', '/pmkpi/workevaluate/assign/provincelist', '待下达县（市）区、开发区', 'wait', 1, 1, 'choosed', 'pmkpitaskassign.clickTabpage', null, '待下达县（市）区、开发区', null, '取消下达', '{tablecode:''V_ELE_VD08002''}', null, '0', null, null, null, null, null, null, null);



DELETE FROM P#busfw_T_uifunction t where t.key='/pmkpi/workevaluate/assign/provincelist';
insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C339A89F78144FB0E053B11FA8C05AC1', '/pmkpi/workevaluate/assign/provincelist', '关闭', 1, 4, 'Nofinishicon', 'pmkpitaskassign.close', null, '关闭', 'pmkpi', null, null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C339A89F78154FB0E053B11FA8C05AC1', '/pmkpi/workevaluate/assign/provincelist', '下达', 1, 1, 'Keepicon', 'pmkpitaskassign.assign', null, '下达', 'pmkpi', null, null, null);

insert into busfw_T_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C339A89F78164FB0E053B11FA8C05AC1', '/pmkpi/workevaluate/assign/provincelist', '取消下达', 1, 2, 'Nofinishicon', 'pmkpitaskassign.unassign', null, '取消下达', 'pmkpi', null, null, null);



DELETE FROM P#Busfw_t_Uitable t where t.key='/pmkpi/workevaluate/assign/provincelist'; 
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C339A89F78264FB0E053B11FA8C05AC1', '/pmkpi/workevaluate/assign/provincelist', 'V_PERF_T_WORKTASKASSIGN', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#Busfw_t_Uicolumn t where t.key='/pmkpi/workevaluate/assign/provincelist';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C339A89F78294FB0E053B11FA8C05AC1', '/pmkpi/workevaluate/assign/provincelist', 'CODE', '编码', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C339A89F782C4FB0E053B11FA8C05AC1', '/pmkpi/workevaluate/assign/provincelist', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C339A89F782E4FB0E053B11FA8C05AC1', '/pmkpi/workevaluate/assign/provincelist', 'NAME', '名称', 3, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
