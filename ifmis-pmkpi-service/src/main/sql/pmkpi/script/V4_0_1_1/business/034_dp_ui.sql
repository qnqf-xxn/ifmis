begin

delete from p#Busfw_t_Dcworkflowplan where guid = '3DC76BC9CDA14F510E6D1B92AA561BE0';

insert into Busfw_t_Dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE, YEAR, province)
values ('3DC76BC9CDA14F510E6D1B92AA561BE0', 'PERF_PROJECT_INFO', 'PERF_PROJECT_INFO', '项目绩效目标申报', '1', null, '', '', '', '20200826143402197', 'B876713347C31372A297A0234F30FFB8', '2016', '87');


delete from Bus_t_Pageconsolecomconfig where url = '/pmkpi/program/reportdp/list';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'pmkpi_tlproreportdp', '{}', 'pmkpitlproreportdp', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'header', '{}', 'header', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'busuidatatable', '{name:''项目绩效申报'',checkbox:true,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/program/report/edit'',deltables:[v_perf_t_outpayproject,v_pm_perf_indicator],tablecode1:''PERF_PROJECT_INFODP''}', 'datatable', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', '');



delete from Bus_t_Pageconsole where url ='/pmkpi/program/reportdp/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/reportdp/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.doubleprocess.report.TlpProgramPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', '', '', 0);



delete from bus_t_pagecomponent where id = 'pmkpi_tlproreportdp';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlproreportdp', '项目绩效申报', '', '项目绩效申报', '/busfw/ltext/swfupload/jslib/fupload.js,/busfw/ltext/componentview/ltext_fileupload.js,/busfw/common/ui/ui_uploadfiles.js,/busfw/ltext/fuds-download.js,/busfw/ltext/fuds-upload.js,/pmkpi/common/fileupload.js,/pmkpi/doubleprocess/report/proreport.js', 'Ext.lt.pmkpi.doubleprocess.reportservice', 'pmkpi', 'pmkpi.doubleprocess.TlpProgramService');


delete from p#busfw_t_uitable where key = '/pmkpi/program/reportdp/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BF4D5ADE06943275E0531224280A22FC', '/pmkpi/program/reportdp/list', 'V_PERF_PROJECT_INFODPVIEW', 100, 1, 0, 'PRO_CODE', '', 'pmkpi', '');


delete from p#Busfw_t_Uifunction where key = '/pmkpi/program/reportdp/list';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB16C3275E053C224280A22FC', '/pmkpi/program/reportdp/list', '新增', 0, 2, 'searchicon', 'pmkpitlproreportdp.add', null, '新增', 'pmkpi', 'add', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB1783275E053C224280A22FC', '/pmkpi/program/reportdp/list', '审核情况', 1, 7, 'searchicon', 'pmkpitlproreportdp.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', '', '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('program/report/listfunction04', '/pmkpi/program/reportdp/list', '查询', 0, 9, 'searchicon', 'pmkpitlproreportdp.query', null, '查询', 'pmkpi', 'query', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB1793275E053C224280A22FC', '/pmkpi/program/reportdp/list', '送审', 1, 5, 'searchicon', 'pmkpitlproreportdp.wfAudit', null, '送审', 'pmkpi', 'sendaudit', '', '{"action":"audit"}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB17E3275E053C224280A22FC', '/pmkpi/program/reportdp/list', '修改', 1, 3, 'searchicon', 'pmkpitlproreportdp.save', null, '修改', 'pmkpi', 'toEdit', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB17F3275E053C224280A22FC', '/pmkpi/program/reportdp/list', '删除', 1, 4, 'searchicon', 'pmkpitlproreportdp.del', null, '删除', 'pmkpi', 'del', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB1803275E053C224280A22FC', '/pmkpi/program/reportdp/list', '取消送审', 1, 6, 'addicon', 'pmkpitlproreportdp.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', '', '{"action":"audit_cancel"}');


delete from p#busfw_t_uicolumn where key = '/pmkpi/program/reportdp/list';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn111', '/pmkpi/program/reportdp/list', 'CREATER', '创建人', 14, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn112', '/pmkpi/program/reportdp/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, '', null, 1, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn113', '/pmkpi/program/reportdp/list', 'MOF_DEP_CODE', '业务科室', 13, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn114', '/pmkpi/program/reportdp/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn115', '/pmkpi/program/reportdp/list', 'CREATE_TIME', '填报时间', 9, 1, 0, null, '', null, 1, '', 'yyyy-MM-dd hh:mm:ss', '', null, null, 0, 'd', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn116', '/pmkpi/program/reportdp/list', 'AGENCYGUID', '预算单位', 3, 1, 0, null, '', null, null, '', '#code-#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn117', '/pmkpi/program/reportdp/list', 'WFID', '工作流id', 20, 0, 0, null, '', null, 1, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn118', '/pmkpi/program/reportdp/list', 'YEAR', '预算年份', 4, 1, 0, null, '', null, 1, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn119', '/pmkpi/program/reportdp/list', 'GUID', '主键', 15, 0, 0, null, '', null, null, '', '', '', null, null, 1, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn120', '/pmkpi/program/reportdp/list', 'PRO_CODE', '项目编码', 1, 0, 0, null, '', null, 1, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('program/report/listcolumn121', '/pmkpi/program/reportdp/list', 'PRO_ID', '主键', 15, 0, 0, null, '', null, null, '', '', '', null, null, 1, 's', '{}', '');


