begin

delete from bus_t_Dictable where tablecode = 'PERF_T_SUPERVISION';
insert into bus_t_Dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'PERF_T_SUPERVISION', '绩效目标监审', '绩效目标监审', 2, 1, 'PERF_T_SUPERVISION', 'gl', '', '0', 1, '0', 1, 1, 'V_PERF_T_SUPERVISION', sysdate, 1, null, '', '1');


delete from bus_t_Diccolumn where tablecode = 'PERF_T_SUPERVISION';
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIADJUSTOPINION', null, '0', 'ADJOPTION', '1', '2017', '1500', '50E7AEB20E9E44DA8C0808FE95D250B2', 'ADJOPTION', 'PERF_T_SUPERVISION', '调整意见', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'AUDITOR', '1', '2017', '1500', '50E7AEB60E9E44DA8C0808FE95D250B2', 'AUDITOR', 'PERF_T_SUPERVISION', '审核人', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATER', '1', '2017', '1500', '510E24FD6F584774AE2EF01733F68386', 'CREATER', 'PERF_T_SUPERVISION', '创建人', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATETIME', '1', '2017', '1500', '4D47D90E45A4418F93C8E51D7F5F7850', 'CREATETIME', 'PERF_T_SUPERVISION', '创建时间', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'GUID', '1', '2017', '1500', '31714B75A8864276AB4C95CC89DA6057', 'GUID', 'PERF_T_SUPERVISION', 'GUID', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LASTUPDATETIME', '1', '2017', '1500', '50E7AE560E9E44DA8C0808FE95D250B2', 'LASTUPDATETIME', 'PERF_T_SUPERVISION', '最后更新时间', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIPRODETAIL', null, '0', 'MAINGUID', '1', '2017', '1500', '60B595B0641C4670A8A4D7F213A4BDBD', 'MAINGUID', 'PERF_T_SUPERVISION', '项目GUID', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPTIONS', '1', '2017', '1500', '332E2BD000EA4FB0836919E66A504FB8', 'OPTIONS', 'PERF_T_SUPERVISION', '其他意见（审核意见）', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'WFID', '1', '2017', '1500', '3103C10A93914E918FD54448B9B4467A', 'WFID', 'PERF_T_SUPERVISION', '审核流程', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIWFSTATUS', null, '0', 'WFSTATUS', '1', '2017', '1500', '09635790DE7B42B28373C4251187637A', 'WFSTATUS', 'PERF_T_SUPERVISION', '审核状态', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'YEAR', '1', '2017', '1500', '0A4A9E01279D4413A802A9F26ACA6746', 'YEAR', 'PERF_T_SUPERVISION', '年', null, '32', null, null, 1, null, sysdate);


delete from bus_t_Dictable where tablecode = 'V_PERF_T_SUPERVISIONVIEW';
insert into bus_t_Dictable (YEAR, PROVINCE, TABLECODE, NAME, REMARK, TABLETYPE, VERSION, DBTABNAME, APPID, EXP, TABLEPART, ISSHOW, DBIMPFLAG, ISSYS, ISUSES, VIEWTABLENAME, DBVERSION, DATASYNC, HASTRIGGER, SYNCCLASSNAME, STATUS)
values ('2016', '87', 'V_PERF_T_SUPERVISIONVIEW', '绩效目标监审视图', '绩效目标监审视图', 2, 1, 'V_PERF_T_SUPERVISIONVIEW', 'pmkpi', '', '0', 1, '0', 1, 1, 'V_PERF_T_SUPERVISIONVIEW', sysdate, 1, null, '', '1');


