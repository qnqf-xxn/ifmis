begin

--“≥√Ê≈‰÷√
delete from bus_t_pageconsole where url ='/pmkpi/common/aisupportauditdetail';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/common/aisupportauditdetail', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', '/pmkpi/common/css/ai_common.css', null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit.AISupportAuditPage', 'detail', '{main:[datatable],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/common/aisupportauditdetail';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/common/aisupportauditdetail', 'pmkpi_aisupportauditdetail', '{}', 'aisupportauditdetail', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/common/aisupportauditdetail', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/common/aisupportauditdetail', 'busuidatatable', '{name:''÷«ƒ‹∏®÷˙…Û∫À¡–±Ì'',title:''÷«ƒ‹∏®÷˙…Û∫À'',headsort:false,checkbox:false,edit:false,addrow:false,isuphide:false,nextSibling:false,rowtolist:false,rowresize:false}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/common/aisupportauditdetail', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null, null);


delete from bus_t_pagecomponent where id ='pmkpi_aisupportauditdetail';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_aisupportauditdetail', '÷«ƒ‹∏®÷˙…Û∫ÀœÍ«È', null, '÷«ƒ‹∏®÷˙…Û∫ÀœÍ«È', '/pmkpi/perfcommon/aisupportauditdetail.js', 'Ext.lt.pmkpi.aisupportauditdetail', 'pmkpi', 'pmkpi.aisupportaudit.AISupportAuditDetailService');
