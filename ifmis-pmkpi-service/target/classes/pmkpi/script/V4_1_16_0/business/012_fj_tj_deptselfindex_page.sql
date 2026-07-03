begin

--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/perfself/apply/editdept/selfindextj';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/editdept/selfindextj', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfself.tab.TjSelfIndexPage', 'index', '{main:[toolbutton,maintable,datatable]}', null, null, null);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/perfself/apply/editdept/selfindextj';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindextj', 'pmkpi_selfindexdepttj', '{}', 'selfindexdepttj', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindextj', 'busuidatatable', '{key:''/pmkpi/perfself/apply/editdept/tjgoal'',addrow:false,headsort:false,name:''绩效目标完成情况'',edit:true,checkbox:false,radio:true,title:''绩效目标完成情况'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindextj', 'busuidatatable', '{key:''/pmkpi/perfself/apply/editdept/tjindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:false,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nextSibling:false,rowtolist:false,isnegative:1}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/editdept/selfindextj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pagecomponent t where t.id in('pmkpi_selfindexdepttj');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_selfindexdepttj', '绩效指标完成情况(天津)', null, '绩效指标完成情况(天津)', '/pmkpi/perfself/tjselfindexdept.js', 'Ext.lt.pmkpi.selfindexdepttj', 'pmkpi', 'pmkpi.perfself.TjSelfIndexService');
