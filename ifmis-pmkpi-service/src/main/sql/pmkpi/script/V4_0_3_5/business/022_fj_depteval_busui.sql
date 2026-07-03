begin

--部门评价列表ui-追加部门整体类型列表字段
delete from p#busfw_t_uicolumn t where t.key ='/pmkpi/evaluation/dept/program';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'GUID', '主键', 15, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, 80, 0, 's', '{ispro:1}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'WFSTATUS', '审核状态', 1, 1, 0, null, null, null, 1, null, '#name', null, null, 80, 1, 'tree', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 150, 0, 's', '{ispro:1}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'CODE', '单位编码', 3, 1, 0, null, null, 0, 1, null, null, null, null, null, 0, 's', '{isdept:1}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'NAME', '单位名称', 3, 1, 0, null, null, null, 1, null, '#code-#name', null, null, null, 0, 's', '{isdept:1}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'AGENCYGUID', '预算单位', 6, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 150, 1, 'tree', '{ispro:1}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'YEAR', '预算年度', 7, 0, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'FININTORGGUID', '业务科室', 12, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 90, 1, 'tree', '{}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'MANAGE_MOF_DEP_CODE', '资金归口处室', 13, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{ispro:1}', null, null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/program', 'CREATER', '填报人', 13, 1, 0, null, null, null, 1, null, '#name', null, null, 90, 1, 'tree', '{}', null, null, null);
