begin
  
delete from p#busfw_t_uifunction t where t.key ='/pmkpi/setting/kpisystemset' and t.code ='syncBdmData';

insert into busfw_t_uifunction (GUID, KEY, NAME, ISVISIABLE, ORDERNUM, CLASSNAME, ACTION, DISABLED, TITLE, APPID, CODE, PARAM, CONFIG, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/setting/kpisystemset', '同步预算数据', 0, 2, 'mod', 'kpisystemset.syncBdmData', null, '同步预算数据', 'pmkpi', 'syncBdmData', null, '{}', null, null);
