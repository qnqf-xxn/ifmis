begin
  
--自评分析，配置表进行修改
update p#busfw_t_uieditform t set t.tablecode = 'V_PERF_T_SELFPERFDESC' where t.key='/pmkpi/perfself/apply/editdept/selfanaly';