delete from p#busfw_t_uiqueryform where key = '/pmkpi/program/report/list';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADDBFCF3275E053C224280A22FC', '/pmkpi/program/report/list', 'PRO_NAME', '项目名称', 1, 1, 's', '', null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', '{}', null);


delete from p#busfw_t_uitabpage where key ='/pmkpi/program/reportdp/list';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D5ADED4B83275E053C2A4280A22FC', 'pmkpi', '/pmkpi/program/reportdp/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'pmkpitlproreportdp.clickTabpage', 0, '曾经办', '', '选择项目,删除,送审,新增,修改,取消送审', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D5ADED4BA3275E053C2V4280A22FC', 'pmkpi', '/pmkpi/program/reportdp/list', '未送审', 'waitaudit', 1, 1, 'choosed', 'pmkpitlproreportdp.clickTabpage', 0, '未送审', '', '取消送审', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D5ADED4C43275E053C2D4280A22FC', 'pmkpi', '/pmkpi/program/reportdp/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'pmkpitlproreportdp.clickTabpage', 0, '已送审', '', '选择项目,删除,送审,新增,修改', '{}', '', '0', '', '', '', '', '', '', '');


delete from Bus_t_Pageconsolecomconfig where url = '/pmkpi/program/reportdp/audit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'pmkpi_tlprogramauditdp', '{}', 'tlprogramauditdp', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'busuidatatable', '{name:''项目绩效审核'',checkbox:true,title:''项目绩效审核'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/program/report/edit'',tablecode1:''PERF_PROJECT_INFODP''}', 'datatable', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'header', '{}', 'header', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'buslefttree', '{}', 'lefttree', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/reportdp/audit', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');



delete from Bus_t_Pageconsole where url ='/pmkpi/program/reportdp/audit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/reportdp/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.doubleprocess.audit.TlpProgramAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', '', '', 0);



delete from bus_t_pagecomponent where id = 'pmkpi_tlprogramauditdp';
insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlprogramauditdp', '项目绩效审核', '', '项目绩效审核', '/pmkpi/doubleprocess/audit/tlprogramaudit.js', 'Ext.lt.pmkpi.doubleprocess.tlpauditservice', 'pmkpi', 'pmkpi.doubleprocess.TlpProgramAuditService');


delete from p#busfw_t_uitable where key = '/pmkpi/program/reportdp/audit';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BF4D5ADE06A03275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'V_PERF_PROJECT_INFODPVIEW', 0, 0, 0, '', '', 'pmkpi', '');


delete from p#Busfw_t_Uifunction where key = '/pmkpi/program/reportdp/audit';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB1663275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '审核信息', 1, 7, 'searchicon', 'tlprogramauditdp.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB1673275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '审核', 1, 1, '', 'tlprogramauditdp.audit', null, '审核', 'pmkpi', 'audit', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB1683275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '取消审核', 1, 2, '', 'tlprogramauditdp.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFA1002978E64124B5267B538D46F087', '/pmkpi/program/reportdp/audit', '查询', 0, 3, 'searchicon', 'tlprogramauditdp.query', null, '查询', 'pmkpi', 'query', '', '');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BF4D5ADDB16A3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', '审核情况', 1, 6, 'searchicon', 'tlprogramauditdp.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', '', '');


delete from p#busfw_t_uicolumn where key = '/pmkpi/program/reportdp/audit';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE99E73275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'WFSTATUS', '审核状态', 15, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE99E83275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'PRO_NAME', '项目名称', 2, 1, 0, null, '', null, 1, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE99E93275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'PRO_NAME', '名称', 3, 1, 0, 0, '', 0, 0, '', '', '', null, 100, 1, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE9A703275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'AGENCYGUID', '预算单位', 3, 1, 0, null, '', null, null, '', '#code-#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE9AB23275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'FININTORGGUID', '业务科室', 13, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE9AEA3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'YEAR', '预算年份', 4, 1, 0, null, '', null, 1, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE9B013275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'CREATER', '创建人', 14, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADE99D23275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'CREATE_TIME', '填报时间', 9, 1, 0, null, '', null, 1, '', 'yyyy-MM-dd hh:mm:ss', '', null, null, 0, 'd', '{}', '');


delete from p#busfw_t_uiqueryform where key = '/pmkpi/program/reportdp/audit';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADDB9DC3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'WFSTATUS', '审核状态', 2, 1, 'tree', '', null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', '', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BF4D5ADDBFCE3275E053C224280A22FC', '/pmkpi/program/reportdp/audit', 'PRO_NAME', '名称', 1, 1, 's', '', null, null, 'pmkpi', 'V_PERF_PROJECT_INFODP', '', null);


delete from p#busfw_t_uitabpage where key ='/pmkpi/program/reportdp/audit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D5ADED2FE3275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/audit', '待审核', 'waitaudit', 1, 1, 'choosed', 'tlprogramauditdp.clickTabpage', null, '待审核', '', '取消审核,审核信息', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D5ADED4BE3275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'tlprogramauditdp.clickTabpage', null, '已审核', '', '审核', '{}', '', '0', '', '', '', '', '', '', '');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BF4D5ADED4C53275E053C224280A22FC', 'pmkpi', '/pmkpi/program/reportdp/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'tlprogramauditdp.clickTabpage', null, '曾经办', '', '审核,取消审核', '{}', '', '0', '', '', '', '', '', '', '');

