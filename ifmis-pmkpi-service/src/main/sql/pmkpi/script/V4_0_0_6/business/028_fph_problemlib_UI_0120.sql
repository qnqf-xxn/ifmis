begin
  

--问卷库
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/setting/baseinfo/problemlib';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C99B97E955C140D095D7134FE753FA58', '/pmkpi/setting/baseinfo/problemlib', 'V_PERF_PROBLEMLIB', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/setting/baseinfo/problemlib';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('346347519C484F8441D271F242424275', '/pmkpi/setting/baseinfo/problemlib', 'DESCS', '问题简述', 1, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1324241435430592457D1E0364324', '/pmkpi/setting/baseinfo/problemlib', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('424242thewerw242031742671FF454', '/pmkpi/setting/baseinfo/problemlib', 'OPTIONS', '选项', 2, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('Frteh22A9C4D0CBDBAD8C6632eerte35', '/pmkpi/setting/baseinfo/problemlib', 'REMARK', '备注', 3, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('24345FE4BE2B01EC98B0B5D524234534', '/pmkpi/setting/baseinfo/problemlib', 'CREATETIME', '创建时间', 4, 1, 0, 0, null, 0, null, null, null, null, null, null, 1, 's', null, null);


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/setting/baseinfo/problemlib';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('3252A6D04844AD785F9E857B4235gfeg', '/pmkpi/setting/baseinfo/problemlib', 'DESCS', '信用等级', 3, 1, 's', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/problemlib';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('uff34B0B1A6DF4B78B2D83E62435308B', '/pmkpi/setting/baseinfo/problemlib', '查询', 1, 4, 'Keepicon', 'baseinfo.query', null, '查询', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('57wf773AA6AB42A3ABDD4D9F41D9E4A1', '/pmkpi/setting/baseinfo/problemlib', '新增', 1, 1, 'Keepicon', 'baseinfo.add', null, '新增', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2524634hgsgsBABA09AAD4352AC45633', '/pmkpi/setting/baseinfo/problemlib', '修改', 1, 2, 'Keepicon', 'baseinfo.update', null, '修改', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8343463F4F4ABE846AA2530617346346', '/pmkpi/setting/baseinfo/problemlib', '删除', 1, 3, 'Keepicon', 'baseinfo.del', null, '删除', 'pmkpi', null, null, null);


--问卷库编辑

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/problemlib/edit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2424DD5C7214C6F9242424F59C3424', '/pmkpi/setting/baseinfo/problemlib/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('424242969A4242424242424141ewfwe', '/pmkpi/setting/baseinfo/problemlib/edit', '保存', 1, 1, 'Keepicon', 'baseinfoedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null);


DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/setting/baseinfo/problemlib/edit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('ewfew772A69E4256A9BF8DD6DCEE66wef', '/pmkpi/setting/baseinfo/problemlib/edit', 'V_PERF_PROBLEMLIB', 's', '主键', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('346346CF7530434636364363468BB3641', '/pmkpi/setting/baseinfo/problemlib/edit', 'V_PERF_PROBLEMLIB', 'tree', '问题类型', 'PROBLEMTYPE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3636895E5403ABD9B2364634dgsfsfdg', '/pmkpi/setting/baseinfo/problemlib/edit', 'V_PERF_PROBLEMLIB', 'textarea', '问题描述', 'DESCS', 1, null, 1, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('19C134654364468B934702DEE346', '/pmkpi/setting/baseinfo/problemlib/edit', 'V_PERF_PROBLEMLIB', 's', '年度', 'YEAR', 0, null, 0, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3646270FDAA142C89DD79D1423463466', '/pmkpi/setting/baseinfo/problemlib/edit', 'V_PERF_PROBLEMLIB', 's', '区划', 'PROVINCE', 0, null, 0, null, 31, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('463494044BE400B3434634gfsrwg343', '/pmkpi/setting/baseinfo/problemlib/edit', 'V_PERF_PROBLEMLIB', 'textarea', '选项', 'OPTIONS', 1, null, 1, null, 5, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('43534534D95436687F6268F34534534', '/pmkpi/setting/baseinfo/problemlib/edit', 'V_PERF_PROBLEMLIB', 'textarea', '备注', 'REMARK', 1, null, 1, null, 6, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

