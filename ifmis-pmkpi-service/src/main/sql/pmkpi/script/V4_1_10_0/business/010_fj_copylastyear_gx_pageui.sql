begin

--选择上年项目页面配置
delete from bus_t_pageconsole where url ='/pmkpi/program/prjindex/sellastyearpro';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/sellastyearpro', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexPage', 'lastyearpro', '{main:[datatable],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/prjindex/sellastyearpro';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/sellastyearpro', 'perf_sellastyearpro', '{}', 'sellastyearpro', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/sellastyearpro', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/sellastyearpro', 'busuidatatable', '{key:''/pmkpi/program/report/list'',name:''选择上年项目'',checkbox:true,title:''选择上年项目'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='perf_sellastyearpro';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_sellastyearpro', '选择上年项目', null, '选择上年项目', '/pmkpi/perfprogram/goal/sellastyearpro.js', 'Ext.lt.pmkpi.sellastyearpro', 'pmkpi', 'pmkpi.perfprogram.goal.SelLastYearProService');


delete from p#busfw_t_uifunction where key ='/pmkpi/program/prjindex/sellastyearpro';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/sellastyearpro', '保存', 1, 1, 'Keepicon', 'sellastyearpro.save', null, '保存', 'pmkpi', null, null, null,'87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/prjindex/sellastyearpro', '取消', 1, 2, 'Nofinishicon', 'sellastyearpro.closewin', null, '取消', 'pmkpi', null, null, null, '87', '2016', null, null);


--目标和指标页签复制(多项目)按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/program/report/protabgoal' and code ='copyyeargoal' and config ='{ismultipro:true}';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/protabgoal', '复制上年目标(多项目)', 0, 10, 'keepicon', 'Ext.lt.pmkpi.copyyeargoal', null, '复制上年目标(多项目)', 'pmkpi', 'copyyeargoal', null, '{ismultipro:true}', '87', '2016', null, null);

delete from p#busfw_t_uifunction where key ='/pmkpi/program/report/treeindex' and code ='lastyearselpro' and config ='{ismultipro:true}';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/report/treeindex', '复制上年指标(多项目)', 0, 6, 'keepicon', 'prjtreeindex.lastyear', null, '复制上年指标(多项目)', 'pmkpi', 'lastyearselpro', null, '{ismultipro:true}', '87', '2016', null, null);


--总体目标指标页签隐藏复制上年(多项目)按钮
update perf_t_treetab t set t.hidebtns='复制上年目标(多项目)' 
where key ='/pmkpi/program/report/protabgoal' and t.code='total' and hidebtns is null;
 
update perf_t_treetab t set t.hidebtns= hidebtns||',复制上年目标(多项目)' 
where key ='/pmkpi/program/report/protabgoal' and t.code='total' and hidebtns is not null and instr(hidebtns,'复制上年目标(多项目)')=0; 

update perf_t_treetab t set t.hidebtns='复制上年指标(多项目)' 
where key ='/pmkpi/program/report/treeindex' and t.code='total' and hidebtns is null;
 
update perf_t_treetab t set t.hidebtns= hidebtns||',复制上年指标(多项目)' 
where key ='/pmkpi/program/report/treeindex' and t.code='total' and hidebtns is not null and instr(hidebtns,'复制上年指标(多项目)')=0; 

