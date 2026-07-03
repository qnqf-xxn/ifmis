begin
  
--财政评价-预算部门自评中的评分表优化附件显示
delete from p#busfw_t_uicolumn where key = '/pmkpi/evaluation/financial/deptfill/score' and columncode = 'FILENAME';
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('BE17CC0278C60A0EE053B11FA8PPEB73', '/pmkpi/evaluation/financial/deptfill/score', 'FILENAME', '附件材料', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

update p#busfw_t_uicolumn t set t.name = '附件管理' where t.columncode = 'FILE' and key = '/pmkpi/evaluation/financial/deptfill/score';


--工作考核优化附件显示

delete from p#busfw_t_uicolumn where key = '/pmkpi/workevaluate/report/deptedit/score' and columncode = 'FILENAME';

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C34CD040E5A8F175E053B11FALP04705', '/pmkpi/workevaluate/report/deptedit/score', 'FILENAME', '附件材料', 7, 1, 0, 0, null, 0, 6, null, null, null, null, 150, 0, 's', null, null);

update p#busfw_t_uicolumn t set t.name = '附件管理' where t.columncode = 'FILE' and key = '/pmkpi/workevaluate/report/deptedit/score';
