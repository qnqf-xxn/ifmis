begin

--项目
--财政部门自评列表
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/deptassessment/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD92FD88254E170BE053B11FA8C06845', 'pmkpi', '/pmkpi/evaluation/financial/deptassessment/list', '待送审', 'waitaudit', 1, 1, 'choosed', 'findeptassessment.clickTabpage', 0, '待送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD92FD88254F170BE053B11FA8C06845', 'pmkpi', '/pmkpi/evaluation/financial/deptassessment/list', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'findeptassessment.clickTabpage', 0, '已送审', null, '填报,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD92FD882550170BE053B11FA8C06845', 'pmkpi', '/pmkpi/evaluation/financial/deptassessment/list', '曾经办', 'allconfirm', 1, 3, 'nomal', 'findeptassessment.clickTabpage', 0, '曾经办', null, '填报,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/deptassessment/list');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD92FD882556170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment/list', '填报', 1, 1, 'searchicon', 'findeptassessment.mod', null, '填报', 'pmkpi', 'mod', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD92FD882551170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment/list', '送审', 1, 7, 'searchicon', 'findeptassessment.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD92FD882552170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment/list', '取消送审', 1, 8, 'searchicon', 'findeptassessment.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD92FD882553170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment/list', '导出项目', 0, 9, 'searchicon', 'findeptassessment.expdadta', null, '导出项目', 'pmkpi', 'expdata', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD92FD882554170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment/list', '查看项目明细', 1, 14, 'searchicon', 'findeptassessment.detailed', null, '查看项目明细', 'pmkpi', 'detailed', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD92FD882555170BE053B11FA8C06845', '/pmkpi/evaluation/financial/deptassessment/list', '审核情况', 1, 15, 'searchicon', 'findeptassessment.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, '{}');

--财政部门自评编辑
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/deptfill/proedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD9470BB508A48E5E053B11FA8C0AEAA', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/proedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD9470BB508B48E5E053B11FA8C0AEAA', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/proedit', '项目资料', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目资料', null, '保存', '{url:''/pmkpi/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD9470BB508C48E5E053B11FA8C0AEAA', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/proedit', '评分表', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{busguid:''BD9470BB508E48E5E053B11FA8C0AEAA'',url:''/pmkpi/evaluation/financial/deptfill/score.page'',action:''deptfillscore.save''}', null, '0', 'proscoreiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD9470BB508D48E5E053B11FA8C0AEAA', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/proedit', '附件上传', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/deptfill/proedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD9470BB508F48E5E053B11FA8C0AEAA', '/pmkpi/evaluation/financial/deptfill/proedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD9470BB509048E5E053B11FA8C0AEAA', '/pmkpi/evaluation/financial/deptfill/proedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);


--财政部门自评评分表
delete from p#busfw_t_uitable t where key in('/pmkpi/evaluation/financial/deptfill/score');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BE17CC0278BF0A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'V_PERF_T_DEPTSCORE', 0, 1, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where key in('/pmkpi/evaluation/financial/deptfill/score');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C00A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'OBLIGATE1', '操作', 0, 1, 0, 0, null, 0, 6, null, null, null, null, 30, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C00A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'NAME', '指标名称', 1, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C10A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'EXPLAIN', '指标解释', 2, 1, 1, 0, null, 0, 6, null, null, null, null, 180, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C20A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'EVALSTD', '评分标准', 3, 1, 1, 0, null, 0, 6, null, null, null, null, 220, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C30A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'SCORE', '分值', 4, 1, 1, 1, null, 0, 6, null, null, null, null, 30, 0, 'i', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C40A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'SELFSCORE', '得分', 5, 1, 1, 1, null, 1, 6, null, null, null, null, 40, 0, 'amt', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C50A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'REMARK', '单位自评完成情况描述（需附相关佐证材料）', 6, 1, 1, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C60A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'FILE', '佐证材料', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C70A0EE053B11FA8C0EB73', '/pmkpi/evaluation/financial/deptfill/score', 'GUID', 'guid', 8, 0, 0, 0, null, 0, 6, null, null, null, null, 80, 0, 's', null, null);

--部门
--财政部门自评编辑
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/evaluation/financial/deptfill/deptedit');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BE1E82C5734F2289E053B11FA8C0082F', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/deptedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{viewtype:''query''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BE1E82C573502289E053B11FA8C0082F', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/deptedit', '项目资料', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '项目资料', null, '保存', '{url:''/pmkpi/file/index.page'',viewtype:''query''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BE1E82C573512289E053B11FA8C0082F', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/deptedit', '评分表', 'info', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{busguid:''BD9470BB508E48E5E053B11FA8C0AEAA'',url:''/pmkpi/evaluation/financial/deptfill/score.page'',action:''deptfillscore.save''}', null, '0', 'proscoreiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BE1E82C573522289E053B11FA8C0082F', 'pmkpi', '/pmkpi/evaluation/financial/deptfill/deptedit', '附件上传', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件上传', null, '保存', '{url:''/pmkpi/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/evaluation/financial/deptfill/deptedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BE1E82C573532289E053B11FA8C0082F', '/pmkpi/evaluation/financial/deptfill/deptedit', '保存', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BE1E82C573542289E053B11FA8C0082F', '/pmkpi/evaluation/financial/deptfill/deptedit', '关闭', 1, 2, 'Nofinishicon', 'tabfreamedit.close', null, '关闭', 'pmkpi', null, null, null);
