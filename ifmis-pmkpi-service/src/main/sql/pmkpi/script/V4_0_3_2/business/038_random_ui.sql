
begin


--范围标识-UI表注册
delete from p#busfw_t_uitable t where t.key = '/pmkpi/randomcomment/scope/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'V_PERF_T_RANDOMCOMMENT_PROJ', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

--范围标识(项目支出)-列注册
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/scope/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','AGENCYGUID','预算单位',3,1,0,0,0,0,NULL,NULL,'#code-#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','PROJNAME','项目名称',2,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','PROLEV','项目级次',2,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','SELFSCORE','自评得分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/index','SELFRESULT','自评结论',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);

--范围标识-按钮注册
delete from p#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/scope/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', '查询', 0, 1, 'searchicon', 'randomcommentscope.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', '提交', 1, 2, 'searchicon', 'randomcommentscope.submit', null, '提交', 'pmkpi', 'submit', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', '删除', 1, 3, 'searchicon', 'randomcommentscope.del', null, '删除', 'pmkpi', 'del', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', '查看项目明细', 1, 4, 'searchicon', 'randomcommentscope.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', '查看自评详情', 1, 5, 'searchicon', 'randomcommentscope.querySelfInfo', null, '查看自评详情', 'pmkpi', 'querySelfInfo', null, '{}','2016','87');

--范围标识-查询区注册
delete from p#busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/scope/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'PROJNAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'WFSTATUS', '审核状态', 2, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'PROJTYPE', '项目类别', 4, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'AMTMAX', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'AMTMIN', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/scope/index', 'ADJUSTSTATUS', '是否目标调整', 7, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');

--范围标识-页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/randomcomment/scope';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/scope', '待标识', '1', 1, 1, 'choosed', 'randomcommentscope.clickTabpage', null, '待标识', null, null, '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/scope', '已标识', '2', 1, 2, 'nomal', 'randomcommentscope.clickTabpage', null, '已标识', null, null, '{}', null, '0', null, null, null, null, null, null, null,'2016','87');


--范围标识-左侧页签注册
delete from perf_t_treetab where key = '/pmkpi/randomcomment/scope' and year = '2016';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/scope', 'dept', '部门整体', 1, null, 2, '2016', '87', null, 'deptrandomscope');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/scope', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programrandomscope');



--范围标识(部门整体)-列注册
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/scope/dept');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','SELFSCORE','自评得分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/scope/dept','SELFRESULT','自评结论',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);



--抽评对象确定-UI表注册
delete from p#busfw_t_uitable t where t.key = '/pmkpi/randomcomment/object/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'V_PERF_T_RANDOMCOMMENT_PROJ', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

--抽评对象确定(项目支出)-列注册
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/object/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','AGENCYGUID','预算单位',3,1,0,0,0,0,NULL,NULL,'#code-#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','PROJNAME','项目名称',2,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','PROLEV','项目级次',2,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','SELFSCORE','自评得分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/object/index','SELFRESULT','自评结论',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);

--抽评对象确定-按钮注册
delete from p#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/object/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '查询', 0, 1, 'searchicon', 'randomcommentobject.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '选择已有项目', 1, 2, 'searchicon', 'randomcommentobject.exisProj', null, '选择已有项目', 'pmkpi', 'exisProj', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '提交', 1, 3, 'searchicon', 'randomcommentobject.submit', null, '提交', 'pmkpi', 'submit', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '撤销已提交', 1, 4, 'searchicon', 'randomcommentobject.backProj', null, '撤销已提交', 'pmkpi', 'backProj', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '查看项目明细', 1, 5, 'searchicon', 'randomcommentobject.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '查看自评详情', 1, 6, 'searchicon', 'randomcommentobject.querySelfInfo', null, '查看自评详情', 'pmkpi', 'querySelfInfo', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', '删除', 1, 7, 'searchicon', 'randomcommentobject.del', null, '删除', 'del', 'query', null, '{}','2016','87');

--抽评对象确定-查询区注册
delete from p#busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/object/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'PROJNAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'WFSTATUS', '审核状态', 2, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'PROJTYPE', '项目类别', 4, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'AMTMAX', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'AMTMIN', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/object/index', 'ADJUSTSTATUS', '是否目标调整', 7, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');

