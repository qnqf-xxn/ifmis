begin

update p#busfw_t_uitable t set t.tablecode='V_PERF_T_EXPDOCMAIN' where t.key ='/pmkpi/setting/expdoc';
update p#busfw_t_uitable t set t.tablecode='V_PERF_T_EXPDOCSUB' where t.key ='/pmkpi/setting/expdoctemp';
