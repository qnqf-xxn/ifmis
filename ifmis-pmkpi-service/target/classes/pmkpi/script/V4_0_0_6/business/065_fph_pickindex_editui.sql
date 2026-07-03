begin
  
DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/prjindex/pickindex' and t.id in('queryform','picktable');
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'busqueryform', '{name:''查询区'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120'',datatable:''picktable''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'busuidatatable', '{addrow:false,nogroupbox:false,edit:false,checkbox:true,nextSibling:false}', 'picktable', 'pmkpi', null);



DELETE FROM p#Busfw_t_Uicolumn t where t.key='/pmkpi/program/prjindex/pickindex';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('program/prjindex/pickindex001', '/pmkpi/program/prjindex/pickindex', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM p#Busfw_t_Uicolumn t where t.key='/pmkpi/program/prjindex/pickindex';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ECAAB40443EE99E8FB5E69EDF6020D78', '/pmkpi/program/prjindex/pickindex', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('54F7348B55894C4EA3C8935833C301E2', '/pmkpi/program/prjindex/pickindex', 'KEYWORD', '关键词', 30, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5C6225E47BA94FB29F0E59EFF2485103', '/pmkpi/program/prjindex/pickindex', 'PERF_IND_CODE', '指标编码', 1, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('06ACCF62BF6D4BC6BD48E9DFE35E20B0', '/pmkpi/program/prjindex/pickindex', 'INDEXCATEGORIES', '行业大类', 6, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A8378701BECA4A8381AA823075D39438', '/pmkpi/program/prjindex/pickindex', 'INDUSTRYCATEGORY', '行业类别', 8, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F0FD052BB15747ADA4790AAB022E2CD6', '/pmkpi/program/prjindex/pickindex', 'PROJTYPE', '项目类型', 4, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"1"}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('47973341E9B7443BA58465FFAE7C9836', '/pmkpi/program/prjindex/pickindex', 'KPI_VAL', '参考值', 15, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2DB5DD447791440CA5B7D87C0813BD69', '/pmkpi/program/prjindex/pickindex', 'COMPUTESIGN', '性质', 14, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CCEC598491C04BA7ADD6BB020F9E753C', '/pmkpi/program/prjindex/pickindex', 'TARGETUNIT', '单位', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EC3DBF09101F43A7827C6FBFF86ABA73', '/pmkpi/program/prjindex/pickindex', 'EXPLAIN', '指标解释', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('26FC3ADF78174F5DA4E70F0A839AF2BD', '/pmkpi/program/prjindex/pickindex', 'FUNDUSE', '资金用途', 10, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('731FAB295C7F4FA99077882BD49107D2', '/pmkpi/program/prjindex/pickindex', 'AGENCY_CODE', '预算部门', 2, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F6F0D864856B43BE85658EEFFF69FD78', '/pmkpi/program/prjindex/pickindex', 'INDEXSTANDARDS', '绩效标准', 19, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FE4456F48FF149BE97374C852C80688F', '/pmkpi/program/prjindex/pickindex', 'PERF_IND_NAME', '内容', 13, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F0E675E4933460FAA67AA03D724B8BD', '/pmkpi/program/prjindex/pickindex', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5FFF300E64E347D4BA567FC0FF2C269E', '/pmkpi/program/prjindex/pickindex', 'IS_COMMON_IND', '是否共性指标', 20, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', null, null);
