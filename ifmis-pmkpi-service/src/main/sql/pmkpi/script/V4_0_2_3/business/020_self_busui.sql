begin

--列表预算执行率进行修改
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/query') and t.COLUMNCODE in('EXECRATE','BGTGET');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BB4894A330D3480A9BDBA7FB83086957', '/pmkpi/perfself/query', 'BGTGET', '预算执行率', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

--指标添加得失分依据及原因
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/apply/edit/selfindex') and t.COLUMNCODE in('SCORE_REMARK');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D158BD7176382DF2E0533315A8C064F2', '/pmkpi/perfself/apply/edit/selfindex', 'SCORE_REMARK', '得失分依据及原因', 13, 0, 1, 0, '0', 0, 6, null, null, null, 0, 150, 0, 's', '{}', null);

--自评审核导入评审意见按钮
delete from p#busfw_t_uifunction t where t.key in('/pmkpi/perfself/audit/index') and t.code='importopinion';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D42BA37665112A20E0533315A8C085FA', '/pmkpi/perfself/audit/index', '导入评审意见', 0, 11, 'searchicon', 'perfselfaudit.importopinion', null, '导入评审意见', 'pmkpi', 'importopinion', null, '{}');

--填报添加评审意见页签
delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/perfself/apply/edit') and t.code='opinion';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D42BA37663BD2A20E0533315A8C085FA', 'pmkpi', '/pmkpi/perfself/apply/edit', '评审意见', 'opinion', 0, 6, 'nomal', 'tabfreamedit.clickTabpage', null, '评审意见', null, '保存', '{url:''/pmkpi/self/opinion/edit.page'',busguid:''D42BA37663F92A20E0533315A8C085FA''}', null, '0', 'opinioniframe', null, null, null, null, null, null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/perfself/apply/dept/edit') and t.code='opinion';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D42BA37664042A20E0533315A8C085FA', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '评审意见', 'opinion', 0, 10, 'nomal', 'tabfreamedit.clickTabpage', null, '评审意见', null, '保存', '{url:''/pmkpi/self/opinion/edit.page'',busguid:''D4BCF217F4D24105E0533315A8C048CC''}', null, '0', 'opinioniframe', null, null, null, null, null, null);

--自评填报评审意见
delete from p#busfw_t_uieditform t where t.key in('/pmkpi/self/opinion/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D42BA37663B62A20E0533315A8C085FA', '/pmkpi/self/opinion/edit', 'V_PERF_T_SELFPERFOPINION', 'textarea', '内容完整性', 'CONTENT_REMARK', 1, null, 1, null, 4, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D42BA37663B72A20E0533315A8C085FA', '/pmkpi/self/opinion/edit', 'V_PERF_T_SELFPERFOPINION', 'textarea', '论证充分性', 'DEMONSTRATION_REMARK', 1, null, 1, null, 5, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D42BA37663B82A20E0533315A8C085FA', '/pmkpi/self/opinion/edit', 'V_PERF_T_SELFPERFOPINION', 'textarea', '结果客观性', 'RESULT_REMARK', 1, null, 1, null, 6, 3, '2', 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D42BA37663B52A20E0533315A8C085FA', '/pmkpi/self/opinion/edit', 'V_PERF_T_SELFPERFOPINION', 'n', '评审得分', 'OPINIONSCORE', 0, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uifunction t where t.key in('/pmkpi/self/opinion/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D42BA37664012A20E0533315A8C085FA', '/pmkpi/self/opinion/edit', '保存', 1, 1, 'searchicon', 'selfopinion.save', null, '保存', 'pmkpi', 'save', null, '{}');
