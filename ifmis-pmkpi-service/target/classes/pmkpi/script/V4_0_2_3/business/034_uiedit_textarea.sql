begin

--文本框宽度调整
--部门绩效申报填报-填报-年度绩效指标-新增指标
update p#busfw_t_uieditform set colspannum = 2 where key ='/pmkpi/deptperformance/report/editindex' and type = 'textarea';
--绩效目标修订填报-修订-绩效指标修订-新增指标
update p#busfw_t_uieditform set colspannum = 2 where  key ='/pmkpi/program/prjindex/editindex' and type = 'textarea';
