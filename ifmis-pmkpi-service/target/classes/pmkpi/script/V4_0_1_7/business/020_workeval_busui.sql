begin

--绩效工作管理考核填报
delete from p#busfw_t_uitable t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C3372D3FF15C5B5CE053B11FA8C07204', '/pmkpi/workevaluate/report/list', 'V_PERF_T_WORKTASKASSIGN', 100, 0, 0, 'code', null, 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E038AC05FA715FB5D8CBA9DF56D60D16', '/pmkpi/workevaluate/report/list', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDDF86FB3E0533315A8C08CFB', '/pmkpi/workevaluate/report/list', 'CODE', '县（区）编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{type:''subprovince''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('464CE079612E9A4BDDA7D7C15490549F', '/pmkpi/workevaluate/report/list', 'CODE', '部门编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A5192B6C857297D8C61E2049229F991A', '/pmkpi/workevaluate/report/list', 'NAME', '部门名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDDF96FB3E0533315A8C08CFB', '/pmkpi/workevaluate/report/list', 'NAME', '县（区）名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{type:''subprovince''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2368F15ADE886EF2C9F0600CFF12F769', '/pmkpi/workevaluate/report/list', 'AGENCYGUID', '预算部门', 5, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('164B118AE4048474CABF3356E961CA8D', '/pmkpi/workevaluate/report/list', 'TASKTYPE', '考核对象', 6, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6A36D60D8512CBD9E26EB5620969C210', '/pmkpi/workevaluate/report/list', 'TASKYEAR', '考核年度', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FEBF7FC5A92BE54A9977D333779CC017', '/pmkpi/workevaluate/report/list', 'GUID', 'guid', 10, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A3128DF5C82B797EB26FC8B9A27D7DE6', '/pmkpi/workevaluate/report/list', 'STARTDATE', '开始时间', 11, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('41343296EB325AF6F6C8E663979094EF', '/pmkpi/workevaluate/report/list', 'ENDDATE', '截止时间', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/report/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('A03E6F987C1D404FBDF88F6468818F23', '/pmkpi/workevaluate/report/list', '填报/修改', 1, 2, 'searchicon', 'workevalreport.addOredit', null, '填报/修改', 'pmkpi', 'save', null, '{deptworkeval2:''deptkeywork''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3102DB9EBF8CB5D8A86B7FA3248B7F3F', '/pmkpi/workevaluate/report/list', '送审', 1, 4, 'searchicon', 'workevalreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{remark:true,subprostatus:''008''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('586816E91ECE7E14FF6D27F4CD1EFF46', '/pmkpi/workevaluate/report/list', '取消送审', 1, 5, 'searchicon', 'workevalreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{subprostatus:''00''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('25DACAAB9CB8692334C7DEDDEDE70A44', '/pmkpi/workevaluate/report/list', '审核情况', 1, 6, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('856178FF1BF085B75087580B8401EA5C', '/pmkpi/workevaluate/report/list', '查看明细', 1, 7, 'searchicon', 'workevalreport.addOredit', null, '查看明细', 'pmkpi', 'querydetailed', null, '{deptworkeval2:''deptkeywork''}');

