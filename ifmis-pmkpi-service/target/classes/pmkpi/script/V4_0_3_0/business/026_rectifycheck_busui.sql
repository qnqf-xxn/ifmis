begin

--部门绩效申报填报-填报
delete from p#busfw_t_uitabpage where key ='/pmkpi/deptperformance/report/edit' and code = 'deptperftest';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/edit', '部门整体绩效(试点)', 'deptperftest', 0, 18, 'nomal', 'tabfreamedit.clickTabpage', null, '部门整体绩效(试点)', null, null, '{busguid:''DE67AEC7AF8E2576E0533315A8C0165D'',action:''deptperftest.save'',url:''/pmkpi/deptperformance/report/deptperftest.page''}', null, '0', 'deptperftestiframe', null, null, null, null, null, null);

--页签
delete from busfw_t_uitabpage where key ='/pmkpi/deptperformance/report/deptperftest';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/deptperftest', '中长期绩效', 'total', 1, 1, 'choosed', 'deptperftest.clickTabpage', 0, '中长期绩效', null, null, '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/report/deptperftest', '年度绩效', 'year', 1, 2, 'nomal', 'deptperftest.clickTabpage', 0, '年度绩效', null, null, '{}', null, '0', null, null, null, null, null, null, null);
--ui表注册
delete from busfw_t_uitable where key = '/pmkpi/deptperformance/report/deptperftest';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'V_BGT_PERF_INDICATOR', 0, 0, 0, null, null, 'pmkpi', null);
--ui展示列注册
delete from busfw_t_uicolumn where key = '/pmkpi/deptperformance/report/deptperftest'; 
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'OBLIGATE1', '操作', 1, 1, 0, 0, null, 0, null, null, null, null, null, 90, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'LV1_PERF_IND_NAME', '一级指标名称', 2, 1, 0, 0, null, 1, null, '[''指标名称'']', null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'LV2_PERF_IND_NAME', '二级指标名称', 3, 1, 1, 0, null, 1, null, '[''指标名称'']', null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'NAME', '三级指标', 4, 1, 1, 0, null, 1, null, '[''指标名称'']', null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'COMPUTESIGN', '计算符号', 5, 1, 1, 0, null, 1, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'INDEXVAL', '指标值', 6, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'METERUNIT', '计量单位', 7, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'INDEXSTANDARDS', '指标值确定依据', 8, 1, 1, 0, null, 0, null, null, '#name', null, null, 200, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'KPI_REMARK', '备注', 9, 1, 1, 0, null, 0, null, null, null, null, null, 200, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'KPI_CONTENT', '指标内容', 10, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'KPI_EVALSTD', '评(扣)分标准', 11, 1, 1, 0, null, 1, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'INDEXCATLEV', '指标分级', 12, 1, 1, 0, null, 0, null, null, '#code-#name', null, null, 150, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'QNINDEXVAL', '前年指标值', 21, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{show:''year''}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'SNINDEXVAL', '上年指标值', 22, 1, 1, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{show:''year''}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'LEVELNO', '级次', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'SINDEX', '二级指标', 23, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'WEIGHT', '权重', 24, 0, 0, 1, null, 0, null, null, null, null, null, 100, 0, 'amt', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'GUID', 'GUID', 25, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'FINDEX', '一级指标', 26, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/report/deptperftest', 'SUPERID', 'SUPERID', 27, 0, 0, 0, null, 0, null, null, null, null, null, 150, 0, 's', '{}', null);

