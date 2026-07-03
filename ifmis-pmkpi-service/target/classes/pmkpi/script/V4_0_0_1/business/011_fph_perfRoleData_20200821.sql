begin

--页面组件注册
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/perfset/datarule';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('0040A32EDFCE4F91AD8A995507D1B24A', '/pmkpi/perfset/datarule', 'V_PMKPI_T_ROLEDATARULE', 0, 0, null, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/perfset/datarule';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A9292236A8534353B010C0B222338B64', '/pmkpi/perfset/datarule', 'GUID', '数据权限guid', 1, 0, 1, null, null, null, null, null, null, null, null, null, null, null, null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0D92F98BE07346FCA1CAB40C89084ECB', '/pmkpi/perfset/datarule', 'NAME', '数据权限名称', 1, 1, 1, null, null, null, null, null, null, null, null, null, null, null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/perfset/datarule';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('880EFAC4DC0C45D79647303272F8847D', '/pmkpi/perfset/datarule', '保存', 1, 3, null, 'Ext.lt.drtemplate.save', null, '保存', 'pmkpi', null, null, null);
