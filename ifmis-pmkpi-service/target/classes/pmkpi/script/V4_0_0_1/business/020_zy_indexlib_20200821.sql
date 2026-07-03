begin

delete from p#busfw_t_uifunction t where key in('/pmkpi/index/list');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('652B4041CD614A19B06B9F767FBC682D', '/pmkpi/index/list', '新增', 1, 1, 'searchicon', 'indexlib.add', null, '新增', 'pmkpi', 'add', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('CB679DBAAD9647A69D7F8058BD41C3BC', '/pmkpi/index/list', '修改', 1, 2, 'searchicon', 'indexlib.mod', null, '修改', 'pmkpi', 'mod', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9B49BF0A4705442AA9C0EC120D29F491', '/pmkpi/index/list', '删除', 1, 3, 'searchicon', 'indexlib.del', null, '删除', 'pmkpi', 'del', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('43730E30064D42329D047E4EE5C85D24', '/pmkpi/index/list', '查询', 1, 4, 'searchicon', 'indexlib.query', null, '查询', 'pmkpi', 'query', '', '{}');

delete from p#busfw_t_uifunction t where key in('/pmkpi/index/edit');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D06B147095B940A69A93A72D259143A6', '/pmkpi/index/edit', '保存', 1, 1, 'searchicon', 'indexlibedit.save', null, '保存', 'pmkpi', 'save', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9178F3E1FBC7439286B98F3744E49D40', '/pmkpi/index/edit', '取消', 1, 2, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'cancle', '', '{}');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/model/list');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('E2670B56FFB64330980000B6C852B707', '/pmkpi/setting/model/list', 'V_PERF_T_MODEL', 0, 0, 0, '', '', 'pmkpi', '');

delete from p#busfw_t_uiqueryform t where key in('/pmkpi/setting/model/list');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('D1B2EB3660D24D7C89AE580390844B96', '/pmkpi/setting/model/list', 'NAME', '名称', 1, 1, 's', '', null, null, 'pmkpi', 'V_PERF_T_MODEL', '', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/model/list');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('79288A8E5B9E4DF3B2E6584997169F61', '/pmkpi/setting/model/list', 'COL1', '指标操作', 1, 1, 0, 0, '', 0, null, '', '', '', null, 100, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('B8862A3297DF4833882E38E7CF91ECF7', '/pmkpi/setting/model/list', 'DESCRIBE', '模板说明', 4, 1, 1, 0, '', 0, null, '', '', '', null, 300, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2416A60CFE0E4D7C9F92FBF7323DD6C8', '/pmkpi/setting/model/list', 'FRAMESYSTEM', '指标体系', 2, 1, 1, 0, '', 1, null, '', '#name', '', null, 150, 1, 'tree', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('79288A8E5B9E4DF3B2E6584997169F61', '/pmkpi/setting/model/list', 'NAME', '模板名称', 3, 1, 1, 0, '', 1, null, '', '', '', null, 220, 0, 's', '', '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/model/list');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ED23C3B4446A4432B2C2954B845A956E', '/pmkpi/setting/model/list', '保存', 1, 1, 'searchicon', 'model.save', null, '保存', 'pmkpi', 'save', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('41643896FEA1493FAE0FE8579E6C6111', '/pmkpi/setting/model/list', '查询', 1, 4, 'searchicon', 'model.query', null, '查询', 'pmkpi', 'query', '', '{}');

delete from p#busfw_t_uitable t where t.key in('/pmkpi/setting/case/list');

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('298436FADF984E6CA3A4D54406448DC6', '/pmkpi/setting/case/list', 'V_PERF_T_CASE', 0, 0, 0, '', '', 'pmkpi', '');


delete from p#busfw_t_uiqueryform t where key in('/pmkpi/setting/case/list');

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('851120EC0AEA4CE2A92D32277CC77C41', '/pmkpi/setting/case/list', 'NAME', '名称', 1, 1, 's', '', null, null, 'pmkpi', 'V_PERF_T_CASE', '', null);

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/case/list');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C66145895FF74CE48807028E79F469B0', '/pmkpi/setting/case/list', 'COL1', '指标操作', 1, 1, 0, 0, '', 0, null, '', '', '', null, 100, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F97DCE562CC849CBA2C896A3C97459AC', '/pmkpi/setting/case/list', 'DESCRIBE', '模板说明', 4, 1, 1, 0, '', 0, null, '', '', '', null, 300, 0, 's', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7489EC05C5564CBAB7F0FD5E996933DB', '/pmkpi/setting/case/list', 'FRAMESYSTEM', '指标体系', 2, 1, 1, 0, '', 1, null, '', '#name', '', null, 150, 1, 'tree', '', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('6D2711294AD74DB1B5044EE4E782F120', '/pmkpi/setting/case/list', 'NAME', '模板名称', 3, 1, 1, 0, '', 1, null, '', '', '', null, 220, 0, 's', '', '');


delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/case/list');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('78EDFE829FA54DE58BFF06370E5D90CC', '/pmkpi/setting/case/list', '保存', 1, 1, 'searchicon', 'model.save', null, '保存', 'pmkpi', 'save', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('500BC81A39F14DAB98784762BF1D9D4E', '/pmkpi/setting/case/list', '查询', 1, 4, 'searchicon', 'model.query', null, '查询', 'pmkpi', 'query', '', '{}');


delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/model/indexlist');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D665EF4820AE439CB7DD9DDCFEE6D990', '/pmkpi/setting/model/indexlist', 'COMPUTESIGN', '计算符号', 4, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FDB0A1E1C94A46DFBF91B01066EF1948', '/pmkpi/setting/model/indexlist', 'FINDEX', '一级指标', 1, 1, 0, null, '', 1, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4789496C715D403A8AFA216DD0171908', '/pmkpi/setting/model/indexlist', 'METERUNIT', '计量单位', 5, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('56CB2F551A7E4DE8AAFE180848B2ADE0', '/pmkpi/setting/model/indexlist', 'NAME', '三级指标名称', 3, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5E0CD7BAD21D4405852624F85A1D7B07', '/pmkpi/setting/model/indexlist', 'SINDEX', '二级指标', 2, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/model/indexlist');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8BB73B816225409AB4AFF01F3B341B92', '/pmkpi/setting/model/indexlist', '取消', 1, 4, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'close', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('ADEF1EFEAABE481994656F4F04DB4411', '/pmkpi/setting/model/indexlist', '新增', 1, 1, 'searchicon', 'modelindex.add', null, '新增', 'pmkpi', 'add', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F547A453C8A742AE805E6846C3C3446F', '/pmkpi/setting/model/indexlist', '修改', 1, 2, 'searchicon', 'modelindex.mod', null, '修改', 'pmkpi', 'mod', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8BB73B816225409AB4AFF01F3B341B92', '/pmkpi/setting/model/indexlist', '删除', 1, 3, 'searchicon', 'modelindex.del', null, '删除', 'pmkpi', 'del', '', '{}');

