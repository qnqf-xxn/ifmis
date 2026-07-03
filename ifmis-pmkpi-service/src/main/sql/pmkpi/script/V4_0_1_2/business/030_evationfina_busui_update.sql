begin
--部门评价附件
update p#busfw_t_uitabpage t set t.config = '{filebustype:''finselfevapro'',url:''/pmkpi/upload/file/index.page''}' where t.key = '/pmkpi/evaluation/financial/deptfill/proedit' and name = '附件上传';

update p#busfw_t_uitabpage t set t.config = '{filebustype:''finevapro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}' where t.key = '/pmkpi/evaluation/financial/deptfill/proedit' and name = '项目资料';

update p#busfw_t_uitabpage t set t.config = '{filebustype:''finselfevadeptpro'',url:''/pmkpi/upload/file/index.page''}' where t.key = '/pmkpi/evaluation/financial/deptfill/deptedit' and name = '附件上传';

update p#busfw_t_uitabpage t set t.config = '{filebustype:''finevadeptpro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}' where t.key = '/pmkpi/evaluation/financial/deptfill/deptedit' and name = '项目资料';

--指派中介需要修改内容
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluate/thirdevaluate/entrust';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3E5F9FB29D7ECEE053B11FA8C00129', '/pmkpi/evaluate/thirdevaluate/entrust', '确定', 1, 1, 'searchicon', 'evaluateentrustservice.save', null, '确定', 'pmkpi', 'save', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD3E5F9FB29E7ECEE053B11FA8C00129', '/pmkpi/evaluate/thirdevaluate/entrust', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'close', null, null);

update p#busfw_t_uicolumn t set t.type = 's' where  key = '/pmkpi/evaluate/thirdevaluate/entrust' and columncode = 'EVALUATENUM';

--财政评价成果上传增加查看自评信息按钮
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/financial/resultupload' and name = '查看自评信息';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD53D19B02782359E053B11FA8C0BCAe', '/pmkpi/evaluation/financial/resultupload', '查看自评信息', 0, 9, 'searchicon', 'finevaluationresult.queryassessment', null, '查看自评信息', 'pmkpi', 'queryassessment', null, '{}');

--财政评价部门整体信息
delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/finconfirm/deptedit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02CE2359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '部门名称', 'NAME', 1, null, 0, null, 4, 1, 2, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02D02359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '项目guid', 'PROGUID', 0, null, 1, null, 2, 1, 2, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02CD2359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '部门编码', 'CODE', 1, null, 0, null, 3, 1, 2, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD53D19B02CF2359E053B11FA8C0BCA2', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', 'guid', 'GUID', 0, null, 1, null, 1, 1, 2, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('PEACBF7062DA2AC8E053B11FA8C05B8C', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 'tree', '主管处室', 'FININTORGGUID', 1, null, 0, null, 17, 1, 2, 'pmkpi', 1, 0, '{"format":"#name"}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BP2A3B90E58C3AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '联系人', 'PROJECTCON', 1, null, 0, null, 10, 1, 2, 'pmkpi', 1, 0, '{}', 0, 0, 0);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BP2A3B90E58D3AC1E053B11FA8C06F54', '/pmkpi/evaluation/finconfirm/deptedit', 'V_PERF_T_FINEVALUATION', 's', '联系人电话', 'LEADER_PHONE', 1, null, 0, null, 11, 1, 2, 'pmkpi', 1, 0, '{}', 0, 0, 0);

--中介库联系电话取联系方式的值
update p#busfw_t_uicolumn t set t.columncode = 'TEL' where t.key = '/pmkpi/setting/baseinfo/intermediaryinfo' and t.columncode = 'PHONE';


--专家姓名转为文本框录入

update p#busfw_t_uieditform t set t.ISVISIABLE = '0',t.NAME = 'GUID' where key = '/pmkpi/setting/baseinfo/expertinifo/edit' and COLUMNCODE = 'GUID';
update p#busfw_t_uieditform t set t.ISVISIABLE = '1' where key = '/pmkpi/setting/baseinfo/expertinifo/edit' and COLUMNCODE = 'NAME';



--部门整体隐藏关于项目信息的附件管理

update p#busfw_t_uitabpage t set t.ISVISIABLE = 0 where key = '/pmkpi/evaluation/financial/deptfill/deptedit' and name = '项目资料';
update p#busfw_t_uitabpage t set t.ISVISIABLE = 0 where key = '/pmkpi/evaluation/finconfirm/deptedit' and name = '附件管理';
update p#busfw_t_uitabpage t set t.ISVISIABLE = 0 where key = '/pmkpi/evaluation/financial/result/deptedit' and name = '项目附件';


