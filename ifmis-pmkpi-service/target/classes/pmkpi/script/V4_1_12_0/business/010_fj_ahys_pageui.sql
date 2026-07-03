begin

--1：查看资金来源列表，增加查询区，增加预算级次列
delete from bus_t_pageconsole t where t.url in('/pmkpi/program/sourcefund');

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/sourcefund', 'template8', '/busfw/common/template/template_defautl.jsp', '/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.datalist.PerfDataListPage', 'list', '{main:[toolbutton,queryform,datatable]}', '', '', 0);

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/program/sourcefund');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/sourcefund', 'pmkpi_datalist', '{}', 'datalist', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/sourcefund', 'busuidatatable', '{name:''资金来源”'',checkbox:true,title:''资金来源'',edit:false,addrow:false}', 'datatable', 'pmkpi', '');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/sourcefund', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null, null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION, PROVINCE)
values ('/pmkpi/program/sourcefund', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null, null);

delete from p#busfw_t_uiqueryform t where key ='/pmkpi/program/sourcefund';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/sourcefund', 'NAME', '资金来源', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROSOURCEFUND', '{}', null, null, null, null,  '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/program/sourcefund', 'BUDGET_LEVEL_CODE', '预算级次', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_PROSOURCEFUND', '{}', null, null, null, null,  '87', '2016');

delete from p#busfw_t_uifunction where key ='/pmkpi/program/sourcefund';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/sourcefund', '查询', 1, 1, 'searchicon', 'datalist.query', null, '查询', 'pmkpi', 'query', null, '{}',  '87', '2016', null, null);

--适用快速查询，COLTYPE=1的可用快速查询，更新uicolumn配置只保留 资金来源、预算级次为1
update p#busfw_t_uicolumn t set COLTYPE = 0 where key ='/pmkpi/program/sourcefund';
update p#busfw_t_uicolumn t set COLTYPE = 1 where key ='/pmkpi/program/sourcefund' and columncode in ('NAME','BUDGET_LEVEL_CODE');


--2：绩效公开，左侧树节点选中自评项目类型，列表增加是否开展自评列
delete from bus_t_diccolumn where tablecode ='PERF_T_MANCEOPEN' and columncode ='ISSELFEVAL';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD00001', null, '1', 'ISSELFEVAL', '1', '2016', '87', sys_guid(), 'ISSELFEVAL', 'PERF_T_MANCEOPEN', '是否开展自评', 'N', '1', null, 1, 1, null, sysdate);

delete from p#busfw_t_uicolumn t where key ='/pmkpi/performanceopen/report/listquery' and columncode ='ISSELFEVAL';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/performanceopen/report/listquery', 'ISSELFEVAL', '是否开展自评', 19, 1, 1, 0, '', 0, 1, '', '#name', '', null, 200, 1, 'tree', '', '', '87', '2016', null, '');


--3：绩效管理工作考核，部门类型考核对象和考核表名称规范,默认省/市直部门公用一套评分表，区分重点和非重点
--任务下达对象名
update perf_enum set name ='部门' where elementcode='PMKPIASSESSMENTBYOBJ' and guid ='dept';

update perf_enum set name ='预算绩效管理重点推进任务牵头部门' where elementcode='PMKPIASSESSMENTBYOBJ' and guid ='deptworkeval1';

update perf_enum set name ='预算绩效管理非重点推进任务牵头部门' where elementcode='PMKPIASSESSMENTBYOBJ' and guid ='deptworkeval2';

--详情页签名
update p#busfw_t_uitabpage set name ='部门预算绩效管理工作考核评分表' where key ='/pmkpi/workevaluate/report/deptedit' and code ='deptwork';

update p#busfw_t_uitabpage set name ='部门预算绩效管理重点推进任务考核评分表' where key ='/pmkpi/workevaluate/report/deptedit' and code ='deptkeywork';

update p#busfw_t_uitabpage set name ='部门预算绩效管理工作考核评分表' where key ='/pmkpi/workevaluate/audit/deptedit' and code ='deptwork';

update p#busfw_t_uitabpage set name ='部门预算绩效管理重点推进任务考核评分表' where key ='/pmkpi/workevaluate/audit/deptedit' and code ='deptkeywork';

--评分表配置表名
update perf_t_datasource set name ='部门预算绩效管理工作考核评分表' where elementcode='scoretype' and guid ='deptwork';

update perf_t_datasource set name ='部门预算绩效管理重点推进任务考核评分表' where elementcode='scoretype' and guid ='deptkeywork';
