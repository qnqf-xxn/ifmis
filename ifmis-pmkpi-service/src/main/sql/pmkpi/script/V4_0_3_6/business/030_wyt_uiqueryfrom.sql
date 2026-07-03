begin
  --查询区字段注册：添加支出项目类别、一级项目编码字段
delete from p#busfw_t_uiqueryform where key ='/pmkpi/yearprogram/query/list' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', 'PROJECTKIND', '支出项目类别', 13, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', 'PRO_LEVONE_CODE', '一级项目编码', 14, 0, 's', null, null, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/perfselftaskmanage/index' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfselftaskmanage/index', 'PROJECTKIND', '支出项目类别', 6, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_ADJUSTPROJECT_INFO', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfselftaskmanage/index', 'PRO_LEVONE_CODE', '一级项目编码', 7, 0, 's', null, null, null, 'pmkpi', 'V_PERF_ADJUSTPROJECT_INFO', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/perfself/apply/index' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/index', 'PROJECTKIND', '支出项目类别', 10, 0, 'tree', null, 1, null, 'pmkpi', 'PERF_T_SELFEVALTASK', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/index', 'PRO_LEVONE_CODE', '一级项目编码', 11, 0, 's', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/adjust/report/program' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/program', 'PROJECTKIND', '支出项目类别', 4, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_T_ADJUST', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/adjust/report/program', 'PRO_LEVONE_CODE', '一级项目编码', 5, 0, 's', null, null, null, 'pmkpi', 'V_PERF_T_ADJUST', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/midprogram/report/list' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'PROJECTKIND', '支出项目类别', 3, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/list', 'PRO_LEVONE_CODE', '一级项目编码', 4, 0, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/midprogram/query/list' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'PROJECTKIND', '支出项目类别', 5, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/query/list', 'PRO_LEVONE_CODE', '一级项目编码', 6, 0, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/midprogram/report/audit' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'PROJECTKIND', '支出项目类别', 5, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/midprogram/report/audit', 'PRO_LEVONE_CODE', '一级项目编码', 6, 0, 's', null, null, null, 'pmkpi', 'V_PERF_T_DEPTPERFMIDDECLARE', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/keytask/send' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/keytask/send', 'PROJECTKIND', '支出项目类别', 3, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/keytask/send', 'PRO_LEVONE_CODE', '一级项目编码', 4, 0, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/manage/prolist' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PROJECTKIND', '支出项目类别', 7, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolist', 'PRO_LEVONE_CODE', '一级项目编码', 8, 0, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/manage/prolistimp' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PROJECTKIND', '支出项目类别', 7, 0, 'tree', null, 1, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/manage/prolistimp', 'PRO_LEVONE_CODE', '一级项目编码', 8, 0, 's', null, null, null, 'pmkpi', 'V_PERF_TRACEPROJECT_INFO', '{}', null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/report' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'PROJECTKIND', '支出项目类别', 4, 0, 'tree', null, 1, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report', 'PRO_LEVONE_CODE', '一级项目编码', 5, 0, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null,  null, null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/program/trace/query' and COLUMNCODE in ('PROJECTKIND','PRO_LEVONE_CODE');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'PROJECTKIND', '支出项目类别', 3, 0, 'tree', null, 1, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null,  null, null, null);
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/query', 'PRO_LEVONE_CODE', '一级项目编码', 4, 0, 's', null, null, null, 'pmkpi', 'PERF_V_PROMONITOR', null, null,  null, null, null);

