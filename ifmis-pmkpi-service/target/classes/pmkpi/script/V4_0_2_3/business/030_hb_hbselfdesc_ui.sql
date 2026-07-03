begin

DELETE FROM p#Busfw_t_Uieditform t WHERE t.key='/pmkpi/perfself/apply/edit/hbselfdesc';
insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('286E9D780C42418AA9625649CD63E51E', '/pmkpi/perfself/apply/edit/hbselfdesc', 'V_PERF_SELFPERFDESC', 's', '主键ID', 'GUID', 0, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null);

insert into Busfw_t_Uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE)
values ('EE08C008791E4D3B992F0B78B4143465', '/pmkpi/perfself/apply/edit/hbselfdesc', 'V_PERF_SELFPERFDESC', 'textarea', '自评结论', 'VCOL6', 1, null, 1, null, 5, 3, '4', 'pmkpi', 1, null, '{}', null, null, null);


DELETE FROM p#Busfw_t_Uitabpage t WHERE t.key='/pmkpi/perfself/apply/edit' and t.code='hbselfdesc';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('DC24A773C66341BFBFF0E2D2754E5F56', 'pmkpi', '/pmkpi/perfself/apply/edit', '自评结论', 'hbselfdesc', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '自评结论(河北)', null, null, '{url:''/pmkpi/perfself/apply/edit/hbselfdesc.page'',action:''selfdesc.save''}', null, '0', 'hbdesciframe', null, null, null, null, null, null);


DELETE FROM p#Busfw_t_Uitabpage t WHERE t.key='/pmkpi/perfself/apply/dept/edit' and t.code='hbselfdesc';
insert into Busfw_t_Uitabpage (GUID, APPID, KEY, NAME, CODE, ISVISIABLE, ORDERNUM, CLASSNAME, CLICK, DISABLED, TITLE, FILTER, HIDEBTNS, CONFIG, WFSTATUS, WAITFLAG, COMPONENTID, COMPONENTCONFIG, COMPONENTKEY, COMPONENTDRAW, COMPONENTSERVICEID, COMPONENTCALLBACKFN, DEFAULTFILTER)
values ('7183429A47E04CC79A3E6D3E00D966F8', 'pmkpi', '/pmkpi/perfself/apply/dept/edit', '自评结论', 'hbselfdesc', 0, 5, 'nomal', 'tabfreamedit.clickTabpage', null, '自评结论(河北)', null, null, '{url:''/pmkpi/perfself/apply/edit/hbselfdesc.page'',action:''selfdesc.save''}', null, '0', 'hbdesciframe', null, null, null, null, null, null);

