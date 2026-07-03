begin

delete from p#Busfw_t_Uitabpage where key = '/pmkpi/evaluation/financial/result/edit' and code = 'finword';
insert into p#Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER)
values ('87661BD514DC20D8B6C39A0461794BAA', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评价方案', 'finword', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '评价方案', null, null, '{url:''/pmkpi/evaluation/financial/word.page?type=1'',action:''finword.save''}', null, '0', 'finwordiframe', null, null, null, null, null, '87', '2016', null);
delete from p#Busfw_t_Uitabpage where key = '/pmkpi/evaluation/financial/result/edit' and code = 'finwords';
insert into p#Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER)
values ('87661BD514DC20D8B6C39AA461794BBB', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评价报告', 'finwords', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '评价报告', null, null, '{url:''/pmkpi/evaluation/financial/word.page?type=2'',action:''finword.save''}', null, '0', 'finwordsiframe', null, null, null, null, null, '87', '2016', null);


delete from P#busfw_T_uieditform where key = '/pmkpi/evaluation/financial/word';
insert into P#busfw_T_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('294E7EB9A5B41257AF782CB3E9C7D23D', '/pmkpi/evaluation/financial/word', 'V_PERF_T_FINEVALUATION', 's', '评价方案', 'FINWORK', 0, '', 1, '', 1, null, '', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');
insert into P#busfw_T_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('78DCAD4DAB81C83279340E921F68E9A1', '/pmkpi/evaluation/financial/word', 'V_PERF_T_FINEVALUATION', 's', '主键ID', 'GUID', 0, '', 0, '', 0, null, '', 'pmkpi', 0, null, '{}', null, null, null, '87', '2016');


delete from Bus_t_Pageconsole where url = '/pmkpi/evaluation/financial/word';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/word', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.word.FinWordPage', 'index', '{main:[toolbutton,editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/word';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/word', 'pmkpi_finword', '{}', 'finword', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/word', 'buseditform', '{title:''评价方案''}', 'editform', 'pmkpi', null);


delete from Bus_t_Pagecomponent where id = 'pmkpi_finword';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finword', '评价方案', null, '评价方案', '/pmkpi/evaluation/financial/word/finword.js', 'Ext.lt.pmkpi.finword', 'pmkpi', 'pmkpi.evaluation.financial.word.FinWordService');


delete FROM Bus_t_Diccolumn t where t.tablecode = 'PERF_T_FINEVALUATION' AND DBCOLUMNCODE IN ('FINWORD','FINREPORT');
insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FINWORD', '1', '2016', '87', 'C10314B8F30C402CA37C8AA2245082AB', 'FINWORD', 'PERF_T_FINEVALUATION', '评价方案文本', 'S', '4000', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FINREPORT', '1', '2016', '87', '8691848C424645B6B1A544D18C11F6C0', 'FINREPORT', 'PERF_T_FINEVALUATION', '评价报告文本', 'S', '4000', null, 1, 0, null, sysdate);
