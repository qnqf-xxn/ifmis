begin
  
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/adjust/report/proedit/goalandindex';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/goalandindex', 'pmkpi_adjustgoalindex', '{}', 'adjustgoalindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/goalandindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/goalandindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/adjust/report/proedit/hbtreeindex'',nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/proedit/goalandindex', 'busuidatatable', '{key:''/pmkpi/adjust/report/proedit/hbprogoal'',addrow:true,headsort:false,name:''项目绩效目标'',edit:true,checkbox:false,radio:true,title:''项目绩效目标'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);




delete from bus_t_pageconsole where url = '/pmkpi/adjust/report/proedit/goalandindex';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/proedit/goalandindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.index.AdjustIndexPage', 'hbindex', '{main:[toolbutton,maintable,datatable]}', null, null, null);


delete from bus_t_pagecomponent where id = 'pmkpi_adjustgoalindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjustgoalindex', '绩效目标调整绩效目标指标', null, '绩效目标调整绩效目标指标', '/pmkpi/adjust/index/adjustgoalindex.js', 'Ext.lt.pmkpi.adjust.goalindexservice', 'pmkpi', 'pmkpi.adjust.index.AdjustGoalIndexService');
