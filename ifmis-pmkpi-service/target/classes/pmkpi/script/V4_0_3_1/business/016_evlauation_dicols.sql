begin
  --财政评价表字段注册
delete from bus_t_diccolumn where tablecode ='PERF_T_FINEVALUATION' and columncode in('GRADE','INDEXEVALUATION','SCORE');
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'GRADE', '1', '2016', '87', 'EB602BC58E6B1F23E0533315A8C06A21', 'GRADE', 'PERF_T_FINEVALUATION', '等级', 'S', '40', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, null, null, '0', 'INDEXEVALUATION', '1', '2016', '87', 'EB602BC58E6A1F23E0533315A8C06A21', 'INDEXEVALUATION', 'PERF_T_FINEVALUATION', '绩效评价指标情况', 'S', '4000', null, null, 1, null, sysdate);

insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION )
values (null, null, null, '0', 'SCORE', '1', '2016', '87', 'EB602BC58E691F23E0533315A8C06A21', 'SCORE', 'PERF_T_FINEVALUATION', '分数', 'N', '10', null, null, 1, null, sysdate);


delete from p#busfw_t_uieditform where key ='/pmkpi/evaluation/financial/result/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'i', '分数', 'SCORE', 0, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null,  null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 's', '等级', 'GRADE', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null,  null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '绩效评价指标情况', 'INDEXEVALUATION', 0, null, 1, null, 6, 3, '3', 'pmkpi', 1, null, '{}', null, null, null,  null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 's', 'guid', 'GUID', 0, null, 0, null, 1, 0, '0', 'pmkpi', 1, 0, '{}', 0, 0, 0,  null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '存在问题', 'EXISTQUESTION', 1, null, 1, null, 4, 3, '3', 'pmkpi', 1, null, '{}', null, null, null,  null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE,  HEAD)
values (sys_guid(), '/pmkpi/evaluation/financial/result/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '整改措施和建议', 'FEEDBACK', 1, null, 1, null, 5, 3, '3', 'pmkpi', 1, null, '{}', null, null, null,  null);

