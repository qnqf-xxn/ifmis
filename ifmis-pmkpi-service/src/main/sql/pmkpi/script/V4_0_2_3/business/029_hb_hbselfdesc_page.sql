begin

DELETE FROM Bus_t_Pageconsole t WHERE t.url='/pmkpi/perfself/apply/edit/hbselfdesc';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/hbselfdesc', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'selfdesc', '{main:[editform]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t WHERE t.url='/pmkpi/perfself/apply/edit/hbselfdesc';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/hbselfdesc', 'pmkpi_selfdesc', '{}', 'selfdesc', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/hbselfdesc', 'buseditform', '{headsort:false,name:''自评结论'',edit:true,title:''自评结论'',nextSibling:false,table:"V_PERF_T_SELFPERFDESC"}', 'editform', 'pmkpi', null);

