begin
  
--政策库
DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/setting/baseinfo/policylib';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/policylib', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'zjindex', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, null);

DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/setting/baseinfo/policylib';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib', 'pmkpi_baseinfo', '{}', 'baseinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/policylib/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);



--政策库编辑
DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/setting/baseinfo/policylib/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/policylib/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[editform],footer:[toolbutton]}', null, null, null);

DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/setting/baseinfo/policylib/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib/edit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib/edit', 'buseditform', '{title:''政策法规编辑'',tablecode:''V_PERF_EXPERTINIFO'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
