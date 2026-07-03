begin

--页面配置
delete from p#busfw_t_uitable t where key in('/pmkpi/setting/buspage');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG )
values ('BFC33581E250F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'BUS_T_PAGECONSOLECOMCONFIG', 0, 0, 0, null, null, 'pmkpi', null );

delete from p#busfw_t_uicolumn t where key in('/pmkpi/setting/buspage');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC33581E257F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'UI', '配置', 1, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null );

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC33581E251F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'URL', '页面url', 2, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null );

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC33581E252F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'COMPONENTID', '组件', 3, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null );

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC6A35D5789520DE053B11FA8C0963C', '/pmkpi/setting/buspage', 'COMPONENTNAME', '组件名称', 4, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null );

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC33581E253F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'CONFIG', '组件配置', 5, 1, 1, null, null, 1, null, null, null, null, null, 300, 0, 's', '{}', null );

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC33581E254F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'ID', '组件id', 6, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null );

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC33581E255F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'APPID', '系统标识', 7, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null );

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL )
values ('BFC33581E256F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', 'REGION', 'REGION', 8, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null );

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/buspage');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFC33581E249F50AE053B11FA8C0F274', '/pmkpi/setting/buspage', '新增菜单', 1, 1, 'searchicon', 'buspage.add', null, '新增菜单', 'pmkpi', 'add', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFC33581E24AF50AE053B11FA8C0F274', '/pmkpi/setting/buspage', '修改菜单', 1, 2, 'searchicon', 'buspage.mod', null, '修改菜单', 'pmkpi', 'mod', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFC33581E24BF50AE053B11FA8C0F274', '/pmkpi/setting/buspage', '删除菜单', 1, 3, 'searchicon', 'buspage.del', null, '删除菜单', 'pmkpi', 'del', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFD6DF0F1DC655CBE053B11FA8C05E69', '/pmkpi/setting/buspage', '置顶', 1, 7, 'searchicon', 'buspage.settop', null, '置顶', 'pmkpi', 'settop', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFD6DF0F1DC755CBE053B11FA8C05E69', '/pmkpi/setting/buspage', '置尾', 1, 8, 'searchicon', 'buspage.setend', null, '置尾', 'pmkpi', 'setend', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFD6DF0F1DC855CBE053B11FA8C05E69', '/pmkpi/setting/buspage', '上移', 1, 9, 'searchicon', 'buspage.setup', null, '上移', 'pmkpi', 'setup', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFD6DF0F1DC955CBE053B11FA8C05E69', '/pmkpi/setting/buspage', '下移', 1, 10, 'searchicon', 'buspage.setdown', null, '下移', 'pmkpi', 'setdown', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFC33581E24CF50AE053B11FA8C0F274', '/pmkpi/setting/buspage', '保存', 1, 11, 'searchicon', 'buspage.save', null, '保存', 'pmkpi', 'save', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C00F3C77D4244110E053B11FA8C079EA', '/pmkpi/setting/buspage', '刷新缓存', 0, 12, 'searchicon', 'buspage.cachenames', null, '刷新缓存', 'pmkpi', 'cachenames', null, '{}');

--菜单编辑
delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/buspage/setmenu');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFD318FCE86E03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', '保存', 1, 1, 'searchicon', 'buseditmenu.save', null, '保存', 'pmkpi', 'save', null, '{}' );

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG )
values ('BFD318FCE87003CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'close', null, '{}' );

delete from p#busfw_t_uieditform t where key in('/pmkpi/setting/buspage/setmenu');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84503CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'V_PERF_T_FINEVALUATION', 's', 'guid', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84603CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'V_PERF_T_FINEVALUATION', 's', '菜单编码', 'CODE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84703CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'V_PERF_T_FINEVALUATION', 's', '菜单名称', 'NAME', 1, null, 1, null, 3, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84803CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '菜单url', 'UIKEY', 1, null, 1, null, 4, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84903CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '父级菜单', 'SUPERGUID', 0, null, 0, null, 6, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84A03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '级次', 'LEVELNO', 0, null, 0, null, 7, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84B03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '是否末级', 'ISLEAF', 0, null, 0, null, 9, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84C03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '排序', 'ORDERNUM', 1, null, 1, null, 10, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84D03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '状态', 'STATUS', 0, null, 0, null, 11, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84E03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '创建时间', 'CREATETIME', 0, null, 0, null, 12, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE84F03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '修改时间', 'UPDATETIME', 0, null, 0, null, 13, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE85003CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '创建人', 'CREATER', 0, null, 0, null, 16, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE85B03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '区划', 'PROVINCE', 0, null, 0, null, 13, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE )
values ('BFD318FCE85C03CBE053B11FA8C00A52', '/pmkpi/setting/buspage/setmenu', 'PERF_T_PAGEMENU', 's', '年度', 'YEAR', 0, null, 0, null, 16, null, null, 'pmkpi', 1, 0, '{}', 0, 0, 0 );
