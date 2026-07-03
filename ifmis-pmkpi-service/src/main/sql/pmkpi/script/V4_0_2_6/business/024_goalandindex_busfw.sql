begin
  
delete from p#busfw_t_uifunction where key = '/pmkpi/program/report/goalandindex';


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D4B397227F384B974CBBED8C55863DA0', '/pmkpi/program/report/goalandindex', '查看评审意见', 0, 8, 'keepicon', 'goalandindex.reviewinfo', null, '查看评审意见', 'pmkpi', 'reviewinfo', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('87E5D22F9AF647B260AC79797E33E916', '/pmkpi/program/report/goalandindex', '复制总体绩效指标', 1, 9, 'keepicon', 'Ext.lt.pmkpi.copytotalindex', null, '复制总体绩效指标', 'pmkpi', 'copytotalindex', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A6AE5582B08865632BA21174C21FA77E', '/pmkpi/program/report/goalandindex', '指标推荐', 1, 1, 'keepicon', 'goalandindex.recom', null, '指标推荐', 'pmkpi', 'recom', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C9A3DA804F53B7E5FC7B9A1C77BBD247', '/pmkpi/program/report/goalandindex', '挑选指标', 0, 5, 'keepicon', 'goalandindex.pick', null, '挑选指标', 'pmkpi', 'pick', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A7D7CFF5169D7C1D328D9A8B94A97E4A', '/pmkpi/program/report/goalandindex', '往年预算执行情况', 1, 7, 'keepicon', 'goalandindex.budget', null, '往年预算执行情况', 'pmkpi', 'budget', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('68F3E359CD5C38E92B876598DE211575', '/pmkpi/program/report/goalandindex', '复制上年指标', 0, 6, 'keepicon', 'goalandindex.lastyear', null, '复制上年指标', 'pmkpi', 'lastyear', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('5638DEEE2EE4BAF183A5CD39D1F63E61', '/pmkpi/program/report/goalandindex', '导入', 1, 10, 'keepicon', 'goalandindex.import', null, '导入', 'pmkpi', 'import', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2CF31BA765A62483AB137D39430F0119', '/pmkpi/program/report/goalandindex', '复制年度绩效指标', 1, 9, 'keepicon', 'Ext.lt.pmkpi.copytotalindex', null, '复制年度绩效指标', 'pmkpi', 'copyyearindex', null, null);





delete from p#busfw_t_uitabpage where key = '/pmkpi/program/report/goalandindex';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('AFA4A8AC770ABDC50C50AA2847BF9E1A', 'pmkpi', '/pmkpi/program/report/goalandindex', '总体绩效指标', 'total', 1, 1, 'choosed', 'goalandindex.clickTabpage', 0, '总体绩效指标', null, '查看评审意见,复制总体绩效指标,复制上年指标', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('397D6AC82439AF5F15FA2C85EF2C74C8', 'pmkpi', '/pmkpi/program/report/goalandindex', '年度绩效指标', 'year', 1, 2, 'nomal', 'goalandindex.clickTabpage', 0, '年度绩效指标', null, '复制年度绩效指标', '{}', null, '0', null, null, null, null, null, null, null);





delete from p#busfw_t_uicolumn where key = '/pmkpi/program/report/hbprotabgoal';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4DD2FD8BB33D1F4DBE9F554D0CA0E59D', '/pmkpi/program/report/hbprotabgoal', 'KPI_TARGET', '绩效目标', 2, 1, 1, 0, null, 1, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E7482511D53D2873A3D6A462A2EF936E', '/pmkpi/program/report/hbprotabgoal', 'GUID', 'GUID', 1, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);






delete from p#busfw_t_uitable where key = '/pmkpi/program/report/hbprotabgoal';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BE73C238FB1FFDC430495C9C2C2D973A', '/pmkpi/program/report/hbprotabgoal', 'V_PM_PERF_GOAL_INFO', 0, 0, 0, null, null, 'pmkpi', '{}');




delete from p#busfw_t_uitable where key = '/pmkpi/program/report/hbtreeindex';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D2D6F2CA5F65BF53B0C8D02028309899', '/pmkpi/program/report/hbtreeindex', 'V_PM_PERF_INDICATOR', 0, 0, 0, null, null, 'pmkpi', '{}');




delete from   p#busfw_t_uicolumn t where key = '/pmkpi/program/report/treeindex' and guid in ('5EB86A25C66DB99949AB7ACFAF7C933E','C691C4852E3720948AF5FE88185D28FC','990CD8154CA3DF672387745818D40330','7C90137479C91D4EE28819B8023C7930','6453DBC49174E38BE90D4C08AA70D3EC','853386499D4A6F6E54A4A36D0AB17F29','F53747C95FDDD7C059DE6E0C92CF5D6B');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F53747C95FDDD7C059DE6E0C92CF5D6B', '/pmkpi/program/report/treeindex', 'QNINDEXVAL', '前年指标值', 4, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('853386499D4A6F6E54A4A36D0AB17F29', '/pmkpi/program/report/treeindex', 'SNINDEXVAL', '上年指标值', 4, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6453DBC49174E38BE90D4C08AA70D3EC', '/pmkpi/program/report/treeindex', 'REFERENCESTANDARDS', '指标值确定依据', 51, 0, 1, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7C90137479C91D4EE28819B8023C7930', '/pmkpi/program/report/treeindex', 'REFERENCEVAL', '参考值', 51, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('990CD8154CA3DF672387745818D40330', '/pmkpi/program/report/treeindex', 'COMPUTETYPE', '计算公式', 51, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C691C4852E3720948AF5FE88185D28FC', '/pmkpi/program/report/treeindex', 'ISSTANDPUSH', '绩效指标来源', 51, 0, 1, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5EB86A25C66DB99949AB7ACFAF7C933E', '/pmkpi/program/report/treeindex', 'INDEXSTANDARDS', '参考值确定依据', 51, 0, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);




delete  from   p#busfw_t_uicolumn t where key = '/pmkpi/program/prjindex/recomindex' and guid in ('AD056FED8177714F84AF720DF170E57B','DFA888B8145981BCDDE2A793BCCC0274','D4D3D3E327E9274CE0533315A8C0ACDD');


insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AD056FED8177714F84AF720DF170E57B', '/pmkpi/program/prjindex/recomindex', 'COMPUTETYPE', '计算公式', 13, 0, 0, 0, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D4D3D3E327E9274CE0533315A8C0ACDD', '/pmkpi/program/prjindex/recomindex', 'INDEXSTANDARDS', '绩效标准', 35, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFA888B8145981BCDDE2A793BCCC0274', '/pmkpi/program/prjindex/recomindex', 'ISSTANDPUSH', '绩效指标来源', 13, 0, 0, 0, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);