delete from bus_t_Diccolumn where tablecode = 'V_PERF_T_SUPERVISIONVIEW';
insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'ADDINDEX', '1', '2017', '1500', '31714275A3864276AB4C95CC89DA6057', 'ADDINDEX', 'V_PERF_T_SUPERVISIONVIEW', '是否新增', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIADJUSTOPINION', null, '0', 'ADJOPTION', '1', '2017', '1500', '50E7A1B20E9E44DA8C0808FE95D250B2', 'ADJOPTION', 'V_PERF_T_SUPERVISIONVIEW', '调整意见', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values ('VD00010', 'PMKPIAGENCYALLPAY', null, '0', 'AGENCYGUID', '1', '2017', '1500', '31704B7508864276AB4C95CC89DA6057', 'AGENCYGUID', 'V_PERF_T_SUPERVISIONVIEW', '单位', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'AUDITOR', '1', '2017', '1500', '50E7A2B60E9E44DA8C0808FE95D250B2', 'AUDITOR', 'V_PERF_T_SUPERVISIONVIEW', '审核人', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATER', '1', '2017', '1500', '510E23FD6F584774AE2EF01733F68386', 'CREATER', 'V_PERF_T_SUPERVISIONVIEW', '创建人', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CREATETIME', '1', '2017', '1500', '4D47D40E45A4418F93C8E51D7F5F7850', 'CREATETIME', 'V_PERF_T_SUPERVISIONVIEW', '创建时间', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'CSID', '1', '2017', '1500', '31714475A5864276AB4C95CC89DA6057', 'CSID', 'V_PERF_T_SUPERVISIONVIEW', '处室', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'DEPT', '1', '2017', '1500', '31714375A4864276AB4C95CC89DA6057', 'DEPT', 'V_PERF_T_SUPERVISIONVIEW', '部门', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'GUID', '1', '2017', '1500', '31714575A8864276AB4C95CC89DA6057', 'GUID', 'V_PERF_T_SUPERVISIONVIEW', 'GUID', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIFRAME', null, '0', 'KPI_LV1', '1', '2017', '1500', '31764B7578864276AB4C95CC89DA6057', 'KPI_LV1', 'V_PERF_T_SUPERVISIONVIEW', '一级指标', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIFRAME', null, '0', 'KPI_LV2', '1', '2017', '1500', '31774B7588864276AB4C95CC89DA6057', 'KPI_LV2', 'V_PERF_T_SUPERVISIONVIEW', '二级指标', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'KPI_LV3', '1', '2017', '1500', '31784B7598864276AB4C95CC89DA6057', 'KPI_LV3', 'V_PERF_T_SUPERVISIONVIEW', '三级指标', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'KPI_VAL', '1', '2017', '1500', '31794B75A1864276AB4C95CC89DA6057', 'KPI_VAL', 'V_PERF_T_SUPERVISIONVIEW', '指标值', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'LASTUPDATETIME', '1', '2017', '1500', '50E7A6560E9E44DA8C0808FE95D250B2', 'LASTUPDATETIME', 'V_PERF_T_SUPERVISIONVIEW', '最后更新时间', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIPRODETAIL', null, '0', 'MAINGUID', '1', '2017', '1500', '60B597B0641C4670A8A4D7F213A4BDBD', 'MAINGUID', 'V_PERF_T_SUPERVISIONVIEW', '项目GUID', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'OPTIONS', '1', '2017', '1500', '332E28D000EA4FB0836919E66A504FB8', 'OPTIONS', 'V_PERF_T_SUPERVISIONVIEW', '其他意见（审核意见）', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PROAMT', '1', '2017', '1500', '31754B7568864276AB4C95CC89DA6057', 'PROAMT', 'V_PERF_T_SUPERVISIONVIEW', '项目资金', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PROJTYPE', '1', '2017', '1500', '31714675A7864276AB4C95CC89DA6057', 'PROJTYPE', 'V_PERF_T_SUPERVISIONVIEW', '监审项目类别', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRONAME', '1', '2017', '1500', '31734B7548864276AB4C95CC89DA6057', 'PRONAME', 'V_PERF_T_SUPERVISIONVIEW', '项目名称', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'PRO_CODE', '1', '2017', '1500', '31744B7558864276AB4C95CC89DA6057', 'PRO_CODE', 'V_PERF_T_SUPERVISIONVIEW', '项目编码', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'WEIGHT', '1', '2017', '1500', '31714175A2864276AB4C95CC89DA6057', 'WEIGHT', 'V_PERF_T_SUPERVISIONVIEW', '权重', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'WFID', '1', '2017', '1500', '3103C90A93914E918FD54448B9B4467A', 'WFID', 'V_PERF_T_SUPERVISIONVIEW', '审核流程', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'YEAR', '1', '2017', '1500', '0A4A9101279D4413A802A9F26ACA6746', 'YEAR', 'V_PERF_T_SUPERVISIONVIEW', '年', null, '32', null, null, 1, null, sysdate);

