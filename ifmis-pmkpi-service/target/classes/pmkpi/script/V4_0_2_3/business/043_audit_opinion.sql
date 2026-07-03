begin
-- 审核页面，右侧意见标题改为  "审核意见"
delete from bus_t_pageconsolecomconfig where url ='/pmkpi/audit/index/opinion';
insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/opinion', 'pmkpi_auditinfo', '{}', 'auditinfo', 'pmkpi', null);

insert into bus_t_pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/audit/index/opinion', 'buseditform', '{title:''审核意见''}', 'editform', 'pmkpi', null);

-- 录入意见框的大小比例
delete from p#busfw_t_uieditform where key ='/pmkpi/audit/index/opinion';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34B9A274CE0533315A8C0ACDD', '/pmkpi/audit/index/opinion', 'PERF_T_AUDITMAIN', 'textarea', null, 'REMARK', 1, null, 0, null, 1, 1, '8', 'pmkpi', 1, null, '{}', 0, 0, 0);

--监控审核页面 
delete from busfw_t_uieditform where key ='/pmkpi/audit/index/traceopinion';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34C65274CE0533315A8C0ACDD', '/pmkpi/audit/index/traceopinion', 'PERF_T_AUDITMAIN', 'textarea', null, 'REMARK', 1, null, 0, null, 2, 1, '6', 'pmkpi', 1, null, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34C66274CE0533315A8C0ACDD', '/pmkpi/audit/index/traceopinion', 'PERF_T_PROMONITOR', 'tree', '审核方式', 'AUDITTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', 0, 0, 0);

