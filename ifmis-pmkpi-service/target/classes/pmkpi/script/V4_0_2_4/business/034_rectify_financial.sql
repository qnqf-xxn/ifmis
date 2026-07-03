begin
delete from p#busfw_t_uitabpage where key ='/pmkpi/rectification/deptAdd';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378F3274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/deptAdd', '基本信息', 'proinfo', 1, 1, 'nomal', 'addprogram.clickTabpage', null, '基本信息', null, '保存,保存并送审', '{url:''/pmkpi/rectification/program/deptinfo.page?viewtype=query''}', null, '0', 'proinfoiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378F4274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/deptAdd', '整改通知附件', 'file', 1, 3, 'nomal', 'addprogram.clickTabpage', null, '整改通知附件', null, null, '{filebustype:''rectification'',url:''/pmkpi/rectification/file.page'',action:''reftifyfile.save''}', null, '0', 'manceiframe', null, null, null, null, null, null);

insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('D4D3D3E378F5274CE0533315A8C0ACDD', 'pmkpi', '/pmkpi/rectification/deptAdd', '整改通知详情', 'rectification', 1, 2, 'nomal', 'addprogram.clickTabpage', null, '整改通知详情', null, '保存,保存并送审', '{url:''/pmkpi/rectification/add/rectification.page''}', null, '0', 'rectifyiframe', null, null, null, null, null, null);
