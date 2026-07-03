begin

--任务布置
delete from p#busfw_t_uitable t where t.key in('/pmkpi/perfself/taskmanage');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('68D79B22EF8F4D8F9DCB51E51910A02F', '/pmkpi/perfself/taskmanage', 'V_PERF_ADJUSTPROJECT_INFO', 100, 0, 0, 'AGENCYGUID', null, 'pmkpi', '{program:" exists(select 1 from v_pm_perf_goal_info gl where gl.pro_code=t.pro_code and gl.yearflag=''0'') and t.pro_cat_code in(''22'',''3'')",dept:"  t.wfstatus=''011'' and exists(select 1 from v_bgt_perf_goal_info gl where gl.mainguid=t.guid)"}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/taskmanage');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('42C5B7D2F837492E8D9E359D65172BE2', '/pmkpi/perfself/taskmanage', 'PRO_CODE', '项目编码', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD71755E2DF2E0533315A8C064F2', '/pmkpi/perfself/taskmanage', 'PRO_NAME', '项目名称', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 180, 0, 's', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('08AF794356DE45A496CC4E5D84D926DA', '/pmkpi/perfself/taskmanage', 'NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 180, 0, 's', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('115B297F3F984A98A0178115943DDE8E', '/pmkpi/perfself/taskmanage', 'DEPT_CODE', '预算部门', 4, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 200, 1, 'tree', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0DEA3B03A256E68E0533315A8C0AFF2', '/pmkpi/perfself/taskmanage', 'AGENCYGUID', '预算单位', 5, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 200, 1, 'tree', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0DEA3B03A216E68E0533315A8C0AFF2', '/pmkpi/perfself/taskmanage', 'MOF_DEP_CODE', '业务处室', 6, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 100, 1, 'tree', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33406A2509654C62A003C4DE9FC4BE46', '/pmkpi/perfself/taskmanage', 'BUDGETAMOUNT', '全年预算数', 7, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{type:''program''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EF0A5321A7C643C6BACC0B6C80039E06', '/pmkpi/perfself/taskmanage', 'CODE', '单位编码', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0DEA3B03A236E68E0533315A8C0AFF2', '/pmkpi/perfself/taskmanage', 'NAME', '单位名称', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EE9A1E2E76464480A9741EA59855918C', '/pmkpi/perfself/taskmanage', 'FININTORGGUID', '业务处室', 11, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 100, 1, 'tree', '{type:''dept''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0DEA3B03A286E68E0533315A8C0AFF2', '/pmkpi/perfself/taskmanage', 'YEAR', '预算年度', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

delete from p#busfw_t_uieditform t where t.key in('/pmkpi/perfselftaskmanage/index');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P7AB553764A146D1A664F19BAF525848', '/pmkpi/perfselftaskmanage/index', 'V_PERF_T_SELFEVALTASK', 'd', '自评开始时间', 'EVALSTART', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P596F0E114FA45AE80E3B87CA16F0A67', '/pmkpi/perfselftaskmanage/index', 'V_PERF_T_SELFEVALTASK', 'd', '自评结束时间', 'EVALEND', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P29A1F3980EF4CEBAB28D4A8C8523DD2', '/pmkpi/perfselftaskmanage/index', 'V_PERF_T_SELFEVALTASK', 'i', '预警天数', 'REMAININGDAYS', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{"format":"#name"}', null, null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/perfselftaskmanage/dept','/pmkpi/perfselftaskmanage/index');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EDFCA52C3E0533315A8C06E47', '/pmkpi/perfselftaskmanage/dept', 'CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EDFCB52C3E0533315A8C06E47', '/pmkpi/perfselftaskmanage/dept', 'NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EDFCD52C3E0533315A8C06E47', '/pmkpi/perfselftaskmanage/dept', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PC35BB0146F547D68E5E29944F3F2307', '/pmkpi/perfselftaskmanage/index', 'NAME', '项目名称', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_ADJUSTPROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PCD4B1B44851481F86DC693B6CB55A96', '/pmkpi/perfselftaskmanage/index', 'MOF_DEP_CODE', '业务处室', 5, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_ADJUSTPROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EDFC852C3E0533315A8C06E47', '/pmkpi/perfselftaskmanage/index', 'AGENCYGUID', '预算单位', 4, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_ADJUSTPROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EDFC452C3E0533315A8C06E47', '/pmkpi/perfselftaskmanage/index', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_ADJUSTPROJECT_INFO', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D158BD7175672DF2E0533315A8C064F2', '/pmkpi/perfselftaskmanage/index', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_ADJUSTPROJECT_INFO', null, null);