--抽评对象确定-页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/randomcomment/object';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/object', '待提交', '1', 1, 1, 'choosed', 'randomcommentobject.clickTabpage', null, '待提交', 'waitaudit', '待提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/object', '已提交', '2', 1, 2, 'nomal', 'randomcommentobject.clickTabpage', null, '已提交', 'alreadyaudit', '已提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/object', '曾经办', '3', 0, 3, 'nomal', 'randomcommentobject.clickTabpage', null, '曾经办', 'alldeals', '曾经办', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

--抽评对象确定-左侧页签注册
delete from perf_t_treetab where key = '/pmkpi/randomcomment/object' and year = '2016';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/object', 'dept', '部门整体', 1, null, 2, '2016', '87', 'BC9E69FB8F45683DADA94276CA20F191', 'deptrandomobject');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/object', 'program', '项目支出', 1, null, 1, '2016', '87', 'BC9E69FB8F45683DADA94276CA20F191', 'programrandomobject');


--随机抽取管理-UI表注册
delete from p#busfw_t_uitable t where t.key = '/pmkpi/randomcomment/random/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', 'V_PERF_T_RANDOMCOMMENT_PROJ', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

--随机抽取管理(项目支出)-列注册
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/random/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','AGENCYGUID','预算单位',3,1,0,0,0,0,NULL,NULL,'#code-#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','PROJNAME','项目名称',2,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','PROLEV','项目级次',2,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','SELFSCORE','自评得分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/random/index','SELFRESULT','自评结论',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);

--随机抽取管理-按钮注册
delete from p#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/random/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', '查询', 0, 1, 'searchicon', 'randomcommentrandom.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', '随机抽取设置', 1, 2, 'searchicon', 'randomcommentrandom.setup', null, '随机抽取设置', 'pmkpi', 'setup', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', '开始抽取', 1, 3, 'searchicon', 'randomcommentrandom.start', null, '开始抽取', 'pmkpi', 'start', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', '查看项目明细', 1, 4, 'searchicon', 'randomcommentrandom.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', '查看自评详情', 1, 5, 'searchicon', 'randomcommentrandom.querySelfInfo', null, '查看自评详情', 'pmkpi', 'querySelfInfo', null, '{}','2016','87');

--随机抽取管理-查询区注册
delete from p#busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/random/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', 'PROJNAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', 'WFSTATUS', '审核状态', 2, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', 'PROJTYPE', '项目类别', 4, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', 'AMTMAX', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/index', 'AMTMIN', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');

--随机抽取管理-页签注册
delete from p#busfw_t_uitabpage where key = '/pmkpi/randomcomment/randoms';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/randoms', '待抽取', '1', 1, 1, 'choosed', 'randomcommentrandom.clickTabpage', null, '待抽取', 'wait', null, '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/randoms', '已抽取', '2', 1, 2, 'nomal', 'randomcommentrandom.clickTabpage', null, '已抽取', 'done', '随机抽取设置,开始抽取', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

--随机抽取管理-左侧页签注册
delete from perf_t_treetab where key = '/pmkpi/randomcomment/randoms' and year = '2016';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/randoms', 'dept', '部门整体', 1, null, 2, '2016', '87', null, 'deptrandomos');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/randoms', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programrandoms');

--绩效抽评委托-UI表注册
delete from p#busfw_t_uitable t where t.key = '/pmkpi/randomcomment/entrust/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/entrust/index', 'V_PERF_T_RANDOMCOMMENT_PROJ', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

--绩效抽评委托(项目支出)-列注册
delete from p#busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/entrust/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','AGENCYGUID','预算单位',3,1,0,0,0,0,NULL,NULL,'#code-#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','PROJNAME','项目名称',2,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','PROLEV','项目级次',2,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','SELFSCORE','自评得分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','SELFRESULT','自评结论',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/entrust/index','MEACHNAME','委托机构',11,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);

--绩效抽评委托-按钮注册
delete from p#busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/entrust/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/entrust/index', '查询', 0, 1, 'searchicon', 'randomcommententrust.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/entrust/index', '委托第三方', 1, 2, 'searchicon', 'randomcommententrust.entrust', null, '委托第三方', 'pmkpi', 'entrust', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/entrust/index', '撤销已提交', 1, 3, 'searchicon', 'randomcommententrust.back', null, '撤销已提交', 'pmkpi', 'back', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/entrust/index', '查看项目明细', 1, 4, 'searchicon', 'randomcommententrust.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/entrust/index', '查看自评详情', 1, 5, 'searchicon', 'randomcommententrust.querySelfInfo', null, '查看自评详情', 'pmkpi', 'querySelfInfo', null, '{}','2016','87');

