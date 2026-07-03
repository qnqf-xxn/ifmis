begin
  
DELETE FROM bus_t_pageconsole t where t.url='/pmkpi/upload/file/index';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/upload/file/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfcommon.filelist.UploadFilePage', 'index', '{main:[datatable]}', null, null, 0);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/upload/file/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/upload/file/index', 'pmkpi_uploadfile', '{}', 'pmkpiuploadfile', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/upload/file/index', 'busuidatatable', '{addrow:false,name:''项目附件'',edit:true,nogroupbox:true,checkbox:true,title:''项目附件'',groupcols:[''guid'',''superid'',''supername'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false}', 'datatable', 'pmkpi', null);


DELETE FROM Bus_t_Pagecomponent t where t.id='pmkpi_uploadfile';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_uploadfile', '附件上传', null, '附件上传', '/pmkpi/perfcommon/file/uploadfilelist.js', 'Ext.lt.pmkpi.perfcommon.uploadfilelist', 'pmkpi', 'pmkpi.perfcommon.UploadFileService');
