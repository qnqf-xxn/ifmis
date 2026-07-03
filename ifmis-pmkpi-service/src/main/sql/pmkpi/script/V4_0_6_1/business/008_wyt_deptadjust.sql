begin
  --目标调整(部门) -- 广西部门职能概述页签
delete from p#busfw_t_uitabpage where key ='/pmkpi/adjust/report/deptedit' and componentid ='funciframe';
insert into busfw_t_uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), 'pmkpi', '/pmkpi/adjust/report/deptedit', '广西-部门职能活动', 'deptfun', 0, 11, 'nomal', 'tabfreamedit.clickTabpage', null, '部门职能活动', null, null, '{busguid:''12F7B8C868E54306A2FDE7CCC32726FC'',action:''deptfunc.save'',url:''/pmkpi/deptperformance/report/funcd.page?isadjust=1''}', null, '0', 'funciframe', null, null, null, null, null, null, null, null);

