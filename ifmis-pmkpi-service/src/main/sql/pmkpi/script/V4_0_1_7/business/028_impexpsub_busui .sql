begin

--1.导出模板配置-新增/修改按钮-编辑区添加下拉配置
delete from p#busfw_t_uieditform where key ='/pmkpi/setting/impexp/impexpmianedit' and columncode = 'TABLECODE';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C467215E173618B8E053B11FA8C09553', '/pmkpi/setting/impexp/impexpmianedit', 'V_PERF_T_IMPEXPMAIN', 'tree', '表名', 'TABLECODE', 1, null, 0, null, 100, null, null, 'pmkpi', 1, null, '{format:''#name-#code''}', 1, null, null);

--2.导出模板配置-列配置-展示列注册  
delete from p#Busfw_t_Uicolumn where key = '/pmkpi/setting/impexpsub' and columncode in( 'COLUMNCODE','TYPE','CSID');
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C78616D7FAED2A40E0533315A8C0F159', '/pmkpi/setting/impexpsub', 'COLUMNCODE', '字段编码', 1, 1, 1, 0, null, 1, null, null, '#code-#name', null, null, 50, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C78616D7FAEE2A40E0533315A8C0F159', '/pmkpi/setting/impexpsub', 'CSID', '数据源', 3, 1, 1, 0, null, 0, null, null, '#code-#name', null, null, 100, 1, 'tree', '{}', null);
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C78616D7FAF32A40E0533315A8C0F159', '/pmkpi/setting/impexpsub', 'TYPE', '字段类型', 7, 1, 1, 0, null, 0, null, null, '#code-#name', null, null, 50, 1, 'tree', '{}', null);


