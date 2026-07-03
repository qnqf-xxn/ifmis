BEGIN

delete from p#busfw_t_uitable where key = '/pmkpi/perfself/random';


insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/random', 'PERF_V_SELFRANDOM', 100, 0, 0, null, null, 'pmkpi', '{}', '87', '2016');


delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/random';


insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', 'DEPT_CODE', '部门编码', 1, 1, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', 'DEPT_NAME', '部门名称', 2, 1, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', 'SELF_COUNT1', '自评项目个数', 3, 1, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', 'SELF_COUNT2', '应抽取项目个数', 4, 1, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', 'SELF_COUNT3', '已抽取项目个数', 5, 1, 0, 0, null, null, 1, null, null, null, null, null, 0, 's', null, null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', 'IS_SUE', '是否下发', 6, 1, 0, 0, null, null, 1, null, '#name', null, null, null, 1, 'tree', null, null, '87', '2016', null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/random';


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', '随机抽取', 1, 1, 'searchicon', 'selfrandom.random', null, '随机抽取', 'pmkpi', 'random', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', '人工选择/抽取', 1, 2, 'searchicon', 'selfrandom.personrandom', null, '人工选择/抽取', 'pmkpi', 'personrandom', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', '确认下发', 1, 3, 'searchicon', 'selfrandom.issue', null, '确认下发', 'pmkpi', 'issue', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', '取消下发', 1, 4, 'searchicon', 'selfrandom.issueoff', null, '取消下发', 'pmkpi', 'issueoff', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random', '查看项目范围', 1, 5, 'searchicon', 'selfrandom.viewpro', null, '查看项目范围', 'pmkpi', 'viewpro', null, '{}', '87', '2016', null, null);


delete from p#busfw_t_uitable where key = '/pmkpi/perfself/random/procheck';


insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG, PROVINCE, YEAR)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'V_PERF_T_SELFEVALTASK', 100, 1, 0, null, null, 'pmkpi', null, '87', '2016');



delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/random/procheck';


insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'EXTRACT_TYPE', '抽取类型', 10, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{lefttabtype:''alreadyaudit''}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'CODE', '项目编码', 1, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'NAME', '项目名称', 2, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 's', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'AGENCYGUID', '预算单位', 3, 1, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'DEPT_CODE', '主管部门', 4, 1, 0, null, null, null, 1, null, '#code-#name', null, null, null, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'FININTORGGUID', '业务科室', 5, 1, 0, null, null, null, 1, null, '#name', null, null, null, 1, 'tree', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'PRO_TOTAL_AMT', '项目总金额', 7, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 'amt', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'BGTAMT', '当年预算金额', 8, 1, 0, null, null, null, 1, null, null, null, null, null, 0, 'amt', '{}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'GUID', 'GUID', 9, 0, 0, null, null, null, 1, null, null, null, null, null, 0, 'amt', '{}', null, '87', '2016', null, null);


delete from p#busfw_t_uifunction where key = '/pmkpi/perfself/random/procheck' ;


insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', '取消纳入', 1, 1, 'searchicon', 'randomcheck.delrandom', null, '取消纳入', 'pmkpi', 'delrandom', null, '{}', '87', '2016', null, null);

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', '确认纳入', 1, 1, 'searchicon', 'randomcheck.addrandom', null, '确认纳入', 'pmkpi', 'addrandom', null, '{}', '87', '2016', null, null);


delete from p#busfw_t_uiqueryform where key = '/pmkpi/perfself/random/procheck' ;


insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'NAME', '项目名称', 2, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_SELFEVALTASK', '{}', null, '87', '2016', null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/random/procheck', 'CODE', '项目编码', 1, 1, 's', null, null, null, 'pmkpi', 'V_PERF_T_SELFEVALTASK', '{}', null, '87', '2016', null, null, null);


delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/random/procheck' ;


insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/random/procheck', '已抽取', 'alreadyaudit', 1, 2, 'nomal', 'randomcheck.clickTabpage', 0, '已抽取', 'is_extract = ''1''', '确认纳入', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/perfself/random/procheck', '未抽取', 'waitaudit', 1, 1, 'choosed', 'randomcheck.clickTabpage', 0, '未抽取', 'is_extract is null or is_extract = '''' or is_extract = ''2''', '取消纳入', '{}', null, '0', null, null, null, null, null, null, '87', '2016', null, null, null);



delete from perf_t_treetab where key = '/pmkpi/perfself/taskmanage' ;


insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'program', '项目支出', 1, '查看项目,标记重点,取消标记重点', 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselftaskmanagehide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'dept', '部门整体', 1, '查看项目', 3, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselftaskmanagehide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/taskmanage', 'transprogram', '转移支付', 0, '查看项目,标记重点,取消标记重点', 2, '2016', '87', 'AA453626C11A83A453494FB4E08F3C16', 'transprogramselftaskmanagehide', null);

delete from perf_t_treetab where key = '/pmkpi/perfself/apply' ;


insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply', 'program', '项目支出', 1, null, 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfapplyhide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply', 'dept', '部门整体', 1, '查看项目,查看可执行指标,查看资金来源', 3, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfapplyhide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/apply', 'transprogram', '转移支付', 0, null, 2, '2016', '87', 'AA453626C11A83A453494FB4E08F3C16', 'transprogramselfapplyhide', null);


delete from perf_t_treetab where key = '/pmkpi/perfself/audit' ;


insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/audit', 'program', '项目支出', 1, null, 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfaudithide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/audit', 'dept', '部门整体', 1, '查看项目,查看可执行指标,查看资金来源', 3, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfaudithide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/audit', 'transprogram', '转移支付', 0, null, 2, '2016', '87', 'AA453626C11A83A453494FB4E08F3C16', 'transprogramselfaudithide', null);


delete from perf_t_treetab where key = '/pmkpi/perfself/query' ;


insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/query', 'program', '项目支出', 1, '导出部门整体自评表', 1, '2016', '87', '97453626C11A83A453494FB4E08F3C16', 'programselfqueryhide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/query', 'dept', '部门整体', 1, '查看项目,导出项目自评表,查看可执行指标,查看资金来源', 3, '2016', '87', 'AB1C3F88E5BA9F021C1D2B249ADBDA27', 'deptselfqueryhide', null);

insert into perf_t_treetab (GUID, KEY, CODE, NAME, ISVISIABLE, HIDEBTNS, ORDERNUM, YEAR, PROVINCE, LEFTWFID, LEFTMENUID, CONFIG)
values (sys_guid(), '/pmkpi/perfself/query', 'transprogram', '转移支付', 0, '导出部门整体自评表', 2, '2016', '87', 'AA453626C11A83A453494FB4E08F3C16', 'transprogramselfqueryhide', null);



delete from p#busfw_t_uicolumn where key = '/pmkpi/perfself/query' and columncode in ('PROTYPE','IS_EXTRACT');


insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'IS_EXTRACT', '是否抽评', 28, 0, 0, 0, null, 0, 1, null, '#name', null, null, null, 1, 'tree', '{lefttabtype:"program"}', null, '87', '2016', null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'PROTYPE', '项目类型', 27, 0, 0, 0, null, 0, 1, null, '#name', null, null, null, 1, 'tree', '{lefttabtype:"program"}', null, '87', '2016', null, null);

delete from p#busfw_t_dcworkflowplan where code in( 'PERF_ZYZFSELFEVALTASK');

insert into busfw_t_dcworkflowplan (GUID, CODE, TABLECODE, NAME, STATUS, YEAR, PROVINCE, VERSION, DBVERSION, REMARK, CREATER, CREATETIME, TYPE, PARTITIONTYPE)
values ('AA453626C11A83A453494FB4E08F3C16', 'PERF_ZYZFSELFEVALTASK', 'V_PERF_T_SELFEVALTASK', '转移支付绩效自评流程', '1', '2016', '87', null, null, null, null, '20200826143402197', 'B876713347C31372A297A0234F30FFB8', '1');