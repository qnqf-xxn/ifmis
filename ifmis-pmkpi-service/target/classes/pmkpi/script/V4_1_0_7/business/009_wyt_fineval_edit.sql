begin
  --财政评价项目新增页面编辑区添加字段  默认隐藏
delete from p#busfw_t_uieditform t where tablecode ='V_PERF_T_FINEVALUATION' and columncode in('FUND_TYPE','PRO_DESC');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'tree', '类别', 'FUND_TYPE', 0, null, 1, null, 19, null, null, 'pmkpi', 1, 0, '{"format":"#code-#name"}', 0, 0, 0, null, null, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/finconfirm/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '项目概况', 'PRO_DESC', 0, null, 1, null, 20, 2, '3', 'pmkpi', 1, 0, '{}', 0, 0, 0, null, null, null);


delete from bus_t_diccolumn where tablecode ='PERF_T_FINEVALUATION' and COLUMNCODE in('PRO_DESC','FUND_TYPE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '1', 'PRO_DESC', '1', '2016', '87', '0E7E07C81C7A6C82E0630A64A8C0BB68', 'PRO_DESC', 'PERF_T_FINEVALUATION', '项目概况', 'S', '4000', null, null, 1, null, sysdate);
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'FINANCIALEVALTYPE', null, '1', 'FUND_TYPE', '1', '2016', '87', '0E7FB8B0869E1C78E0630A64A8C0E265', 'FUND_TYPE', 'PERF_T_FINEVALUATION', '类别', 'S', '40', null, 1, 1, null, sysdate);



  --财政评价成果上传编辑区字段修改
delete from p#busfw_t_uieditform t where key ='/pmkpi/evaluation/financial/result/edit' and columncode  in('SCORE','EXISTQUESTION','FEEDBACK');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'i', '分数', 'SCORE', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '存在的问题', 'EXISTQUESTION', 1, null, 1, null, 10, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '应用建议', 'FEEDBACK', 1, null, 1, null, 11, 3, '3', 'pmkpi', 1, null, '{}', null, null, null, null, null, null);


--财政评价列表添加展示字段
delete from p#busfw_t_uicolumn t where key ='/pmkpi/evaluation/financial/program' and columncode in('FUND_TYPE','PRO_TOTAL_AMT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/program', 'FUND_TYPE', '类别', 22, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{ispro:1}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/financial/program', 'PRO_TOTAL_AMT', '项目总金额', 23, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{ispro:1}', null,  null, null);
