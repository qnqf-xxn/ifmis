begin

delete from bus_t_pageconsolecomconfig t where t.url in('/pmkpi/upload/file/index');
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/upload/file/index', 'pmkpi_uploadfile', '{}', 'pmkpiuploadfile', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/upload/file/index', 'busuidatatable', '{addrow:false,name:''附件管理'',edit:true,nogroupbox:true,checkbox:true,title:''附件管理'',groupcols:[''guid'',''superid'',''supername'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,rowtolist:false}', 'datatable', 'pmkpi', null);

delete from busfw_t_uitable t where t.key in('/pmkpi/upload/file/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BEE5E20ADBDFEE4FE053B11FA8C02857', '/pmkpi/upload/file/index', 'PERF_FILETYPE', 0, 0, null, 'order by ordernum', null, 'pmkpi', '{}');

