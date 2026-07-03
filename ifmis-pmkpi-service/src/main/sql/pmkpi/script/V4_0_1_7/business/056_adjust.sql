begin

delete from bus_t_pageconsole t where t.url in('/pmkpi/adjust/report/deptedit/index');
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/adjust/report/deptedit/index', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.adjust.index.AdjustIndexPage', 'index', '{main:[toolbutton,datatable]}', null, null, null);


delete from p#busfw_t_uieditform t where t.key in('/pmkpi/adjust/report/deptedit/goal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BA167C07PPBC4655E053B11FA8C02221', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整说明', 'ADJUSTREMARK', 1, null, 1, null, 1, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B64DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 's', 'GUID', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B64DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 's', '业务类型代码', 'BUSI_TYPE_CODE', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B65DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整前年度绩效目标', 'KPI_TARGET', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9D8BDAA8B66DDAEE053B11FA8C04101', '/pmkpi/adjust/report/deptedit/goal', 'V_PERF_T_ADJUSTGOAL', 'textarea', '调整后年度绩效目标', 'ADJUSTNDGOAL', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

update p#busfw_t_uicolumn t set t.isedit=1 where t.key in('/pmkpi/adjust/report/deptedit/index') and t.columncode='INDEXVAL';
