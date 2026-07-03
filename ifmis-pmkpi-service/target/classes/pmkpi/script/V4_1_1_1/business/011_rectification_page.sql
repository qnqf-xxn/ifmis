begin
  
delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/rectification/feedbackfile') and t.id='datatable';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/rectification/feedbackfile', 'busuidatatable', '{name:''整改反馈附件'',title:''整改反馈附件'',key:''/pmkpi/upload/file/index'',rowtolist:false}', 'datatable', 'pmkpi', null);
