
begin
  
--首页
DELETE FROM P#Busfw_t_Uifunction t where t.key='/pmkpi/program/mod/report';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F80D42210A2F44D5AAE00B6EE48A81BD', '/pmkpi/program/mod/report', '修订', 1, 2, 'searchicon', 'perfpromodreport.revisionment', null, '修订', 'pmkpi', 'toEdit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3ACA5960E87E4F3C8872331402B2377F', '/pmkpi/program/mod/report', '选择项目', 1, 1, 'searchicon', 'perfpromodreport.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('AC8FA29254CE4B308163D4FD939F173B', '/pmkpi/program/mod/report', '审核情况', 1, 5, 'searchicon', 'perfpromodreport.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('C39DA111D43F4FD9A8C1BE457FD91EC7', '/pmkpi/program/mod/report', '删除项目', 1, 7, 'searchicon', 'perfpromodreport.delrevision', null, '删除项目', 'pmkpi', 'delrevision', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('87E15A9450524E46BEC74A8961BFEBD4', '/pmkpi/program/mod/report', '查看明细', 1, 6, 'searchicon', 'perfpromodreport.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('8274D6CB75CF476691D291D5DFF80E2A', '/pmkpi/program/mod/report', '取消送审', 1, 4, 'searchicon', 'perfpromodreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('0AE74F08668446039E5E04174635A5C9', '/pmkpi/program/mod/report', '送审', 1, 3, 'searchicon', 'perfpromodreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');


DELETE FROM P#busfw_t_uiqueryform t where t.key='/pmkpi/program/mod/report';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('4E4967DB7890451D83485C8C8CFC3B44', '/pmkpi/program/mod/report', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('ABA3B398211348A5B445A30559A7F6B1', '/pmkpi/program/mod/report', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);


DELETE FROM P#Busfw_t_Uitabpage t where t.key='/pmkpi/program/mod/report';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('CB4BEFCED6FD4C8FBE8329FD468167BB', 'pmkpi', '/pmkpi/program/mod/report', '未送审', 'waitaudit', 1, 1, 'choosed', 'perfpromodreport.clickTabpage', 1, '未送审', null, '取消送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('5114B63BD7F742BBA7F0C63EF23C5F08', 'pmkpi', '/pmkpi/program/mod/report', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'perfpromodreport.clickTabpage', 1, '已送审', null, '修订,送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BFE6379C10794681ABD5EF66B6AAE4BD', 'pmkpi', '/pmkpi/program/mod/report', '曾经办', 'alldeals', 1, 3, 'nomal', 'perfpromodreport.clickTabpage', 1, '曾经办', null, '修订,送审,取消送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);


DELETE FROM P#Busfw_t_Uitable t where t.key='/pmkpi/program/mod/report';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('7895A3A6836E4DCAB736E99849C8F61D', '/pmkpi/program/mod/report', 'V_PERF_T_PROVISIONDECLARE', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#Busfw_t_Uicolumn t where t.key='/pmkpi/program/mod/report';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('2E3CA3CD699C444C802530C7BF0D8315', '/pmkpi/program/mod/report', 'PROGUID', '项目主键', 21, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('40BE3491D09B49418B6F7EEA4EF2C52F', '/pmkpi/program/mod/report', 'GUID', '主键', 15, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8CD76812F21B445E98CF8FF8EDEC9333', '/pmkpi/program/mod/report', 'WFSTATUS', '审核状态', 15, 0, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('03B58788298246C3B99FE76557D68469', '/pmkpi/program/mod/report', 'WFID', '工作流id', 20, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('3E3D495DF2D04DE2881EB82E2D82F2F7', '/pmkpi/program/mod/report', 'WFSTATUS', '状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('563936C119574DE9B51688FA441A8045', '/pmkpi/program/mod/report', 'REVISIONNUM', '修订次数', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('75C62DC2FC834C64A22518D5713E0686', '/pmkpi/program/mod/report', 'YEAR', '预算年份', 7, 1, 0, 0, null, null, 1, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C146F8984504810917916FE23E9C54A', '/pmkpi/program/mod/report', 'PRO_CODE', '项目编码', 4, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EAA842327EA44016B94821450A79DEDE', '/pmkpi/program/mod/report', 'PRO_NAME', '项目名称', 5, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DB70D0AA2A0D4581AC2BF40158629FF5', '/pmkpi/program/mod/report', 'CREATETIME', '填报时间', 9, 1, 0, 0, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C5F0DB0C6E5A4FF29721A97FFEB2D6E2', '/pmkpi/program/mod/report', 'FININTORGGUID', '业务处室', 13, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('FB601112D8DC435C8ABC5E8BEF6A6717', '/pmkpi/program/mod/report', 'AGENCYGUID', '预算单位', 6, 1, 0, 0, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', null, null);

