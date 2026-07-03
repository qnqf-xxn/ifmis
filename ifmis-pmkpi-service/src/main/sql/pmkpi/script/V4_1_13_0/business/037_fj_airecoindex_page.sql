begin
  
update bus_t_pageconsole set CONSOLESERVICE = 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.airecoindex.AiRecoindexPage',CSSLIB = '/pmkpi/common/css/ai_common.css' where url ='/pmkpi/program/airecoindex';

update bus_t_pagecomponent set SERVICE = 'pmkpi.prjindex.AiRecoindexService' where id ='pmkpi_airecoindex';
