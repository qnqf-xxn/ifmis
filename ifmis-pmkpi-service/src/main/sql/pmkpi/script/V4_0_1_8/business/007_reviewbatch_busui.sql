begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/review/report/batchadd');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('CB4B5D1811181FC1E0533315A8C008A2', '/pmkpi/review/report/batchadd', 'PERF_V_REVIEWQUERY', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/review/report/batchadd');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CB4B5D18111A1FC1E0533315A8C008A2', '/pmkpi/review/report/batchadd', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 280, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CB4B5D1811191FC1E0533315A8C008A2', '/pmkpi/review/report/batchadd', 'PRO_CODE', '项目名称', 2, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 250, 1, 'tree', '{type:''program,zyzfprogram''}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/review/report/batchadd');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CB4B5D1811231FC1E0533315A8C008A2', '/pmkpi/review/report/batchadd', '确认', 1, 1, 'Keepicon', 'reviewbatchadd.batchadd', null, '确认', 'pmkpi', 'batchadd', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CB4B5D1811221FC1E0533315A8C008A2', '/pmkpi/review/report/batchadd', '关闭', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'colse', null, '{}');
