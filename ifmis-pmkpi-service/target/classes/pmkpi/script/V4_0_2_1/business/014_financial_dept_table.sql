begin


delete from p#busfw_t_uitable t where key in('/pmkpi/program/report/list','/pmkpi/evaluation/financial/program');

insert into busfw_t_uitable(GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD25F32C9EA677B9E053B11FA8C041F0', '/pmkpi/evaluation/financial/program', 'V_PERF_T_FINEVALUATION', 100, 0, null, null, 't.pro_cat_code in(''22'',''3'')', 'pmkpi', '{}');

insert into busfw_t_uitable(GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('2259FFA1A6504F13B6730C730E8FC124', '/pmkpi/program/report/list', 'V_PERF_PROJECT_INFO', 100, 1, 0, 'PRO_CODE', 't.pro_cat_code in(''22'',''3'')', 'pmkpi', null);

