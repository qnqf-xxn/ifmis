begin
  
delete from fasp_t_dicdssource where guid in('PERFTYPICALCASETYPE','PERFTYPICALCASESTATUS') ;

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFTYPICALCASESTATUS', 'PERFTYPICALCASESTATUS', 'PERFTYPICALCASESTATUS', '典型案例授权状态', '1', null, null, null, '2016', '87', null, null, null, '1', '[{guid:"0",code:"0",name:"未授权"},{guid:"1",code:"1",name:"已授权"}]', null, 1, 'pmkpi');

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PERFTYPICALCASETYPE', 'PERFTYPICALCASETYPE', 'PERFTYPICALCASETYPE', '典型案例类型', '1', null, null, null, '2016', '87', null, null, null, '2', 'select * from v_perf_enum where elementcode = ''PERFTYPICALCASETYPE'' order by code', null, 1, 'pmkpi');


delete from bus_t_dictable where tablecode ='PERF_T_TYPICALCASE';

insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_TYPICALCASE', '典型案例表', '典型案例表', 2, 1, 'PERF_T_TYPICALCASE', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_T_TYPICALCASE', sysdate, 1, 1, null, '1');


delete from bus_t_diccolumn where tablecode ='PERF_T_TYPICALCASE';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFTYPICALCASETYPE', null, '1', 'CASETYPE', '1', '2016', '87', sys_guid(), 'CASETYPE', 'PERF_T_TYPICALCASE', '模板类型', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CODE', '1', '2016', '87', sys_guid(), 'CODE', 'PERF_T_TYPICALCASE', '编码', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATETIME', '1', '2016', '87', sys_guid(), 'CREATETIME', 'PERF_T_TYPICALCASE', '新增时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATETIME', '1', '2016', '87', sys_guid(), 'UPDATETIME', 'PERF_T_TYPICALCASE', '修改时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'DESCRIBE', '1', '2016', '87', sys_guid(), 'DESCRIBE', 'PERF_T_TYPICALCASE', '模板描述', 'S', '4000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', sys_guid(), 'GUID', 'PERF_T_TYPICALCASE', '主键', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2016', '87', sys_guid(), 'IS_DELETED', 'PERF_T_TYPICALCASE', '是否删除', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2016', '87', sys_guid(), 'NAME', 'PERF_T_TYPICALCASE', '模板名称', 'S', '500', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD08002', null, '1', 'PROVINCE', '1', '2016', '87', sys_guid(), 'PROVINCE', 'PERF_T_TYPICALCASE', '区划', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PERFTYPICALCASESTATUS', null, '1', 'STATUS', '1', '2016', '87', sys_guid(), 'STATUS', 'PERF_T_TYPICALCASE', '授权状态', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', sys_guid(), 'YEAR', 'PERF_T_TYPICALCASE', '年度', 'S', '40', null, 1, 1, null, sysdate);



delete from bus_t_pageconsole where url in ('/pmkpi/setting/typicalcase/list','/pmkpi/setting/typicalcase/edit','/pmkpi/setting/typicalcase/info');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/typicalcase/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.typicalcase.TypicalCasePage', 'edit', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/typicalcase/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.typicalcase.TypicalCasePage', 'info', '{main:[editform]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/typicalcase/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.typicalcase.TypicalCasePage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);


delete from bus_t_pageconsolecomconfig where url in ('/pmkpi/setting/typicalcase/list','/pmkpi/setting/typicalcase/edit','/pmkpi/setting/typicalcase/info');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/list', 'pmkpi_typicalcase', '{}', 'typicalcase', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/list', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/list', 'busfw.dataexport', '{}', 'dataexport', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/list', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/list', 'busuidatatable', '{uikey:''/pmkpi/setting/typicalcase/edit'',name:''典型案例库'',checkbox:true,title:''典型案例库'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);


insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);


insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/info', 'pmkpi_typicalcaseedit', '{}', 'caseinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/typicalcase/info', 'buseditform', '{tiptitle:''基础信息'',tablecode:''V_PERF_T_TYPICALCASE'',pagetype:''manceinfo'',iswf:''true''}', 'editform', 'pmkpi', null);


delete from bus_t_pagecomponent where id in ('pmkpi_typicalcase','pmkpi_typicalcaseedit');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_typicalcase', '典型案例库', null, '典型案例库', '/pmkpi/setting/typicalcase/typicalcaseservice.js', 'Ext.lt.pmkpi.typicalcase', 'pmkpi', 'pmkpi.typicalcase.TypicalCaseService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_typicalcaseedit', '典型案例库编辑', null, '典型案例库编辑', '/pmkpi/setting/typicalcase/typicalcaseedit.js', 'Ext.lt.pmkpi.typicalcaseedit', 'pmkpi', 'pmkpi.typicalcase.TypicalCaseService');



