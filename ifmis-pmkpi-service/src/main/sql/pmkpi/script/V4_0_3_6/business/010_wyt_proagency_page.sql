begin
--项目单位变更维护页面注册
delete from bus_t_pageconsole where url ='/pmkpi/setting/proagency';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/proagency', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.proagency.ProagencyPage', 'index', '{header:[header],main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/setting/proagency';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''datatable'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency', 'pmkpi_proagency', '{}', 'proagency', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency', 'busuidatatable', '{name:''项目变更单位列表'',checkbox:true,title:''项目变更单位列表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_proagency';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_proagency', '项目单位变更维护', null, '项目单位变更维护', '/pmkpi/setting/proagency/proagencyservice.js', 'Ext.lt.pmkpi.proagencyservice', 'pmkpi', 'pmkpi.setting.proagency.ProagencyService');


delete from bus_t_diccolumn where tablecode ='PERF_PROJECT_AGENCY';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCY_CODE', '1', '2016', '87', '4450B6D0DD7A0554E053B11FA8C044F7', 'AGENCY_CODE', 'PERF_PROJECT_AGENCY', '变更后单位编码', 'S', '100', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'AGENCY_NAME', '1', '2016', '87', '1450B6D0DD7A0554E053B11FA8C044F7', 'AGENCY_NAME', 'PERF_PROJECT_AGENCY', '变更后单位名称', 'S', '100', null, 1, 0, null,sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATETIME', '1', '2016', '87', '7450B6D0DD7D0554E053B11FA8C044F7', 'CREATETIME', 'PERF_PROJECT_AGENCY', '创建时间', 'S', '10', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'GUID', '1', '2016', '87', '2450B6D0DD7A0554E053B11FA8C044F7', 'GUID', 'PERF_PROJECT_AGENCY', '主键', 'S', '100', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PROVINCE', '1', '2016', '87', '5450B6D0DD7D0554E053B11FA8C044F7', 'PROVINCE', 'PERF_PROJECT_AGENCY', '区划', 'S', '10', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_CODE', '1', '2016', '87', '3450B6D0DD7E0554E053B11FA8C044F7', 'PRO_CODE', 'PERF_PROJECT_AGENCY', '项目编码', 'S', '100', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_NAME', '1', '2016', '87', '9450B6D0DD7E0554E053B11FA8C044F7', 'PRO_NAME', 'PERF_PROJECT_AGENCY', '项目名称', 'S', '100', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'UPDATETIME', '1', '2016', '87', '8450B6D0DD7E0554E053B11FA8C044F7', 'UPDATETIME', 'PERF_PROJECT_AGENCY', '修改时间', 'S', '10', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'YEAR', '1', '2016', '87', '6450B6D0DD7E0554E053B11FA8C044F7', 'YEAR', 'PERF_PROJECT_AGENCY', '年度', 'S', '10', null, 1, 0, null, sysdate);


delete from bus_t_diccolumn where tablecode ='PERF_V_PROJECT_AGENCY';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCYCODE', '1', '2016', '87', '9450B6D0DD7A0554E053B11FA8C044F7', 'AGENCYCODE', 'PERF_V_PROJECT_AGENCY', '原单位', 'S', '100', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00010', null, '0', 'AGENCY_CODE', '1', '2016', '87', '4450B6D0DD7A0554E053B11FA8C044F6', 'AGENCY_CODE', 'PERF_V_PROJECT_AGENCY', '变更后单位编码', 'S', '100', null, 1, 0, null, sysdate);



delete from bus_t_dictable where tablecode ='PERF_PROJECT_AGENCY';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_PROJECT_AGENCY', '项目单位变更维护表', '项目单位变更维护表', 2, 1, 'PERF_PROJECT_AGENCY', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_PROJECT_AGENCY', sysdate, 1, 1, null, '1');


--项目单位变更维护新增页面注册

delete from bus_t_pageconsole where url ='/pmkpi/setting/proagency/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/proagency/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.proagency.ProagencyPage', 'editindex', '{main:[datatable],footer:[toolbutton]}', null, null, null);


delete from bus_t_pageconsolecomconfig where url ='/pmkpi/setting/proagency/edit';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency/edit', 'pmkpi_proagencyedit', '{}', 'proagencyedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency/edit', 'busuidatatable', '{name:''项目变更单位列表'',checkbox:true,title:''项目变更单位列表'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/proagency/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


delete from bus_t_pagecomponent where id ='pmkpi_proagencyedit';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_proagencyedit', '项目单位变更维护页面', null, '项目单位变更维护页面', '/pmkpi/setting/proagency/proagencyedit.js', 'Ext.lt.pmkpi.proagencyedit', 'pmkpi', 'pmkpi.setting.proagency.ProagencyEditService');



