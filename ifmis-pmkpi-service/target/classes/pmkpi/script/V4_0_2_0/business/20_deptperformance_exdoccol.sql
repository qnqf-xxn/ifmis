begin
    
DELETE FROM Bus_t_Pageconsolecomconfig t WHERE t.url='/pmkpi/deptperformance/query/index';
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'pmkpi_deptperformancequery', '{}', 'deptperformancequery', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'busuidatatable', '{name:''部门绩效'',checkbox:true,title:''部门绩效'',edit:false,addrow:false,uikey:''/pmkpi/deptperformance/report/edit''}', 'datatable', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'bustoolbutton', '{}', 'toolbutton', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'header', '{}', 'header', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'buslefttree', '{}', 'lefttree', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'busqueryform', '{name:''查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptperformance/query/index', 'busfw.dataexport', '{}', 'dataexport', 'pmkpi', null);



DELETE FROM  P#busfw_t_Uifunction t WHERE t.key='/pmkpi/deptperformance/query/index' and t.code='export';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('553CDB5BD6534A678E5C5618F162DDF6', '/pmkpi/deptperformance/query/index', '导出列表', 1, 3, 'searchicon', 'deptperformancequery.export', null, '导出列表', 'pmkpi', 'export', null, '{}');
