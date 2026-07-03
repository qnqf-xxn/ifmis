begin
  
delete from p#busfw_t_uitable t where key in('/pmkpi/program/sourcefund');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/sourcefund', 'V_PERF_T_PROSOURCEFUND', 100, 0, 0, '', '', 'pmkpi', '{querycols:''pro_code''}', '87', '2016');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/program/sourcefund');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/sourcefund', 'PRO_CODE', '项目编码', 1, 1, 0, 0, '', 0, 1, '', '', '', null, 200, 0, 's', '', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/sourcefund', 'PRO_NAME', '项目名称', 2, 1, 0, 0, '', 0, 1, '', '', '', null, 280, 0, 's', '', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/sourcefund', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '', 0, 1, '', '#code-#name', '', null, 280, 1, 'tree', '', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/sourcefund', 'NAME', '资金来源', 4, 1, 0, 0, '', 0, 1, '', '', '', null, 200, 0, 's', '', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/sourcefund', 'AMT2', '指标金额', 7, 1, 0, 0, '', 0, 1, '', '', '', null, 150, 0, 'amt', '', '', '87', '2016', null, '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/sourcefund', 'AMT3', '支付金额', 8, 1, 0, 0, '', 0, 1, '', '', '', null, 150, 0, 'amt', '', '', '87', '2016', null, '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/program/trace/report','/pmkpi/program/sourcefund','/pmkpi/program/query/list','/pmkpi/yearprogram/query/list','/pmkpi/program/trace/audit','/pmkpi/program/trace/query','/pmkpi/perfself/apply/index','/pmkpi/perfself/audit/index','/pmkpi/perfself/query/index') and t.code in('querySourceFund');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/index', '查看资金来源', 0, 31, 'searchicon', 'perfselfapply.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/audit/index', '查看资金来源', 0, 31, 'searchicon', 'perfselfaudit.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query/index', '查看资金来源', 0, 31, 'searchicon', 'perfselfquery.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/query/list', '查看资金来源', 0, 31, 'searchicon', 'tlprogramquery.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/audit', '查看资金来源', 0, 31, 'searchicon', 'protraceaudit.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', '查看资金来源', 0, 31, 'searchicon', 'protracequery.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', '查看资金来源', 0, 31, 'searchicon', 'protaskreport.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '查看资金来源', 0, 31, 'searchicon', 'yearprogramquery.querySourceFund', null, '查看资金来源', 'pmkpi', 'querySourceFund', '', '', '87', '2016', null, '');


update perf_t_treetab t set t.hidebtns=t.hidebtns||',查看资金来源' where key in('/pmkpi/program/trace/report','/pmkpi/program/trace/audit','/pmkpi/program/trace/query','/pmkpi/perfself/apply','/pmkpi/perfself/audit','/pmkpi/perfself/query') and t.code in('depttrace','dept') and t.hidebtns not like'%,查看资金来源';
