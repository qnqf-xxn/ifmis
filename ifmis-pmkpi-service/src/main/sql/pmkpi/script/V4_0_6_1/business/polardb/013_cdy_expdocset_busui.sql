begin

update p#busfw_t_uitable t set t.pagenum=100 where t.key in('/pmkpi/setting/expdoc');
update p#busfw_t_uicolumn t set t.isvisiable=0 where t.key in('/pmkpi/setting/expdoc') and t.columncode='ORDERNUM';
update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/setting/expdoc') and t.code in('add','del');

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/setting/expdoctemp');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 's', 'GUID', 'GUID', 0, null, 1, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 's', '模板名称', 'TEMPLATENAME', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 's', '模板编码', 'TEMPLATECODE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 'tree', '导出类型', 'EXPTYPE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 'tree', '是否可压缩', 'ISZIP', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 'textarea', '导出文件名称', 'EXPFILENAME', 1, null, 0, null, 5, 2, '1', 'pmkpi', 1, null, '{}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 's', '排序', 'ORDERNUM', 0, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 's', '状态', 'STATUS', 0, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 's', '年度', 'YEAR', 0, null, 0, null, 10, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null,'2016','87');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/setting/expdoctemp', 'V_PERF_T_EXPDOCMAIN', 's', '区划', 'PROVINCE', 0, null, 0, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null,'2016','87');