begin

delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply/edit' and code in ('selfanaly','goalindex');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/apply/edit', '自评分析', 'selfanaly', 0, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '自评分析', null, null, '{url:''/pmkpi/perfself/apply/editdept/selfanaly.page'',action:''selfanaly.save''}', null, '0', 'analyiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/apply/edit', '绩效完成情况(湖北)', 'goalindex', 0, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效完成情况(湖北)', null, null, '{busguid:''987681B666C9BAD44314299CC99F951B'',url:''/pmkpi/perfself/apply/edit/goalandindex.page'',action:''selfgoalindex.save''}', null, '0', 'goalindexiframe', null, null, null, null, null, null);


delete from p#busfw_t_uitable where key = '/pmkpi/perfself/apply/edit/goalandindex';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/goalandindex', 'V_PM_PERF_GOAL_INFO', 0, 0, 0, null, null, 'pmkpi', '{}');



delete from p#busfw_t_uitable where key = '/pmkpi/perfself/apply/edit/hbprogoal';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbprogoal', 'V_PM_PERF_GOAL_INFO', 0, 0, 0, null, null, 'pmkpi', '{}');




delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/apply/edit/hbprogoal';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbprogoal', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbprogoal', 'KPI_TARGET', '年度绩效目标', 1, 1, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);




delete from p#busfw_t_uitable where key = '/pmkpi/perfself/apply/edit/hbtreeindex';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'V_PERF_T_SELFPERFINDEX', 0, 1, 0, null, null, 'pmkpi', null);





delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/apply/edit/hbtreeindex';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'FILENAME', '附件材料', 16, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'FILE', '附件管理', 15, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'KPI_REMARK', '偏差原因及改进措施', 14, 1, 1, 0, '0', 0, 6, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'SCORE_REMARK', '得失分依据及原因', 13, 0, 1, 0, '0', 0, 6, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'SCORE', '实际得分', 12, 1, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'WARN', '序时进度预警', 11, 0, 0, 0, '0', 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'ACTUALWEIGHT', '权重', 10, 1, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'WEIGHT', '权重设定值', 9, 0, 0, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'METERUNIT', '计量单位', 8, 1, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'ACTUALVALUE', '实际完成值', 7, 1, 1, 0, '0', 1, 6, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'INDEXVAL', '指标值', 6, 1, 0, 0, '0', 0, 6, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'COMPUTESIGN', '计算符号', 5, 1, 0, 0, '0', 0, 6, null, '#name', null, 0, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'NAME', '指标名称', 4, 1, 0, 0, '0', 0, 6, null, null, null, 0, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/perfself/apply/edit/hbtreeindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);
