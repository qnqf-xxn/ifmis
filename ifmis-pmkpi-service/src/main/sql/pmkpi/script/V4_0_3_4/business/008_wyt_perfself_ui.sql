begin
  --列表字段
delete from p#busfw_t_uicolumn where key ='/pmkpi/perfself/query' and columncode in ('PRO_TOTAL_AMT','BGTAMT');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'PRO_TOTAL_AMT', '项目总金额', 16, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{type:"program"}', null,  null, null);

insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL,  ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/query', 'BGTAMT', '当年预算金额', 17, 1, 0, 0, null, 0, 1, null, null, null, null, 100, 0, 's', '{type:"program"}', null,  null, null);


delete from p#busfw_t_uiqueryform where key ='/pmkpi/perfself/apply/index' and columncode in ('PRO_TOTAL_AMT','BGTAMT','COMPANY');
insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL, REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/index', 'COMPANY', '金额单位', 7, 1, 'tree', null, null, null, 'pmkpi', 'V_PERF_COMPANY', '{region:1,format:''#name'',multi:0}', null, null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/index', 'BGTAMT', '当年预算金额', 9, 1, 'i', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', '{region:1,unit:1,dotname:2,qfw:true}', null,  null, null, null);

insert into busfw_t_uiqueryform (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, TYPE, DEFAULTVALUE, LINKCHILD, LINKPARENT, APPID, TABLECODE, CONFIG, BOTTOMCONTRL,  REQUIREMENT, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/perfself/apply/index', 'PRO_TOTAL_AMT', '项目总金额', 8, 1, 'i', null, null, null, 'pmkpi', 'PERF_T_SELFEVALTASK', '{region:1,unit:1,dotname:2,qfw:true}', null,  null, null, null);

