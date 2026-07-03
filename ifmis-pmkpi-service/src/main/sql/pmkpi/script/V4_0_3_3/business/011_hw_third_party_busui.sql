begin

--1、评价成果上传-评估结论页面增加“是否委托第三方开展”，值集为“是、否”，必填，发版隐藏
delete from p#busfw_t_uieditform where key = '/pmkpi/evaluation/dept/result/edit' and columncode = 'ISENTRUST';
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/result/edit', 'V_PERF_T_DEPTEVALUATION', 'tree', '是否委托第三方开展', 'ISENTRUST', 0, null, 1, null, 4, null, null, 'pmkpi', 1, null, '{}', null, null, null, null, null, null);

--2、评价成果上传，增加“第三方信息”页签，发版隐藏
delete from busfw_t_uitabpage where key ='/pmkpi/evaluation/dept/result/edit' and code = 'thirdparty';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/evaluation/dept/result/edit', '第三方信息', 'thirdparty', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '第三方信息', null, null, '{url:''/pmkpi/evaluation/dept/thirdparty.page'',action:''thirdparty.save''}', null, '0', 'thirdpartyiframe', null, null, null, null, null, null, null, null);

delete from busfw_t_uitable where key = '/pmkpi/evaluation/dept/thirdparty';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values (sys_guid(), '/pmkpi/evaluation/dept/thirdparty', 'V_PERF_THIRD_PARTY_INFO', 0, 0, 0, null, null, 'pmkpi', '{}');

delete from busfw_t_uicolumn where key = '/pmkpi/evaluation/dept/thirdparty';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/thirdparty', 'LEADER_NAME', '负责人名称', 2, 1, 1, null, null, null, 1, null, null, null, null, 120, 0, 's', '{}', null, null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/evaluation/dept/thirdparty', 'INSTITUTION_NAME', '第三方机构名称', 1, 1, 1, null, null, null, 1, null, null, null, null, 200, 0, 's', '{}', null, null, null);



