begin
  --公式编辑区配置
delete from bus_t_pageconsole where url = '/pmkpi/setting/editformal';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/editformal', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);

--财政重点评价评分表
delete from bus_t_pageconsole where url = '/pmkpi/setting/tempdataset';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/tempdataset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.tempdataset.PerfTempDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);
--绩效枚举配置
delete from bus_t_pageconsole where url = '/pmkpi/setting/perfenumset';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/perfenumset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.tempdataset.PerfTempDataSetPage', 'leftindex', '{header:[header],left:lefttree,main:[toolbutton,datatable,queryform]}', null, null, 0);
--审核定义下级菜单
delete from bus_t_pageconsole where url = '/pmkpi/setting/auditdefinemenu';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/auditdefinemenu', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);
--预警规则配置
delete from bus_t_pageconsole where url = '/pmkpi/setting/warnset';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/warnset', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.dataset.PerfDataSetPage', 'index', '{header:[header],main:[toolbutton,datatable]}', null, null, 0);

--公式编辑区配置
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/editformal';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''perf_t_editformal'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'busuidatatable', '{name:''公式编辑区配置'',checkbox:true,title:''公式编辑区配置'',edit:true,addrow:true,delcols:[''guid'',''province'',''year''],updatecols:[''guid'',''province'',''year'']}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/editformal', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--财政重点评价评分表
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/tempdataset';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'pmkpi_tempdataset', '{}', 'tempdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''财政重点评价评分表维护'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/tempdataset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

--绩效枚举配置
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/perfenumset';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'pmkpi_tempdataset', '{}', 'tempdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''枚举参数配置'', groupcols:[''guid'',''superid'',''name'',''levelno''],delcols:[''guid'',''province''],updatecols:[''guid'',''province''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/perfenumset', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''datatable'',defprovince:''1'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
--审核定义下级菜单
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/auditdefinemenu';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'pmkpi_perfdataset', '{}', 'perfdataset', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''perf_t_auditdefinemenu'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'busuidatatable', '{name:''审核定义下级菜单'',checkbox:true,title:''审核定义下级菜单'',edit:true,addrow:true,treedata:true,treemapping:null}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/auditdefinemenu', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
--预警规则配置
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
values ('/pmkpi/setting/warnset', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''perf_t_warnset'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);



