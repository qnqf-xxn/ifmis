begin 

delete from bus_t_pageconsolecomconfig where url ='/pmkpi/perfself/taskmanage' and id ='datatable';

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/perfself/taskmanage', 'busuidatatable', '{name:''绩效自评下达'',checkbox:true,title:''绩效自评下达'',edit:false,addrow:false,uikey:''/pmkpi/perfselftaskmanage/edit'',deltables:[''v_perf_t_selfperfindex'',''v_perf_t_selfperfdesc'',''v_perf_t_selfprofund'',''v_perf_t_selfperfgoal''],delcols:[''mainguid'',''mainguid'',''mainguid'']}', 'datatable', 'pmkpi', null);
