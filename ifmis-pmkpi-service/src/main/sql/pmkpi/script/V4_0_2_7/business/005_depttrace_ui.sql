begin 
--广西 部门整体绩效监控 表字段注册
delete from bus_t_diccolumn t where tablecode ='PERF_T_PROMONITOR' and columncode in('FillCONTACTTYPE','FillMAN');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FillCONTACTTYPE', '1', '2020', '87', '26C179F1E09F2A9CE0530100007FE97F', 'FillCONTACTTYPE', 'PERF_T_PROMONITOR', '填报人联系方式', 'S', '30', null, 1, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'FillMAN', '1', '2020', '87', '16C179F1E09F2A9CE0530100007FE97F', 'FillMAN', 'PERF_T_PROMONITOR', '填报人', 'S', '30', null, 1, 1, null, sysdate);


 --广西 部门整体绩效监控填报 --预算执行情况 扩展备用资金字段
delete from busfw_t_uicolumn where key ='/pmkpi/dept/trace/report/edit/fund' and columncode in('AMT5','AMT7','AMT8');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT5', '备用资金字段1', 9, 0, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT7', '备用资金字段2', 10, 0, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/dept/trace/report/edit/fund', 'AMT8', '备用资金字段3', 11, 0, 1, 1, null, 0, 6, '[''预算执行情况'']', null, null, null, 100, 0, 'amt', null, null);



-- 广西：绩效指标完成情况 增加字段 （默认隐藏）
delete busfw_t_uicolumn where key ='/pmkpi/trace/report/deptedit/indextarget' and COLUMNCODE='COMPLETEANALYSCON';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/trace/report/deptedit/indextarget', 'COMPLETEANALYSCON', '全年预计完成情况', 8, 0, 1, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{}', null);


--广西部门整体绩效监控 新加一个 监控分析 页签，默认隐藏
delete from busfw_t_uitabpage where key ='/pmkpi/trace/report/deptedit' and code ='traceanalysis';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/trace/report/deptedit', '监控分析', 'traceanalysis', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '监控分析', null, null, '{busguid:''B760B51D6F9E6B86E0530100007F27AE''}', null, '0', 'analysisformaleditform', null, null, null, null, null, null);


delete from busfw_t_uieditform where key ='/pmkpi/trace/report/deptedit/analysis' and columncode ='PROBLEMS';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '实施存在的问题', 'PROBLEMS', 1, null, 1, null, 6, 3, '2', 'pmkpi', 1, null, '{}', null, null, null, null);



--广西：部门整体绩效监控填报 - 基本信息页签 编辑区与部门申报基本信息共用一个key，这里需要区分开
delete from bus_t_pageconsole where url ='/pmkpi/trace/report/deptedit/info';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/trace/report/deptedit/info', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprotrace.info.ProTraceInfoProPage', 'editInfo', '{main:[infoeditform,traceeditform]}', null, null, 0);

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/trace/report/deptedit/info';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'pmkpi_protraceinfo', '{}', 'protraceinfo', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'buseditform', '{key:''/pmkpi/report/deptedit/trace/info'',title:''部门项目信息'',tablecode:''v_perf_t_deptperfdeclare''}', 'infoeditform', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/trace/report/deptedit/info', 'buseditform', '{}', 'traceeditform', 'pmkpi', null);

--广西：部门整体绩效监控填报 - 基本信息编辑区添加字段，重新注册编辑区，与部门申报基本信息的key区分 
--从原来key里复制编辑区字段，只修改guid和key，其他值不变

delete from busfw_t_uieditform t where key ='/pmkpi/report/deptedit/trace/info';
insert into busfw_t_uieditform (GUID, key, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD)
select sys_guid(), '/pmkpi/report/deptedit/trace/info', TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD
from busfw_t_uieditform where key ='/pmkpi/deptperformance/report/edit';

--广西要求添加新字段 默认隐藏
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD)
values (sys_guid(), '/pmkpi/report/deptedit/trace/info', 'PERF_V_PROMONITOR', 's', '填报人', 'FillMAN', 0, null, 1, null, 18, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD)
values (sys_guid(), '/pmkpi/report/deptedit/trace/info', 'PERF_V_PROMONITOR', 's', '填报人联系方式', 'FillCONTACTTYPE', 0, null, 1, null, 19, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null);
