
begin

--监控查询导出附件按钮
delete from p#busfw_t_uifunction where KEY = '/pmkpi/program/trace/query' and CODE = 'indexFileExp';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/program/trace/query', '导出附件', 0, 23, 'searchicon', 'protracequery.indexFileExp', null, '导出附件', 'pmkpi', 'indexFileExp', null, '{}');

--自评查询导出附件按钮
delete from p#busfw_t_uifunction where KEY = '/pmkpi/perfself/query/index' and CODE = 'indexFileExp';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/query/index', '导出附件', 0, 21, 'searchicon', 'perfselfquery.indexFileExp', null, '导出附件', 'pmkpi', 'indexFileExp', null, '{}');
