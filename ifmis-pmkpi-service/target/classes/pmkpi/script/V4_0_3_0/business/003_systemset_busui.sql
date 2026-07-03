begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/kpisystemset');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'V_PERF_T_SYSTEMSET', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/kpisystemset');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'GUID', '主键', 1, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'PARAMCODE', '参数编码', 2, 1, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'PARAMNAME', '参数名称', 3, 1, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'PARAMVALUE', '参数值', 4, 1, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'REMARK', '描述', 5, 1, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'APPID', '系统', 6, 0, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'STATUS', '是否启用', 7, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, 50, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'YEAR', '年度', 8, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'PROVINCE', '区划', 9, 0, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'ORDERNUM', '排序', 10, 0, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', '{}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/setting/kpisystemset');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/setting/kpisystemset', '修改', 1, 1, 'mod', 'kpisystemset.mod', null, '修改', 'pmkpi', 'mod', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/setting/kpisystemset');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'PARAMCODE', '参数编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_SYSTEMSET', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'PARAMNAME', '参数名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_SYSTEMSET', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/setting/kpisystemset', 'STATUS', '是否启用', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_SYSTEMSET', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/kpisystemset/infoedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', '保存', 1, 1, 'Keepicon', 'kpisystemsetedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/kpisystemset/infoedit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', 'V_PERF_T_SYSTEMSET', 's', '参数编码', 'PARAMCODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', 'V_PERF_T_SYSTEMSET', 's', '参数名称', 'PARAMNAME', 1, null, 1, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', 'V_PERF_T_SYSTEMSET', 'textarea', '参数值', 'PARAMVALUE', 1, null, 1, null, 3, 2, '3', 'pmkpi', 1, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', 'V_PERF_T_SYSTEMSET', 'textarea', '描述', 'REMARK', 1, null, 1, null, 4, 2, '3', 'pmkpi', 0, null, '{}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', 'V_PERF_T_SYSTEMSET', 'tree', '是否启用', 'STATUS', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/kpisystemset/infoedit', 'V_PERF_T_SYSTEMSET', 's', 'GUID', 'GUID', 0, null, 0, null, 6, null, null, 'pmkpi', 0, null, '{}', null, null, null, null);
