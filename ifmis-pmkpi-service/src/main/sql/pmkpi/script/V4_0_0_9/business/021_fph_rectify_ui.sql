begin
  
--整改通知首页
DELETE FROM p#busfw_t_Uitable t WHERE t.key='/pmkpi/rectification/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C01E4E4F958F8E89C88C952F2BEC3A76', '/pmkpi/rectification/index', 'V_PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);

DELETE FROM p#busfw_t_Uicolumn t WHERE t.key='/pmkpi/rectification/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C67A29A8DEF825099A993A954FAB70F2', '/pmkpi/rectification/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('43C30730507A80BA8951D3FDCB75084C', '/pmkpi/rectification/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4BC2437E865515C9A5A5DFE22810C33C', '/pmkpi/rectification/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D50DDEE9F21BC289B6AF26C06FA3F5B2', '/pmkpi/rectification/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F95B1E78550BBA0BCAB3261C12622460', '/pmkpi/rectification/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C0F702981887DEF3994631B81AD8542', '/pmkpi/rectification/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

DELETE FROM p#busfw_t_Uifunction t WHERE t.key='/pmkpi/rectification/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6D43FAB5B8EAD7D4008D152B3B4C16F0', '/pmkpi/rectification/index', '下达', 1, 5, 'addaction', 'rectification.wfAudit', null, '下达', 'pmkpi', 'sendaudit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2D71A6F8F230CD0BCCCAD4F6DF6474DB', '/pmkpi/rectification/index', '选择项目', 1, 2, 'addaction', 'rectification.addproj', null, '选择项目', 'pmkpi', 'addproj', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('700120DEBB6A19869F4F5070A1AB84AC', '/pmkpi/rectification/index', '查询', 0, 1, 'addaction', 'rectification.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('FDDD969089A259056C6186B964B64BBF', '/pmkpi/rectification/index', '审核情况', 0, 8, 'addaction', 'rectification.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('6DDDFA005297265798DD72C6A316298A', '/pmkpi/rectification/index', '送审', 0, 5, 'addaction', 'rectification.send', null, '送审', 'pmkpi', 'send', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('479F03EFCC39C1024D2C3342CFA2DD56', '/pmkpi/rectification/index', '起草/修改', 0, 3, 'addaction', 'rectification.edit', null, '起草/修改', 'pmkpi', 'edit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('498EC1C7F15A05FF739AF997C5BD646F', '/pmkpi/rectification/index', '删除', 1, 4, 'addaction', 'rectification.del', null, '删除', 'pmkpi', 'del', null, null);

DELETE FROM p#busfw_t_Uiqueryform t WHERE t.key='/pmkpi/rectification/index';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('15EAD9822CB5B1EEF0DFA0A9DEADAB0E', '/pmkpi/rectification/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);

DELETE FROM p#busfw_t_Uitabpage t WHERE t.key='/pmkpi/rectification/index';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6C0FFE236BBB497009F7FEEAEFB1FC68', 'pmkpi', '/pmkpi/rectification/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', '', '选择项目,删除,起草/修改,下达', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D3B88EFE90560B0E6E2E5E185E68BA02', 'pmkpi', '/pmkpi/rectification/index', '未送审', 'waitaudit', 1, 1, 'choosed', 'rectification.clickTabpage', 0, '显示未处理', '', null, '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1AA395D7674CFE0CD1D394DD7A6BAFD4', 'pmkpi', '/pmkpi/rectification/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'rectification.clickTabpage', 0, '显示已处理', null, '选择项目,删除,起草/修改,下达', '{}', null, '0', null, null, null, null, null, null, null);


--选择项目
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/rectification/add/proj';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('265BD352DC9C401E2B63D2CCC36ED7EF', '/pmkpi/rectification/add/proj', 'V_PERF_PROJECT_INFO', 20, 0, null, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/rectification/add/proj';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F876728735BB23BC7C910D8FC31D696B', '/pmkpi/rectification/add/proj', 'DEPT_CODE', '部门', 9, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F2559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'MOF_DEP_CODE', '业务处室', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F5559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'EXP_FUNC_CODE', '功能分类', 6, 0, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F7559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'GUID', '项目id', 7, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F8559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_CODE', '项目编码', 2, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F9559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_NAME', '项目名称', 3, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F3559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/rectification/add/proj';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DD62A20F25AE345CA743AB2C214EA179', '/pmkpi/rectification/add/proj', '查询', 0, 1, 'addaction', 'rectificationadd.query', null, '查询', 'pmkpi', '查询', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('83471FF7D88768373224E9AD6F021DC5', '/pmkpi/rectification/add/proj', '确定', 1, 2, 'addaction', 'rectificationadd.add', null, '确定', 'pmkpi', '确定', null, null);

DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/rectification/add/proj';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('89A225809BBEA6C37274CD7A8AAC3932', '/pmkpi/rectification/add/proj', 'PRO_NAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_PROJECT_INFO', null, null);

--选择项目（部门）
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/rectification/add/deptproj';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD4E9B88DEF57473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'V_PERF_T_DEPTPERFDECLARE', 20, 0, null, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/rectification/add/deptproj';
insert into P#busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF67473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'CREATETIME', '创建人', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into P#busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF77473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 6, null, null, null, null, null, 0, 's', null, null);

insert into P#busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF87473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'LINKMAN', '联系人', 4, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into P#busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF97473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'NAME', '名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', null, null);

insert into P#busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFA7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'TELEPHONE', '联系电话', 5, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

insert into P#busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFB7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/rectification/add/deptproj';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD4E9B88DEFC7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', '查询', 0, 1, 'addaction', 'rectificationadd.query', null, '查询', 'pmkpi', '查询', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD4E9B88DEFD7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', '确定', 1, 2, 'addaction', 'rectificationadd.add', null, '确定', 'pmkpi', '确定', null, null);

DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/rectification/add/deptproj';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFE7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'NAME', '名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'V_PERF_T_DEPTPERFDECLARE', null, null);

--整改通知附件
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/rectification/noticeandfile';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD19AA0879E20A55E053B11FA8C0A366', '/pmkpi/rectification/noticeandfile', 'V_PERF_FILE', 0, 1, 0, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/rectification/noticeandfile';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD19AA0879E30A55E053B11FA8C0A366', '/pmkpi/rectification/noticeandfile', 'FILENAME', '附件名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD19AA0879E40A55E053B11FA8C0A366', '/pmkpi/rectification/noticeandfile', 'CREATERNAME', '上传人', 3, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD19AA0879E50A55E053B11FA8C0A366', '/pmkpi/rectification/noticeandfile', 'CREATE_TIME', '上传时间', 4, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD19AA0879E60A55E053B11FA8C0A366', '/pmkpi/rectification/noticeandfile', 'MANAGE', '操作', 5, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/rectification/noticeandfile';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879E70A55E053B11FA8C0A366', '/pmkpi/rectification/noticeandfile', 'V_PERF_T_RECTIFY', 'textarea', '整改内容', 'RECTIFYDESC', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879E80A55E053B11FA8C0A366', '/pmkpi/rectification/noticeandfile', 'V_PERF_T_RECTIFY', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/rectification/noticeandfile';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/noticeandfile', '保存', 1, 1, null, 'pmkpinoticeandfile.save', null, '保存', 'pmkpi', 'save', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BA521F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/noticeandfile', '上传文件', 1, 2, null, 'pmkpinoticeandfile.addFile', null, '上传文件', 'pmkpi', 'addFile', null, '{}');


--整改通知详情
DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/rectification/add/rectification';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('3406E30AC80C31999CB1D47D960CE375', '/pmkpi/rectification/add/rectification', 'PERF_T_RECTIFY', 's', '整改标题', 'RECTIFYTITLE', 0, null, 1, null, 1, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('DFEE87D171053E8583E7EEFE60E0591E', '/pmkpi/rectification/add/rectification', 'PERF_T_RECTIFY', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);

--整改通知新增(项目)
DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/rectification/program/add';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C41829802E023DE6FA95330E4525637A', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知详情', 'rectification', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知详情', null, null, '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('25CCFA09C578C553CB3C77D945891EBD', 'pmkpi', '/pmkpi/rectification/program/add', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{url:''/pmkpi/rectification/program/proinfo.page''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD19AA0879E10A55E053B11FA8C0A366', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知附件', 'file', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知附件', null, null, '{url:''/pmkpi/rectification/noticeandfile.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);