--填报
delete from p#busfw_t_uitable t where t.key in('/pmkpi/perfself/query');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('D9CB1846C5F54DECB52C6EA582CD3986', '/pmkpi/perfself/query', 'PERF_V_SELFEVALTASK', 100, 0, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/query');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0F2BE7D8713141F58367EE399DBD2F22', '/pmkpi/perfself/query', 'GUID', 'guid', 0, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ABEF0528549E40AB92B9F3DA53A9E3D5', '/pmkpi/perfself/query', 'WFSTATUS', '状态', 1, 1, 0, 0, null, 0, 6, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0692F1785EFD47478E5C992C9A8ACABE', '/pmkpi/perfself/query', 'CODE', '项目编码', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 120, 0, 's', '{type:"program"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('09DF08825E3B4D60A2848441AD8B5B3F', '/pmkpi/perfself/query', 'NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{type:"program"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('77FD9D72E6FF4E3591610D684B56E0D7', '/pmkpi/perfself/query', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 200, 1, 'tree', '{type:"program"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6D6D2DE14D93421DADE1947AB3DC5C1B', '/pmkpi/perfself/query', 'NAME', '预算单位名称', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{type:"dept"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0DEA3B03A696E68E0533315A8C0AFF2', '/pmkpi/perfself/query', 'CODE', '预算单位编码', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{type:"dept"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0AC6E8C79F094A44B73BA654CCCD2AF1', '/pmkpi/perfself/query', 'FININTORGGUID', '业务处室', 6, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C3F421BFB0C54D229C2287FEE5A00F78', '/pmkpi/perfself/query', 'BUDGETAMOUNT', '全年预算数', 7, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{type:"program"}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A2CCE33173D6432EA1F127D94A046134', '/pmkpi/perfself/query', 'EXECRATENUM', '调整后预算数', 8, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1ACDD06A64E741D98CEDBD40A52E413E', '/pmkpi/perfself/query', 'EXECAMOUNT', '全年执行数', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BB4894A330D3480A9BDBA7FB83086957', '/pmkpi/perfself/query', 'EXECRATE', '预算执行率', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0B77A5405D12418FB66B8AD3500AEB02', '/pmkpi/perfself/query', 'SCORE', '得分', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DC8371A80AFD4A52ACE3FE28BF14DB68', '/pmkpi/perfself/query', 'SELFRESULT', '自评结论', 12, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('432CEEBB0733401B819670A8FC561209', '/pmkpi/perfself/query', 'WARN', '自评预警', 13, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F2A1374262CC458FB4906F21C88BB3CA', '/pmkpi/perfself/query', 'WARNDAYS', '截止天数', 14, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F2A1374262CC458FB4906F21C88BB3CA', '/pmkpi/perfself/query', 'PRO_CODE', '项目编码', 15, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/apply/index') and code in('exportProj');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0B6DB0ECF46167746B070840E219C286', '/pmkpi/perfself/apply/index', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}');

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/perfself/apply/dept','/pmkpi/perfself/apply/index');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EE00A52C3E0533315A8C06E47', '/pmkpi/perfself/apply/dept', 'CODE', '单位编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EE00B52C3E0533315A8C06E47', '/pmkpi/perfself/apply/dept', 'NAME', '单位名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EE00C52C3E0533315A8C06E47', '/pmkpi/perfself/apply/dept', 'WFSTATUS', '审核状态', 4, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EE00D52C3E0533315A8C06E47', '/pmkpi/perfself/apply/dept', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A94', '/pmkpi/perfself/apply/index', 'NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A95', '/pmkpi/perfself/apply/index', 'WFSTATUS', '审核状态', 5, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A96', '/pmkpi/perfself/apply/index', 'FININTORGGUID', '业务处室', 4, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A98', '/pmkpi/perfself/apply/index', 'C1', '全年预算数≥（万元）', 5, 0, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A99', '/pmkpi/perfself/apply/index', 'C2', '全年预算数≤（万元）', 6, 0, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EDFCF52C3E0533315A8C06E47', '/pmkpi/perfself/apply/index', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D106B09EDFD052C3E0533315A8C06E47', '/pmkpi/perfself/apply/index', 'AGENCYGUID', '预算单位', 3, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

