begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/rectification/feedback/resultopinion';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/resultopinion', 'pmkpi_resultopinion', '{}', 'resultopinion', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/resultopinion', 'buseditform', '{title:''结果应用意见'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/resultopinion', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/rectification/feedback/resultopinion';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION)
values ('/pmkpi/rectification/feedback/resultopinion', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'resultopinionedit', '{main:[toolbutton,editform]}', null, null);


delete from bus_t_pagecomponent where id = 'pmkpi_resultopinion';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_resultopinion', '结果应用意见', null, '结果应用意见', '/pmkpi/rectification/resultopinion.js', 'Ext.lt.pmkpi.rectification.resultopinion', 'pmkpi', 'pmkpi.rectification.FeedbackAuditIndexService');


delete from bus_t_diccolumn where tablecode = 'PERF_T_RECTIFY' and columncode = 'FINADJUSTADVICE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIADJUSTADVICE', null, '1', 'FINADJUSTADVICE', '1', '2023', '87', '08C42947FEDCD5A66AA6B59A6EC72521', 'FINADJUSTADVICE', 'PERF_T_RECTIFY', '业务处室预算调整意见', 'S', '40', null, 1, 1, null, sysdate);
