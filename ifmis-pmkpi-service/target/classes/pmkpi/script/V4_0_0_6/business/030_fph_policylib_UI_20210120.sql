begin
  



--政策法规
DELETE FROM p#busfw_t_Uitable t where t.key= '/pmkpi/setting/baseinfo/policylib';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('34324ECD5E623202E5A16736319323', '/pmkpi/setting/baseinfo/policylib', 'V_PERF_POLICYLIB', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM p#busfw_t_Uicolumn t where t.key= '/pmkpi/setting/baseinfo/policylib';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('346347519C484F8441D271F242424275', '/pmkpi/setting/baseinfo/policylib', 'CODE', '文号', 2, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1324241435430592457D1E0364324', '/pmkpi/setting/baseinfo/policylib', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('424242thewerw242031742671FF454', '/pmkpi/setting/baseinfo/policylib', 'NAME', '文件名称', 1, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('Frteh22A9C4D0CBDBAD8C6632eerte35', '/pmkpi/setting/baseinfo/policylib', 'FILETYPE', '文件类型', 3, 1, 0, 0, null, 0, null, null, null, null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('24345FE4BE2B01EC98B0B5D524234534', '/pmkpi/setting/baseinfo/policylib', 'KEYWORD', '关键词', 5, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('24345FE4BE2B01EC98B0B5D524234534', '/pmkpi/setting/baseinfo/policylib', 'CREATETIME', '发文时间', 4, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);


DELETE FROM p#busfw_t_Uifunction t where t.key= '/pmkpi/setting/baseinfo/policylib';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('235wB1A6DF4B78B2D83E62B61A9wtewt', '/pmkpi/setting/baseinfo/policylib', '删除', 1, 4, 'Keepicon', 'baseinfo.del', null, '删除', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('346fsgAB42A3ABDD4D9F41D9wetw43', '/pmkpi/setting/baseinfo/policylib', '新增', 1, 1, 'Keepicon', 'baseinfo.add', null, '新增', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ryw345346AAD4358860AAC5EA2E44363', '/pmkpi/setting/baseinfo/policylib', '修改', 1, 2, 'Keepicon', 'baseinfo.update', null, '修改', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ryw345346AAD4358860AAC5EA2E44363', '/pmkpi/setting/baseinfo/policylib', '查询', 1, 5, 'Keepicon', 'baseinfo.query', null, '查询', 'pmkpi', null, null, null);


DELETE FROM p#busfw_t_Uiqueryform t where t.key= '/pmkpi/setting/baseinfo/policylib';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('242A6D04844AD785F9E857B4A242424', '/pmkpi/setting/baseinfo/policylib', 'FILETYPE', '文件类型', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);


--政策法规编辑
DELETE FROM p#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/policylib/edit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('352C7214C6F96B19162F59C34C423523', '/pmkpi/setting/baseinfo/policylib/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('235327364F74DE7980E096923523533C', '/pmkpi/setting/baseinfo/policylib/edit', '保存', 1, 1, 'Keepicon', 'baseinfoedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null);


DELETE FROM p#busfw_t_Uieditform t where t.key='/pmkpi/setting/baseinfo/policylib/edit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('ewfew772A69E425wywF8DD6DCEE66wef', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 's', '主键', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('36446CF7530wrtrwy364363468BBwttq', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 's', '文件名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('634E5403ABD9B2364634dgsfsfdg3643wt', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 's', '文号', 'CODE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('19C134654364468B934702DEE346346', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 's', '年度', 'YEAR', 0, null, 0, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3646270FDAA142C89DD79D1423463364', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 's', '区划', 'PROVINCE', 0, null, 0, null, 31, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('463643600B3434634gfsrwg3433463', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 'tree', '文件类型', 'FILETYPE', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('25255436687F6268F3453453425346', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 'textarea', '正文', 'REMARK', 1, null, 1, null, 6, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('wtrrgw4356576352352532523356236', '/pmkpi/setting/baseinfo/policylib/edit', 'V_PERF_POLICYLIB', 'tree', '是否重要', 'ISIMPORTANT', 1, null, 1, null, 7, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);
