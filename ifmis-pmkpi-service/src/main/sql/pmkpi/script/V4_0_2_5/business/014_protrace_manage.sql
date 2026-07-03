begin
delete from bus_t_pageconsole where url ='/pmkpi/program/trace/manage/prolist';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/prolist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{left:lefttree,main:[tabpage,datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/trace/manage/prolist';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'pmkpi_protaskprolist', '{}', 'protaskprolist', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBF4B8DD19707ABDE0533315A8C072C7', '/pmkpi/program/trace/manage/prolist', 'PRO_TOTAL_AMT', '项目总金额', 7, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBF4B8DD19717ABDE0533315A8C072C7', '/pmkpi/program/trace/manage/prolist', 'PRO_CAT_CODE', '支出类别', 6, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DBF4B8DD19727ABDE0533315A8C072C7', '/pmkpi/program/trace/manage/prolist', 'BGTAMT', '当年预算金额', 8, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BF2274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BF3274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BF4274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 150, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BF5274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'DEPT_CODE', '主管部门', 4, 1, 0, null, null, null, null, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BF6274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'FININTORGGUID', '业务科室', 5, 1, 0, null, null, null, 1, null, '#name', null, null, 100, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BF7274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'YEAR', '预算年份', 9, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BF8274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'CREATE_TIME', '创建时间', 10, 0, 0, null, null, null, null, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);


delete from p#busfw_t_uitable where key ='/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3D3E30F8E274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'V_PERF_TRACEPROJECT_INFO', 100, 1, 0, 't.pro_code', 'exists(select 1 from v_pm_perf_goal_info a where a.pro_code=t.pro_code and a.yearflag=''0'') and t.pro_cat_code in(''22'',''3'')', 'pmkpi', null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values ('DBF4383BDA1467AEE0533315A8C04C9E', '/pmkpi/program/trace/manage/prolist', 'BGTAMT', '当年预算金额', 5, 1, 'amt', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values ('DBF4383BDA1567AEE0533315A8C04C9E', '/pmkpi/program/trace/manage/prolist', 'PRO_TOTAL_AMT', '项目总金额', 4, 1, 'amt', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values ('DBF4383BDA1667AEE0533315A8C04C9E', '/pmkpi/program/trace/manage/prolist', 'PRO_CAT_CODE', '支出类别', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values ('D4D3D3E35BC7274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 't.PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values ('D4D3D3E35BC8274CE0533315A8C0ACDD', '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);




delete from bus_t_diccolumn where TABLECODE = 'V_PERF_TRACEPROJECT_INFO';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '1', 'AGENCYGUID', '1', null, null, sys_guid(), 'AGENCYGUID', 'V_PERF_TRACEPROJECT_INFO', '单位信息', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03002', 'VD00010', null, '0', 'AGENCY_CODE', '1', null, null, sys_guid(), 'AGENCY_CODE', 'V_PERF_TRACEPROJECT_INFO', '单位代码', 'S', '21', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'BGTAMT', '1', null, null, sys_guid(), 'BGTAMT', 'V_PERF_TRACEPROJECT_INFO', '当年预算总额', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '61006100UEw5VQ8y', null, '0', 'CREATER', '1', null, null, sys_guid(), 'CREATER', 'V_PERF_TRACEPROJECT_INFO', '建单人', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'DEPT_CODE', '1', null, null,sys_guid(), 'DEPT_CODE', 'V_PERF_TRACEPROJECT_INFO', '部门代码', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09004', null, '0', 'DEP_AUD_OPINION_CODE', '1', null, null, sys_guid(), 'DEP_AUD_OPINION_CODE', 'V_PERF_TRACEPROJECT_INFO', '部门审核意见', 'S', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09002', null, '0', 'DISTRI_TYPE_CODE', '1', null, null, sys_guid(), 'DISTRI_TYPE_CODE', 'V_PERF_TRACEPROJECT_INFO', '分配方式', 'S', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE05004', 'VD10004', null, '0', 'EXP_FUNC_CODE', '1', null, null, sys_guid(), 'EXP_FUNC_CODE', 'V_PERF_TRACEPROJECT_INFO', '支出功能分类科目代码', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', null, null, sys_guid(), 'FININTORGGUID', 'V_PERF_TRACEPROJECT_INFO', '财政处室', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_ATTACH', '1', null, null, sys_guid(), 'IS_ATTACH', 'V_PERF_TRACEPROJECT_INFO', '是否填报附件', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_BGT', '1', null, null, sys_guid(), 'IS_BGT', 'V_PERF_TRACEPROJECT_INFO', '是否纳入', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_CAPTIAL_CONS_PRO', '1', null, null, sys_guid(), 'IS_CAPTIAL_CONS_PRO', 'V_PERF_TRACEPROJECT_INFO', '是否基建项目', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_DELETED', '1', null, null, sys_guid(), 'IS_DELETED', 'V_PERF_TRACEPROJECT_INFO', '是否删除', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_DIVIDE_PRO', '1', null, null, sys_guid(), 'IS_DIVIDE_PRO', 'V_PERF_TRACEPROJECT_INFO', '是否拆分项目', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_END', '1', null, null, sys_guid(), 'IS_END', 'V_PERF_TRACEPROJECT_INFO', '是否终止', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_GOVPUR', '1', null, null, sys_guid(), 'IS_GOVPUR', 'V_PERF_TRACEPROJECT_INFO', '是否填报采购', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_OTHER_EDIT', '1', null, null, sys_guid(), 'IS_OTHER_EDIT', 'V_PERF_TRACEPROJECT_INFO', '是否代编', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_PERFORM', '1', null, null, sys_guid(), 'IS_PERFORM', 'V_PERF_TRACEPROJECT_INFO', '是否填报绩效', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_SCIENTIFIC', '1', null, null, sys_guid(), 'IS_SCIENTIFIC', 'V_PERF_TRACEPROJECT_INFO', '是否科研项目', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_THIN', '1', null, null, sys_guid(), 'IS_THIN', 'V_PERF_TRACEPROJECT_INFO', '是否细化', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_TO_DOWN', '1', null, null, sys_guid(), 'IS_TO_DOWN', 'V_PERF_TRACEPROJECT_INFO', '是否对下项目', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_TRACK', '1', null, null, sys_guid(), 'IS_TRACK', 'V_PERF_TRACEPROJECT_INFO', '是否追踪', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_USESET', '1', null, null, sys_guid(), 'IS_USESET', 'V_PERF_TRACEPROJECT_INFO', '是否设置使用范围', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'IS_WAIT_DIVIDE', '1', null, null, sys_guid(), 'IS_WAIT_DIVIDE', 'V_PERF_TRACEPROJECT_INFO', '是否待安排项目', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '0', 'LASTAUDIT', '1', null, null, sys_guid(), 'LASTAUDIT', 'V_PERF_TRACEPROJECT_INFO', '是否终审', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'MANAGE_DEPT_CODE', '1', null, null, sys_guid(), 'MANAGE_DEPT_CODE', 'V_PERF_TRACEPROJECT_INFO', '主管部门代码', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03026', '099003', null, '0', 'MANAGE_MOF_DEP_CODE', '1', null, null, sys_guid(), 'MANAGE_MOF_DEP_CODE', 'V_PERF_TRACEPROJECT_INFO', '主管处室代码', 'S', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09005', null, '0', 'MOF_AUD_OPINION_CODE', '1', null, null, sys_guid(), 'MOF_AUD_OPINION_CODE', 'V_PERF_TRACEPROJECT_INFO', '财政审核意见', 'S', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03026', '099003', null, '0', 'MOF_DEP_CODE', '1', null, null, sys_guid(), 'MOF_DEP_CODE', 'V_PERF_TRACEPROJECT_INFO', '财政内部机构代码', 'S', '6', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD08001', null, '1', 'MOF_DIV_CODE', '1', null, null, sys_guid(), 'MOF_DIV_CODE', 'V_PERF_TRACEPROJECT_INFO', '财政区划代码', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PDMVD09001', null, '0', 'PRO_CAT_CODE', '1', null, null, sys_guid(), 'PRO_CAT_CODE', 'V_PERF_TRACEPROJECT_INFO', '项目类别', 'S', '32', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09007', null, '0', 'PRO_SOURCE_CODE', '1', null, null, sys_guid(), 'PRO_SOURCE_CODE', 'V_PERF_TRACEPROJECT_INFO', '项目来源代码', 'S', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_TOTAL_AMT', '1', null, null, sys_guid(), 'PRO_TOTAL_AMT', 'V_PERF_TRACEPROJECT_INFO', '项目总额', 'N', null, null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('DE03002', 'VD00010', null, '0', 'TRAOBJ_AGENCY_CODE', '1', null, null, sys_guid(), 'TRAOBJ_AGENCY_CODE', 'V_PERF_TRACEPROJECT_INFO', '去向单位代码', 'S', '21', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('092004', '099076', null, '0', 'WFSTATUS', '1', null, null, sys_guid(), 'WFSTATUS', 'V_PERF_TRACEPROJECT_INFO', '流程状态', 'S', null, null, 1, 1, null, sysdate);
