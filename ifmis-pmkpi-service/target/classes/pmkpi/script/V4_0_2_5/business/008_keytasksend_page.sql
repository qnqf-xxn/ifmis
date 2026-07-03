begin

--page
delete from bus_t_pagecomponent where id  = 'pmkpi_keytasksend';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_keytasksend', '部门重点监控下发', null, '部门重点监控下发', '/pmkpi/perfprotrace/dept/send/deptkeytasksend.js', 'Ext.lt.pmkpi.perfprotrace.keytasksendservice', 'pmkpi', 'pmkpi.perfprotrace.deptsend.DeptKeyTaskSendService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/trace/keytask/send';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/keytask/send', 'pmkpi_keytasksend', '{}', 'keytasksend', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/keytask/send', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/keytask/send', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/keytask/send', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/keytask/send', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/keytask/send', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/keytask/send', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/program/trace/keytask/send';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/keytask/send', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.dept.send.DeptKeyTaskSendPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

