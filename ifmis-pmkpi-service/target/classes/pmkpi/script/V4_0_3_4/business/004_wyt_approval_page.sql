begin
  
delete from bus_t_pageconsole where url ='/pmkpi/approval/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/approval/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/approval/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query', 'buseditform', '{key:''/pmkpi/yearprogram/query/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);



delete from bus_t_pageconsolecomconfig where url ='/pmkpi/approval/program/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'busfw.dataexport', '{}', 'dataexport', null, null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'busuidatatable', '{name:''预算批复项目'',checkbox:true,title:''预算批复项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/approval/program/query', 'pmkpi_approvalquery', '{}', 'approvalquery', 'pmkpi', null);


--表格字段注册
delete from bus_t_diccolumn where tablecode ='PERF_BGT_PROJECTPF' and columncode in('FININTORGGUID','PRO_CAT_CODE','PRO_LEV');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', '2016', '87', 'F181C16A50056F77E0533315A8C0A0C0', 'FININTORGGUID', 'PERF_BGT_PROJECTPF', '财政处室', 'S', '6', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09001', null, '0', 'PRO_CAT_CODE', '1', null, null, 'F181C16A50066F77E0533315A8C0A0C0', 'PRO_CAT_CODE', 'PERF_BGT_PROJECTPF', '项目类别', 'S', '2', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_LEV', '1', '2016', '87', 'F181C16A50076F77E0533315A8C0A0C0', 'PRO_LEV', 'PERF_BGT_PROJECTPF', '项目级次', 'S', '2', null, 1, 1, null, sysdate);

delete from bus_t_diccolumn where tablecode ='PERF_BGT_V_PROJECTPF';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'AGENCYGUID', '1', '2016', '87', 'F1D20960C97D35CBE0533315A8C04D4A', 'AGENCYGUID', 'PERF_BGT_V_PROJECTPF', '单位信息', 'S', null, null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03002', 'VD00010', null, '1', 'AGENCY_CODE', '1', '2016', '87', 'F1D20960C97E35CBE0533315A8C04D4A', 'AGENCY_CODE', 'PERF_BGT_V_PROJECTPF', '单位代码', 'S', '21', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', '2016', '87', 'F1D20960C97F35CBE0533315A8C04D4A', 'FININTORGGUID', 'PERF_BGT_V_PROJECTPF', '财政处室', 'S', '6', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_DELETED', '1', '2016', '87', 'F1D20960C98035CBE0533315A8C04D4A', 'IS_DELETED', 'PERF_BGT_V_PROJECTPF', '是否删除', 'N', '1', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09001', null, '0', 'PRO_CAT_CODE', '1', null, null, 'F1D20960C98135CBE0533315A8C04D4A', 'PRO_CAT_CODE', 'PERF_BGT_V_PROJECTPF', '项目类别', 'S', '2', null, 1, 1, null, sysdate);



--表注册
delete from p#busfw_t_uitable where key ='/pmkpi/approval/program/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PERF_BGT_V_PROJECTPF', 100, 0, 0, null, null, 'pmkpi', null);


--表字段注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/approval/program/query';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, 120, 0, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_TOTAL_AMT', '项目总额', 4, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'SETUP_YEAR', '设立年度', 8, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_ID', '项目guid', 0, 0, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'GUID', 'GUID', 0, 0, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_CAT_CODE', '项目类别', 6, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'PRO_LEV', '项目级次', 7, 1, 0, null, null, null, 1, null, null, null, null, 200, 1, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'BGTAMT', '当年预算金额', 5, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null,  null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', 'FININTORGGUID', '业务科室', 9, 1, 0, null, null, null, 1, null, '#name', null, null, 100, 1, 'tree', '{}', null,  null, null);


--按钮注册
delete from p#busfw_t_uifunction where key ='/pmkpi/approval/program/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', '导出列表', 1, 2, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}',  null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/approval/program/query', '查看项目明细', 1, 1, 'searchicon', 'approvalquery.queryView', null, '查看项目明细', 'pmkpi', 'proinfoview', null, null,  null, null);



--详情页页签注册
delete from p#busfw_t_uitabpage where key ='/pmkpi/approval/query';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query', '基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''5498A7A14F70471A9B8FB1666AD6B2C3''}', null, '0', 'editform', null, null, null, null, null,  null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query', '年度绩效目标', 'tabgoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效目标', null, null, '{url:''/pmkpi/approval/query/protabgoal.page?showtab=3'',busguid:''C0B38427A5C119E4E053B11FA8C0573E''}', null, '0', 'iframetabgoal', null, null, null, null, null,  null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/approval/query', '年度绩效指标', 'yearindex', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效指标', null, null, '{url:''/pmkpi/approval/query/treeindex.page?showtab=3''}', null, '0', 'iframeindextable', null, null, null, null, null,  null, null, null);

