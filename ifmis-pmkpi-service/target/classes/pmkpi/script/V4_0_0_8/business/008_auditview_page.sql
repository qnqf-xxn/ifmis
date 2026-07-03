begin
  
DELETE FROM Bus_t_Pageconsole t where t.url='/pmkpi/audit/view';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/audit/view', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.audit.PmkpiPerfAuditPage', 'index', '{main:[],footer:[toolbutton]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/audit/index/opinion';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/opinion', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/opinion', 'buseditform', '{title:''…Û∫À''}', 'editform', 'pmkpi', null);
