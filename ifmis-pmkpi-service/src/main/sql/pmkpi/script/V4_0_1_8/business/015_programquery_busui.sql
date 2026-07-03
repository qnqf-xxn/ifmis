begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/query/list') and code ='queryprogram';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CBDA79A46AFB0FF4E0533315A8C0CC18', '/pmkpi/program/query/list', '查看项目明细', 1, 6, 'searchicon', 'Ext.lt.pmkpi.proinfoview', null, '查看项目明细', 'pmkpi', 'queryprogram', null, null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/query/list') and COLUMNCODE='PRO_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('35E034ACE1D2BE9C53D862BA1D036F01', '/pmkpi/program/query/list', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 120, 0, 's', '{}', null);
