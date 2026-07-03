begin
--选择指标复选框改为true
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/program/prjindex/refindi' and id='recomtable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/refindi', 'busuidatatable', '{headsort:false,addrow:false,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'',nogroupbox:true}', 'recomtable', 'pmkpi', null);
