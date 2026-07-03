begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/instructor';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor', 'pmkpi_baseinfo', '{}', 'baseinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/instructor/edit'',sxuikey:''/pmkpi/setting/baseinfo/instructor/sxedit''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/instructor';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/instructor', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'zjindex', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, null);




delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/instructor/sxedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor/sxedit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor/sxedit', 'buseditform', '{key:''/pmkpi/setting/baseinfo/instructor/edit'',title:''监督指导库编辑'',tablecode:''V_PERF_INSTRUCTOR'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor/sxedit', 'bustoolbutton', '{key:''/pmkpi/setting/baseinfo/instructor/edit''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/instructor/sxedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/instructor/sxedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/instructor/sxedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/intermediaryinfo' and id = 'datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/intermediaryinfo/edit'',sxuikey:''/pmkpi/setting/baseinfo/intermediaryinfo/sxedit''}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[tabpage,editform,legalpersoneditform],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/intermediaryinfo/sxedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', 'bustoolbutton', '{key:''/pmkpi/setting/baseinfo/intermediaryinfo/edit''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', 'buseditform', '{key:''/pmkpi/setting/baseinfo/intermediaryinfo/edit'',title:''中介编辑'',tablecode:''V_PERF_INTERMEDIARYINFO'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryinfo/sxedit', 'buseditform', '{key:''/pmkpi/setting/baseinfo/legalperson'',tablecode:''V_PERF_LEGALPERSON'',iswf:''false''}', 'legalpersoneditform', 'pmkpi', null);


delete from bus_t_pagecomponent where id = 'pmkpi_baseinfoedit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_baseinfoedit', '基础资料编辑', null, '基础资料编辑', '/pmkpi/setting/baseinfo/baseinfoedit.js', 'Ext.lt.pmkpi.baseinfoedit', 'pmkpi', 'pmkpi.baseinfo.BaseinfoEditService');



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/legalperson';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/legalperson', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[editform]}', null, null, null);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/legalperson';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/legalperson', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/legalperson', 'buseditform', '{title:''法定代表人编辑'',tablecode:''V_PERF_LEGALPERSON'',iswf:''true''}', 'editform', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/intermediaryfunds';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/intermediaryfunds', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'pjindex', '{main:[datatable]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/intermediaryfunds';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryfunds', 'pmkpi_reviewer', '{}', 'reviewer', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/intermediaryfunds', 'busuidatatable', '{headsort:false,addrow:true,name:''过去三年主要业绩'',edit:true,checkbox:true,title:''过去三年主要业绩'',initlevel:6,isuphide:false,nextSibling:false}', 'datatable', 'pmkpi', null);



delete from bus_t_pagecomponent where id = 'pmkpi_reviewer';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_reviewer', '评价人信息', null, '评价人信息', '/pmkpi/setting/baseinfo/reviewerinfo.js', 'Ext.lt.pmkpi.reviewerinfo', 'pmkpi', 'pmkpi.baseinfo.BasereviewerService');



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/mainreviewer';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/mainreviewer', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'pjindex', '{main:[datatable]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/mainreviewer';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/mainreviewer', 'pmkpi_reviewer', '{}', 'reviewer', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/mainreviewer', 'busuidatatable', '{headsort:false,addrow:true,name:''主评人信息'',edit:true,checkbox:true,title:''主评人信息'',initlevel:6,isuphide:false,nextSibling:false}', 'datatable', 'pmkpi', null);




delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/branch';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/branch', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'pjindex', '{main:[datatable]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/branch';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/branch', 'pmkpi_reviewer', '{}', 'reviewer', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/branch', 'busuidatatable', '{headsort:false,addrow:true,name:''分支机构信息'',edit:true,checkbox:true,title:''分支机构信息'',initlevel:6,isuphide:false,nextSibling:false}', 'datatable', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/expert';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/expert', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'pjindex', '{main:[datatable]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/expert';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/expert', 'pmkpi_reviewer', '{}', 'reviewer', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/expert', 'busuidatatable', '{headsort:false,addrow:true,name:''合作专家信息'',edit:true,checkbox:true,title:''合作专家信息'',initlevel:6,isuphide:false,nextSibling:false}', 'datatable', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/otheremploy';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/otheremploy', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'pjindex', '{main:[datatable]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/otheremploy';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/otheremploy', 'pmkpi_reviewer', '{}', 'reviewer', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/otheremploy', 'busuidatatable', '{headsort:false,addrow:true,name:''其他绩效评价从业人员信息'',edit:true,checkbox:true,title:''其他绩效评价从业人员信息'',initlevel:6,isuphide:false,nextSibling:false}', 'datatable', 'pmkpi', null);