delete from p#busfw_t_uieditform t where key in('/pmkpi/setting/model/edit');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1FF75408D51A40CCB2FCF751CB17AE22', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 'tree', '层次分类', 'SINDEX', 1, '', 1, '', 2, 0, '0', 'pmkpi', 1, 0, '{format:''#name''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C9618B1F4DB446E9BE5EC1377A46A468', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '名称', 'NAME', 1, '', 1, '', 1, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('54EE81489CE1489D8C6069A27123E875', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '创建人', 'CREATER', 0, '', 1, '', 11, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('56B00CECBBB946CEBC07D00FECD1DB07', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '创建时间', 'CREATETIME', 0, '', 1, '', 12, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('53CAD4E0D8B64F11AC545E75CB069078', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '状态', 'STATUS', 0, '', 1, '', 13, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C73B2C70BC7243F39DD48842D89839A9', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '单位id', 'AGENCYGUID', 0, '', 1, '', 15, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3979BE84F05640A499415FACDAF6E15A', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '年度', 'YEAR', 0, '', 1, '', 16, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('95127C7E3D05474D8638E8FBBA5158EF', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '区划', 'PROVINCE', 0, '', 1, '', 17, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('67EFA3A549C644D2B5FE7167A3B0B482', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', 'guid', 'GUID', 0, '', 1, '', 20, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1FF75408D51A40CCB2FCF751CB17AE22', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 'tree', '一级指标', 'FINDEX', 0, '', 1, '', 21, 0, '', 'pmkpi', 1, 0, '{format:''#name''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('95127C7E3D05474D8638E8FBBA5158EF', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '计量单位', 'METERUNIT', 1, '', 1, '', 4, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('67EFA3A549C644D2B5FE7167A3B0B482', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 'tree', '计算符号', 'COMPUTESIGN', 1, '', 1, '', 3, null, '', 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1FF75408D51A40CCB2FCF751CB17AE22', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 's', '指标值', 'INDEXVALUE', 0, '', 1, '', 5, 0, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1E00C63FE92446E1A772B54AF2A40610', '/pmkpi/setting/model/edit', 'PERF_T_CASEMODELINDEX', 'i', '排序', 'ORDERNUM', 0, '', 0, '', 0, null, '', 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/model/edit');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('5B74B03C8468461BA9CFBF6D1199A31A', '/pmkpi/setting/model/edit', '保存', 1, 1, 'searchicon', 'modelindexedit.save', null, '保存', 'pmkpi', 'save', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B171DD21D0CA4F7880EA12951605DE70', '/pmkpi/setting/model/edit', '取消', 1, 2, 'searchicon', 'modelindexedit.close', null, '取消', 'pmkpi', 'cancle', '', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/setting/case/indexlist');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('912147D426B34ECCAD1A6A43B0A17FCE', '/pmkpi/setting/case/indexlist', 'COMPUTESIGN', '计算符号', 4, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('9680C07C60D14249A9B38294C53ECF6F', '/pmkpi/setting/case/indexlist', 'FINDEX', '一级指标', 1, 1, 0, null, '', 1, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7968DC8D1E414EC180662FB72CD922C5', '/pmkpi/setting/case/indexlist', 'INDEXVALUE', '指标值', 5, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3148250D6114456F8F0E04693DFD0E47', '/pmkpi/setting/case/indexlist', 'METERUNIT', '计量单位', 6, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8A9BDC9054FB4F5D8491860FC366D08B', '/pmkpi/setting/case/indexlist', 'NAME', '三级指标名称', 3, 1, 0, null, '', null, null, '', '', '', null, null, 0, 's', '{}', '');

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('331FFE004E4C41499363015F4302A90A', '/pmkpi/setting/case/indexlist', 'SINDEX', '二级指标', 2, 1, 0, null, '', null, null, '', '#name', '', null, null, 1, 'tree', '{}', '');

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/case/indexlist');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFD4874AB7EB4FDB83F53CE2DEE8930A', '/pmkpi/setting/case/indexlist', '取消', 1, 4, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'close', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('66D0957BD6BA4DD3BBCA81706213EF71', '/pmkpi/setting/case/indexlist', '新增', 1, 1, 'searchicon', 'modelindex.add', null, '新增', 'pmkpi', 'add', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AD245866D3E149C0A2E87DA25AB59537', '/pmkpi/setting/case/indexlist', '修改', 1, 2, 'searchicon', 'modelindex.mod', null, '修改', 'pmkpi', 'mod', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('62A39B72676F4BAA89F8AF5D39690087', '/pmkpi/setting/case/indexlist', '删除', 1, 3, 'searchicon', 'modelindex.del', null, '删除', 'pmkpi', 'del', '', '{}');

delete from p#busfw_t_uieditform t where key in('/pmkpi/setting/case/edit');

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0571584ED0114A0FB878B8ADC9BDF696', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 'tree', '层次分类', 'SINDEX', 1, '', 1, '', 2, 0, '0', 'pmkpi', 1, 0, '{format:''#name''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('71B86483A6B24AC79E41B1EA43055B43', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '名称', 'NAME', 1, '', 1, '', 1, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6E026123E73D4D8DB6F01B454C88780B', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '创建人', 'CREATER', 0, '', 1, '', 11, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('46858989BE914EEA82191B3DBCBD1D7A', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '创建时间', 'CREATETIME', 0, '', 1, '', 12, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('79B85508BEF740BF90A8C24E4440097E', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '状态', 'STATUS', 0, '', 1, '', 13, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C9B0A1AD9B1B4E949C660D28FED1C882', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '单位id', 'AGENCYGUID', 0, '', 1, '', 15, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('92D228B41C124DDABB6863A7DD59ED88', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '年度', 'YEAR', 0, '', 1, '', 16, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('F2F3728B97574093ACEEEE805DE67521', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '区划', 'PROVINCE', 0, '', 1, '', 17, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('82183B6140ED4F2EB8924F47CCE30838', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', 'guid', 'GUID', 0, '', 1, '', 20, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('9D9ECC8A14514186BF434D2F2D213D7F', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 'tree', '一级指标', 'FINDEX', 0, '', 1, '', 21, 0, '', 'pmkpi', 1, 0, '{format:''#name''}', 0, 1, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6000C7FD8860494ABA276074E03B93E3', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '计量单位', 'METERUNIT', 1, '', 1, '', 4, null, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7083E1D3D46C4F7F958F7C69DB3F205B', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 'tree', '计算符号', 'COMPUTESIGN', 1, '', 1, '', 3, null, '', 'pmkpi', 1, null, '{format:''#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('322EBEF5087D4AD78B4C3ADB4E66A3E7', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 's', '指标值', 'INDEXVALUE', 1, '', 1, '', 5, 0, '', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E2B32620851E48C180FC66D266CBD9F5', '/pmkpi/setting/case/edit', 'PERF_T_CASEMODELINDEX', 'i', '排序', 'ORDERNUM', 0, '', 0, '', 0, null, '', 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/setting/case/edit');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B970BDCC8ADA40F5BA45AA03DDEEADD7', '/pmkpi/setting/case/edit', '保存', 1, 1, 'searchicon', 'modelindexedit.save', null, '保存', 'pmkpi', 'save', '', '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('78A82161ED9F4BB5AE79875237FC69B3', '/pmkpi/setting/case/edit', '取消', 1, 2, 'searchicon', 'modelindexedit.close', null, '取消', 'pmkpi', 'cancle', '', '{}');

