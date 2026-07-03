begin

delete from p#busfw_t_uifunction t where t.KEY='/pmkpi/deptperformance/report/perfindex' and code ='recom';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/deptperformance/report/perfindex', '指标推荐', 1, 1, 'keepicon', 'deptindex.recom', null, '指标推荐', 'pmkpi', 'recom', null, null);


delete from p#busfw_t_uifunction t where t.KEY='/pmkpi/adjust/report/deptedit/index' and code ='recom';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/adjust/report/deptedit/index', '指标推荐', 1, 1, 'keepicon', 'adjustindex.recom', null, '指标推荐', 'pmkpi', 'recom', null, null);
