begin
delete from p#busfw_t_uicolumn where key in('/pmkpi/rectification/index');
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('C67A29A8DEF825099A993A954FAB70F2', '/pmkpi/rectification/index', 'AGENCYGUID', '预算单位', 3, 1, 0, 0, '0', 0, 1, null, '#code-#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('43C30730507A80BA8951D3FDCB75084C', '/pmkpi/rectification/index', 'CREATER', '填报人', 5, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('4BC2437E865515C9A5A5DFE22810C33C', '/pmkpi/rectification/index', 'FININTORGGUID', '业务处室', 4, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('D50DDEE9F21BC289B6AF26C06FA3F5B2', '/pmkpi/rectification/index', 'GUID', 'guid', 0, 0, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('F95B1E78550BBA0BCAB3261C12622460', '/pmkpi/rectification/index', 'PROJNAME', '项目名称', 1, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', '{ispro:1}', null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('0C0F702981887DEF3994631B81AD8542', '/pmkpi/rectification/index', 'WFSTATUS', '审核状态', 2, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('333F702981887DEF3994631B81AD8500', '/pmkpi/rectification/index', 'RECTYPE', '业务阶段', 6, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 'tree', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('222F702981887DEF3994631B81AD8511', '/pmkpi/rectification/index', 'TASKSTAGE', '任务阶段', 8, 1, 0, 0, '0', 0, 1, null, '#name', null, 0, null, 1, 's', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('444F702981887DEF3994631B81AD8522', '/pmkpi/rectification/index', 'CREATETIME', '更新时间', 9, 1, 0, 0, '0', 0, 1, null, 'yyyy-MM-dd hh:mm:ss', null, 0, null, 0, 'd', null, null);
insert into busfw_t_uicolumn (GUID, KEY, COLUMNCODE, NAME, ORDERNUM, ISVISIABLE, ISEDIT, TOTALTAG, SHOWLEVEL, REQUIREMENT, COLTYPE, HEAD, FORMAT, DEFAULTVALUE, LEVELCONTROL, COLWIDTH, ISSOURCE, TYPE, CONFIG, BOTTOMCONTRL)
values ('111F702981887DEF3994631B81AD8533', '/pmkpi/rectification/index', 'TASKNAME', '任务名称', 7, 1, 0, 0, '0', 0, 1, null, null, null, 0, null, 0, 's', null, null);


delete from p#busfw_t_uitable where key in('/pmkpi/rectification/index');
insert into busfw_t_uitable (GUID, KEY, TABLECODE, PAGENUM, TOTALTAG, LOCKNUM, ORDERBY, DEFQUERY, APPID, CONFIG)
values ('C01E4E4F958F8E89C88C952F2BEC3A76', '/pmkpi/rectification/index', 'V_PERF_T_RECTIFY', 20, 0, null, null, null, 'pmkpi', null);
