begin

--¼à¿Ø·ÖÎöÒ³Ç©±à¼­Çø×Ö¶Î
delete from p#busfw_t_uieditform where key ='/pmkpi/program/trace/report/edit/analysis' and columncode in('BGTWARN','GOALWARN');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', 'Ô¤ËãÖ´ÐÐÔ¤¾¯', 'BGTWARN', 1, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/program/trace/report/edit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '¼¨Ð§Ä¿±êÍê³ÉÔ¤¾¯', 'GOALWARN', 1, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);


delete from p#busfw_t_uieditform where key ='/pmkpi/trace/report/deptedit/analysis' and columncode in('BGTWARN','GOALWARN');
insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', 'Ô¤ËãÖ´ÐÐÔ¤¾¯', 'BGTWARN', 1, null, 0, null, 0, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

insert into busfw_t_uieditform (GUID, KEY, TABLECODE, TYPE, NAME, COLUMNCODE, ISVISIABLE, SHOWLEVEL, REQUIREMENT, DEFAULTVALUE, ORDERNUM, COLSPANNUM, TEXTAREAROWS, APPID, ISEDIT, LEVELCONTROL, CONFIG, FROMSOURCE, BOTTOMCONTRL, SETVALUE, HEAD, ISEDITCTRL, EDITCTRLMSG)
values (sys_guid(), '/pmkpi/trace/report/deptedit/analysis', 'V_PERF_T_PROTRACEANALYSIS', 's', '¼¨Ð§Ä¿±êÍê³ÉÔ¤¾¯', 'GOALWARN', 1, null, 0, null, 1, null, null, 'pmkpi', 0, null, '{}', null, null, null, null, null, null);

