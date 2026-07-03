
begin

--页面组件
delete from bus_t_pageconsole where URL = '/pmkpi/setting/indexauth';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/indexauth', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.indexauth.IndexAuthPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, null);

delete from bus_t_pageconsolecomconfig where URL = '/pmkpi/setting/indexauth';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/indexauth', 'pmkpi_indexauth', '{}', 'indexauth', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/indexauth', 'busuidatatable', '{addrow:false,edit:true,checkbox:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/indexauth', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/indexauth', 'header', '{}', 'header', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_indexauth';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_indexauth', '绩效指标库共享授权', null, '绩效指标库共享授权', '/pmkpi/setting/indexauth/indexauthservice.js', 'Ext.lt.pmkpi.indexauthservice', 'pmkpi', 'pmkpi.setting.IndexAuthService');
