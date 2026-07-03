begin
  
--默认隐藏 引用指标、 清空指标 按钮
update p#busfw_t_uifunction set ISVISIABLE = 0 where key = '/pmkpi/program/report/treeindex' and code in('refindi','clear');


