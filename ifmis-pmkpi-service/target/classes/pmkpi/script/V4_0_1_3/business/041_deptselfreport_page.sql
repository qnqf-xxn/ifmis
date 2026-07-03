-- 部门整体绩效自评填报和部门整体绩效目标填报使用的是同一个页面，新增一个页面
begin
update bus_t_pageconsolecomconfig t set t.CONFIG ='{key:''/pmkpi/perfself/apply/dept/report/edit'',headsort:false,name:''部门基本信息'',edit:true,title:''部门基本信息'',nextSibling:false,table:''V_PERF_T_DEPTPERFDECLARE''}'where t.url ='/pmkpi/perfself/apply/dept/edit/projinfo' and t.id = 'editform'; 
  
delete from bus_t_pageconsole where url in('/pmkpi/perfself/apply/dept/report/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/perfself/apply/dept/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,formaleditform,perftaskdatatable,deptgoaleditform],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsole where url in('/pmkpi/perfself/apply/dept/report/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftarget'',headsort:false,addrow:true,name:''年度绩效目标'',edit:true,checkbox:true,title:''年度绩效目标'',initlevel:6,isuphide:false,nextSibling:false}', 'perftargetdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'buseditform', '{title:''基础信息'',tablecode:''perf_t_deptperfdeclare'',pagetype:''manceinfo'',iswf:''true''}', 'formaleditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/auditindex'',headsort:false,addrow:true,name:''考评一类指标'',edit:true,checkbox:true,title:''考评一类指标'',initlevel:6,isuphide:false,nextSibling:false}', 'auditindexdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/target'',headsort:false,addrow:true,name:''部门整体目标'',edit:true,checkbox:true,title:''部门整体目标'',initlevel:6,isuphide:false,nextSibling:false}', 'targetdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',addrow:true,headsort:false,name:''主要任务'',edit:true,checkbox:true,title:''主要任务'',initlevel:6,isuphide:false,nextSibling:false}', 'perftaskdatatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/apply/dept/report/edit', 'buseditform', '{key:''/pmkpi/deptperformance/report/deptgoal'',title:''绩效目标'',tablecode:''v_bgt_perf_goal_info''}', 'deptgoaleditform', 'pmkpi', null);


delete busfw_t_uieditform where key='/pmkpi/perfself/apply/dept/report/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('19beace2f9ef6d03abacb81e0f87f5bd', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门编号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('27067c6345a3a3b972dd627a23774081', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '部门名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('319ff73ff870eea8ecabed2f3952ad20', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系人', 'LINKMAN', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('410ca017fa06755393685baa83ba3655', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '联系电话', 'TELEPHONE', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('55BF000C2F284D768896F0C6DA7CBC3E', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '资金总额', 'BUDGETTOTAL', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7622e19ff98b47444d10c893b78975e8', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6AD344AC45CE43AC9B288B75B0BA2DB9', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '基本支出', 'BASICEXPEND', 1, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('982A3DAFF88F4FFF83BEB8B837291139', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '一般公共预算', 'BUDGETAMT', 1, null, 1, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('8D4D2133A30C4F21859A3884793AB39D', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '政府性基金拨款', 'GOVEFUNCAMT', 1, null, 1, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('09790368673E45FEAC5BE252DE9BD587', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '项目支出', 'PROJEXPAMT', 1, null, 1, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E20428A954C4459C84CF5B5023BCA141', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '纳入专户管理的非税收入拨款', 'TAXRANAMT', 1, null, 1, null, 15, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B50D43C5E0EE4A5DA67CAC0A5A13E111', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'amt', '其他资金', 'OTHERFUND', 1, null, 1, null, 16, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('AF7B9FCB028148698EBC8E83F659ECB1', '/pmkpi/perfself/apply/dept/report/edit', 'V_PERF_T_DEPTPERFDECLARE', 'textarea', '部门职能职责概述', 'FUNCDESC', 1, null, 0, null, 17, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