--绩效抽评委托-查询区注册
delete from p#busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/random/entrust';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/entrust', 'PROJNAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/entrust', 'WFSTATUS', '审核状态', 2, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/entrust', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/entrust', 'PROJTYPE', '项目类别', 4, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/entrust', 'AMTMAX', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/entrust', 'AMTMIN', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');

--绩效抽评委托-页签注册
delete from busfw_t_uitabpage where key = '/pmkpi/randomcomment/entrust';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/entrust', '待提交', '1', 1, 1, 'choosed', 'randomcommententrust.clickTabpage', null, '待提交', 'waitaudit', '撤销已提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/entrust', '已提交', '2', 1, 2, 'nomal', 'randomcommententrust.clickTabpage', null, '已提交', 'alreadyaudit', '委托第三方', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

--绩效抽评委托-左侧页签注册
delete from perf_t_treetab where key = '/pmkpi/randomcomment/entrust' and year = '2016';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/entrust', 'dept', '部门整体', 1, null, 2, '2016', '87', null, 'deptrandomentrust');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/entrust', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programrandomentrust');


--抽评结果上传-UI表注册
delete from busfw_t_uitable t where t.key = '/pmkpi/randomcomment/result/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', 'V_PERF_T_RANDOMCOMMENT_PROJ', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

--抽评结果上传(项目支出)-列注册
delete from busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/result/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','AGENCYGUID','预算单位',3,1,0,0,0,0,NULL,NULL,'#code-#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','PROJNAME','项目名称',2,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','PROLEV','项目级次',2,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','ACTUALSCORE','抽评总分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','RANDOMRESULT','抽评结果',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/result/index','MEACHNAME','委托机构',11,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);

--抽评结果上传-按钮注册
delete from busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/result/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '查询', 0, 1, 'searchicon', 'randomcommentresult.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '填报', 1, 2, 'searchicon', 'randomcommentresult.report', null, '填报', 'pmkpi', 'report', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '提交', 1, 3, 'searchicon', 'randomcommentresult.submit', null, '提交', 'pmkpi', 'submit', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '取消提交', 1, 4, 'searchicon', 'randomcommentresult.submit', null, '取消提交', 'pmkpi', 'cancelsubmit', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '上传评价结果', 1, 5, 'searchicon', 'randomcommentresult.upload', null, '上传评价结果', 'pmkpi', 'upload', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '查看项目明细', 0, 6, 'searchicon', 'randomcommentresult.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/result/index', '查看自评详情', 0, 7, 'searchicon', 'randomcommentresult.querySelfInfo', null, '查看自评详情', 'pmkpi', 'querySelfInfo', null, '{}','2016','87');

--抽评结果上传-查询区注册
delete from p#busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/random/result/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/result/index', 'PROJNAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/result/index', 'WFSTATUS', '审核状态', 2, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/result/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/result/index', 'PROJTYPE', '项目类别', 4, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/result/index', 'AMTMAX', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/random/result/index', 'AMTMIN', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');

--抽评结果上传-页签注册
delete from busfw_t_uitabpage where key = '/pmkpi/randomcomment/result';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/result', '待提交', '1', 1, 1, 'choosed', 'randomcommentresult.clickTabpage', null, '待提交', 'ISSUBMIT=''0''', '取消提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, YEAR, PROVINCE)
values (sys_guid(), 'pmkpi', '/pmkpi/randomcomment/result', '已提交', '2', 1, 2, 'nomal', 'randomcommentresult.clickTabpage', null, '已提交', 'ISSUBMIT=''1''', '上传评价结果,填报,提交', '{}', null, '0', null, null, null, null, null, null, null,'2016','87');

--抽评结果上传-左侧页签注册
delete from perf_t_treetab where key = '/pmkpi/randomcomment/result' and year = '2016';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/result', 'dept', '部门整体', 1, null, 2, '2016', '87', null, 'deptrandomresult');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/result', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programrandomresult');


--绩效抽评查询-UI表注册
delete from busfw_t_uitable t where t.key = '/pmkpi/randomcomment/query/index';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', 'V_PERF_T_RANDOMCOMMENT_PROJ', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

