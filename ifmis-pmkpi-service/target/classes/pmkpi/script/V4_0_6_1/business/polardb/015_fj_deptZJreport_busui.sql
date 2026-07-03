begin
 
--浙江部门整体申报-绩效指标-指标选择项目新增查询区 
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/deptZJformance/report/edit/selpros' and id ='queryform';

insert into Bus_t_Pageconsolecomconfig (URL, COMPONENTID, CONFIG, ID, APPID, REGION)
values ('/pmkpi/deptZJformance/report/edit/selpros', 'busqueryform', '{name:''查询区'',datatable:''noseltable'',fastquery:true,drawmode:''div'',label:''快速查询'',labelwidth:''120''}', 'queryform', 'pmkpi', null);

delete FROM p#Busfw_t_Uiqueryform t where t.key = '/pmkpi/deptZJformance/report/edit/selpros';

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/deptZJformance/report/edit/selpros', 'pro_code', '项目编码', 1, 0, 's', null, 0, 0, 'pmkpi', 'V_PERF_BGT_INDEXPRO', null, null, null, null, null,'2016','87');

insert into Busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/deptZJformance/report/edit/selpros', 'pro_name', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_BGT_INDEXPRO', null, null, null, null, null,'2016','87');

--快速查询只保留项目名称
delete FROM p#Busfw_t_Uicolumn t where t.key = '/pmkpi/deptZJformance/report/edit/selpros1';

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_ID', '项目id', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null, null, null,'2016','87');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_TOTAL_AMT', '金额', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 'amt', '{}', null, null, null,'2016','87');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/deptZJformance/report/edit/selpros1', 'AGENCYGUID', '单位编码', 5, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null, null, null,'2016','87');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_CODE', '项目编码', 2, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', '{}', null, null, null,'2016','87');

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/deptZJformance/report/edit/selpros1', 'PRO_NAME', '项目名称', 3, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', '{}', null, null, null,'2016','87');


