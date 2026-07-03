begin
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/program/trace/report/edit/info';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'pmkpi_protraceinfo', '{}', 'protraceinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'buseditform', '{key:''/pmkpi/program/report/trace/edit'',title:''项目基础信息'',tablecode:''v_perf_project_info''}', 'infoeditform', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/program/trace/report/edit/info', 'buseditform', '{title:''监控信息'',tablecode:''v_perf_t_promonitor''}', 'traceeditform', 'pmkpi', null);


--项目支出绩效监控填报 - 基本信息编辑区添加字段，重新注册编辑区，与项目申报基本信息的key区分 
--从原来key里复制编辑区字段，只修改guid和key，其他值不变
delete from p#busfw_t_uieditform t where key ='/pmkpi/program/report/trace/edit';
insert into busfw_t_uieditform (GUID, key, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD)
select sys_guid(), '/pmkpi/program/report/trace/edit', TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD
from busfw_t_uieditform where key ='/pmkpi/program/report/edit';

--新加的字段（填报人、填报人联系方式） 默认隐藏
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD)
values (sys_guid(), '/pmkpi/program/report/trace/edit', 'PERF_V_PROMONITOR', 's', '填报人', 'FillMAN', 1, null, 1, null, 2050, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD)
values (sys_guid(), '/pmkpi/program/report/trace/edit', 'PERF_V_PROMONITOR', 's', '填报人联系方式', 'FillCONTACTTYPE', 1, null, 1, null, 2060, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null);
