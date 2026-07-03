begin


delete from p#busfw_t_uitable t where t.key in('/pmkpi/busauditdefine/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('A042A97CCB0349608D6B2FA048075C14', '/pmkpi/busauditdefine/index', 'PERF_T_BUSAUDITDEFINE', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/busauditdefine/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4543802161C4D87BF6D59025C74AC63', '/pmkpi/busauditdefine/index', 'AUDITDEFINE', '审核定义', 4, 1, 1, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CC747A5144904CC7A676CD4FBDBBFFFE', '/pmkpi/busauditdefine/index', 'BUSGUID', '业务guid', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('09FDD152DFD643E08D20F92479A102A2', '/pmkpi/busauditdefine/index', 'ERRTYPE', '错误级别', 5, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('24D700DC1D204988BF9DC4BBD11181EB', '/pmkpi/busauditdefine/index', 'GUID', 'guid', 1, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E1F454E0F07348739A3BC6D76D5E719C', '/pmkpi/busauditdefine/index', 'ORDERNUM', '排序', 3, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);


delete from p#busfw_t_uifunction t where key in('/pmkpi/busauditdefine/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('174F2F064B9442B3A9B7ACDFBF8BA6B5', '/pmkpi/busauditdefine/index', '保存', 1, 1, 'addicon', 'busauditdefine.save', null, '保存', 'pmkpi', 'save', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('FCDA07DBBDA0439EBC11BB7BBCF5695E', '/pmkpi/busauditdefine/index', 'delmenu', 1, 3, 'addicon', 'busauditdefine.delmenu', null, 'delmenu', 'pmkpi', 'save', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F05C83A2C9AB497AA4222351233C0F1B', '/pmkpi/busauditdefine/index', 'modmenu', 1, 2, 'addicon', 'busauditdefine.modmenu', null, 'modmenu', 'pmkpi', 'save', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('FCDA07DBBDA0439EBC11BB7BBCF5695E', '/pmkpi/busauditdefine/index', 'addmenu', 1, 2, 'addicon', 'busauditdefine.addmenu', null, 'addmenu', 'pmkpi', 'save', null, null);


delete from p#busfw_t_uieditform t where key in('/pmkpi/busauditdefine/editmenu');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B410CD8C694C46BD85663D034C57E0A2', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '主键', 'GUID', 1, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('F2962D40C7A143E08C0B6CFAC91236A3', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '父级菜单', 'SUPERID', 0, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7DF9D5E2140C4B6D978EFA8D9E5A2B94', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '编码', 'CODE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E4A4505510BA429296CD4A3D7334AFF3', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '名称', 'NAME', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('21AB409045C54193B78FA917E3571393', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '创建时间', 'CREATETIME', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('790DC445448646E2B39A1A1B4B825FB7', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '级次', 'LEVELNO', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1CDD15E1AD7C4A34980E0EEDC8D438DE', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '是否末级', 'ISLEAF', 0, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('766633FC5D8240D3A0ABBFA6648D1C2A', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '排序', 'ORDERNUM', 0, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D9EF08D88A3546A8A5FF74928AFF7946', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', 'CREATER', 'CREATER', 0, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('03BC4DD3EA1749BF86427D2B6DAAE97F', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '年度', 'YEAR', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('593E4B39A2F446F8A00D7EC4D0B68850', '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '区划', 'PROVINCE', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/busauditdefine/editmenu');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BEE305DCEB7A4F929572F662FDAFC0BC', '/pmkpi/busauditdefine/editmenu', '保存', 1, 1, 'addicon', 'busauditeditmenu.save', null, '保存', 'pmkpi', 'save', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B8EC8EB9183749DD96B230D94AAA2592', '/pmkpi/busauditdefine/editmenu', '取消', 1, 2, 'addicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'colse', null, null);


