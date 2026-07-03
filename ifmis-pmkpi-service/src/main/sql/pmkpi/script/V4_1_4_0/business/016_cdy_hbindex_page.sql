begin
  
update bus_t_pageconsole t set t.config='{main:[toolbutton,tabpage,goaldatatable,datatable]}' where t.url in('/pmkpi/program/report/goalandindex');
