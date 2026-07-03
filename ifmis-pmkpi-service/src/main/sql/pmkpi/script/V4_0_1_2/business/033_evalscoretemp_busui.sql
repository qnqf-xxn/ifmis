begin

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/tempdataset');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B84E9D56D6107E4AE0530100007F3871', '/pmkpi/setting/tempdataset', '保存', 1, 1, 'Keepicon', 'evalscore.savemajorkey', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9B1F32F777464B52B82597A16C090F9E', '/pmkpi/setting/tempdataset', '初始化', 0, 2, 'Keepicon', 'evalscore.copy', null, '初始化', 'pmkpi', null, null, null);

delete from p#busfw_t_uicolumn t where key in('/pmkpi/setting/tempdataset');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('889F9D8555F843CE8856C6855D469814', '/pmkpi/setting/tempdataset', 'OPERATION', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6137E4AE0530100207F3871', '/pmkpi/setting/tempdataset', 'CODE', '编码', 2, 1, 1, 0, null, 0, null, null, null, null, null, 120, 0, 's', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('29284FC3B4C5434CBB147C9BD779A00B', '/pmkpi/setting/tempdataset', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 280, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F3333', '/pmkpi/setting/tempdataset', 'SCORE', '分值', 4, 1, 1, 0, null, 1, null, null, null, null, null, 30, 0, 's', '{type:''workscore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F2222', '/pmkpi/setting/tempdataset', 'EVALSTD', '自评标准', 6, 1, 1, 0, null, 1, null, null, null, null, null, 200, 0, 's', '{type:''workscore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F5555', '/pmkpi/setting/tempdataset', 'REMARK', '评分备注', 6, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{type:''workscore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC62689EB81347298F1EDCC26D24DE47', '/pmkpi/setting/tempdataset', 'SCORE', '得分', 7, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 'amt', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F7777', '/pmkpi/setting/tempdataset', 'FILE', '附件', 8, 0, 1, 0, null, 1, null, null, null, null, null, 50, 0, 's', '{type:''workscore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F4444', '/pmkpi/setting/tempdataset', 'GUID', 'guid', 9, 0, 1, 0, null, 1, null, null, null, null, null, 50, 0, 's', '{type:''workscore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F6666', '/pmkpi/setting/tempdataset', 'QUERYSQL', '查询sql', 10, 1, 1, 0, null, 0, null, null, null, null, null, 50, 0, 's', '{type:''workscore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D16BE33B81DF486FBB1609F691CA6408', '/pmkpi/setting/tempdataset', 'SUPERID', 'superid', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F1FF3B8E053B11FA8C0D3A2', '/pmkpi/setting/tempdataset', 'ISLEAF', '是否末节点', 14, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BC8DF02C1F20F3B8E053B11FA8C0D3A3', '/pmkpi/setting/tempdataset', 'LEVELNO', '层级', 16, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F8871', '/pmkpi/setting/tempdataset', 'ORDERNUM', '排序', 22, 1, 1, 0, null, 1, null, null, null, null, null, 50, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6127E4AE0730100076F3871', '/pmkpi/setting/tempdataset', 'REMARK', '备注', 23, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D612764AE0730100077F3871', '/pmkpi/setting/tempdataset', 'EVALSTD', '评分标准', 24, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56D6127E46E0730100077F3871', '/pmkpi/setting/tempdataset', 'EXPLAIN', '指标解释', 25, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E9D56s6127E46E07301p0077F3871', '/pmkpi/setting/tempdataset', 'BUSTYPE', '业务类型', 26, 0, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56Dc127E46E0730100077F3871', '/pmkpi/setting/tempdataset', 'AUDITTYPE', '审核类型', 27, 0, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', '{type:''evaluatescore''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F8888', '/pmkpi/setting/tempdataset', 'ISEDIT', '是否编辑', 28, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B84E0D56D6127E46E0730100077F9999', '/pmkpi/setting/tempdataset', 'ISADD', '是否新增', 29, 1, 1, 0, null, 0, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('39C1152FC12A450C82D4B8614A942882', '/pmkpi/setting/tempdataset', 'GUID', 'guid', 30, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);
