begin
  
DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/perfselftaskmanage/index';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PC35BB0146F547D68E5E29944F3F2307', '/pmkpi/perfselftaskmanage/index', 'NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PCD4B1B44851481F86DC693B6CB55A96', '/pmkpi/perfselftaskmanage/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PCD4B1B44851481F86DC693B6CB55A98', '/pmkpi/perfselftaskmanage/index', 'C1', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PCD4B1B44851481F86DC693B6CB55A99', '/pmkpi/perfselftaskmanage/index', 'C2', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/perfself/apply/index';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A94', '/pmkpi/perfself/apply/index', 'NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A95', '/pmkpi/perfself/apply/index', 'WFSTATUS', '审核状态', 2, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A96', '/pmkpi/perfself/apply/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A97', '/pmkpi/perfself/apply/index', 'BUSTYPE', '项目类型', 4, 0, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A98', '/pmkpi/perfself/apply/index', 'C1', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('P2D4B1B44851481F86DC693B6CB55A99', '/pmkpi/perfself/apply/index', 'C2', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);


DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/perfselftaskmanage/index';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PC35BB0146F547D68E5E29944F3F2307', '/pmkpi/perfselftaskmanage/index', 'NAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PCD4B1B44851481F86DC693B6CB55A96', '/pmkpi/perfselftaskmanage/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PCD4B1B44851481F86DC693B6CB55A98', '/pmkpi/perfselftaskmanage/index', 'C1', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('PCD4B1B44851481F86DC693B6CB55A99', '/pmkpi/perfselftaskmanage/index', 'C2', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', null, null);

