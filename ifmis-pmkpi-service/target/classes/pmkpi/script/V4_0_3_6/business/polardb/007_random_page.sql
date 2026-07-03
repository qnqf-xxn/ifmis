begin

--抽评范围标识
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/scope';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'pmkpi_randomcommentscope', '{}', 'randomcommentscope', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'busuidatatable', '{name:''绩效抽评范围'',key:''/pmkpi/randomcomment/scope/index'',checkbox:true,title:''绩效抽评范围'',edit:false,addrow:false,pagetype:''report'',tabcode:''V_PERF_T_RANDOMCOMMENT''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'bustoolbutton', '{key:''/pmkpi/randomcomment/scope/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/scope', 'busqueryform', '{key:''/pmkpi/randomcomment/scope/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/scope';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/scope', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'scopeIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_randomcommentscope');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcommentscope', '抽评范围标识', null, '抽评范围标识', '/pmkpi/randomComment/randomCommentScope.js', 'Ext.lt.pmkpi.randomComment.scopeIndex', 'pmkpi', 'pmkpi.randomcomment.RandomCommentScopeService');


--抽评对象确定
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/object';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'pmkpi_randomcommentobject', '{}', 'randomcommentobject', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'busuidatatable', '{name:''抽评对象确定'',checkbox:true,title:''抽评对象确定'',edit:false,addrow:false,pagetype:''report'',tabcode:''V_PERF_T_RANDOMCOMMENT'',workflow:''BC9E69FB8F45683DADA94276CA20F191'',uikey:''/pmkpi/randomcomment/exisProj'',key:''/pmkpi/randomcomment/object/index''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'bustoolbutton', '{key:''/pmkpi/randomcomment/object/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/object', 'busqueryform', '{key:''/pmkpi/randomcomment/object/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/object';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/object', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'objectIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_randomcommentobject');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcommentobject', '抽评对象确定', null, '抽评对象确定', '/pmkpi/randomComment/randomCommentObject.js', 'Ext.lt.pmkpi.randomComment.objectIndex', 'pmkpi', 'pmkpi.randomcomment.RandomCommentObjectService');

--随机抽取管理
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/randoms';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'pmkpi_randomcommentrandom', '{}', 'randomcommentrandom', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'busuidatatable', '{name:''随机抽评管理'',checkbox:true,title:''随机抽评管理'',edit:false,addrow:false,pagetype:''report'',tabcode:''V_PERF_T_RANDOM'',tabcode1:''V_PERF_T_RANDOMCOMMENT'',uikey:''/pmkpi/randomcomment/randomAdd'',uikey1:''/pmkpi/randomcomment/random'',key:''/pmkpi/randomcomment/random/index''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'bustoolbutton', '{key:''/pmkpi/randomcomment/random/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/randoms', 'busqueryform', '{key:''/pmkpi/randomcomment/random/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/randoms';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/randoms', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'randomIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_randomcommentrandom');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcommentrandom', '随机抽评管理', null, '随机抽评管理', '/pmkpi/randomComment/randomCommentRandom.js,/pmkpi/randomComment/random.js', 'Ext.lt.pmkpi.randomComment.randomIndex', 'pmkpi', 'pmkpi.randomcomment.RandomCommentRandomService');

--绩效抽评委托
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/entrust';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'pmkpi_randomcommententrust', '{}', 'randomcommententrust', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'busuidatatable', '{name:''绩效抽评委托'',checkbox:true,title:''绩效抽评委托'',edit:false,addrow:false,pagetype:''report'',tabcode:''V_PERF_T_RANDOMCOMMENT'',uikey:''/pmkpi/randomcomment/entrusting'',key:''/pmkpi/randomcomment/entrust/index''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'bustoolbutton', '{key:''/pmkpi/randomcomment/entrust/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/entrust', 'busqueryform', '{key:''/pmkpi/randomcomment/entrust/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/entrust';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/entrust', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'entrustIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_randomcommententrust');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcommententrust', '抽评委托', null, '抽评委托', '/pmkpi/randomComment/randomCommentEntrust.js', 'Ext.lt.pmkpi.randomComment.entrustIndex', 'pmkpi', 'pmkpi.randomcomment.RandomCommentEntrustService');

--抽评结果上传
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/result';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'pmkpi_randomcommentresult', '{}', 'randomcommentresult', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'busuidatatable', '{name:''抽评结果上传'',checkbox:true,title:''抽评结果上传'',edit:false,addrow:false,pagetype:''report'',tabcode:''V_PERF_T_RANDOM'',tabcode1:''V_PERF_T_RANDOMCOMMENT'',uikey:''/pmkpi/randomcomment/result/edit'',proTable:''V_PERF_T_RANDOMPROBLEM'',infotablecode:''pmkpi_t_prodetailinfo'',busguid:''108DC779F2B93101E97322F01EC532A7'',key:''/pmkpi/randomcomment/result/index''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'bustoolbutton', '{key:''/pmkpi/randomcomment/result/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/result', 'busqueryform', '{key:''/pmkpi/randomcomment/result/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/result';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/result', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'resultIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_randomcommentresult');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcommentresult', '抽评结果上传', null, '抽评结果上传', '/pmkpi/randomComment/randomCommentResult.js', 'Ext.lt.pmkpi.randomComment.resultIndex', 'pmkpi', 'pmkpi.randomcomment.RandomCommentResultService');

--绩效抽评查询
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/query';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query', 'pmkpi_randomcommentquery', '{}', 'randomcommentquery', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query', 'busuidatatable', '{name:''绩效抽评查询'',checkbox:true,title:''绩效抽评查询'',edit:false,addrow:false,pagetype:''report'',tabcode:''V_PERF_T_RANDOMCOMMENT'',uiquerykey:''/pmkpi/randomcomment/result/edit'',key:''/pmkpi/randomcomment/query/index''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query', 'header', '{}', 'header', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query', 'bustoolbutton', '{key:''/pmkpi/randomcomment/query/index''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/query', 'busqueryform', '{key:''/pmkpi/randomcomment/query/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/query';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/query', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'queryIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_randomcommentquery');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcommentquery', '抽评查询', null, '抽评查询', '/pmkpi/randomComment/randomCommentQuery.js', 'Ext.lt.pmkpi.randomComment.queryIndex', 'pmkpi', 'pmkpi.randomcomment.RandomCommentQueryService');



--抽评对象确定-选择项目
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/randomcomment/exisProj';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/exisProj', 'pmkpi_randomcommentproj', '{}', 'randomcommentproj', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/exisProj', 'busuidatatable', '{name:''选择项目'',checkbox:true,title:''选择项目'',edit:false,addrow:false,pagetype:''report'',tabcode:''V_PERF_T_RANDOMCOMMENT''}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/exisProj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/exisProj', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/randomcomment/exisProj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);


delete from bus_t_pageconsole where url = '/pmkpi/randomcomment/exisProj';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/randomcomment/exisProj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.randomComment.page.RandomCommentPage', 'projIndex', '{left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_randomcommentproj');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_randomcommentproj', '抽评选择项目', null, '抽评选择项目', '/pmkpi/randomComment/randomCommentProj.js', 'Ext.lt.pmkpi.randomComment.projIndex', 'pmkpi', 'pmkpi.randomcomment.RandomCommentProjService');
