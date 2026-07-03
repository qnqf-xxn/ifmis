i integer;
begin
  delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/program/prjindex/recomindex';
  delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/program/prjindex/recomindex';
  delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_recomindex';
  
  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/program/prjindex/recomindex', 'pmkpi_recomindex', '{}', 'pmkpirecomindex', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/program/prjindex/recomindex', 'busuidatatable', '{headsort:false,addrow:false,name:''绩效指标'',edit:true,checkbox:true,title:''绩效指标'',nogroupbox:true}', 'recomtable', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/program/prjindex/recomindex', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/program/prjindex/recomindex', 'bustabpage', '{}', 'tab', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/program/prjindex/recomindex', 'busqueryform', '{name:''查询区'',fastquery:true,datatable:''recomtable'',drawmode:''table'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

  insert into Bus_t_Pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
  values ('/pmkpi/program/prjindex/recomindex', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexPage', 'cmpage', '{header:[tab],main:[queryform,recomtable]}', null, null, 0);

  insert into Bus_t_Pagecomponent (ID, NAME, TYPE, REMARK, JSLIB, JSOBJECTNAME, APPID, SERVICE)
  values ('pmkpi_recomindex', '精准推荐', null, '精准推荐', '/pmkpi/perfprogram/prjindex/recoindex.js', 'Ext.lt.pmkpi.recomindexservice', 'pmkpi', 'pmkpi.prjindex.RecomIndexService');
  
  SELECT count(*) into i FROM Busfw_t_Uitable t where t.key = '/pmkpi/program/prjindex/recomindex';
  if i=0 then
     insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
     values ('prjindex/recomindextable001', '/pmkpi/program/prjindex/recomindex', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{title:"绩效指标"}', '87', '2016');
  end if;
  
  SELECT count(*) into i FROM Busfw_t_Uicolumn t where t.key = '/pmkpi/program/prjindex/recomindex';
  if i=0 then
     insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex004', '/pmkpi/program/prjindex/recomindex', 'INDEXCATEGORIES', '行业大类', 44, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex005', '/pmkpi/program/prjindex/recomindex', 'INDUSTRYCATEGORY', '行业类别', 46, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex006', '/pmkpi/program/prjindex/recomindex', 'FUNDUSE', '资金用途', 47, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex007', '/pmkpi/program/prjindex/recomindex', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex008', '/pmkpi/program/prjindex/recomindex', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex009', '/pmkpi/program/prjindex/recomindex', 'NAME', '内容', 13, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex010', '/pmkpi/program/prjindex/recomindex', 'COMPUTESIGN', '性质', 14, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex011', '/pmkpi/program/prjindex/recomindex', 'INDEXVALUE', '参考值', 15, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex012', '/pmkpi/program/prjindex/recomindex', 'METERUNIT', '单位', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex013', '/pmkpi/program/prjindex/recomindex', 'EXPLAIN', '指标解释', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex014', '/pmkpi/program/prjindex/recomindex', 'INDEXSTANDARDS', '绩效标准', 35, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

    insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
    values ('pmkpiprjindexrecomindex015', '/pmkpi/program/prjindex/recomindex', 'KEYWORD', '关键词', 30, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');
  end if;