--整改通知新增(部门)
DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/rectification/dept/add';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016D4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知详情', 'rectification', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知详情', null, null, '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016C4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{url:''/pmkpi/rectification/program/deptinfo.page''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016B4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知附件', 'file', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知附件', null, null, '{url:''/pmkpi/rectification/noticeandfile.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);


--整改通知审核
DELETE FROM P#busfw_t_Uitable t WHERE t.key='/pmkpi/rectification/audit/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('30CA317C24BAF4E04E412C2CEC47E6E2', '/pmkpi/rectification/audit/index', 'PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t WHERE t.key='/pmkpi/rectification/audit/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8A16B0A09DF13715DF86E37F824A7E79', '/pmkpi/rectification/audit/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E10423C94B42A2792AE6B4C3AF344000', '/pmkpi/rectification/audit/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('5B36CEE8EA59C627DA73142459EDD6D0', '/pmkpi/rectification/audit/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('02C9CEB209A56DBB6F23020F00BAB8D0', '/pmkpi/rectification/audit/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CB7DA35CB33E61E1E282E185101ABA17', '/pmkpi/rectification/audit/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('062A801A0F5FBBA38C758F1C35463FF1', '/pmkpi/rectification/audit/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

DELETE FROM P#busfw_t_Uiqueryform t WHERE t.key='/pmkpi/rectification/audit/index';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('3503799C28CF696469356D969CD15557', '/pmkpi/rectification/audit/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);

DELETE FROM P#busfw_t_Uifunction t WHERE t.key='/pmkpi/rectification/audit/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('95E751B0D548BFAF4D020E0708275B4A', '/pmkpi/rectification/audit/index', '下发', 1, 2, 'addaction', 'rectificationaudit.send', null, '下发', 'pmkpi', 'audit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('DE24FB043565247602D4F8496CC3A094', '/pmkpi/rectification/audit/index', '审核情况', 1, 4, 'addaction', 'rectificationaudit.queryaudit', null, '审核情况', 'pmkpi', 'queryaudit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('40349437008AE6B5375F270FA5C63919', '/pmkpi/rectification/audit/index', '退回', 1, 3, 'addaction', 'rectificationaudit.back', null, '退回', 'pmkpi', '退回', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('59CE85375EBA016896C69A79221E4170', '/pmkpi/rectification/audit/index', '查询', 0, 1, 'addaction', 'rectificationaudit.query', null, '查询', 'pmkpi', 'query', null, null);

DELETE FROM P#busfw_t_Uitabpage t WHERE t.key='/pmkpi/rectification/audit/index';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BAF217043BF56952789CB44851073CE6', 'pmkpi', '/pmkpi/rectification/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'rectificationaudit.clickTabpage', null, '曾经办', null, '下发,退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1A0D3885BCE074CFD57E0DD729A1B3FC', 'pmkpi', '/pmkpi/rectification/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'rectificationaudit.clickTabpage', null, '已审核', null, '下发,退回', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E0E2E3D020AD1A6262A16EAF27480697', 'pmkpi', '/pmkpi/rectification/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'rectificationaudit.clickTabpage', null, '待审核', null, null, '{}', null, '0', null, null, null, null, null, null, null);


--整改情况反馈
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/rectification/feedback/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('328760ED4A0DC4B19FD35621F78420AC', '/pmkpi/rectification/feedback/index', 'PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/rectification/feedback/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D0C0794B6343D75B96962C7587E60D8D', '/pmkpi/rectification/feedback/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8E1C2F0958C4C99221330B202F3DF414', '/pmkpi/rectification/feedback/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E1FC534E4B98F857528BF74871650105', '/pmkpi/rectification/feedback/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8F89A9961F2CA80877F69B3BD27A996B', '/pmkpi/rectification/feedback/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4FCCD6D23BBC1FC4E25A1C88D47B6B75', '/pmkpi/rectification/feedback/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BF8F02D9D20025216EA340DC0B6E8D55', '/pmkpi/rectification/feedback/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/rectification/feedback/index';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('110765D8743D9B766FC0F20FD15616D0', '/pmkpi/rectification/feedback/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/rectification/feedback/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7DA2987BC09A697B296CADE6E06BE46F', '/pmkpi/rectification/feedback/index', '送审', 1, 5, 'addaction', 'feedback.send', null, '送审', 'pmkpi', 'send', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C9F0C09D631CC75281243CFF29EF2A67', '/pmkpi/rectification/feedback/index', '取消送审', 1, 7, 'addaction', 'feedback.cancel', null, '取消送审', 'pmkpi', 'cancel', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F2C9D38AEED59C57C3D34DA808EED307', '/pmkpi/rectification/feedback/index', '通过', 0, 13, 'addaction', 'feedback.pass', null, '通过', 'pmkpi', 'pass', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7A4B84E7BE5894CAFEFBF921F31DA52C', '/pmkpi/rectification/feedback/index', '填报/修改', 1, 3, 'addaction', 'feedback.add', null, '填报/修改', 'pmkpi', 'add', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('63A977BA3F01E7E85CA73B60A9681F1A', '/pmkpi/rectification/feedback/index', '查询', 0, 1, 'addaction', 'feedback.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0389A1DF24BED016FA76F4458A642B5B', '/pmkpi/rectification/feedback/index', '审核情况', 1, 8, 'addaction', 'feedback.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/rectification/feedback/index';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('26333A6799CF2C38E7F7F1CF604745F4', 'pmkpi', '/pmkpi/rectification/feedback/index', '未送审', 'waitaudit', 1, 1, 'choosed', 'feedback.clickTabpage', null, '待审核', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0DF6CC35CCFE3C543DACA385CD25B26A', 'pmkpi', '/pmkpi/rectification/feedback/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'feedback.clickTabpage', null, '已审核', null, '填报/修改,送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F2CFA4806E89730F9E5CD61E9278C36', 'pmkpi', '/pmkpi/rectification/feedback/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'feedback.clickTabpage', null, '曾经办', null, '填报/修改,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);


--整改反馈附件
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/rectification/feedbackfile';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('BD19AA0879EB0A55E053B11FA8C0A366', '/pmkpi/rectification/feedbackfile', 'V_PERF_FILE', 0, 1, 0, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/rectification/feedbackfile';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A314FEBF3397DE053B11FA8C0E3D4', '/pmkpi/rectification/feedbackfile', 'FILENAME', '附件名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A314FEBF4397DE053B11FA8C0E3D4', '/pmkpi/rectification/feedbackfile', 'CREATERNAME', '上传人', 3, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A314FEBF5397DE053B11FA8C0E3D4', '/pmkpi/rectification/feedbackfile', 'CREATE_TIME', '上传时间', 4, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD2A314FEBF6397DE053B11FA8C0E3D4', '/pmkpi/rectification/feedbackfile', 'MANAGE', '操作', 5, 1, 0, null, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, null, 0, 'd', '{}', null);

DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/rectification/feedbackfile';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879E90A55E053B11FA8C0A366', '/pmkpi/rectification/feedbackfile', 'V_PERF_T_RECTIFY', 'textarea', '整改反馈内容', 'FEEDBACKDESC', 1, null, 1, null, 1, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD19AA0879EA0A55E053B11FA8C0A366', '/pmkpi/rectification/feedbackfile', 'V_PERF_T_RECTIFY', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/rectification/feedbackfile';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2A314FEBF7397DE053B11FA8C0E3D4', '/pmkpi/rectification/feedbackfile', '保存', 1, 1, null, 'pmkpinoticeandfile.save', null, '保存', 'pmkpi', 'save', null, '{}');

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BD2A314FEBF8397DE053B11FA8C0E3D4', '/pmkpi/rectification/feedbackfile', '上传文件', 1, 2, null, 'pmkpinoticeandfile.addFile', null, '上传文件', 'pmkpi', 'addFile', null, '{}');


--反馈信息详情
DELETE FROM P#busfw_t_Uieditform t where t.key='/pmkpi/rectification/feedback/info';
insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('047F4D7CF5AB930CB0D9CF214AB3D947', '/pmkpi/rectification/feedback/info', 'PERF_T_RECTIFY', 's', '整改标题', 'RECTIFYTITLE', 0, null, 1, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('ECEFF5E17010D109DE592219FCA497C0', '/pmkpi/rectification/feedback/info', 'PERF_T_RECTIFY', 's', '主键ID', 'GUID', 0, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null);


--反馈填报（项目）
DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/rectification/program/edit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('25CCFA09C578C553CB3C77D945891EBD', 'pmkpi', '/pmkpi/rectification/program/edit', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{url:''/pmkpi/rectification/program/proinfo.page''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD19AA0879E10A55E053B11FA8C0A366', 'pmkpi', '/pmkpi/rectification/program/edit', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知附件', null, null, '{url:''/pmkpi/rectification/noticeandfile.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B6A93ACFAEEFDFF75CCCBAEC5B3AA467', 'pmkpi', '/pmkpi/rectification/program/edit', '整改反馈附件', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '整改反馈附件', null, '保存', '{url:''/pmkpi/rectification/feedbackfile.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('FF950D27D2E61F4117846BF2F0CE5C49', 'pmkpi', '/pmkpi/rectification/program/edit', '反馈信息详情', 'feedbackInfo', 0, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '反馈信息详情', null, null, '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('87661BD514DC20D8B6C39A0461794B17', 'pmkpi', '/pmkpi/rectification/program/edit', '整改通知详情', 'rectification', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知详情', null, '保存', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);


----反馈填报（部门）
DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/rectification/dept/edit';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016E4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '基本信息', 'proinfo', 1, 1, 'nomal', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{url:''/pmkpi/rectification/program/deptinfo.page''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016F4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知附件', null, null, '{url:''/pmkpi/rectification/noticeandfile.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301704449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改反馈附件', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '整改反馈附件', null, '保存', '{url:''/pmkpi/rectification/feedbackfile.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301714449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '反馈信息详情', 'feedbackInfo', 0, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '反馈信息详情', null, null, '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301724449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改通知详情', 'rectification', 0, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '整改通知详情', null, '保存', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);


--整改反馈审核
DELETE FROM P#busfw_t_Uitable t where t.key='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('71E40A87BD91392E172848F3944CC03B', '/pmkpi/rectification/feedback/audit/index', 'PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);

DELETE FROM P#busfw_t_Uicolumn t where t.key='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E543D68CD1AB715EBBDAA614B324104B', '/pmkpi/rectification/feedback/audit/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0645A2AD66C5EEC0BCF9FA5B2A6618E3', '/pmkpi/rectification/feedback/audit/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F9197D58C35CA88ED51ED47DC7F04D5D', '/pmkpi/rectification/feedback/audit/index', 'FININTORGGUID', '业务科室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C8C91B3D03D0FEF8F15D24F1E743728B', '/pmkpi/rectification/feedback/audit/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3004FAFEAC8A7540C909FB34EBB11017', '/pmkpi/rectification/feedback/audit/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);

insert into busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FD7CBB752F2D2924FD94A9F779D809A5', '/pmkpi/rectification/feedback/audit/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);

DELETE FROM P#busfw_t_Uifunction t where t.key='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2E041D630C43BDE245F03751798259C3', '/pmkpi/rectification/feedback/audit/index', '取消审核', 1, 8, 'addaction', 'feedbackAudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AEDD3BDCB952726578D7D2838F16BA87', '/pmkpi/rectification/feedback/audit/index', '审核情况', 1, 9, 'addaction', 'feedbackAudit.showwflogs', null, '审核情况', 'pmkpi', 'showwflogs', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3B63783C84CA198D92FD6EBD458496FB', '/pmkpi/rectification/feedback/audit/index', '审核', 1, 5, 'addaction', 'feedbackAudit.send', null, '审核', 'pmkpi', 'send', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('64AFDD7C9DFD82DA5F418F0B68013751', '/pmkpi/rectification/feedback/audit/index', '查询', 0, 1, 'addaction', 'feedbackAudit.query', null, '查询', 'pmkpi', 'query', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0E47A168221C06E8E8C25C2A3A80EB6C', '/pmkpi/rectification/feedback/audit/index', '退回', 0, 6, 'addaction', 'feedbackAudit.back', null, '退回', 'pmkpi', 'back', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4E3DC0A835A5B0683955F67349075DC2', '/pmkpi/rectification/feedback/audit/index', '批量审核', 0, 7, 'addaction', 'feedbackAudit.sendlist', null, '批量审核', 'pmkpi', 'sendlist', null, null);

insert into busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('54314B2E452249C08234D60BB31729FE', '/pmkpi/rectification/feedback/audit/index', '审核信息', 1, 10, 'searchicon', 'feedbackAudit.auditinfo', null, '审核信息', 'pmkpi', 'auditinfo', null, null);

DELETE FROM P#busfw_t_Uitabpage t where t.key='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A29C4F477B69E77F09501150DC5D3618', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '未审核', 'waitaudit', 1, 1, 'choosed', 'feedbackAudit.clickTabpage', null, '待办', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('916576D530E9FC995D911162E28F4C2B', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'feedbackAudit.clickTabpage', null, '已办', null, '审核,批量审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('06AB75D352DAFA8B47CBFA7F26DDD757', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'feedbackAudit.clickTabpage', null, '曾经办', null, '审核,批量审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

DELETE FROM P#busfw_t_Uiqueryform t where t.key='/pmkpi/rectification/feedback/audit/index';
insert into busfw_t_Uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B279545AD93DAC49EF495E7AFB0A6938', '/pmkpi/rectification/feedback/audit/index', 'PROJNAME', '项目名称', 1, 1, 's', null, 0, 0, 'pmkpi', 'PERF_T_RECTIFY', null, null);
