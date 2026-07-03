begin
--抽评对象标记
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/scope/index' and componentid = 'busqueryform' ;
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--抽评对象确定
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/object/index' and componentid = 'busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--随机抽取管理
delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/randomcomment/random/index' and componentid = 'busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/random/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--抽评委托
delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/randomcomment/entrust/index' and componentid = 'busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--抽评结果上传
delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/randomcomment/result/index' and componentid = 'busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--抽评查询

delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/randomcomment/query/index' and componentid = 'busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--抽评对象确定选择项目
delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/randomcomment/exisProj' and componentid = 'busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/exisProj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--委托第三方
delete from bus_t_pageconsolecomconfig  where url = '/pmkpi/randomcomment/entrusting' and componentid = 'busqueryform';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrusting', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/result/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/result/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'editIndex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/result/edit/randomIndexEdit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/result/edit/randomIndexEdit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'randomIndexEdit', '{main:[toolbutton,datatable]}', null, null, 0);

delete bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/result/edit/randomIndexEdit' and componentid = 'bustoolbutton';
INSERT INTO bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION) VALUES ('/pmkpi/randomcomment/result/edit/randomIndexEdit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', NULL);

