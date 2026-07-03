begin
  
--修改列表页数
update p#busfw_t_uitable t set t.pagenum=100 where t.key in('/pmkpi/midprogram/report/list','/pmkpi/midprogram/query/list','/pmkpi/deptperformance/query/index','/pmkpi/deptperformance/report/index','/pmkpi/deptperformance/audit/index','/pmkpi/program/report/audit','/pmkpi/midprogram/report/audit','/pmkpi/program/reportdp/jxaudit','/pmkpi/program/reportdp/audit');

--修改待办查询方法
update PERF_PENDINGTASK t set t.mothod='getVodSql' where key in( '/pmkpi/deptperformance/report/index','/pmkpi/deptperformance/audit/index','/pmkpi/program/report/audit','/pmkpi/midprogram/report/audit','/pmkpi/program/reportdp/jxaudit','/pmkpi/program/reportdp/audit');
