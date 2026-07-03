begin
--1-1.一级项目-展示列注册
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/firstprogram/query/list'; 
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1D551B939D3C4472ABDC2F65674F866C', '/pmkpi/firstprogram/query/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('952C03692A1A409697ADFD04D06676E6', '/pmkpi/firstprogram/query/list', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FEC3C4F1E3CB44D0ACC1DA1B389DAC49', '/pmkpi/firstprogram/query/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('171F6026CC2844ACBBA2E068A43F9FD8', '/pmkpi/firstprogram/query/list', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('32E78FDCF72C402D8A721BE4419C4334', '/pmkpi/firstprogram/query/list', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B00133E3848F42E598099A105CD6440A', '/pmkpi/firstprogram/query/list', 'CREATER', '创建人', 14, 0, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F670DA31BA0D4F839BFFA5B6BE74D98F', '/pmkpi/firstprogram/query/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('59099805C87E4026815803A8F271CF1C', '/pmkpi/firstprogram/query/list', 'PRO_NAME', '名称', 0, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B2A48B9B97754780ACDBD333B318C8EF', '/pmkpi/firstprogram/query/list', 'PRO_LEV', '项级次', 1, 0, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FF2ECBDDAE644221AF5A9A0644EABB37', '/pmkpi/firstprogram/query/list', 'PRO_ID', '项目ID', 1, 0, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

--1-2.一级项目-业务表注册
delete from p#busfw_t_uitable where key = '/pmkpi/firstprogram/query/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D0C59A9F25004AC38B7B493CE6E41994', '/pmkpi/firstprogram/query/list', 'V_PERF_PROJECT_INFO', 100, 0, 0, null, null, 'pmkpi', null);

--1-3.一级项目-查询区注册
delete from p#busfw_t_uiqueryform where key = '/pmkpi/firstprogram/query/list';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BF9F565359D24D6A8AD062162493F048', '/pmkpi/firstprogram/query/list', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('433672E203A6493597EADE9053A1A373', '/pmkpi/firstprogram/query/list', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);


--2-1.转移支付-展示列注册
delete from p#Busfw_t_Uicolumn t where key = '/pmkpi/transpay/query/list';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C54DCDA72EC84EC793FDBA8921CC8EE5', '/pmkpi/transpay/query/list', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F90E1D7110EE4B1FA07FCE3ECA7B9E7F', '/pmkpi/transpay/query/list', 'AGENCY_CODE', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E07FA212E3734C56A614E45CAEE7B60E', '/pmkpi/transpay/query/list', 'YEAR', '预算年份', 4, 1, 0, null, null, null, 1, null, null, null, null, 100, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('516902112B1C4083B309F8BD8E5A0A3B', '/pmkpi/transpay/query/list', 'CREATE_TIME', '填报时间', 9, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('75ECF64A5876446CB942AB6C4F1D8DAC', '/pmkpi/transpay/query/list', 'FININTORGGUID', '业务科室', 13, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A00F1E0568C04E4B8A0FD1EF936E2E1E', '/pmkpi/transpay/query/list', 'CREATER', '创建人', 14, 0, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('905B16298D224EB39C02BA55E3053670', '/pmkpi/transpay/query/list', 'WFSTATUS', '审核状态', 15, 1, 0, null, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('424C2E8897754D4DA71D3A54EE071121', '/pmkpi/transpay/query/list', 'PRO_NAME', '名称', 0, 0, 0, 0, null, 0, 0, null, null, null, null, 200, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8FFD68CB6E19489EB0937E12FB567FF6', '/pmkpi/transpay/query/list', 'PRO_LEV', '项级次', 1, 0, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE39A6DBE00C418385CC209D565CCA28', '/pmkpi/transpay/query/list', 'PRO_ID', '项目ID', 1, 0, 0, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null);

--2-2.转移支付-业务表注册
delete from  p#busfw_t_uitable t where key = '/pmkpi/transpay/query/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('0A832E8B60714C34926347D0E3811860', '/pmkpi/transpay/query/list', 'V_PERF_PROJECT_INFO', 100, 0, 0, null, null, 'pmkpi', null);

--2-3.转移支付-查询区注册
delete from p#busfw_t_uiqueryform t  where key ='/pmkpi/transpay/query/list';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('31E71DD32E224CEC845A3B63364FC7B7', '/pmkpi/transpay/query/list', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('29D99BBDF06448FFA17940A9A378B19F', '/pmkpi/transpay/query/list', 'PRO_NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);


--3-1.绩效目标查询-整合-展示列注册
delete from  p#Busfw_t_Uicolumn t where key = '/pmkpi/performance/query';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7BB54BE4DB6647289D5BFE57E2EC3D08', '/pmkpi/performance/query', 'GUID', 'GUID', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

--3-2.绩效目标查询-整合-业务表注册
delete from  p#busfw_t_uitable t where key = '/pmkpi/performance/query';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('44D9B3DADDF14C10A2DB4D2D9B547812', '/pmkpi/performance/query', 'PERF_T_SUPERVISION', 100, 1, 0, null, null, 'pmkpi', '{}');

--3-3.绩效目标查询-整合-按钮注册
delete from p#busfw_t_uifunction t where key = '/pmkpi/performance/query';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AFEAA51A31E14CC2ADA69A025258116E', '/pmkpi/performance/query', '查询', 0, 1, 'searchicon', 'performance.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('07469D5C18904327A68729CB6371627E', '/pmkpi/performance/query', '审核情况', 1, 2, 'searchicon', 'performance.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('5890170D54444B0C8C7D58D7BCEDD11A', '/pmkpi/performance/query', '导出', 1, 3, 'searchicon', 'performance.export', null, '导出', 'pmkpi', 'export', null, '{}');




