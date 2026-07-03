begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/busauditdefine/editmenu');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/busauditdefine/editmenu', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine.BusAuditDefinePage', 'editMenu', '{main:[editform],footer:[toolbutton]}', null, null, 0);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/busauditdefine/editmenu');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '菜单主建（请联系研发）', 'GUID', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '编码', 'CODE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '名称', 'NAME', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '排序', 'ORDERNUM', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '级次', 'LEVELNO', 0, null, 0, null, 6, null, null, 'pmkpi', 0, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '是否末级', 'ISLEAF', 0, null, 0, null, 7, null, null, 'pmkpi', 0, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '父级菜单', 'SUPERID', 0, null, 0, null, 8, null, null, 'pmkpi', 0, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', 'CREATER', 'CREATER', 0, null, 0, null, 10, null, null, 'pmkpi', 1, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '创建时间', 'CREATETIME', 0, null, 0, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '区划', 'PROVINCE', 0, null, 0, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null,  null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/busauditdefine/editmenu', 'PERF_T_AUDITDEFINEMENU', 's', '年度', 'YEAR', 0, null, 0, null, 13, null, null, 'pmkpi', 0, null, '{}', null, null, null,  null, null, null);
