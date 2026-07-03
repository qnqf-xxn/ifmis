begin

delete from p#busfw_t_uitabpage t where t.KEY='/pmkpi/deptperformance/deptperf/recomindex';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/deptperformance/deptperf/recomindex', '推荐指标', 'index', 1, 1, 'choosed', 'pmkpideptrecomindex.clicktab', 0, '推荐指标', null, null, null, null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uiqueryform t where t.KEY='/pmkpi/deptperformance/deptperf/recomindex';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'name', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'code', '编码', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);

delete from p#busfw_t_uifunction t where t.KEY='/pmkpi/deptperformance/deptperf/recomindex';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', '查询', 0, 1, 'addicon', 'pmkpideptrecomindex.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', '确定', 1, 2, 'addicon', 'pmkpideptrecomindex.addindex', null, '确定', 'pmkpi', 'addindex', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', '取消', 1, 3, 'delicon', 'pmkpideptrecomindex.closewin', null, '取消', 'pmkpi', 'closewin', null, null);

delete from p#busfw_t_uitable t where t.KEY='/pmkpi/deptperformance/deptperf/recomindex';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.KEY='/pmkpi/deptperformance/deptperf/recomindex';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'FINDEX', '一级指标', 1, 1, 0, 0, '0', 0, 1, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'SINDEX', '二级指标', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'NAME', '指标名称', 3, 1, 0, 0, '0', 1, 1, null, null, null, null, 190, 0, 's', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'COMPUTESIGN', '计算符号', 4, 1, 0, 0, '0', 0, 0, null, '#name', null, 0, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'INDEXVALUE', '参考指标值', 5, 0, 0, 0, '0', 0, 0, null, null, null, null, null, 0, 's', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'METERUNIT', '计量单位', 6, 1, 0, 0, '0', 0, 0, null, null, null, 0, 80, 0, 's', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'PLANVAL', '计划标准', 7, 1, 0, 0, '0', 0, 0, null, null, null, 0, 80, 0, 's', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'EXPLAIN', '指标解释', 8, 1, 0, 0, '0', 0, 1, null, null, null, 0, 80, 0, 's', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'FILED', '职能', 9, 1, 0, 0, '0', 0, 1, null, null, null, 0, 80, 0, 's', '{}', '0');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/deptperformance/deptperf/recomindex', 'OCCUPATION', '活动', 10, 1, 0, 0, '0', 0, 1, null, null, null, 0, 80, 0, 's', '{}', '0');