--绩效工作管理考核填报（区县）
delete from p#busfw_t_uieditform t where t.key in('/pmkpi/workevaluate/report/subpedit/info');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3C5ECFF8E30AEE0DF8FAB81FBAF2D4C0', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '县（市）区编码', 'CODE', 1, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('978B72B3CA0F980FA7D563EFB0E7399D', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '县（市）区名称', 'NAME', 1, null, 0, null, 2, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('AC3E938A786F2A5191A57666AF29FF08', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '联系方式', 'TEL', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('25EF1C321EA9CD87DC3D5DDD4FA34D81', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '填报人', 'LINKMAN', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C67BB31E4C00596CCEA3A58A74205068', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '事前绩效评估覆盖率', 'ASSESSMENTRATE', 1, null, 0, null, 10, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('10AACB5B9226AFCB6DAAA0BBDC1AC23E', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '绩效目标管理覆盖率', 'GOALRATE', 1, null, 0, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('00CECB432AF2A4625F86195990EBF3D5', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '绩效监控管理覆盖率', 'TRACERATE', 1, null, 0, null, 12, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('598925F00C7AF1CC2DBC8CA8A61E5E19', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '绩效评价管理覆盖率', 'EVALUATIONRATE', 1, null, 0, null, 13, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('784CE9708BDEC18D240A322201DFD513', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '区划', 'PROVINCE', 0, null, 0, null, 20, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3B9CB920E739DD75A70E2D251A4FC9BA', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '最后修改时间', 'LASTUPDATETIME', 0, null, 0, null, 21, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7F49547EA1FD1C31A71B5A971E961D48', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '是否删除', 'IS_DELETED', 0, null, 0, null, 22, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('8803D38EE2AB2012AF0DDFDB2E894A3F', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '主建', 'GUID', 0, null, 0, null, 23, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7250F5C6E506534D2D2BC6FD244463B7', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '创建时间', 'CREATE_TIME', 0, null, 0, null, 24, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('26E5ECB8031EE235B674DC09893C5484', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '创建人', 'CREATER', 0, null, 0, null, 25, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DA0F94128B3D2ECE92D47AD8206B2C3B', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '任务类型', 'BUSTYPE', 0, null, 0, null, 26, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('659E4A31B50B07335C6B705D2A25A724', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', 'AUDITOR', 'AUDITOR', 0, null, 0, null, 30, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('EAB8B8126189A11310568162057955CE', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '下达单位或区划的guid', 'AGENCYGUID', 0, null, 0, null, 31, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('45402BC16E78002E3585211FB3F02818', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '工作流ID', 'WFID', 0, null, 0, null, 32, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('F14C3C35F298CC7E9E1F90135577C2D1', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '修改时间', 'UPDATE_TIME', 0, null, 0, null, 33, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1FA79B0A88ADC444DAC5494929E8C154', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '年度', 'YEAR', 0, null, 0, null, 34, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BE7F3D4BE4A123F05444CDEE3B9708B7', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '工作流状态', 'WFSTATUS', 0, null, 0, null, 35, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('EF43D8101883B48F4FA345F6A17CDFFD', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '考核对象', 'TASKTYPE', 0, null, 0, null, 40, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A1244D4DB59CA231DC52B8B24CC5CE86', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '主单guid', 'TASKGUID', 0, null, 0, null, 41, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('59792E27731676FCF3A9913179101C49', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '状态', 'STATUS', 0, null, 0, null, 42, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E5555692AA90057B0969CD61037B7048', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '下级区划', 'SUBPROVINCE', 0, null, 0, null, 43, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('082B14C65E7BC6C1758326D513ED89AB', '/pmkpi/workevaluate/report/subpedit/info', 'V_PERF_T_WORKTASKASSIGN', 's', '处室', 'FININTORGGUID', 0, null, 0, null, 44, null, null, 'pmkpi', 0, null, '{}', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/report/subprovinceedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C88ABD0AB485140CE0533315A8C0DBFE', '/pmkpi/workevaluate/report/subprovinceedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C88ABD0AB486140CE0533315A8C0DBFE', '/pmkpi/workevaluate/report/subprovinceedit', '取消', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/report/subprovinceedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C88ABD0AB487140CE0533315A8C0DBFE', 'pmkpi', '/pmkpi/workevaluate/report/subprovinceedit', '基本信息', 'editinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''C8B7928DDE7C6FB3E0533315A8C08CFB''}', null, '0', 'infoeditformformal', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C88ABD0AB488140CE0533315A8C0DBFE', 'pmkpi', '/pmkpi/workevaluate/report/subprovinceedit', '县（市）区、开发区预算绩效管理工作考核评分表', 'subprovincework', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '县（市）区、开发区预算绩效管理工作考核评分表', null, null, '{url:''/pmkpi/workevaluate/report/deptedit/score.page'',busguid:''C8B7928DDE7E6FB3E0533315A8C08CFB'',action:''workevalscore.save''}', null, '0', 'deptworkiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C88ABD0AB489140CE0533315A8C0DBFE', 'pmkpi', '/pmkpi/workevaluate/report/subprovinceedit', '附件上传', 'workfile', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存', '{filebustype:''subprovinceworkeval'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

