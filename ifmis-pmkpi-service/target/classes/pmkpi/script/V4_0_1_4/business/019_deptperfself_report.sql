begin
-- 绩效自评管理 部门整体  绩效自评填报  添加编辑区配置
update bus_t_pageconsole set CONFIG='{main:[tabpage,deptgoaleditform],footer:[toolbutton]}' where url = '/pmkpi/perfself/apply/dept/edit';

update bus_t_pageconsolecomconfig set CONFIG ='{key:''/pmkpi/deptperformance/report/deptgoal'',title:''绩效目标'',tablecode:''v_bgt_perf_goal_info''}' where url ='/pmkpi/perfself/apply/dept/edit' and  id ='deptgoaleditform';  

-- 绩效自评 -- 部门整体填报 添加部门职能概述、绩效目标页签
delete from p#busfw_t_uitabpage where key in('/pmkpi/perfself/apply/dept/edit') and code in('deptfun','deptgoal') and COMPONENTID in('funciframe','deptgoaleditform'); 
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('67F400F6D1DF458095B6F0C0A40942E3', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '部门职能概述', 'deptfun', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '部门职能活动', null, null, '{url:''/pmkpi/deptperformance/report/funcd.page'',action:''deptfunc.save'',busguid:''15F7B8C868E54306A2FDE7CCC32726FC''}', null, '0', 'funciframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('AA1CB9CAD6784E7F80E29057B1111D9C', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '绩效目标', 'deptgoal', 0, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标', null, null, '{busguid:''6584F846CE6D4CB8BF105577F0DC4C8C''}', null, '0', 'deptgoaleditform', null, null, null, null, null, null);
