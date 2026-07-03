begin

delete from Bus_t_Pageconsole t where t.url like '/pmkpi/program/prjindex/editindex';
delete from Bus_t_Pageconsolecomconfig t where t.url like '/pmkpi/program/prjindex/editindex';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/editindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'editpage', '{main:[indexform],footer:[toolbutton]}', null, null, 0);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/editindex', 'pmkpi_editindex', '{}', 'pmkpieditindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/editindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/editindex', 'buseditform', '{name:''±à¼­Çø'',columnsize:2,amtflag:2}', 'indexform', 'pmkpi', null);
