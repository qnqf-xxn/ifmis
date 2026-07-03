begin

--ҳ������ PAGE
--��Ŀ��ЧĿ���ѯ
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/query/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/query/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.query.TlpProgramQueryPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/query/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/list', 'pmkpi_tlprogramquery', '{}', 'tlprogramquery', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/list', 'busuidatatable', '{name:''��Ŀ��Ч'',checkbox:true,title:''��Ŀ��Ч'',edit:false,addrow:false,uikey:''/pmkpi/program/report/edit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/query/list', 'busqueryform', '{name:''��ѯ��'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''���ٲ�ѯ'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_tlprogramquery';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlprogramquery', '��Ŀ��Ч��ѯ', null, '��Ŀ��Ч��ѯ', '/pmkpi/perfprogram/query/assessquery.js', 'Ext.lt.pmkpi.perfprogram.tlpqueryservice', 'pmkpi', 'pmkpi.perfprogram.TlpProgramQueryService');

--��Ŀ��ЧĿ�����
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/report/audit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/audit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.audit.TlpProgramAuditPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable],height:[null,null,null,null]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/report/audit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/audit', 'pmkpi_tlprogramaudit', '{}', 'tlprogramaudit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/audit', 'busuidatatable', '{name:''��Ŀ��Ч���'',checkbox:true,title:''��Ŀ��Ч���'',edit:false,addrow:false,pagetype:''audit'',uikey:''/pmkpi/program/report/edit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/audit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/audit', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/audit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/audit', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/audit', 'busqueryform', '{name:''��ѯ��'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''���ٲ�ѯ'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_tlprogramaudit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlprogramaudit', '��Ŀ��Ч���', null, '��Ŀ��Ч���', '/pmkpi/perfprogram/audit/tlprogramaudit.js', 'Ext.lt.pmkpi.perfprogram.tlpauditservice', 'pmkpi', 'pmkpi.perfprogram.TlpProgramAuditService');

--��Ŀ��ЧĿ���
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/report/list';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/list', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.report.TlpProgramPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,tabpage,datatable]}', null, null, 0);


delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/report/list';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/list', 'pmkpi_tlproreport', '{}', 'pmkpitlproreport', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/list', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/list', 'busqueryform', '{name:''��ѯ��'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''���ٲ�ѯ'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/list', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/list', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/list', 'busuidatatable', '{name:''��Ŀ��Ч�걨'',checkbox:true,title:''��Ŀ��Ч�걨'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/program/report/edit'',deltables:[v_perf_t_outpayproject,v_pm_perf_indicator]}', 'datatable', 'pmkpi', null);


insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/list', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_tlproreport';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlproreport', '��Ŀ��Ч�걨', null, '��Ŀ��Ч�걨', '/busfw/ltext/swfupload/jslib/fupload.js,/busfw/ltext/componentview/ltext_fileupload.js,/busfw/common/ui/ui_uploadfiles.js,/busfw/ltext/fuds-download.js,/busfw/ltext/fuds-upload.js,/pmkpi/common/fileupload.js,/pmkpi/perfprogram/report/proreport.js', 'Ext.lt.pmkpi.perfprogram.reportservice', 'pmkpi', 'pmkpi.perfprogram.TlpProgramService');

--��Ŀ��ЧĿ�����������Ϣ
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/report/edit';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.report.TlpProgramPage', 'editindex', '{main:[tabpage,toolbutton,editform,mxdatatable]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/report/edit';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/edit', 'pmkpi_tlprogramedit', '{}', 'pmkpitlprogramedit', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/edit', 'bustabpage', '{}', 'tabpage', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/edit', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/edit', 'busuidatatable', '{key:''/pmkpi/program/report/mxdatatable'',headsort:false,addrow:true,name:''Ԥ��֧����ϸ'',edit:true,checkbox:true,title:''Ԥ��֧����ϸ''}', 'mxdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/edit', 'buseditform', '{title:''������Ϣ'',tablecode:''v_perf_project_info'',iswf:''true''}', 'editform', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_tlprogramedit';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlprogramedit', '��Ŀ��Ϣ�༭', null, '��Ŀ��Ϣ�༭', '/busfw/ltext/swfupload/jslib/fupload.js,/busfw/ltext/componentview/ltext_fileupload.js,/busfw/common/ui/ui_uploadfiles.js,/busfw/ltext/fuds-download.js,/busfw/ltext/fuds-upload.js,/pmkpi/common/fileupload.js,/pmkpi/perfprogram/report/proreportedit.js', 'Ext.lt.pmkpi.perfprogram.editservice', 'pmkpi', 'pmkpi.perfprogram.TlpProgramEdit');

