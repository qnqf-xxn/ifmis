begin

--绩效目标调整-年度任务页签-busui [保存按钮]
delete from p#busfw_t_uitabpage where key ='/pmkpi/adjust/report/deptedit' and code = 'yeartask';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378D7274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/adjust/report/deptedit', '年度任务', 'yeartask', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '年度任务', null, null, '{url:''/pmkpi/adjust/report/deptedit/task.page'',action:''adjustquery.save'',busguid:''B9D8BDAA8B2EDDAEE053B11FA8C04101''}', null, '0', 'yeartaskiframe', null, null, null, null, null, null);

--是否可编辑，是否新增行
delete from bus_t_pageconsolecomconfig where url = '/pmkpi/adjust/report/deptedit/task';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/task', 'pmkpi_adjusteditquery', '{}', 'adjustquery', 'pmkpi', null);
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/adjust/report/deptedit/task', 'busuidatatable', '{key:''/pmkpi/deptperformance/report/perftask'',name:''年度任务'',checkbox:true,title:''年度任务'',edit:true,addrow:true}', 'datatable', 'pmkpi', null);


