
begin
update  p#busfw_t_uitabpage t set t.config = '{filebustype:''adjustreport'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/adjust/report/proedit' and name = '附件管理';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''adjustdeptreport'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/adjust/report/deptedit' and name = '附件管理';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''tracedeptreport'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/trace/report/deptedit' and name = '附件上传';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''traceproreport'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/program/trace/report/edit' and name = '附件上传';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''traceproreport'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/program/trace/report/ordinaryedit' and name = '附件上传';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''deptevapro'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/deptreport/proedit' and name = '附件管理';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''deptevapro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/dept/result/edit' and name = '项目附件';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''deptevaproresult'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/dept/result/edit' and name = '评价成果';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''finevapro'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/finconfirm/proedit' and name = '附件管理';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''finevadeptpro'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/finconfirm/deptedit' and name = '附件管理';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''finevapro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/financial/result/edit' and name = '项目附件';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''finevaproresult'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/financial/result/edit' and name = '评价成果';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''finevadeptpro'',url:''/pmkpi/upload/file/index.page'',viewtype:''query''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/financial/result/deptedit' and name = '项目附件';

update  p#busfw_t_uitabpage t set t.config = '{filebustype:''finevadeptproresult'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/evaluation/financial/result/deptedit' and name = '评价成果';


update  p#busfw_t_uitabpage t set t.config = '{filebustype:''reviewreport'',url:''/pmkpi/upload/file/index.page''}' where t.config like '%/pmkpi/file/index%' and t.key = '/pmkpi/review/report/proedit' and name = '附件管理';


delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply/edit' and name = '附件管理';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,DEFAULTFILTER)
values ('B9B1886CA78A00A1E003B11FA8C0DBA4', 'pmkpi', '/pmkpi/perfself/apply/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''perfselfapplyedit'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply/policy/edit' and name = '附件管理';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,DEFAULTFILTER)
values ('B9B1886CA78A00A1E003B11FA8C07BA4', 'pmkpi', '/pmkpi/perfself/apply/policy/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''perfselfapplypolicyedit'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

delete from p#busfw_t_uitabpage where key = '/pmkpi/perfself/apply/dept/edit' and name = '附件管理';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN,DEFAULTFILTER)
values ('B9B1886CA78A00A1E003B11FA1C07BA4', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '附件管理', 'file', 1, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '附件管理', null, '保存', '{filebustype:''perfselfapplydeptedit'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);

