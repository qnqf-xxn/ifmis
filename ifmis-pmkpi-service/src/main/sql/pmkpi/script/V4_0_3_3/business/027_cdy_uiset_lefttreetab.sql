begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/set/pmkpilefttreetab/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/set/pmkpilefttreetab/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.buspage.ui.UiSetPage', 'editpage', '{main:[datatable],footer:[toolbutton]}', null, null, null);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/set/pmkpilefttreetab/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/pmkpilefttreetab/edit', 'pmkpi_uiset', '{}', 'pmkpiuiset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/pmkpilefttreetab/edit', 'bustoolbutton', '{key:''/pmkpi/set/uiqueryformcols/edit''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/set/pmkpilefttreetab/edit', 'busuidatatable', '{addrow:false,name:''×ó²àÊ÷Ò³Ç©'',edit:true,checkbox:true,title:''×ó²àÊ÷Ò³Ç©''}', 'datatable', 'pmkpi', null);

delete from bus_t_dictable t where t.tablecode='PERF_T_TREETAB';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_TREETAB', '¼¨Ð§×ó²àÊ÷Ò³Ç©ÅäÖÃ±í', '¼¨Ð§×ó²àÊ÷Ò³Ç©ÅäÖÃ±í', 2, 1, 'PERF_T_TREETAB', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_T_TREETAB', sysdate, 1, 1, null, '1');

delete from bus_t_diccolumn t where t.tablecode='PERF_T_TREETAB';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CODE', '1', '2022', '87', 'F0512C3449B15809E0533315A8C047BB', 'CODE', 'PERF_T_TREETAB', 'Ò³Ç©±àÂë', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CONFIG', '1', '2022', '87', 'F0512C3449AB5809E0533315A8C047BB', 'CONFIG', 'PERF_T_TREETAB', 'ÅäÖÃÐÅÏ¢', 'S', '2000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'GUID', '1', '2022', '87', 'F0512C3449AC5809E0533315A8C047BB', 'GUID', 'PERF_T_TREETAB', 'Ö÷½¨', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'HIDEBTNS', '1', '2022', '87', 'F0512C3449A85809E0533315A8C047BB', 'HIDEBTNS', 'PERF_T_TREETAB', 'Òþ²Ø°´Å¥', 'S', '200', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '8700I935L0bK', null, '0', 'ISVISIABLE', '1', '2022', '87', 'F0512C3449AD5809E0533315A8C047BB', 'ISVISIABLE', 'PERF_T_TREETAB', 'ÊÇ·ñÏÔÊ¾', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'KEY', '1', '2022', '87', 'F0512C3449AE5809E0533315A8C047BB', 'KEY', 'PERF_T_TREETAB', 'KEY', 'S', '100', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LEFTMENUID', '1', '2022', '87', 'F0512C3449AA5809E0533315A8C047BB', 'LEFTMENUID', 'PERF_T_TREETAB', '×ó²àÊ÷Ò³Ç©²Ëµ¥id', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LEFTWFID', '1', '2022', '87', 'F0512C3449A95809E0533315A8C047BB', 'LEFTWFID', 'PERF_T_TREETAB', '×ó²àÊ÷Ò³Ç©Á÷³Ìid', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'NAME', '1', '2022', '87', 'F0512C3449AF5809E0533315A8C047BB', 'NAME', 'PERF_T_TREETAB', 'ÏÔÊ¾Ãû³Æ', 'S', '100', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ORDERNUM', '1', '2022', '87', 'F0512C3449B05809E0533315A8C047BB', 'ORDERNUM', 'PERF_T_TREETAB', 'ÅÅÐò', 'N', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2022', '87', 'F0512C3449B35809E0533315A8C047BB', 'PROVINCE', 'PERF_T_TREETAB', 'Çø»®', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2022', '87', 'F0512C3449B25809E0533315A8C047BB', 'YEAR', 'PERF_T_TREETAB', 'Äê¶È', 'S', '4', null, 1, 1, null, sysdate);


delete from p#busfw_t_uitable t where t.key in('/pmkpi/set/pmkpilefttreetab/edit');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'V_PERF_T_TREETAB', 100, 0, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/set/pmkpilefttreetab/edit');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'GUID', 'Ö÷¼ü', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'KEY', 'Ò³ÃæKEY', 2, 1, 0, 0, null, 1, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'CODE', 'Ò³Ç©±àÂë', 3, 1, 0, 0, null, 1, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'NAME', 'Ò³Ç©Ãû³Æ', 5, 1, 1, 0, null, 1, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'ISVISIABLE', 'ÊÇ·ñÏÔÊ¾', 8, 1, 1, 0, null, 1, 1, null, null, null, null, null, 1, 'tree', '{format:''#code-#name''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'HIDEBTNS', 'Òþ²Ø°´Å¥', 9, 1, 1, 0, null, 0, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'ORDERNUM', 'ÅÅÐò', 10, 1, 1, 0, null, 1, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'LEFTWFID', '×ó²àÁ÷³Ìid', 11, 1, 1, 0, null, 0, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'LEFTMENUID', '×ó²à²Ëµ¥id', 12, 1, 1, 0, null, 0, 1, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/set/pmkpilefttreetab/edit', 'CONFIG', 'ÊôÐÔ', 13, 1, 1, 0, null, 0, 1, null, null, null, null, null, null, 's', null, null);
