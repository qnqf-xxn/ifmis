begin
--财政评价管理-财政评价成果上传-评价成果（改为新版）

--项目支出-finevaproresult
delete from p#busfw_t_uitabpage where key ='/pmkpi/evaluation/financial/result/edit' and name = '评价成果';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A43274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/result/edit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{filebustype:''finevaproresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);
--附件页配置
delete from perf_filetype where bustype = 'finevaproresult';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F1OP6P23PP8190CC3E053B11FA8C0BCC', '001', '项目申报附件', null, '#', 1, 0, 1, 1, 'finevaproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F1PP6P63P38P90CC3E053B11FA8C0BCC', '001001', '评价通知', null, 'F1OP6P23PP8190CC3E053B11FA8C0BCC', 2, 1, 2, 1, 'finevaproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F2PP6P63P38P90CC3E053B11FA8C0BCC', '001002', '评价方案', null, 'F1OP6P23PP8190CC3E053B11FA8C0BCC', 2, 1, 3, 1, 'finevaproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F3PP6P63P38P90CC3E053B11FA8C0BCC', '001003', '评价报告', null, 'F1OP6P23PP8190CC3E053B11FA8C0BCC', 2, 1, 4, 1, 'finevaproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F4PP6P63P38P90CC3E053B11FA8C0BCC', '001004', '其他材料', null, 'F1OP6P23PP8190CC3E053B11FA8C0BCC', 2, 1, 5, 1, 'finevaproresult', null, null, 2016, '87');

--部门整体-finevadeptproresult
delete from p#busfw_t_uitabpage where key ='/pmkpi/evaluation/financial/result/deptedit' and name = '评价成果';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E37A47274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/evaluation/financial/result/deptedit', '评价成果', 'file', 1, 4, 'nomal', 'tabfreamedit.clickTabpage', null, '评价成果', null, '保存', '{filebustype:''finevadeptproresult'',url:''/pmkpi/upload/file/index.page''}', null, '0', 'manceiframe', null, null, null, null, null, null);
--附件页配置
delete from perf_filetype where bustype = 'finevadeptproresult';
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F1OP6P23PP8190CC3E053B11FA8C0B1C', '001', '项目申报附件', null, '#', 1, 0, 1, 1, 'finevadeptproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F1PP6P63P38P90CC3E053B11FA8C0B1C', '001001', '评价通知', null, 'F1OP6P23PP8190CC3E053B11FA8C0B1C', 2, 1, 2, 1, 'finevadeptproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F2PP6P63P38P90CC3E053B11FA8C0B1C', '001002', '评价方案', null, 'F1OP6P23PP8190CC3E053B11FA8C0B1C', 2, 1, 3, 1, 'finevadeptproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F3PP6P63P38P90CC3E053B11FA8C0B1C', '001003', '评价报告', null, 'F1OP6P23PP8190CC3E053B11FA8C0B1C', 2, 1, 4, 1, 'finevadeptproresult', null, null, 2016, '87');
insert into perf_filetype (GUID, CODE, NAME, REMARK, SUPERID, LEVELNO, ISLEAF, ORDERNUM, STATUS, BUSTYPE, CREATETIME, UPDATETIME, YEAR, PROVINCE)
values ('F4PP6P63P38P90CC3E053B11FA8C0B1C', '001004', '其他材料', null, 'F1OP6P23PP8190CC3E053B11FA8C0B1C', 2, 1, 5, 1, 'finevadeptproresult', null, null, 2016, '87');
