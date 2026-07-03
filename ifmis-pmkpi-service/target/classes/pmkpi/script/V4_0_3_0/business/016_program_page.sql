begin
  
update bus_t_pageconsole t set t.consoleservice='gov.mof.fasp2.pmkpi.tabfream.TabfreamPage' where t.url in('/pmkpi/program/report/edit');
