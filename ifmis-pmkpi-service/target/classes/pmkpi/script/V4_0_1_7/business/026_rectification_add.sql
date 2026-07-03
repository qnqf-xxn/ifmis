begin
-- 整改新增页面(项目、部门 ) 按钮
delete from p#busfw_t_uifunction where key in('/pmkpi/rectification/dept/add','/pmkpi/rectification/program/add');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/add', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/add', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/dept/add', '保存并送审', 1, 2, null, 'addprogram.saveaudit', null, '保存并送审', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/add', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/add', '返回', 1, 3, null, 'addprogram.back', null, '返回', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/program/add', '保存并送审', 1, 2, null, 'addprogram.saveaudit', null, '保存并送审', 'pmkpi', 'audit', null, '{}');

--整改新增页面 部门整体
delete from bus_t_pageconsole where url ='/pmkpi/rectification/dept/edit';
insert into bus_t_pageconsole (URL, TEMPLATE, PAGE, JSLIB, CSSLIB, OBJLIB, APPID, CONSOLESERVICE, METHOD, CONFIG, SUPCONSOLE, REGION, ISEXPAND)
values ('/pmkpi/rectification/dept/edit', 'template8', '/pmkpi/common/template/template_defautl.jsp', '/pmkpi/common/template/template_default.js', null, null, 'pmkpi', 'gov.mof.fasp2.pmkpi.rectification.page.RectificationPage', 'feedbackEdit', '{main:[tabpage],footer:[toolbutton]}', null, null, 0);

-- 整改新增页面(项目、部门 )页签
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/dept/add','/pmkpi/rectification/program/add');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016C4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '基本信息', 'proinfo', 1, 1, 'choosed', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并送审', '{url:''/pmkpi/rectification/program/deptinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016D4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并送审', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016B4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/add', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('25CCFA09C578C553CB3C77D945891EBD', 'pmkpi', '/pmkpi/rectification/program/add', '基本信息', 'proinfo', 1, 1, 'choosed', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并送审', '{url:''/pmkpi/rectification/program/proinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD19AA0879E10A55E053B11FA8C0A366', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C41829802E023DE6FA95330E4525637A', 'pmkpi', '/pmkpi/rectification/program/add', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并送审', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);


--整改新增页  项目支出 ——业务处室字段缺少数据源
delete from bus_t_diccolumn t where t.tablecode in('PERF_PROJECT_INFO') and t.columncode ='FININTORGGUID';
insert into bus_t_diccolumn (DEID, CSID, EXP, ISSYS, DBCOLUMNCODE, ISUSES, YEAR, PROVINCE, COLUMNID, COLUMNCODE, TABLECODE, NAME, DATATYPE, DATALENGTH, SCALE, VERSION, NULLABLE, DEFAULTVALUE, DBVERSION)
values (null, '099003', null, '1', 'FININTORGGUID', '1', null, null, 'B61B314BC21B5271E0530100007F17EC', 'FININTORGGUID', 'PERF_PROJECT_INFO', '财政处室', 'S', '32', null, 1, 1, null, sysdate);

--整改新增页  部门整体——表字段注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/add/deptproj';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF77473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'GUID', 'guid', 1, 0, 0, 0, null, 0, 1, null, null, null, null, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF87473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'LINKMAN', '联系人', 5, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF97473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'NAME', '预算单位名称', 4, 1, 0, 0, null, 0, 1, null, null, null, null, 200, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFA7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'TELEPHONE', '联系电话', 6, 1, 0, 0, null, 0, 1, null, null, null, null, 150, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEFB7473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'WFSTATUS', '工作流状态', 2, 1, 0, 0, null, 0, 1, null, '#name', null, null, 80, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF67473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'CREATETIME', '创建人', 7, 0, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BD4E9B88DEF57473E053B11FA8C03CED', '/pmkpi/rectification/add/deptproj', 'AGENCYGUID', '单位编码', 3, 1, 0, 0, null, 0, 1, null, '#name', null, null, 50, 1, 'tree', null, null);

--整改选择项目  项目支出——表字段注册
delete from p#busfw_t_uicolumn where key ='/pmkpi/rectification/add/proj';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F876728735BB23BC7C910D8FC31D696B', '/pmkpi/rectification/add/proj', 'DEPT_CODE', '部门', 9, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F2559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'FININTORGGUID', '业务处室', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F5559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'EXP_FUNC_CODE', '功能分类', 6, 0, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F7559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'GUID', '项目id', 7, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F8559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_CODE', '项目编码', 2, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F9559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_NAME', '项目名称', 3, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F6559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'PRO_LEV', '项目级别', 1, 0, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('730FCB22D6F3559DE053D100A8C017CB', '/pmkpi/rectification/add/proj', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);

-- 整改通知审核  页签控制按钮的显示隐藏
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/audit/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BAF217043BF56952789CB44851073CE6', 'pmkpi', '/pmkpi/rectification/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'rectificationaudit.clickTabpage', null, '曾经办', null, '下发,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1A0D3885BCE074CFD57E0DD729A1B3FC', 'pmkpi', '/pmkpi/rectification/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'rectificationaudit.clickTabpage', null, '已审核', null, '下发,退回', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('E0E2E3D020AD1A6262A16EAF27480697', 'pmkpi', '/pmkpi/rectification/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'rectificationaudit.clickTabpage', null, '待审核', null, null, '{}', null, '0', null, null, null, null, null, null, null);

