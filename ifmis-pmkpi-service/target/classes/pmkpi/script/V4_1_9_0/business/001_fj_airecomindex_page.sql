begin

--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/program/airecoindex';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/airecoindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'pickpage', '{left:lefttree,main:[airecoindextable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/airecoindex';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/airecoindex', 'pmkpi_airecoindex', '{}', 'airecoindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/airecoindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/airecoindex', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/airecoindex', 'busuidatatable', '{name:''指标推荐列表'',headsort:false,checkbox:true,edit:false,addrow:false,isuphide:false,nextSibling:false,rowtolist:false,rowresize:false}', 'airecoindextable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_airecoindex';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_airecoindex', 'AI指标推荐信息', null, 'AI指标推荐信息', '/pmkpi/perfprogram/prjindex/airecoindex.js', 'Ext.lt.pmkpi.airecoindex', 'pmkpi', 'pmkpi.prjindex.RecomIndexService');
