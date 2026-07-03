begin

delete from  bus_t_pageconsolecomconfig where url in ('/pmkpi/perfself/apply/editdept/selfindexhb','/pmkpi/perfself/apply/edit/goalandindex','/pmkpi/program/trace/report/edit/goalandindex') and id = 'toolbutton';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindexhb', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);



insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/goalandindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);





delete from bus_t_pageconsole where url in ('/pmkpi/perfself/apply/editdept/selfindexhb','/pmkpi/perfself/apply/edit/goalandindex','/pmkpi/program/trace/report/edit/goalandindex');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/editdept/selfindexhb', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'hbindex', '{main:[toolbutton,maintable,datatable]}', null, null, null);


insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'hbgoalindex', '{main:[maintable,toolbutton,datatable]}', null, null, null);


insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/report/edit/goalandindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.indextarget.ProIndexTargetPage', 'hbindex', '{main:[toolbutton,maintable,datatable]}', null, null, null);





