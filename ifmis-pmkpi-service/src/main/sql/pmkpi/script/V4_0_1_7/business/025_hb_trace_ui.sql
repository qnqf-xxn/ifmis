begin
  
DELETE FROM p#Busfw_t_Uitable t where t.key='/pmkpi/program/trace/hbreport';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('327826C7A3D64BA194971C0DA9F4FD34', '/pmkpi/program/trace/hbreport', 'PERF_V_HBPROMONITOR', 100, 0, 0, null, null, 'pmkpi', null);

DELETE FROM p#Busfw_t_Uicolumn t where t.key='/pmkpi/program/trace/hbreport';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2788BDBA290341BF82A7A6FEAE7B9BD6', '/pmkpi/program/trace/hbreport', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F51FD7414E504029862B259564B0ECDE', '/pmkpi/program/trace/hbreport', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F9578EBC33A04154B176293AD3C5BC9C', '/pmkpi/program/trace/hbreport', 'TASKTYPE', '任务类型', 1, 0, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E5FE53F0EC844293922CB0971432828E', '/pmkpi/program/trace/hbreport', 'PRO_CODE', '项目编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('AB6006971BB54590BA078D463220A981', '/pmkpi/program/trace/hbreport', 'PRO_NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C469072B2F104BCA92273F890028293B', '/pmkpi/program/trace/hbreport', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 180, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('801FA24591A44BA69B235379BF6AC038', '/pmkpi/program/trace/hbreport', 'TASKSTAGE', '监控阶段', 9, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A7D3F5288E5B473D9A9F0E4BE91358A5', '/pmkpi/program/trace/hbreport', 'WARNDAYS', '预警截止天数', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D68567CC87EA47B3A3EC6A5B532E42A5', '/pmkpi/program/trace/hbreport', 'FININTORGGUID', '业务处室', 11, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('02E2A190E6B540B9945D877A74566A2D', '/pmkpi/program/trace/hbreport', 'BGTWARN', '预算执行预警', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D1EF927B13FE4BDA8BD910AC8ADA0500', '/pmkpi/program/trace/hbreport', 'GOALWARN', '目标完成预警', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C74D63045E6B48B397B62DFF0EF67FFD', '/pmkpi/program/trace/hbreport', 'DEPTTASK', '自行监控', 15, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A99ABFD68D1445D48A8FB02B788D2AF9', '/pmkpi/program/trace/hbreport', 'PROVINCETASK', '重点监控', 16, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B1A8525F3B8A4F168947A1CEC1ED093A', '/pmkpi/program/trace/hbreport', 'WARN', '预警', 17, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);


DELETE FROM p#Busfw_t_Uitabpage t where t.key='/pmkpi/program/trace/hbdualaudit';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3F498D078124B5DA432F37F978ECCDB', 'pmkpi', '/pmkpi/program/trace/hbdualaudit', '待审核', 'waitaudit', 1, 1, 'choosed', 'protracehbdualaudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('2C7FF4811EC44F69A03538FDDE1A52DE', 'pmkpi', '/pmkpi/program/trace/hbdualaudit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'protracehbdualaudit.clickTabpage', null, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('576C4F4B684C43AEA866EA034F379FF7', 'pmkpi', '/pmkpi/program/trace/hbdualaudit', '曾经办', 'alldeals', 1, 3, 'nomal', 'protracehbdualaudit.clickTabpage', null, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);


DELETE FROM p#Busfw_t_Uifunction t where t.key='/pmkpi/program/trace/hbdualaudit';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('55397C57B05B41C3B1C54BA6AF8DDF20', '/pmkpi/program/trace/hbdualaudit', '发起目标调整', 0, 10, 'searchicon', 'protracehbdualaudit.adjustTarget', null, '发起目标调整', 'pmkpi', 'adjustTarget', null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7ADF556829EE4CF7861DEDC26EA2FB21', '/pmkpi/program/trace/hbdualaudit', '发起监控整改', 0, 11, 'searchicon', 'protracehbdualaudit.monRect', null, '发起监控整改', 'pmkpi', 'monRect', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CE14B1815F9047C5A9DA2948CF894DCC', '/pmkpi/program/trace/hbdualaudit', '审核', 1, 4, 'searchicon', 'protracehbdualaudit.audit', null, '审核', 'pmkpi', 'sendaudit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('5614D6B04937437CA55EB25F5695CC87', '/pmkpi/program/trace/hbdualaudit', '取消审核', 1, 5, 'searchicon', 'protracehbdualaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2E55ABE608EE426A9049AF22409EA479', '/pmkpi/program/trace/hbdualaudit', '审核情况', 1, 6, 'searchicon', 'protracehbdualaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4723FF9641B647D6945DC848F4A97654', '/pmkpi/program/trace/hbdualaudit', '导出列表', 1, 9, 'searchicon', 'protracehbdualaudit.export', null, '导出列表', 'pmkpi', 'export', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('63794AE6FADA478EB05C8825108EBEBC', '/pmkpi/program/trace/hbdualaudit', '导出报告', 1, 8, 'searchicon', 'Ext.lt.pmkpi.expdoc', null, '导出报告', 'pmkpi', 'expdoc', null, '{tempatecode:''tracereportindex''}');
