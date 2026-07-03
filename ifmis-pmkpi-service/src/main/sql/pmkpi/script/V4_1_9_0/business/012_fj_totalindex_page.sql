begin

delete from bus_t_pageconsole where url='/pmkpi/program/prjindex/totalindex';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/totalindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'totalpage', '{main:[lasttable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url='/pmkpi/program/prjindex/totalindex';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/totalindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/totalindex', 'pmkpi_totalindex', '{}', 'pmkpitotalindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/totalindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,rowtolist:false}', 'lasttable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_totalindex';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_totalindex', '复制总体指标', null, '复制总体指标', '/pmkpi/perfprogram/prjindex/totalindex.js', 'Ext.lt.pmkpi.totalindexservice', 'pmkpi', 'pmkpi.prjindex.TotalIndexService');
