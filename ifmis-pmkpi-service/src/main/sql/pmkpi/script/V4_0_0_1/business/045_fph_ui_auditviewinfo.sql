begin


delete from p#busfw_t_uitable t where t.key in('/pmkpi/auditviewinfo/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('F31EFF85FA5747DE8FBD4C6BD4158D32', '/pmkpi/auditviewinfo/index', 'PERF_T_CUSTOMAUDITVIEW', 0, 0, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/auditviewinfo/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('402F15D457F14EE1B28DB9852EFA03EB', '/pmkpi/auditviewinfo/index', 'CODE', '视图名称', 1, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EE5FEBACE2384E0489BC1979FC6D6BE7', '/pmkpi/auditviewinfo/index', 'NAME', '中文名称', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

delete from p#busfw_t_uifunction t where key in('/pmkpi/auditviewinfo/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2F49EE7E35F4761901ED7FB29C324A9', '/pmkpi/auditviewinfo/index', '编辑', 1, 2, 'searchicon', 'auditviewinfo.edittable', null, '编辑', 'pmkpi', 'edittable', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DDD95CF178D043E1B8B115AFFD48F13A', '/pmkpi/auditviewinfo/index', '删除', 1, 3, 'searchicon', 'auditviewinfo.deletable', null, '删除', 'pmkpi', 'deletable', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3A77F53A0D6042429D07F736D73281FB', '/pmkpi/auditviewinfo/index', '自定义审核视图登记', 1, 1, 'searchicon', 'auditviewinfo.addtable', null, '自定义审核视图', 'pmkpi', 'addtable', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('09BD5E9C8D394865B9AE712036C1C788', '/pmkpi/auditviewinfo/index', '查询', 1, 4, 'searchicon', 'auditviewinfo.tablequery', null, '查询', 'pmkpi', 'tablequery', null, '{}');

delete from p#busfw_t_uiqueryform t where key in('/pmkpi/auditviewinfo/index');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('0C7D6212C29146CF8C4A0FCF20EBEE7A', '/pmkpi/auditviewinfo/index', 'NAME', '中文名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_CUSTOMAUDITVIEW', null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('957C029BCA4E4B35AA37ECCCE180F668', '/pmkpi/auditviewinfo/index', 'CODE', '视图名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_T_CUSTOMAUDITVIEW', null, null);

delete from p#busfw_t_uieditform t where key in('/pmkpi/editaudiview/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4dd3c92e0e824909b2ac4292aa7856fb', '/pmkpi/editaudiview/edit', 'PERF_T_CUSTOMAUDITVIEW', 's', '视图名称', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('fc48147e7fbb45bea0de8327f96ab314', '/pmkpi/editaudiview/edit', 'PERF_T_CUSTOMAUDITVIEW', 's', '视图中文名', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('377bff3bb78548368c7a3f1123bf6e52', '/pmkpi/editaudiview/edit', 'PERF_T_CUSTOMAUDITVIEW', 'textarea', 'SQL', 'CHECKSQL', 1, null, 1, null, 3, 10, '10', 'pmkpi', 1, null, '{}', null, null, null);




delete from p#busfw_t_uitable t where t.key in('/pmkpi/auditdefine/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('a1a4f4e43e976b7b6e3e24cdab077520', '/pmkpi/auditdefine/index', 'PERF_T_AUDITDEFINE', 0, 0, 0, null, null, 'pmkpi', '{}');


delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/auditdefine/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2179ce8073e0a1676643edfce6972925', '/pmkpi/auditdefine/index', 'CODE', '审核序号', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('35b9a440cb4d0d70dc7c49c4f320b84c', '/pmkpi/auditdefine/index', 'GUID', '主键', 1, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7acfafcd1a79d929d48b1880c071787f', '/pmkpi/auditdefine/index', 'NAME', '审核名称', 3, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);




