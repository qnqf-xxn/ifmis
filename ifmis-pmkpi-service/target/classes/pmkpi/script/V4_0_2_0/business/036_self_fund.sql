begin
--自评 - 预算执行情况 数据保存到业务表
delete from p#busfw_t_uitable where key ='/pmkpi/perfself/apply/edit/bdgpay';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD547EED79AC0EABE053B11FA8C0BC8D', '/pmkpi/perfself/apply/edit/bdgpay', 'V_PERF_T_SELFPROFUND', 0, 1, 0, null, null, 'pmkpi', null);