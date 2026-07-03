begin
  
DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/adjust/report' and t.componentid in ('deptqueryform','deptdatatable');
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busqueryform', '{key:''/pmkpi/adjust/report/dept'',name:''部门整体查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'deptqueryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report', 'busuidatatable', '{key:''/pmkpi/adjust/report/dept'',name:''部门整体绩效目标调整表'',checkbox:true,title:''绩效目标调整表'',edit:false,addrow:false}', 'deptdatatable', 'pmkpi', null);

DELETE FROM Bus_t_Pageconsolecomconfig t where t.url='/pmkpi/review/report/list' and t.componentid in ('deptqueryform','deptdatatable');
insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busqueryform', '{key:''/pmkpi/review/report/dept'',name:''部门整体查询区'',datatable:''datatable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'deptqueryform', 'pmkpi', null);

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/review/report/list', 'busuidatatable', '{key:''/pmkpi/review/report/dept'',name:''部门整体绩效目标评审表'',checkbox:true,title:''项目绩效申报'',edit:false,addrow:false,pagetype:''report'',uikey:''/pmkpi/assess/goal/edit''}', 'deptdatatable', 'pmkpi', null);
