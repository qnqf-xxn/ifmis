begin
  --部门整体绩效监控 监控分析编辑区添加字段(发版默认隐藏)
delete from p#busfw_t_uieditform where key ='/pmkpi/trace/report/deptedit/analysis' and columncode in('NDGOAL','MEASURES');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values ('EE8513532B773E79E0533315A8C08CF2', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '年度预期目标', 'NDGOAL', 0, null, 0, null, 9, 3, '2', 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values ('EE8513532B763E79E0533315A8C08CF2', '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '目标完成情况', 'MEASURES', 0, null, 1, null, 10, 3, '2', 'pmkpi', 1, null, '{}', null, null, null, null, null, null);
