begin

--页面配置
update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/expertinifo/edit'',sxuikey:''/pmkpi/setting/baseinfo/expertinifo/addoredit''}' where url = '/pmkpi/setting/baseinfo/expertinifo' and componentid = 'busuidatatable';


update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/policylib/edit'',sxuikey:''/pmkpi/setting/baseinfo/policylib/sxedit''}' where url = '/pmkpi/setting/baseinfo/policylib' and componentid = 'busuidatatable';


update bus_t_pageconsolecomconfig set config = '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''基础资料'',uikey:''/pmkpi/setting/baseinfo/standard/edit'',sxuikey:''/pmkpi/setting/baseinfo/standard/sxedit''}' where url = '/pmkpi/setting/baseinfo/standard' and componentid = 'busuidatatable';


--新增/编辑页面配置

delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/expertinifo/addoredit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/expertinifo/addoredit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/expertinifo/addoredit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/expertinifo/addoredit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/expertinifo/addoredit', 'buseditform', '{key:''/pmkpi/setting/baseinfo/expertinifo/edit'',title:''专家编辑'',tablecode:''V_PERF_EXPERTINIFO'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/expertinifo/addoredit', 'bustoolbutton', '{key:''/pmkpi/setting/baseinfo/expertinifo/edit''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/expertinifo/addoredit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/policylib/sxedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/policylib/sxedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/policylib/sxedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib/sxedit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib/sxedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib/sxedit', 'bustoolbutton', '{key:''/pmkpi/setting/baseinfo/policylib/edit''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/policylib/sxedit', 'buseditform', '{key:''/pmkpi/setting/baseinfo/policylib/edit'',title:''政策法规编辑'',tablecode:''V_PERF_POLICYLIB'',iswf:''true''}', 'editform', 'pmkpi', null);



delete from bus_t_pageconsole where url = '/pmkpi/setting/baseinfo/standard/sxedit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/baseinfo/standard/sxedit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.baseinfo.BaseinfoPage', 'editindex', '{main:[tabpage,editform],footer:[toolbutton]}', null, null, 0);



delete from bus_t_pageconsolecomconfig where url = '/pmkpi/setting/baseinfo/standard/sxedit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/standard/sxedit', 'buseditform', '{key:''/pmkpi/setting/baseinfo/standard/edit'',title:''标准库编辑'',tablecode:''V_PERF_STANDARDLIB'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/standard/sxedit', 'bustoolbutton', '{key:''/pmkpi/setting/baseinfo/standard/edit''}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/standard/sxedit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/baseinfo/standard/sxedit', 'pmkpi_baseinfoedit', '{}', 'baseinfoedit', 'pmkpi', null);





delete from bus_t_diccolumn t where tablecode = 'PERF_STANDARDLIB' and columncode = 'TYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'STANDARDTYPE', null, '1', 'TYPE', '1', '2016', '87', '362D7BCD27CF4C86ACC02D1461CF0233', 'TYPE', 'PERF_STANDARDLIB', '标准类型', 'S', '40', null, null, 1, null, sysdate);


delete from fasp_t_dicdssource t where code = 'STANDARDTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('STANDARDTYPE', 'STANDARDTYPE', 'STANDARDTYPE', '标准类型', '1', null, null, null, '2021', '87', null, null, null, '2', 'SELECT * FROM v_perf_enum t where t.elementcode=''TYPE'' order by t.ordernum', null, null, 'pmkpi');