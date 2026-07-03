begin

--“≥√Ê≈‰÷√
delete from bus_t_pageconsole where url ='/pmkpi/common/aisupportaudit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/common/aisupportaudit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit.AISupportAuditPage', 'index', '{left:lefttree,main:[queryform,datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/common/aisupportaudit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/common/aisupportaudit', 'pmkpi_aisupportaudit', '{}', 'aisupportaudit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/common/aisupportaudit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/common/aisupportaudit', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/common/aisupportaudit', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/common/aisupportaudit', 'busqueryform', '{name:''≤È—Ø«¯'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''øÏÀŸ≤È—Ø'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/common/aisupportaudit', 'busuidatatable', '{name:''÷«ƒ‹∏®÷˙…Û∫À¡–±Ì'',title:''÷«ƒ‹∏®÷˙…Û∫À'',headsort:false,checkbox:true,edit:false,addrow:false,isuphide:false,nextSibling:false,rowtolist:false,rowresize:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_aisupportaudit';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_aisupportaudit', '÷«ƒ‹∏®÷˙…Û∫À', null, '÷«ƒ‹∏®÷˙…Û∫À', '/pmkpi/perfcommon/aisupportaudit.js', 'Ext.lt.pmkpi.aisupportaudit', 'pmkpi', 'pmkpi.aisupportaudit.AISupportAuditService');

