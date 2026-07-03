begin
delete FROM p#Busfw_t_Uiqueryform t where t.KEY in ('/pmkpi/indexlib/finagive','/pmkpi/indexlib/finagive/edit');
delete FROM p#Busfw_t_Uicolumn t where t.key in ('/pmkpi/indexlib/finagive','/pmkpi/indexlib/finagive/edit');
delete FROM p#Busfw_t_Uitable t where t.key in ('/pmkpi/indexlib/finagive','/pmkpi/indexlib/finagive/edit');
delete FROM p#Busfw_t_Uifunction t where t.key in ('/pmkpi/indexlib/finagive','/pmkpi/indexlib/finagive/edit');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT)
values ('DC61752E496C7964E0535164A8C07A89', '/pmkpi/indexlib/finagive', 'AGENCYCODE', '预算部门', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_INDEXFINAGIVE', null, null, '87', '2016', null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT)
values ('DC62752E496C7964E0535164A8C07A89', '/pmkpi/indexlib/finagive', 'ELTWOGUID', '行业类别', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_INDEXFINAGIVE', null, null, '87', '2016', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC6F752E496E3964E0535164A8C07A89', '/pmkpi/indexlib/finagive', 'ELTWOGUID', '行业类别', 3, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, null, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC6F752E496E2964E0535164A8C07A89', '/pmkpi/indexlib/finagive', 'AGENCYCODE', '预算部门', 2, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, null, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC6F752E496E1964E0535164A8C07A89', '/pmkpi/indexlib/finagive', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('DC728BC9605D3007E0532315A8C0B978', '/pmkpi/indexlib/finagive/edit', 'AGENCYCODE', '预算部门', 3, 1, 0, 0, null, 0, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('DC6F752E496D7964E0535164A8C07A89', '/pmkpi/indexlib/finagive', 'V_PERF_T_INDEXFINAGIVE', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('DC728BC9605D3007E0532315A8C0B977', '/pmkpi/indexlib/finagive/edit', 'V_PERF_T_INDEXFINAGIVE', 0, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('D16F752E496B7964E0535164A8C07A89', '/pmkpi/indexlib/finagive', '授权', 1, 1, 'searchicon', 'indexfinagive.give', null, '授权', 'pmkpi', 'give', null, '{}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('D26F752E496B7964E0535164A8C07A89', '/pmkpi/indexlib/finagive', '导出', 1, 2, 'searchicon', 'indexfinagive.export', null, '导出', 'pmkpi', 'exp', null, '{}', '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('DC728BC9605E3007E0533315A8C0B973', '/pmkpi/indexlib/finagive/edit', '保存', 1, 1, 'Keepicon', 'finagiveedit.save', null, '保存', 'pmkpi', null, null, null, '87', '2016');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('DC728BC9605F3007E0533315A8C0B973', '/pmkpi/indexlib/finagive/edit', '取消', 1, 2, 'Nofinishicon', 'finagiveedit.close', null, '取消', 'pmkpi', null, null, null, '87', '2016');
