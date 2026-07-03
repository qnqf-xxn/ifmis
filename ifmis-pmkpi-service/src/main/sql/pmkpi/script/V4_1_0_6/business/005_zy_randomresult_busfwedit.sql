begin
  
delete from p#busfw_t_uieditform t where key = '/pmkpi/randomcomment/result/edit/randomProblemEdit' and columncode in ('VCOL3','VCOL4','VCOL5');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/randomcomment/result/edit/randomProblemEdit', 'PERF_T_RANDOMPROBLEM', 's', '自评质量得分', 'VCOL4', 1, null, 0, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/randomcomment/result/edit/randomProblemEdit', 'PERF_T_RANDOMPROBLEM', 's', '自评质量结果', 'VCOL5', 1, null, 0, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/randomcomment/result/edit/randomProblemEdit', 'PERF_T_RANDOMPROBLEM', 'tree', '抽评等级', 'VCOL3', 1, null, 0, null, 3, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null, null, null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/randomcomment/result/index' and code = 'import';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '批量导入评价结果', 1, 8, 'searchicon', 'randomcommentresult.import', null, '批量导入评价结果', 'pmkpi', 'import', null, '{}', null, null);
