begin 
-- 财政评价项目审核 项目支出 评分表显示
update p#busfw_t_uitabpage t set t.isvisiable = '1' where key='/pmkpi/evaluation/finconfirm/proedit' and t.componentid ='scoreiframe';
-- 财政评价项目审核 部门整体 附件表显示
update p#busfw_t_uitabpage t set t.isvisiable = '1' where key='/pmkpi/evaluation/finconfirm/deptedit' and t.componentid ='manceiframe';
-- 添加评分表页签
delete from busfw_t_uitabpage t where key in('pmkpi', '/pmkpi/evaluation/finconfirm/deptedit') and code = 'score';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C3A0D06B92EBCAA7E053B11FA8C11BDD', 'pmkpi', '/pmkpi/evaluation/finconfirm/deptedit', '评分表', 'score', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{url:''/pmkpi/evaluation/financial/deptfill/score.page''}', null, '0', 'scoreiframe', null, null, null, null, null, null);

-- 财政评价成果审核  项目支出 评分表显示
update p#busfw_t_uitabpage t set t.isvisiable = '1' where key='/pmkpi/evaluation/financial/result/edit' and t.componentid ='scoreiframe';
-- 财政评价成果审核  部门整体 附件表显示
update p#busfw_t_uitabpage t set t.isvisiable = '1' where key='/pmkpi/evaluation/financial/result/deptedit' and t.componentid ='manceiframe' and t.isvisiable ='0';
-- 添加评分表页签
delete from busfw_t_uitabpage t where key in('pmkpi', '/pmkpi/evaluation/financial/result/deptedit') and code = 'score';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('C0A0D06B92EBCAA7E053B11FA8C00BDD', 'pmkpi', '/pmkpi/evaluation/financial/result/deptedit', '评分表', 'score', 1, 2, 'nomal', 'tabfreamedit.clickTabpage', null, '评分表', null, null, '{url:''/pmkpi/evaluation/financial/deptfill/score.page''}', null, '0', 'scoreiframe', null, null, null, null, null, null);
