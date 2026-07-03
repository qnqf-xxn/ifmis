begin

delete from p#busfw_t_uitable t where t.key in('/pmkpi/perfself/taskmanage');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('68D79B22EF8F4D8F9DCB51E51910A02F', '/pmkpi/perfself/taskmanage', 'V_PERF_V_SELFEVALPROGRAMS', 100, 0, 0, null, null, 'pmkpi', '{program:" exists(select 1 from v_pm_perf_goal_info gl where gl.pro_code=t.pro_code and gl.yearflag=''0'')",dept:" exists(select 1 from v_bgt_perf_goal_info gl where gl.mainguid=t.projguid)"}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/perfself/taskmanage');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('42C5B7D2F837492E8D9E359D65172BE2', '/pmkpi/perfself/taskmanage', 'PRO_CODE', '项目编码', 0, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('115B297F3F984A98A0178115943DDE8E', '/pmkpi/perfself/taskmanage', 'PRO_CODE', '部门编码', 1, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('7B5007224B5C41418D1E30C6972EB39F', '/pmkpi/perfself/taskmanage', 'NAME', '部门名称', 2, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{isdept:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('08AF794356DE45A496CC4E5D84D926DA', '/pmkpi/perfself/taskmanage', 'NAME', '项目名称', 3, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{ispro:1}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EF0A5321A7C643C6BACC0B6C80039E06', '/pmkpi/perfself/taskmanage', 'AGENCYGUID', '预算单位', 4, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('EE9A1E2E76464480A9741EA59855918C', '/pmkpi/perfself/taskmanage', 'FININTORGGUID', '业务处室', 5, 1, 0, 0, null, 0, 6, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('33406A2509654C62A003C4DE9FC4BE46', '/pmkpi/perfself/taskmanage', 'BUDGETAMOUNT', '全年预算数', 6, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C89F77F069A62E90E0533315A8C0A9BE', '/pmkpi/perfself/taskmanage', 'EXECRATENUM', '调整后预算数', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0D9F9AF47A1544A7840B79D4ECA82DD6', '/pmkpi/perfself/taskmanage', 'EXECAMOUNT', '全年执行数', 8, 0, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('89ABE20F736340F195264F9CF5720580', '/pmkpi/perfself/taskmanage', 'EXECRATE', '预算执行率', 9, 1, 0, 0, null, 0, 6, null, null, null, null, 200, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('A2D576F94193449DA7F652B8DCFE44D5', '/pmkpi/perfself/taskmanage', 'EVALSTART', '开始时间', 10, 1, 0, 0, null, 0, 6, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('DDF3DD3050564C61934176867E159BDC', '/pmkpi/perfself/taskmanage', 'EVALEND', '截止时间', 11, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', '{}', null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/perfself/taskmanage');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C15713128F464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/taskmanage', '未下达', 'waitaudit', 1, 1, 'choosed', 'perfselfmanage.clickTabpage', null, '未下达', null, '取消下达', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C157131291464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/taskmanage', '已下达', 'alreadyaudit', 1, 2, 'nomal', 'perfselfmanage.clickTabpage', null, '已下达', 't.evalstatus =1', '任务下达', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C7C157131290464FE0533315A8C0A90F', 'pmkpi', '/pmkpi/perfself/taskmanage', '已完成', 'alldeals', 1, 3, 'nomal', 'perfselfmanage.clickTabpage', null, '已完成', 't.evalstatus =2', '任务下达,取消下达', '{}', null, '0', null, null, null, null, null, null, null);