delete from p#busfw_t_uifunction t where key in('/pmkpi/auditdefine/index');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('e20512fb56a92f8e271b58b2fc62bdf0', '/pmkpi/auditdefine/index', '删除', 1, 3, 'searchicon', 'auditdefine.del', null, '删除', 'pmkpi', 'del', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('86a186aa344f433c86053a38951e41ba', '/pmkpi/auditdefine/index', '修改', 1, 2, 'searchicon', 'auditdefine.toEdit', null, '修改', 'pmkpi', 'edit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('507c776463188a016835d348f0ec89d5', '/pmkpi/auditdefine/index', '新增', 1, 1, 'searchicon', 'auditdefine.toAdd', null, '新增', 'pmkpi', 'infosave', null, '{}');


delete from p#busfw_t_uitabpage t where key in('/pmkpi/auditdefine/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0098b1df431fa8c72f38ec6299671263', 'pmkpi', '/pmkpi/auditdefine/index', '存储过程', 'procedure', 1, 1, 'choosed', 'auditdefine.clickTabpage', null, '存储过程', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('ca4d2e25471faa662a2979c0edbc4236', 'pmkpi', '/pmkpi/auditdefine/index', 'beanid', 'auditbeanid', 1, 2, 'nomal', 'auditdefine.clickTabpage', null, 'beanid', null, null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('b22b3baf4eca3edf40b99d3271373681', 'pmkpi', '/pmkpi/auditdefine/index', '视图', 'singletable', 1, 3, 'nomal', 'auditdefine.clickTabpage', null, '视图', null, null, '{}', null, '0', null, null, null, null, null, null, null);



delete from p#busfw_t_uieditform t where key in('/pmkpi/auditdefine/edit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('5d8d46989d61284a4b47acf8a6a6012d', '/pmkpi/auditdefine/edit', 'PERF_T_AUDITDEFINE', 's', '主键', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('df60aee34bee62141c5f3b19f5b6f0ea', '/pmkpi/auditdefine/edit', 'PERF_T_AUDITDEFINE', 'boolean', '是否启用', 'STATUS', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('ea7946f61a2a657ef8cf98f361ae4039', '/pmkpi/auditdefine/edit', 'PERF_T_AUDITDEFINE', 's', '审核名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('96c91e247828adf11c57c4adcdf556e1', '/pmkpi/auditdefine/edit', 'PERF_T_AUDITDEFINE', 's', '审核序号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('66c2634e9a964c882d65eaa5b9052cd9', '/pmkpi/auditdefine/edit', 'PERF_T_AUDITDEFINE', 'boolean', '是否全表校验', 'ISALLTABLE', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('d744a5e66517709d9c6b8c31c898c1fb', '/pmkpi/auditdefine/edit', 'PERF_T_AUDITDEFINE', 'boolean', '有数据不通过', 'RECORDADOPT', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D3E1BB803FC341538EED2C28BE71054E', '/pmkpi/auditdefine/edit', 'PERF_T_AUDITDEFINE', 's', '存储过程', 'PROCEDURE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);


delete from p#busfw_t_uieditform t where key in('/pmkpi/auditdefine/editbeanid');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('ea9471018d84051fb19161549f6797ba', '/pmkpi/auditdefine/editbeanid', 'PERF_T_AUDITDEFINE', 's', 'beanid', 'PROCEDURE', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('10210e0e66d569bc936b27d523b636fe', '/pmkpi/auditdefine/editbeanid', 'PERF_T_AUDITDEFINE', 'boolean', '有数据不通过', 'RECORDADOPT', 1, null, 0, null, 6, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('351a661977e3ef3b145fb04f21c163ed', '/pmkpi/auditdefine/editbeanid', 'PERF_T_AUDITDEFINE', 'boolean', '是否全表校验', 'ISALLTABLE', 1, null, 0, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('fe6254a151b1bffe7ad5b7f486215d25', '/pmkpi/auditdefine/editbeanid', 'PERF_T_AUDITDEFINE', 's', '审核序号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('51d4d206d388c06119a8016798d5a96f', '/pmkpi/auditdefine/editbeanid', 'PERF_T_AUDITDEFINE', 's', '审核名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('26953765796b8601d5be3c4d1ae82d79', '/pmkpi/auditdefine/editbeanid', 'PERF_T_AUDITDEFINE', 'boolean', '是否启用', 'STATUS', 1, null, 0, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0371314d989912cb4d0586a35febef3f', '/pmkpi/auditdefine/editbeanid', 'PERF_T_AUDITDEFINE', 's', '主键', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null);


