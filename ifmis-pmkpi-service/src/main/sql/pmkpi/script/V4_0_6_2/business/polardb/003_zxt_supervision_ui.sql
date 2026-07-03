begin

delete from p#busfw_t_uicolumn where  key = '/pmkpi/supervision/index' AND COLUMNCODE in ('YEAR','PROVINCE','INDEXGUID','CREATER','CREATETIME','UPDATETIME','PROTYPE');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/supervision/index', 'YEAR', '年度', 23, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/supervision/index', 'PROVINCE', '区划', 24, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/supervision/index', 'INDEXGUID', '指标ID', 25, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/supervision/index', 'CREATER', '创建人', 26, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/supervision/index', 'CREATETIME', '创建时间', 27, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/supervision/index', 'UPDATETIME', '更新时间', 28, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,province,year)
values (sys_guid(), '/pmkpi/supervision/index', 'PROTYPE', '监审项目类型', 29, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null,'87','2016');