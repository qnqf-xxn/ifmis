begin

delete FROM bus_t_pageconsole where url = '/pmkpi/doubleprocess/index';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/doubleprocess/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.doubleprocess.dpaudit.DoubleProcessPage', 'index', '{header:[header]}', null, null, 0);


delete FROM bus_t_pageconsolecomconfig  where url = '/pmkpi/doubleprocess/index';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/doubleprocess/index', 'pmkpi_doubleprocess', '{}', 'doubleprocess_index', 'pmkpi', null);


delete FROM bus_t_pagecomponent where  id = 'pmkpi_doubleprocess';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_doubleprocess', '山西双流程调用', null, '山西双流程调用', '/pmkpi/doubleprocess/indexdp.js', 'Ext.lt.pmkpi.doubleprocess.index', 'pmkpi', 'pmkpi.doubleprocess.dpaudit.DoubleProcessService');



