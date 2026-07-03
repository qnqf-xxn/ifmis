begin

update p#busfw_t_uiqueryform t set t.type='tree' where t.key in('/pmkpi/setting/baseinfo/expertinifo') and t.columncode in('CREDITNO','PROFESSIONAL');
