begin
  
DELETE FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformance/report/indexproject';

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('B2385D456245D09544DED094C70F9D', '/pmkpi/deptZJformance/report/indexproject', 'V_BGT_PERF_INDICATOR', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

DELETE FROM p#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformance/report/indexproject';

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0fA5FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2g2ggFBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'ISBUDGET', '是否与预算挂钩', 36, 0, 0, 0, null, 0, null, null, null, null, null, 150, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2g2ggssss3d698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'PRO_NAME', '项目名称', 41, 1, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2g2ggddfF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'PRO_TOTAL_AMT', '金额', 42, 1, 0, 0, null, 0, null, null, null, null, null, 90, 0, 'amt', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0227BF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'KPI_CONTENT', '指标内容', 11, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0226FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'INDEXIMPORT', '指标重要性', 9, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0225FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'NAME', '指标名称', 8, 1, 0, 0, null, 0, null, null, null, null, null, 180, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0224FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'SNAME', '二级指标', 7, 1, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0223FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'FINDEX', '一级指标', 6, 1, 0, 0, null, 0, 6, null, '#name', null, null, 120, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0221FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'FUN_RES_CODE', '部门职责', 2, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 250, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0228FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'SCORE', '分值', 12, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F02200FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'SCORERULE', '赋分原则', 13, 0, 0, 0, null, 0, null, null, null, null, null, 180, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F09FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'COMPUTESIGN', '计算符号', 14, 0, 0, 0, null, 1, 6, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2Fsf2A5FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'INDEXVAL', '指标值', 15, 0, 0, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2FDD2A5FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'METERUNIT', '计量单位', 16, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0dA5FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'KPI_REMARK', '目标值说明', 19, 0, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0dsBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'KPI_VAL1', '历年指标值1', 20, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F0sA5FBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'KPI_VAL2', '历年指标值2', 21, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CD2F022dBF43698B85128D8DBC09C5', '/pmkpi/deptZJformance/report/indexproject', 'KPI_VAL3', '历年指标值3', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

DELETE FROM P#Busfw_t_Uieditform t where t.key = '/pmkpi/deptZJformance/report/goaledit';

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('545AE4F54512494BA3C4A7237C5E9D81', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 's', '区划', 'PROVINCE', 0, null, 0, null, 15, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('9283B98d9389432F8859232C9DB997FA', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 's', 'guid', 'GUID', 0, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('9283B98cc389432F8859232C9DB997FA', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 'textarea', '部门整体绩效指标体系概述', 'KPI_TARGET', 1, null, 1, null, 2, 3, '5', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('9283Bxv69389432F8859232C9DB997FA', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 's', '主建id', 'MAINGUID', 0, null, 0, null, 21, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('9283B98ff389432F8859232C9DB997FA', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 's', '单位', 'AGENCYGUID', 0, null, 0, null, 22, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('9283B98aa389432F8859232C9DB997FA', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 'textarea', '部门整体绩效产出指标挂钩机制概述', 'REMARK', 1, null, 1, null, 5, 3, '5', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('9283B9sf9389432F8859232C9DB997FA', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 's', '创建时间', 'CREATETIME', 0, null, 0, null, 17, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('9283B98g9389432F8859232C9DB997FA', '/pmkpi/deptZJformance/report/goaledit', 'BGT_PERF_GOAL_INFO', 's', '年度', 'YEAR', 0, null, 0, null, 16, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

DELETE FROM P#Busfw_t_Uitabpage t where t.key = '/pmkpi/deptZJformance/report/edit';

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('9594dfsf8AED4861A55EC312C0D8FDE5', 'pmkpi', '/pmkpi/deptZJformance/report/edit', '绩效目标概述', 'goaleditform', 1, 4, 'nomal', 'pmkpideptZJedit.clickTabpage', null, '绩效目标概述', null, null, '{busguid:''A281E16C4F894E8091DC4CA01B08C092''}', null, '0', 'goaleditform', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('9594DDewxxED4861A55EC312C0D8FDE5', 'pmkpi', '/pmkpi/deptZJformance/report/edit', '预算挂钩机制', 'budgettable', 1, 3, 'nomal', 'pmkpideptZJedit.clickTabpage', null, '预算挂钩机制', null, null, '{busguid:''A281E16V4F894E8091DC4CA01B08C092''}', null, '0', 'budgetdatatable', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('9594DDBdsfsD4861A55EC312C0D8FDE5', 'pmkpi', '/pmkpi/deptZJformance/report/edit', '部门整体绩效指标', 'perfindextable', 1, 2, 'nomal', 'pmkpideptZJedit.clickTabpage', null, '部门整体绩效指标', null, null, '{busguid:''A281E16B4F894E8091DC4CA01B08C092''}', null, '0', 'perfindexdatatable', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('9594DDB666dD4861A55EC312C0D8FDE5', 'pmkpi', '/pmkpi/deptZJformance/report/edit', '部门基本信息', 'infoeditform', 1, 1, 'choosed', 'pmkpideptZJedit.clickTabpage', null, '部门基本信息', null, null, '{busguid:''A281E16A4F894E8091DC4CA01B08C092''}', null, '0', 'infoeditform', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('9594gsdfeED4861A55EC312C0D8FDE5', 'pmkpi', '/pmkpi/deptZJformance/report/edit', '附件管理', 'file', 1, 6, 'nomal', 'pmkpideptZJedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''deptzjperformance'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('9594DDdsED4861A55EC312C0D8FDE5', 'pmkpi', '/pmkpi/deptZJformance/report/edit', '绩效指标与预算项目对应表', 'indexprotable', 1, 5, 'nomal', 'pmkpideptZJedit.clickTabpage', null, '绩效指标与预算项目对应表', null, null, '{busguid:''A281E16AJ4F894E8091DC4CA01B08C092'',viewtype:''query''}', null, '0', 'indexprodatatable', null, null, null, null, null, null, '87', '2016');

DELETE FROM p#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformance/report/editindex';

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('AB61BABF869E441ABCFEC3636A87D19C', '/pmkpi/deptZJformance/report/editindex', 'V_BGT_PERF_INDICATOR', 0, 0, 0, ' order by ordernum', null, 'pmkpi', '{}', '87', '2016');

DELETE FROM p#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformance/report/editindex';

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A35946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'SNAME', '二级指标', 3, 1, 1, 0, null, 1, 1, '[''指标名称'']', null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A34946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'FINDEX', '一级指标', 2, 1, 0, 0, null, 1, 6, '[''指标名称'']', '#name', null, null, 100, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A33946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'KPI_REMARK', '目标值说明', 19, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A88946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'SCORERULE', '赋分原则', 13, 1, 1, 0, null, 1, 6, null, null, null, null, 180, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A86946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'METERUNIT', '计量单位', 16, 1, 1, 0, null, 0, 0, null, null, null, null, 80, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A85946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'INDEXVAL', '2022指标值', 15, 1, 1, 0, null, 1, 0, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A84946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'COMPUTESIGN', '计算符号', 14, 1, 1, 0, null, 1, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A82946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'NAME', '三级指标', 4, 1, 1, 0, null, 1, 1, '[''指标名称'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A36946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, 0, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A37946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'KPI_CONTENT', '指标内容', 11, 1, 1, 0, null, 1, 0, null, null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A38946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'KPI_EVALSTD', '扣分标准', 28, 0, 0, 0, null, 0, 0, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE6A81946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'FUN_RES_CODE', '部门职责', 1, 1, 1, 0, null, 1, 6, null, '#code-#name', null, null, 250, 1, 'tree', '{filtersql:"  bgt_dept_code = \''#agencyguid\''"}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE223946F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'INDEXIMPORT', '指标重要性', 9, 1, 1, 0, null, 1, 6, null, '#name', null, null, 120, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE22ew46F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'SCORE', '分值', 12, 1, 1, 1, null, 1, 0, null, null, null, null, 100, 0, 'i', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE2ww46F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'KPI_VAL1', '2021', 20, 1, 1, 0, null, 0, 1, '[''历史指标值'']', null, null, null, 120, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBE2sfdw46F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'KPI_VAL2', '2020', 21, 1, 1, 0, null, 0, 1, '[''历史指标值'']', null, null, null, 120, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBEdfsww46F2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'KPI_VAL3', '2019', 22, 1, 1, 0, null, 0, 1, '[''历史指标值'']', null, null, null, 120, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBweweTGGE17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'PROSELECT', '部门预算项目或专项资金', 33, 1, 0, 0, null, 0, 0, null, null, null, null, 100, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('70B6DBsdfGDXSF2A17893EF58F8FA17', '/pmkpi/deptZJformance/report/editindex', 'ISBUDGET', '是否与预算挂钩', 36, 1, 1, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null, '87', '2016');

DELETE FROM P#Busfw_t_Uieditform t where t.key = '/pmkpi/deptZJformance/report/edit';

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('7DC3EF6F366446A59991D3B1EAA36ADE', '/pmkpi/deptZJformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('7DC3EF6F344446A59991D3B1EAA36ADE', '/pmkpi/deptZJformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系电话', 'TELEPHONE', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('7DC3EF6F333446A59991D3B1EAA36ADE', '/pmkpi/deptZJformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系人', 'LINKMAN', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('7DC3EF6F322446A59991D3B1EAA36ADE', '/pmkpi/deptZJformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('7DC3EF6F311446A59991D3B1EAA36ADE', '/pmkpi/deptZJformance/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门编号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');

DELETE FROM p#Busfw_t_Uifunction t where t.key = '/pmkpi/deptZJformance/report/edit';

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('C54A53995622429FA125296EF5881610', '/pmkpi/deptZJformance/report/edit', '取消', 1, 2, 'Nofinishicon', 'pmkpideptZJedit.close', null, '取消', 'pmkpi', null, null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('C54A53885622429FA125296EF5881610', '/pmkpi/deptZJformance/report/edit', '保存', 1, 1, 'Keepicon', 'pmkpideptZJedit.infosave', null, '保存', 'pmkpi', null, null, null, '87', '2016');

DELETE FROM P#Busfw_t_Uitable t where t.key = '/pmkpi/deptZJformance/report/editbudget';

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('B2385D223245D09544DED094C70F9D', '/pmkpi/deptZJformance/report/editbudget', 'V_PERF_BGT_LINKBGTINFO', 0, 0, 0, ' order by  ordernum', null, 'pmkpi', null, '87', '2016');

DELETE FROM P#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformance/report/editbudget';

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('4BAA6C21EFA74FD6B3EE3D457BC7DDFE', '/pmkpi/deptZJformance/report/editbudget', 'AGENCYGUID', '单位', 51, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('39C4521080B0427BA1E9323E635A110C', '/pmkpi/deptZJformance/report/editbudget', 'BASEPERIOD', '基期指标值', 13, 1, 1, 0, null, 0, 6, '[''2022年挂钩机制'']', null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('A0E14156D17F40A582B41C4A5F314417', '/pmkpi/deptZJformance/report/editbudget', 'BGTAMT1', '2016年', 10, 1, 1, 0, null, 1, 6, '[''一般公共预算安排金额'']', null, null, null, 150, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('740AF40B1B1642699C5AFFABC7099AC5', '/pmkpi/deptZJformance/report/editbudget', 'BGTAMT2', '2020年', 11, 1, 1, 0, null, 1, 6, '[''一般公共预算安排金额'']', null, null, null, 150, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('5432171E2BB544A4BA94D49E5BDCAC0C', '/pmkpi/deptZJformance/report/editbudget', 'BGTAMT3', '2019年', 12, 1, 1, 0, null, 1, 6, '[''一般公共预算安排金额'']', null, null, null, 150, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('0440E4A7727747518DBED70027FDFC5E', '/pmkpi/deptZJformance/report/editbudget', 'COMPUTESIGN', '符号', 2, 1, 0, 0, null, 1, 6, null, '#name', null, null, 150, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('55CCD999E9F1462B8A2C96F58203DA48', '/pmkpi/deptZJformance/report/editbudget', 'COUPLEAMT', '挂钩额(挂钩增减比例*一般公共预算安排金额)', 17, 1, 1, 0, null, 0, 6, '[''2022年挂钩机制'']', null, null, null, 150, 0, 'amt', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('91240DFC43504796A01B9DA85348070D', '/pmkpi/deptZJformance/report/editbudget', 'COUPLERATE', '挂钩增减比例(2022指标值/基期值*权重)', 16, 1, 1, 0, null, 0, 6, '[''2022年挂钩机制'']', null, null, null, 150, 0, 'i', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('51D729EFC77548C7B333B08F73B24582', '/pmkpi/deptZJformance/report/editbudget', 'CREATER', '创建人', 53, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('1556CE3B41C74D2BA8EA1C3C8A6C36F6', '/pmkpi/deptZJformance/report/editbudget', 'CREATETIME', '创建时间', 54, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('7A069A07B31F44FAA9B0CADF3DC9892D', '/pmkpi/deptZJformance/report/editbudget', 'FINDEX', '一级指标', 56, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('8A264A97410A49FE9BC5584E1A83B39C', '/pmkpi/deptZJformance/report/editbudget', 'FININTORGGUID', '处室', 57, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('809EE6229C524A6AB932F42AF5EE96B6', '/pmkpi/deptZJformance/report/editbudget', 'GUID', '主键', 58, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('3F87736A534343B5A2124C6CE660967E', '/pmkpi/deptZJformance/report/editbudget', 'INDEXGUID', '来源指标', 59, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('BF4885687FB547759C50A54365E5B08C', '/pmkpi/deptZJformance/report/editbudget', 'KPI_VAL', '2022年指标值', 6, 1, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('57D23351E6CE4D1E92982788CB766090', '/pmkpi/deptZJformance/report/editbudget', 'KPI_VAL1', '2016年', 3, 1, 0, 0, null, 1, 6, '[''指标值'']', null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('A4F9BFB49E5042C493E15E2F77AABB1E', '/pmkpi/deptZJformance/report/editbudget', 'KPI_VAL2', '2020年', 4, 1, 0, 0, null, 1, 6, '[''指标值'']', null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('CF2911E2DEA64AB4963C6D522C58E499', '/pmkpi/deptZJformance/report/editbudget', 'KPI_VAL3', '2019年', 5, 1, 0, 0, null, 1, 6, '[''指标值'']', null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('4A5E229E99CC462D9C643FFD08FEB975', '/pmkpi/deptZJformance/report/editbudget', 'MAINGUID', '主表ID', 63, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('C5375D45B7CD4E5F858E36ECFE3C578B', '/pmkpi/deptZJformance/report/editbudget', 'METERUNIT', '计量单位', 7, 1, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('80DD661C8D814AE898CA51F7E39543C1', '/pmkpi/deptZJformance/report/editbudget', 'NAME', '指标名称', 1, 1, 0, 0, null, 1, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('37B31184D685447B89EA03C96170F4E7', '/pmkpi/deptZJformance/report/editbudget', 'ORDERNUM', '排序', 65, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('3596CE1283B34518BA4DD590B3694A99', '/pmkpi/deptZJformance/report/editbudget', 'PROVINCE', '区划', 66, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('8065D7439E2140C9849BD13E502DF6CB', '/pmkpi/deptZJformance/report/editbudget', 'REMARK', '备注', 22, 1, 1, 0, null, 0, 6, null, null, null, null, 250, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('C2D6339CD6FA469785543CD12FC2B6D9', '/pmkpi/deptZJformance/report/editbudget', 'SCORE', '权重', 77, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('2EAE56CAA6FF4D8C80C2C53930AACE3E', '/pmkpi/deptZJformance/report/editbudget', 'SINDEX', '二级指标', 78, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('303B26B5E55340EEB1712B275F739FAA', '/pmkpi/deptZJformance/report/editbudget', 'UPDATETIME', '更新', 79, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E27EB5567E544BB499F39876CCE078B7', '/pmkpi/deptZJformance/report/editbudget', 'YEAR', '年度', 52, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');
