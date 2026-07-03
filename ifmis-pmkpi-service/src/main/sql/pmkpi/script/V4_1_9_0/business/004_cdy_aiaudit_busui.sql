begin
  
delete from p#busfw_t_uieditform t where t.key in('/pmkpi/audit/aisendaudit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, PROVINCE, YEAR, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/aisendaudit', 'V_PERF_T_AUDITMAIN', 'textarea', '“‚º˚', 'REMARK', 1, null, 0, null, 5, 1, '2', 'pmkpi', 1, null, '{}', null, null, null, '87', '2016', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/audit/aisendaudit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/aisendaudit', '…Û∫À', 1, 1, 'searchicon', 'aisendaudit.audit', null, '…Û∫À', 'pmkpi', 'audit', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/audit/aisendaudit', '»°œ˚', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '»°œ˚', 'pmkpi', 'cancle', null, '{}', '87', '2016', null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/audit/index','/pmkpi/supervision/index') and t.code='AIaudit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/audit/index', 'AI…Û∫À', 0, 1, 'searchicon', 'perfselfaudit.AIaudit', null, 'AI…Û∫À', 'pmkpi', 'AIaudit', null, '{api_key:"app-J8OhWDS0QFhN4QbB1hZ6icNZ",queryset:''[{"querycol":"pro_code","tablecode":"v_perf_project_info","dcol":"pro_code","datacols":"pro_code,pro_name,pro_bases,pro_desc,v_col7,pro_term,is_perform,projectkind"},{"querycol":"mainguid","tablecode":"v_perf_t_selfperfindex","dcol":"guid","datacols":"pro_code,pro_name,findex,sindex,name,computesign,meterunit,indexval","wheresql":""}]'',datacols:''pro_code,guid''}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/supervision/index', 'AI…Û∫À', 0, 1, 'searchicon', 'supervision.AIaudit', null, 'AI…Û∫À', 'pmkpi', 'AIaudit', null, '{api_key:"app-J8OhWDS0QFhN4QbB1hZ6icNZ",queryset:''[{"querycol":"pro_code","tablecode":"v_perf_project_info","dcol":"pro_code","datacols":"pro_code,pro_name,pro_bases,pro_desc,v_col7,pro_term,is_perform,projectkind"},{"querycol":"guid","tablecode":"V_PERF_T_SUPERVISIONVIEW","dcol":"guid","datacols":"mainguid,proname,kpi_lv1,kpi_lv2,kpi_lv3,kpi_val,adjoption,options","wheresql":"""}]'',datacols:''mainguid,guid''}', '87', '2016', null, null);
