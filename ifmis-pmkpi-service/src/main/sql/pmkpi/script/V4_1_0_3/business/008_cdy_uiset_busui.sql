begin

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/set/uidatatablecols/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '标识', 'GUID', 0, null, 1, null, 0, null, null, 'pmkpi', 0, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', 'key', 'KEY', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', 'LOCKNUM', 'LOCKNUM', 1, null, 0, null, 2, null, null, 'pmkpi', 1, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '表名称', 'TABLECODE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '过滤条件sql', 'DEFQUERY', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '配置信息', 'CONFIG', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '排序字段', 'ORDERBY', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '分页数', 'PAGENUM', 1, null, 0, null, 7, null, null, 'pmkpi', 1, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '是否分页', 'TOTALTAG', 1, null, 0, null, 8, null, null, 'pmkpi', 1, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/set/uidatatablecols/edit', 'BUSFW_T_UITABLE', 's', '系统标识', 'APPID', 1, null, 1, null, 9, null, null, 'pmkpi', 0, null, null, null, null, null);
