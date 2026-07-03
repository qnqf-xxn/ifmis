begin
delete from busfw_t_uifunction t where t.key in ('/pmkpi/indexlib/commedit','/pmkpi/indexlib/deptlist','/pmkpi/indexlib/edit','/pmkpi/indexlib/list','/pmkpi/index/audit','/pmkpi/index/query');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('pmkpi/index/audit900034', '/pmkpi/index/audit', '确认', 1, 5, 'searchicon', 'indexaudit.wfAudit', null, '确认', 'pmkpi', 'audit', null, '{"action":"audit"}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('pmkpi/index/audit900036', '/pmkpi/index/audit', '取消确认', 1, 7, 'searchicon', 'indexaudit.wfAudit', null, '取消确认', 'pmkpi', 'cancelaudit', null, '{"action":"cancelaudit"}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('pmkpi/index/audit900029', '/pmkpi/index/audit', '退回', 1, 6, 'addicon', 'indexaudit.wfAudit', null, '退回', 'pmkpi', 'back', null, '{"action":"back"}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('pmkpiindexquery901', '/pmkpi/index/query', '查询', 1, 3, 'searchicon', 'indexquery.query', null, '查询', 'pmkpi', 'query', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('4A2C2AE80E1342078D4E4E1A429F6013', '/pmkpi/indexlib/commedit', '保存', 1, 1, 'searchicon', 'indexinfoedit.save', null, '保存', 'pmkpi', 'save', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('281FD63DA7CA4A2DBA728B4B94062465', '/pmkpi/indexlib/commedit', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist908', '/pmkpi/indexlib/deptlist', '修改', 1, 2, 'searchicon', 'indexlib.mod', null, '修改', 'pmkpi', 'mod', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('/pmkpi/indexlib/deptlist911', '/pmkpi/indexlib/deptlist', '送审', 1, 5, 'searchicon', 'indexlib.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('/pmkpi/indexlib/deptlist912', '/pmkpi/indexlib/deptlist', '取消送审', 1, 6, 'addicon', 'indexlib.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist903', '/pmkpi/indexlib/deptlist', '删除', 1, 3, 'searchicon', 'indexlib.del', null, '删除', 'pmkpi', 'del', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist909', '/pmkpi/indexlib/deptlist', '新增', 1, 1, 'searchicon', 'indexlib.add', null, '新增', 'pmkpi', 'add', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('9A11D19362DA4C1DA7927A66AA5D0CE', '/pmkpi/indexlib/edit', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('79EEDC3D21F04E438938A1E70D0EA3C4', '/pmkpi/indexlib/edit', '保存', 1, 1, 'searchicon', 'indexinfoedit.save', null, '保存', 'pmkpi', 'save', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('42579F282FEA4D0FA055EF0DABFC480D', '/pmkpi/indexlib/list', '删除', 1, 3, 'searchicon', 'indexlib.del', null, '删除', 'pmkpi', 'del', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('D07D71E49F9C4D488EFF3B88E2DCEBE4', '/pmkpi/indexlib/list', '修改', 1, 2, 'searchicon', 'indexlib.mod', null, '修改', 'pmkpi', 'mod', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values ('19F3FD260B40443E9D086B8375D0D9D5', '/pmkpi/indexlib/list', '新增', 1, 1, 'searchicon', 'indexlib.add', null, '新增', 'pmkpi', 'add', null, '{}', '87', '2016');

delete from busfw_t_uiqueryform t where t.key in ('/pmkpi/indexlib/commedit','/pmkpi/indexlib/deptlist','/pmkpi/indexlib/list','/pmkpi/index/audit','/pmkpi/index/query');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit00904', '/pmkpi/index/audit', 'PERF_IND_NAME', '指标名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit00903', '/pmkpi/index/audit', 'FINDEX', '一级指标', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexquery002', '/pmkpi/index/query', 'FINDEX', '一级指标', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexquery001', '/pmkpi/index/query', 'PERF_IND_NAME', '指标名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist000213', '/pmkpi/indexlib/deptlist', 'FINDEX', '一级指标', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist000212', '/pmkpi/indexlib/deptlist', 'PERF_IND_NAME', '指标名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('2569D8108BCB40CAB429A623F6D7E334', '/pmkpi/indexlib/list', 'PERF_IND_NAME', '指标名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('5C851BD747464636B376B22A7B6B1CCC', '/pmkpi/indexlib/list', 'FINDEX', '一级指标', 2, 1, 'tree', null, null, null, 'pmkpi', 'V_BAS_PERF_INDICATOR', null, null, '87', '2016');

delete from busfw_t_uitabpage t where t.key in ('/pmkpi/indexlib/deptlist','/pmkpi/index/audit');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpi/index/audit002', 'pmkpi', '/pmkpi/index/audit', '已确认', 'alreadyaudit', 1, 2, 'nomal', 'indexaudit.clickTabpage', null, '已审核', null, '退回,确认', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpi/index/audit001', 'pmkpi', '/pmkpi/index/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'indexaudit.clickTabpage', null, '曾经办', null, '退回,确认,取消确认', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpi/index/audit003', 'pmkpi', '/pmkpi/index/audit', '待确认', 'waitaudit', 1, 1, 'choosed', 'indexaudit.clickTabpage', null, '待审核', null, '取消确认', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist002', 'pmkpi', '/pmkpi/indexlib/deptlist', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'indexlib.clickTabpage', null, '已审核', null, '新增,修改,删除,送审', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist003', 'pmkpi', '/pmkpi/indexlib/deptlist', '待送审', 'waitaudit', 1, 1, 'choosed', 'indexlib.clickTabpage', null, '待审核', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist001', 'pmkpi', '/pmkpi/indexlib/deptlist', '曾经办', 'alldeals', 1, 3, 'nomal', 'indexlib.clickTabpage', null, '曾经办', null, '新增,修改,删除,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null, '87', '2016');

delete from busfw_t_uitable t where t.key in ('/pmkpi/indexlib/deptlist','/pmkpi/indexlib/list','/pmkpi/index/audit','/pmkpi/index/query');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('pmkpi/index/audit2229901', '/pmkpi/index/audit', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('pmkpi/index/querytable001', '/pmkpi/index/query', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9901', '/pmkpi/indexlib/deptlist', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values ('E9FF972AF9114397B1F735143CF67E5A', '/pmkpi/indexlib/list', 'V_BAS_PERF_INDICATOR', 100, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');

delete from busfw_t_uicolumn t where t.key in ('/pmkpi/indexlib/deptlist','/pmkpi/indexlib/list','/pmkpi/index/audit','/pmkpi/index/query');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9016', '/pmkpi/index/audit', 'INDEXSTANDARDS', '绩效标准', 19, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9014', '/pmkpi/index/audit', 'EXPLAIN', '指标解释', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9018', '/pmkpi/index/audit', 'KEYWORD', '关键词', 30, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9009', '/pmkpi/index/audit', 'PERF_IND_NAME', '内容', 13, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9008', '/pmkpi/index/audit', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9007', '/pmkpi/index/audit', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9006', '/pmkpi/index/audit', 'FUNDUSE', '资金用途', 10, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9005', '/pmkpi/index/audit', 'INDUSTRYCATEGORY', '行业类别', 8, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9004', '/pmkpi/index/audit', 'INDEXCATEGORIES', '行业大类', 6, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9002', '/pmkpi/index/audit', 'AGENCY_CODE', '预算部门', 2, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9001', '/pmkpi/index/audit', 'PERF_IND_CODE', '指标编码', 1, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9019', '/pmkpi/index/audit', 'WFSTATUS', '流程', 0, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9011', '/pmkpi/index/audit', 'COMPUTESIGN', '性质', 14, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9012', '/pmkpi/index/audit', 'KPI_VAL', '参考值', 15, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/audit9013', '/pmkpi/index/audit', 'TARGETUNIT', '单位', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols005', '/pmkpi/index/query', 'INDUSTRYCATEGORY', '行业类别', 8, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols015', '/pmkpi/index/query', 'KEYWORD', '关键词', 30, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols013', '/pmkpi/index/query', 'EXPLAIN', '指标解释', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols012', '/pmkpi/index/query', 'TARGETUNIT', '单位', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols011', '/pmkpi/index/query', 'KPI_VAL', '参考值', 15, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols010', '/pmkpi/index/query', 'COMPUTESIGN', '性质', 14, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols009', '/pmkpi/index/query', 'PERF_IND_NAME', '内容', 13, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols008', '/pmkpi/index/query', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols007', '/pmkpi/index/query', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols006', '/pmkpi/index/query', 'FUNDUSE', '资金用途', 10, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols001', '/pmkpi/index/query', 'PERF_IND_CODE', '指标编码', 1, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols002', '/pmkpi/index/query', 'AGENCY_CODE', '预算部门', 2, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols003', '/pmkpi/index/query', 'PROJTYPE', '项目类型', 4, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"1"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols004', '/pmkpi/index/query', 'INDEXCATEGORIES', '行业大类', 6, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/index/querycols014', '/pmkpi/index/query', 'INDEXSTANDARDS', '绩效标准', 19, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9014', '/pmkpi/indexlib/deptlist', 'EXPLAIN', '指标解释', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9019', '/pmkpi/indexlib/deptlist', 'WFSTATUS', '流程', 0, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9018', '/pmkpi/indexlib/deptlist', 'KEYWORD', '关键词', 30, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9016', '/pmkpi/indexlib/deptlist', 'INDEXSTANDARDS', '绩效标准', 19, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9006', '/pmkpi/indexlib/deptlist', 'FUNDUSE', '资金用途', 10, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9007', '/pmkpi/indexlib/deptlist', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9008', '/pmkpi/indexlib/deptlist', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9001', '/pmkpi/indexlib/deptlist', 'PERF_IND_CODE', '指标编码', 1, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9002', '/pmkpi/indexlib/deptlist', 'AGENCY_CODE', '预算部门', 2, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9003', '/pmkpi/indexlib/deptlist', 'PROJTYPE', '项目类型', 4, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"1"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9004', '/pmkpi/indexlib/deptlist', 'INDEXCATEGORIES', '行业大类', 6, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9005', '/pmkpi/indexlib/deptlist', 'INDUSTRYCATEGORY', '行业类别', 8, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9009', '/pmkpi/indexlib/deptlist', 'PERF_IND_NAME', '内容', 13, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9011', '/pmkpi/indexlib/deptlist', 'COMPUTESIGN', '性质', 14, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9012', '/pmkpi/indexlib/deptlist', 'KPI_VAL', '参考值', 15, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpi/indexlib/deptlist9013', '/pmkpi/indexlib/deptlist', 'TARGETUNIT', '单位', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00012', '/pmkpi/indexlib/list', 'FINDEX', '一级指标', 11, 1, 0, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00027', '/pmkpi/indexlib/list', 'KEYWORD', '关键词', 30, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00016', '/pmkpi/indexlib/list', 'PERF_IND_CODE', '指标编码', 1, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00017', '/pmkpi/indexlib/list', 'INDEXCATEGORIES', '行业大类', 6, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00018', '/pmkpi/indexlib/list', 'INDUSTRYCATEGORY', '行业类别', 8, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00019', '/pmkpi/indexlib/list', 'PROJTYPE', '项目类型', 4, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"1"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00020', '/pmkpi/indexlib/list', 'KPI_VAL', '参考值', 15, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00021', '/pmkpi/indexlib/list', 'COMPUTESIGN', '性质', 14, 1, 0, null, null, null, null, '[''三级指标'']', '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00022', '/pmkpi/indexlib/list', 'TARGETUNIT', '单位', 16, 1, 0, null, null, null, null, '[''三级指标'']', null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00023', '/pmkpi/indexlib/list', 'EXPLAIN', '指标解释', 17, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00024', '/pmkpi/indexlib/list', 'FUNDUSE', '资金用途', 10, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00025', '/pmkpi/indexlib/list', 'AGENCY_CODE', '预算部门', 2, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00026', '/pmkpi/indexlib/list', 'INDEXSTANDARDS', '绩效标准', 19, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{iscommon:"0"}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00015', '/pmkpi/indexlib/list', 'PERF_IND_NAME', '内容', 13, 1, 0, 0, null, 1, null, '[''三级指标'']', null, null, null, 220, 0, 's', '{}', null, '87', '2016');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR)
values ('pmkpiindexliblist00016', '/pmkpi/indexlib/list', 'SINDEX', '二级指标', 12, 1, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016');

delete from busfw_t_uieditform t where t.key in ('/pmkpi/indexlib/commedit','/pmkpi/indexlib/edit');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit011', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '关键词', 'KEYWORD', 1, null, 0, null, 46, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit009', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 'tree', '项目类型', 'PROJTYPE', 0, null, 0, null, 45, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit008', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 'textarea', '指标解释', 'EXPLAIN', 1, null, 0, null, 66, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit001', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '指标名称', 'PERF_IND_NAME', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit002', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 'tree', '指标体系', 'FRAMESYSTEM', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit099', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', 'guid', 'guid', 0, null, 0, null, 99, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit004', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 'tree', '计算符号', 'COMPUTESIGN', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit005', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '指标值', 'KPI_VAL', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit006', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 's', '计量单位', 'METERUNIT', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit007', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 'textarea', '指标值说明', 'VALUE_DESC', 1, null, 1, null, 55, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('pmkpiindexlibcommedit003', '/pmkpi/indexlib/commedit', 'V_BAS_PERF_INDICATOR', 'tree', '层次分类', 'SINDEX', 1, null, 1, null, 3, null, null, 'pmkpi', 1, 0, '{format:''#name'',filtersql:''frametype=\''#FRAMESYSTEM\''''}', 0, 1, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A83A062E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'textarea', '指标解释', 'EXPLAIN', 1, null, 0, null, 52, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A83A162E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '绩效标准', 'INDEXSTANDARDS', 1, null, 0, null, 45, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A83A262E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '关键词', 'KEYWORD', 1, null, 0, null, 46, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('11B37377E8AE4C4E92D03E136CD7FAA8', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '单位id', 'AGENCYGUID', 0, null, 0, null, 50, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A833962E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '单位id', 'AGENCY_CODE', 0, null, 0, null, 51, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A83A762E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '编码', 'PERF_IND_CODE', 0, null, 0, null, 59, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A839F62E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '资金用途', 'FUNDUSE', 1, null, 1, null, 43, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A839E62E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '行业类别', 'INDUSTRYCATEGORY', 0, null, 1, null, 42, null, null, 'pmkpi', 1, null, '{filtersql:''superguid=\''#INDEXCATEGORIES\'' ''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A839D62E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '行业大类', 'INDEXCATEGORIES', 0, null, 1, null, 41, null, null, 'pmkpi', 1, null, '{filtersql:''levelno=\''1\''''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('B412538A82D562E3E0535164A8C0C98B', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'textarea', '指标值说明', 'VALUE_DESC', 1, null, 1, null, 51, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('A8028459A1DF4DF2965D67EA00F63892', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '一级指标', 'FINDEX', 0, null, 0, null, 18, null, null, 'pmkpi', 1, 0, '{format:''#name''}', 0, 1, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('2AB703247CF9449B93B2639CC6E5B8BA', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', 'guid', 'GUID', 0, null, 0, null, 17, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('49F4832CBDE44739B09E23F1C41A0E1C', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '指标名称', 'PERF_IND_NAME', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('49F4832CBDE44739B09E23F1C41A0E1C', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '指标体系', 'FRAMESYSTEM', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('A8028459A1DF4DF2965D67EA00F63892', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '层次分类', 'SINDEX', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name'',filtersql:''frametype=\''#FRAMESYSTEM\''''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('099DFA0B1EAD4565A67D3273B6C5BFA2', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 'tree', '计算符号', 'COMPUTESIGN', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('13402A2269A542CE9C521727DDC8BE1F', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '指标值', 'KPI_VAL', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR)
values ('85236C46012F45E39B26ED4038C65785', '/pmkpi/indexlib/edit', 'V_BAS_PERF_INDICATOR', 's', '计量单位', 'METERUNIT', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null, '87', '2016');