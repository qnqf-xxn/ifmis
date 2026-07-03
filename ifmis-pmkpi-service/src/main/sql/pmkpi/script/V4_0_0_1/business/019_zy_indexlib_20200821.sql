begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/index/list');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/index/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.index.IndexPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/index/list');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/list', 'pmkpi_indexlib', '{}', 'indexlib', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/list', 'busuidatatable', '{name:''指标表'',checkbox:true,title:''指标表'',edit:false,addrow:false}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/list', 'header', '{}', 'header', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_indexlib');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_indexlib', '指标库', '', '指标库', '/pmkpi/setting/index/indexservice.js', 'Ext.lt.pmkpi.indexservice', 'pmkpi', 'pmkpi.setting.index.IndexService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/model/list');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/model/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.modelcase.ModelCasePage', 'list', '{header:[header],main:[toolbutton,queryform,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/model/list');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/list', 'pmkpi_model', '{}', 'model', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/list', 'busuidatatable', '{name:''模板库'',checkbox:true,title:''模板库'',edit:true,addrow:true,uikey:''/pmkpi/setting/model/indexlist''}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/list', 'header', '{}', 'header', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_model');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_model', '指标模板', '', '指标模板', '/pmkpi/setting/modelcase/modelcaseservice.js', 'Ext.lt.pmkpi.modelcase', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/case/list');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/case/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.modelcase.ModelCasePage', 'list', '{header:[header],main:[toolbutton,queryform,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/case/list');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'pmkpi_model', '{}', 'model', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busuidatatable', '{name:''案例库'',checkbox:true,title:''案例库'',edit:true,addrow:true,uikey:''/pmkpi/setting/case/indexlist''}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'header', '{}', 'header', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_model');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_model', '指标模板', '', '指标模板', '/pmkpi/setting/modelcase/modelcaseservice.js', 'Ext.lt.pmkpi.modelcase', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/index/edit');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/index/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.index.IndexPage', 'edit', '{main:[toolbutton,editform]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/index/edit');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/edit', 'pmkpi_indexlibedit', '{}', 'indexlibedit', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/index/edit', 'buseditform', '{title:''指标信息''}', 'editform', 'pmkpi', '');



delete from bus_t_pagecomponent t where t.id in('pmkpi_indexlibedit');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_indexlibedit', '指标库', '', '指标库', '/pmkpi/setting/index/indexeditservice.js', 'Ext.lt.pmkpi.indexservice', 'pmkpi', 'pmkpi.setting.index.IndexEditService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/model/indexlist');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/model/indexlist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.modelcase.ModelCasePage', 'indexlist', '{main:[toolbutton,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/model/indexlist');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/indexlist', 'pmkpi_modelindex', '{}', 'modelindex', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/indexlist', 'busuidatatable', '{name:''模板指标'',checkbox:true,title:''模板指标'',edit:false,addrow:false,uikey:''/pmkpi/setting/model/edit''}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/indexlist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_modelindex');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_modelindex', '案例/模板指标明细', '', '案例/模板指标明细', '/pmkpi/setting/modelcase/modelcaseindex.js', 'Ext.lt.pmkpi.modelcaseindex', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseIndexService');


delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/model/edit');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/model/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.modelcase.ModelCasePage', 'indexedit', '{main:[toolbutton,editform]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/model/edit');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/edit', 'pmkpi_modelindexedit', '{}', 'modelindexedit', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/model/edit', 'buseditform', '{title:''指标信息''}', 'editform', 'pmkpi', '');



delete from bus_t_pagecomponent t where t.id in('pmkpi_modelindexedit');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_modelindexedit', '模板指标编辑', '', '模板指标编辑', '/pmkpi/setting/modelcase/modelcaseindexedit.js', 'Ext.lt.pmkpi.modelcaseindexedit', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseIndexEditService');


delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/case/indexlist');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/case/indexlist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.modelcase.ModelCasePage', 'indexlist', '{main:[toolbutton,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/case/indexlist');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/indexlist', 'pmkpi_modelindex', '{}', 'modelindex', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/indexlist', 'busuidatatable', '{name:''案例指标'',checkbox:true,title:''案例指标'',edit:false,addrow:false,uikey:''/pmkpi/setting/case/edit''}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/indexlist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

delete from bus_t_pagecomponent t where t.id in('pmkpi_modelindex');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_modelindex', '案例/模板指标明细', '', '案例/模板指标明细', '/pmkpi/setting/modelcase/modelcaseindex.js', 'Ext.lt.pmkpi.modelcaseindex', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseIndexService');

delete from bus_t_pageconsole t where t.url in('/pmkpi/setting/case/edit');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/case/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.modelcase.ModelCasePage', 'indexedit', '{main:[toolbutton,editform]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/setting/case/edit');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/edit', 'pmkpi_modelindexedit', '{}', 'modelindexedit', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/case/edit', 'buseditform', '{title:''指标信息''}', 'editform', 'pmkpi', '');



delete from bus_t_pagecomponent t where t.id in('pmkpi_modelindexedit');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_modelindexedit', '模板指标编辑', '', '模板指标编辑', '/pmkpi/setting/modelcase/modelcaseindexedit.js', 'Ext.lt.pmkpi.modelcaseindexedit', 'pmkpi', 'pmkpi.setting.modelcase.ModelCaseIndexEditService');
