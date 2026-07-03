begin
    
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptZJformance/report/edit';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptZJformance/report/edit';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptZJedit';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'pmkpi_deptZJedit', '{}', 'pmkpideptZJedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptZJformance/report/indexproject'',headsort:false,addrow:false,name:''指标项目对应表'',edit:false,checkbox:false,title:''指标项目对应表'',isuphide:false,nextSibling:false}', 'indexprodatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'buseditform', '{title:''绩效目标概述'',key:''/pmkpi/deptZJformance/report/goaledit'',tablecode:''v_bgt_perf_goal_info''}', 'goaleditform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'bustabpage', '{}', 'edittabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptZJformance/report/editindex'',headsort:false,addrow:true,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'',isuphide:false,nextSibling:false}', 'perfindexdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'buseditform', '{title:''部门基本信息'',tablecode:''v_perf_t_deptperfdeclare'',iswf:''true''}', 'infoeditform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptZJformance/report/editbudget'',headsort:false,addrow:false,name:''预算挂钩机制'',edit:true,checkbox:false,title:''预算挂钩机制'',isuphide:false,nextSibling:false}', 'budgetdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptZJformance/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptZJformance.report.DeptPerfPage', 'editindex', '{main:[edittabpage,infoeditform,perfindexdatatable,budgetdatatable,goaleditform,indexprodatatable],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptZJedit', '浙江部门绩效编辑', null, '浙江部门绩效编辑', '/pmkpi/deptZJformance/report/deptZJperfedit.js', 'Ext.lt.pmkpi.deptZJperfedit', 'pmkpi', 'pmkpi.deptZJformance.DeptPerfEdit');
