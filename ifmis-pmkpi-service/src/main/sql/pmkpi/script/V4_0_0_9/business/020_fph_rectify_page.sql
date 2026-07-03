begin
  
--整改通知首页
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/index';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'index', '{header:[header],main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/index';
insert into Bus_t_Pageconsolecomconfig ( URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ( '/pmkpi/rectification/index', 'pmkpi_rectification', '{}', 'rectification', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig ( URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig ( URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'busuidatatable', '{name:''整改通知下达'',checkbox:true,title:''整改通知下达'',edit:false,addrow:false,uikey:''/pmkpi/rectification/add''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig ( URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig ( URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig ( URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig ( URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_rectification';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectification', '整改通知下达', null, '整改通知下达', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationIndex.js', 'Ext.lt.pmkpi.rectification.index', 'pmkpi', 'pmkpi.rectification.RectificationService');

--选择项目
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/add/proj';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/add/proj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorj', '{header:[toolbutton],main:[queryform,datatable]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/add/proj';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'pmkpi_rectificationadd', '{}', 'rectificationadd', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'busuidatatable', '{name:''选择项目'',checkbox:false,title:''选择项目'',edit:false,addrow:false,radio:true}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_rectificationadd';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationadd', '选择项目', null, '选择项目', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationproj.js', 'Ext.lt.pmkpi.rectification.add.proj', 'pmkpi', 'pmkpi.rectification.RectificationAddProjService');


--选择项目(部门)
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/add/deptproj';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/add/deptproj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorj', '{header:[toolbutton],main:[queryform,datatable]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/add/deptproj';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'pmkpi_rectificationadd', '{}', 'rectificationadd', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'busuidatatable', '{name:''选择项目'',checkbox:false,title:''选择项目'',edit:false,addrow:false,radio:true}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_rectificationadd';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationadd', '选择项目', null, '选择项目', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationproj.js', 'Ext.lt.pmkpi.rectification.add.proj', 'pmkpi', 'pmkpi.rectification.RectificationAddProjService');


--基本信息(项目)
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/program/proinfo';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/program/proinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.info.ProgramInfoPage', 'editindex', '{main:[editform]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/program/proinfo';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/proinfo', 'pmkpi_programinfo', '{}', 'pmkpiprograminfo', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/proinfo', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

--整改通知附件
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/noticeandfile';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/noticeandfile', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.file.NoticeandFilePage', 'index', '{main:[toolbutton,editform,datatable]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/noticeandfile';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/noticeandfile', 'pmkpi_noticeandfile', '{}', 'pmkpinoticeandfile', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/noticeandfile', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/noticeandfile', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/noticeandfile', 'busuidatatable', '{name:''整改文件'',checkbox:false,title:''整改文件'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_noticeandfile';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_noticeandfile', '整改文件上传', null, '整改文件上传', '/pmkpi/rectification/noticeandfile.js', 'Ext.lt.pmkpi.rectification.noticeandfileservice', 'pmkpi', 'pmkpi.rectification.NoticaandFileService');

--整改通知详情
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/add/rectification';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/add/rectification', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'rectification', '{main:[toolbutton,editform]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/add/rectification';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/rectification', 'pmkpi_rectifyinfo', '{}', 'rectifyinfo', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/rectification', 'buseditform', '{title:''整改通知详情''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/rectification', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_rectifyinfo';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectifyinfo', '整改通知详情', null, '整改通知详情', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationinfo.js', 'Ext.lt.pmkpi.rectification.info', 'pmkpi', 'pmkpi.rectification.RectificationAddService');

--整改通知新增(项目)
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/program/add';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/program/add', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'rectifyAdd', '{main:[tabpage]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/program/add';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


--基本信息(部门)
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/program/deptinfo';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/program/deptinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.info.ProgramInfoPage', 'editindex', '{main:[editform]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/program/deptinfo';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/deptinfo', 'pmkpi_programinfo', '{}', 'pmkpiprograminfo', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/deptinfo', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''基础信息'',tablecode:''v_perf_t_deptperfdeclare''}', 'editform', 'pmkpi', null);


--整改通知新增(部门)
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/dept/add';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/dept/add', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'rectifyAdd', '{main:[tabpage]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/dept/add';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


--整改通知审核
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/audit/index';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'auditIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/audit/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'pmkpi_rectificationaudit', '{}', 'rectificationaudit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busuidatatable', '{name:''整改通知审核'',checkbox:true,title:''整改通知审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/rectification/add''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_rectificationaudit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationaudit', '整改通知审核', null, '整改通知审核', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationaudit.js', 'Ext.lt.pmkpi.rectification.audit.index', 'pmkpi', 'pmkpi.rectification.RectificationAuditService');


--整改情况反馈
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/feedback/index';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/feedback/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackIndex', '{header:[header],main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/feedback/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'pmkpi_feedback', '{}', 'feedback', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'busuidatatable', '{name:''整改情况反馈'',checkbox:true,title:''整改情况反馈'',edit:false,addrow:false,pagetype:''audit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_feedback';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedback', '整改情况反馈', null, '整改情况反馈', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/feedbackIndex.js', 'Ext.lt.pmkpi.rectification.feedback.index', 'pmkpi', 'pmkpi.rectification.FeedbackIndexService');


--整改反馈附件
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/feedbackfile';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/feedbackfile', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.file.NoticeandFilePage', 'index', '{main:[toolbutton,editform,datatable]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/feedbackfile';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'pmkpi_noticeandfile', '{}', 'pmkpinoticeandfile', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'busuidatatable', '{name:''整改文件'',checkbox:false,title:''整改文件'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_noticeandfile';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_noticeandfile', '整改文件上传', null, '整改文件上传', '/pmkpi/rectification/noticeandfile.js', 'Ext.lt.pmkpi.rectification.noticeandfileservice', 'pmkpi', 'pmkpi.rectification.NoticaandFileService');


--反馈信息详情
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/feedback/info';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/feedback/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackInfo', '{main:[editform]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/feedback/info';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/info', 'pmkpi_feedbackinfo', '{}', 'feedbackinfo', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/info', 'buseditform', '{title:''反馈信息详情''}', 'editform', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_feedbackinfo';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedbackinfo', '反馈信息详情', null, '反馈信息详情', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/feedbackInfo.js', 'Ext.lt.pmkpi.rectification.feedback.info', 'pmkpi', 'pmkpi.rectification.FeedbackInfoService');


--反馈填报（项目）
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/program/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/program/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackEdit', '{main:[tabpage]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/program/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


--反馈填报（部门）
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/dept/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/dept/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackEdit', '{main:[tabpage]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/dept/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/edit', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''基础信息'',tablecode:''v_perf_t_deptperfdeclare''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


--z整改反馈审核
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/rectification/feedback/audit/index';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/feedback/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackAuditIndex', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/rectification/feedback/audit/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'pmkpi_feedbackAudit', '{}', 'feedbackAudit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'busuidatatable', '{name:''整改情况审核'',checkbox:true,title:''整改情况审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/rectification/feedback/edit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedback/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_feedbackAudit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedbackAudit', '整改情况审核', null, '整改情况审核', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/feedbackauditIndex.js', 'Ext.lt.pmkpi.feedback.audit.index', 'pmkpi', 'pmkpi.rectification.FeedbackAuditIndexService');


DELETE FROM bus_t_pagecomponent t where t.id='pmkpi_programinfo';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_programinfo', '项目基本信息', null, '项目基本信息', '/pmkpi/rectification/programinfo.js', 'Ext.lt.pmkpi.rectification.programinfoservice', 'pmkpi', 'pmkpi.rectification.ProgramInfoService');