--审核
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('217A331A7ADDB40280DD0605E49FEA30', '/pmkpi/workevaluate/audit/list', '审核', 1, 1, 'searchicon', 'workevalaudit.auditOrDetailed', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit",deptworkeval2:''deptkeywork'',subprostatus:''011''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('02740201D8DCB52C9C3BCCE513250C20', '/pmkpi/workevaluate/audit/list', '退回', 1, 2, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '退回', 'pmkpi', 'back', null, '{subprostatus:''00''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4AF4138DE7C946456E827998CA64EE63', '/pmkpi/workevaluate/audit/list', '取消审核', 1, 3, 'searchicon', 'Ext.lt.pmkpi.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel",subprostatus:''008''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F45AEC0F5EB81545E24C8614C639BFD2', '/pmkpi/workevaluate/audit/list', '审核情况', 1, 4, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7F6C216CA715299EF22C5A1C46B5CAA0', '/pmkpi/workevaluate/audit/list', '查看明细', 1, 5, 'searchicon', 'workevalaudit.auditOrDetailed', null, '查看明细', 'pmkpi', 'detailed', null, '{deptworkeval2:''deptkeywork''}');

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/audit/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('AEE011E1FB77067113460B1D8B0927D5', 'pmkpi', '/pmkpi/workevaluate/audit/list', '审核', 'waitaudit', 1, 1, 'choosed', 'workevalaudit.clickTabpage', 0, '待审核', null, '取消审核', '{subprovincefilter:"wfstatus in(''008'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('4A1BD9AFF299EC7CD0925F3F2696A433', 'pmkpi', '/pmkpi/workevaluate/audit/list', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'workevalaudit.clickTabpage', 0, '已审核', null, '审核,退回', '{subprovincefilter:"wfstatus in(''011'')"}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('37CE0CF001F767388668BAB7E4A11083', 'pmkpi', '/pmkpi/workevaluate/audit/list', '曾经办', 'alldeals', 1, 3, 'nomal', 'workevalaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核,退回', '{subprovincefilter:"wfstatus in(''008'',''011'')"}', null, '0', null, null, null, null, null, null, null);

--填报
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/audit/subprovinceedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8B7928DDDFD6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/audit/subprovinceedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8B7928DDDFF6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/audit/subprovinceedit', '保存并审核', 1, 2, 'Nofinishicon', 'tabfreamedit.saveaudit', null, '保存并审核', 'pmkpi', 'audit', null, '{subprostatus:''011''}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C8B7928DDDFE6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/audit/subprovinceedit', '取消', 1, 3, 'Nofinishicon', 'tabfreamedit.close', null, '取消', 'pmkpi', null, null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/workevaluate/audit/subprovinceedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C8B7928DDDFC6FB3E0533315A8C08CFB', 'pmkpi', '/pmkpi/workevaluate/audit/subprovinceedit', '基本信息', 'editinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存,保存并审核', '{busguid:''C88ABD0AB4A0140CE0533315A8C0DBFE'',viewtype:''query''}', null, '0', 'infoeditformformal', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C8B7928DDDFB6FB3E0533315A8C08CFB', 'pmkpi', '/pmkpi/workevaluate/audit/subprovinceedit', '县（市）区、开发区预算绩效管理工作考核评分表', 'subprovincework', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '县（市）区、开发区预算绩效管理工作考核评分表', null, null, '{url:''/pmkpi/workevaluate/report/deptedit/score.page?pagetype=audit'',busguid:''C88ABD0AB4A2140CE0533315A8C0DBFE'',action:''workevalscore.save''}', null, '0', 'deptworkiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C8B7928DDDFA6FB3E0533315A8C08CFB', 'pmkpi', '/pmkpi/workevaluate/audit/subprovinceedit', '附件上传', 'workfile', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存,保存并审核', '{filebustype:''subprovinceworkeval'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);

--查询
delete from p#busfw_t_uitable t where t.key in('/pmkpi/workevaluate/query/list');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C3A0123A14BAA7BFE053B11FA8C0ACD0', '/pmkpi/workevaluate/query/list', 'V_PERF_T_WORKTASKASSIGN', 0, 0, 0, null, ' t.wfstatus=011', 'pmkpi', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/workevaluate/query/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE3B6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'WFSTATUS', '状态', 1, 0, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE3C6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'CODE', '部门编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE476FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'CODE', '县（区）编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{type:''subprovince''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE3D6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'NAME', '部门名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE466FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'NAME', '县（区）名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{type:''subprovince''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE3E6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'AGENCYGUID', '预算部门', 5, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE3F6FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'TASKTYPE', '考核对象', 6, 1, 0, 0, null, 0, 6, null, '#name', null, null, 150, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE406FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'YEAR', '考核年度', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE416FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'GUID', 'guid', 10, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE426FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'STARTDATE', '开始时间', 11, 0, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE436FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'ENDDATE', '截止时间', 12, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE446FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'SCORE', '得分', 13, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'f', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8B7928DDE456FB3E0533315A8C08CFB', '/pmkpi/workevaluate/query/list', 'ORDERNUM', '排名', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 'n', '{}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/workevaluate/query/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3A0123A14C4A7BFE053B11FA8C0ACD0', '/pmkpi/workevaluate/query/list', '审核情况', 1, 6, 'searchicon', 'Ext.lt.pmkpi.auditquery', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C3A0123A14C5A7BFE053B11FA8C0ACD0', '/pmkpi/workevaluate/query/list', '查看明细', 1, 7, 'searchicon', 'workevalquery.querydetailed', null, '查看明细', 'pmkpi', 'querydetailed', null, '{deptworkeval2:''deptkeywork''}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/workevaluate/query/list');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C3A0123A14D6A7BFE053B11FA8C0ACD0', '/pmkpi/workevaluate/query/list', 'CODE', '部门编码', 1, 0, 's', null, null, null, 'pmkpi', 'PERF_T_WORKTASKASSIGN', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C3A0123A14D7A7BFE053B11FA8C0ACD0', '/pmkpi/workevaluate/query/list', 'NAME', '部门名称', 2, 0, 's', null, null, null, 'pmkpi', 'PERF_T_WORKTASKASSIGN', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('C3A0123A14D8A7BFE053B11FA8C0ACD0', '/pmkpi/workevaluate/query/list', 'TASKTYPE', '考核对象', 3, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_WORKTASKASSIGN', '{formart:''#name''}', null);
