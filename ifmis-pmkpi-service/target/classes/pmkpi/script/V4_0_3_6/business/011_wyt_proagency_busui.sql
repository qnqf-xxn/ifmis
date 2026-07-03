begin
--项目单位变更维护页面ui注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/proagency';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', 'GUID', '主键', 0, 0, 0, 0, null, null, null, null, null, null, null, 38, null, 's', null, null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', 'PRO_CODE', '项目编码', 1, 1, 0, 0, null, 1, 1, null, null, null, null, 100, null, 's', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', 'PRO_NAME', '项目名称', 2, 1, 0, 0, null, 1, 1, null, null, null, null, 100, null, 's', null, null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', 'AGENCY_CODE', '变更后单位', 4, 1, 0, 0, null, 1, 1, null, '#code-#name', null, null, 130, 1, 'tree', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', 'AGENCYCODE', '原单位', 3, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, 200, 1, 'tree', null, null,  null, null);


delete from p#busfw_t_uitable where key = '/pmkpi/setting/proagency';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/setting/proagency', 'PERF_V_PROJECT_AGENCY', 100, 0, 0, null, null, 'pmkpi', null);


delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/proagency';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', 't.PRO_CODE', '项目编码', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_PROJECT_AGENCY', '{}', null,  null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', 't.PRO_NAME', '项目名称', 2, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_PROJECT_AGENCY', '{}', null,  null, null, null);



delete from p#busfw_t_uifunction where key ='/pmkpi/setting/proagency';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', '删除', 1, 3, 'searchicon', 'proagency.deleted', null, '删除', 'pmkpi', 'deleted', null, '{}',  null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', '导入', 1, 4, 'import', 'proagency.import', null, '导入', 'pmkpi', 'import', null, '{}',  null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', '导出列表', 1, 5, 'export', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'expdoc', null, '{}',  null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', '新增', 1, 1, 'searchicon', 'proagency.add', null, '新增', 'pmkpi', 'add', null, '{}',  null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency', '修改', 1, 2, 'searchicon', 'proagency.update', null, '修改', 'pmkpi', 'update', null, '{}',  null, null);



--项目单位变更维护编辑页面注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/setting/proagency/edit';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency/edit', 'GUID', '主键', 0, 0, 0, 0, null, 0, 0, null, null, null, null, 38, null, 's', null, null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency/edit', 'PRO_CODE', '项目编码', 2, 1, 1, 0, null, 1, 1, null, null, null, null, 100, null, 's', '{}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency/edit', 'AGENCY_CODE', '变更后单位', 4, 1, 1, 0, null, 1, 1, null, '#code-#name', null, null, 130, 1, 'tree', '{}', null,  null, null);


delete from p#busfw_t_uitable where key = '/pmkpi/setting/proagency/edit';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/setting/proagency/edit', 'V_PERF_PROJECT_AGENCY', 0, 0, 0, null, null, 'pmkpi', null);


delete from p#busfw_t_uifunction where key ='/pmkpi/setting/proagency/edit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null,  null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/proagency/edit', '保存', 1, 1, 'Keepicon', 'proagencyedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null,  null, null);
