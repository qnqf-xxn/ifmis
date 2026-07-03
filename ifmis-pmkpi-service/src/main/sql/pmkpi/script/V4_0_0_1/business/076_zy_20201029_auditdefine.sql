begin

delete from p#busfw_t_uitable where key = '/pmkpi/auditviewinfo/index';

insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('F31EFF85FA5747DE8FBD4C6BD4158D32', '/pmkpi/auditviewinfo/index', 'PERF_T_CUSTOMAUDITVIEW', 0, 0, 0, null, null, 'pmkpi', '{}');

delete from p#busfw_t_uiqueryform where key = '/pmkpi/auditviewinfo/index';

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('0C7D6212C29146CF8C4A0FCF20EBEE7A', '/pmkpi/auditviewinfo/index', 'NAME', '中文名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_CUSTOMAUDITVIEW', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('957C029BCA4E4B35AA37ECCCE180F668', '/pmkpi/auditviewinfo/index', 'CODE', '视图名称', 2, 1, 's', null, null, null, 'pmkpi', 'PERF_T_CUSTOMAUDITVIEW', '{}', null);

delete from p#busfw_t_uicolumn where key = '/pmkpi/auditviewinfo/index';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('402F15D457F14EE1B28DB9852EFA03EB', '/pmkpi/auditviewinfo/index', 'CODE', '视图名称', 1, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EE5FEBACE2384E0489BC1979FC6D6BE7', '/pmkpi/auditviewinfo/index', 'NAME', '中文名称', 2, 1, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

delete from p#busfw_t_uifunction where key = '/pmkpi/auditviewinfo/index';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D2F49EE7E35F4761901ED7FB29C324A9', '/pmkpi/auditviewinfo/index', '编辑', 1, 2, 'searchicon', 'auditviewinfo.edittable', null, '编辑', 'pmkpi', 'edittable', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DDD95CF178D043E1B8B115AFFD48F13A', '/pmkpi/auditviewinfo/index', '删除', 1, 3, 'searchicon', 'auditviewinfo.deletable', null, '删除', 'pmkpi', 'deletable', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3A77F53A0D6042429D07F736D73281FB', '/pmkpi/auditviewinfo/index', '自定义审核视图登记', 1, 1, 'searchicon', 'auditviewinfo.addtable', null, '自定义审核视图', 'pmkpi', 'addtable', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('09BD5E9C8D394865B9AE712036C1C788', '/pmkpi/auditviewinfo/index', '查询', 1, 4, 'searchicon', 'auditviewinfo.tablequery', null, '查询', 'pmkpi', 'tablequery', null, '{}');


delete from p#busfw_t_uieditform where key = '/pmkpi/editaudiview/edit';

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('377bff3bb78548368c7a3f1123bf6e52', '/pmkpi/editaudiview/edit', 'PERF_T_CUSTOMAUDITVIEW', 'textarea', 'SQL', 'CHECKSQL', 1, null, 1, null, 3, 10, '10', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4dd3c92e0e824909b2ac4292aa7856fb', '/pmkpi/editaudiview/edit', 'PERF_T_CUSTOMAUDITVIEW', 's', '视图名称', 'CODE', 1, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('fc48147e7fbb45bea0de8327f96ab314', '/pmkpi/editaudiview/edit', 'PERF_T_CUSTOMAUDITVIEW', 's', '视图中文名', 'NAME', 1, null, 1, null, 2, null, null, 'pmkpi', 1, null, '{}', null, null, null);

delete from p#busfw_t_uifunction where key = '/pmkpi/editaudiview/edit';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('949aa0ecbc0d4cc2afd9958a4a26c839', '/pmkpi/editaudiview/edit', 'SQL校验', 1, 1, 'searchicon', 'editaudiview.checksql', null, 'SQL校验', 'pmkpi', 'checksql', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('227aaaf078094b93905d295d6e72585c', '/pmkpi/editaudiview/edit', '视图登记', 1, 2, 'keepicon', 'editaudiview.save', null, '视图登记', 'pmkpi', 'save', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('63c6f408201841e5b80c0edeec1fe248', '/pmkpi/editaudiview/edit', '取消', 1, 3, 'searchicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', 'closeModalWindow', null, '{}');
