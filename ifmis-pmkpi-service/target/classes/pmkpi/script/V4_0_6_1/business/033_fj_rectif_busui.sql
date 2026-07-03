begin

--注册  整改反馈附件-预算调整建议
delete from bus_t_diccolumn t where t.tablecode='PERF_T_RECTIFY' and t.columncode ='ADJUSTADVICE';

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'PMKPIADJUSTADVICE', null, '1', 'ADJUSTADVICE', '1', '2023', '87', 'CB4C2ER7328A49E0E05T3315A8C09CED', 'ADJUSTADVICE', 'PERF_T_RECTIFY', '预算调整建议', 'S', '40', null, 1, 1, null, sysdate);

--去掉发现问题的数据源csid
update bus_t_diccolumn t set t.CSID = '' where t.tablecode='PERF_T_RECTIFY' and t.csid ='RECSTATE';


--编辑区  整改反馈附件-预算调整建议 默认隐藏
delete from p#busfw_t_uieditform where key = '/pmkpi/rectification/feedbackfile' and columncode = 'ADJUSTADVICE';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/rectification/feedbackfile', 'V_PERF_T_RECTIFY', 'tree', '预算调整建议', 'ADJUSTADVICE', 0, null, 0, null, 2, null, null, 'pmkpi', 1, null, '{format:''#code-#name''}', null, null, null, null, null, null);