--绩效抽评查询(项目支出)-列注册
delete from busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/query/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','AGENCYGUID','预算单位',3,1,0,0,0,0,NULL,NULL,'#code-#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','PROJNAME','项目名称',2,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','PROLEV','项目级次',2,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','SCORE','自评质量得分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','ACTUALSCORE','抽评总分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','RANDOMRESULT','抽评结果',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/query/index','MEACHNAME','委托机构',11,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);

--绩效抽评查询-按钮注册
delete from busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/query/index';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', '查询', 0, 1, 'searchicon', 'randomcommentquery.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', '查看项目明细', 1, 2, 'searchicon', 'randomcommentquery.showProjView', null, '查看项目明细', 'pmkpi', 'showProjView', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', '查看自评详情', 0, 3, 'searchicon', 'randomcommentquery.querySelfInfo', null, '查看自评详情', 'pmkpi', 'querySelfInfo', null, '{}','2016','87');

--绩效抽评查询-查询区注册
delete from busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/query/index';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', 'PROJNAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', 'WFSTATUS', '审核状态', 2, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', 'PROJTYPE', '项目类别', 4, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', 'AMTMAX', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/query/index', 'AMTMIN', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');


--绩效抽评查询-左侧页签注册
delete from perf_t_treetab where key = '/pmkpi/randomcomment/query' and year = '2016';
insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/query', 'dept', '部门整体', 1, null, 2, '2016', '87', null, 'deptrandomquery');

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID)
values (sys_guid(), '/pmkpi/randomcomment/query', 'program', '项目支出', 1, null, 1, '2016', '87', null, 'programrandomquery');


--抽评对象确定选择项目-UI表注册
delete from busfw_t_uitable t where t.key = '/pmkpi/randomcomment/exisProj';
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', 'V_PERF_T_RANDOMCOMMENT_PROJ', 100, 1, 0, null, null, 'pmkpi', null,'2016','87');

--抽评对象确定选择项目(项目支出)-列注册
delete from busfw_t_uicolumn t where t.key in('/pmkpi/randomcomment/exisProj');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','YEAR','预算年份',4,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','FININTORGGUID','业务处室',4,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','BUDGETAMOUNT','全年预算数',5,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','EXECAMOUNT','全年执行数',6,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','GUID','主键ID',1,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','BUDGETGOALCREATOR','填报人',7,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','EXECRATE','预算执行率',7,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','AGENCYGUID','预算单位',3,1,0,0,0,0,NULL,NULL,'#code-#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','PROJTYPE','绩效类型',8,0,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','PROJNAME','项目名称',2,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','PROLEV','项目级次',2,1,0,0,0,0,NULL,NULL,'#name',NULL,0,NULL,1,'tree','{type:''program''}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','SELFSCORE','自评得分',9,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,PROVINCE, YEAR)
values (sys_guid(),'/pmkpi/randomcomment/exisProj','SELFRESULT','自评结论',10,1,0,0,0,0,NULL,NULL,NULL,NULL,0,NULL,0,'s','{}',NULL,87,2016);

--抽评对象确定选择项目-按钮注册
delete from busfw_t_uifunction t where t.key = '/pmkpi/randomcomment/exisProj';
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', '查询', 0, 1, 'searchicon', 'randomcommentproj.query', null, '查询', 'pmkpi', 'query', null, '{}','2016','87');
insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', '确定', 1, 2, 'searchicon', 'randomcommentproj.submit', null, '确定', 'pmkpi', 'audit', null, '{}','2016','87');

--抽评对象确定选择项目-查询区注册
delete from busfw_t_uiqueryform t where t.key = '/pmkpi/randomcomment/exisProj';
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', 'PROJNAME', '项目名称', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', 'WFSTATUS', '审核状态', 2, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', 'FININTORGGUID', '业务处室', 3, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', 'PROJTYPE', '项目类别', 4, 0, 'tree', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', 'AMTMAX', '全年预算数≥（万元）', 5, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, YEAR, PROVINCE)
values (sys_guid(), '/pmkpi/randomcomment/exisProj', 'AMTMIN', '全年预算数≤（万元）', 6, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_RANDOMCOMMENT_PROJ', '{}', null, null,'2016','87');
