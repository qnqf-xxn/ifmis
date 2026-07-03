begin
  update p#Busfw_t_Uitabpage t set t.ordernum = 1,t.classname = 'choosed' where t.KEY = '/pmkpi/rectification/addBatch' and t.code = 'file';