begin
delete from Bus_t_Pageconsole t where t.url = '/pmkpi/program/report/progoal';
delete from Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/program/report/progoal';

insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/progoal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexPage', 'listpage', '{main:[editform]}', null, null, 0);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'pmkpi_tlprogoal', '{}', 'pmkpitlproindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/progoal', 'buseditform', '{key:''/pmkpi/program/report/proindex''}', 'editform', 'pmkpi', null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/program/report/proindex') and t.guid in('B412538AB4D962E3E0535164A8C0C98B');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B412538AB4D962E3E0535164A8C0C98B', '/pmkpi/program/report/proindex', 'V_PM_PERF_GOAL_INFO', 'textarea', '中期绩效目标', 'ZQGOAL', 1, null, 0, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);
