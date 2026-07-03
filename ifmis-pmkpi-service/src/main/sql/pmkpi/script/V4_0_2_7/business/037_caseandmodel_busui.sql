
begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/caseinfo/index','/pmkpi/setting/modelinfo/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/setting/caseinfo/index', 'V_PERF_T_CASEMODELINDEX', 0, 0, 0, null, null, 'pmkpi', '{}');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/setting/modelinfo/index', 'V_PERF_T_CASEMODELINDEX', 0, 0, 0, null, null, 'pmkpi', '{}');

--案例库指标列表
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/caseinfo/index') and t.columncode in('FINDEX','SINDEX','COMPUTESIGN','COMPUTESIGN','INDEXVALUE','METERUNIT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/caseinfo/index', 'FINDEX', '一级指标', 1, 1, 1, null, null, 1, null, null, '#name', null, null, 150, 1, 'tree', '{filtersql:" levelno=\''1\'' and frametype=\''#framesystem\''"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/caseinfo/index', 'SINDEX', '二级指标', 2, 1, 1, null, null, 1, null, null, '#name', null, null, 150, 1, 'tree', '{filtersql:" guid in (select guid from v_perf_t_frame k where k.superid = \''#findex\'') and frametype=\''#framesystem\''"}', '1');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/caseinfo/index', 'COMPUTESIGN', '计算符号', 4, 1, 1, null, null, 1, null, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/caseinfo/index', 'INDEXVALUE', '指标值', 5, 1, 1, null, null, null, null, null, null, null, null, 120, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/caseinfo/index', 'METERUNIT', '计量单位', 6, 1, 1, null, null, null, null, null, null, null, null, 120, 0, 's', '{}', null);

--模板库指标列表
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/modelinfo/index') and t.columncode in('FINDEX','SINDEX','COMPUTESIGN','COMPUTESIGN','INDEXVALUE','METERUNIT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/modelinfo/index', 'FINDEX', '一级指标', 1, 1, 1, null, null, 1, null, null, '#name', null, null, 150, 1, 'tree', '{filtersql:" levelno=\''1\'' and frametype=\''#framesystem\''"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/modelinfo/index', 'SINDEX', '二级指标', 2, 1, 1, null, null, 1, null, null, '#name', null, null, 150, 1, 'tree', '{filtersql:" guid in (select guid from v_perf_t_frame k where k.superid = \''#findex\'')  and frametype=\''#framesystem\''"}', '1');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/modelinfo/index', 'COMPUTESIGN', '计算符号', 4, 1, 1, null, null, 1, null, null, '#name', null, null, 120, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/modelinfo/index', 'INDEXVALUE', '指标值', 5, 1, 1, null, null, null, null, null, null, null, null, 120, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values (sys_guid(), '/pmkpi/setting/modelinfo/index', 'METERUNIT', '计量单位', 6, 1, 1, null, null, null, null, null, null, null, null, 120, 0, 's', '{}', null);
