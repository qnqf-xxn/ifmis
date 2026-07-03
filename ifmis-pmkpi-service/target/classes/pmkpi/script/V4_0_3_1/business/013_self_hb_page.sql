begin

--湖北-自评分析
delete from bus_t_pagecomponent where id = 'pmkpi_selfanaly';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfanaly', '自评分析', null, '自评分析', '/pmkpi/perfself/selfdesc.js', 'Ext.lt.pmkpi.selfdesc', 'pmkpi', 'pmkpi.perfSelf.tab.SelfDescService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/editdept/selfanaly';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfanaly', 'pmkpi_selfanaly', '{}', 'selfanaly', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfanaly', 'buseditform', '{headsort:false,name:''自评分析信息'',edit:true,title:''自评分析信息'',nextSibling:false,table:"V_PERF_T_SELFPERFDESC"}', 'editform', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/editdept/selfanaly';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/editdept/selfanaly', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'selfdesc', '{main:[editform]}', null, null, 0);


--湖北-绩效指标完成情况
delete from bus_t_pagecomponent where id = 'pmkpi_selfindexdept';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfindexdept', '绩效指标完成情况(湖北)', null, '绩效指标完成情况(湖北)', '/pmkpi/perfself/hbselfindexdept.js', 'Ext.lt.pmkpi.selfindexdept', 'pmkpi', 'pmkpi.perfSelf.tab.HbSelfIndexService');

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/editdept/selfindexhb';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindexhb', 'pmkpi_selfindexdept', '{}', 'selfindexdept', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindexhb', 'busuidatatable', '{key:''/pmkpi/perfself/apply/editdept/hbgoal'',addrow:false,headsort:false,name:''绩效指标完成情况'',edit:false,checkbox:false,radio:true,title:''绩效指标完成情况'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindexhb', 'busuidatatable', '{key:''/pmkpi/perfself/apply/editdept/hbindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:false,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/editdept/selfindexhb';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/editdept/selfindexhb', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'hbindex', '{main:[maintable,datatable]}', null, null, null);
