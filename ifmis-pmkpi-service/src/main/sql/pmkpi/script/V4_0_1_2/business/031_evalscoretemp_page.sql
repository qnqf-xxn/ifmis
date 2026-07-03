begin

delete from bus_t_pageconsole where url='/pmkpi/setting/tempdataset';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/tempdataset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.tempdataset.PerfTempDataSetPage', 'getLeftData', '{header:[header],left:lefttree,main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/setting/tempdataset';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'pmkpi_evalscore', '{}', 'evalscore', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''评分表维护'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,query:''querydata''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

delete from bus_t_pagecomponent t where t.id = 'pmkpi_evalscore';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_evalscore', '评分表数据维护', null, '评分表数据维护', '/pmkpi/setting/tempdataset/tempdatasetscore.js', 'Ext.lt.pmkpi.tempdatasetscore', 'pmkpi', 'pmkpi.setting.tempdataset.PerfTempDataSetService');



