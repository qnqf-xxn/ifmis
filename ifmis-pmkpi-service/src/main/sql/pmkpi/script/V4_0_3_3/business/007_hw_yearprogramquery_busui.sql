begin

delete from bus_t_diccolumn where tablecode = 'V_PERF_PROJECT_YEAR' and columncode = 'PRO_CAT_CODE';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, 'VD09001', null, '0', 'PRO_CAT_CODE', '1', null, null, 'D0419BBF19CF23B8E0533315A8C0FC8D', 'PRO_CAT_CODE', 'V_PERF_PROJECT_YEAR', '项目类别', 'S', '2', null, 1, 1, null, sysdate);

delete from p#busfw_t_uiqueryform where key = '/pmkpi/yearprogram/query/list' and columncode = 'PRO_CAT_CODE';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', 'PRO_CAT_CODE', '项目分类', 5, 1, 'tree', null, 1, null, 'pmkpi', 'V_PERF_PROJECT_YEAR', '{}', null, null, null, null);

delete from busfw_t_uicolumn where key = '/pmkpi/yearprogram/query/list' and columncode = 'PRO_CAT_CODE';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/yearprogram/query/list', 'PRO_CAT_CODE', '项目类别', 11, 1, 0, null, null, null, 1, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null, null, null);
