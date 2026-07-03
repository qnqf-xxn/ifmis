begin

--页面组件-重大政策全生命周期绩效管理
delete from bus_t_pageconsole where url ='/pmkpi/majorpolicy/evalindex';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/majorpolicy/evalindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.transpaypro.TranspayProIndexPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/majorpolicy/evalindex';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/evalindex', 'pmkpi_transpayproindex', '{}', 'transpayproindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/evalindex', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/evalindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,edit:true,checkbox:true,title:''重大政策全生命周期绩效管理'',treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,query:''querydata''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/evalindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/evalindex', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/evalindex', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


--选择项目页面配置-表格组件的CONFIG中的cfgquerysql为可配置选择项目过滤条件，默认为在重大政策视图中不存在
delete from bus_t_pageconsole where url ='/pmkpi/majorpolicy/selrpro';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/majorpolicy/selrpro', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.transpaypro.TranspayProIndexPage', 'proindex', '{main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/majorpolicy/selrpro';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/selrpro', 'perf_majorpolicyselpro', '{}', 'majorpolicyselpro', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/selrpro', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/selrpro', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/majorpolicy/selrpro', 'busuidatatable', '{name:''选择项目'',checkbox:true,edit:false,addrow:false,cfgquerysql:''not exists(select 1 from V_PERF_T_MAJORPOLICY a where t.pro_code = a.pro_code)''}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='perf_majorpolicyselpro';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_majorpolicyselpro', '重大政策选择项目', null, '重大政策选择项目', '/pmkpi/transpaypro/majorpolicyselpro.js', 'Ext.lt.pmkpi.majorpolicyselpro', 'pmkpi', 'pmkpi.transpaypro.TranspayProIndexService');