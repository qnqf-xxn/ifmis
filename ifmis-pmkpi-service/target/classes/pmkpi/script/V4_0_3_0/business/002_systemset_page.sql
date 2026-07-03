begin

delete from bus_t_pageconsole t where t.url  in('/pmkpi/setting/kpisystemset');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/kpisystemset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.kpisystemset.KPISystemSetPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/kpisystemset');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'pmkpi_kpisystemset', '{}', 'kpisystemset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'busuidatatable', '{name:''绩效系统参数配置'',radio:true,title:''绩效系统参数配置'',edit:true,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pageconsole t where t.url  in('/pmkpi/kpisystemset/infoedit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/kpisystemset/infoedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.kpisystemset.KPISystemSetPage', 'edit', '{main:[editform],footer:[toolbutton]}', null, null, null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_kpisystemsetedit');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_kpisystemsetedit', '绩效系统参数配置编辑', null, '绩效系统参数配置编辑', '/pmkpi/setting/kpisystemset/kpisystemsetedit.js', 'Ext.lt.pmkpi.kpisystemset.infoedit', 'pmkpi', 'pmkpi.kpisystemset.KPISystemSetService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/kpisystemset/infoedit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/kpisystemset/infoedit', 'pmkpi_kpisystemsetedit', '{}', 'kpisystemsetedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/kpisystemset/infoedit', 'buseditform', '{columnsize:2}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/kpisystemset/infoedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

