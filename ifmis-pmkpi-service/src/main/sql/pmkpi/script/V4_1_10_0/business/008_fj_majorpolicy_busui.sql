begin

delete from p#busfw_t_uitable where key ='/pmkpi/majorpolicy/evalindex';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'V_PERF_T_MAJORPOLICY', 0, 0, 0, 'order by dept_code,pro_code', null, 'pmkpi', '{tiptext:'' 删除或修改后请点击保存按钮，否则会丢失数据！''}', '87', '2016');

delete from p#busfw_t_uicolumn where key ='/pmkpi/majorpolicy/evalindex';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'FININTORGGUID', '归口业务处', 2, 1, 0, 0, null, 1, null, null, '#name', null, null, 100, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'DEPT_CODE', '主管部门', 3, 1, 0, 0, null, 1, null, null, '#name', null, null, 150, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'PRO_CODE', '项目编码', 99, 0, 0, 0, null, 1, 1, null, null, null, null, 150, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'PRO_NAME', '政策名称', 5, 1, 0, 0, null, 1, 1, null, null, null, null, 300, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'YEARCOL1', '起始年度', 6, 1, 1, 0, null, 1, null, '[''本轮政策实施期'',''本轮政策实施期'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'YEARCOL2', '终止年度', 7, 1, 1, 0, null, 1, null, '[''本轮政策实施期'',''本轮政策实施期'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'YEARCOL3', '起始年度', 8, 1, 1, 0, null, 0, null, '[''上轮政策实施期'',''上轮政策实施期'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'YEARCOL4', '终止年度', 9, 1, 1, 0, null, 0, null, '[''上轮政策实施期'',''上轮政策实施期'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'URL1', '事前绩效评估', 10, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'URL2', '绩效目标（本年度）', 11, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'VIOLATIONSNUM', '认定违规数量', 12, 1, 1, 0, null, 0, 0, '[''执行监控'',''执行监控'']', null, null, null, 100, 0, 'i', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'RECTIFICATIONNUM', '已整改数量', 13, 1, 1, 0, null, 0, 0, '[''执行监控'',''执行监控'']', null, null, null, 100, 0, 'i', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'SELFEVALRESULT1', '2022', 14, 1, 0, 0, null, 0, null, '[''近三年自评自评结论'',''绩效评价'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'SELFEVALRESULT2', '2023', 15, 1, 0, 0, null, 0, null, '[''近三年自评自评结论'',''绩效评价'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'SELFEVALRESULT3', '2024', 16, 1, 0, 0, null, 0, null, '[''近三年自评自评结论'',''绩效评价'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'YEARCOL5', '最近开展到期绩效评价的年份', 17, 1, 1, 0, null, 0, null, '[''最近开展到期绩效评价的年份'',''绩效评价'']', null, null, null, 50, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'YEARCOL6', '起始年度', 18, 1, 1, 0, null, 0, null, '[''绩效评价覆盖预算年度'',''绩效评价'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'YEARCOL7', '终止年度', 19, 1, 1, 0, null, 0, null, '[''绩效评价覆盖预算年度'',''绩效评价'']', null, null, null, 80, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'OBLIGATE2', '到期绩效评价报告（最新）（上传）', 20, 1, 0, 0, null, 0, null, '[''到期绩效评价报告（最新）（上传）'',''绩效评价'']', null, null, null, 50, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'WARN', '到期评价预警', 21, 1, 0, 0, null, 0, null, '[''到期评价预警'',''绩效评价'']', '#name', null, null, 100, 1, 'tree', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'OBLIGATE1', '本轮资金管理文件（上传）', 22, 1, 0, 0, null, 0, null, null, null, null, null, 50, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'LINKMAN', '处室联系人', 23, 1, 1, 0, null, 0, null, null, null, null, null, 100, 0, 's', null, null, '87', '2016', null, null);


delete from p#busfw_t_uiqueryform where key='/pmkpi/majorpolicy/evalindex';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', 'PRO_NAME', '政策名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_T_MAJORPOLICY', null, '87', '2016');

delete from p#Busfw_t_uifunction t where t.key='/pmkpi/majorpolicy/evalindex';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', '保存', 1, 1, 'keepicon', 'transpayproindex.savemajorkey', null, '保存', 'pmkpi', 'save', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', '删除', 1, 3, 'keepicon', 'transpayproindex.delrows', null, '删除', 'pmkpi', 'delrows', null, null, '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', '导出列表', 1, 9, 'searchicon', 'Ext.lt.pmkpi.expdata', null, '导出列表', 'pmkpi', 'export', null, '{}', '87', '2016');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/majorpolicy/evalindex', '新增', 1, 2, 'keepicon', 'transpayproindex.addselectpro', null, '新增', 'pmkpi', 'addselectpro', null, null, '87', '2016');

delete from p#busfw_t_uifunction where key ='/pmkpi/majorpolicy/selrpro';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', '确定', 1, 1, 'Keepicon', 'majorpolicyselpro.save', null, '确定', 'pmkpi', null, null, null, '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', '取消', 1, 2, 'Nofinishicon', 'majorpolicyselpro.closewin', null, '取消', 'pmkpi', null, null, null, '87', '2016', null, null);



delete from p#busfw_t_uitable where key ='/pmkpi/majorpolicy/selrpro';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/majorpolicy/selrpro', 'V_PERF_PROJECT_SELFRESULT', 100, 1, 0, 't.PRO_CODE', null, 'pmkpi', null, '87', '2016');

delete from p#busfw_t_uicolumn where key ='/pmkpi/majorpolicy/selrpro';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'PRO_CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'PRO_NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'YEAR', '预算年度', 4, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'FININTORGGUID', '业务科室', 13, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'CREATER', '创建人', 14, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'WFSTATUS', '审核状态', 15, 0, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'GUID', '主键', 15, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'CREATE_TIME', '项目入库时间', 22, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 'd', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'PRO_START_YEAR', '开始日期', 25, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'PRO_TERM', '项目期限', 26, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'LEADER_NAME', '项目负责人', 27, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'LEADER_TEL', '项目联系人', 28, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/majorpolicy/selrpro', 'PRO_TOTAL_AMT', '项目总金额', 29, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

