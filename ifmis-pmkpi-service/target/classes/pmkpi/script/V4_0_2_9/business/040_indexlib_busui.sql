begin

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/indexlib/deptlist');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'FRAMESYSTEM', '指标体系', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', '{format:''#name'',multi:false}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'FINDEX', '一级指标', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', '{format:''#name'',filtersql:''frametype=\''#FRAMESYSTEM\'' and levelno=1''}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'SINDEX', '二级指标', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', '{format:''#name'',filtersql:''frametype=\''#FRAMESYSTEM\''''}', 1, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/deptlist', 'PERF_IND_NAME', '三级指标名称', 4, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/indexlib/list');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/list', 'FRAMESYSTEM', '指标体系', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', '{format:''#name'',multi:false}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/list', 'FINDEX', '一级指标', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', '{format:''#name'',filtersql:''frametype=\''#FRAMESYSTEM\'' and levelno=1''}', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/list', 'SINDEX', '二级指标', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', '{format:''#name'',filtersql:''frametype=\''#FRAMESYSTEM\''''}', 1, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT)
values (sys_guid(), '/pmkpi/indexlib/list', 'PERF_IND_NAME', '三级指标名称', 4, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, null);
