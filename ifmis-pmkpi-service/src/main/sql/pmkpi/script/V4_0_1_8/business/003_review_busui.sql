begin

delete from p#busfw_t_uitable t where t.key='/pmkpi/review/report/list';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('CAFEB34355B2591DE0533315A8C05C95', '/pmkpi/review/report/list', 'PERF_V_REVIEWQUERY', 100, 0, 0, null, null, 'pmkpi', '{program:"1=1",dept:"1=1"}');

delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/review/report/list');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355F5591DE0533315A8C05C95', '/pmkpi/review/report/list', 'ISCONFIRM', '是否确认', 1, 1, 0, 0, null, null, null, null, '#name', null, null, 100, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355F6591DE0533315A8C05C95', '/pmkpi/review/report/list', 'PRO_CODE', '项目名称', 2, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{type:''program,zyzfprogram''}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355F7591DE0533315A8C05C95', '/pmkpi/review/report/list', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, null, null, '#code-#name', null, null, 200, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355F8591DE0533315A8C05C95', '/pmkpi/review/report/list', 'YEAR', '预算年份', 4, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355FA591DE0533315A8C05C95', '/pmkpi/review/report/list', 'FININTORGGUID', '业务科室', 13, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355FB591DE0533315A8C05C95', '/pmkpi/review/report/list', 'CREATER', '创建人', 14, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355FC591DE0533315A8C05C95', '/pmkpi/review/report/list', 'GUID', '主键', 15, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355FD591DE0533315A8C05C95', '/pmkpi/review/report/list', 'WFSTATUS', '审核状态', 15, 0, 0, null, null, null, null, null, '#name', null, null, null, 1, 'tree', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355FF591DE0533315A8C05C95', '/pmkpi/review/report/list', 'PROGUID', '评审表guid', 20, 0, 0, null, null, null, null, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB34355FE591DE0533315A8C05C95', '/pmkpi/review/report/list', 'WFID', '工作流id', 20, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB3435600591DE0533315A8C05C95', '/pmkpi/review/report/list', 'FREVIEWNAME', '初审意见', 21, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB3435601591DE0533315A8C05C95', '/pmkpi/review/report/list', 'FOPINION', '修改完善意见（初审）', 22, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB3435602591DE0533315A8C05C95', '/pmkpi/review/report/list', 'SREVIEWNAME', '复核意见', 24, 0, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CAFEB3435603591DE0533315A8C05C95', '/pmkpi/review/report/list', 'SOPINION', '修改完善意见（复核）', 25, 0, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CBA0265D78CF2334E0533315A8C097E1', '/pmkpi/review/report/list', 'SHJL', '审核结论', 27, 1, 0, null, null, null, null, null, null, null, null, 100, 0, 's', '{}', null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('CBA0265D78D02334E0533315A8C097E1', '/pmkpi/review/report/list', 'REMARK', '审核意见', 28, 1, 0, null, null, null, null, null, null, null, null, 150, 0, 's', '{}', null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/review/report/list');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('CAFEB3435638591DE0533315A8C05C95', '/pmkpi/review/report/list', 'PRO_CODE', '项目名称', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_REVIEW', '{formart:''#code-#name''}', null);

delete from p#busfw_t_uitabpage t where t.key in('/pmkpi/review/report/list');
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B99D7BA8413D628AE053B11FA8C0BED3', 'pmkpi', '/pmkpi/review/report/list', '待提交', 'waitaudit', 1, 1, 'choosed', 'pmkpireviewreport.clickTabpage', 0, '待提交', null, '取消委托专家,取消确认评审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B99D7BA8413C628AE053B11FA8C0BED3', 'pmkpi', '/pmkpi/review/report/list', '已提交', 'alreadyaudit', 1, 2, 'nomal', 'pmkpireviewreport.clickTabpage', 0, '已提交', null, '评审,生成工作流,提交,取消确认评审,委托专家,修改项目,导入评审意见,批量提交送审', '{}', null, '0', null, null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('B98F570474DBC0DCE053B11FA8C0D7F5', 'pmkpi', '/pmkpi/review/report/list', '曾经办', 'allconfirm', 1, 3, 'nomal', 'pmkpireviewreport.clickTabpage', 0, '曾经办', null, '确认评审,评审,提交,生成工作流,取消委托专家,委托专家,修改项目,导入评审意见,批量提交送审,取消确认评审', '{}', null, '0', null, null, null, null, null, null, null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/review/report/program');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('B9B648D940F56F00E053B11FA8C05B38', '/pmkpi/review/report/program', 'PRO_CODE', '项目名称', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_REVIEW', '{formart:''#code-#name''}', null);

delete from p#busfw_t_uiqueryform t where t.key in('/pmkpi/review/report/dept');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL)
values ('BA054DBD86D53316E053B11FA8C0178B', '/pmkpi/review/report/dept', 'AGENCYGUID', '预算单位', 1, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_REVIEW', '{format:''#code-#name''}', null);
