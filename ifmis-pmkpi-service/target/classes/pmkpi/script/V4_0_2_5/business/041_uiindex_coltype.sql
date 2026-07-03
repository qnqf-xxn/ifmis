begin
update p#Busfw_t_Uicolumn t set t.coltype = 1 where t.key = '/pmkpi/indexlib/deptlist' and t.isvisiable = 1;
update p#Busfw_t_Uicolumn t set t.coltype = 1 where t.key = '/pmkpi/index/audit' and t.isvisiable = 1;
update p#Busfw_t_Uicolumn t set t.coltype = 1 where t.key = '/pmkpi/indexlib/list' and t.isvisiable = 1;
update p#Busfw_t_Uicolumn t set t.coltype = 1 where t.key = '/pmkpi/index/query' and t.isvisiable = 1;