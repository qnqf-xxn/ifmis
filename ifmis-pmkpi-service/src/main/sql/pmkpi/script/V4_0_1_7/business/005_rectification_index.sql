-- 整改通知编制页面
begin
delete  from bus_t_pageconsole where url in('/pmkpi/rectification/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);

delete  from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/index';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'pmkpi_rectification', '{}', 'rectification', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'busuidatatable', '{name:''整改通知下达'',checkbox:true,title:''整改通知下达'',edit:false,addrow:false,uikey:''/pmkpi/rectification/add''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'header', '{}', 'header', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'busdclefttree', '{}', 'lefttree', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete  from bus_t_pagecomponent where id ='pmkpi_rectification';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectification', '整改通知下达', null, '整改通知下达', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationIndex.js', 'Ext.lt.pmkpi.rectification.index', 'pmkpi', 'pmkpi.rectification.RectificationService');


-- 列表字段
delete  from p#busfw_t_uicolumn where key ='/pmkpi/rectification/index';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C67A29A8DEF825099A993A954FAB70F2', '/pmkpi/rectification/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('43C30730507A80BA8951D3FDCB75084C', '/pmkpi/rectification/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4BC2437E865515C9A5A5DFE22810C33C', '/pmkpi/rectification/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D50DDEE9F21BC289B6AF26C06FA3F5B2', '/pmkpi/rectification/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F95B1E78550BBA0BCAB3261C12622460', '/pmkpi/rectification/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C0F702981887DEF3994631B81AD8542', '/pmkpi/rectification/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('111F702981887DEF3994631B81AD8542', '/pmkpi/rectification/index', 'RECTYPE', '整改类型', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);


--列表
delete from p#busfw_t_uitable where key ='/pmkpi/rectification/audit/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('30CA317C24BAF4E04E412C2CEC47E6E2', '/pmkpi/rectification/audit/index', 'PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);


--表字段
delete  from bus_t_diccolumn where tablecode = 'PERF_T_RECTIFY' and dbcolumncode ='RECTYPE' and columncode = 'RECTYPE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'RECTYPE', null, '1', 'RECTYPE', '1', null, null, 'D4D1EAC335E659DDE0533315A8C033DA', 'RECTYPE', 'PERF_T_RECTIFY', '整改类型', 'S', '50', null, null, 1, null, sysdate);


--表
delete  from bus_t_dictable where tablecode ='PERF_T_RECTIFY';
insert into bus_t_dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_RECTIFY', '整改信息表', '整改信息表', 2, 1, 'PERF_T_RECTIFY', 'pmkpi', null, null, 1, null, 1, 1, null, null, null, null, null, '1');


--查询区
delete  from p#busfw_t_uiqueryform where key ='/pmkpi/rectification/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('15EAD9822CB5B1EEF0DFA0A9DEADAB0E', '/pmkpi/rectification/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);


-- 页签
delete  from p#busfw_t_uitabpage where key ='/pmkpi/rectification/index';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6C0FFE236BBB497009F7FEEAEFB1FC68', 'pmkpi', '/pmkpi/rectification/index', '已下达', 'alreadyaudit', 1, 2, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', null, '选择项目,删除,起草/修改,下达', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D3B88EFE90560B0E6E2E5E185E68BA02', 'pmkpi', '/pmkpi/rectification/index', '待下达', 'waitaudit', 1, 1, 'choosed', 'rectification.clickTabpage', 0, '显示未处理', null, '取消下达', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1AA395D7674CFE0CD1D394DD7A6BAFD4', 'pmkpi', '/pmkpi/rectification/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', null, '选择项目,删除,起草/修改,下达,取消下达', '{}', null, '0', null, null, null, null, null, null, null);


-- 按钮
delete  from p#busfw_t_uifunction where key ='/pmkpi/rectification/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6D43FAB5B8EAD7D4008D152B3B4C16F0', '/pmkpi/rectification/index', '下达', 1, 5, 'addaction', 'rectification.wfAudit', null, '下达', 'pmkpi', 'sendaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2D71A6F8F230CD0BCCCAD4F6DF6474DB', '/pmkpi/rectification/index', '选择项目', 1, 2, 'addaction', 'rectification.addproj', null, '选择项目', 'pmkpi', 'addproj', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('700120DEBB6A19869F4F5070A1AB84AC', '/pmkpi/rectification/index', '查询', 0, 1, 'addaction', 'rectification.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('FDDD969089A259056C6186B964B64BBF', '/pmkpi/rectification/index', '审核情况', 0, 8, 'addaction', 'rectification.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6DDDFA005297265798DD72C6A316298A', '/pmkpi/rectification/index', '送审', 0, 9, 'addaction', 'rectification.send', null, '送审', 'pmkpi', 'send', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('479F03EFCC39C1024D2C3342CFA2DD56', '/pmkpi/rectification/index', '起草/修改', 0, 3, 'addaction', 'rectification.edit', null, '起草/修改', 'pmkpi', 'edit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('498EC1C7F15A05FF739AF997C5BD646F', '/pmkpi/rectification/index', '删除', 1, 4, 'addaction', 'rectification.del', null, '删除', 'pmkpi', 'del', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('00F7DF1F9B604C88ABDBFC20277BEE58', '/pmkpi/rectification/index', '取消下达', 1, 10, 'addaction', 'rectification.wfAudit', null, '取消下达', 'pmkpi', 'cancelsendaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('10F7DF1F9B604C88ABDBFC20277BEE51', '/pmkpi/rectification/index', '查看项目', 1, 7, 'addaction', 'rectification.showProjView', null, '查看项目', 'pmkpi', 'showProjView', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('28163FECE45512A1E0533315A8C0ACDB', '/pmkpi/rectification/index', '查看明细', 1, 6, 'addaction', 'rectification.detailed', null, '查看明细', 'pmkpi', 'detailed', null, null);



-- 整改编制  选项目（项目支出、部门整体）
delete  from bus_t_pageconsole where url in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/add/proj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorj', '{footer:[toolbutton],main:[queryform,datatable]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/add/deptproj', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'selectPorj', '{footer:[toolbutton],main:[queryform,datatable]}', null, null, 0);


delete  from bus_t_pageconsolecomconfig where url in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'pmkpi_rectificationadd', '{}', 'rectificationadd', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/proj', 'busuidatatable', '{name:''选择项目'',checkbox:false,title:''选择项目'',edit:false,addrow:false,radio:true,wheresql:wfstatus=''10''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'pmkpi_rectificationadd', '{}', 'rectificationadd', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/add/deptproj', 'busuidatatable', '{name:''部门'',checkbox:false,title:''部门'',edit:false,addrow:false,radio:true}', 'datatable', 'pmkpi', null);


delete  from bus_t_pagecomponent where id ='pmkpi_rectificationadd';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_rectificationadd', '选择项目', null, '选择项目', '/busfw/common/bill/billmanage.js,/pmkpi/rectification/rectificationproj.js', 'Ext.lt.pmkpi.rectification.add.proj', 'pmkpi', 'pmkpi.rectification.RectificationAddProjService');



--列表字段
delete  from p#busfw_t_uicolumn where key in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F876728735BB23BC7C910D8FC31D696B', '/pmkpi/rectification/add/proj', 'DEPT_CODE', '部门', 9, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F2559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'FININTORGGUID', '业务处室', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F5559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'EXP_FUNC_CODE', '功能分类', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F7559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'GUID', '项目id', 7, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F8559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_CODE', '项目编码', 2, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F9559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_NAME', '项目名称', 3, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F6559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_LEV', '项目级别', 1, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F3559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF77473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF87473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF97473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'NAME', '名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFA7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFB7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 1, null, '#name', null, null, 80, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF67473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);



--列表
delete  from p#busfw_t_uitable where key in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('265BD352DC9C401E2B63D2CCC36ED7EF', '/pmkpi/rectification/add/proj', 'V_PERF_PROJECT_INFO', 20, 0, null, null, null, 'pmkpi', null);

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD4E9B88DEF57473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'V_PERF_T_DEPTPERFDECLARE', 20, 0, null, null, null, 'pmkpi', null);


-- 查询区
delete  from p#busfw_t_uiqueryform where key in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('89A225809BBEA6C37274CD7A8AAC3932', '/pmkpi/rectification/add/proj', 'PRO_NAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFE7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);


-- 按钮
delete  from p#busfw_t_uifunction where key in('/pmkpi/rectification/add/proj','/pmkpi/rectification/add/deptproj');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DD62A20F25AE345CA743AB2C214EA179', '/pmkpi/rectification/add/proj', '查询', 0, 1, 'addaction', 'rectificationadd.query', null, '查询', 'pmkpi', '查询', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('83471FF7D88768373224E9AD6F021DC5', '/pmkpi/rectification/add/proj', '确定', 1, 2, 'addaction', 'rectificationadd.add', null, '确定', 'pmkpi', '确定', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('11111FF7D88768373224E9AD6F021DC5', '/pmkpi/rectification/add/proj', '关闭', 1, 3, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD4E9B88DEFD7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', '确定', 1, 2, 'addaction', 'rectificationadd.add', null, '确定', 'pmkpi', '确定', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD4E9B88DEFC7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', '查询', 0, 1, 'addaction', 'rectificationadd.query', null, '查询', 'pmkpi', '查询', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('22222FF7D88768373224E9AD6F021DC5', '/pmkpi/rectification/add/deptproj', '关闭', 1, 3, 'addaction', 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', '关闭', null, null);



-- 整改通知 新增
delete  from bus_t_pageconsole where url in('/pmkpi/rectification/program/add','/pmkpi/rectification/dept/add');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/program/add', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'rectifyAdd', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/dept/add', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'rectifyAdd', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);


delete  from bus_t_pageconsolecomconfig where url in('/pmkpi/rectification/program/add','/pmkpi/rectification/dept/add');

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'pmkpi_addprogram', '{}', 'addprogram', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/program/add', 'buseditform', '{key:''/pmkpi/program/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'pmkpi_addprogram', '{}', 'addprogram', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/dept/add', 'buseditform', '{key:''/pmkpi/deptperformance/report/edit'',title:''基础信息'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);


delete  from bus_t_pagecomponent where id ='pmkpi_addprogram';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_addprogram', '整改新增项目', null, '整改新增项目', '/pmkpi/rectification/rectificationaddproj.js', 'Ext.lt.pmkpi.rectification.addproj', 'pmkpi', 'pmkpi.rectification.addproj.AddprojEditService');


--页签
delete  from p#busfw_t_uitabpage where key ='/pmkpi/rectification/program/add';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C41829802E023DE6FA95330E4525637A', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, null, '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('25CCFA09C578C553CB3C77D945891EBD', 'pmkpi', '/pmkpi/rectification/program/add', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/rectification/program/proinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD19AA0879E10A55E053B11FA8C0A366', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016C4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, null, '{url:''/pmkpi/rectification/program/deptinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016D4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知详情', 'rectification', 0, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, null, '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016B4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知附件', 'file', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);



--按钮
delete  from p#busfw_t_uifunction where key in('/pmkpi/rectification/program/add','/pmkpi/rectification/dept/add');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/add', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/add', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/program/add', '保存并送审', 1, 2, null, 'addprogram.saveandsend', null, '保存并送审', 'pmkpi', 'saveandsend', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/add', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/add', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/dept/add', '保存并送审', 1, 2, null, 'addprogram.saveandsend', null, '保存并送审', 'pmkpi', 'saveandsend', null, '{}');


--整改附件
delete  from bus_t_pageconsole where url ='/pmkpi/rectification/file';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/file', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.filelist.UploadFilePage', 'index', '{main:[editform,datatable]}', null, null, 0);


delete  from bus_t_pageconsolecomconfig where url ='/pmkpi/rectification/file';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/file', 'pmkpi_uploadfile', '{}', 'pmkpiuploadfile', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/file', 'busuidatatable', '{name:''整改附件'',title:''整改附件'',key:''/pmkpi/upload/file/index''}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/file', 'buseditform', '{}', 'editform', 'pmkpi', null);

--编辑区
delete  from p#busfw_t_uieditform where key ='/pmkpi/rectification/file';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879E70A55E053B11FA8C0A366', '/pmkpi/rectification/file', 'V_PERF_T_RECTIFY', 'textarea', '整改内容', 'RECTIFYDESC', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879E80A55E053B11FA8C0A366', '/pmkpi/rectification/file', 'V_PERF_T_RECTIFY', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);





