BEGIN

delete from p#BUSFW_T_UIFUNCTION t where t.key in('/pmkpi/transfer/transferindex','/pmkpi/transfer/transfergoal') and code='copy';
insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/transfer/transfergoal', '复制总体目标', 0, 2, 'keepicon', 'transfergoal.copy', null, '复制总体目标', 'pmkpi', 'copy', '', '', '340000000', '2024', null, '');

insert into BUSFW_T_UIFUNCTION (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, PROVINCE, YEAR, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/transfer/transferindex', '复制总体指标', 0, 2, 'keepicon', 'transferindex.copy', null, '复制总体指标', 'pmkpi', 'copy', '', '', '340000000', '2024', null, '');

delete from p#BUSFW_T_UITABPAGE t where t.key in('/pmkpi/transfer/editperf') and t.code='file';
insert into BUSFW_T_UITABPAGE (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, PROVINCE, YEAR, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/transfer/editperf', '附件管理', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', '', '保存', '{filebustype:''transfer'',url:''/pmkpi/upload/file/index.page''}', '', '0', 'manceiframe', '', '', '', '', '', '340000000', '2024', '', null, '');

delete from perf_filetype t where bustype='transfer';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4699EC9E97E44772E063030011ACD56A', '001', '附件分类', '', '#', 1, 0, 1, 1, 'transfer', '', '', 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4699EC9E97E54772E063030011ACD56A', '001001', '结转前绩效附件(需上传结转前绩效目标表)', '', '4699EC9E97E44772E063030011ACD56A', 2, 1, 2, 1, 'transfer', '', '', 2016, '87');

insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('4699EC9E97E64772E063030011ACD56A', '001002', '结转后绩效附件(需上传结转后绩效目标表)', '', '4699EC9E97E44772E063030011ACD56A', 2, 1, 3, 1, 'transfer', '', '', 2016, '87');