begin

--项目绩效申报-指标新增、修改按钮隐藏
update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/program/report/treeindex') and t.code in('add','mod');

--部门整体绩效申报-指标新增、修改按钮隐藏
update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/deptperformance/report/perfindex') and t.code in('add','mod');

--绩效目标修订-指标新增、修改按钮隐藏
update p#busfw_t_uifunction t set t.isvisiable=0 where t.key in('/pmkpi/prorevision/report/edit/index') and t.code in('add','mod');
