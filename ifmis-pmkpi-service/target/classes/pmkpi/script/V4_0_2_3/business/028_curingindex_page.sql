begin
--页面page
delete from bus_t_pageconsole where url ='/pmkpi/curingindex/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/curingindex/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.setting.curingindex.CuringIndexSetPage', 'index', '{header:[header],lefttree:lefttree,main:[toolbutton,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url='/pmkpi/curingindex/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/curingindex/index', 'pmkpi_curingindex', '{}', 'curingindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/curingindex/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/curingindex/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/curingindex/index', 'busuidatatable', '{headsort:false,addrow:true,nogroupbox:false,edit:true,checkbox:true,title:''固化指标层级'', groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,query:''querydata''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/curingindex/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_curingindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_curingindex', '固化指标层级', null, '固化指标层级', '/pmkpi/setting/curingindex/curingindex.js', 'Ext.lt.pmkpi.curingindex', 'pmkpi', 'pmkpi.curingindex.CuringIndexSetService');




--表字段
delete from bus_t_diccolumn t where t.tablecode ='PERF_T_SELFFRAME'; 
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CODE', '1', '2016', '87', 'D4D3DA6475F227EBE0533315A8C09551', 'CODE', 'PERF_T_SELFFRAME', '编码', 'S', '50', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIZBXS', null, '1', 'COMPUTESIGN', '1', '2016', '87', 'D4D3DA6475F327EBE0533315A8C09551', 'COMPUTESIGN', 'PERF_T_SELFFRAME', '计算符号', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CREATETIME', '1', '2016', '87', 'D4D3DA6475F427EBE0533315A8C09551', 'CREATETIME', 'PERF_T_SELFFRAME', '创建时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'BUSSTYPE', null, '1', 'EVALUATIONRULE', '1', '2016', '87', 'D4D3DA6475F527EBE0533315A8C09551', 'EVALUATIONRULE', 'PERF_T_SELFFRAME', '评扣分细则', 'S', '255', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', 'D4D3DA6475F627EBE0533315A8C09551', 'GUID', 'PERF_T_SELFFRAME', 'guid', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'INDEXVAL', '1', '2016', '87', 'D4D3DA6475F727EBE0533315A8C09551', 'INDEXVAL', 'PERF_T_SELFFRAME', '指标值', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '1', 'ISEDIT', '1', '2016', '87', 'D4D3DA6475F827EBE0533315A8C09551', 'ISEDIT', 'PERF_T_SELFFRAME', '是否可编辑', 'S', '3', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'ISLEAF', null, '1', 'ISLEAF', '1', '2016', '87', 'D4D3DA6475F927EBE0533315A8C09551', 'ISLEAF', 'PERF_T_SELFFRAME', '是否为末级节点', 'S', '3', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'LEVELNO', '1', '2016', '87', 'D4D3DA6475FA27EBE0533315A8C09551', 'LEVELNO', 'PERF_T_SELFFRAME', '层级', 'N', '2', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'METERUNIT', '1', '2016', '87', 'D4D3DA6475FB27EBE0533315A8C09551', 'METERUNIT', 'PERF_T_SELFFRAME', '计量单位', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'NAME', '1', '2016', '87', 'D4D3DA6475FC27EBE0533315A8C09551', 'NAME', 'PERF_T_SELFFRAME', '名称', 'S', '100', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'ORDERNUM', '1', '2016', '87', 'D4D3DA6475FD27EBE0533315A8C09551', 'ORDERNUM', 'PERF_T_SELFFRAME', '排序', 'N', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', 'D4D3DA6475FE27EBE0533315A8C09551', 'PROVINCE', 'PERF_T_SELFFRAME', '区划', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REMARK', '1', '2016', '87', 'D4D3DA6475FF27EBE0533315A8C09551', 'REMARK', 'PERF_T_SELFFRAME', '备注', 'S', '4000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'SUPERID', '1', '2016', '87', 'D4D3DA64760027EBE0533315A8C09551', 'SUPERID', 'PERF_T_SELFFRAME', '父类id', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'UPDATETIME', '1', '2016', '87', 'D4D3DA64760127EBE0533315A8C09551', 'UPDATETIME', 'PERF_T_SELFFRAME', '更新时间', 'S', '17', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'WEIGHT', '1', '2016', '87', 'D4D3DA64760227EBE0533315A8C09551', 'WEIGHT', 'PERF_T_SELFFRAME', '权重', 'S', '10', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', 'D4D3DA64760327EBE0533315A8C09551', 'YEAR', 'PERF_T_SELFFRAME', '年度', 'S', '4', null, 1, 1, null, sysdate);


--ui配置  列表字段
delete from p#busfw_t_uicolumn where key= '/pmkpi/curingindex/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BD9274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'GUID', 'GUID', 1, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BDA274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'OBLIGATE', '操作', 2, 1, 0, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BDC274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BDD274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'WEIGHT', '权重', 4, 1, 1, 0, null, 0, null, null, null, null, null, 30, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BDE274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'SUPERID', 'superid', 5, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BDF274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'LEVELNO', '层级', 6, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BE0274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'ORDERNUM', '排序', 6, 0, 1, 0, null, 0, null, null, null, null, null, 30, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BE1274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'INDEXVAL', '指标值', 7, 1, 1, 0, null, 1, null, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BE2274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'COMPUTESIGN', '计算符号', 8, 1, 1, 0, null, 1, null, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BE3274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'METERUNIT', '计量单位', 9, 1, 1, 0, null, 0, null, null, null, null, null, 30, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BE5274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'ISEDIT', '是否可编辑', 11, 1, 1, 0, null, 0, null, null, '#name', null, null, 20, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BE6274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'STATUS', '是否启用', 13, 0, 1, 0, null, 0, null, null, null, null, null, 30, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E32BE7274CE0533315A8C0ACDD', '/pmkpi/curingindex/index', 'ISLEAF', '是否末节点', 12, 1, 0, 0, null, 0, null, null, '#name', null, null, 20, 1, 'tree', null, null);



delete from p#busfw_t_uitable where key ='/pmkpi/curingindex/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D4D3DA64761327EBE0533315A8C09551', '/pmkpi/curingindex/index', 'PERF_T_SELFFRAME', 0, 0, 0, null, null, 'pmkpi', null);


delete from p#busfw_t_uifunction where key ='/pmkpi/curingindex/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4D3DA64761427EBE0533315A8C09551', '/pmkpi/curingindex/index', '保存', 1, 1, 'Keepicon', 'curingindex.savemajorkey', null, '保存', 'pmkpi', null, null, null);

