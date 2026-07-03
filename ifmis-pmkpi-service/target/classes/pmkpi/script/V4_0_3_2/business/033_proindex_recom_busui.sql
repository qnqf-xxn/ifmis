begin

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/program/prjindex/recomindex') and t.columncode in('FILED','OCCUPATION','FUNDUSE','PLANVAL');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'FILED', '职能', 61, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'OCCUPATION', '活动', 62, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'FUNDUSE', '资金用途', 63, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/recomindex', 'PLANVAL', '计划标准', 64, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null);