delete from p#busfw_t_uieditform t where key in('/pmkpi/auditdefine/viewedit');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('dbc0cfabbafb204c9cea13d7ca344346', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 's', '审核名称', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1f987332225cabae622d7dda4519cf8e', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 's', '审核序号', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4ce5371cd4c0c6316b205085b90b5732', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 'boolean', '是否启用', 'STATUS', 1, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('64138c84fc5adbf4bf8246be94022908', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 'boolean', '是否全表校验', 'ISALLTABLE', 1, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('c4e010c5723976bba03fbc8e6bdf0727', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 'boolean', '有数据不通过', 'RECORDADOPT', 1, null, 1, null, 5, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('808c4c53fae1eac2ab5ffa4a57a67755', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 'tree', '选择报表', 'VIEWGUID', 1, null, 1, null, 6, null, null, 'pmkpi', 1, null, '{format:''#code-#name''}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('1ac9d803b9a32643cf84db280fac7c95', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 'textarea', '组成sql', 'AUDITSQL', 1, null, 1, null, 7, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('719e77bdf7dd2c3cb7edee477a648136', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 'boolean', '按审核说明提示错误信息', 'REMARK', 1, null, 1, null, 8, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('e118e7e3b824708b366845e2dcec754d', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 'textarea', '审核说明', 'EXPLAIN', 1, null, 1, null, 9, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('995e2442161574181a14da97578f6049', '/pmkpi/auditdefine/viewedit', 'PERF_T_AUDITDEFINE', 's', '主键', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 1, null, '{}', null, null, null);



delete from p#busfw_t_uifunction t where key in('/pmkpi/auditdefine/edit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('b99109667b4c8e4e2e3505e93ba84214', '/pmkpi/auditdefine/edit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('31872a115e148695c14d87425f96fc89', '/pmkpi/auditdefine/edit', '保存', 1, 1, 'Keepicon', 'editdefine.infosave', null, '保存', 'pmkpi', 'infosave', null, null);


delete from p#busfw_t_uifunction t where key in('/pmkpi/auditdefine/viewedit');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0a7ba01eb99e1b69cabca7edd43d9df5', '/pmkpi/auditdefine/viewedit', '保存', 1, 1, 'Keepicon', 'editdefine.infosave', null, '保存', 'pmkpi', 'infosave', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('f9f5fe23fe845d3a12798e390963d406', '/pmkpi/auditdefine/viewedit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);



delete from p#busfw_t_uifunction t where key in('/pmkpi/auditdefine/editbeanid');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0a7ba01eb99e1b69cabca7edd43d9df5', '/pmkpi/auditdefine/editbeanid', '保存', 1, 1, 'Keepicon', 'editdefine.infosave', null, '保存', 'pmkpi', 'infosave', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('5D0A426468D94E319E96F92169B34546', '/pmkpi/auditdefine/editbeanid', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);


delete from P#busfw_t_Uifunction t where t.key in('/pmkpi/editaudiview/edit');
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('949aa0ecbc0d4cc2afd9958a4a26c839', '/pmkpi/editaudiview/edit', 'SQL校验', 1, 1, 'searchicon', 'editaudiview.checksql', null, 'SQL校验', 'pmkpi', 'checksql', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('227aaaf078094b93905d295d6e72585c', '/pmkpi/editaudiview/edit', '视图登记', 1, 2, 'keepicon', 'editaudiview.save', null, '视图登记', 'pmkpi', 'save', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('63c6f408201841e5b80c0edeec1fe248', '/pmkpi/editaudiview/edit', '取消', 1, 3, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'closeModalWindow', null, null);
