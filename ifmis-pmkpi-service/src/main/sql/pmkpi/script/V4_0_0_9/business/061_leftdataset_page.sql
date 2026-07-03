begin
  --左侧树枚举表维护
delete from bus_t_pageconsole where url = '/pmkpi/setting/perfenumset';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/perfenumset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'leftindex', '{header:[header],left:lefttree,main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/perfenumset';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'busuidatatable', '{name:''枚举参数配置'',checkbox:true,title:''枚举参数配置'',edit:true,addrow:true,delcols:[''guid'',''province''],updatecols:[''guid'',''province''],}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''PERF_ENUM'',defprovince:''1'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);



delete from bus_t_pagecomponent where ID = 'pmkpi_perfdataset';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_perfdataset', '绩效评估类别', null, '绩效评估类别', '/pmkpi/setting/dataset/perfdatasetservice.js', 'Ext.lt.pmkpi.perfdataset', 'pmkpi', 'pmkpi.setting.dataset.PerfDataSetService');

