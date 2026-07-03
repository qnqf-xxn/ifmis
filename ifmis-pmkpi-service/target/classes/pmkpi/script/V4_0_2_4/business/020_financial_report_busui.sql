begin

--广西-财政终稿报告上传-按钮注册
delete from p#busfw_t_uifunction where key = '/pmkpi/evaluation/financial/resultaudit' and name = '上传终稿评价报告';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D9389BA0CDA05150E0533315A8C08AB0', '/pmkpi/evaluation/financial/resultaudit', '上传终稿评价报告', 1, 3, 'searchicon', 'finevaluationresult.reportupload', null, '上传终稿评价报告', 'pmkpi', 'reportupload', null, '{}');

--财政终稿报告上传-上传终稿评价报告-按钮弹框-项目支出
--按钮
delete from p#busfw_t_uifunction where key  ='/pmkpi/evaluation/financial/report/edit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D9387C7CE9DE5EF7E0533315A8C033EC', '/pmkpi/evaluation/financial/report/edit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D9387C7CE9DF5EF7E0533315A8C033EC', '/pmkpi/evaluation/financial/report/edit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);
--编辑区
delete from p#busfw_t_uieditform where key ='/pmkpi/evaluation/financial/report/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D9387C7CE9E05EF7E0533315A8C033EC', '/pmkpi/evaluation/financial/report/edit', 'V_PERF_T_FINEVALUATION', 's', 'guid', 'GUID', 0, null, 0, null, 1, 0, '0', 'pmkpi', 1, 0, '{}', 0, 0, 0);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D9387C7CE9E15EF7E0533315A8C033EC', '/pmkpi/evaluation/financial/report/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '存在问题', 'EXISTQUESTION', 1, null, 1, null, 2, 3, '3', 'pmkpi', 0, null, '{}', null, null, null);
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D9387C7CE9E25EF7E0533315A8C033EC', '/pmkpi/evaluation/financial/report/edit', 'V_PERF_T_FINEVALUATION', 'textarea', '整改措施和建议', 'FEEDBACK', 1, null, 1, null, 3, 3, '3', 'pmkpi', 0, null, '{}', null, null, null);
--页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/evaluation/financial/report/edit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9E35EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/edit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9E45EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/edit', '项目附件', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{filebustype:''finevapro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9E55EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/edit', '评分表', 'score', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{url:''/pmkpi/evaluation/financial/deptfill/score.page''}', null, '0', 'scoreiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9E65EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/edit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2''}', null, '0', 'editform', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9E75EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/edit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{filebustype:''finevaproresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

--财政终稿报告上传-上传终稿评价报告-按钮弹框-部门整体
--按钮
delete from p#busfw_t_uifunction where key  ='/pmkpi/evaluation/financial/report/deptedit';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D9387C7CE9E85EF7E0533315A8C033EC', '/pmkpi/evaluation/financial/report/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D9387C7CE9E95EF7E0533315A8C033EC', '/pmkpi/evaluation/financial/report/deptedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);
--页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/evaluation/financial/report/deptedit';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9EA5EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/deptedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9EB5EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/deptedit', '项目附件', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目附件', null, '保存', '{filebustype:''finevadeptpro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9EC5EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/deptedit', '评分表', 'score', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{url:''/pmkpi/evaluation/financial/deptfill/deptedit/score.page''}', null, '0', 'scoreiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9ED5EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/deptedit', '评估结论', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评估结论', null, null, '{busguid:''BD53D19B028A2359E053B11FA8C0BCA2''}', null, '0', 'editform', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D9387C7CE9EE5EF7E0533315A8C033EC', 'pmkpi', '/pmkpi/evaluation/financial/report/deptedit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{filebustype:''finevadeptproresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);





