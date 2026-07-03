begin
  
DELETE FROM p#Busfw_t_Uitable t WHERE t.key='/pmkpi/yearprogram/query/list';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D0419BBF189123B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'V_PERF_PROJECT_YEAR', 100, 0, 0, null, '1=1', 'pmkpi', null);


DELETE FROM p#Busfw_t_Uicolumn t WHERE t.key='/pmkpi/yearprogram/query/list';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18F523B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'PRO_NAME', '名称', 0, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 1, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18F623B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, null, null, null, null, null, 120, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18F723B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18F823B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18F923B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18FA23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18FB23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18FC23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'CREATER', '创建人', 14, 0, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18FD23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF18FE23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'APPLY_UP', '申报数', 10, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF1AEE23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'WFID', '审核ID', 20, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);


DELETE FROM p#Busfw_t_Uifunction t WHERE t.key='/pmkpi/yearprogram/query/list';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D0419BBF190523B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', '审核情况', 1, 2, 'searchicon', 'yearprogramquery.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D0419BBF190623B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', '查看项目明细', 1, 6, 'searchicon', 'yearprogramquery.proinfoview', null, '查看项目明细', 'pmkpi', 'queryprogram', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D0419BBF1A8E23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', '导出报表', 0, 3, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报表', 'pmkpi', 'expxls', null, '{tempatecode:''sxxmjxmb''}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D0419BBF1A8F23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', '导出天津报表', 0, 4, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出天津报表', 'pmkpi', 'exptjxls', null, '{tempatecode:''tjhfxmjxmbsbb''}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D0419BBF1A9123B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', '导出合肥报表', 0, 5, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出合肥报表', 'pmkpi', 'exptjxlsx', null, '{tempatecode:''hfxmjxmbsbb''}');


DELETE FROM p#Busfw_t_Uiqueryform t WHERE t.key='/pmkpi/yearprogram/query/list';
insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF195923B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF195B23B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF196023B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'YEAR', '年度', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null);

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D0419BBF196523B8E0533315A8C0FC8D', '/pmkpi/yearprogram/query/list', 'APPLY_UP', '申报数', 4, 1, 'amt', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{region:1}', null);



