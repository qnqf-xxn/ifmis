begin
update busfw_t_uicolumn t set t.isvisiable = 1,t.colwidth = 100 where t.key = '/pmkpi/setting/tempdataset' and t.columncode = 'ISLEAF';
