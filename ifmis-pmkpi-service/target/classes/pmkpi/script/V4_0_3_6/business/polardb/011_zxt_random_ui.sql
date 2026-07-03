
 update P#Busfw_t_UiTABLE set tablecode = 'V_PERF_PROJECT_INFO' where key = '/pmkpi/performance/query';

 update p#busfw_T_uitabpage set filter = 'toident' where key = '/pmkpi/randomcomment/scope' and name = '待标识';
 update p#busfw_T_uitabpage set filter = 'isident' where key = '/pmkpi/randomcomment/scope' and name = '已标识';

 update p#busfw_T_uieditform set name = '抽取项目数量(优，良，中，差)' where key = '/pmkpi/randomcomment/randomAdd' and columncode = 'RANDOM';
 update p#busfw_T_uieditform set name = '待抽取项目数量(优，良，中，差)' where key = '/pmkpi/randomcomment/randomAdd' and columncode = 'RANDOMPROJ';
