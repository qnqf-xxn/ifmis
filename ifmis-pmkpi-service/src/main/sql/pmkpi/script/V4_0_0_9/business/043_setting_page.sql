begin
--预警规则配置
delete from bus_t_pageconsole where url = '/pmkpi/setting/warnset';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/warnset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/warnset';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/warnset', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/warnset', 'busuidatatable', '{name:''预警规则配置'',checkbox:true,title:''预警规则配置'',viewtabcode:''V_PERF_T_WARNSET'',edit:true,addrow:true,delcols:[''guid'',''province'',''year''],updatecols:[''guid'',''province'',''year'']}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/warnset', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/warnset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/warnset', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''perf_t_warnset'',defprovince:''1'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

--审核定义下级菜单

delete from bus_t_pageconsole where url = '/pmkpi/setting/auditdefinemenu';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/auditdefinemenu', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/auditdefinemenu';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''perf_t_auditdefinemenu'',defprovince:''1'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'busuidatatable', '{name:''审核定义下级菜单'',checkbox:true,title:''审核定义下级菜单'',edit:true,addrow:true,province:"87",treedata:true,treemapping:null}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--公式编辑区配置

delete from bus_t_pageconsole where url = '/pmkpi/setting/editformal';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/editformal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/editformal';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''perf_t_editformal'',defprovince:''1'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'busuidatatable', '{name:''公式编辑区配置'',checkbox:true,title:''公式编辑区配置'',edit:true,addrow:true,delcols:[''guid'',''province'',''year''],updatecols:[''guid'',''province'',''year'']}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
