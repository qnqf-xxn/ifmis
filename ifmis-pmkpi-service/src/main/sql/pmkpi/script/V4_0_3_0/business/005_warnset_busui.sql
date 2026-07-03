begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/warnset');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/setting/warnset', 'PERF_T_WARNSET', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/warnset');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'GUID', '主键', 1, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'CODE', '预警规则编码', 2, 0, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'NAME', '预警规则名称', 3, 1, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'TYPE', '预警规则类别', 4, 1, 0, 0, null, 1, null, null, null, null, null, 150, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'WARNSQL', '预警规则SQL语句', 5, 1, 0, 0, null, 1, null, null, null, null, null, 500, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'YEAR', '年度', 8, 0, 0, 0, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'PROVINCE', '区划', 9, 0, 0, 0, null, 0, null, null, null, null, null, null, null, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/warnset', 'STATUS', '是否启用', 10, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/setting/warnset');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/setting/warnset', '修改', 1, 1, 'searchicon', 'perfdataset.mod', null, '修改', 'pmkpi', 'mod', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/setting/warnset');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/setting/warnset', 'NAME', '预警规则名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_WARNSET', '{}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/setting/warnset', 'TYPE', '预警规则类别', 2, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_WARNSET', '{}', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/setting/warnset/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/setting/warnset/edit', '保存', 1, 1, 'Keepicon', 'datasetedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/setting/warnset/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/setting/warnset/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/setting/warnset/edit', 'V_PERF_T_WARNSET', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/setting/warnset/edit', 'V_PERF_T_WARNSET', 's', '预警规则名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/setting/warnset/edit', 'V_PERF_T_WARNSET', 's', '预警规则类别', 'TYPE', 1, null, 1, null, 3, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/setting/warnset/edit', 'V_PERF_T_WARNSET', 'textarea', '预警规则SQL语句', 'WARNSQL', 1, null, 1, null, 4, 2, '3', 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/setting/warnset/edit', 'V_PERF_T_WARNSET', 'tree', '是否启用', 'STATUS', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', null, null, null, null);