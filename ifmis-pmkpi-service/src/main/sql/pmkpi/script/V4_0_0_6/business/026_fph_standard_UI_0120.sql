begin
  
--标准库
DELETE FROM p#busfw_t_Uitable t where t.key='/pmkpi/setting/baseinfo/standard';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('7B33B00F6D17406A8FAE3C8D7AF61A54', '/pmkpi/setting/baseinfo/standard', 'V_PERF_STANDARDLIB', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM p#busfw_t_Uicolumn t where t.key='/pmkpi/setting/baseinfo/standard';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('222CA6719C484F8441D271F242424275', '/pmkpi/setting/baseinfo/standard', 'NAME', '名称', 1, 1, 0, 0, null, 1, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('13242414B420592457D1E007B242424', '/pmkpi/setting/baseinfo/standard', 'GUID', 'GUID', 0, 0, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('42424242424639F104242031742671FF', '/pmkpi/setting/baseinfo/standard', 'RELEASEAGENCY', '发布单位', 2, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F24E3A6E22A9C4D0CBDBAD8C66324242', '/pmkpi/setting/baseinfo/standard', 'RELEASESTATUS', '发布状态', 3, 1, 0, 0, null, 0, null, null, '#name', null, null, null, 0, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('24242850FE4BE2B01EC98B0B5D524242', '/pmkpi/setting/baseinfo/standard', 'TYPE', '标准类型', 4, 1, 0, 0, null, 0, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('454529542B9A14CB8FB29A5A54545gtg', '/pmkpi/setting/baseinfo/standard', 'LINE1', '优', 5, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('243606CE33F4337D772E3F4DCFE3535', '/pmkpi/setting/baseinfo/standard', 'LINE2', '良', 6, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('353564235A278056A835353535tefr3r', '/pmkpi/setting/baseinfo/standard', 'LINE3', '中', 7, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33071739F674D47950A2991D343343tf', '/pmkpi/setting/baseinfo/standard', 'LINE4', '差', 8, 1, 0, 0, null, 0, null, null, null, null, null, null, 0, 's', null, null);



DELETE FROM p#busfw_t_Uiqueryform t where t.key='/pmkpi/setting/baseinfo/standard';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('4C5E9695B3AC4044A0DD22572D537095', '/pmkpi/setting/baseinfo/standard', 'NAME', '名称', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_EXPERTINIFO', '{}', null);



DELETE FROM p#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/standard';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2324B0B1A6DF4B78B2D83E62B61A9242', '/pmkpi/setting/baseinfo/standard', '查询', 1, 4, 'Keepicon', 'baseinfo.query', null, '查询', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('242C9D3AA6A2424D9F41D9E4A1242424', '/pmkpi/setting/baseinfo/standard', '新增', 1, 1, 'Keepicon', 'baseinfo.add', null, '新增', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2435309AA4343860AAC5EA2E44673353', '/pmkpi/setting/baseinfo/standard', '修改', 1, 2, 'Keepicon', 'baseinfo.update', null, '修改', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('82343EF3F4F4ABE846340934ffsads34', '/pmkpi/setting/baseinfo/standard', '删除', 1, 3, 'Keepicon', 'baseinfo.del', null, '删除', 'pmkpi', null, null, null);


--标准库编辑

DELETE FROM p#busfw_t_Uifunction t where t.key='/pmkpi/setting/baseinfo/standard/edit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2342D5C7214C6F96B19162F59C34C4', '/pmkpi/setting/baseinfo/standard/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2424242424364F74DE7980E0969A242', '/pmkpi/setting/baseinfo/standard/edit', '保存', 1, 1, 'Keepicon', 'baseinfoedit.infosave', null, '保存', 'pmkpi', 'infosave', null, null);


DELETE FROM p#busfw_t_Uieditform t where t.key='/pmkpi/setting/baseinfo/standard/edit';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7BE32BC7DC6A41C0AA50BC6DBAEE89AE', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '主键', 'GUID', 0, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3A3627D6C24C4E68B2F7D8BB82D3248E', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准编码', 'CODE', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('851F705895E5403ABD9B2920D2E2F3C8', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准名称', 'NAME', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('9F7C2A64D26F4E94AB8279230994C102', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 'd', '发布日期', 'RELEASEDATA', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6323595436687F6268F16925323532', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 'tree', '标准类型', 'TYPE', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('CAC421B094E04FD789AD396035F4255B', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '发布单位', 'RELEASEAGENCY', 1, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('35232324471C8646707F73235235325', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 'tree', '发布状态', 'RELEASESTATUS', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{"format":"#code-#name"}', 0, 1, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('06FAAB71A0D54427990C1C5C0A1FD48B', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '测量单位', 'UNIT', 1, null, 0, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7BFBD1D7FEA0401F813DC28CF1BA9704', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '测量方法', 'METHOD', 1, null, 0, null, 10, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D20BE2697C1545A0B8BB404DF54198FA', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（优）', 'LINE1', 1, null, 0, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('131353grgr4DF5419813122323232323', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（良）', 'LINE2', 1, null, 0, null, 15, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('23236707F7381D76A45454544334545', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（中）', 'LINE3', 1, null, 0, null, 17, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('46577CF19FF1474tfwwwre707F7381D76A', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（差）', 'LINE4', 1, null, 0, null, 19, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1323697C1545A0B8BB404DF54198131', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（优）描述', 'DESC1', 1, null, 0, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('2323F1471C864670734343rererwewew', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（良）描述', 'DESC2', 1, null, 0, null, 16, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3435h57FF1471C8646707F738145454', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（中）描述', 'DESC3', 1, null, 0, null, 18, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('45wetwFF1471C8646707Fwtwtwetwe6A', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 's', '标准线（差）描述', 'DESC4', 1, null, 0, null, 20, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('tr345sfgFF1471C8646707F7381D425', '/pmkpi/setting/baseinfo/standard/edit', 'V_PERF_STANDARDLIB', 'textarea', '标准说明', 'REMARK', 1, null, 0, null, 22, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

