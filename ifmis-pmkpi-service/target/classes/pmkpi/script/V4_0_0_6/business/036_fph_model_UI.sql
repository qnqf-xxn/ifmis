begin

--模板
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/setting/model/list';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9897D6C20AD09A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', 'V_PERF_T_MODEL', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/setting/model/list';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20AE09A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', 'DESCRIBE', '模板说明', 4, 1, 1, 0, null, 0, null, null, null, null, null, 300, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20AF09A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', 'FRAMESYSTEM', '指标体系', 2, 1, 1, 0, null, 1, null, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20B009A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', 'NAME', '模板名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 220, 0, 's', null, null);



DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/setting/model/list';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20B109A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_MODEL', null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/model/list';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9897D6C20B209A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', '查询', 1, 4, 'searchicon', 'model.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9897D6C20B309A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', '新增', 1, 1, 'searchicon', 'model.add', null, '新增', 'pmkpi', 'add', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9897D6C20B409A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', '删除', 1, 3, 'searchicon', 'model.del', null, '删除', 'pmkpi', 'del', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9897D6C20B509A4E053B11FA8C0BD99', '/pmkpi/setting/model/list', '修改', 1, 2, 'searchicon', 'model.update', null, '修改', 'pmkpi', 'update', null, '{}');


--模板编辑
DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/setting/modelinfo/edit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9897D6C20B609A4E053B11FA8C0BD99', 'pmkpi', '/pmkpi/setting/modelinfo/edit', '基本信息', 'editform', 1, 1, 'choosed', 'modelindex.clickTabpage', null, '基本信息', null, null, '{}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9897D6C20B709A4E053B11FA8C0BD99', 'pmkpi', '/pmkpi/setting/modelinfo/edit', '绩效目标', 'goaleditform', 1, 2, 'nomal', 'modelindex.clickTabpage', null, '绩效目标', null, null, '{}', null, '0', 'goaleditform', null, null, null, null, null, NULL);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B9897D6C20B809A4E053B11FA8C0BD99', 'pmkpi', '/pmkpi/setting/modelinfo/edit', '绩效指标', 'indexdatatable', 1, 3, 'nomal', 'modelindex.clickTabpage', null, '绩效指标', null, null, '{}', null, '0', 'indexdatatable', null, null, null, null, null, NULL);


DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/setting/modelinfo/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B9897D6C20B909A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/index', 'PERF_T_CASEMODELINDEX', 0, 0, 0, null, null, 'pmkpi', '{}');



DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/setting/modelinfo/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20BA09A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/index', 'COMPUTESIGN', '计算符号', 4, 1, 1, null, null, null, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20BB09A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/index', 'FINDEX', '一级指标', 1, 1, 1, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{filtersql:" isleaf = 0"}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20BC09A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/index', 'INDEXVALUE', '指标值', 5, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20BD09A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/index', 'METERUNIT', '计量单位', 6, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20BE09A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/index', 'NAME', '三级指标名称', 3, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9897D6C20BF09A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/index', 'SINDEX', '二级指标', 2, 1, 1, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{filtersql:"  guid in (select guid from v_perf_t_frame k where k.superid = \''#findex\'')"}', null);



DELETE FROM P#busfw_t_uieditform t where t.key='/pmkpi/setting/modelinfo/goal';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9897D6C20C009A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/goal', 'V_PERF_T_MODELMODELGOAL', 's', '主键', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9897D6C20C109A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/goal', 'V_PERF_T_MODELMODELGOAL', 'textarea', '年度目标', 'NDGOAL', 1, null, 0, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9897D6C20C209A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/goal', 'V_PERF_T_MODELMODELGOAL', 'textarea', '中期目标', 'ZQGOAL', 1, null, 0, null, 2, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);



DELETE FROM P#busfw_t_uieditform t where t.key='/pmkpi/setting/modelinfo/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9897D6C20C309A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/edit', 'V_PERF_T_MODEL', 's', '名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9897D6C20C409A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/edit', 'V_PERF_T_MODEL', 's', '编号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B9897D6C20C509A4E053B11FA8C0BD99', '/pmkpi/setting/modelinfo/edit', 'V_PERF_T_MODEL', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/modelinfo/edit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B969E8EFDF5D4F6FE053B11FA8C0BFC4', '/pmkpi/setting/modelinfo/edit', '保存', 1, 1, 'Keepicon', 'modelindex.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B969E8EFDF5E4F6FE053B11FA8C0BFC4', '/pmkpi/setting/modelinfo/edit', '取消', 1, 2, 'Nofinishicon', 'modelindex.close', null, '取消', 'pmkpi', null, null, null);
