begin

--页面配置 纳入指标填报要素说明
delete from bus_t_pageconsole where url ='/pmkpi/intoindexlib/explan';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/intoindexlib/explan', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.intoindexlib.IntoIndexLibPage', 'explan', '{main:[datatable],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/intoindexlib/explan';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/intoindexlib/explan', 'pmkpi_intoindexlibexplan', '{}', 'intoindexlibexplan', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/intoindexlib/explan', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/intoindexlib/explan', 'busuidatatable', '{name:''填报要素说明'',headsort:false,checkbox:false,edit:false,addrow:false,isuphide:false,nextSibling:false,rowtolist:false,rowresize:false}', 'datatable', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.id in('pmkpi_intoindexlibexplan');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_intoindexlibexplan', '纳入指标填报要素说明', '', '纳入指标填报要素说明', '/pmkpi/perfcommon/intolindexlib/intoindexlibexplan.js', 'Ext.lt.pmkpi.intoindexlibexplan', 'pmkpi', 'pmkpi.intoindexlib.IntoIndexLibService');
