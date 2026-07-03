begin

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/perfself/apply/edit/goalandindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'pmkpi_selfgoalindex', '{}', 'selfgoalindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'busuidatatable', '{key:''/pmkpi/perfself/apply/edit/hbprogoal'',addrow:false,headsort:false,name:''年度绩效目标'',edit:true,checkbox:false,radio:true,title:''年度绩效目标'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/perfself/apply/edit/hbtreeindex'',nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/perfself/apply/edit/goalandindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/edit/goalandindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.page.PerfSelfApplyPage', 'hbgoalindex', '{main:[maintable,datatable]}', null, null, null);



delete from bus_t_pagecomponent where id = 'pmkpi_selfgoalindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfgoalindex', '绩效完成情况', null, '绩效完成情况', '/pmkpi/perfself/selfgoalandindex.js', 'Ext.lt.pmkpi.self.goalandindex', 'pmkpi', 'pmkpi.perfSelf.tab.SelfGoalIndexService');




