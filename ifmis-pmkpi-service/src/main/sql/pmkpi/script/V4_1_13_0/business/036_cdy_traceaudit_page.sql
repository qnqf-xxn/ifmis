begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/audit/index/perfconreview','/pmkpi/audit/index/traceopinion');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/perfconreview', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[editform]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/traceopinion', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/index/perfconreview','/pmkpi/audit/index/traceopinion');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/audit/index/perfconreview', 'buseditform', '{title:''审核意见'',amtswitch:false}', 'editform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/audit/index/perfconreview', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/audit/index/traceopinion', 'buseditform', '{title:''审核意见'',amtswitch:false}', 'editform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/audit/index/traceopinion', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', null, null);


delete from perf_t_datasource t where t.elementcode='traceaudittype' and t.guid='3';

delete bus_t_pageconsole t where t.url in('/pmkpi/audit/index/evaluation');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/index/evaluation', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/audit/index/evaluation');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/audit/index/evaluation', 'buseditform', '{title:''审核意见'',amtswitch:false}', 'editform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/audit/index/evaluation', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', null, null);
