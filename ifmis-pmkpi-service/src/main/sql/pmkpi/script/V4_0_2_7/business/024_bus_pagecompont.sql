begin
  delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptperformance/report/edit' and t.id in ('deptamtdatatable','deptproexpdatatable');
  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/deptamt'',addrow:false,headsort:false,name:''部门总体资金'',edit:true,checkbox:false,radio:false,title:''部门总体资金'',nextSibling:false}', 'deptamtdatatable', 'pmkpi', null);

  insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
  values ('/pmkpi/deptperformance/report/edit', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/deptproexp'',addrow:true,headsort:false,name:''项目支出情况'',edit:true,checkbox:true,title:''项目支出情况'',nextSibling:false}', 'deptproexpdatatable', 'pmkpi', null);

