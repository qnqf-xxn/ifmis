begin

--指派中介-page
delete from bus_t_pagecomponent where id = 'evaluateentrustservice';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('evaluateentrustservice', '指派中介', null, '指派中介', '/busfw/ltext/swfupload/jslib/fupload.js,/busfw/ltext/componentview/ltext_fileupload.js,/busfw/common/ui/ui_uploadfiles.js,/busfw/ltext/fuds-download.js,/busfw/ltext/fuds-upload.js,/pmkpi/common/fileupload.js,/pmkpi/evaluate/evaluateentrust.js', 'Ext.lt.pmkpi.evaluate.evaluateentrustservice', 'pmkpi', 'pmkpi.evaluate.EvaluateEntrustService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluate/thirdevaluate/entrust'; 
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/entrust', 'evaluateentrustservice', '{}', 'evaluateentrustservice', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/entrust', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/entrust', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/entrust', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/entrust', 'busuidatatable', '{key:''/pmkpi/evaluate/thirdevaluate/entrust'',name:''中介库'',checkbox:true,title:''中介库'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluate/thirdevaluate/entrust', 'busuidatatable', '{key:''/pmkpi/evaluate/thirdevaluate/selentrust'',name:''已选中介'',checkbox:true,title:''已选中介'',edit:false,addrow:false}', 'seldatatable', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluate/thirdevaluate/entrust'; 
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluate/thirdevaluate/entrust', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluate.page.EvaluatePage', 'toEvaluateEntrust', '{main:[toolbutton,queryform,datatable,seldatatable]}', null, null, 0);

