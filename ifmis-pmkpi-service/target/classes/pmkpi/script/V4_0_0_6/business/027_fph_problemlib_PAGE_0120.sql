begin
  
--问卷库
DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/setting/baseinfo/problemlib';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/problemlib', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'zjindex', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, null);

DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/setting/baseinfo/problemlib';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib', 'pmkpi_baseinfo', '{}', 'baseinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/problemlib/edit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);


--问卷库编辑
DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/setting/baseinfo/problemlib/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/problemlib/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[editform],footer:[toolbutton]}', null, null, null);

DELETE FROM bus_t_pageconsolecomconfig t where t.url='/pmkpi/setting/baseinfo/problemlib/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib/edit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib/edit', 'buseditform', '{title:''问卷编辑'',tablecode:''V_PERF_EXPERTINIFO'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/problemlib/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
