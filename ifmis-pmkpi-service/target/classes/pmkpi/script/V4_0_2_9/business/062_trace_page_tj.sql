begin
  --监控填报 预算执行情况页面  （天津）  重点监控
delete from p#busfw_t_uitabpage where key ='/pmkpi/program/trace/report/edit' and code ='tjprotracefund';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/trace/report/edit', '预算执行情况(天津)', 'tjprotracefund', 0, 12, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况(天津)', null, null, '{url:''/pmkpi/program/trace/report/edit/tjfund.page'',busguid:''B74D29A870344446E0530100007F1A5A'',action:''tjtracefund.save''}', null, '0', 'tjprotracefundiframe', null, null, null, null, null, '87', '2016', null);

--一般监控
delete from p#busfw_t_uitabpage where key ='/pmkpi/program/trace/report/ordinaryedit' and code ='tjprotracefund';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/trace/report/ordinaryedit', '预算执行情况(天津)', 'tjprotracefund', 0, 9, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况(天津)', null, null, '{url:''/pmkpi/program/trace/report/edit/tjfund.page'',busguid:''B74D29A870344446E0530100007F1A5A'',action:''tjtracefund.save''}', null, '0', 'tjprotracefundiframe', null, null, null, null, null, '87', '2016', null);


  

--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/program/trace/report/edit/tjfund';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/tjfund', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.fund.TjProFundPage', 'list', '{main:[datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/trace/report/edit/tjfund';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/tjfund', 'pmkpi_protracetjfund', '{}', 'tjtracefund', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/tjfund', 'busuidatatable', '{addrow:false,amtflag:2,name:''预算执行情况'',edit:true,checkbox:true,tiptiptiptitle:''预算执行情况'',isnegative:reue}', 'datatable', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_protracetjfund';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_protracetjfund', '天津项目绩效监控预算执行情况', null, '天津项目绩效监控预算执行情况', '/pmkpi/perfprotrace/fund/tjfundservice.js', 'Ext.lt.pmkpi.protrace.tjfundservice', 'pmkpi', 'pmkpi.perfprotrace.fund.TjProFundService');



delete from bus_t_diccolumn where tablecode ='PERF_T_PROBGTFUND' and columncode in('CODE','LEVELNO','SUPERGUID');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CODE', '1', '2020', '87', 'E578FF3AF2946B13E0533315A8C07E0C', 'CODE', 'PERF_T_PROBGTFUND', '编码', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LEVELNO', '1', '2020', '87', 'E578FF3AF2936B13E0533315A8C07E0C', 'LEVELNO', 'PERF_T_PROBGTFUND', '层级', 'S', '40', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'SUPERGUID', '1', '2020', '87', 'E578FF3AF2926B13E0533315A8C07E0C', 'SUPERGUID', 'PERF_T_PROBGTFUND', '父级id', 'S', '40', null, 1, 1, null, sysdate);


--UI配置
delete from p#busfw_t_uicolumn where key ='/pmkpi/program/trace/report/edit/tjfund';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'AMT1', '年初预算数', 2, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'AMT2', '年度预算调整', 3, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'AMT3', '调整后预算数', 4, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'AMT4', '1-X月执行数', 5, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'BGTGET', '1-X月执行率%', 6, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 'f', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'AMT5', '全年预计执行数', 7, 1, 1, 0, null, 0, null, null, null, null, null, null, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'NAME', ' ', 1, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);


delete from p#busfw_t_uitable where key ='/pmkpi/program/trace/report/edit/tjfund';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/report/edit/tjfund', 'V_PERF_T_PROBGTFUND', 0, 1, 0, null, null, 'pmkpi', null);

delete FROM BUS_t_Diccolumn t where t.TABLECODE = 'PERF_V_PROMONITOR' and t.COLUMNCODE = 'COMPWARN';
delete FROM BUS_t_Diccolumn t where t.TABLECODE = 'PERF_V_PROMONITOR_HB' and t.COLUMNCODE = 'COMPWARN';
insert into BUS_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPWARN', '1', '2016', '87', 'E6E5A6FA25C8B704E0530100007FEE44', 'COMPWARN', 'PERF_V_PROMONITOR_HB', '全年预计完成情况偏离度预警', 'S', '40', null, 1, 0, null, sysdate);
insert into BUS_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'COMPWARN', '1', '2016', '87', 'E6E5A6FA25C7B704E0530100007FEE44', 'COMPWARN', 'PERF_V_PROMONITOR', '全年预计完成情况偏离度预警', 'S', '40', null, 1, 0, null, sysdate);
