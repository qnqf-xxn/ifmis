BEGIN

DELETE from busfw_t_uifunction where key = '/pmkpi/evaluation/financial/query' AND CODE = 'queryresult';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG,YEAR,PROVINCE)
values (sys_guid(), '/pmkpi/evaluation/financial/query', '查看评价成果', 1, 6, 'searchicon', 'finevalquery.queryresult', null, '查看评价成果', 'pmkpi', 'queryresult', null, '{}','2021','330000000');


DELETE FROM BUSFW_T_UITABPAGE WHERE KEY = '/pmkpi/evaluation/financial/result/edit' and code = 'finapp';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评价成果应用情况', 'finapp', 1, 7, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果应用情况', null, '保存', '{url:''/pmkpi/evaluation/financial/application/index.page''}', null, '0', 'finappiframe', null, null, null, null, null, null,'2021','330000000');

--项目
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/query/edit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null,'2021','330000000');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '项目附件', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{url:''/pmkpi/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null,'2021','330000000');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2'',url:''/pmkpi/evaluation/financial/result/edit.page'',viewtype:''query''}', null, '0', 'editform', null, null, null, null, null, null,'2021','330000000');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceisframe', null, null, null, null, null, null,'2021','330000000');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER,YEAR,PROVINCE)
values (SYS_GUID(), 'pmkpi', '/pmkpi/evaluation/financial/query/edit', '评分表', 'info', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, '保存', '{busguid:''BD9470BB508E48E5E053B11FA8C0AEAA'',url:''/pmkpi/evaluation/financial/deptfill/score.page'',viewtype:''query''}', null, '0', 'proscoreiframe', null, null, null, null, null, null,'2021','330000000');


delete from bus_t_pageconsole t where t.url in('/pmkpi/evaluation/financial/query/edit');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/query/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.tabfream.TabfreamPage', 'editindex', '{main:[tabpage,infoeditform,editform],footer:[toolbutton]}', null, null, 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/evaluation/financial/query/edit');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'pmkpi_tabfreamedit', '{}', 'tabfreamedit', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'buseditform', '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''评估结果''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'buseditform', '{key:''/pmkpi/evaluation/finconfirm/edit'',columnsize:2,iswf:''true'',tablecode:''v_perf_t_finevaluation''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/query/edit', 'busuidatatable', '{key:''/pmkpi/evaluation/financial/deptfill/score'',name:''评分表'',checkbox:true,title:''评分表'',edit:false,addrow:false}', 'datatable', 'pmkpi', null);


delete bus_t_pageconsole where url = '/pmkpi/evaluation/financial/application/index';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/evaluation/financial/application/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.evaluation.financial.finapp.FinApplicationPage', 'index', '{main:[datatable]}', null, null, 0);
delete bus_t_pageconsolecomconfig where url = '/pmkpi/evaluation/financial/application/index';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/application/index', 'pmkpi_finappindex', '{}', 'finappindex', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/evaluation/financial/application/index', 'busuidatatable', '{addrow:false,name:''评价成果应用情况'',edit:true,checkbox:true,title:''评价成果应用情况''}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id = 'pmkpi_finappindex';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_finappindex', '评价成果应用情况', null, '评价成果应用情况', '/pmkpi/evaluation/financial/finapp/finappindex.js', 'Ext.lt.pmkpi.finappindex', 'pmkpi', 'pmkpi.evaluation.FinApplicationService');

delete from p#busfw_t_uitable where key = '/pmkpi/evaluation/financial/application/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/evaluation/financial/application/index', 'V_PERF_T_FINAPPLICATION', 0, 0, 0, null, null, 'pmkpi', null, '330000000', '2021');
select * from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/financial/application/index';

delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/financial/application/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (SYS_GUID(), '/pmkpi/evaluation/financial/application/index', 'GUID', 'GUID', 1, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '330000000', '2021');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (SYS_GUID(), '/pmkpi/evaluation/financial/application/index', 'CODE', '结果应用名称', 2, 1, 0, 0, null, 0, null, null, '#name', null, 0, 200, 1, 'tree', '{}', null, '330000000', '2021');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values (SYS_GUID(), '/pmkpi/evaluation/financial/application/index', 'CONTENT', '结果应用内容', 3, 1, 1, 0, null, 0, null, null, null, null, 0, 200, 1, 's', '{}', null, '330000000', '2021');

	
delete from bus_t_dictable where tablecode = 'PERF_T_FINAPPLICATION';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_FINAPPLICATION', '评价成果应用情况', null, 1, 1, 'V_PERF_T_FINAPPLICATION', 'pmkpi', null, '0', 1, '0', 0, 1, null, sysdate, 1, 1, null, '1');


delete from bus_t_diccolumn where tablecode = 'PERF_T_FINAPPLICATION';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'GUID', '1', '2016', '87', 'BCAC837AF852A4Q1E053B11FA8C0F8B7', 'GUID', 'PERF_T_FINAPPLICATION', 'ID', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FINGUID', '1', '2016', '87', 'BCAC837AF852Q2PPE053B11FA8C0F8B7', 'FINGUID', 'PERF_T_FINAPPLICATION', 'ID', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIZBXS', null, '1', 'CODE', '1', '2016', '87', 'BCAC837AF851A4BQ3053B11PP8C0F8B7', 'CODE', 'PERF_T_FINAPPLICATION', '结果应用名称', 'S', '40', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'CONTENTS', '1', '2016', '87', 'BCAC837AF853A4PQ4053B11FA8C0F8B7', 'CONTENTS', 'PERF_T_FINAPPLICATION', '结果应用内容', 'S', '2000', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PROVINCE', '1', '2016', '87', 'BCAC837AF85Q54PPE053B11FA8C0F8B7', 'PROVINCE', 'PERF_T_FINAPPLICATION', '区划', 'S', '9', null, 1, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'YEAR', '1', '2016', '87', 'BCAC837AF861A4PPQ653B11FA8C0F8B7', 'YEAR', 'PERF_T_FINAPPLICATION', '年度', 'S', '4', null, 1, 1, null, sysdate);

delete from fasp_t_dicdssource where code = 'PMKPIFINAPP';
insert into fasp_t_dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, VERSION, APPID)
values ('PMKPIFINAPP', 'PMKPIFINAPP', 'PMKPIFINAPP', '评价结果名称维护', '1', '20180424221721795', '20180424', null, '2016', '87', null, null, null, '2', 'select * from V_PERF_T_FINAPP', 1, 'pmkpi');

