begin

DELETE FROM Bus_t_Pageconsole t WHERE t.url='/pmkpi/yearprogram/query/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/yearprogram/query/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);



DELETE FROM Bus_t_Pageconsolecomconfig t WHERE t.url='/pmkpi/yearprogram/query/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yearprogram/query/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yearprogram/query/edit', 'buseditform', '{title:''»ù´¡ÐÅÏ¢'',tablecode:''v_perf_project_info'',pagetype:''manceinfo'',iswf:''true'',wheresql:'' 1=1 ''}', 'editform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yearprogram/query/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/yearprogram/query/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

