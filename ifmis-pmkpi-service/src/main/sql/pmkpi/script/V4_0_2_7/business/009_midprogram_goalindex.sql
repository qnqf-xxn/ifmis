begin

delete from p#busfw_t_uitabpage where key = '/pmkpi/midprogram/report/edit' and code = 'goalandindex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/midprogram/report/edit', '年度绩效(湖北)', 'goalandindex', 0, 4, 'nomal', 'pmkpimidprogramedit.clickTabpage', null, '年度绩效(湖北)', null, null, '{url:''/pmkpi/program/report/goalandindex.page?showtab=1'||chr(38)||'isedittotal=1'',action:''goalandindex.save'',busguid:''2AA2F7C3AA54442AB529CEBA1DABAF96''}', null, '0', 'goalandindexiframe', null, null, null, null, null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/midprogram/query/list' and config like '%hbyjxmjxmbsbb%';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/midprogram/query/list', '导出报告(湖北)', 0, 9, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告(湖北)', 'pmkpi', 'expxls', null, '{tempatecode:''hbyjxmjxmbsbb''}');



delete from p#busfw_t_uifunction where key = '/pmkpi/yearprogram/query/list' and config like '%hbejxmjxmbsbb%';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', '导出报告(湖北)', 0, 7, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告(湖北)', 'pmkpi', 'exphbxlsx', null, '{tempatecode:''hbejxmjxmbsbb''}');



delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/treeindex' and columncode in ('REFERENCESTANDARDS','INDEXSTANDARDS');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'REFERENCESTANDARDS', '参考值确定依据', 51, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/treeindex', 'INDEXSTANDARDS', '指标值确定依据', 51, 0, 1, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);


delete from p#busfw_t_uitabpage t  where key = '/pmkpi/yearprogram/query/edit' and code = 'goalandindex';

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/yearprogram/query/edit', '年度绩效(湖北)', 'goalandindex', 0, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '年度绩效(湖北)', null, null, '{url:''/pmkpi/program/report/goalandindex.page?showtab=1'||chr(38)||'isedittotal=1'',action:''goalandindex.save'',busguid:''2AA2F7C3AA54442AB529CEBA1DABAF96''}', null, '0', 'goalandindexiframe', null, null, null, null, null, null);



delete from p#busfw_t_uitabpage where key = '/pmkpi/program/report/goalandindex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/report/goalandindex', '总体绩效目标', 'total', 1, 1, 'choosed', 'goalandindex.clickTabpage', 0, '总体绩效目标', null, '查看评审意见,复制总体绩效指标,复制上年指标', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/program/report/goalandindex', '年度绩效目标', 'year', 1, 2, 'nomal', 'goalandindex.clickTabpage', 0, '年度绩效目标', null, '复制年度绩效指标', '{}', null, '0', null, null, null, null, null, null, null);




delete from bus_t_diccolumn where tablecode = 'PM_PERF_INDICATOR' and columncode in ('INDEXSTANDARDS','REFERENCESTANDARDS');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'INDEXSTANDARDS', null, '1', 'INDEXSTANDARDS', '1', '2016', '87', 'A2F2BC69B1F00D7A96FFEBF7CA42B124', 'INDEXSTANDARDS', 'PM_PERF_INDICATOR', '指标值确定依据', 'S', '2000', null, 1, 0, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'REFERENCESTANDARDS', '1', '2016', '87', '3581608267B8EB52887A319ECD4E4B61', 'REFERENCESTANDARDS', 'PM_PERF_INDICATOR', '参考值确定依据', 'S', '2000', null, 1, 0, null, sysdate);


delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/hbprotabgoal';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/hbprotabgoal', 'GUID', '主键', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/hbprotabgoal', 'KPI_TARGET', '目标', 3, 1, 1, 0, null, 1, 1, null, null, null, null, 500, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/program/report/hbprotabgoal', 'GOALNAME', '名称', 2, 1, 0, 0, null, 1, 1, null, null, null, null, 200, 0, 's', null, null);



delete from  p#busfw_t_uifunction t where key = '/pmkpi/index/audit' and code = 'showwfinfo';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/index/audit', '审核情况', 0, 8, 'searchicon', 'indexaudit.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');


delete from p#busfw_t_uifunction t where key = '/pmkpi/index/query' and code = 'showwfinfo';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/index/query', '审核情况', 0, 8, 'searchicon', 'indexquery.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');


delete from p#busfw_t_uifunction t where key = '/pmkpi/indexlib/deptlist' and code = 'showwfinfo';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/indexlib/deptlist', '审核情况', 0, 8, 'searchicon', 'indexlib.showwfinfo', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');