--选择项目
DELETE FROM P#Busfw_t_Uifunction t where t.key='/pmkpi/program/mod/report/procheck';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('3D95AE9FDB63420CBA0AADE8D8110E04', '/pmkpi/program/mod/report/procheck', '确定', 1, 1, 'Keepicon', 'pmkpimodreportcheck.save', null, '确定', 'pmkpi', null, null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('4DD754A34C0446258C5B1ACE4993DF6E', '/pmkpi/program/mod/report/procheck', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);


--总体指标
DELETE FROM P#Busfw_t_Uifunction t where t.key='/pmkpi/program/mod/totaledit';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BDD20B0E70AA40BFB31E66052B2E7C25', '/pmkpi/program/mod/totaledit', '确定', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '确定', 'pmkpi', null, null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('15CA6C925D9A4F1DBBE30B51C9A438AF', '/pmkpi/program/mod/totaledit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

DELETE FROM P#Busfw_t_Uitabpage t where t.key='/pmkpi/program/mod/totaledit';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('17A7F8FF0A1D427C8D144CB7870AF411', 'pmkpi', '/pmkpi/program/mod/totaledit', '绩效目标修订', 'progoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标修订', null, null, '{busguid:''2FB4849242234C70ABD595787B713774'',url:''/pmkpi/program/mod/mergeindex.page?modtype=total'',action:''promodmergeindex.save''}', null, '0', 'iframegoaltable', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('78103CED11AC412193F15D707B104D2A', 'pmkpi', '/pmkpi/program/mod/totaledit', '基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{busguid:''C23D4A4FD4614DC7BAF00EC3D2DE5F97'',url:''/pmkpi/program/mod/edit/info.page'',viewtype:''query''}', null, '0', 'infoiframe', null, null, null, null, null, null);



--年度指标
DELETE FROM P#Busfw_t_Uifunction t where t.key='/pmkpi/program/mod/yearedit';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9EBACD3B14B1438E8EBDE17D1B34B081', '/pmkpi/program/mod/yearedit', '确定', 1, 1, 'Keepicon', 'tabfreamedit.infosave', null, '确定', 'pmkpi', null, null, null);

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('323E89F6E39743B28120AEF2737B9CC3', '/pmkpi/program/mod/yearedit', '取消', 1, 2, 'Nofinishicon', 'Ext.lt.ui.closeModalWindow', null, '取消', 'pmkpi', null, null, null);

DELETE FROM P#Busfw_t_Uitabpage t where t.key='/pmkpi/program/mod/yearedit';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('66D01BB947284BC28A274FBBC17A7C0B', 'pmkpi', '/pmkpi/program/mod/yearedit', '绩效目标修订', 'progoal', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '绩效目标修订', null, null, '{busguid:''2FB4849242234C70ABD595787B713774'',url:''/pmkpi/program/mod/mergeindex.page?modtype=year'',action:''promodmergeindex.save''}', null, '0', 'iframegoaltable', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('18627F5ACB164B2EB276C577064EDAB1', 'pmkpi', '/pmkpi/program/mod/yearedit', '基本信息', 'proinfo', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, '保存', '{busguid:''C23D4A4FD4614DC7BAF00EC3D2DE5F97'',url:''/pmkpi/program/mod/edit/info.page'',viewtype:''query''}', null, '0', 'infoiframe', null, null, null, null, null, null);


