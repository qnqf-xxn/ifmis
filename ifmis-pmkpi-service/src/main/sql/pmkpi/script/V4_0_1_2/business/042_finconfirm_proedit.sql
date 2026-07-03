begin
  
DELETE FROM p#Busfw_t_Uitabpage t where t.key='/pmkpi/evaluation/finconfirm/proedit';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3A0D06B92EBCAA7E053B11FA8C03BDD', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '评分表', 'score', 0, 3, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{url:''/pmkpi/evaluation/financial/deptfill/score.page''}', null, '0', 'scoreiframe', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53D3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '基本信息', 'info', 1, 1, 'choosed', 'tabfreamedit.clickTabpage', null, '基本信息', null, null, '{busguid:''BD2A3B90E5403AC1E053B11FA8C06F54''}', null, '0', 'infoeditform', null, null, null, null, null, null);

insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('BD2A3B90E53E3AC1E053B11FA8C06F54', 'pmkpi', '/pmkpi/evaluation/finconfirm/proedit', '附件管理', 'file', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''finevapro'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);


DELETE FROM p#Busfw_t_Uitabpage t where t.key='/pmkpi/evaluation/financial/result/edit' and t.code='score';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3DBD6A738125C96E053B11FA8C07BA0', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评分表', 'score', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{url:''/pmkpi/evaluation/financial/deptfill/score.page''}', null, '0', 'scoreiframe', null, null, null, null, null, null);