insert into bus_t_Diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'YJPRONAME', '1', '2017', '1500', '31714575A6864276AB4C95CC89DA6057', 'YJPRONAME', 'V_PERF_T_SUPERVISIONVIEW', '一级项目', null, '32', null, null, 1, null, sysdate);



delete from Bus_t_Pageconsolecomconfig where url = '/pmkpi/supervision/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'perf_supervision', '{}', 'supervision', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'busuidatatable', '{name:''绩效目标监审'',checkbox:true,title:''绩效目标监审'',edit:false,addrow:false}', 'datatable', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'header', '{}', 'header', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'busdclefttree', '{}', 'lefttree', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'bustabpage', '{}', 'tabpage', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/index', 'dataexport', '{}', 'dataexport', 'pmkpi', '');


delete from Bus_t_Pageconsole where url = '/pmkpi/supervision/index';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/supervision/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSupervision.PerfSupervisionPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', '', '', 0);



delete from Bus_t_Pagecomponent where id = 'perf_supervision';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_supervision', '绩效目标监审', '', '绩效目标监审', '/pmkpi/perfSupervision/supervision.js', 'Ext.lt.pmkpi.perfSupervision.index', 'pmkpi', 'pmkpi.perfSupervision.PerfSupervisionService');




delete from Bus_t_Pageconsolecomconfig where url = '/pmkpi/supervision/multiUpdate';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/multiUpdate', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/multiUpdate', 'buseditform', '{}', 'editform', 'pmkpi', '');

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/supervision/multiUpdate', 'perf_supervisionUpdate', '{}', 'supervisionUpdate', 'pmkpi', '');




delete from Bus_t_Pageconsole where url = '/pmkpi/supervision/multiUpdate';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/supervision/multiUpdate', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', '', '', 'pmkpi', 'gov.mof.fasp2.pmkpi.perfSupervision.PerfSupervisionPage', 'updateIndex', '{main:[toolbutton,editform]}', '', '', 0);



delete from Bus_t_Pagecomponent where id = 'perf_supervisionUpdate';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('perf_supervisionUpdate', '批量修改监审意见', '', '批量修改监审意见', '/pmkpi/perfSupervision/supervisionUpdate.js', 'Ext.lt.pmkpi.perfSupervision.updateIndex', 'pmkpi', 'pmkpi.perfSupervision.PerfSupervisionUpdateService');




delete from Fasp_t_Dicdssource where code = 'PMKPIWFSTATUS';
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIWFSTATUS', 'PMKPIWFSTATUS', 'PMKPIWFSTATUS', '工作流状态-绩效', '1', '', '', '', '2020', '87', '', '201901', '', '2', 'select * from pmkpi_t_wfstatus', '', 1, 'pmkpi');

delete from Fasp_t_Dicdssource where code = 'PMKPIADJUSTOPINION';
insert into Fasp_t_Dicdssource (GUID, CODE, ELEMENTCODE, NAME, STATUS, CREATETIME, STARTTIME, ENDTIME, YEAR, PROVINCE, CRC, TYPEGUID, SHOWSTRUCT, SOURCETYPE, DATASOURCE, DBVERSION, VERSION, APPID)
values ('PMKPIADJUSTOPINION', 'PMKPIADJUSTOPINION', 'PMKPIADJUSTOPINION', '调整审核意见', '1', '20180424221721795', '20180424', '', '', '', '', '201901', '', '1', '[{guid:"1",code:1,name:"指标不够完整"},{guid:"2",code:2,name:"指标不够细化、量化"},{guid:"3",code:3,name:"指标与项目的相关性不够"},{guid:"4",code:4,name:"指标与指标值不匹配"},{guid:"5",code:5,name:"建议拆分指标"},{guid:"6",code:6,name:"一级指标类型错误"},{guid:"7",code:7,name:"二级指标类型错误"},{guid:"8",code:8,name:"建议增加明确效益指标"},{guid:"9",code:9,name:"建议增加明确产出指标"},{guid:"10",code:10,name:"建议增加满意度指标"},{guid:"11",code:11,name:"其他"}]', sysdate, 1, 'pmkpi');