--审核
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/audit/index') and code in('exportProj');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('29C57E220BCB603FDD5FB908700CF20D', '/pmkpi/perfself/audit/index', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}');

--查询
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/query/index') and code in('exportProj');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54D98F353F267D57C9E5A01CD5D39828', '/pmkpi/perfself/query/index', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'exportProj', null, '{}');

--目标完成情况
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/apply/edit/selfindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176352DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD71763A2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'NAME', '指标名称', 4, 1, 0, 0, '0', 0, 6, null, null, null, 0, 180, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176312DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'COMPUTESIGN', '计算符号', 5, 1, 0, 0, '0', 0, 6, null, '#name', null, 0, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176362DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'INDEXVAL', '指标值', 6, 1, 0, 0, '0', 0, 6, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176302DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'ACTUALVALUE', '实际完成值', 7, 1, 1, 0, '0', 1, 6, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176392DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'METERUNIT', '计量单位', 8, 1, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176342DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'WEIGHT', '权重设定值', 9, 1, 0, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176332DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'ACTUALWEIGHT', '权重', 10, 1, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176322DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'WARN', '序时进度预警', 11, 0, 0, 0, '0', 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176372DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'SCORE', '实际得分', 12, 1, 1, 1, '0', 0, 1, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176382DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'KPI_REMARK', '偏差原因及改进措施', 14, 1, 1, 0, '0', 0, 6, null, null, null, 0, 200, 0, 's', '{}', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/apply/editdept/selfindex');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7175B02DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'GUID', '主键ID', 1, 0, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD71763B2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'NAME', '指标名称', 2, 1, 0, 0, '0', 0, 6, null, null, null, 0, 180, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7175AB2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'COMPUTESIGN', '计算符号', 3, 1, 0, 0, '0', 0, 6, null, '#name', null, 0, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7175B12DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'INDEXVAL', '指标值', 4, 1, 0, 0, '0', 0, 6, null, null, null, 0, 180, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7175AA2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'ACTUALVALUE', '实际完成值', 5, 1, 1, 0, '0', 1, 6, null, null, null, 0, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD71763C2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'METERUNIT', '计量单位', 6, 1, 0, 0, '0', 0, 6, null, null, null, 0, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD71763D2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'WEIGHT', '权重设定值', 10, 1, 0, 1, '0', 0, 6, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD71763E2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'ACTUALWEIGHT', '权重', 11, 1, 1, 1, '0', 0, 6, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7175AD2DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'SCORE', '实际得分', 12, 1, 1, 1, '0', 0, 6, null, '{unit: 1, dotname: 2, qfw: true}', null, 0, 100, 0, 'i', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7175A62DF2E0533315A8C064F2', '/pmkpi/perfself/apply/editdept/selfindex', 'KPI_REMARK', '偏差原因及改进措施', 13, 1, 1, 0, '0', 0, 6, null, null, null, 0, 200, 0, 's', '{}', null);
