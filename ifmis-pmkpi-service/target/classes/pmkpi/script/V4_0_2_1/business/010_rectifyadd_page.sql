begin
-- 问题整改选项目 通版 项目支出
delete from bus_t_pageconsole where url ='/pmkpi/rectification/check/proj';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/check/proj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorjLeft', '{footer:[toolbutton],left:lefttree,main:[queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/check/proj';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'pmkpi_rectificationcheck', '{}', 'rectificationcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/proj', 'busuidatatable', '{name:''选择项目'',checkbox:false,tiptiptiptiptitle:''选择项目'',edit:false,addrow:false,radio:true,title:''选择项目''}', 'datatable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_rectificationcheck';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationcheck', '选择项目', null, '选择项目', '/pmkpi/rectification/rectificationcheckproj.js', 'Ext.lt.pmkpi.rectification.checkproj', 'pmkpi', 'pmkpi.rectification.checkpro.RectificationCheckProjService');

--按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('83471FF7D88768373224E9AD6F021DC2', '/pmkpi/rectification/check/proj', '确定', 1, 2, 'addaction', 'rectificationcheck.add', null, '确定', 'pmkpi', '确定', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('11111FF7D88768373224E9AD6F021DC3', '/pmkpi/rectification/check/proj', '关闭', 1, 3, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);

--查询区
delete from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('89A225809BBEA6C37274CD7A8AAC3938', '/pmkpi/rectification/check/proj', 'NAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

--列表表字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F6559DE053D100A8C017C2', '/pmkpi/rectification/check/proj', 'TASKSTAGE', '任务阶段', 9, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', '{isjk:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F2559DE053D100A8C017C3', '/pmkpi/rectification/check/proj', 'FININTORGGUID', '业务处室', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F7559DE053D100A8C017C4', '/pmkpi/rectification/check/proj', 'GUID', '项目id', 7, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F8559DE053D100A8C017C5', '/pmkpi/rectification/check/proj', 'PRO_CODE', '项目编码', 3, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F9559DE053D100A8C017C6', '/pmkpi/rectification/check/proj', 'NAME', '项目名称', 4, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F3559DE053D100A8C017C7', '/pmkpi/rectification/check/proj', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F5559DE053D100A8C017C2', '/pmkpi/rectification/check/proj', 'TASKNAME', '任务名称', 8, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, null, '{isjk:1}', null);


--列表
delete from p#busfw_t_uitable where key ='/pmkpi/rectification/check/proj';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('265BD352DC9C401E2B63D2CCC36ED7E0', '/pmkpi/rectification/check/proj', 'V_PERF_PROJECT_INFO', 20, 0, null, null, null, 'pmkpi', null);



-- 问题整改选项目 通版 部门整体
delete from bus_t_pageconsole where url ='/pmkpi/rectification/check/deptproj';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/check/deptproj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorjLeft', '{footer:[toolbutton],left:lefttree,main:[queryform,datatable]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url = '/pmkpi/rectification/check/deptproj';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'pmkpi_rectificationcheck', '{}', 'rectificationcheck', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'busuidatatable', '{name:''部门'',checkbox:false,title:''部门'',edit:false,addrow:false,radio:true}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/check/deptproj', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

--按钮
delete from p#busfw_t_uifunction where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('83471FF7D88768373224E9AD6F021DC5', '/pmkpi/rectification/check/deptproj', '确定', 1, 2, 'addaction', 'rectificationcheck.add', null, '确定', 'pmkpi', '确定', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('11111FF7D88768373224E9AD6F021DC6', '/pmkpi/rectification/check/deptproj', '关闭', 1, 3, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);

--查询区
delete from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFE7473E053B11FA8C03CE0', '/pmkpi/rectification/check/deptproj', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

--列表表字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/check/deptproj';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF77473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF87473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'LINKMAN', '联系人', 5, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF97473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'NAME', '预算单位名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFA7473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'TELEPHONE', '联系电话', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFB7473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'WFSTATUS', '工作流状态', 2, 0, 0, 0, null, 0, 1, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF67473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'CREATETIME', '创建人', 7, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF57473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'AGENCYGUID', '单位编码', 4, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF37473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'TASKSTAGE', '任务阶段', 9, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', '{isjk:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF47473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'TASKNAME', '任务名称', 9, 1, 0, 0, null, 0, 1, null, null, null, null, 50, 0, 's', null, null);


--列表
delete from p#busfw_t_uitable where key = '/pmkpi/rectification/check/deptproj';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD4E9B88DEF56473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'V_PERF_T_DEPTPERFDECLARE', 20, 0, null, null, null, 'pmkpi', null);

-- 填报 详情页签 页面js配置
delete from bus_t_pagecomponent where id in('pmkpi_feedbackinfo','pmkpi_rectifyinfo');
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_feedbackinfo', '反馈信息详情', null, '反馈信息详情', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/feedbackInfo.js', 'Ext.lt.pmkpi.rectification.feedback.info', 'pmkpi', 'pmkpi.rectification.FeedbackInfoService');

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectifyinfo', '整改通知详情', null, '整改通知详情', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationinfo.js', 'Ext.lt.pmkpi.rectification.info', 'pmkpi', 'pmkpi.rectification.RectificationAddService');


--表字段注册
delete from bus_t_diccolumn where tablecode ='PERF_T_RECTIFY' and columncode in('TASKSTAGE','TASKGUID','TASKNAME','RECTYPE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'TASKNAME', '1', null, null, '2EECED2DB35ECA7145F1A2EDCE17AA22', 'TASKNAME', 'PERF_T_RECTIFY', '任务名称', 'S', '50', null, null, 1, null,sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPITASKSTAGE', null, '1', 'TASKSTAGE', '1', null, null, '2EECED2DB35ECA7145F1A2EDCE17AA11', 'TASKSTAGE', 'PERF_T_RECTIFY', '任务阶段', 'S', '50', null, null, 1, null,sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'TASKGUID', '1', null, null, '22ECED2DB35ECA7145F1A2EDCE17AA64', 'TASKGUID', 'PERF_T_RECTIFY', '任务guid', 'S', '4', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'RECTYPE', null, '1', 'RECTYPE', '1', null, null, '2EECED2DB35ECA7145F1A2EDCE17AA33', 'RECTYPE', 'PERF_T_RECTIFY', '整改类型', 'S', '50', null, null, 1, null, sysdate);
