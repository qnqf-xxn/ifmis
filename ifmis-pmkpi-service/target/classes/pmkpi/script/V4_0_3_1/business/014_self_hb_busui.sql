begin

--湖北-自评填报页签
delete from busfw_t_uitabpage where key = '/pmkpi/perfself/apply/dept/edit' and code in ('selfanaly','selfindexdept');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '自评分析', 'selfanaly', 0, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '自评分析', null, null, '{url:''/pmkpi/perfself/apply/editdept/selfanaly.page'',action:''selfanaly.save''}', null, '0', 'analyiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '指标完成情况(湖北)', 'selfindexdept', 0, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '指标完成情况(湖北)', null, null, '{url:''/pmkpi/perfself/apply/editdept/selfindexhb.page'',action:''selfindexdept.save''}', null, '0', 'indexdeptiframe', null, null, null, null, null, null);

--自评分析-编辑区
delete from busfw_t_uieditform where key ='/pmkpi/perfself/apply/editdept/selfanaly';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfanaly', 'V_PERF_SELFDEPTDESC', 'textarea', '偏差大或目标未完成的原因分析', 'UNFINISHEDANALY', 1, null, 0, null, 9, 3, '4', 'pmkpi', 1, null, '{}', null, null, null, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/selfanaly', 'V_PERF_SELFDEPTDESC', 'textarea', '改进措施及结果应用方案', 'RECTIFICPLAN', 1, null, 0, null, 10, 3, '4', 'pmkpi', 1, null, '{}', null, null, null, null);

--指标完成情况(湖北)-busui
--目标
delete from busfw_t_uitable where key = '/pmkpi/perfself/apply/editdept/hbgoal';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbgoal', 'V_BGT_PERF_GOAL_INFO', 0, 0, 0, null, null, 'pmkpi', '{}');

delete from busfw_t_uicolumn where key = '/pmkpi/perfself/apply/editdept/hbgoal';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbgoal', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbgoal', 'KPI_TARGET', '年度绩效目标', 1, 1, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

--指标
delete from busfw_t_uitable where key = '/pmkpi/perfself/apply/editdept/hbindex';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'V_PERF_T_SELFPERFINDEX', 0, 1, 0, null, null, 'pmkpi', null);

delete from busfw_t_uicolumn where key = '/pmkpi/perfself/apply/editdept/hbindex';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'NAME', '指标名称', 2, 1, 0, 0, '0', 0, 6, null, null, null, 0, 180, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'COMPUTESIGN', '计算符号', 3, 1, 0, 0, '0', 0, 6, null, '#name', null, 0, 100, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'INDEXVAL', '指标值', 4, 1, 0, 0, '0', 0, 6, null, null, null, 0, 180, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'ACTUALVALUE', '实际完成值', 5, 1, 1, 0, '0', 1, 6, null, null, null, 0, 150, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'METERUNIT', '计量单位', 6, 1, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'WEIGHT', '权重设定值', 7, 0, 0, 1, '0', 0, 6, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'ACTUALWEIGHT', '权重', 8, 1, 1, 1, '0', 0, 6, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'SCORE', '实际得分', 9, 1, 1, 1, '0', 0, 6, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/editdept/hbindex', 'KPI_REMARK', '偏差原因及改进措施', 10, 0, 1, 0, '0', 0, 6, null, null, null, 0, 200, 0, 's', '{}', null);

--导出部门整体自评表（湖北）
delete from busfw_t_uifunction where key =  '/pmkpi/perfself/query/index' and name = '导出部门整体自评表（湖北）';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/query/index', '导出部门整体自评表（湖北）', 0, 10, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出部门整体自评表（湖北）', 'pmkpi', 'expxls', null, '{tempatecode:''hbbmztzpdc''}');




