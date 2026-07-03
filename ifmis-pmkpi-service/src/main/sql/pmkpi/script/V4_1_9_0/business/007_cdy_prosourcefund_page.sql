begin
  
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/sourcefund');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/sourcefund', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.datalist.PerfDataListPage', 'list', '{main:[datatable]}', '', '', 0);

delete from bus_t_pagecomponent t where t.id in('pmkpi_datalist');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_datalist', '列表数据', '', '列表数据', '/pmkpi/perfcommon/datalist/datalist.js', 'Ext.lt.pmkpi.perfdatalist', 'pmkpi', 'pmkpi.datalist.PerfDataListService');

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/sourcefund');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/sourcefund', 'pmkpi_datalist', '{}', 'datalist', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/sourcefund', 'busuidatatable', '{name:''资金来源”'',checkbox:true,title:''资金来源'',edit:false,addrow:false}', 'datatable', 'pmkpi', '');
