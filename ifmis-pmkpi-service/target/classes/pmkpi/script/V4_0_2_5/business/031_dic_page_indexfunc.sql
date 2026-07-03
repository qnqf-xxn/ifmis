begin
  
delete FROM Bus_t_Dictable t where t.tablecode = 'PERF_T_INDEXCOMFUNC';
delete FROM Bus_t_Diccolumn t where t.tablecode = 'PERF_T_INDEXCOMFUNC';
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/setting/zjindexenum';
delete FROM bus_t_pageconsole t where t.url = '/pmkpi/setting/zjindexenum';
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_zjtempdata';

insert into Bus_t_Dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_INDEXCOMFUNC', '浙江指标维护左侧树一二级码表', '浙江指标维护左侧树一二级码表', 2, 1, 'PERF_T_INDEXCOMFUNC', 'pmkpi', null, '0', 1, '0', 0, 1, 'V_PERF_T_INDEXCOMFUNC', null, 1, 1, null, '1');

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIAGENCYALLPAY', null, '1', 'AGENCYGUID', '1', '2016', '87', '9A7A3F1822APPDB58124P2EB5BBAEA33', 'AGENCYGUID', 'PERF_T_INDEXCOMFUNC', '单位', 'S', '40', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CODE', '1', '2016', '87', '40519D5AC30144A7ACA5A4A05EPPB9A2', 'CODE', 'PERF_T_INDEXCOMFUNC', '编码', 'S', '100', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATER', '1', '2016', '87', '9A7A3F1822AA4DB5812492EPPBBAEA33', 'CREATER', 'PERF_T_INDEXCOMFUNC', '创建人', 'S', '40', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATETIME', '1', '2016', '87', 'ED8FF37B617742B9BCFE5B3DPP37B835', 'CREATETIME', 'PERF_T_INDEXCOMFUNC', '创建时间', 'S', '17', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'DEPT', '1', '2016', '87', '9A7A3F1822AA4DB5812PPPPP5BBAEA33', 'DEPT', 'PERF_T_INDEXCOMFUNC', '部门', 'S', '40', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', 'FA97A85EDF1B4242A5CC297FPP8ABD0A', 'GUID', 'PERF_T_INDEXCOMFUNC', '主键', 'S', '32', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ISLEAF', '1', '2016', '87', '0FEE6547AF9641769B3PP1C8F0C7676D', 'ISLEAF', 'PERF_T_INDEXCOMFUNC', '是否末节点', 'N', '1', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LEVELNO', '1', '2016', '87', 'CB70696A7FAF440BA874PP6B90532B35', 'LEVELNO', 'PERF_T_INDEXCOMFUNC', '层级', 'N', '2', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2016', '87', '003D37994E1D465PPA294BF767956847', 'NAME', 'PERF_T_INDEXCOMFUNC', '名称', 'S', '200', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', 'B114BC1DE93141E880PPB091A58B1F93', 'ORDERNUM', 'PERF_T_INDEXCOMFUNC', '排序', 'S', '9', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROELEMENT', '1', '2016', '87', 'DCEBFCDA89C54894E0533315A8C0676E', 'PROELEMENT', 'PERF_T_INDEXCOMFUNC', '项目类型', 'S', '40', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', '5D67F180453D4179B8PP359711C32C64', 'PROVINCE', 'PERF_T_INDEXCOMFUNC', '区划', 'S', '9', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REMARK', '1', '2016', '87', 'EEC2711D98644865PP514577F488EBE0', 'REMARK', 'PERF_T_INDEXCOMFUNC', '备注', 'S', '4000', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'STATUS', '1', '2016', '87', 'D0FDDACB668F4AFFPPPEEECC96A2A05', 'STATUS', 'PERF_T_INDEXCOMFUNC', '状态', 'S', '1', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SUPERID', '1', '2016', '87', '98C99374E4784266BPP36E0C0AFBC091', 'SUPERID', 'PERF_T_INDEXCOMFUNC', '父级', 'S', '38', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATETIME', '1', '2016', '87', '6BB1FE34DAD54571APPB255B6F8B16DC', 'UPDATETIME', 'PERF_T_INDEXCOMFUNC', '修改时间', 'S', '17', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'VERSION', '1', '2016', '87', 'A66B8ABF61PP4F5CB7C6102FA73E71F0', 'VERSION', 'PERF_T_INDEXCOMFUNC', '版本', 'S', '9', null, 1, 1, null, sysdate);

insert into Bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', '6F155D2834B0PPP78F347D62995049B2', 'YEAR', 'PERF_T_INDEXCOMFUNC', '年度', 'N', '4', null, 1, 1, null, sysdate);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/zjindexenum', 'pmkpi_zjtempdata', '{}', 'zjtempdata', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/zjindexenum', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,edit:true,checkbox:true,title:''个性指标项目表'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/zjindexenum', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/zjindexenum', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/zjindexenum', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/setting/zjindexenum', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''datatable'',defprovince:''1'',drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/setting/zjindexenum', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.zjtempdata.ZjTempDataPage', 'agencyleftindex', '{header:[header],left:lefttree,main:[toolbutton,datatable,queryform]}', null, null, 0);

insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_zjtempdata', '一二级项目码表维护', null, '一二级项目码表维护', '/pmkpi/setting/zjtempdata/zjtempdataservice.js', 'Ext.lt.pmkpi.zjtempdata', 'pmkpi', 'pmkpi.setting.zjdataset.ZjTempDataService');

