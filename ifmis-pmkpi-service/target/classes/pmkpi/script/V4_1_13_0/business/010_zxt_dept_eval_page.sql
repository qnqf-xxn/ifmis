BEGIN
-- 申报新增 

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/proedit';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/proedit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/proedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/proedit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/proedit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/proedit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);
-- 基本信息
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/infoedit' ;

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/infoedit', 'pmkpi_deptinfoedit', '{}', 'deptedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/infoedit', 'buseditform', '{columnsize:2,iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'editform', 'pmkpi', null, null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/infoedit';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/infoedit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.report.DeptReportAddPage', 'editInfo', '{main:[editform]}', null, null, 0);


delete from bus_t_pagecomponent where id = 'pmkpi_deptinfoedit';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptinfoedit', '部门申报编辑', null, '部门申报编辑', '/pmkpi/evaluation/dept/report/reportadd.js', 'Ext.lt.pmkpi.reportadd', 'pmkpi', 'pmkpi.evaluation.dept.report.DeptReportAddService');

-- 关联项目 
 
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/prorelation';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation', 'pmkpi_deptprorelation', '{}', 'pmkpideptprorelation', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation', 'header', '{}', 'header', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation', 'busuidatatable', '{name:''项目基本信息'',checkbox:true,title:''项目基本信息'',edit:false,addrow:false,pagetype:''report''}', 'datatable', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/prorelation';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/prorelation', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.relation.ProRelationPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);



delete from bus_t_pagecomponent where id = 'pmkpi_deptprorelation';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptprorelation', '部门评价关联项目', null, '部门评价关联项目', '/pmkpi/evaluation/dept/relation/prorelation.js', 'Ext.lt.pmkpi.deptevaluation.prorelation', 'pmkpi', 'pmkpi.dept.relation.ProRelationService');

-- 选择项目
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/prorelation/procheck';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation/procheck', 'pmkpi_deptprorelationcheck', '{}', 'deptprorelationcheck', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation/procheck', 'buslefttree', '{}', 'lefttree', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation/procheck', 'busqueryform', '{key:''/pmkpi/evaluation/dept/prorelation'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/prorelation/procheck', 'busuidatatable', '{name:''项目'',checkbox:true,title:''项目'',edit:false,addrow:false,pagetype:''report''}', 'datatable', 'pmkpi', null, null);


delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/prorelation/procheck';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/prorelation/procheck', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.relation.ProRelationPage', 'check', '{left:lefttree,main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pagecomponent where id = 'pmkpi_deptprorelationcheck'; 

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptprorelationcheck', '部门评价项目关联选择', null, '部门评价项目关联选择', '/pmkpi/evaluation/dept/relation/prorelationcheck.js', 'Ext.lt.pmkpi.deptevaluation.prorelationcheck', 'pmkpi', 'pmkpi.dept.relation.ProRelationCheckService');

-- 宁夏上传评价成果 
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/result/editnx' ;


insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/result/editnx', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/result/editnx', 'bustabpage', '{}', 'tabpage', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/result/editnx', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/result/editnx', 'buseditform', '{key:''/pmkpi/evaluation/dept/result/evaledit'',iswf:''true'',tablecode:''v_perf_t_deptevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/result/editnx', 'buseditform', '{key:''/pmkpi/evaluation/dept/infoedit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'infoeditform', 'pmkpi', null, null);



delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/result/editnx' ;

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/result/editnx', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);


-- 评价成果
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/dept/result/evaledit' ;

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/result/evaledit', 'pmkpi_evalinfoedit', '{}', 'evalinfoedit', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/evaluation/dept/result/evaledit', 'buseditform', '{columnsize:2,iswf:''true'',tablecode:''v_perf_t_deptevaluation''}', 'editform', 'pmkpi', null, null);

delete from bus_t_pageconsole where url = '/pmkpi/evaluation/dept/result/evaledit' ;

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/result/evaledit', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.result.DeptResultPage', 'evaledit', '{main:[editform]}', null, null, 0);

delete from bus_t_pagecomponent where id = 'pmkpi_evalinfoedit';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evalinfoedit', '部门评价成果', null, '部门评价成果', '/pmkpi/evaluation/dept/result/resulteval.js', 'Ext.lt.pmkpi.resulteval', 'pmkpi', 'pmkpi.evaluation.dept.DeptResultEvalService');
