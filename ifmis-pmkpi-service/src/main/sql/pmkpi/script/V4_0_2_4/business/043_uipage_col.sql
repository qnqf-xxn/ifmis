begin
--财政评价选择项目  项目支出、部门整体
delete from bus_t_pageconsole where url in('/pmkpi/evaluation/financial/procheck','/pmkpi/evaluation/financial/deptcheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/deptcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/evaluation/financial/procheck','/pmkpi/evaluation/financial/deptcheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'pmkpi_financialprocheck', '{}', 'financialprocheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''项目'',checkbox:true,title:''项目'',edit:false,addrow:false,wheresql:"wfstatus=''011''"}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/financial/check''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'pmkpi_financialprocheck', '{}', 'financialprocheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'busuidatatable', '{name:''部门'',checkbox:true,title:''部门'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/financial/check''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/deptcheck', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--年中追加选择项目
delete from bus_t_pageconsole where url ='/pmkpi/midprogram/report/procheck';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/midprogram/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport.MidProgramPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url='/pmkpi/midprogram/report/procheck';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'pmkpi_midreportcheck', '{}', 'midreportcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标表'',checkbox:true,title:''绩效目标表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/midprogram/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--部门评价选择项目
delete from bus_t_pageconsole where url in('/pmkpi/evaluation/dept/procheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/dept/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.dept.report.DeptReportPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/evaluation/dept/procheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'pmkpi_deptprocheck', '{}', 'deptprocheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''项目'',checkbox:true,title:''项目'',edit:false,addrow:false} ', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'bustoolbutton', '{key:''/pmkpi/evaluation/dept/check''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/dept/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--绩效目标修订选择项目
delete from bus_t_pageconsole where url in('/pmkpi/prorevision/report/procheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/prorevision/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/prorevision/report/procheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'pmkpi_revisionreportcheck', '{}', 'revisionreportcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'bustoolbutton', '{key:''/pmkpi/prorevision/report/check''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标修订表'',checkbox:true,title:''绩效目标修订表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/prorevision/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--目标调整选择项目  项目支出、部门整体
delete from bus_t_pageconsole where url in('/pmkpi/adjust/report/procheck','/pmkpi/adjust/report/deptcheck');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/procheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptcheck', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.report.AdjustReportPage', 'check', '{main:[datatable,queryform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/adjust/report/procheck','/pmkpi/adjust/report/deptcheck');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'pmkpi_adjustreportcheck', '{}', 'adjustreportcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'bustoolbutton', '{key:''/pmkpi/adjust/report/check''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/procheck', 'busqueryform', '{key:''/pmkpi/program/report/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'pmkpi_adjustreportcheck', '{}', 'adjustreportcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'bustoolbutton', '{key:''/pmkpi/adjust/report/check''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'busqueryform', '{key:''/pmkpi/deptperformance/report/index'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptcheck', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/index'',name:''绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false,wheresql:"wfstatus=''011''"}', 'datatable', 'pmkpi', null);

--问题整改新增项目 项目支出、部门整体
delete from bus_t_pageconsole where url in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/add/proj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorj', '{footer:[toolbutton],main:[datatable,queryform]}', null, null, 0);
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/add/deptproj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorj', '{footer:[toolbutton],left:lefttree,main:[datatable,queryform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'pmkpi_rectificationadd', '{}', 'rectificationadd', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'busuidatatable', '{name:''选择项目'',checkbox:false,tiptiptiptiptitle:''选择项目'',edit:false,addrow:false,radio:true,title:''选择项目''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'pmkpi_rectificationadd', '{}', 'rectificationadd', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'busuidatatable', '{name:''部门'',checkbox:false,title:''部门'',edit:false,addrow:false,radio:true}', 'datatable', 'pmkpi', null);


--问题整改选择项目 项目支出、部门整体
delete from bus_t_pageconsole where url in('/pmkpi/rectification/check/proj','/pmkpi/rectification/check/deptproj');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/check/proj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorjLeft', '{footer:[toolbutton],left:lefttree,main:[datatable,queryform]}', null, null, 0);
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/check/deptproj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorjLeft', '{footer:[toolbutton],left:lefttree,main:[datatable,queryform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url in('/pmkpi/rectification/check/proj','/pmkpi/rectification/check/deptproj');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'pmkpi_rectificationcheck', '{}', 'rectificationcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'buslefttree', '{rectifytrace:''D7F6D15AB0E27ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E07ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E47ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E67ECFE0533315A8C04610''}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'busuidatatable', '{name:''选择项目'',checkbox:false,tiptiptiptiptitle:''选择项目'',edit:false,addrow:false,radio:true,title:''选择项目''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'pmkpi_rectificationcheck', '{}', 'rectificationcheck', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'buslefttree', '{rectifytrace:''D7F6D15AB0E37ECFE0533315A8C04610'',rectifyperfself:''D7F6D15AB0E17ECFE0533315A8C04610'',rectifyfinancialeval:''D7F6D15AB0E57ECFE0533315A8C04610'',rectifydepteval:''D7F6D15AB0E77ECFE0533315A8C04610''}', 'lefttree', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'busuidatatable', '{name:''部门'',checkbox:false,title:''部门'',edit:false,addrow:false,radio:true}', 'datatable', 'pmkpi', null);

--绩效监控任务布置范围 项目支出、部门整体
delete from bus_t_pageconsole where url in('/pmkpi/program/trace/manage/prolist','/pmkpi/program/trace/manage/deptlist');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/prolist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{main:[datatable,queryform,tabpage],footer:[toolbutton]}', null, null, 0);
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/deptlist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{main:[datatable,queryform,tabpage],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url in('/pmkpi/program/trace/manage/prolist','/pmkpi/program/trace/manage/deptlist');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'pmkpi_protaskprolist', '{}', 'protaskprolist', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/prolist', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'pmkpi_protaskprolist', '{}', 'protaskprolist', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'bustoolbutton', '{key:''/pmkpi/program/trace/manage/prolist''}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'busuidatatable', '{name:''绩效项目'',checkbox:true,title:''绩效项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/manage/deptlist', 'bustabpage', '{key:''/pmkpi/program/trace/manage/prolist''}', 'tabpage', 'pmkpi', null);

