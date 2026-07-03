begin
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/adjust/report/deptperf';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptperf', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptperf', 'busuidatatable', '{headsort:false,addrow:false,edit:true,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,nogroupbox:true,rowtolist:false}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptperf', 'busuidatatable', '{key:''/pmkpi/adjust/report/deptperfgoal'',addrow:true,headsort:false,name:''部门整体绩效目标'',edit:true,checkbox:false,radio:true,title:''部门整体绩效目标'',nextSibling:false,rowtolist:false}', 'maintable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptperf', 'pmkpi_dtadjperf', '{}', 'dtadjperf', 'pmkpi', null);

delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_dtadjperf';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_dtadjperf', '湖北部门绩效调整', null, '湖北部门绩效调整', '/pmkpi/adjust/deptadjperf/dtperfadj.js', 'Ext.lt.pmkpi.dtperfadj', 'pmkpi', 'pmkpi.adjust.deptadjperf.DtPerfAdjService');

delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/adjust/report/deptperf';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptperf', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.deptadjperf.DtPerfAdjPage', 'index', '{main:[tabpage,maintable,datatable]}', null, null, null);

delete FROM Busfw_t_Uitable t where t.key in ('/pmkpi/adjust/report/deptperfgoal','/pmkpi/adjust/report/deptperf');
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('E44BDA2E5CA37072E0533315A8C039CE', '/pmkpi/adjust/report/deptperf', 'V_PERF_T_ADJUSTINDEX', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('E44BDA2E5C9F7072E0533315A8C039CE', '/pmkpi/adjust/report/deptperfgoal', 'V_PERF_T_ADJUSTGOAL', 0, 0, 0, null, null, 'pmkpi', null, '87', '2016');

delete FROM Busfw_t_Uicolumn t where t.key in ('/pmkpi/adjust/report/deptperfgoal','/pmkpi/adjust/report/deptperf');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E44BDA2E5CA47072E0533315A8C039CE', '/pmkpi/adjust/report/deptperfgoal', 'KPI_DEP_ID', '主键', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E44BDA2E5CA37072E0533315A8C039CE', '/pmkpi/adjust/report/deptperfgoal', 'KPI_TARGET', '目标(调整前)', 4, 1, 1, 0, null, 1, 1, null, null, null, null, 500, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E44BDA2E5CA27072E0533315A8C039CE', '/pmkpi/adjust/report/deptperfgoal', 'GOALNAME', '名称', 3, 1, 0, 0, null, 1, 1, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E44BDA2E5CA17072E0533315A8C039CE', '/pmkpi/adjust/report/deptperfgoal', 'DEPT_CODE', '部门', 6, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E44BDA2E5CA57072E0533315A8C039CE', '/pmkpi/adjust/report/deptperfgoal', 'ADJUSTNDGOAL', '目标(调整后)', 5, 1, 1, 0, null, 1, 1, null, null, null, null, 500, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D4154BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'QNINDEXVAL', '前年指标值', 5, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{show:''year''}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D4654BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperfgoal', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3554BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'INDEXVAL', '指标值', 10, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3454BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'COMPUTESIGN', '计算符号', 9, 1, 1, 0, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3354BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'EXPLAIN', '公式或说明', 4, 0, 0, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3254BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'NAME', '指标名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D4554BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperfgoal', 'STATUS', '数据状态', 2, 1, 0, 0, null, 0, null, null, '#name', null, null, 80, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D4054BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'STATUS', '数据状态', 2, 1, 0, 0, null, 0, null, null, '#name', null, null, 80, 1, 'tree', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3F54BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3654BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'METERUNIT', '计量单位', 11, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3754BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'ADJUSTINDEXVAL', '调整后指标值', 11, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3854BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'LEVELNO', '级次', 12, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3954BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'WEIGHT', '权重', 16, 0, 0, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3A54BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'ISLINKED', '是否为与预算总额挂钩产出指标', 17, 0, 0, 0, null, 0, null, null, '#name', null, null, 120, 1, 'tree', '{}', null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3B54BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'RULE', '赋分原则', 18, 0, 0, 0, null, 0, 6, null, null, null, null, 180, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3C54BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'KPI_REMARK', '目标值说明', 19, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3D54BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'ADJUSTREMARK', '调整说明', 20, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3E54BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'FINDEX', '一级指标', 22, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3F56BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3F57BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3F58BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'SUPERID', 'SUPERID', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3F59BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'KPI_CONTENT', '指标内容', 27, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D3F54BAE1533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'KPI_EVALSTD', '扣分标准', 28, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', null, null, '87', '2016');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('E45C13043D4254BAE0533315A8C029D0', '/pmkpi/adjust/report/deptperf', 'SNINDEXVAL', '上年指标值', 6, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{show:''year''}', null, '87', '2016');

delete FROM Busfw_t_Uitabpage t where t.key = '/pmkpi/adjust/report/deptperf';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('E45C13043D4454BAE0533315A8C029D0', 'pmkpi', '/pmkpi/adjust/report/deptperf', '年度绩效', 'year', 1, 2, 'nomal', 'dtadjperf.clickTabpage', 0, '年度绩效', null, null, '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('E45C13043D4354BAE0533315A8C029D0', 'pmkpi', '/pmkpi/adjust/report/deptperf', '中长期绩效', 'total', 1, 1, 'choosed', 'dtadjperf.clickTabpage', 0, '中长期绩效', null, null, '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');
