begin
delete from p#busfw_t_uitable where key = '/pmkpi/setting/expdoctemp';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BFD1CC24688CDpoE053B11FA8C0461F', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCSUB', 100, null, null, null, null, 'pmkpi', null);

delete from p#busfw_t_uitable where key = '/pmkpi/setting/expdoc';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BFC33581PPOOF50AE053B11FAC0F274', '/pmkpi/setting/expdoc', 'PERF_T_EXPDOCMAIN', 0, 0, 0, null, null, 'pmkpi', null);


delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/expdoctemp';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E7B06C18194A43D1APOP7DD903B65PPP', '/pmkpi/setting/expdoctemp', 'GUID', '主键', 1, 0, 0, null, null, 1, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('676049F161814POP8EA943B3DB8229PP', '/pmkpi/setting/expdoctemp', 'TABLECODE', '表编码', 2, 1, 1, null, null, 1, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B8925348D4114315POPPCFF2B02C1PPP', '/pmkpi/setting/expdoctemp', 'MAINGUID', '模板定义guid', 3, 0, 1, null, null, 1, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E7B06C18194A43D1POP27DD903B657PP', '/pmkpi/setting/expdoctemp', 'DATAKEY', '数据别名', 4, 1, 1, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('505A708441CF48EE896POP2542D2C4PP', '/pmkpi/setting/expdoctemp', 'QUERYTYPE', '查询类型', 5, 1, 1, null, null, 1, 1, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B8925348D4114315AOOOPF2B02C14PP', '/pmkpi/setting/expdoctemp', 'WHERESQL', '查询条件', 6, 1, 1, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A3963BF15E284A14B1CPPP99FDBC0DPP', '/pmkpi/setting/expdoctemp', 'ORDERNUM', '排序', 7, 1, 1, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('072ECF81B143468FBPPPP1FCD05003PP', '/pmkpi/setting/expdoctemp', 'PROVINCE', '区划', 10, 0, 0, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9A9E1F1DDB6642358POP233612467CPP', '/pmkpi/setting/expdoctemp', 'STATUS', '状态', 8, 0, 0, null, null, 0, null, null, null, null, null, null, 0, '0', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5993C32F32A1416B8PPP1528B747F2PP', '/pmkpi/setting/expdoctemp', 'CREATETIME', '创建时间', 11, 0, 0, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5993C32F32A1096B8PPP1528B747F2PP', '/pmkpi/setting/expdoctemp', 'UPDATETIME', '更新时间', 12, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5993C30992A1416B8PPP1528B747F2PP', '/pmkpi/setting/expdoctemp', 'YEAR', '年度', 9, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('072ECF81B143468FBPPPP1FCD05003PP', '/pmkpi/setting/expdoctemp', 'WHOLENAME', null, 13, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', '{}', null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/setting/expdoc';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E7B06C18194A43D1APOP7DD903B6571D', '/pmkpi/setting/expdoc', 'GUID', '主键', 1, 0, 0, null, null, 1, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('676049F161814POP8EA943B3DB8229EE', '/pmkpi/setting/expdoc', 'TEMPLATECODE', '模板编码', 2, 1, 1, null, null, 1, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B8925348D4114315POPPCFF2B02C1409', '/pmkpi/setting/expdoc', 'TEMPLATENAME', '模板名称', 3, 1, 1, null, null, 1, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E7B06C18194A43D1POP27DD903B6571D', '/pmkpi/setting/expdoc', 'EXPFILENAME', '导出文件名称', 4, 1, 1, null, null, 0, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('505A708441CF48EE896POP2542D2C4B0', '/pmkpi/setting/expdoc', 'EXPTYPE', '导出类型', 5, 1, 1, null, null, 1, 1, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B8925348D4114315AOOOPF2B02C1409', '/pmkpi/setting/expdoc', 'ISZIP', '是否可压缩', 6, 1, 1, null, null, 0, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A3963BF15E284A14B1CPPP99FDBC0D45', '/pmkpi/setting/expdoc', 'ORDERNUM', '排序', 7, 1, 1, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('072ECF81B143468FBPPPP1FCD05003B8', '/pmkpi/setting/expdoc', 'PROVINCE', '区划', 10, 0, 0, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9A9E1F1DDB6642358POP233612467C54', '/pmkpi/setting/expdoc', 'STATUS', '状态', 8, 0, 0, null, null, 0, null, null, null, null, null, null, 0, '0', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5993C32F32A1416B8PPP1528B747F2CA', '/pmkpi/setting/expdoc', 'CREATETIME', '创建时间', 11, 0, 0, null, null, 0, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5993C32F32A1096B8PPP1528B747F2CA', '/pmkpi/setting/expdoc', 'UPDATETIME', '更新时间', 12, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5993C30992A1416B8PPP1528B747F2CA', '/pmkpi/setting/expdoc', 'YEAR', '年度', 9, 0, 0, null, null, 0, null, null, null, null, null, null, null, 's', '{}', null);







delete from p#busfw_t_uifunction where key = '/pmkpi/setting/expdoctemp';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFD1CC246PPPD987E053B11FA8C0461F', '/pmkpi/setting/expdoctemp', '保存', 1, 1, 'Keepicon', 'expdoctemp.save', null, '保存', 'pmkpi', 'save', null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/setting/expdoc';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFC33581ppppF50AE053B11FA8C0F274', '/pmkpi/setting/expdoc', '新增', 1, 0, 'searchicon', 'expdoc.add', null, '新增', 'pmkpi', 'add', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFC33581E24AF50opoppB11FA8C0F274', '/pmkpi/setting/expdoc', '修改', 1, 1, 'searchicon', 'expdoc.mod', null, '修改', 'pmkpi', 'mod', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFC33581E2POPO0AE053B11FA8C0F274', '/pmkpi/setting/expdoc', '删除', 1, 2, 'searchicon', 'expdoc.del', null, '删除', 'pmkpi', 'del', null, '{}');

delete from p#busfw_t_uifunction where key = '/pmkpi/setting/expdoc/set';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFD1CC246PPPD987E090B11FA8C0461F', '/pmkpi/setting/expdoc/set', '保存', 1, 1, 'Keepicon', 'expdocset.save', null, '保存', 'pmkpi', 'save', null, null);




delete from p#busfw_t_uiqueryform where key = '/pmkpi/setting/expdoc';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('EC39909688401EECB0D09DB633B07718', '/pmkpi/setting/expdoc', 'TEMPLATECODE', '模板编码', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_EXPDOCMAIN', '{}', null);





delete from p#busfw_t_uieditform where key = '/pmkpi/setting/expdoctemp';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96273DB72E053B11FA8C0A1p1', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', '模板编码', 'TEMPLATECODE', 1, null, 1, null, 9, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96274DB72E053B11FA8C0A1P2', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', '模板名称', 'TEMPLATENAME', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96275DB72E053B11FA8C0A1P3', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', '导出文件名称', 'EXPFILENAME', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96276DB72E053B11FA8C0A1P4', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', 'GUID', 'GUID', 0, null, 1, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96277DB72E053B11FA8C0A1P5', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 'tree', '导出类型', 'EXPTYPE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96278DB72E053B11FA8C0A1P6', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 'tree', '是否可压缩', 'ISZIP', 1, null, 0, null, 2, null, null, 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC96279DB72E053B11FA8C0A1P7', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', '排序', 'ORDERNUM', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC9627ADB72E053B11FA8C0A1P8', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', '状态', 'STATUS', 1, null, 0, null, 7, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('P0BFD1DBC9627ADP0253B11FA8C0A1P8', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', '区划', 'PROVINCE', 0, null, 0, null, 11, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BFD1DBC9627ADP02E053B11FA8C0A1P8', '/pmkpi/setting/expdoctemp', 'PERF_T_EXPDOCMAIN', 's', '年度', 'YEAR', 0, null, 0, null, 10, null, null, 'pmkpi', 0, null, '{}', null, null, null);





