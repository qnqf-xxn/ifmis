begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/adjust/traindex');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/adjust/traindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.index.AdjustIndexPage', 'traIndex', '{left:lefttree,main:[toolbutton,editform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/adjust/traindex');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/adjust/traindex', 'pmkpiimpexp', '{}', 'impexp', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/adjust/traindex', 'pmkpi_adjtraindex', '{}', 'adjtraindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/adjust/traindex', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/adjust/traindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/adjust/traindex', 'busuidatatable', '{key:''/pmkpi/program/report/treeindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false,remark:''当整体年度绩效修改时区域年度绩效需同步调整。''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/adjust/traindex', 'buseditform', '{key:''/pmkpi/program/report/protabgoal''}', 'editform', 'pmkpi', null);

delete from bus_t_pagecomponent t where t.id in('pmkpi_adjtraindex');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_adjtraindex', '调整细化区域年度绩效', null, '调整细化区域年度绩效', '/pmkpi/adjust/index/adjusttraindex.js', 'Ext.lt.pmkpi.adjusttraindex', 'pmkpi', 'pmkpi.adjust.AdjustTraIndexService');
