begin


delete from bus_t_pageconsole t where t.url = '/pmkpi/workevaluate/performance/deptedit'; 
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/performance/deptedit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditformformal],footer:[toolbutton]}', null, null, 0);




delete from bus_t_pageconsolecomconfig t where t.url = '/pmkpi/workevaluate/performance/deptedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/workevaluate/performance/deptedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/workevaluate/performance/deptedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/workevaluate/performance/deptedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/workevaluate/performance/deptedit', 'buseditform', '{key:''/pmkpi/workevaluate/performance/deptedit/info'',title:''基本信息'',tablecode:''v_perf_t_worktaskassign'',iswf:''true'',columnsize:2}', 'infoeditformformal', 'pmkpi', null, null);



delete from p#busfw_t_uieditform t where t.key = '/pmkpi/workevaluate/performance/deptedit/info'; 
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/info', 'V_PERF_T_VIEWNX', 'tree', '部门', 'CODE', 1, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/info', 'V_PERF_T_VIEWNX', 'tree', '业务处室', 'FININTORGGUID', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null, '87', '2016', null, null, null);







delete from p#busfw_t_uitabpage t where t.key = '/pmkpi/workevaluate/performance/deptedit'; 
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/performance/deptedit', '绩效考核评分表', 'deptscore', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效考核评分表', null, null, '{url:''/pmkpi/workevaluate/performance/deptedit/score.page?scoretype=deptscore'',busguid:''C3395BDB3BF5441CE053B11FA8C0A614'',action:''workevalscore.save''}', null, '0', 'deptworkiframe', null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/workevaluate/performance/deptedit', '基本信息', 'editinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''C3395BDB3BF3441CE053B11FA8C0A614''}', null, '0', 'infoeditformformal', null, null, null, null, null, '87', '2016', null, null, null);




delete from bus_t_pageconsole t where t.url = '/pmkpi/workevaluate/performance/deptedit/score'; 
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/workevaluate/performance/deptedit/score', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.workevaluate.score.WorkEvaluateScorePage', 'score', '{main:[datatable]}', null, null, 0);




delete from bus_t_pageconsolecomconfig t where t.url = '/pmkpi/workevaluate/performance/deptedit/score'; 
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/workevaluate/performance/deptedit/score', 'pmkpi_workevalscore', '{}', 'workevalscore', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/workevaluate/performance/deptedit/score', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null, null);






delete from p#busfw_t_uitable t where t.key = '/pmkpi/workevaluate/performance/deptedit/score'; 
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/score', 'V_PERF_T_DEPTSCORE', 0, 1, 0, null, null, 'pmkpi', '{}', '87', '2016');





delete from p#busfw_t_uicolumn t where t.key = '/pmkpi/workevaluate/performance/deptedit/score'; 
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/score', 'NAME', '考核标准', 1, 1, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/score', 'SCORE', '分值', 2, 1, 0, 1, null, 0, 1, null, '{unit:1,dotname:2,qfw:true}', null, null, null, 0, 'i', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/score', 'EVALSTD', '评分标准', 3, 1, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/score', 'RATISCORE', '评定分数', 5, 1, 1, 1, null, 0, 1, null, '{unit:1,dotname:2,qfw:true}', null, null, null, 0, 'i', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/deptedit/score', 'REMARK', '备注', 6, 1, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);








delete from p#busfw_t_uifunction t where t.key = '/pmkpi/workevaluate/performance/index'; 
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', '查看', 1, 1, 'searchicon', 'Ext.lt.pmkpi.info', null, '查看', 'pmkpi', 'info', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', '自动计算考核得分', 1, 2, 'searchicon', 'Ext.lt.pmkpi.calc', null, '自动计算考核得分', 'pmkpi', 'calc', null, '{}', '87', '2016', null, null);





