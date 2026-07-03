begin

--合肥预算执行情况
delete from p#busfw_t_uieditform t where t.key in('/pmkpi/trace/report/proedit/warn/goal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34E08274CE0533315A8C0ACDD', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'boolean', '达到预期绩效目标', 'ISGOAL', 1, null, 1, null, 1, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34E0C274CE0533315A8C0ACDD', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '年度总体目标', 'NDGOAL', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34E0D274CE0533315A8C0ACDD', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '绩效目标执行情况', 'MEASURES', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DC98B644AAF3387EE0533315A8C05B69', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'tree', '原因类型', 'REASONTYPE', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34E0F274CE0533315A8C0ACDD', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 's', 'guid', 'GUID', 0, null, 0, null, 5, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D4D3D3E34E0E274CE0533315A8C0ACDD', '/pmkpi/trace/report/proedit/warn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '未达到支出进度和绩效目标原因分析', 'DEVIATION', 1, null, 0, null, 9, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

--合肥一般监控导入导出按钮
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/report') and t.code in('ordexpdoc','ordimpdoc','commonimport');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DC6D0EBF40F54559E0533315A8C0017C', '/pmkpi/program/trace/report', '一般监控模板导出', 0, 14, 'searchicon', 'protaskreport.expdoc', null, '一般监控模板导出', 'pmkpi', 'ordexpdoc', null, '{tempatecode:''hfybjkb'',exptype:''ordprogram''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DC6D0EBF40F64559E0533315A8C0017C', '/pmkpi/program/trace/report', '一般监控导入', 0, 15, 'searchicon', 'protaskreport.impdoc', null, '一般监控导入', 'pmkpi', 'ordimpdoc', null, '{impexpcode:''traceordprogram'',impServicetype:''ordprogram''}');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/trace/report') and t.code in('alreadyaudit','alldeals','back');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9C4261289047117E0533315A8C0B939', 'pmkpi', '/pmkpi/program/trace/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'protaskreport.clickTabpage', null, '已送审', null, '填报/修改,删除,送审,一般监控模板导出,一般监控导入', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9C4261289067117E0533315A8C0B939', 'pmkpi', '/pmkpi/program/trace/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'protaskreport.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审,一般监控模板导出,一般监控导入', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9C4261289077117E0533315A8C0B939', 'pmkpi', '/pmkpi/program/trace/report', '被退回', 'back', 1, 3, 'nomal', 'protaskreport.clickTabpage', null, '被退回', null, '取消送审,一般监控模板导出,一般监控导入', '{}', null, '0', null, null, null, null, null, null, null);
