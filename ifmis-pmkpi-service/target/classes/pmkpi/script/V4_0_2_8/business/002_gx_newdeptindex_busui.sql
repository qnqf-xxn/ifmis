begin

--绩效指标页签增加按钮
delete from busfw_t_uifunction where key ='/pmkpi/program/report/treeindex' and name in('引用指标','清空指标');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/report/treeindex', '引用指标', 1, 11, 'keepicon', 'prjtreeindex.refindi', null, '引用指标', 'pmkpi', 'refindi', null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/report/treeindex', '清空指标', 1, 12, 'keepicon', 'prjtreeindex.clear', null, '清空指标', 'pmkpi', 'clear', null, null);

--引用指标
--ui表
delete from busfw_t_uitable where key = '/pmkpi/program/prjindex/refindi';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', null);
--展示列
delete from busfw_t_uicolumn where key = '/pmkpi/program/prjindex/refindi';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'KPI_VAL', '参考值', 13, 1, 0, 0, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'NAME', '内容', 14, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'COMPUTESIGN', '性质', 15, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'INDEXVALUE', '参考值', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'METERUNIT', '单位', 17, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'VALUE_CHANGE', '指标值变动情况', 18, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'INDEXCATEGORIES', '行业大类', 19, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'INDUSTRYCATEGORY', '行业类别', 20, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'FUNDUSE', '资金用途', 21, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'KEYWORD', '关键词', 22, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'VALUE_REMARK', '参考指标值', 23, 0, 1, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'GUID', 'guid', 24, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'INDEXSTANDARDS', '指标值设定依据', 25, 0, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/prjindex/refindi', 'COMPUTETYPE', '计算公式', 26, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);
--页签
delete from busfw_t_uitabpage where key = '/pmkpi/program/prjindex/refindi';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/prjindex/refindi', '案例模板', 'case', 1, 1, 'choosed', 'pmkpirefindi.clicktab', 0, '案例模板', null, null, '{qf:["code"]}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/prjindex/refindi', '共性模板', 'mode', 1, 2, 'nomal', 'pmkpirefindi.clicktab', 0, '共性模板', null, null, '{qf:["name"]}', null, '0', null, null, null, null, null, null, null);
--查询区
-- delete from p#busfw_t_uiqueryform where key = '/pmkpi/program/prjindex/refindi';
-- insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
-- values ('E2B9268C87A20BB6E0533315A8C01A01', '/pmkpi/program/prjindex/refindi', 'name', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);
-- insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
-- values ('E2B9268C87A30BB6E0533315A8C01A01', '/pmkpi/program/prjindex/refindi', 'code', '编码', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);





