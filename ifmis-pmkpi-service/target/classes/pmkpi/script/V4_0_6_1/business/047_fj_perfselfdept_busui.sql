begin

--自评填报 部门职能概述页签查询模式修复
update p#busfw_t_uitabpage set CONFIG = '{url:''/pmkpi/deptperformance/report/funcd.page?viewtype=query'',action:''deptfunc.save'',busguid:''15F7B8C868E54306A2FDE7CCC32726FC'',viewtype:''query''}' where key ='/pmkpi/perfself/apply/dept/edit' and code ='deptfun';