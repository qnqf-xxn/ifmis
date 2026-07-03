begin
  
delete from fasp_t_dicdssource where guid ='PMKPIYEARFLAG';

insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIYEARFLAG', 'PMKPIYEARFLAG', 'PMKPIYEARFLAG', '绩效目标类型', '1', '20240218113621631', '20160101', null, '2016', '87', null, null, null, '1', '[{guid:"1",code:"1",name:"总体绩效"},{guid:"0",code:"0",name:"年度绩效"}]', null, 1, 'pmkpi');


delete from bus_t_dictable where tablecode ='PERF_T_FIXEDINDEX';

insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_FIXEDINDEX', '绩效固化指标表', '绩效固化指标表', 2, 1, 'PERF_T_FIXEDINDEX', 'pmkpi', null, '0', 1, null, 1, 1, 'V_PERF_T_FIXEDINDEX', sysdate, 1, 1, null, '1');


delete from bus_t_diccolumn where tablecode ='PERF_T_FIXEDINDEX';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CODE', '1', '2016', '87', sys_guid(), 'CODE', 'PERF_T_FIXEDINDEX', '编码', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIZBXS', null, '1', 'COMPUTESIGN', '1', '2016', '87', sys_guid(), 'COMPUTESIGN', 'PERF_T_FIXEDINDEX', '计算符号', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATE_TIME', '1', '2016', '87', sys_guid(), 'CREATE_TIME', 'PERF_T_FIXEDINDEX', '创建时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIFRAME', null, '1', 'FINDEX', '1', '2016', '87', sys_guid(), 'FINDEX', 'PERF_T_FIXEDINDEX', '一级指标', 'N', '2', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIFRAMESYSTEM', null, '1', 'FRAMETYPE', '1', '2016', '87', sys_guid(), 'FRAMETYPE', 'PERF_T_FIXEDINDEX', '固化类型', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', sys_guid(), 'GUID', 'PERF_T_FIXEDINDEX', 'guid', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXVAL', '1', '2016', '87', sys_guid(), 'INDEXVAL', 'PERF_T_FIXEDINDEX', '指标值', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'IS_DELETED', '1', '2016', '87', sys_guid(), 'IS_DELETED', 'PERF_T_FIXEDINDEX', '是否删除', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'METERUNIT', '1', '2016', '87', sys_guid(), 'METERUNIT', 'PERF_T_FIXEDINDEX', '计量单位', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2016', '87', sys_guid(), 'NAME', 'PERF_T_FIXEDINDEX', '名称', 'S', '100', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', sys_guid(), 'ORDERNUM', 'PERF_T_FIXEDINDEX', '排序', 'N', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', sys_guid(), 'PROVINCE', 'PERF_T_FIXEDINDEX', '区划', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REMARK', '1', '2016', '87', sys_guid(), 'REMARK', 'PERF_T_FIXEDINDEX', '备注', 'S', '4000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIFRAME', null, '1', 'SINDEX', '1', '2016', '87', sys_guid(), 'SINDEX', 'PERF_T_FIXEDINDEX', '二级指标', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'STATUS', '1', '2016', '87', sys_guid(), 'STATUS', 'PERF_T_FIXEDINDEX', '状态', 'N', '1', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATE_TIME', '1', '2016', '87', sys_guid(), 'UPDATE_TIME', 'PERF_T_FIXEDINDEX', '更新时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'WEIGHT', '1', '2016', '87', sys_guid(), 'WEIGHT', 'PERF_T_FIXEDINDEX', '权重', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', sys_guid(), 'YEAR', 'PERF_T_FIXEDINDEX', '年度', 'S', '4', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIYEARFLAG', null, '1', 'YEARFLAG', '1', '2016', '87', sys_guid(), 'YEARFLAG', 'PERF_T_FIXEDINDEX', '绩效目标类型', 'S', '40', null, 1, 1, null, sysdate);


delete from bus_t_diccolumn where tablecode ='PM_PERF_INDICATOR' and columncode ='ISFIXED';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISFIXED', '1', '2016', '87', sys_guid(), 'ISFIXED', 'PM_PERF_INDICATOR', '是否为固化指标', 'N', '22', null, 1, 0, null, sysdate);

delete from bus_t_diccolumn where tablecode ='PERF_PROVISION_INDICATOR' and columncode ='ISFIXED';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISFIXED', '1', '2016', '87', sys_guid(), 'ISFIXED', 'PERF_PROVISION_INDICATOR', '是否为固化指标', 'N', '22', null, 1, 0, null, sysdate);

delete from bus_t_diccolumn where tablecode ='PERF_T_ADJUSTINDEX' and columncode ='ISFIXED';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISFIXED', '1', '2016', '87', sys_guid(), 'ISFIXED', 'PERF_T_ADJUSTINDEX', '是否为固化指标', 'N', '22', null, null, 1, null, sysdate);


delete from bus_t_pageconsole where url ='/pmkpi/fixedindex/index';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/fixedindex/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.curingindex.CuringIndexSetPage', 'index', '{header:[header],lefttree:lefttree,main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/fixedindex/index';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/fixedindex/index', 'pmkpi_curingindex', '{}', 'curingindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/fixedindex/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/fixedindex/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/fixedindex/index', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''固化指标'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,query:''querydata''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/fixedindex/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

