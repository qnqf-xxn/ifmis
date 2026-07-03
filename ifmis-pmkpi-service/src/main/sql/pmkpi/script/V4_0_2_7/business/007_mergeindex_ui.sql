begin 
  
--贵州 个性化指标填报页面：隐藏新增和修改指标按钮(改为行内增删改) 
update p#busfw_t_uifunction set ISVISIABLE = 0 where key ='/pmkpi/program/report/mergeindex' and code in('add','mod');
