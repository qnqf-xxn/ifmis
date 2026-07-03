begin
  delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptperformance/report/deptperf';
  delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/deptperformance/report/deptperf';
  delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_deptperf';
  
  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/deptperformance/report/deptperf', 'pmkpi_deptperf', '{}', 'deptperf', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/deptperformance/report/deptperf', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/deptperfgoal'',addrow:true,headsort:false,name:''部门整体绩效目标'',edit:true,checkbox:false,radio:true,title:''部门整体绩效目标'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/deptperformance/report/deptperf', 'busuidatatable', '{headsort:false,addrow:false,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/deptperformance/report/deptperf', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

  insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
  values ('/pmkpi/deptperformance/report/deptperf', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.deptperformance.deptperf.DeptPerfHbPage', 'index', '{main:[tabpage,maintable,datatable]}', null, null, null);

  insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
  values ('pmkpi_deptperf', '湖北部门绩效', null, '湖北部门绩效', '/buscommon/fileimport/js/import.js,/pmkpi/deptperformance/deptperfhb.js', 'Ext.lt.pmkpi.deptperf', 'pmkpi', 'pmkpi.deptperformance.deptperf.DeptPerfHbService');

  delete FROM Busfw_t_Uitabpage t where t.key = '/pmkpi/deptperformance/report/deptperf';
  delete FROM Busfw_t_Uitable t where t.key = '/pmkpi/deptperformance/report/deptperfgoal';
  delete FROM Busfw_t_Uicolumn t where t.key = '/pmkpi/deptperformance/report/deptperfgoal';
  delete FROM Busfw_t_Uitable t where t.key = '/pmkpi/deptperformance/report/deptperf';
  delete FROM Busfw_t_Uicolumn t where t.key = '/pmkpi/deptperformance/report/deptperf';
  
  insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
  values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/deptperf', '中长期绩效', 'total', 1, 1, 'choosed', 'deptperf.clickTabpage', 0, '中长期绩效', null, null, '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

  insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
  values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/deptperf', '年度绩效', 'year', 1, 2, 'nomal', 'deptperf.clickTabpage', 0, '年度绩效', null, null, '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');
  
  insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperfgoal', 'V_BGT_PERF_GOAL_INFO', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');
  
  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperfgoal', 'DEPT_CODE', '部门', 6, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperfgoal', 'GOALNAME', '名称', 2, 1, 0, 0, null, 1, 1, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperfgoal', 'KPI_TARGET', '目标', 4, 1, 1, 0, null, 1, 1, null, null, null, null, 500, 0, 's', null, null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperfgoal', 'KPI_DEP_ID', '主键', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');
  
  insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'V_BGT_PERF_INDICATOR', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');
  
  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'COMPUTESIGN', '计算符号', 9, 1, 1, 0, null, 1, null, null, '#name', null, null, 100, 1, 'tree', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'KPI_EVALSTD', '评(扣)分标准', 28, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'KPI_CONTENT', '指标内容', 27, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'KPI_REMARK', '备注', 19, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'METERUNIT', '计量单位', 11, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'WEIGHT', '权重', 16, 0, 0, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'QNINDEXVAL', '前年指标值', 5, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{show:''year''}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'SNINDEXVAL', '上年指标值', 6, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{show:''year''}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 90, 0, 's', '{}', null, '87', '2016');

  insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/deptperformance/report/deptperf', 'INDEXSTANDARDS', '指标值确定依据', 13, 1, 1, 0, null, 0, null, null, '#name', null, null, 200, 1, 'tree', '{}', null, '87', '2016');

