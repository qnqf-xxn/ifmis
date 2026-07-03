begin

DELETE FROM p#busfw_t_Uitable t where t.key='/pmkpi/arrangement/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B84E9D56D6117E4AE0530100007F3871', '/pmkpi/arrangement/index', 'V_PERF_T_FRAME', 0, 0, 0, '', '', 'pmkpi', '');


DELETE FROM p#busfw_t_Uicolumn t where t.key='/pmkpi/arrangement/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D16BE33B81DF486FBB1609F69ACA6408', '/pmkpi/arrangement/index', 'SUPERID', 'SUPERID', 12, 0, 0, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6137E4AE0530100007F3871', '/pmkpi/arrangement/index', 'CODE', '编码', 4, 1, 1, 0, '', 1, null, '', '', '', null, 120, 0, 's', '', '');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC62689EB81747298F1EDCC26D24DE47', '/pmkpi/arrangement/index', 'WEIGHT', '权重', 7, 1, 1, 0, '', 0, null, '', '', '', null, 100, 0, 'amt', '', '');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('29284FC3B1C5434CBB147C9BD779A00B', '/pmkpi/arrangement/index', 'NAME', '指标名称', 5, 1, 1, 0, '', 1, null, '', '', '', null, 280, 0, 's', '', '');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39C1152FC12A480C82D4B8614A942882', '/pmkpi/arrangement/index', 'GUID', 'GUID', 3, 0, 0, 0, '', 0, null, '', '', '', null, 150, 0, 's', '', '');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('889F9D8555F843CE885DC6855D469814', '/pmkpi/arrangement/index', 'OBLIGATE', '操作', 1, 1, 0, 0, '', 0, null, '', '', '', null, 100, 0, 's', '', '');

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6127E4AE0530100007F3871', '/pmkpi/arrangement/index', 'REMARK', '备注', 23, 1, 1, 0, '', 0, null, '', '', '', null, null, 0, 's', '', '');


DELETE FROM p#busfw_t_Uifunction t where t.key='/pmkpi/arrangement/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B84E9D56D6107E4AE0530100007F3871', '/pmkpi/arrangement/index', '保存', 1, 1, 'Keepicon', 'arrangement.save', null, '保存', 'pmkpi', '', '', '');

insert into P#busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9B1F32F777464B52B82597A16C090F9E', '/pmkpi/arrangement/index', '复制上年指标层级', 1, 2, 'Keepicon', 'arrangement.copy', null, '复制上年指标层级', 'pmkpi', null, null, null);