--整改情况反馈  页签控制按钮的显示隐藏
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/feedback/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('26333A6799CF2C38E7F7F1CF604745F4', 'pmkpi', '/pmkpi/rectification/feedback/index', '待送审', 'waitaudit', 1, 1, 'choosed', 'feedback.clickTabpage', null, '待审核', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('0DF6CC35CCFE3C543DACA385CD25B26A', 'pmkpi', '/pmkpi/rectification/feedback/index', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'feedback.clickTabpage', null, '已审核', null, '填报/修改,送审', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6F2CFA4806E89730F9E5CD61E9278C36', 'pmkpi', '/pmkpi/rectification/feedback/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'feedback.clickTabpage', null, '曾经办', null, '填报/修改,送审,取消送审', '{}', null, '0', null, null, null, null, null, null, null);

--整改情况审核  页签控制按钮的显示隐藏
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/feedback/audit/index');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('A29C4F477B69E77F09501150DC5D3618', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '待审核', 'waitaudit', 1, 1, 'choosed', 'feedbackAudit.clickTabpage', null, '待审核', null, '取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('916576D530E9FC995D911162E28F4C2B', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'feedbackAudit.clickTabpage', null, '已审核', null, '审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('06AB75D352DAFA8B47CBFA7F26DDD757', 'pmkpi', '/pmkpi/rectification/feedback/audit/index', '曾经办', 'alldeals', 1, 3, 'nomal', 'feedbackAudit.clickTabpage', null, '曾经办', null, '审核,取消审核,审核信息', '{}', null, '0', null, null, null, null, null, null, null);

-- 整改情况反馈填报(项目、部门) 按钮
delete from p#busfw_t_uifunction where key in('/pmkpi/rectification/program/edit','/pmkpi/rectification/dept/edit');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/edit', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/program/edit', '关闭', 1, 3, null, 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/program/edit', '保存并送审', 1, 2, null, 'addprogram.saveaudit', null, '保存并送审', 'pmkpi', 'audit', null, '{}');

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2A521F68FFD4C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/edit', '保存', 1, 1, null, 'addprogram.save', null, '保存', 'pmkpi', 'save', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4A551F68FFD5C4E0E053B11FA8C0D063', '/pmkpi/rectification/dept/edit', '关闭', 1, 3, null, 'Ext.lt.ui.closeModalWindow', null, '关闭', 'pmkpi', 'close', null, '{}');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('120DACFAC78F561AE053B11FA8C05C37', '/pmkpi/rectification/dept/edit', '保存并送审', 1, 2, null, 'addprogram.saveaudit', null, '保存并送审', 'pmkpi', 'audit', null, '{}');


--反馈信息填报 -- 页签对按钮
delete from p#busfw_t_uitabpage where key in('/pmkpi/rectification/dept/edit','/pmkpi/rectification/program/edit');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016E4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并送审', '{url:''/pmkpi/rectification/program/deptinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD534043016F4449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, '保存,保存并送审', '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301704449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改反馈附件', 'file', 1, 5, 'nomal', 'addprogram.clickTabpage', null, '整改反馈附件', null, null, '{filebustype:''feedback'',url:''/pmkpi/rectification/feedbackfile.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301714449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '反馈信息详情', 'feedbackInfo', 1, 4, 'nomal', 'addprogram.clickTabpage', null, '反馈信息详情', null, '保存并送审', '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD53404301724449E053B11FA8C0DF9A', 'pmkpi', '/pmkpi/rectification/dept/edit', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并送审', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('25CCFA09C578C553CB3C77D945891EBD', 'pmkpi', '/pmkpi/rectification/program/edit', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并送审', '{url:''/pmkpi/rectification/program/proinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD19AA0879E10A55E053B11FA8C0A366', 'pmkpi', '/pmkpi/rectification/program/edit', '整改通知附件', 'rectifyfile', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, '保存,保存并送审', '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',viewtype:''query''}', null, '0', 'rectifymanceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B6A93ACFAEEFDFF75CCCBAEC5B3AA467', 'pmkpi', '/pmkpi/rectification/program/edit', '整改反馈附件', 'file', 1, 5, 'nomal', 'addprogram.clickTabpage', null, '整改反馈附件', null, null, '{filebustype:''feedback'',url:''/pmkpi/rectification/feedbackfile.page'',action:''pmkpiuploadfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('FF950D27D2E61F4117846BF2F0CE5C49', 'pmkpi', '/pmkpi/rectification/program/edit', '反馈信息详情', 'feedbackInfo', 1, 4, 'nomal', 'addprogram.clickTabpage', null, '反馈信息详情', null, '保存并送审', '{url:''/pmkpi/rectification/feedback/info.page'',action:''feedbackinfo.save''}', null, '0', 'feedbackiframe', null, null, null, null, null, null);
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('87661BD514DC20D8B6C39A0461794B17', 'pmkpi', '/pmkpi/rectification/program/edit', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并送审', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);

