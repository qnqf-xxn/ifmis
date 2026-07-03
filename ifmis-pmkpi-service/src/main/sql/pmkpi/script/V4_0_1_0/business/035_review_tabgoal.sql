begin
  
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/report/proedit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/proedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform]}', null, null, 0);

DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/review/report/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/review/report/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfreview.report.PerfReviewPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);


UPDATE p#Busfw_t_Uitabpage t set t.config='{url:''/pmkpi/program/report/protabgoal.page?showtab=1'||chr(38)||'isedittotal=1'',viewtype:''query''}',t.componentid='iframegoal' where t.key='/pmkpi/review/report/proedit' and t.code='progoal';


update p#Busfw_t_Uitabpage t set t.filter=' t.type=''goal''' where t.key='/pmkpi/review/report/list';