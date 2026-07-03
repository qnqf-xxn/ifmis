begin
  
--案例
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/setting/case/list';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('298436FADF984E6CA3A4D54406448DC6', '/pmkpi/setting/case/list', 'V_PERF_T_CASE', 0, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/setting/case/list';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F97DCE562CC849CBA2C896A3C97459AC', '/pmkpi/setting/case/list', 'DESCRIBE', '模板说明', 4, 1, 1, 0, null, 0, null, null, null, null, null, 300, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7489EC05C5564CBAB7F0FD5E996933DB', '/pmkpi/setting/case/list', 'FRAMESYSTEM', '指标体系', 2, 1, 1, 0, null, 1, null, null, '#name', null, null, 150, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6D2711294AD74DB1B5044EE4E782F120', '/pmkpi/setting/case/list', 'NAME', '模板名称', 3, 1, 1, 0, null, 1, null, null, null, null, null, 220, 0, 's', null, null);



DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/setting/case/list';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('851120EC0AEA4CE2A92D32277CC77C41', '/pmkpi/setting/case/list', 'NAME', '名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_CASE', null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/case/list';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('500BC81A39F14DAB98784762BF1D9D4E', '/pmkpi/setting/case/list', '查询', 1, 4, 'searchicon', 'model.query', null, '查询', 'pmkpi', 'query', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B969E8EFDF614F6FE053B11FA8C0BFC4', '/pmkpi/setting/case/list', '新增', 1, 1, 'searchicon', 'model.add', null, '新增', 'pmkpi', 'add', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B343577999758wr3B11FA8C0810C6322', '/pmkpi/setting/case/list', '删除', 1, 3, 'searchicon', 'model.del', null, '删除', 'pmkpi', 'del', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B9779997589DB418E053B11FA8C0810C', '/pmkpi/setting/case/list', '修改', 1, 2, 'searchicon', 'model.update', null, '修改', 'pmkpi', 'update', null, '{}');


--案例编辑
DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/setting/caseinfo/edit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B969E8EFDF5F4F6FE053B11FA8C0BFC4', 'pmkpi', '/pmkpi/setting/caseinfo/edit', '基本信息', 'editform', 1, 1, 'choosed', 'modelindex.clickTabpage', null, '基本信息', null, null, '{}', null, '0', 'editform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B969E8EFDF604F6FE053B11FA8C0BFC4', 'pmkpi', '/pmkpi/setting/caseinfo/edit', '绩效目标', 'goaleditform', 1, 2, 'nomal', 'modelindex.clickTabpage', null, '绩效目标', null, null, '{}', null, '0', 'goaleditform', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B97799975895B418E053B11FA8C0810C', 'pmkpi', '/pmkpi/setting/caseinfo/edit', '绩效指标', 'indexdatatable', 1, 3, 'nomal', 'modelindex.clickTabpage', null, '绩效指标', null, null, '{}', null, '0', 'indexdatatable', null, null, null, null, null, null);


DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/setting/caseinfo/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('B97799975896B418E053B11FA8C0810C', '/pmkpi/setting/caseinfo/index', 'PERF_T_CASEMODELINDEX', 0, 0, 0, null, null, 'pmkpi', '{}');



DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/setting/caseinfo/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97799975897B418E053B11FA8C0810C', '/pmkpi/setting/caseinfo/index', 'COMPUTESIGN', '计算符号', 4, 1, 1, null, null, null, null, null, '#name', null, null, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97799975898B418E053B11FA8C0810C', '/pmkpi/setting/caseinfo/index', 'FINDEX', '一级指标', 1, 1, 1, null, null, 1, null, null, '#name', null, null, null, 1, 'tree', '{filtersql:" isleaf = 0"}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B97799975899B418E053B11FA8C0810C', '/pmkpi/setting/caseinfo/index', 'INDEXVALUE', '指标值', 5, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9779997589AB418E053B11FA8C0810C', '/pmkpi/setting/caseinfo/index', 'METERUNIT', '计量单位', 6, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9779997589BB418E053B11FA8C0810C', '/pmkpi/setting/caseinfo/index', 'NAME', '三级指标名称', 3, 1, 1, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B9779997589CB418E053B11FA8C0810C', '/pmkpi/setting/caseinfo/index', 'SINDEX', '二级指标', 2, 1, 1, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{filtersql:"  guid in (select guid from v_perf_t_frame k where k.superid = \''#findex\'')"}', null);



DELETE FROM P#busfw_t_uieditform t where t.key='/pmkpi/setting/caseinfo/goal';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B969E8EFDF5B4F6FE053B11FA8C0BFC4', '/pmkpi/setting/caseinfo/goal', 'V_PERF_T_CASEMODELGOAL', 's', '主键', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B969E8EFDF5C4F6FE053B11FA8C0BFC4', '/pmkpi/setting/caseinfo/goal', 'V_PERF_T_CASEMODELGOAL', 'textarea', '年度目标', 'NDGOAL', 1, null, 0, null, 3, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('2369E8EFDF5C4F6FE053B11FA8354232', '/pmkpi/setting/caseinfo/goal', 'V_PERF_T_CASEMODELGOAL', 'textarea', '中期目标', 'ZQGOAL', 1, null, 0, null, 2, 3, '2', 'pmkpi', 1, null, '{}', null, null, null);



DELETE FROM P#busfw_t_uieditform t where t.key='/pmkpi/setting/caseinfo/edit';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B969DB44CDFB4DE5E053B11FA8C06234', '/pmkpi/setting/caseinfo/edit', 'V_PERF_T_CASE', 's', '名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B969DB44CDFD4DE5E053B11FA8C06234', '/pmkpi/setting/caseinfo/edit', 'V_PERF_T_CASE', 's', '编号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B969DB44CDFE4DE5E053B11FA8C06234', '/pmkpi/setting/caseinfo/edit', 'V_PERF_T_CASE', 's', '主键', 'GUID', 0, null, 0, null, 5, null, null, 'pmkpi', 0, null, '{}', null, null, null);


DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/setting/caseinfo/edit';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B969E8EFDF5D4F6FE053B11FA8C0BFC4', '/pmkpi/setting/caseinfo/edit', '保存', 1, 1, 'Keepicon', 'modelindex.infosave', null, '保存', 'pmkpi', null, null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B969E8EFDF5E4F6FE053B11FA8C0BFC4', '/pmkpi/setting/caseinfo/edit', '取消', 1, 2, 'Nofinishicon', 'modelindex.close', null, '取消', 'pmkpi', null, null, null);
