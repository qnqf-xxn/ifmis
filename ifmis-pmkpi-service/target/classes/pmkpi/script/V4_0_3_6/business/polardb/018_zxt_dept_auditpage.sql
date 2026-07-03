begin
  
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptZJformanceadjust/audit/index';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptZJformanceadjust/audit/index';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptperfauditadjust';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'pmkpi_deptperfauditadjust', '{}', 'pmkpideptperfauditzj', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'busuidatatable', '{name:''部门绩效审核'',checkbox:true,title:''部门绩效审核'',edit:false,addrow:false,pagetype:''audit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);


insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptZJformanceadjust/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptZJformanceadjust.audit.DeptPerfAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptperfauditadjust', '绩效部门审核', null, '绩效部门审核', '/pmkpi/deptZJformanceadjust/audit/deptaudit.js', 'Ext.lt.pmkpi.deptperf.deptauditservice', 'pmkpi', 'pmkpi.deptZJformanceadjust.DeptPerfAuditService');
