begin
  --修改枚举表 操作列 coltype字段值
update p#busfw_t_uicolumn set COLTYPE = 2 where key ='/pmkpi/setting/perfenumset' and columncode ='ISADD';


--绩效枚举配置页面 添加分页
delete from p#busfw_t_uitable where key ='/pmkpi/setting/perfenumset';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/setting/perfenumset', 'PERF_ENUM', 100, 0, 0, null, null, 'pmkpi', null);