delete from p#busfw_t_uiqueryform t where t.key = '/pmkpi/workevaluate/performance/index'; 
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'iseval', '已生成绩效考核表', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_VIEWNX', '{format:''#name''}', null, '87', '2016', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'totalscore', '考核总得分', 2, 1, 'n', null, null, null, 'pmkpi', 'V_PERF_T_VIEWNX', '{region:1}', null, '87', '2016', null, null, null);






delete from p#busfw_t_uitable t where t.key = '/pmkpi/workevaluate/performance/index'; 
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'V_PERF_T_VIEWNX', 100, 0, 0, null, null, 'pmkpi', null, '87', '2016');






delete from p#busfw_t_uicolumn t where t.key = '/pmkpi/workevaluate/performance/index'; 
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'SELFEVALSCORE', '绩效自评达标情况得分', 8, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 'n', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'PUBLICTARGETSCORE', '绩效公开达标情况得分', 9, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 'n', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'ISEVAL', '已生成绩效考核表', 10, 1, 0, null, null, null, 1, null, '#name', null, null, 200, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'CODE', '部门', 1, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 240, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'RATING', '等次', 6, 1, 0, null, null, null, 1, null, null, null, null, 80, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'MONITORSCORE', '绩效监控达标情况得分', 7, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 'n', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'GOALACHIEVESCORE', '绩效目标达标情况得分', 5, 1, 0, null, null, null, 1, null, null, null, null, 240, 0, 'n', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'FININTORGGUID', '业务处室', 2, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 160, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'TOTALSCORE', '考核总得分', 3, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 'n', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/workevaluate/performance/index', 'GUID', '主键', 0, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);








delete from bus_t_dictable t where t.TABLECODE='V_PERF_T_VIEWNX'; 
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2020', '87', 'V_PERF_T_VIEWNX', '宁夏绩效工作考核表', '宁夏绩效工作考核表', 1, 1, 'V_PERF_T_VIEWNX', 'pmkpi', null, '0', 1, '0', 1, 1, 'V_PERF_T_VIEWNX', null, 1, 1, null, '1');





delete from bus_t_diccolumn t where t.tablecode='V_PERF_T_VIEWNX'; 
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'CODE', '1', '2020', '87', sys_guid(), 'CODE', 'V_PERF_T_VIEWNX', '编码', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '0', 'FININTORGGUID', '1', '2020', '87', sys_guid(), 'FININTORGGUID', 'V_PERF_T_VIEWNX', '处室', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'GOALACHIEVESCORE', '1', '2020', '87', sys_guid(), 'GOALACHIEVESCORE', 'V_PERF_T_VIEWNX', '绩效目标达标情况得分', 'N', '8', 2, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '0', '2020', '87', sys_guid(), 'GUID', 'V_PERF_T_VIEWNX', '主建', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'ISEVAL', '1', '2020', '87', sys_guid(), 'ISEVAL', 'V_PERF_T_VIEWNX', '已生成绩效考核表', 'S', '4', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'MONITORSCORE', '1', '2020', '87', sys_guid(), 'MONITORSCORE', 'V_PERF_T_VIEWNX', '绩效监控达标情况得分绩效监控达标情况得分', 'N', '8', 2, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '0', '2020', '87', sys_guid(), 'NAME', 'V_PERF_T_VIEWNX', '部门', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'OLDGUID', '0', '2020', '87', sys_guid(), 'OLDGUID', 'V_PERF_T_VIEWNX', '原主建', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PUBLICTARGETSCORE', '1', '2020', '87', sys_guid(), 'PUBLICTARGETSCORE', 'V_PERF_T_VIEWNX', '绩效公开达标情况得分', 'N', '8', 2, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'RATING', '1', '2020', '87', sys_guid(), 'RATING', 'V_PERF_T_VIEWNX', '等次', 'S', '40', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'SELFEVALSCORE', '1', '2020', '87', sys_guid(), 'SELFEVALSCORE', 'V_PERF_T_VIEWNX', '绩效自评达标情况得分', 'N', '8', 2, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'TOTALSCORE', '1', '2020', '87', sys_guid(), 'TOTALSCORE', 'V_PERF_T_VIEWNX', '考核总得分', 'N', '8', 2, 1, 0, null, sysdate);






