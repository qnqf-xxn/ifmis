begin

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/report') and t.code in('ahexpdoc','hfexpdoc','ahimpdoc','hfimpdoc');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DDAE5EE67B270D2BE0533315A8C0290E', '/pmkpi/program/trace/report', '监控模板导出（安徽）', 0, 20, 'searchicon', 'protaskreport.expdoc', null, '监控模板导出（安徽）', 'pmkpi', 'ahexpdoc', null, '{protempatecode:''ahxmjxjkbg'',depttempatecode:''ahbmztjxjkbg'',proexptype:''ahprogram'',deptexptype:''ahdept''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DDAE5EE67B280D2BE0533315A8C0290E', '/pmkpi/program/trace/report', '监控导入（安徽）', 0, 21, 'searchicon', 'protaskreport.impdoc', null, '监控导入（安徽）', 'pmkpi', 'ahimpdoc', null, '{impServicetype:''impreport'',protempatecode:''ahxmjxjkbg'',depttempatecode:''ahbmztjxjkbg'',impreporttype:''ah''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFBC838A63A420ACE0533315A8C0681A', '/pmkpi/program/trace/report', '监控模板导出（合肥）', 0, 22, 'searchicon', 'protaskreport.expdoc', null, '监控模板导出（合肥）', 'pmkpi', 'hfexpdoc', null, '{protempatecode:''hfxmzczdjkmb'',depttempatecode:''hfbmztjkmb'',proexptype:''hfprogram'',deptexptype:''hfdept''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFBC838A63A520ACE0533315A8C0681A', '/pmkpi/program/trace/report', '监控导入（合肥）', 0, 23, 'searchicon', 'protaskreport.impdoc', null, '监控导入（合肥）', 'pmkpi', 'hfimpdoc', null, '{impServicetype:''impreport'',protempatecode:''hfxmzczdjkmb'',depttempatecode:''hfbmztjkmb'',impreporttype:''hf''}');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/program/trace/report');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9C4261289057117E0533315A8C0B939', 'pmkpi', '/pmkpi/program/trace/report', '待送审', 'waitaudit', 1, 1, 'choosed', 'protaskreport.clickTabpage', null, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9C4261289047117E0533315A8C0B939', 'pmkpi', '/pmkpi/program/trace/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'protaskreport.clickTabpage', null, '已送审', null, '填报/修改,删除,送审,一般监控模板导出,一般监控导入,监控模板导出（安徽）,监控导入（安徽）,监控模板导出（合肥）,监控导入（合肥）', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9C4261289077117E0533315A8C0B939', 'pmkpi', '/pmkpi/program/trace/report', '被退回', 'back', 1, 3, 'nomal', 'protaskreport.clickTabpage', null, '被退回', null, '取消送审,一般监控模板导出,一般监控导入,监控模板导出（安徽）,监控导入（安徽）,监控模板导出（合肥）,监控导入（合肥）', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9C4261289067117E0533315A8C0B939', 'pmkpi', '/pmkpi/program/trace/report', '曾经办', 'alldeals', 1, 4, 'nomal', 'protaskreport.clickTabpage', null, '曾经办', null, '填报/修改,删除,送审,取消送审,一般监控模板导出,一般监控导入,监控模板导出（安徽）,监控导入（安徽）,监控模板导出（合肥）,监控导入（合肥）', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/program/trace/query') and t.code in('ahexpdoc','hfexpdoc','ordexpdoc');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFF8BD467E934FF8E0533315A8C0D3F9', '/pmkpi/program/trace/query', '一般监控导出（合肥）', 0, 19, 'searchicon', 'protracequery.expdoc', null, '一般监控导出（合肥）', 'pmkpi', 'ordexpdoc', null, '{tempatecode:''hfybjkb'',exptype:''ordprogram''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFF8BD467E944FF8E0533315A8C0D3F9', '/pmkpi/program/trace/query', '监控报告导出（安徽）', 0, 20, 'searchicon', 'protracequery.expdoc', null, '监控报告导出（安徽）', 'pmkpi', 'ahexpdoc', null, '{protempatecode:''ahxmjxjkbg'',depttempatecode:''ahbmztjxjkbg'',proexptype:''ahprogram'',deptexptype:''ahdept''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DFF8BD467E954FF8E0533315A8C0D3F9', '/pmkpi/program/trace/query', '监控报告导出（合肥）', 0, 22, 'searchicon', 'protracequery.expdoc', null, '监控报告导出（合肥）', 'pmkpi', 'hfexpdoc', null, '{protempatecode:''hfxmzczdjkmb'',depttempatecode:''hfbmztjkmb'',proexptype:''hfprogram'',deptexptype:''hfdept''}');

