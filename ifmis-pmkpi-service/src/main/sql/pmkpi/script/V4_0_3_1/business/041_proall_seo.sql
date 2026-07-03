begin
  delete FROM Bus_t_Pageconsolecomconfig t where t.url in ('/pmkpi/allseo/project/allinfo','/pmkpi/allseo/project/index');
  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/index', 'pmkpi_proallseo', '{}', 'pmkpiproallseo', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/index', 'header', '{}', 'header', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/index', 'busuidatatable', '{key:''/pmkpi/yearprogram/query/list'',checkbox:false,radio:true,edit:false}', 'datatable', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/index', 'busqueryform', '{key:''/pmkpi/yearprogram/query/list'',name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis'',edit:false}', 'monitoreditform5', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis'',edit:false}', 'monitoreditform4', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'pmkpi_proallinfo', '{}', 'pmkpiproallinfo', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/report/edit'',headsort:false,name:''项目基本信息'',edit:false,title:''项目基本信息'',nextSibling:false}', 'baseditform', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/report/protabgoal'',headsort:false,name:''中长期目标'',edit:false,title:''中长期目标'',nextSibling:false}', 'totaleditform', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/report/protabgoal'',headsort:false,name:''年度目标'',edit:false,title:''年度目标'',nextSibling:false}', 'yeareditform', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:false,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',rowtolist:false,title:''中长期绩效指标''}', 'totaldatatable', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'busuidatatable', '{headsort:false,addrow:false,nogroupbox:true,edit:false,checkbox:true,groupcols:[''guid'',''superid'',''name'',''levelno''],treedata:true,treemapping:null,initlevel:6,isuphide:false,editgroupdata:true,nextSibling:false,key:''/pmkpi/program/report/treeindex'',rowtolist:false,title:''年度绩效指标''}', 'yeardatatable', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis'',edit:false}', 'monitoreditform1', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis'',edit:false}', 'monitoreditform2', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/program/trace/report/edit/analysis'',title:''监控分析'',tablecode:''v_perf_t_protraceanalysis'',edit:false}', 'monitoreditform3', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/perfself/apply/edit/selfdesc'',headsort:false,edit:false,title:''绩效自评结果'',nextSibling:false,table:"V_PERF_T_SELFPERFDESC"}', 'selfeditform', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/evaluation/dept/result/edit'',tablecode:''v_perf_t_deptevaluation'',title:''部门评价结果'',edit:false}', 'deptevaleditform', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/allseo/project/allinfo', 'buseditform', '{key:''/pmkpi/evaluation/financial/result/edit'',iswf:''true'',tablecode:''v_perf_t_finevaluation'',title:''财政评价结果'',edit:false}', 'finaneditform', 'pmkpi', null);

  delete FROM Bus_t_Pageconsole t where t.url in ('/pmkpi/allseo/project/allinfo','/pmkpi/allseo/project/index');
  insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
  values ('/pmkpi/allseo/project/allinfo', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.allseo.ProSeoPage', 'editindex', '{left:lefttree,main:[baseditform,totaleditform,yeareditform,totaldatatable,yeardatatable,monitoreditform1,monitoreditform2,monitoreditform3,monitoreditform4,monitoreditform5,selfeditform,deptevaleditform,finaneditform],heights:[null,null,null,600,600]}', null, null, 0);

  insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
  values ('/pmkpi/allseo/project/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.allseo.ProSeoPage', 'index', '{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}', null, null, 0);

  delete FROM Bus_t_Pagecomponent t where t.id in ('pmkpi_proallinfo','pmkpi_proallseo');
  
  insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
  values ('pmkpi_proallinfo', '项目全信息查询', null, '项目全信息查询', '/pmkpi/allseo/proallinfo.js', 'Ext.lt.pmkpi.proallinfo', 'pmkpi', 'pmkpi.allseo.ProAllInfo');

  insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
  values ('pmkpi_proallseo', '项目全过程绩效查询', null, '项目全过程绩效查询', '/pmkpi/allseo/proseo.js', 'Ext.lt.pmkpi.proseo.index', 'pmkpi', 'pmkpi.allseo.ProSeoService');

  delete FROM Busfw_t_Uifunction t where t.key = '/pmkpi/allseo/project/index';
  
  insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
  values (sys_guid(), '/pmkpi/allseo/project/index', '查看详情', 1, 1, 'searchicon', 'pmkpiproallseo.allinfo', null, '查看详情', 'pmkpi', 'query', null, null, '87', '2016');

  delete FROM Perf_t_Datasource t where t.elementcode = 'proallseo';
  
  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('proindex', '301', '绩效指标', null, '00', 1, 0, 301, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('yeareditform', '203', '年度目标', null, 'progoal', 2, 1, 203, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('totaleditform', '202', '中长期目标', null, 'progoal', 2, 1, 202, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('baseditform', '101', '基本信息', null, '00', 1, 1, 101, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('progoal', '201', '绩效目标', null, '00', 1, 0, 201, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('totaldatatable', '302', '中长期指标', null, 'proindex', 2, 1, 302, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('yeardatatable', '303', '年度指标', null, 'proindex', 2, 1, 303, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('protrace', '401', '绩效监控结果', null, '00', 1, 0, 401, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('selfeditform', '501', '绩效自评结果', null, '00', 1, 1, 501, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('deptevaleditform', '601', '部门评价结果', null, '00', 1, 1, 601, 'proallseo', 1, '20221102', '20221102', 2016, '87');

  insert into Perf_t_Datasource (GUID, CODE, NAME, REMARK, SUPERGUID, LEVELNO, ISLEAF, ORDERNUM, ELEMENTCODE, STATUS, CREATETIME, UPDATETIME, YEAR, PROVINCE)
  values ('finaneditform', '701', '财政评价结果', null, '00', 1, 1, 701, 'proallseo', 1, '20221102', '20221102', 2016, '87');
