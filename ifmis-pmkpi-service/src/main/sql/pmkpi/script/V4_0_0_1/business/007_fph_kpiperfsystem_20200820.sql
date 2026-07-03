begin

DELETE FROM Bus_t_Pageconsole t WHERE t.url='/pmkpi/setting/kpisystemset';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/kpisystemset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.kpisystemset.KPISystemSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);


DELETE FROM Bus_t_Pageconsolecomconfig t WHERE t.url='/pmkpi/setting/kpisystemset';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'pmkpi_kpisystemset', '{}', 'kpisystemset', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'busuidatatable', '{name:''绩效系统参数配置'',checkbox:true,title:''绩效系统参数配置'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/kpisystemset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);



DELETE FROM Bus_t_Pagecomponent t WHERE t.id='pmkpi_kpisystemset';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_kpisystemset', '绩效系统参数配置', null, '绩效系统参数配置', '/pmkpi/setting/kpisystemset/kpisystemsetservice.js', 'Ext.lt.pmkpi.kpisystemset', 'pmkpi', 'pmkpi.kpisystemset.KPISystemSetService');
