begin

--中介库
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/setting/baseinfo/intermediaryinfo';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B6FA04ECD5E64C4C8E02E5A167363193', '/pmkpi/setting/baseinfo/intermediaryinfo', 'V_PERF_INTERMEDIARYINFO', 100, 0, 0, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/setting/baseinfo/intermediaryinfo';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('58F86FD1FEE648F3A966C5F1BB42D570', '/pmkpi/setting/baseinfo/intermediaryinfo', 'NAME', '机构名称', 1, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DF1A1A2B946C45EAA98BF51E2B84058B', '/pmkpi/setting/baseinfo/intermediaryinfo', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9F47719B690148E9A9D2FC87DBF25AC8', '/pmkpi/setting/baseinfo/intermediaryinfo', 'INSTITUTIONAL', '机构性质', 3, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FC6FAEEB0CE744FBAC16C432DCA0DFD2', '/pmkpi/setting/baseinfo/intermediaryinfo', 'SCOPEBUSINESS', '业务范围', 5, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EFD80B4133944A52B1885BA01D342E7B', '/pmkpi/setting/baseinfo/intermediaryinfo', 'CREDITNO', '信用等级', 7, 1, 0, 0, null, 0, null, null, '#code-#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('71E55EE685CB4D6A83E96B88D8FBDDAB', '/pmkpi/setting/baseinfo/intermediaryinfo', 'EVALUATENUM', '评价累计数', 9, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B8F8ADA1C72647C4885EDCBA5503A7D5', '/pmkpi/setting/baseinfo/intermediaryinfo', 'ADDRESS', '机构地址', 11, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('64F0234847914B5AA3323DFF6C548A97', '/pmkpi/setting/baseinfo/intermediaryinfo', 'PHONE', '联系电话', 13, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/intermediaryinfo';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('07CC9D3AA6AB42A3ABDD4D9F41D9E4A1', '/pmkpi/setting/baseinfo/intermediaryinfo', '新增', 1, 1, 'Keepicon', 'baseinfo.add', null, '新增', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DD5BABA09AAD4358860AAC5EA2E44673', '/pmkpi/setting/baseinfo/intermediaryinfo', '修改', 1, 2, 'Keepicon', 'baseinfo.update', null, '修改', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8262A56CEF3F4F4ABE846AA253061709', '/pmkpi/setting/baseinfo/intermediaryinfo', '删除', 1, 3, 'Keepicon', 'baseinfo.del', null, '删除', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0207B0B1A6DF4B78B2D83E62B61A908B', '/pmkpi/setting/baseinfo/intermediaryinfo', '查询', 1, 4, 'Keepicon', 'baseinfo.query', null, '查询', 'pmkpi', null, null, null);


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/setting/baseinfo/intermediaryinfo';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('3F02330EA6D04844AD785F9E857B4AF2', '/pmkpi/setting/baseinfo/intermediaryinfo', 'CREDITNO', '信用等级', 1, 1, 'tree', null, null, null, 'pmkpi', 'PERF_INTERMEDIARYINFO', '{}', null);


--中介库编辑
DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/intermediaryinfo/edit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D21B9DD5C7214C6F96B19162F59C34C4', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F25A307364F74DE7980E0969A4077E3C', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', '保存', 1, 1, 'Keepicon', 'baseinfoedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null);

DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/setting/baseinfo/intermediaryinfo/edit';


insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D1BF9A83341342779D646D8B6722D890', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '主键', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('778BF2C4CBF448209CD55D635716F412', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '机构编码', 'CODE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6DB4B06273104660AE128508BF695D56', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '机构名称', 'NAME', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1619FF0030AE48D59B6D474D28654B7E', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '法定人', 'LEGALPERSON', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B4AA469BE4E24388921CFC647E4D5F00', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'd', '成立时间', 'OPENDATE', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('520D21475B714510967446A3F76F83AF', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'tree', '机构性质', 'INSTITUTIONAL', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BC1DF0503BA547A78F17313A5EB44F85', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'tree', '信用等级', 'CREDITNO', 1, null, 1, null, 10, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1BB534C961174786A40194544C8D1696', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '社会信用社代码', 'CODS', 1, null, 0, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('631AE8BDB2584226955AA4CAD78AC3C4', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '机构地址', 'ADDRESS', 1, null, 0, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('FE4E5B5C60114456BD12D3F7579037FC', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '联系人', 'EDITPEOPLE', 1, null, 1, null, 16, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6C2CFB8DD4424201806E5BCFEAC61E51', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '联系方式', 'TEL', 1, null, 1, null, 18, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('5B6EE68C646140D8913253AB3937C419', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'tree', '业务范围', 'SCOPEBUSINESS', 1, null, 1, null, 20, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('9F0DF4323C764D07AF141AE2E3B51139', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'tree', '行业大类', 'CATEGORY02', 1, null, 0, null, 22, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3CE21247B2E44E6089287485DAAB3D84', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'tree', '行业类别', 'CATEGORY01', 1, null, 0, null, 24, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('78E9ECE3A775443CBC899D34A35A4BC4', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'boolean', '是否有不良记录', 'ISBADRECORD', 1, null, 0, null, 26, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3C525A2351BD4EF59BEB2BD393679C2B', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'textarea', '近三年参与的绩效评价项目（限2000字内）', 'PERFPRO', 1, null, 0, null, 28, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3234A2351BD4EF59BEB2BD393679C211', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 'textarea', '业绩（限2000字内）', 'ACHIEVEMENT', 1, null, 0, null, 30, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E0AA52EBB458485386335B33406C2D0C', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFO', 's', '年度', 'YEAR', 0, null, 0, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C862D1C2BB014801A2512D25A35D7980', '/pmkpi/setting/baseinfo/intermediaryinfo/edit', 'V_PERF_INTERMEDIARYINFOR', 's', '区划', 'PROVINCE', 0, null, 0, null, 31, null, null, 'pmkpi', 1, null, '{}', null, null, null);
