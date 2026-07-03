begin

--页面组件
delete from bus_t_pageconsole where URL = '/pmkpi/program/report/adjustindex';

insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/adjustindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'mergeindexadjust', '{main:[tabpage,toolbutton,editform,datatable,befortable]}', null, null, null);

delete from bus_t_pageconsolecomconfig where URL = '/pmkpi/program/report/adjustindex';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/adjustindex', 'pmkpi_mergeindexadjustpro', '{}', 'mergeindexadjustpro', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/adjustindex', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/adjustindex', 'buseditform', '{}', 'editform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/adjustindex', 'busuidatatable', '{key:''/pmkpi/program/report/bgtindex'',headsort:false,addrow:false,nogroupbox:true,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/adjustindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/adjustindex', 'busuidatatable', '{name:''等级:'',checkbox:true,title:''等级:'',edit:true,addrow:false,rowtolist:false,headsort:false}', 'befortable', 'pmkpi', null);

delete from bus_t_pagecomponent where id ='pmkpi_mergeindexadjustpro';

insert into bus_t_pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_mergeindexadjustpro', '绩效目标指标合并项目变更', null, '绩效目标指标合并项目变更', '/pmkpi/perfprogram/prjindex/mergeindexadjustpro.js', 'Ext.lt.pmkpi.treeindexadjustpro', 'pmkpi', 'pmkpi.prjindex.MergeIndexAdjustService');


--ui配置按钮
delete from p#busfw_t_uifunction where KEY = '/pmkpi/program/report/adjustindex';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/report/adjustindex', '指标推荐', 1, 1, 'keepicon', 'mergeindexadjustpro.recom', null, '指标推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/report/adjustindex', '删除指标', 1, 4, 'keepicon', 'mergeindexadjustpro.del', null, '删除指标', 'pmkpi', 'del', null, null);


--ui配置页签
delete from p#busfw_t_uitabpage where KEY = '/pmkpi/program/report/adjustindex';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/report/adjustindex', '总体绩效指标', 'total', 1, 1, 'choosed', 'mergeindexadjustpro.clickTabpage', 0, '总体绩效指标', null, '复制总体绩效指标', '{hidebtn:''新增指标,修改指标,删除指标,挑选指标,复制上年指标,往年预算执行情况,查看评审意见,复制总体绩效指标,指标推荐''}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/report/adjustindex', '事前绩效评估', 'before', 1, 3, 'nomal', 'mergeindexadjustpro.clickTabpage', 0, '事前绩效评估', null, '指标推荐,新增指标,修改指标,删除指标,挑选指标,复制上年指标,往年预算执行情况,查看评审意见,复制总体绩效指标', '{}', null, '0', null, null, null, null, null, null, null);


--ui配置编辑区（目标）
delete from p#busfw_t_uieditform where KEY = '/pmkpi/program/report/adjustindex';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整前总体绩效目标', 'KPI_TARGET', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整后总体绩效目标', 'ADJUSTNDGOAL', 1, null, 0, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整说明', 'ADJUSTREMARK', 1, null, 1, null, 1, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'V_PERF_T_ADJUSTGOAL', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);


--ui配置列表（事前绩效）
delete from p#busfw_t_uitable where KEY = '/pmkpi/program/report/adjustindex';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'V_PERF_T_ADVEVAINFO', 0, 1, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn where KEY = '/pmkpi/program/report/adjustindex';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'PROJGUID', '项目ID', 2, 0, 0, 0, '0', 0, null, null, null, null, 0, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'ADV_EVA_INFO', '评估内容', 3, 1, 0, 0, '0', 0, null, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'EVALUATE_PROBLEM', '评估问题', 4, 1, 0, 0, '0', 0, null, null, null, null, 0, 400, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'WEIGHT', '权重', 5, 1, 0, 1, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'OPTION_VALUE', '调整前选项', 6, 1, 0, 0, '0', 0, null, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'UNIT_SINCE_SCORE', '调整前得分', 7, 1, 0, 1, '0', 1, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'SCORE_SHOWS', '自评得分说明', 8, 0, 1, 0, '0', 0, null, null, null, null, 0, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'ADJUST_OPT_VALUE', '调整后选项', 9, 1, 0, 0, '0', 0, null, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'ADJUST_SCORE', '调整后得分', 10, 1, 0, 0, '0', 0, null, null, null, null, 0, 50, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/adjustindex', 'ADJUSTREMARK', '调整说明', 11, 1, 1, 0, '0', 0, null, null, null, null, 0, 200, 0, 's', '{}', null);
  
    