begin
  
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptZJformanceadjust/report/index';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptZJformanceadjust/report/index';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptZJlistadjust';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'busuidatatable', '{name:''部门绩效申报'',checkbox:true,title:''部门绩效申报'',edit:false,addrow:false,pagetype:''report'',repeatflag:''false''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'pmkpi_deptZJlistadjust', '{}', 'deptZJlist', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformanceadjust/report/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptZJformanceadjust/report/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptZJformanceadjust.report.DeptPerfPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptZJlistadjust', '部门绩效申报列表', null, '部门绩效申报列表', '/pmkpi/deptZJformanceadjust/report/deptZJreport.js', 'Ext.lt.pmkpi.deptZJlist', 'pmkpi', 'pmkpi.deptZJformanceadjust.DeptPerfService');

