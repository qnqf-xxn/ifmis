begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/assessment/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/assessment/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.assessment.AssessmentSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/assessment/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/assessment/list', 'pmkpi_assessment', '{}', 'assessment', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/assessment/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/assessment/list', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,name:''绩效事前评估模板'',edit:true,checkbox:true,title:''绩效事前评估模板'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/assessment/list', 'header', '{}', 'header', 'pmkpi', null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_assessment');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_assessment', '绩效事前评估模板', null, '绩效事前评估模板', '/pmkpi/setting/assessment/assessment.js', 'Ext.lt.pmkpi.assessmentservice', 'pmkpi', 'pmkpi.setting.assessment.AssessmentSetService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/program/assessment/list');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/assessment/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.assessment.PerfAssessmentPage', 'index', '{main:[datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_perfassessment');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfassessment', '绩效事前评估', null, '绩效事前评估', '/pmkpi/perfprogram/assessment/assessmentservice.js', 'Ext.lt.pmkpi.assessmentservice', 'pmkpi', 'pmkpi.perfprogram.assessment.PerfAssessmentService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/assessment/list');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/assessment/list', 'pmkpi_perfassessment', '{}', 'perfassessment', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/assessment/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/assessment/list', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''绩效事前评估'',edit:true,checkbox:false,title:''绩效事前评估'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

