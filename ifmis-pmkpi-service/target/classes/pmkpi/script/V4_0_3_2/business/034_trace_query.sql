begin
  --监控任务布置 查询区添加 金额单位 字段
delete from bus_t_pageconsole where url in('/pmkpi/program/trace/manage/prolist','/pmkpi/program/trace/manage/prolistimp');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/prolist', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{left:lefttree,main:[tabpage,queryform,datatable],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/trace/manage/prolistimp', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManagePage', 'prolist', '{left:lefttree,main:[tabpage,queryform,datatable],footer:[toolbutton]}', null, null, 0);

--一般(重点)监控任务布置项目支出查询区添加字段
delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/manage/prolist';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'COMPANY', '金额单位', 4, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_COMPANY', '{region:1,format:''#name'',multi:0}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'BGTAMT', '当年预算金额', 6, 1, 'i', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRO_TOTAL_AMT', '项目总金额', 5, 1, 'i', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRO_CAT_CODE', '支出类别', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 't.PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/manage/prolistimp';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'COMPANY', '金额单位', 4, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_COMPANY', '{region:1,format:''#name'',multi:0}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'BGTAMT', '当年预算金额', 6, 1, 'i', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_CAT_CODE', '支出类别', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 't.PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_TOTAL_AMT', '项目总金额', 5, 1, 'i', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{region:1}', null,  null);



delete from bus_t_diccolumn where tablecode ='V_PERF_COMPANY';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'COMPANYTYPE', null, '0', 'COMPANY', '1', null, null, 'DC8032D0B30B79C6E0533315A8C01721', 'COMPANY', 'V_PERF_COMPANY', '金额单位', 'S', null, null, 1, 1, null, sysdate);


delete from fasp_t_dicdssource where guid ='COMPANYTYPE';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('COMPANYTYPE', 'COMPANYTYPE', 'COMPANYTYPE', '金额单位类型', '1', null, null, null, '2020', '87', null, null, null, '2', 'select t.* from perf_t_datasource t where t.elementcode=''companytype'' order by ordernum', null, 1, 'pmkpi');


delete from perf_t_datasource where elementcode='companytype';
insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('1', '1', '元', null, null, null, null, 1, 'companytype', 1, '20221116', '20221116', 2021, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('2', '2', '万元', null, null, null, null, 2, 'companytype', 1, '20221116', '20221116', 2021, '87');

insert into perf_t_datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('3', '3', '亿元', null, null, null, null, 3, 'companytype', 1, '20221116', '20221116', 2021, '87');

