begin
  --问题整改 选择项目 右侧数据没有滚动条
delete from p#busfw_t_uitable where key in ('/pmkpi/rectification/check/deptproj','/pmkpi/rectification/check/proj');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD4E9B88DEF56473E053B11FA8C03CED', '/pmkpi/rectification/check/deptproj', 'V_PERF_T_DEPTPERFDECLARE', 200, 0, null, null, null, 'pmkpi', null);

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('265BD352DC9C401E2B63D2CCC36ED7E0', '/pmkpi/rectification/check/proj', 'V_PERF_PROJECT_INFO', 200, 0, null, null, null, 'pmkpi', null);

