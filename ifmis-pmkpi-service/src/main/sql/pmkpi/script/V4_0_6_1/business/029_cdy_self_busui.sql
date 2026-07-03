begin

update p#busfw_t_uieditform t  set t.tablecode='V_PERF_T_SELFPERFDESC' where t.key in('/pmkpi/perfself/apply/editdept/selfdesc','/pmkpi/perfself/apply/edit/selfdesc');