--一般项目监控-阶段监控填报
delete from p#busfw_t_uieditform t where t.key in('/pmkpi/trace/report/proedit/ordwarn/goal');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DFF8BD467E964FF8E0533315A8C0D3F9', '/pmkpi/trace/report/proedit/ordwarn/goal', 'V_PERF_T_PROTRACEANALYSIS', 's', 'guid', 'GUID', 0, null, 0, null, 5, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DFF8BD467E974FF8E0533315A8C0D3F9', '/pmkpi/trace/report/proedit/ordwarn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'tree', '原因类型', 'REASONTYPE', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DFF8BD467E984FF8E0533315A8C0D3F9', '/pmkpi/trace/report/proedit/ordwarn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '未达到支出进度和绩效目标原因分析', 'DEVIATION', 1, null, 0, null, 9, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DFF8BD467E994FF8E0533315A8C0D3F9', '/pmkpi/trace/report/proedit/ordwarn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'boolean', '达到预期绩效目标', 'ISGOAL', 1, null, 1, null, 1, 3, '1', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DFF8BD467E9A4FF8E0533315A8C0D3F9', '/pmkpi/trace/report/proedit/ordwarn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '年度总体目标', 'NDGOAL', 1, null, 0, null, 2, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DFF8BD467E9B4FF8E0533315A8C0D3F9', '/pmkpi/trace/report/proedit/ordwarn/goal', 'V_PERF_T_PROTRACEANALYSIS', 'textarea', '绩效目标执行情况', 'MEASURES', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uitable t where t.key in('/pmkpi/trace/report/proedit/ordwarn/fund');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('DFF8BD467E9F4FF8E0533315A8C0D3F9', '/pmkpi/trace/report/proedit/ordwarn/fund', 'V_PERF_T_PROBGTFUND', 0, 0, 0, null, null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/trace/report/proedit/ordwarn/fund');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CB75DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'PRO_NAME', '项目名称', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CB85DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'AMT1', '年初预算', 2, 1, 0, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CB95DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'AMT2', '调整后预算', 3, 0, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CBA5DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'AMT7', '追加预算数', 3, 1, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CBB5DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'AMT8', '追减预算数', 4, 1, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CBC5DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'AMT3', '年度预算调整', 5, 1, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CBD5DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'AMT4', '累计支出', 6, 1, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CBE5DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'BGTGET', '预算执行率%', 7, 1, 1, 0, null, 0, 6, null, null, null, null, 80, 0, 'f', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CBF5DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'AMT5', '项目指标结余', 10, 0, 1, 1, null, 0, 6, null, null, null, null, 80, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CC05DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'ISEDIT', '是否编辑', 20, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DFF94C575CC15DB9E0533315A8C04C9E', '/pmkpi/trace/report/proedit/ordwarn/fund', 'NAME', '资金来源', 99, 0, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

--一般监控-修改阶段监控填报url
update p#busfw_t_uitabpage t set t.config='{url:''/pmkpi/trace/report/proedit/ordwarn.page?protype=ordprogram'',busguid:''BA6668DFDF231167E053B11FA8C08965'',action:''tracewarn.save''}' where t.key in('/pmkpi/program/trace/report/ordinaryedit') and t.code='protracefund';
