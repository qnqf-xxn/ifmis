begin

--页面配置
delete from bus_t_pageconsole where url ='/pmkpi/evaluation/financial/additionalinfo';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/additionalinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.additonalinfo.AdditionalInfoPage', 'index', '{main:[editform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/evaluation/financial/additionalinfo';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/additionalinfo', 'pmkpi_additionalinfo', '{}', 'additionalinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/additionalinfo', 'buseditform', '{headsort:false,name:''评价补充信息'',edit:true,nextSibling:false,table:"V_PERF_T_EVALADDITIONALINFO"}', 'editform', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_additionalinfo';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_additionalinfo', '评价补充信息', null, '评价补充信息', '/pmkpi/evaluation/financial/additionalinfo/additionalinfo.js', 'Ext.lt.pmkpi.additionalinfo', 'pmkpi', 'pmkpi.evaluation.financial.AdditionalInfoService');