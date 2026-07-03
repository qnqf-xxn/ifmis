begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/apply/index') and t.code='hfexpdoc';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply/index', '合肥自评模板导出', 0, 22, 'searchicon', 'perfselfapply.expdoc', null, '合肥自评模板导出', 'pmkpi', 'hfexpdoc', null, '{protempatecode:''hfxmzczpj'',depttempatecode:''hfbmztzpj'',proexptype:''hfprogram'',deptexptype:''hfdept''}');

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/query/index') and t.code='hfexpdoc';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values (sys_guid(), '/pmkpi/perfself/query/index', '合肥自评报告导出', 0, 22, 'searchicon', 'perfselfquery.expdoc', null, '合肥自评报告导出', 'pmkpi', 'hfexpdoc', null, '{protempatecode:''hfxmzczpj'',depttempatecode:''hfbmztzpj'',proexptype:''hfprogram'',deptexptype:''hfdept''}');

update perf_t_treetab t set t.hidebtns='查看项目,合肥自评模板导出' where t.key in('/pmkpi/perfself/apply') and code='dept';

update perf_t_treetab t set t.hidebtns='查看项目,导出项目自评表,导出项目支出支出绩效自评表（河北）,合肥自评报告导出' where t.key in('/pmkpi/perfself/query') and code='dept';
