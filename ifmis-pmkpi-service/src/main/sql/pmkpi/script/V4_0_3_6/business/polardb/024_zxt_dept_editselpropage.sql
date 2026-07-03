begin
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptZJformance/report/edit/selpros';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptZJformance/report/edit/selpros';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptselpros';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit/selpros', 'pmkpi_deptselpros', '{}', 'pmkpideptselpros', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit/selpros', 'busuidatatable', '{key:''/pmkpi/deptZJformance/report/edit/selpros1'',headsort:false,edit:false,checkbox:true,isuphide:false,nextSibling:false}', 'noseltable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit/selpros', 'busuidatatable', '{key:''/pmkpi/deptZJformance/report/edit/selpros2'',headsort:false,edit:false,checkbox:true,isuphide:false,nextSibling:false}', 'yeseltable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit/selpros', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/deptZJformance/report/edit/selpros', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptZJformance.report.DeptPerfPage', 'indexpros', '{main:[],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_deptselpros', '部门指标选择项目', null, '部门指标选择项目', '/pmkpi/deptZJformance/report/deptindexpros.js', 'Ext.lt.pmkpi.deptselpros', 'pmkpi', 'pmkpi.deptZJformance.DeptPerfIndexPros');
