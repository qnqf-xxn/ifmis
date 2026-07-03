begin
delete FROM Bus_t_Pageconsole t where t.url in
('/pmkpi/perfselftaskmanage/index','/pmkpi/perfself/apply/index','/pmkpi/perfself/apply/edit',
'/pmkpi/perfself/apply/edit/projinfo','/pmkpi/perfself/apply/edit/bdgpay','/pmkpi/perfself/apply/edit/selfindex',
'/pmkpi/perfself/apply/edit/selfdesc','/pmkpi/perfself/audit/index','/pmkpi/perfself/query/index');

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'editindex', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/bdgpay', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'payindex', '{main:[datatable]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/projinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'projinfo', '{main:[editform,selfeditform]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/selfdesc', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'selfdesc', '{main:[editform]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/selfindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'selfindex', '{main:[datatable]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable,dataexport]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/audit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfApplyPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable,dataexport]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/query/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable,dataexport]}', null, null, 0);

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfselftaskmanage/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSelf.page.PerfSelfTaskManagePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

