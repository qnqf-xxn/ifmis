
begin


update bus_t_pageconsole t set t.config='{header:[header],left:lefttree,main:[toolbutton,queryform,datatable]}',t.page='/busfw/common/template/template_defautl.jsp',
t.JSLIB='/busfw/common/template/template_default.js,/pmkpi/common/perfcommon.js,/pmkpi/common/perfutil.js,/pmkpi/common/ueditor/ueditor.config.js,/pmkpi/common/ueditor/ueditor.all.js' where t.url='/pmkpi/setting/perfenumset';

update bus_t_pageconsole t set t.config='{header:[header],main:[toolbutton,queryform,datatable]}' where t.url='/pmkpi/auditviewinfo/index';
update BUS_T_PAGECONSOLECOMCONFIG t set t.id='queryform' where t.url='/pmkpi/auditviewinfo/index' and t.id='busquery';

update bus_t_pageconsole t set t.config='{header:[header],main:[toolbutton,tabpage,datatable]}' where t.url='/pmkpi/auditdefine/index';

update p#busfw_t_uifunction t set t.ACTION='deptZJlist.checkprogram' where t.key ='/pmkpi/deptZJformanceadjust/report/index'
                                                                       and t.action='deptZJlist.add';

update BUS_T_PAGECONSOLE t set t.config='{main:[queryform,datatable],footer:[toolbutton]}'
where t.url = '/pmkpi/case/report/check';

update BUS_T_PAGECONSOLECOMCONFIG t set t.config='{name:''案例库'',checkbox:true,title:''案例库'',edit:false,addrow:false,uikey:''/pmkpi/setting/modelinfo/edit'',deltables:[v_perf_t_casemodelgoal,v_perf_t_casemodelindex]}'
where t.url='/pmkpi/setting/model/list' and t.id='datatable';

update BUS_T_PAGECONSOLE t set t.config='{main:[queryform,datatable],footer:[toolbutton]}'
where t.url = '/pmkpi/indexlib/procheck';
update BUS_T_PAGECONSOLE t set t.config='{main:[queryform,datatable],footer:[toolbutton]}'
where t.url = '/pmkpi/indexlib/deptcheck';





