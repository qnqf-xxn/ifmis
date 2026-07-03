
begin
delete from p#busfw_t_uitabpage where key = '/pmkpi/evaluation/financial/result/edit' and code = 'randomIndex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER)
values ('075468E4F811BPPD6C4C8F9CD6360191', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '绩效指标', 'randomIndex', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效指标', null, null, '{url:''/pmkpi/evation/result/edit/randomIndexEdit.page'',action:''evaprjindex.save''}', null, '0', 'randomIndexiframe', null, null, null, null, null, '87', '2016', null);

delete from p#busfw_t_uitable where key = '/pmkpi/evation/result/edit/randomIndexEdit';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('B84E9D56D6117E4AEPP30100007F3871', '/pmkpi/evation/result/edit/randomIndexEdit', 'V_PERF_T_EVAINDICATOR', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

delete from p#busfw_t_uicolumn where key = '/pmkpi/evation/result/edit/randomIndexEdit';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('D16BE33B81DF486PPB1609F69ACA6408', '/pmkpi/evation/result/edit/randomIndexEdit', 'SUPERID', 'SUPERID', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('B84E9D56D6137E4PPP530100007F3871', '/pmkpi/evation/result/edit/randomIndexEdit', 'CODE', '编码', 4, 0, 1, 0, null, 1, null, null, null, null, null, 120, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('FC62689EB8174PP98F1EDCC26D24DE47', '/pmkpi/evation/result/edit/randomIndexEdit', 'WEIGHT', '权重', 7, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('29284FC3B1C5PP4CBB147C9BD779A00B', '/pmkpi/evation/result/edit/randomIndexEdit', 'NAME', '指标名称', 5, 1, 1, 0, null, 1, null, null, null, null, null, 280, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('39C1152FC12PP80C82D4B8614A942882', '/pmkpi/evation/result/edit/randomIndexEdit', 'GUID', 'GUID', 3, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('889F9D855PPP43CE885DC6855D469814', '/pmkpi/evation/result/edit/randomIndexEdit', 'OBLIGATE', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('B84E9PPPD6127E4AE0530100007F3871', '/pmkpi/evation/result/edit/randomIndexEdit', 'REMARK', '备注', 23, 0, 1, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('S4F657602AF00D51E05PP10A10AC7BAF', '/pmkpi/evation/result/edit/randomIndexEdit', 'COMPUTESIGN', '计算符号', 5, 1, 1, 0, '0', 0, null, null, '#name', null, 0, 50, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('SAAEADD6DB982963E053PP03A8C08AD1', '/pmkpi/evation/result/edit/randomIndexEdit', 'METERUNIT', '指标度量单位', 10, 1, 1, 0, '0', 0, null, null, null, null, 0, 20, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('SF60D3C211A3BA69E05PP100A8C02F03', '/pmkpi/evation/result/edit/randomIndexEdit', 'INDEXVAL', '指标值', 6, 1, 1, 0, '0', 0, null, null, null, null, 0, 100, 0, 's', '{}', null, '87', '2016');