--指标目标合并页面
DELETE FROM p#Busfw_t_Uieditform t where t.key='/pmkpi/program/mod/mergeindex';
insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E1584695B4A34CA3A8549965BD12DCEC', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '创建人', 'CREATER', 0, null, 1, null, 14, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C2ED9E8E2D904288BD5921550C53C64B', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '版本说明', 'VERSION_NAME', 0, null, 1, null, 25, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('A834551C0F6B4A4EBCE3381A57DB4A45', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '是否年度指标', 'YEARFLAG', 0, null, 1, null, 31, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('B42313B35D254AE2B6E962E3EBFB9D0D', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', 'guid', 'GUID', 0, null, 1, null, 3, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('F7B6F36ACA5048E489A69A14EBE6FF14', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '更新时间', 'UPDATE_TIME', 0, null, 1, null, 27, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4BBAC113E01D43CA8CA7B34386F6AAE2', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '是否删除1是2否', 'IS_DELETED', 0, null, 1, '2', 28, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C1A33247FE4142659D1623E6241A3C64', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '创建时间', 'CREATE_TIME', 0, null, 1, null, 29, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('4D8C0B6B4A954B37904894D901B0AB36', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '单位', 'AGENCY_CODE', 0, null, 1, null, 30, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('FBB66A80039645C99EE77FD35119F44A', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '单位', 'AGENCYGUID', 0, null, 1, null, 11, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('2C83D9ADAB204181A26F19569B1D3B7D', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '主单guid', 'MAINGUID', 0, null, 1, null, 12, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C36B343EF9D3444683AD7F74DF948C63', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '创建时间', 'CREATETIME', 0, null, 1, null, 13, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('2D28C943D2AD44C5A63FE5562E1C903C', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '下级财政区划代码', 'SUB_MOF_CODE', 0, null, 1, null, 26, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('7F8DF8AACCD04469B74A8BD39DE0D7F3', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '区划', 'PROVINCE', 0, null, 1, null, 15, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('BD5F4E722D1343AB8C43E303709832A5', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '年度', 'YEAR', 0, null, 1, null, 16, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C93EA8ECFBFC4AAF82FF8CEF122DF0C7', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '财政区划代码', 'MOF_DIV_CODE', 0, null, 1, null, 17, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('0653E29C400E4A7AB08373AE13BE2241', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '预算年度', 'FISCAL_YEAR', 0, null, 1, null, 20, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('85E0024325974FBF9075E740C26A75EA', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '项目代码', 'PRO_CODE', 0, null, 1, null, 21, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('6D3231BEB5EC4CB1A2F20F8A89997E7D', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 'textarea', '绩效目标', 'KPI_TARGET', 1, null, 1, null, 2, 3, '3', 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('C6E24B713F56434D97F251004F86F6A7', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '业务类型代码', 'BUSI_TYPE_CODE', 0, null, 1, null, 23, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('D5BDB89CC9C14FFABEA054007E566781', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '版本号', 'VERSION', 0, null, 1, null, 24, null, null, 'pmkpi', 1, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('E0028FE4FBD643C081FE4005DCA5AABE', '/pmkpi/program/mod/mergeindex', 'V_PERF_PROVISION_GOAL_INFO', 's', '项目绩效目标主键', 'KPI_PER_ID', 0, null, 1, null, 22, null, null, 'pmkpi', 1, null, '{}', null, null, null);


--审核页面

DELETE FROM P#Busfw_t_Uifunction t where t.key='/pmkpi/program/mod/audit';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('88F2AC2BB742415693FB75A5DF247537', '/pmkpi/program/mod/audit', '审核情况', 1, 3, 'searchicon', 'pmkpipromodaudit.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('E68DF4184B46465EBEA2C4401AB6CC7F', '/pmkpi/program/mod/audit', '取消审核', 1, 2, 'searchicon', 'pmkpipromodaudit.wfAudit', null, '取消审核', 'pmkpi', 'cancelaudit', null, '{"action":"audit_cancel"}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('D3B04CD214534DA6872894FE00572E68', '/pmkpi/program/mod/audit', '审核', 1, 1, 'searchicon', 'pmkpipromodaudit.audit', null, '审核', 'pmkpi', 'audit', null, '{"action":"audit"}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('9BCEBAEC631D43F4B695BDEC75FCC321', '/pmkpi/program/mod/audit', '查看明细', 1, 4, 'searchicon', 'pmkpipromodaudit.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');


DELETE FROM P#Busfw_t_Uitabpage t where t.key='/pmkpi/program/mod/audit';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('94D33D00CE5440E3939ACB8A544A9AA9', 'pmkpi', '/pmkpi/program/mod/audit', '曾经办', 'alldeals', 1, 3, 'nomal', 'pmkpipromodaudit.clickTabpage', 0, '曾经办', null, '审核,取消审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('1E046EC67DA14D388548F92E04282002', 'pmkpi', '/pmkpi/program/mod/audit', '已审核', 'alreadyaudit', 1, 2, 'nomal', 'pmkpipromodaudit.clickTabpage', 0, '已审核', null, '审核', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('8B64D809E6A04691B08056ACDE3AD92D', 'pmkpi', '/pmkpi/program/mod/audit', '审核', 'waitaudit', 1, 1, 'choosed', 'pmkpipromodaudit.clickTabpage', 0, '待审核', null, '取消审核', '{}', null, '0', null, null, null, null, null, null, null);


DELETE FROM P#busfw_t_uiqueryform t where t.key='/pmkpi/program/mod/audit';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('77097630519B45ED883FF7FD4DCD3011', '/pmkpi/program/mod/audit', 'PRO_NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('407AD97E04D34B859B357045E599A9E3', '/pmkpi/program/mod/audit', 'PRO_CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_PROVISIONDECLARE', '{}', null);


DELETE FROM P#Busfw_t_Uitable t where t.key='/pmkpi/program/mod/audit';
insert into Busfw_t_Uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('8B90E2D792B548BA8B35F6288249F1D8', '/pmkpi/program/mod/audit', 'V_PERF_T_PROVISIONDECLARE', 100, 0, 0, null, null, 'pmkpi', null);


DELETE FROM P#Busfw_t_Uicolumn t where t.key='/pmkpi/program/mod/audit';
insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('289F5CC3159E407B8547B700215F6F30', '/pmkpi/program/mod/audit', 'PROGUID', '项目主键', 21, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('92444E724DD24B0E96477E5055A97661', '/pmkpi/program/mod/audit', 'GUID', '主键', 15, 0, 0, 0, null, null, null, null, null, null, null, null, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('ABC27BD4A3B1482DAC31C5434658AC2B', '/pmkpi/program/mod/audit', 'WFSTATUS', '审核状态', 15, 0, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('8FE55ECA220C4A4FAF9793A73ADC5AC6', '/pmkpi/program/mod/audit', 'WFID', '工作流id', 20, 0, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('727D54F5B0854FEA818390AEED06D7F1', '/pmkpi/program/mod/audit', 'WFSTATUS', '状态', 2, 1, 0, 0, null, 0, 6, null, '#name', null, null, 80, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('E55E57EACA1D40BA8C6AF522248622CE', '/pmkpi/program/mod/audit', 'REVISIONNUM', '修订次数', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('42190AABCC56494DACAB0BC724A1E853', '/pmkpi/program/mod/audit', 'YEAR', '预算年份', 7, 1, 0, 0, null, null, 1, null, null, null, null, 100, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F3CAD2C98B8E46A0848BE1F5634EE1C0', '/pmkpi/program/mod/audit', 'PRO_CODE', '项目编码', 4, 1, 0, 0, null, null, null, null, null, null, null, 150, 1, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1424F7921F8C468ABFFA8FAA6115CE96', '/pmkpi/program/mod/audit', 'PRO_NAME', '项目名称', 5, 1, 0, 0, null, null, 1, null, null, null, null, 200, 0, 's', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1198D495C28B4F09A7525310556058CE', '/pmkpi/program/mod/audit', 'CREATETIME', '填报时间', 9, 1, 0, 0, null, null, 1, null, 'yyyy-MM-dd hh:mm:ss', null, null, 100, 0, 'd', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('1184062F20B24813AB205D4E184658CF', '/pmkpi/program/mod/audit', 'FININTORGGUID', '业务处室', 13, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', null, null);

insert into Busfw_t_Uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C6E67D7F1E0E417C8E2AF64E242F23C8', '/pmkpi/program/mod/audit', 'AGENCYGUID', '预算单位', 6, 1, 0, 0, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', null, null);


DELETE FROM p#Busfw_t_Uifunction t where t.key='/pmkpi/program/apply/mod';
insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('2E01A8643DD0418CA5EF3F87EC52CFCE', '/pmkpi/program/apply/mod', '修订', 0, 2, 'searchicon', 'perfpromodreport.revisionment', null, '修订', 'pmkpi', 'toEdit', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('971A283C0A8D4528BA81CBCC5711E194', '/pmkpi/program/apply/mod', '选择项目', 1, 1, 'searchicon', 'perfpromodreport.checkprogram', null, '选择项目', 'pmkpi', 'checkprogram', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('7372977C605A4822B3A4102DE3268666', '/pmkpi/program/apply/mod', '审核情况', 1, 5, 'searchicon', 'perfpromodreport.queryaudit', null, '审核情况', 'pmkpi', 'showwfinfo', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('F3C651191A0841E9848673BA1523CF17', '/pmkpi/program/apply/mod', '删除项目', 1, 7, 'searchicon', 'perfpromodreport.delrevision', null, '删除项目', 'pmkpi', 'delrevision', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('BFD54F8D01604E518A7466B2477B54F2', '/pmkpi/program/apply/mod', '查看明细', 1, 6, 'searchicon', 'perfpromodreport.detailed', null, '查看明细', 'pmkpi', 'detailed', null, '{}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('B533164A40E14A14BA91088A92878533', '/pmkpi/program/apply/mod', '取消送审', 1, 4, 'searchicon', 'perfpromodreport.wfAudit', null, '取消送审', 'pmkpi', 'cancelsendaudit', null, '{"action":"audit_cancel"}');

insert into Busfw_t_Uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG)
values ('47766CDC4C41489A966FBB2646AC006B', '/pmkpi/program/apply/mod', '送审', 1, 3, 'searchicon', 'perfpromodreport.wfAudit', null, '送审', 'pmkpi', 'sendaudit', null, '{"action":"audit"}');


DELETE FROM p#Busfw_t_Uitabpage t where t.key='/pmkpi/program/apply/mod';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('5F9CD608E91B404A9EA43CCF9A00A1DB', 'pmkpi', '/pmkpi/program/apply/mod', '未送审', 'waitaudit', 1, 1, 'choosed', 'perfpromodreport.clickTabpage', 1, '未送审', null, '取消送审', '{wheresql:'' 1=1 ''}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('01274911C56540AFB223FD23E364FE13', 'pmkpi', '/pmkpi/program/apply/mod', '已送审', 'alreadyaudit', 1, 2, 'nomal', 'perfpromodreport.clickTabpage', 1, '已送审', null, '修订,送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('6552902A44014E7ABD0531C018D7288C', 'pmkpi', '/pmkpi/program/apply/mod', '曾经办', 'alldeals', 1, 3, 'nomal', 'perfpromodreport.clickTabpage', 1, '曾经办', null, '修订,送审,取消送审,删除项目,选择项目', '{}', null, '0', null, null, null, null, null, null, null);
