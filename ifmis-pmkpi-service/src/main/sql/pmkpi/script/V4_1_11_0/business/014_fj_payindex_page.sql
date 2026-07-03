begin

--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/program/report/payindex';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/payindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/report/payindex';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/payindex', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/payindex', 'buseditform', '{key:''/pmkpi/yearprogram/query/edit'',tablecode:''v_perf_project_info'',pagetype:''manceinfo'',iswf:''true'',wheresql:'' 1=1 ''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/payindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/payindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);


delete from bus_t_pageconsole where url ='/pmkpi/program/report/treeindex/quantity';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/treeindex/quantity', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.payindex.PrjTreeIndexQuantityPage', 'index', '{main:[datatable]}', null, null, null);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/report/treeindex/quantity';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex/quantity', 'pmkpi_prjtreeindexquantity', '{isyears:''0''}', 'prjtreeindexquantity', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex/quantity', 'dataexport', '{}', 'dataexport', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/treeindex/quantity', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,treemapping:null,initlevel:6,isuphide:false,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_prjtreeindexquantity';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_prjtreeindexquantity', '数量指标填报', null, '数量指标填报', '/pmkpi/perfprogram/prjindex/prjtreeindexquantity.js', 'Ext.lt.pmkpi.treeindexquantity', 'pmkpi', 'pmkpi.perfprogram.prjindex.PrjTreeIndexQuantityService');

