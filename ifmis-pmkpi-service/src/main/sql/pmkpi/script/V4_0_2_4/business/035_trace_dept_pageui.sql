begin
--pageconsole
delete from bus_t_pageconsole where URL = '/pmkpi/dept/trace/report/edit/fund';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/dept/trace/report/edit/fund', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.fund.ProFundPage', 'list', '{main:[datatable]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where URL = '/pmkpi/dept/trace/report/edit/fund';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/dept/trace/report/edit/fund', 'pmkpi_protracefund', '{}', 'tracefund', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/dept/trace/report/edit/fund', 'busuidatatable', '{addrow:false,name:''预算执行情况'',edit:true,checkbox:true,title:''预算执行情况'',isnegative:reue}', 'datatable', 'pmkpi', null);




--uibus

delete from p#busfw_t_uitable where key = '/pmkpi/dept/trace/report/edit/fund';
insert into p#busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'V_PERF_T_PROBGTFUND', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');


delete from p#busfw_t_uicolumn where key = '/pmkpi/dept/trace/report/edit/fund';
insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT1', '年初预算', 5, 1, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT2', '调整预算数', 6, 1, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT3', '调整后预算数', 7, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT4', '预算执行数', 8, 1, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'BGTGET', '预算执行率(%)', 9, 1, 0, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'f', null, null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'ISEDIT', '是否编辑', 20, 0, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT6', '全年执行数', 21, 1, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into p#busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'NAME', '资金来源', 1, 1, 1, 1, null, 0, 6, null, null, null, null, 150, 0, 's', null, null, '87', '2016');



--uitabpage

delete from p#busfw_t_uitabpage where key = '/pmkpi/trace/report/deptedit' and code = 'tracefund';
insert into p#busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values (sys_guid(), 'pmkpi', '/pmkpi/trace/report/deptedit', '预算执行情况', 'tracefund', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '预算执行情况', null, null, '{url:''/pmkpi/dept/trace/report/edit/fund.page'',busguid:''B74D29A870344446E0530100007F1A5A'',action:''tracefund.save''}', null, '0', 'taskfundsiframe', null, null, null, null, null, null, '87', '2016');