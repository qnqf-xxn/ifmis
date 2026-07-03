begin
--自评填报  预算执行情况部分字段可编辑
delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/apply/edit/bdgpay';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598810DAFE4530603A8C02DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT1', '年初预算', 2, 1, 1, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598800DAFE0530603A8C42DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'NAME', '资金来源', 1, 1, 1, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598820DAFE8530603A8C02DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT2', '年度预算调整', 3, 1, 1, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598850DAFE0530603A8C62DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT3', '调整后的预算', 4, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598860DAFE0530603A8C82DD0', '/pmkpi/perfself/apply/edit/bdgpay', 'AMT4', '全年执行数', 5, 1, 1, 1, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598870DAFE0530603A8C02DD1', '/pmkpi/perfself/apply/edit/bdgpay', 'BGTGET', '预算执行率%', 6, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('SDE4504598800DAFE0530603A8C42DD2', '/pmkpi/perfself/apply/edit/bdgpay', 'SCORE', '自评得分', 7, 1, 0, 1, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);