--��Ŀ��ЧĿ�������ȼ�ЧĿ��
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/report/proindex';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/report/proindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'listpage', '{main:[editform,toolbutton,indexdatatable]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/report/proindex';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'pmkpi_tlproindex', '{}', 'pmkpitlproindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:false,name:''��ȼ�Чָ��'',edit:true,checkbox:false,radio:true,title:''��ȼ�Чָ��'',indextable:''v_pm_perf_indicator'',nextSibling:false,nogroupbox:true}', 'indexdatatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/report/proindex', 'buseditform', '{}', 'editform', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_tlproindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_tlproindex', '��Ŀ���ָ��', null, '��Ŀ���ָ��', '/pmkpi/perfprogram/prjindex/prjindex.js', 'Ext.lt.pmkpi.prjindexservice', 'pmkpi', 'pmkpi.prjindex.PrjIndexService');

--��Ŀ��ЧĿ�������ȼ�ЧĿ��  ��׼�Ƽ�
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/prjindex/recomindex';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/recomindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'cmpage', '{header:[toolbutton,queryform,tab],main:[recomtable]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/prjindex/recomindex';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/recomindex', 'pmkpi_recomindex', '{headsort:false,addrow:false,name:''��Чָ��'',edit:true,checkbox:true,title:''��Чָ��'',nogroupbox:true}', 'pmkpirecomindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/recomindex', 'busuidatatable', '{}', 'recomtable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/recomindex', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/recomindex', 'bustabpage', '{}', 'tab', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/recomindex', 'busqueryform', '{}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/recomindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_recomindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_recomindex', '��׼�Ƽ�', null, '��׼�Ƽ�', '/pmkpi/perfprogram/prjindex/recoindex.js', 'Ext.lt.pmkpi.recomindexservice', 'pmkpi', 'pmkpi.prjindex.RecomIndexService');

--��Ŀ��ЧĿ�������ȼ�ЧĿ��  ��ѡָ��
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/prjindex/pickindex';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/pickindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'pickpage', '{main:[toolbutton,queryform,picktable]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/prjindex/pickindex';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'pmkpi_editindex', '{}', 'pmkpieditindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'busqueryform', '{}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'pmkpi_pickindex', '{}', 'pmkpipickindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/pickindex', 'busuidatatable', '{addrow:false,nogroupbox:false,name:''��Чָ��'',edit:false,checkbox:false,checkbox:true,title:''��Чָ��'',nextSibling:false}', 'picktable', 'pmkpi', null);


delete from Bus_t_Pagecomponent t where t.id='pmkpi_pickindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_pickindex', '��ѡָ��', null, '��ѡָ��', '/pmkpi/perfprogram/prjindex/pickindex.js', 'Ext.lt.pmkpi.pickindexservice', 'pmkpi', 'pmkpi.prjindex.IndexPickService');


--��Ŀ��ЧĿ�������ȼ�ЧĿ��  �޸�ָ��
delete from Bus_t_Pageconsole t where t.url='/pmkpi/program/prjindex/editindex';
insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/program/prjindex/editindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'editpage', '{main:[indexform],footer:[indexeditbtn]}', null, null, 0);

delete from Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/program/prjindex/editindex';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/editindex', 'pmkpi_editindex', '{}', 'pmkpieditindex', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/editindex', 'bustoolbutton', '{}', 'indexeditbtn', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/prjindex/editindex', 'buseditform', '{name:''�༭��'',columnsize:2,amtflag:2}', 'indexform', 'pmkpi', null);

delete from Bus_t_Pagecomponent t where t.id='pmkpi_editindex';
insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
values ('pmkpi_editindex', '�༭ָ��', null, '�༭ָ��', '/pmkpi/perfprogram/prjindex/indexedit.js', 'Ext.lt.pmkpi.indexedit', 'pmkpi', 'pmkpi.prjindex.IndexEditService');
